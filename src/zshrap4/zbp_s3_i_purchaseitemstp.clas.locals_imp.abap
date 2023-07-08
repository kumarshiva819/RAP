CLASS lhc_purchaseitem DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS setPurchaseStatus FOR DETERMINE ON SAVE
      IMPORTING keys FOR PurchaseItem~setPurchaseStatus.

ENDCLASS.

CLASS lhc_purchaseitem IMPLEMENTATION.

  METHOD setPurchaseStatus.

   DATA:
     lv_tot_price TYPE p LENGTH 10 DECIMALS 2.

    READ ENTITIES OF ZS3_CO_OverallPOPriceTP IN LOCAL MODE
    ENTITY PurchaseItem
    ALL FIELDS WITH CORRESPONDING #(  keys )
    RESULT DATA(lt_po_items).

    LOOP AT lt_po_items INTO DATA(ls_po_item).
      lv_tot_price += (  ls_po_item-OrderQunt * ls_po_item-ProductPrice ).
    ENDLOOP.

    IF lv_tot_price > 1000.

      MODIFY ENTITIES OF ZS3_CO_OverallPOPriceTP IN LOCAL MODE
      ENTITY PurchaseOrder
      UPDATE FIELDS (  PurchaseStatus )
      WITH VALUE #(  FOR ls_keys IN keys
                     ( %key = CORRESPONDING #( ls_keys )
                        PurchaseStatus = '01 ')
                   )
       REPORTED DATA(lt_reported).

    ENDIF.

  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
