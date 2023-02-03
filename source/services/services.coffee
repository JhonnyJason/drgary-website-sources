import Modules from "./allmodules"
import domconnect from "./servicesdomconnect"
domconnect.initialize()

############################################################
global.allModules = Modules
global.onServicesPage = true

############################################################
appStartup = ->
    ## which modules shall be kickstarted?
    Modules.appcoremodule.startUp()
    
    scrollTo = sessionStorage.getItem("scrollTo")
    if scrollTo then Modules.smoothscrollmodule.chapterScroll(scrollTo)
    sessionStorage.setItem("scrollTo", "")
    return

############################################################
run = ->
    promises = (m.initialize() for n,m of Modules when m.initialize?) 
    await Promise.all(promises)
    appStartup()

############################################################
run()