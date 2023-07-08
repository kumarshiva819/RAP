@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Overall PO price'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZS3_CO_OverallPOPrice as select from ZS3_I_PurchaseHeader
{
  key PurchaseOrder,
  Description,
  @Semantics.amount.currencyCode: 'PriceUnit'
  sum(_PurchaseItems.ItemPrice) as PurchaseTotalPrice,
  _PurchaseItems.PriceUnit,
  OrderType,
  CompanyCode,
  PurchaseOrg,
  PurchaseStatus,
  Supplier,
  Plant,
  CreateBy,
  CreatedDateTime,
  ChangedDateTime,
  Imageurl,
  last_changed_at,
  /* Associations */
  _OrderType,
  _PurchaseItems,
  _Supplier,
  _PoStatus
}
group by
    PurchaseOrder,
    Description,
    OrderType,
    CompanyCode,
    PurchaseOrg,
    PurchaseStatus,
    Supplier,
    Plant,
    CreateBy,
    CreatedDateTime,
    ChangedDateTime,
    Imageurl,
    last_changed_at,
    _PurchaseItems.PriceUnit
    
