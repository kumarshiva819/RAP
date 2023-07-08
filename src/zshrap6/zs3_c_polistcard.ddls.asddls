@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'List card type Bar,Purchase Utilization'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZS3_C_PoListCard as select from ZS3_CO_OverallPOPriceTP
{
    key PurchaseOrder,
    Description,
    PurchaseTotalPrice,
    PriceUnit,
    PurchaseStatus,
    Priority,
    CreateBy,
    CreatedDateTime,
    cast( ( PurchaseTotalPrice * ( 100 / 50000 ) ) as abap.int2 ) as BudgetUsage
}
