@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'View for filter'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZS3_C_Purchase_OVP_Filter
  as select from ZS3_CO_OverallPOPriceTP
  association [1] to ZS3_C_PoStatus   as _PoStatus on $projection.PurchaseStatus = _PoStatus.Postatus
  association [1] to ZS3_I_PoPriority as _Prio     on $projection.Priority = _Prio.Priority
{
  key PurchaseOrder,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZS3_C_PoStatus', element: 'Postatus'} }]
      PurchaseStatus,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZS3_I_PoPriority' , element: 'Priority' } }]
      Priority,
      _PoStatus,
      _Prio
}
