############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("mailedformmodule")
#endregion

############################################################
import * as S from "./statemodule.js"
import { postData } from "thingy-network-base"

############################################################
formId = "CA4BD51AE638F911E8A68ED8C462D60FE6B1432C11311E21DEE4CC2595D81BA8"
formMailerURL = "https://form-mailer.dotv.ee"
# formMailerURL = "https://localhost:6999"

############################################################
submitPrepared = false
authCode = ""


############################################################
formIsSendable = ->
    formData = getFormData()
    # name
    if formData.name.trim() == "" then return false
    # email
    if formData.email.trim() == "" then return false    
    # message
    if formData.message.trim() == "" then return false
    return true

markMissingFormFields = ->
    formData = getFormData()
    # name
    if formData.name.trim() == ""
        nameInput = document.getElementById("name-input")
        nameInput.classList.add("missing")

    # email
    if formData.email.trim() == ""
        emailInput = document.getElementById("email-input")
        emailInput.classList.add("missing")
    
    # message
    if formData.message.trim() == ""
        messageTextarea = document.getElementById("message-textarea")
        messageTextarea.classList.add("missing")
    # scroll back top
    top = messageForm.offsetTop - 100
    $('body,html').animate({scrollTop: top}, 400)    
    return

removeMissingMarks = ->
    missing = Array.from(document.getElementsByClassName("missing"))
    
    for el in missing
        el.classList.remove("missing")
    return

sendFormData = (formData) ->
    url = formMailerURL+"/sendForm"
    # url = AppState.formMailerURL+"/sendForm"
    # authCode = AppState.authCode
    return postData(url, {authCode, formData})

retrieveAuthCode = ->
    url = formMailerURL+"/getAuthCode"
    # url = AppState.formMailerURL+"/getAuthCode"
    # formId = AppState.formId
    result = await postData(url, {formId})
    authCode = result.authCode
    return

prepareFormSubmit = ->
    return if submitPrepared
    # return if AppState.submitPrepared
    button = messageForm.getElementsByTagName("button")[0]

    handleSubmit = (evnt) ->
        evnt.preventDefault()
        removeMissingMarks()
        if formIsSendable() then sendForm()
        else markMissingFormFields()
        return

    button.addEventListener("click", handleSubmit)
    # AppState.submitPrepared = true
    submitPrepared = true
    return

getFormData = ->
    form = document.getElementById("message-form")
    data = Object.fromEntries(new FormData(form).entries())
    console.log(JSON.stringify(data, null, 4))
    return data

sendForm = ->
    setFormLoadingState()
    formData = getFormData()
    try 
        { ok, error } = await sendFormData(formData)
        if ok then setFormSuccessState()
        else setFormErrorState(error)
    catch err then setFormErrorState(err)
    return

############################################################
#region state setter functions
setFormActiveState = ->
    messageForm.setAttribute("disabled", "false")
    formFeedback.className = ""
    return

setFormSuccessState = ->
    messageForm.setAttribute("disabled", "true")
    formFeedback.className = "success"
    return

setFormLoadingState = ->
    messageForm.setAttribute("disabled", "true")
    formFeedback.className = "loading"
    return

setFormErrorState = (err) ->
    console.error(err)
    messageForm.setAttribute("disabled", "true")
    formFeedback.className = "error"
    retryButton = formFeedback.getElementsByTagName("button")[0]
    retryButton.addEventListener("click", prepareForm)        
    return

#endregion

############################################################
export prepareForm = ->
    try 
        setFormLoadingState()
        await retrieveAuthCode()
        prepareFormSubmit()
        setFormActiveState()
    catch err then setFormErrorState(err)    
    return
