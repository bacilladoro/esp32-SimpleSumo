-- Hardware configuration
motor = {
    right = pio.GPIO16,
    left = pio.GPIO17
}
edge = {
    right = pio.GPIO39,
    left = pio.GPIO35,
    back = pio.GPIO33
}
switch = {
    right = pio.GPIO18,
    left = pio.GPIO19
}
sonic = {
    echo = pio.GPIO5,
    trigger = pio.GPIO23
}
beeper = pio.GPIO22