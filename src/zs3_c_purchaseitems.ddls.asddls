@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Items'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
@Search.searchable: true
define view entity ZS3_C_PurchaseItems as select from ZS3_I_PurchaseItems
{
    key PurchaseOrder,
    key PurchaseItem,
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.7
  @Search.ranking: #HIGH
    ShortText,
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.7
  @Search.ranking: #MEDIUM
    Material,
    Plant,
    MaterialGroup,
    @Semantics.quantity.unitOfMeasure: 'OrderUnit'
    OrderQunt,
    OrderUnit,
    @Semantics.amount.currencyCode: 'PriceUnit'
    ItemPrice,
    @Semantics.amount.currencyCode: 'PriceUnit'
    ProductPrice,
    PriceUnit,
    LocalLastChangedBy,
    LocalLastChangedAt,
    /* Associations */
    _Currency,
    _PurchaseHeader
}
