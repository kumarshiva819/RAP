@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Items'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZS3_I_PurchaseItemsTP as select from ZS3_I_PurchaseItems
association to parent ZS3_CO_OverallPOPriceTP as _PurchaseHeader on $projection.PurchaseOrder = _PurchaseHeader.PurchaseOrder
{
    key PurchaseOrder,
    key PurchaseItem,
    ShortText,
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
