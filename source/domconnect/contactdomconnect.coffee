contactdomconnect = {name: "contactdomconnect"}

############################################################
contactdomconnect.initialize = () ->
    global.content = document.getElementById("content")
    global.callAppointmentButton = document.getElementById("call-appointment-button")
    global.messageAppointmentButton = document.getElementById("message-appointment-button")
    global.messageForm = document.getElementById("message-form")
    global.nameInput = document.getElementById("name-input")
    global.emailInput = document.getElementById("email-input")
    global.messageTextarea = document.getElementById("message-textarea")
    global.formFeedback = document.getElementById("form-feedback")
    global.headerTopSection = document.getElementById("header-top-section")
    global.headerMenuSection = document.getElementById("header-menu-section")
    global.headerMenu = document.getElementById("header-menu")
    global.menuLinkServices = document.getElementById("menu-link-services")
    global.menuLinkOrdination = document.getElementById("menu-link-ordination")
    global.menuLinkAboutme = document.getElementById("menu-link-aboutme")
    global.outerContentTable = document.getElementById("outer-content-table")
    global.contentTable = document.getElementById("content-table")
    return
    
module.exports = contactdomconnect