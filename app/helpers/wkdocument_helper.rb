module WkdocumentHelper

    def getDocuments
        url = getDocumentType
        tableName = Object.const_get(url[:container_type]).table_name
        @attachments = Attachment.joins("INNER JOIN #{tableName} ON #{tableName}.id = container_id AND container_type='#{url[:container_type]}'")
            .where("#{tableName}.id = ?", url[:container_id])
    end

    def getDocumentType
        url = {controller: 'wkdocument', action: 'new'}
        case(controller_name)
        when 'wkcrmaccount'
            url[:container_type] = 'WkAccount'
            url[:container_id] = params[:account_id]
        when 'wkopportunity'
            url[:container_type] = 'WkOpportunity'
            url[:container_id] = params[:opp_id]
        when 'wkcrmactivity'
            url[:container_type] = 'WkCrmActivity'
            url[:container_id] = params[:activity_id]
        when 'wkcrmcontact'
            url[:container_type] = 'WkCrmContact'
            url[:container_id] = params[:contact_id]
        end
        url
    end

    def getRedirectUrl(container_id, container_type)
        case(container_type)
        when 'WkAccount'
            url = {controller: 'wkcrmaccount', action: 'edit', account_id: container_id}
        when 'WkOpportunity'
            url = {controller: 'wkopportunity', action: 'edit', opp_id: container_id}
        when 'WkCrmActivity'
            url = {controller: 'wkcrmactivity', action: 'edit', activity_id: container_id}
        when 'WkCrmContact'
            url = {controller: 'wkcrmcontact', action: 'edit', contact_id: container_id}
        end
        url
    end
end