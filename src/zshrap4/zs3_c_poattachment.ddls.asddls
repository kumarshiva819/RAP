@EndUserText.label: 'Projection view for PO attachment'
@AccessControl.authorizationCheck: #NOT_REQUIRED

@UI.headerInfo: {
  typeName: 'Attachment',
  typeNamePlural: 'Attachment',
  
  title: { type: #STANDARD , value: 'Purchaseordernumber' },
  description: { type: #STANDARD , value: 'Purchaseordernumber'}
}

@UI.presentationVariant: [{ sortOrder: [{ by: 'Purchaseordernumber' , direction: #ASC }] , 
                            visualizations: [{ type: #AS_LINEITEM }]}]

define view entity ZS3_C_PoAttachment as projection on ZS3_I_PoAttachment
{
  @UI.facet: [ {
                  id:'GeneralInfo',
                  label: 'General Information',
                  type: #COLLECTION,
                  position: 10
                },
                
                {
                 id: 'POInfo',
                 purpose: #STANDARD,
                 label: 'Purchase Order',
                 type: #IDENTIFICATION_REFERENCE,
                 parentId: 'GeneralInfo',
                 position: 10
                },
                
                 {
                 id: 'Upload',
                 purpose: #STANDARD,
                 label: 'Upload attachment',
                 type: #FIELDGROUP_REFERENCE,
                 parentId: 'GeneralInfo',
                 position: 20,
                 targetQualifier: 'Upload'
                }               
             ]
    @UI.lineItem: [{ position: 10, label : 'Purchase Order', importance: #HIGH }]
    @UI.identification: [{ position: 10 , label: 'Purchase Order' }]
    key Purchaseordernumber,
    @UI.lineItem: [{ position: 20, label : 'Attachment ID', importance: #HIGH }]
    @UI.identification: [{ position: 20 , label: 'Attachment ID' }]
    key AttachId,
    @UI.lineItem: [{ position: 30, label : 'File', importance: #HIGH }]
    @UI.fieldGroup: [{ position: 10 , label: 'Attachment' , qualifier: 'Upload' } ]
    Attachment,
    @UI.hidden: true
    Mimetype,
    @UI.hidden: true
    Filename,
    @Semantics.systemDateTime.lastChangedAt: true
    LastChangedAt,
    /* Associations */
    _Header : redirected to parent ZS3_C_OverallPOPriceTP
}
