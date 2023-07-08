@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PO Attachment table'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZS3_I_PoAttachment as select from zs3_poattachment
association to parent ZS3_CO_OverallPOPriceTP as _Header on $projection.Purchaseordernumber = _Header.PurchaseOrder
{
    key purchaseordernumber as Purchaseordernumber,
    key attach_id           as AttachId,
    @Semantics.largeObject: {
       mimeType: 'Mimetype',
       fileName: 'Filename',
       contentDispositionPreference: #INLINE
    }
    attachment              as Attachment,
    @Semantics.mimeType: true
    mimetype                as Mimetype,
    filename                as Filename,
    @Semantics.systemDateTime.lastChangedAt: true
    last_changed_at         as LastChangedAt,
    
    _Header
}
