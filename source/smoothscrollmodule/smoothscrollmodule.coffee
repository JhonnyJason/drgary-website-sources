############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("smoothscrollmodule")
#endregion

############################################################
import *  as S from "./statemodule.js"
import *  as v from "./vanillautilmodule.js"
import *  as upButton from "./upbuttonmodule.js"
import *  as headerHandle from "./headermodule.js"

############################################################
headerHeight = 0
pageIsBig = false

############################################################
export initialize = ->
    log "initialize"
    pageIsBig = window.innerHeight < (document.documentElement.scrollHeight - 190)

    allChapterLinks = document.getElementsByClassName("chapter-link")
    allChapterLinks = [...allChapterLinks]
    addScrollEffect(link) for link in allChapterLinks
    
    getHeaderHeight() # needed?
    document.addEventListener("scroll", weScrolled)
    return

############################################################
addScrollEffect = (chapterLink)->
    log "addScrollEffect"
    chapterId = chapterLink.getAttribute("chapter-id")
    log chapterId
    return unless chapterId? and chapterId.length > 1
    return unless chapterId[0] == "#"
    log "chapterId was valid!"
    chapterId = chapterId.slice(1)

    chapterElement = document.getElementById(chapterId)
    
    if onServicesPage? 
        scrollPosition = chapterElement.offsetTop - 160 # + headerHeight?
        if screen.width < 950 then scrollPosition -= 140

        chapterLink.addEventListener("click", () -> v.scrollTo(scrollPosition))
    else
        pageSwitchScroll = (evnt) ->
            evnt.preventDefault()
            sessionStorage.setItem("scrollTo", chapterId)
            return

        chapterLink.addEventListener("click", pageSwitchScroll)

    return

############################################################
getHeaderHeight = ->
    main = document.getElementsByTagName("header")[0]
    headerHeight = main.offsetHeight
    return

############################################################
weScrolled = (evnt) ->
    offset = window.scrollY

    if offset > 50
        upButton.show()
        if pageIsBig then headerHandle.collapse()
    else 
        upButton.hide()
        if pageIsBig then headerHandle.expand()

    # TODO: check what does this do?
    if offset > 120 then headerHandle.onFarScroll()

    return        

############################################################
export immediateChapterScroll = (chapterId) ->
    log "immediateChapterScroll"
    chapterElement = document.getElementById(chapterId)
    scrollPosition = chapterElement.offsetTop - 120 # + headerHeight?
    v.scrollTo(scrollPosition)
    return