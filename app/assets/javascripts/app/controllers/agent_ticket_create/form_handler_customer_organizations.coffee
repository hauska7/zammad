class TicketCreateFormHanderCustomerOrganizations

  @run: (params, attribute, attributes, classname, form, ui) ->
    return if !attribute
    return if attribute.name isnt 'organization_id'

    customer = App.User.findNative(params.customer_id)
    return if !customer

    select = $(".select_organization")
    return if !select.length

    filter = (options, _type, params) ->
      # customer_id in params would be nice
      ticketMiddleForm = $(".ticket-form-middle")
      params = App.ControllerForm.params(ticketMiddleForm)
      customer = App.User.findNative(params.customer_id)
      return options if !customer

      primary_organization = App.Organization.findNative(customer.organization_id)
      alternative_organizations = customer.organizations
      all_organizations = []
      all_organizations.push primary_organization if primary_organization
      all_organizations = all_organizations.concat alternative_organizations if alternative_organizations

      result = []
      if customer
        for option in options
          organization = all_organizations.find (organization) -> (organization.id == option.id) or (organization.id == option.value)
          if organization
            result.push option
      else
        result = options
      
      result

    attribute.filter = filter

    new_select = ui.formGenItem(attribute, "Ticket", form, -1)

    select.replaceWith(new_select)

App.Config.set('CustomerOrganizations', TicketCreateFormHanderCustomerOrganizations, 'TicketCreateFormHandler')
