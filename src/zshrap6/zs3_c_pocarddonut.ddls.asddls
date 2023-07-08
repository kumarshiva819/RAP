@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Donut chart for purchase orders'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZS3_C_PoCardDonut
  as select from ZS3_CO_OverallPOPriceTP
{
  key PurchaseOrder,
      PurchaseStatus,
      _PoStat.Statusdesc as StatusDescription,
      Priority,
      _Prio.Description as PriorityDescription,
      @Aggregation.default: #SUM
      1 as SumofDocument

}
