-- Fetch hardware configuration
dofile("/hardware.lua")
dofile("/sumomoves.lua")
dofile("/functions.lua")
dofile("/tasks.lua")

edgeSensitivity = 1000
maximumRange = 30

hardwareAttached = event.create()
buttonPressed = event.create()
isRunning = true
movesQueue = {}
queueMtx = thread.createmutex()

-- Start the threads
thread.start(startUpTask)
thread.start(mainTask)
thread.start(stayInRingTask)
--thread.start(pursueTask)
--thread.start(attackTask)
thread.start(queueTask)

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
