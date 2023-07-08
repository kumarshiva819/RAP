@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PO Priority view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZS3_I_PoPriority
  as select from zs3_po_priority
{
@Search.defaultSearchElement: true
@Search.fuzzinessThreshold: 0.7
@Search.ranking: #HIGH
  key priority    as Priority,
@Search.defaultSearchElement: true
@Search.fuzzinessThreshold: 0.7
@Search.ranking: #MEDIUM
      description as Description
}
