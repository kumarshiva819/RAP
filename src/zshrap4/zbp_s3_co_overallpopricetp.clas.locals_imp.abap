CLASS lhc_ZS3_CO_OverallPOPriceTP DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR ZS3_CO_OverallPOPriceTP RESULT result.

    METHODS copy FOR MODIFY
      IMPORTING keys FOR ACTION purchaseorder~copy RESULT result.

    METHODS withdrawapproval FOR MODIFY
      IMPORTING keys FOR ACTION purchaseorder~withdrawapproval RESULT result.

    METHODS validatestatus FOR VALIDATE ON SAVE
      IMPORTING keys FOR purchaseorder~ValidateStatus.

    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE purchaseorder.

    METHODS earlynumbering_cba_poitems FOR NUMBERING
      IMPORTING entities FOR CREATE purchaseorder\_PoItems.

     METHODS earlynumbering_cba_poattch FOR NUMBERING
      IMPORTING entities FOR CREATE purchaseorder\_PoAttachment.

ENDCLASS.

CLASS lhc_ZS3_CO_OverallPOPriceTP IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD earlynumbering_create.

     SELECT MAX( PurchaseOrder )
           FROM ZS3_C_OverallPOPriceTP
           INTO @DATA(lv_po_max).

      data(lt_entities) = entities[].

       LOOP AT lt_entities INTO DATA(ls_entity).
         lv_po_max += 1.

         APPEND VALUE #( %cid = ls_entity-%cid
                         %is_draft = ls_entity-%is_draft
                         purchaseorder = |{ lv_po_max ALPHA = IN }| ) TO mapped-purchaseorder.


       ENDLOOP.

  ENDMETHOD.


  METHOD earlynumbering_cba_poitems.

      data(lt_entity_items) = entities.

      READ ENTITY IN LOCAL MODE ZS3_CO_OverallPOPriceTP
      BY \_PoItems
      ALL FIELDS WITH CORRESPONDING #( entities )
      RESULT DATA(lt_poitem_max).

      LOOP AT lt_entity_items INTO DATA(ls_entity_item_data).

*  Get the maximum item number for the Purchase Order

          SELECT MAX( PurchaseItem )
                 FROM @lt_poitem_max as lt_poitem_max
                 WHERE PurchaseOrder = @ls_entity_item_data-PurchaseOrder
                 INTO @DATA(lv_max).

              LOOP AT ls_entity_item_data-%target INTO DATA(ls_items).

                IF ls_entity_item_data-%is_draft = 01.
                 lv_max += 10.
                ELSE.
                 lv_max = ls_items-PurchaseItem.
                ENDIF.

                 ls_items-%key-PurchaseItem = |{ lv_max ALPHA = IN }|.

                 APPEND VALUE #( "%is_draft = ls_items-%is_draft
                                 %cid = ls_items-%cid
                                 %tky = ls_entity_item_data-%tky
                                 %key = ls_items-%key ) TO mapped-purchaseitem.
              ENDLOOP.

      ENDLOOP.

  ENDMETHOD.

  METHOD Copy.

      DATA: lt_keys TYPE TABLE FOR READ IMPORT ZS3_CO_OverallPOPriceTP.

       lt_keys = VALUE #( FOR ls_keys IN keys
*                          ( %key = ls_keys-%key
                           (  %tky = ls_keys-%tky
                            %control-Description = 01
                            %control-CompanyCode = 01
                            %control-PurchaseOrg = 01
                            %control-OrderType = 01
                            %control-PurchaseStatus = 01
                            %control-Supplier = 01 ) ).

* 1) Read the Purchase Order from the keys which is to be copied
        READ ENTITY IN LOCAL MODE ZS3_CO_OverallPOPriceTP
        FROM lt_keys
        RESULT DATA(lt_po_data).

* 2) Create a new entry from the Copied PO
        MODIFY ENTITIES OF ZS3_CO_OverallPOPriceTP IN LOCAL MODE
        ENTITY PurchaseOrder
        CREATE AUTO FILL CID
        FIELDS ( Description CompanyCode PurchaseOrg OrderType PurchaseStatus Supplier )
        WITH CORRESPONDING #( lt_po_data )
        MAPPED DATA(lt_mapped).

* 3) Retrieve the newly created PO
       READ ENTITIES OF ZS3_CO_OverallPOPriceTP IN LOCAL MODE
       ENTITY PurchaseOrder
       ALL FIELDS WITH CORRESPONDING #( lt_mapped-purchaseorder )
       RESULT DATA(lt_new_po).

* 4) Send back to UI
       result = VALUE #( FOR ls_new_po IN lt_new_po INDEX INTO lv_index
                         ( %key               = keys[ lv_index ]-%key
                           %cid_ref           = keys[ lv_index ]-%cid_ref
                           %param             = CORRESPONDING #( ls_new_po ) )
                       ).

  ENDMETHOD.

  METHOD WithdrawApproval.

     MODIFY ENTITIES OF ZS3_CO_OverallPOPriceTP IN LOCAL MODE
     ENTITY PurchaseOrder
     UPDATE FIELDS ( PurchaseStatus )
     WITH VALUE #(  FOR ls_key IN keys
                    (  %key = ls_key-%key
                       PurchaseStatus = '03'
                    )
                 )
     REPORTED DATA(lt_reported).

       READ ENTITIES OF ZS3_CO_OverallPOPriceTP IN LOCAL MODE
       ENTITY PurchaseOrder
       ALL FIELDS WITH CORRESPONDING #( keys )
       RESULT DATA(lt_changed_po).

     result = VALUE #( FOR ls_changed_po IN lt_changed_po
                         ( %tky               = ls_changed_po-%tky
                           %param             = CORRESPONDING #( ls_changed_po ) )
                       ).

  ENDMETHOD.

  METHOD ValidateStatus.

    DATA(lr_ref) = NEW cl_abap_behv(   ).

     READ ENTITIES OF ZS3_CO_OverallPOPriceTP IN LOCAL MODE
     ENTITY PurchaseOrder
     FIELDS (  PurchaseStatus )
     WITH CORRESPONDING #( keys )
     RESULT DATA(lt_new_po).

     LOOP AT lt_new_po INTO DATA(ls_new_po).

       CASE ls_new_po-PurchaseStatus.
        WHEN '01'.
        WHEN '02'.
        WHEN '03'.
        WHEN OTHERS.
          APPEND VALUE #( %key = ls_new_po-PurchaseOrder ) TO failed-purchaseorder.
          APPEND VALUE #( %key = ls_new_po-PurchaseOrder
                          %msg = lr_ref->new_message_with_text(  severity = if_abap_behv_message=>severity-error
                                                                 text     = 'Purchase Status is invalid'
                                                              )
                          %element-purchasestatus = if_abap_behv=>mk-on
                        ) TO reported-purchaseorder.
       ENDCASE.
     ENDLOOP.

  ENDMETHOD.


  METHOD earlynumbering_cba_poattch.

     DATA(lt_entities) = entities.

     READ ENTITY IN LOCAL MODE ZS3_CO_OverallPOPriceTP
     BY \_PoAttachment
     ALL FIELDS WITH CORRESPONDING #( entities )
     RESULT DATA(lt_attach).

     LOOP AT lt_entities INTO DATA(ls_entity).

       SELECT MAX( AttachId ) FROM @lt_attach as lt_atach
             WHERE Purchaseordernumber = @ls_entity-PurchaseOrder
             INTO @DATA(lv_max).

         LOOP AT ls_entity-%target INTO DATA(ls_item).
           IF ls_entity-%is_draft = 01.
             lv_max += 10.
           ELSE.
             lv_max = ls_item-AttachId.
           ENDIF.

            ls_item-AttachId = |{ lv_max ALPHA = IN }|.

           APPEND VALUE #(  %cid = ls_item-%cid
                            %tky = CORRESPONDING #( ls_entity-%tky )
                            %key = ls_item-%key      ) TO mapped-poattachment.
         ENDLOOP.

     ENDLOOP.


  ENDMETHOD.

ENDCLASS.
