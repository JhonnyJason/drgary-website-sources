import Modules from "./allmodules"
import domconnect from "./ordinationdomconnect"
domconnect.initialize()

############################################################
global.allModules = Modules
global.onOrdinationPage = true

############################################################
appStartup = ->
    ## which modules shall be kickstarted?
    Modules.appcoremodule.startUp()
    handleGMapConsent()
    return


#########################################################
# Handle Google Maps consent
#########################################################
handleGMapConsent = ->
    mapsIframe = '<iframe width="100%" height="100%" frameborder="0" style="border:0" src="https://www.google.com/maps/embed/v1/place?key=AIzaSyDvn9E6v2jQ7ETIc1s4Soj9iOE9NFrlnb0&q=place_id:Ei1HcmlsbHBhcnplcnN0cmHDn2UgNjIsIDgwMTAgR3Jheiwgw5ZzdGVycmVpY2g" allowfullscreen="" />'

    # consentBlock = document.getElementById("consent-block")
    # consentButton = document.getElementById("consent-button")
    # googleMapsFrame = document.getElementById("google-maps-frame")
    
    letMapInit  = -> googleMapsFrame.innerHTML = mapsIframe

    consentClicked = ->
        localStorage.setItem("google-consent", "true")
        consentBlock.style.display = "none"
        letMapInit()

    consent = localStorage.getItem("google-consent")
    if consent == "true" then letMapInit()
    else
        consentBlock.style.display = "block"
        consentButton.addEventListener("click", consentClicked)
    return

############################################################
run = ->
    promises = (m.initialize() for n,m of Modules when m.initialize?) 
    await Promise.all(promises)
    appStartup()

############################################################
run()