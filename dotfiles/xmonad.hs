import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import XMonad.Util.SpawnOnce

myStartupHook :: X ()
myStartupHook = do
    spawnOnce "picom"
    spawnOnce "feh --randomize --bg-fill ~/wallpapers/*"


main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ docks defaultConfig
        { layoutHook = avoidStruts $ layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
            { ppOutput = hPutStrLn xmproc
            , ppTitle = xmobarColor "green" "" . shorten 50
            }
        , modMask     = mod4Mask  -- Rebind mod to the windows key
        , terminal    = "alacritty"
        , startupHook = myStartupHook
        }
