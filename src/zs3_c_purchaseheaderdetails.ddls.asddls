@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Header details'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED}
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: ['PurchaseOrder']
@Search.searchable: true
define view entity ZS3_C_PurchaseHeaderDetails as select from ZS3_CO_OverallPOPrice
association [0..*] to ZS3_C_PurchaseItems as _PoItems  on $projection.PurchaseOrder  = _PoItems.PurchaseOrder
association [1]    to ZS3_C_PoStatus      as _PoStatus on $projection.PurchaseStatus = _PoStatus.Postatus
association [1]    to ZS3_C_OrderType     as _PoType   on $projection.OrderType      = _PoType.PoType
association [1]    to ZS3_C_Supplier      as _Suppl    on $projection.Supplier       = _Suppl.Supplierid
{
@ObjectModel.text.element: ['Description']
    key PurchaseOrder,
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.7
    @Search.ranking: #HIGH
    Description,
    PurchaseTotalPrice,
    PriceUnit,
    OrderType,
    CompanyCode,
    PurchaseOrg,
    @Consumption.valueHelpDefinition: [{ entity: { name: 'ZS3_C_PoStatus' , element: 'Postatus' } }]
    @ObjectModel.text.element: ['Statusdesc']
    PurchaseStatus,
    _PoStatus.Statusdesc as Statusdesc,
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.7
    @Search.ranking: #MEDIUM
    @Consumption.valueHelpDefinition: [{ entity: { name: 'ZS3_C_Supplier' , element: 'Supplierid' } }]
    @ObjectModel.text.element: ['SupplierName']
    Supplier,
    _Supplier.SupplierName as SupplierName,
    case 
      when PurchaseStatus = '01'  then 2
      when PurchaseStatus = '02'  then 3
      when PurchaseStatus = '03'  then 1
      else 0
    end as Criticalityvalue,
    
    Plant,
    CreateBy,
    CreatedDateTime,
    ChangedDateTime,
    @Semantics.imageUrl: true
    Imageurl,
    /* Associations */
    _OrderType,
    _PurchaseItems,
    _Supplier,
    
    _PoItems,
    _PoStatus,
    _PoType,
    _Suppl
}
