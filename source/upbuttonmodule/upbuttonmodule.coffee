############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("upbuttonmodule")
#endregion

############################################################
import { scrollTo } from "./vanillautilmodule.js"

############################################################
export initialize = ->
    log "initialize"
    upbutton.addEventListener("click", upbuttonClicked)
    return

############################################################
upbuttonClicked = ->
    scrollTo(0)
    return

############################################################
export show = ->
    log "show"
    upbutton.classList.add("shown")
    return

export hide = ->
    log "hide"
    upbutton.classList.remove("shown")
    return
