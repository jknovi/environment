import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import XMonad.Util.SpawnOnce
import XMonad.Layout.IndependentScreens

myStartupHook :: X ()
myStartupHook = do
    { screens <- countScreens
    ; case screens of
       1 -> do
         spawn "xrandr --output eDP-1 --primary --scale .75x.75"
       3 -> do
         spawn "xrandr --output eDP-1 --left-of DP-4 --scale .75x.75 --output DP-4  --primary --left-of DP-3"
       _ -> return ()
    ; spawnOnce "picom"
    ; spawnOnce "feh --randomize --bg-fill ~/wallpapers/*"
    }


main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ docks def
        { layoutHook = avoidStruts $ layoutHook def
        , logHook = dynamicLogWithPP xmobarPP
            { ppOutput = hPutStrLn xmproc
            , ppTitle = xmobarColor "green" "" . shorten 50
            }
        , terminal    = "alacritty"
        , startupHook = myStartupHook
        }
