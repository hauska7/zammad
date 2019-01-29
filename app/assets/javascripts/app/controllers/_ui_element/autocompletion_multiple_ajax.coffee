class App.UiElement.autocompletion_multiple_ajax
  @render: (attribute, params = {}) ->
    if params[attribute.name]?.length > 0 || attribute.value?.length > 0
      object = App[attribute.relation].find(params[attribute.name][0] || attribute.value[0])
      valueName = object.displayName()

    value = App["Organization"].all().map (organization) -> organization.id

    # selectable search
    searchableAjaxSelectObject = new App.SearchableMultipleSelect(
      attribute:
        value:       params[attribute.name] || value
        valueName:   valueName
        name:        attribute.name
        id:          value
        placeholder: App.i18n.translateInline('Search...')
        limit:       40
        object:      attribute.relation
        ajax:        true
    )
    searchableAjaxSelectObject.element()
