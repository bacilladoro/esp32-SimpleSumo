-- Fetch hardware configuration
dofile("/hardware.lua")
dofile("/functions.lua")

edgeSensitivity = 1000
maximumRange = 30

hardwareAttached = event.create()
buttonPressed = event.create()


-- Startup
thread.start(function()
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
        end
    end
end)

-- Main action
thread.start(function()
    buttonPressed:wait()
    buttonPressed:done()
    local stuckCounter = 0

    print("Starting action")
    while true do
        local edgeSensed, buttonSensed, ultraSensed, r, l, b, b1, b2, d = checkSensors()
        if edgeSensed then
            stayInRing(r,l,b)
        elseif buttonSensed then
            attack(b1,b2)
        elseif ultraSensed then
            beep(100)
            persue()
            stuckCounter = stuckCounter + 1
            if stuckCounter > math.random(20,40) then
                if math.random(1,2) < 2 then
                    moveBackwardRight()
                else
                    moveBackwardLeft()
                end
                tmr.delayms(math.random(50,500))
                moveRandom()
                tmr.delayms(math.random(1,100))
                stuckCounter = 0 
            end
        else
            search()
        end
    end
end)

-- Front switches
pio.pin.setdir(pio.INPUT,switch.left,switch.right)
pio.pin.setpull(pio.PULLUP,switch.left,switch.right)

-- Beeper
pio.pin.setdir(pio.OUTPUT,beeper)

-- Setup servos
servoLeft  = servo.attach(motor.left)
servoRight = servo.attach(motor.right)

-- Setup edge detection
edgeLeft  = adc.attach(adc.ADC1,edge.left)
edgeRight = adc.attach(adc.ADC1,edge.right)
edgeBack  = adc.attach(adc.ADC1,edge.back)

-- Setup sonic sensor
sonicSensor = sensor.attach("US015",sonic.trigger, sonic.echo)
sonicSensor:set("temperature",20)

hardwareAttached:broadcast()