
CLASS lcl_buffer_class DEFINITION.

  PUBLIC SECTION.

    CLASS-DATA: mt_po_data TYPE zif_s3_po_types=>mt_po_header,
                mt_po_item TYPE zif_s3_po_types=>mt_po_item.
ENDCLASS.

CLASS lcl_buffer_class IMPLEMENTATION.
ENDCLASS.



CLASS lhc_ZS3_CO_OVERALLPOPRICETP_U DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zs3_co_overallpopricetp_u RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE zs3_co_overallpopricetp_u.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zs3_co_overallpopricetp_u.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zs3_co_overallpopricetp_u.

    METHODS read FOR READ
      IMPORTING keys FOR READ zs3_co_overallpopricetp_u RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zs3_co_overallpopricetp_u.

    METHODS rba_Poitems FOR READ
      IMPORTING keys_rba FOR READ zs3_co_overallpopricetp_u\_Poitems FULL result_requested RESULT result LINK association_links.

    METHODS cba_Poitems FOR MODIFY
      IMPORTING entities_cba FOR CREATE zs3_co_overallpopricetp_u\_Poitems.

ENDCLASS.

CLASS lhc_ZS3_CO_OVERALLPOPRICETP_U IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create.

    lcl_buffer_class=>mt_po_data = CORRESPONDING #(  entities MAPPING FROM ENTITY ).

    mapped-purchaseorders = VALUE #(  FOR ls_entity IN entities
                                     ( %cid = ls_entity-%cid
                                       %key = ls_entity-%key
                                     )
                                   ).

  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD rba_Poitems.
  ENDMETHOD.

  METHOD cba_Poitems.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZS3_I_PURCHASEITEMSTP_U DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zs3_i_purchaseitemstp_u.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zs3_i_purchaseitemstp_u.

    METHODS read FOR READ
      IMPORTING keys FOR READ zs3_i_purchaseitemstp_u RESULT result.

    METHODS rba_Purchaseheader FOR READ
      IMPORTING keys_rba FOR READ zs3_i_purchaseitemstp_u\_Purchaseheader FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_ZS3_I_PURCHASEITEMSTP_U IMPLEMENTATION.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD rba_Purchaseheader.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZS3_CO_OVERALLPOPRICETP_U DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZS3_CO_OVERALLPOPRICETP_U IMPLEMENTATION.

  METHOD finalize.

  ENDMETHOD.

  METHOD check_before_save.

  ENDMETHOD.

  METHOD save.

    IF lcl_buffer_class=>mt_po_data IS NOT INITIAL.

      CALL FUNCTION 'Z_S3_FM_UPD_PO'
        EXPORTING
          im_po_header = lcl_buffer_class=>mt_po_data.
    ENDIF.


    IF lcl_buffer_class=>mt_po_item IS NOT INITIAL.

      CALL FUNCTION 'Z_S3_FM_UPD_PO'
        EXPORTING
          im_po_items = lcl_buffer_class=>mt_po_item.
    ENDIF.

  ENDMETHOD.

  METHOD cleanup.

  ENDMETHOD.

  METHOD cleanup_finalize.

  ENDMETHOD.

ENDCLASS.
