$ = require 'jquery'

module.exports =

##*
# Manages the items in the status bar.
##
class StatusBarManager
    ###*
     * The label to show.
    ###
    label: null

    ###*
     * The label HTML element.
    ###
    labelElement: null

    ###*
     * The progress bar HTML element.
    ###
    progressBar: null

    ###*
     * The root HTML element of the progress bar.
    ###
    element: null

    ###*
     * The tile that is located in the status bar.
    ###
    tile: null

    ###*
     * Initializes the progress bar, setting up its DOM structure.
     *
     * @param {mixed} statusBarService
    ###
    initialize: (statusBarService) ->
        @labelElement = document.createElement("span")
        @labelElement.className = ""
        @labelElement.innerHTML = @label

        @progressBar = document.createElement("progress")

        @element = document.createElement("div")
        @element.className = "php-integrator-progress-bar"
        @element.appendChild(@progressBar)
        @element.appendChild(@labelElement)

        @tile = statusBarService.addRightTile(item: @element, priority: 999999)

    ###*
     * Cleans up and removes all elements.
    ###
    destroy: () ->
        @tile.destroy()

    ###*
     * Sets the text to show in the label.
     *
     * @param {string} label
    ###
    setLabel: (@label) ->
        @labelElement.innerHTML = @label
        @labelElement.className = ''

    ###*
     * Sets the progress value for the progress bar (between 0 and 100).
     *
     * @param {int|null} progress The progress (between 0 and 100) or null for an indeterminate status.
    ###
    setProgress: (progress) ->
        if progress != null
            @progressBar.value = Math.max(Math.min(progress, 100), 0)
            @progressBar.max = 100

        else
            @progressBar.removeAttribute('value')
            @progressBar.removeAttribute('max')

    ###*
     * Shows the element.
    ###
    show: ->
        $(@element).show()
        $(@progressBar).show()

    ###*
     * Hides the element.
    ###
    hide: ->
        $(@element).hide()

    ###*
     * Shows only the label.
    ###
    showLabelOnly: ->
        $(@element).show()
        $(@progressBar).hide()

    ###*
     * Shows the specified message in the status area.
     *
     * @param {string} label
     * @param {string} className
    ###
    showMessage: (label, className = '') ->
        @setLabel(label)
        @labelElement.className = className
        @showLabelOnly()

    ###*
     * Attaches to the specified element or using the specified object.
     *
     * @param {mixed} object
    ###
    attach: (object) ->
        throw new Error("This method is absract and must be implemented!")

    ###*
     * Detaches from the previously attached element.
    ###
    detach: ->
        throw new Error("This method is absract and must be implemented!")
