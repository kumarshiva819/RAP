@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Supplier'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZS3_C_Supplier as select from ZS3_I_Supplier
{
@Search.defaultSearchElement: true
@Search.fuzzinessThreshold: 0.7
@Search.ranking: #HIGH
@ObjectModel.text.element: ['SupplierName']
    key Supplierid,
@Search.defaultSearchElement: true
@Search.fuzzinessThreshold: 0.7
@Search.ranking: #MEDIUM
@Semantics.text: true
@Semantics.name.fullName: true
    SupplierName,
@Semantics.eMail.type: [#WORK]
    @EndUserText.label: 'Email'
    EmailAddress,
@Semantics.telephone.type: [#WORK]
    @EndUserText.label: 'Phone Number'
    PhoneNumber,
@Semantics.telephone.type: [#FAX]
    @EndUserText.label: 'Fax Number'
    FaxNumber,
    WebAddress
}
