import Modules from "./allmodules"
import domconnect from "./ordinationdomconnect"
domconnect.initialize()

############################################################
import PhotoSwipeLightbox from 'photoswipe/lightbox';
import PhotoSwipe from 'photoswipe';

############################################################
global.allModules = Modules
global.onOrdinationPage = true

############################################################
appStartup = ->
    Modules.appcoremodule.startUp()

    lightbox = new PhotoSwipeLightbox({
        gallery: '#imageGallery',
        children: 'a',
        pswpModule: PhotoSwipe,
        bgOpacity: 0.7,
        errorMsg: 'Bild konnte nicht geladen werden.'
    });
    lightbox.init()
    return

############################################################
run = ->
    promises = (m.initialize() for n,m of Modules when m.initialize?) 
    await Promise.all(promises)
    appStartup()

############################################################
run()