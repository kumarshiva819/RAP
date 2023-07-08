@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Supplier data'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZS3_I_Supplier as select from zs3_supplier_db
{
    key supplierid as Supplierid,
    supplier_name  as SupplierName,
    email_address  as EmailAddress,
    phone_number   as PhoneNumber,
    fax_number     as FaxNumber,
    web_address    as WebAddress
}
