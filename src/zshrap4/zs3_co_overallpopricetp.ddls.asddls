@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Header Details'
define root view entity ZS3_CO_OverallPOPriceTP as select from ZS3_CO_OverallPOPrice
composition[*] of ZS3_I_PurchaseItemsTP as _PoItems
composition[*] of ZS3_I_PoAttachment as _PoAttachment
association [1] to ZS3_C_Supplier as _Supp on $projection.Supplier = _Supp.Supplierid
association [1] to ZS3_C_PoStatus as _PoStat on $projection.PurchaseStatus = _PoStat.Postatus
association [1] to ZS3_I_PoPriority as _Prio on $projection.Priority = _Prio.Priority
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
    case 
      when PurchaseTotalPrice < 500 then '03'
      when PurchaseTotalPrice > 500 and PurchaseTotalPrice < 1000 then '02'
      when PurchaseTotalPrice > 1000 then '01'
      else '00' 
    end as Priority,
    /* Associations */
    _OrderType,
    _PoStatus,
    _PurchaseItems,
    _Supplier,
    _PoItems, // Make association public
    _Supp,
    _PoStat,
    _PoAttachment,
    _Prio
}
