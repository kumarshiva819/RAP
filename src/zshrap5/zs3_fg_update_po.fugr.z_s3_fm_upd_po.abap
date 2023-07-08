function Z_S3_FM_UPD_PO.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IM_PO_HEADER) TYPE  ZIF_S3_PO_TYPES=>MT_PO_HEADER
*"     REFERENCE(IM_PO_ITEMS) TYPE  ZIF_S3_PO_TYPES=>MT_PO_ITEM
*"       OPTIONAL
*"----------------------------------------------------------------------
    if IM_PO_HEADER IS NOT INITIAL.
      MODIFY zs3_poheader_db FROM TABLE @im_po_header.
    endif.

    if IM_PO_items IS NOT INITIAL.
      MODIFY zs3_poitem_db FROM TABLE @im_po_items.
    endif.

ENDFUNCTION.
