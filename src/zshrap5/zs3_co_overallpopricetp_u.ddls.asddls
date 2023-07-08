@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Header Details'
define root view entity ZS3_CO_OVERALLPOPRICETP_U as select from ZS3_CO_OverallPOPrice
composition[*] of ZS3_I_PURCHASEITEMSTP_U as _PoItems
association [1] to ZS3_C_Supplier as _Supp on $projection.Supplier = _Supp.Supplierid
association [1] to ZS3_C_PoStatus as _PoStat on $projection.PurchaseStatus = _PoStat.Postatus
{
    key PurchaseOrder,
    Description,
    PurchaseTotalPrice,
    PriceUnit,
    OrderType,
    CompanyCode,
    PurchaseOrg,
    PurchaseStatus,
    case PurchaseStatus
     when '01' then 2
     when '02' then 3
     when '03' then 1
     else 0
     end as CriticaValue,
    Supplier,
    Plant,
    @Semantics.user.createdBy: true
    CreateBy,
    @Semantics.systemDateTime.createdAt: true
    CreatedDateTime,
    @Semantics.systemDateTime.localInstanceLastChangedAt: true
    ChangedDateTime,
    @Semantics.systemDateTime.lastChangedAt: true
    last_changed_at,
    Imageurl,
    /* Associations */
    _OrderType,
    _PoStatus,
    _PurchaseItems,
    _Supplier,
    _PoItems, // Make association public
    _Supp,
    _PoStat
}
