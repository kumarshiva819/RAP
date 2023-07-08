@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PO Status'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZS3_C_PoStatus as select from ZS3_I_POStatus
{
@Search.defaultSearchElement: true
@Search.fuzzinessThreshold: 0.7
@Search.ranking: #HIGH
@EndUserText.label: 'Status'
@ObjectModel.text.element: ['Statusdesc']
    key Postatus,
@Search.defaultSearchElement: true
@Search.fuzzinessThreshold: 0.7
@Search.ranking: #MEDIUM
@EndUserText.label: 'Status Description'
       Statusdesc
}
