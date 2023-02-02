servicesdomconnect = {name: "servicesdomconnect"}

############################################################
servicesdomconnect.initialize = () ->
    global.headerTopSection = document.getElementById("header-top-section")
    global.headerMenuSection = document.getElementById("header-menu-section")
    global.headerMenu = document.getElementById("header-menu")
    global.menuLinkServices = document.getElementById("menu-link-services")
    global.menuLinkOrdination = document.getElementById("menu-link-ordination")
    global.menuLinkAboutme = document.getElementById("menu-link-aboutme")
    global.outerContentTable = document.getElementById("outer-content-table")
    global.contentTable = document.getElementById("content-table")
    return
    
module.exports = servicesdomconnect