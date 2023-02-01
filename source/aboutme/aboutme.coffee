import Modules from "./allmodules"
import domconnect from "./aboutmedomconnect"
domconnect.initialize()

############################################################
global.allModules = Modules
global.onAboutmePage = true

############################################################
appStartup = ->
    ## which modules shall be kickstarted?
    Modules.appcoremodule.startUp()
    return

############################################################
run = ->
    promises = (m.initialize() for n,m of Modules when m.initialize?) 
    await Promise.all(promises)
    appStartup()

############################################################
run()