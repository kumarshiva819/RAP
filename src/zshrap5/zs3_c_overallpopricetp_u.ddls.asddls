@EndUserText.label: 'Projection view for PO header'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: ['PurchaseOrder']
@Search.searchable: true
define root view entity ZS3_C_OVERALLPOPRICETP_U 
provider contract transactional_query
as projection on ZS3_CO_OVERALLPOPRICETP_U

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
  @UI.hidden: true
    CriticaValue,
    Supplier,
    _Supplier.SupplierName,
    Plant,
    CreateBy,
    CreatedDateTime,
    ChangedDateTime,
    last_changed_at,
  @Semantics.imageUrl: true
    Imageurl,
    /* Associations */
    _OrderType,
    _PoItems : redirected to composition child ZS3_C_PURCHASEITEMSTP_U,
    _PoStat,
    _PoStatus,
    _PurchaseItems,
    _Supp,
    _Supplier
}
