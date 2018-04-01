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

-- Read the sensors
function checkSensors()
    local b1, b2 = pio.pin.getval(switch.left, switch.right)
    local rb,b = edgeBack:read()
    local rr,r = edgeRight:read()
    local rl,l = edgeLeft:read()
    local d = sonicSensor:read("distance")

    local edgeSensed = (b > edgeSensitivity) or (r > edgeSensitivity) or (l > edgeSensitivity)
    local ultraSensed = (d < maximumRange)
    local buttonSensed = (b1 == 0 or b2 == 0)
    return edgeSensed, buttonSensed, ultraSensed, r, l, b, b1, b2, d
end


function stayInRing(rightEdgeState, leftEdgeState, backEdgeState)
    if rightEdgeState > edgeSensitivity and leftEdgeState > edgeSensitivity then
        print("Both front sensors triggered")
        moveBackward()
        tmr.delayms(math.random(300,700))
        rotateRight()
        tmr.delayms(math.random(10,550))
    elseif rightEdgeState > edgeSensitivity then
        print("Right sensor triggered")
        moveBackwardRight()
        tmr.delayms(math.random(300,700))
        rotateLeft()
        tmr.delayms(math.random(10,550))
    elseif leftEdgeState > edgeSensitivity then
        print("Left sensor triggered")
        moveBackwardLeft()
        tmr.delayms(math.random(300,700))    
        rotateRight()
        tmr.delayms(math.random(10,550))
    end
    if backEdgeState > edgeSensitivity then
        print("Back sensor triggered")
        moveForwardFast()
        tmr.delayms(1000)
    end
end

function persue()
    print("Starting persue")
    moveForwardFast()
    tmr.delayms(100)
end

function attack(rightButtonState, leftButtonState)
    if rightButtonState == 0 and leftButtonState == 0 then
        print("Both front buttons triggered")
        moveForwardFast()
        tmr.delayms(100)
    elseif leftButtonState == 0 then
        print("Left button triggered")
        pivotLeft()
        tmr.delayms(100)
    elseif rightButtonState == 0 then
        print("Right button triggered")
        pivotRight()
        tmr.delayms(100)        
    end
end

function search()
    print("Searching")
    if math.random(1,100) > 5 then
        if math.random(1,100) < 50 then
            pivotRight()
        else
            pivotLeft()
        end
        tmr.delayms(50)
        moveForwardSlow()
        tmr.delayms(50)
    else
        moveRandom()
        tmr.delay(math.random(20,70))
    end
end

function pivotLeft()
    servoLeft:write(90+15)
    servoRight:write(90-70)
end

function pivotRight()
    servoLeft:write(90+70)
    servoRight:write(90-15)
end

function rotateRight()
    servoLeft:write(90+25)
    servoRight:write(90+25)
end

function rotateLeft()
    servoLeft:write(90-25)
    servoRight:write(90-25)
end

function sitStill()
    servoLeft:write(90)
    servoRight:write(90)
end

function moveBackward()
    servoLeft:write(90-25)
    servoRight:write(90+25)
end

function moveBackwardLeft()
    servoLeft:write(90-20)
    servoRight:write(90+45)
end

function moveBackwardRight()
    servoLeft:write(90-45)
    servoRight:write(90+20)
end

function moveForwardSlow()
    servoLeft:write(90+15)
    servoRight:write(90-15)
end

function moveForwardFast()
    servoLeft:write(180)
    servoRight:write(0)
end

function moveRandom()
    servoLeft:write(math.random(0,180))
    servoRight:write(math.random(0,180))
end