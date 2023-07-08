@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Header details'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define view entity ZS3_I_PurchaseHeader as select from zs3_poheader_db
association [0..*] to ZS3_I_PurchaseItems as _PurchaseItems on $projection.PurchaseOrder  = _PurchaseItems.PurchaseOrder
association [1]    to ZS3_I_OrderType     as _OrderType     on $projection.OrderType      = _OrderType.PoType
association [1]    to ZS3_I_Supplier      as _Supplier      on $projection.Supplier       = _Supplier.Supplierid
association [1]    to ZS3_I_POStatus      as _PoStatus      on $projection.PurchaseStatus = _PoStatus.Postatus
{
    key po_order      as PurchaseOrder,
    po_desc           as Description,
    po_type           as OrderType,
    comp_code         as CompanyCode,
    po_org            as PurchaseOrg,
    po_status         as PurchaseStatus,
    supplier          as Supplier,
    plant             as Plant,
    create_by         as CreateBy,
    created_date_time as CreatedDateTime,
    changed_date_time as ChangedDateTime,
    imageurl          as Imageurl,
    last_changed_at,
    
    _PurchaseItems,
    _OrderType,
    _Supplier,
    _PoStatus
}
