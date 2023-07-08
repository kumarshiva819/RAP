@EndUserText.label: 'Projection view for the child'
@AccessControl.authorizationCheck: #NOT_REQUIRED

@UI.headerInfo: {
  typeName: 'PurchaseItem',
  typeNamePlural: 'Purchase Items',
  
  title.value: 'ShortText',
  description: {
                  label: 'Manage Purchase Orders',
                  type: #STANDARD,
                  value: 'PurchaseItem'
               }
}
@Search.searchable: true
define view entity ZS3_C_PurchaseItemsTP 
as projection on ZS3_I_PurchaseItemsTP

{

   @UI.facet: [{
                 id:'ItemData',
                 type: #IDENTIFICATION_REFERENCE,
                 label: 'Item Info',
                 position: 10,
                 purpose: #STANDARD
                   }]
    
    @UI.lineItem: [{ position: 10 , label: 'Purchase Order' }]
    key PurchaseOrder,
    @ObjectModel.text.element: ['ShortText']
    @UI.lineItem: [{ position: 20 , label: 'Purchase Order Item' }]
    key PurchaseItem,
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.7
    @Search.ranking: #HIGH
    @UI.lineItem: [{ position: 30 , label: 'Item Description' }]
    @UI.identification: [{ position: 10 , label: 'Item Description' }]
    ShortText,
    @UI.lineItem: [{ position: 40 , label: 'Material' }]
    @UI.identification: [{ position: 20 , label: 'Material' }]
    Material,
    Plant,
    @UI.lineItem: [{ position: 50 , label: 'Material Group' }]
    @UI.identification: [{ position: 30 , label: 'Material Group' }]
    MaterialGroup,
    @UI.lineItem: [{ position: 60 , label: 'Order Quantity' }]
    @UI.identification: [{ position: 40 , label: 'Order Quantity' }]
    OrderQunt,
    @UI.lineItem: [{ position: 70 , label: 'Order Unit' }]
    @UI.identification: [{ position: 50 , label: 'Order Unit' }]
    OrderUnit,
    ItemPrice,
    @UI.lineItem: [{ position: 70 , label: 'Item Price' }]
    @UI.identification: [{ position: 60 , label: 'Item Price' }]
    ProductPrice,
    @UI.lineItem: [{ position: 80 , label: 'Price Unit' }]
    @UI.identification: [{ position: 70 , label: 'Price Unit' }]
    PriceUnit,
    LocalLastChangedBy,
    LocalLastChangedAt,
    /* Associations */
    _Currency,
    _PurchaseHeader : redirected to parent ZS3_C_OverallPOPriceTP
}
