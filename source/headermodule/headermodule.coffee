############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("headermodule")
#endregion

############################################################
import * as S from "./statemodule.js"

############################################################
export initialize = ->
    log "initialize"
    headerMenu.addEventListener("click", headerMenuClicked)

    contentTable.addEventListener("mouseleave", mouseLeftTable)
    menuLinkServices.addEventListener("mouseenter", mouseEnteredServices)
    menuLinkServices.addEventListener("mouseleave", mouseLeftServices)

    if onServicePage?
        menuLinkServices.addEventListener("click", servicesClicked)
        outerContentTable.classList.remove("closed")

    return

############################################################
headerMenuClicked = ->
    log "headerMenuClicked"
    if S.get("letCollapse")
        headerMenu.classList.add("collapsed")
        S.set("letCollapse", false )         
    else
        headerMenu.classList.remove("collapsed") 
    return

servicesClicked = (event) ->
    # log "servicesClicked"
    if S.get("serviceLinkClicked")
        S.set("serviceLinkClicked", false)
        closeOuterContentTable()
    else 
        S.set("serviceLinkClicked", true)
        openOuterContentTable()
    log screen.width 
    
    if screen.width < 950
        S.set("letCollapse", true)
    return

mouseEnteredServices = ->
    S.set("serviceLinkHovered", true)
    openOuterContentTable()
    return

mouseLeftServices = (event) ->
    log "mouseLeftServices"
    return if S.get("serviceLinkClicked")
    coordinates = 
        x: event.pageX
        y: event.pageY
    if !leftBottom(event.target, coordinates)
        S.set("serviceLinkHovered", false)
        closeOuterContentTable()        
    return
    
mouseLeftTable = (event) ->
    log "mouseLeftTable"
    S.set("serviceLinkHovered", false)
    return if S.get("serviceLinkClicked")
    closeOuterContentTable()
    return

############################################################
leftBottom = (element, coordinates) ->
    # log "leftBottom"
    # log coordinates
    boundingRect = element.getBoundingClientRect()
    elementBottomY = boundingRect.bottom
    # log elementBottomY
    return true if elementBottomY < coordinates.y
    return false

closeOuterContentTable = ->
    return if S.get("shouldClose")
    outerContentTable.classList.add("closed")
    S.set("shouldClose", true)
    setTimeout(hideServiceMenu, 700)
    return
        
openOuterContentTable = ->
    S.set("shouldClose", false)
    outerContentTable.style.zIndex = "998"
    outerContentTable.classList.remove("closed")
    return

hideServiceMenu = ->
    if S.get("shouldClose")
        outerContentTable.style.zIndex = "-1"
        S.set("shouldClose", false) 
    return

############################################################
export expand = ->
    headerMenuSection.classList.remove("fixed")
    headerMenu.classList.remove("collapsed")
    outerContentTable.classList.remove("fixed") if outerContentTable
    return

export collapse = ->
    headerMenuSection.classList.add("fixed") 
    headerMenu.classList.add("collapsed")
    outerContentTable.classList.add("fixed") if outerContentTable
    return

############################################################
export onFarScroll = ->
    if outerContentTable
        S.set("serviceLinkClicked", false)
        S.set("serviceLinkHovered", false)
        closeOuterContentTable()
    return