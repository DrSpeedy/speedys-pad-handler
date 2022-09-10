# Speedy's Pad Handler
Discord: DrSpeedy#1852
Github: https://github.com/DrSpeedy/speedys-pad-handler

# Functions:
```
 * <void> StartPadHandler()
 * <void> StopPadHandler()
 * <bool> CheckInput(cmd_str)
```
# Opcodes
```
T: Tap
H: Held Down (Delayed)
D: Down
U: Up
R: Just Released
F: Function

T, H Both can take a numeric argument with the following
syntax: [T2], [H4]; If no arugment is supplied, the arg will
default to 1. This argument is the number of taps needed to meet
the input condition
```

# Examples:
```lua
CheckInput('[D]VK(48):[T2]RB')
```
True when VK48 - Zero is held down and RB is tapped twice
on the controller

```lua
CheckInput('[D]VK(48):[F]SEQ(RB,LB,X)')
```
True when VK48 - Zero is held down and RB, LB, X are pressed
in sequence on the controller

# More Examples:
```lua
function SomeFunc()
    -- If LB is pressed twice and held on the 2nd press
    if (CheckInput('[H2]LB')) then
        do_something()
    end

    -- If LB is pressed twice and released on 2nd press
    if (CheckInput('[T2]LB')) then
        do_something()
    end

    -- If LT is just held down and then X is tapped once and released
    if (CheckInput('[D]LT:[T]X')) then
        do_something()
    end
end
```