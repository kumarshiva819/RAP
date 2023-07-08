CLASS zcl_bo_test_s3 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_bo_test_s3 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


    MODIFY ENTITY ZS3_C_OverallPOPriceTP " Root Entity
    CREATE BY \_PoItems  " items
    FIELDS ( Material Plant MaterialGroup ProductPrice )
    WITH VALUE #(
                  (
                     PurchaseOrder = '0000001011'
                     %target  = VALUE #(
                                         (  %cid = 'CID_ITEM-1'
*                                            PurchaseItem = '0010'
                                            Material = 'IPHONE_15'
                                            Plant  = '1010'
                                            MaterialGroup = '002'
                                            ProductPrice = 110
                                         )

                                         (  %cid = 'CID_ITEM-2'
*                                            PurchaseItem = '0020'
                                            Material = 'IPHONE_16'
                                            Plant  = '1020'
                                            MaterialGroup = '002'
                                            ProductPrice = 140
                                         )

                                        )
                  )
                 )

      FAILED data(lt_failed)
      MAPPED data(lt_mapped)
      REPORTED data(lt_reported).

      COMMIT ENTITIES.

  ENDMETHOD.
ENDCLASS.
