############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("appcoremodule")
#endregion

############################################################
#region Page Loader Functions
loadIndexPage = ->
	window.location.href = "/"

loadAboutmePage = () ->
	window.location.href = "/aboutme.html"

loadOrdinationPage = () ->
	window.location.href = "/ordination.html"

loadServicesPage = () ->
	window.location.href = "/services.html"

loadContactPage = () ->
	window.location.href = "/contact.html"

#endregion

############################################################
export startUp = ->
    log "startUp"
    if headerTopSection and !onIndexPage?
        headerTopSection.addEventListener("click", loadIndexPage)

    if menuLinkServices and !onServicesPage?
        menuLinkServices.addEventListener("click", loadServicesPage)
        contentTable.addEventListener("click", loadServicesPage)
    if menuLinkServices and onServicesPage?
        menuLinkServices.classList.add("home")
        
    if menuLinkOrdination and !onOrdinationPage?
        menuLinkOrdination.addEventListener("click", loadOrdinationPage)
    if menuLinkOrdination and onOrdinationPage?
        menuLinkOrdination.classList.add("home")

    if menuLinkAboutme and !onAboutmePage?
        menuLinkAboutme.addEventListener("click", loadAboutmePage)
    if menuLinkAboutme and onAboutmePage?
        menuLinkAboutme.classList.add("home")

    contactLinks = document.getElementsByClassName("contact-link")
    contactLinks = [...contactLinks]
    for link in contactLinks
        link.addEventListener("click", loadContactPage)
    
    return
