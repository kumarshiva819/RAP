INTERFACE zif_s3_po_types
  PUBLIC.

    TYPES: mt_po_header TYPE STANDARD TABLE OF zs3_poheader_db WITH DEFAULT KEY,
           mt_po_item   TYPE STANDARD TABLE OF zs3_poitem_db WITH DEFAULT KEY.

ENDINTERFACE.
