import Modules from "./allmodules"
import domconnect from "./contactdomconnect"
domconnect.initialize()

############################################################
global.allModules = Modules
global.onContactPage = true

############################################################
appStartup = ->
    callAppointmentButton.addEventListener("click", () -> window.open("tel:+4366488188728"))
    messageAppointmentButton.addEventListener("click", () ->  window.open("mailto:termin@drgary.at"))

    ## which modules shall be kickstarted?
    Modules.appcoremodule.startUp()
    Modules.mailedformmodule.prepareForm()
    return

############################################################
run = ->
    promises = (m.initialize() for n,m of Modules when m.initialize?) 
    await Promise.all(promises)
    appStartup()

############################################################
run()