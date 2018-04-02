function beep(d)
    pio.pin.sethigh(beeper)
    tmr.delayms(d)
    pio.pin.setlow(beeper)   
end

-- This pauses the robot for 5 seconds (5000 milliseconds) after it is turned on, per competition requirements. Then it beeps the 5 sec countdown
function countdown()
    beep(50)
    tmr.delayms(995)
    beep(50);
    tmr.delayms(995)
    beep(50);
    tmr.delayms(995)
    beep(50);
    tmr.delayms(995)
    beep(150);
    tmr.delayms(995)
end

function pushMoves(prio, moves)
    local newMove
    if moves then
        queueMtx:lock()
        if movesQueue[1].priority > prio then
            movesQueue = {}
        end
        while #moves > 0 do
            newMove = table.remove(moves,1)
            print("1> Inserting [left]="..newMove.left.." [right]="..newMove.right)
            table.insert(movesQueue,{priority=prio,move=newMove})
        end
        queueMtx:unlock()
    else
        print("ERROR Received empty move")
    end
end

