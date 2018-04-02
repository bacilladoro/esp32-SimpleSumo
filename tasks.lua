-- Startup
startUpTask = function()
    hardwareAttached:wait()
    hardwareAttached:done()

    beep(100)

    print("Waiting for button press")

    local wait = true
    while wait do 
        local s1,s2 = pio.pin.getval(switch.left, switch.right)
        if(s1 == 0 or s2 == 0) then
            print("Button has been pressed")
            countdown()
            buttonPressed:broadcast()
            wait = false
            isRunning = true
        end
    end
end


-- Stay in Ring thread
stayInRingTask = function()
    buttonPressed:wait() -- Wait until are Go

    local l,r,b,rl,rr,rb
    print("Starting Stay in Ring")
    while isRunning do
        -- Check edge sensors
        rb,b = edgeBack:read()
        rr,r = edgeRight:read()
        rl,l = edgeLeft:read()
        if l > edgeSensitivity and r > edgeSensitivity then
            print("-- Both Front edge")
            pushMoves(1,sumomoves.stayinring.both)
        elseif l > edgeSensitivity then
            print("-- Left Front edge")
            pushMoves(1,sumomoves.stayinring.left)
        elseif r > edgeSensitivity then
            print("-- Right Front edge")
            pushMoves(1,sumomoves.stayinring.right)
        end
        if b > edgeSensitivity then
            print("-- Back edge")
            pushMoves(0,sumomoves.stayinring.back)
        end
        thread.sleepms(50)
    end
    print("Finished Stay in Ring")
end

-- Attack Thread
attackTask = function()
    buttonPressed:wait() -- Wait until are Go

    local lb,rb

    print("Starting Attack")
    while isRunning do
        lb,rb = pio.pin.getval(switch.left, switch.right)
        if lb == 0 and rb == 0 then
            print("-- Both buttons")
            pushMoves(2,sumomoves.attack.both)
        elseif lb == 0 then
            print("-- Left button")
            pushMoves(2,sumomoves.attack.left)
        elseif rb == 0 then
            print("-- Right button")
            pushMoves(2,sumomoves.attack.right)
        end
        thread.sleepms(100)
    end
    print("Finished Attack")
end

-- Pursue Thread
pursueTask = function()
    buttonPressed:wait() -- Wait until are Go

    local d

    print("Starting Persue")
    while isRunning do
        d = sonicSensor:read("distance")
        if d < maximumRange then
            print("-- Found something")
            pushMoves(3,sumomoves.persue)
            beep(50)
        end
        thread.sleepms(1000)
    end
    print("Finished Persue")
end

-- Queue processing thread
queueTask = function()
    buttonPressed:wait() -- Wait until we are Go
    local currentMove = nil
    local endtime = 0
    local currentPriority = 9

    print("Starting Queue processing")
    while isRunning do
        queueMtx:lock()
        if #movesQueue > 0 then
            -- We start a new move when 
            -- - there is no current move
            -- - the time for previous move has passed
            -- - a higher priority move has been pushed
            if not currentMove or os.clock() > endtime or movesQueue[1].priority < currentPriority then
                currentMove = table.remove(movesQueue,1)
                queueMtx:unlock()
                currentPriority = currentMove.priority
                if type(currentMove.move.duration) == "number" then
                    endtime = os.clock() + (currentMove.move.duration / 1000)
                else
                    endtime = os.clock() + (math.random(currentMove.move.duration.min,currentMove.move.duration.max) / 1000)
                end
                print(">> Processing Move [left]="..currentMove.move.left.." [right]="..currentMove.move.right.." [duration]="..endtime-os.clock())
                servoLeft:write(currentMove.move.left)
                servoRight:write(currentMove.move.right)
                
            end
        else
            queueMtx:unlock()
        end
        thread.sleepms(100)
    end
    print("Finished Queue processing")
end

-- Main action
mainTask = function()
    buttonPressed:wait()
    buttonPressed:done()
    local stuckCounter = 0

    print("Starting action")
    while isRunning do
        if #movesQueue == 0 then -- We have nothing to do so we start the search
            print("Pushing search moves")
            if math.random(1,100) < 50 then
                pushMoves(4,sumomoves.search.left)
            else
                pushMoves(4,sumomoves.search.right)
            end
        end
        thread.sleepms(100)       
    end
end
