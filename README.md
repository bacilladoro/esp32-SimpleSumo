# esp32-SimpleSumo
Battle program for Simple Sumobot using ESP32 running RTOS-Lua based on the work of https://github.com/mechengineermike

# Hardware
The SimpleSumo bot has 9 hardware interfaces
- 3 IR sensors for edge detection
- 2 Continuous rotation servos
- 2 buttons for collision detection
- 1 Ultrasonic sensor for enemy detection
- 1 Beeper to give audio feedback

The connections to the ESP32 board are as follows

Device            | GPIO pin         | Comment
----------------- | ---------------- | --------
Servo 1           | GPIO16           | Right Wheel
Servo 2           | GPIO17           | Left Wheel
IR Sensor 1       | GPIO39           | Right Edge
IR Sensor 2       | GPIO35           | Left Edge
IR Sensor 3       | GPIO33           | Back Edge
Button 1          | GPIO18           | Right button
Button 2          | GPIO19           | Left button
Ultrasonic Sensor | GPIO5            | Echo
Ultrasonic Sensor | GPIO23           | Trigger 
Buzzer            | GPIO 22          |

