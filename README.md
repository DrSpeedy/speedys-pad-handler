Speedy's Pad Handler
Discord: DrSpeedy#1852
Github: https://github.com/DrSpeedy/speedys-pad-handler

Functions:
```
 * <void> StartPadHandler()
 * <void> StopPadHandler()
 * <bool> PadMultiTapHold(<any> key_index, <int> taps)
 * <bool> PadSingleTapHold(<any> key_index)
 * <bool> PadMultiTap(<any> key_index, <int> taps)
 * <bool> PadSingleTap(<any> key_index)
 ```

`key_index: index to the keys = {} global, taps: number of taps -1 a button needs to be pressed`

Features:
 Background thread to manage button press/release events
 * Single/Multi tap and hold on last
 * Single/Multi tap and release on last
 * Set max tick delay in between button presses

Examples:
```lua
function SomeFunc()
    -- If LB is pressed twice and held on the 2nd press
    if (PadMultiTapHold('LB', 1)) then
        do_something()
    end

    -- If LB is pressed twice and released on 2nd press
    if (PadMultiTap('LB', 1)) then
        do_something()
    end

    -- If LT is pressed once and not released and then X is tapped once and released
    if (PadSingleTapHold('LT') and PadSingleTap('X')) then
        do_something()
    end
end
```