@EndUserText.label: 'Projection view for root view'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: ['PurchaseOrder']
@Search.searchable: true

define root view entity ZS3_C_OverallPOPriceTP
provider contract transactional_query
as projection on ZS3_CO_OverallPOPriceTP
{
@ObjectModel.text.element: ['Description']
    key PurchaseOrder,
 @Search.defaultSearchElement: true
 @Search.fuzzinessThreshold: 0.7
 @Search.ranking: #HIGH
    Description,
    @Semantics.amount.currencyCode: 'PriceUnit'
    PurchaseTotalPrice,
    @UI.hidden: true
    PriceUnit,
  @Consumption.valueHelpDefinition: [{ entity: { name: 'ZS3_C_OrderType' , element: 'PoType' } }]
    OrderType,
    CompanyCode,
    PurchaseOrg,
  @Consumption.valueHelpDefinition: [{ entity : { name: 'ZS3_C_PoStatus' , element: 'Postatus' } }]
  @ObjectModel.text.element: ['Statusdesc']
    PurchaseStatus,
    _PoStatus.Statusdesc,
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.7
  @Search.ranking: #MEDIUM
  @Consumption.valueHelpDefinition: [{ entity : { name: 'ZS3_C_Supplier' , element: 'Supplierid' } }]
  @ObjectModel.text.element: ['SupplierName']
  @Consumption.filter.multipleSelections: false
    Supplier,
    _Supplier.SupplierName,
    Plant,
    CreateBy,
    CreatedDateTime,
    ChangedDateTime,
    @Semantics.imageUrl: true
    Imageurl,
    last_changed_at,
    @UI.hidden: true
    CriticaValue,
    /* Associations */
    _OrderType,
    _PoItems : redirected to composition child ZS3_C_PurchaseItemsTP,
    _PoAttachment : redirected to composition child ZS3_C_PoAttachment,
    _PoStatus,
    _PurchaseItems,
    _Supp,
    _Supplier
}
