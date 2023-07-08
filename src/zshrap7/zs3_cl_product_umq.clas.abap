CLASS zs3_cl_product_umq DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_rap_query_provider .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zs3_cl_product_umq IMPLEMENTATION.


  METHOD if_rap_query_provider~select.


    DATA:
      lt_business_data TYPE TABLE OF zzs3sepmra_i_product_e,
      lo_http_client   TYPE REF TO if_web_http_client,
      lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
      lo_request       TYPE REF TO /iwbep/if_cp_request_read_list,
      lo_response      TYPE REF TO /iwbep/if_cp_response_read_lst.

DATA:
* lo_filter_factory   TYPE REF TO /iwbep/if_cp_filter_factory,
* lo_filter_node_1    TYPE REF TO /iwbep/if_cp_filter_node,
* lo_filter_node_2    TYPE REF TO /iwbep/if_cp_filter_node,
 lo_filter_node_root TYPE REF TO /iwbep/if_cp_filter_node.
* lt_range_PRODUCT TYPE RANGE OF <element_name>,
* lt_range_PRODUCTTYPE TYPE RANGE OF <element_name>.



    TRY.
        " Create http client
DATA(lo_destination) = cl_http_destination_provider=>create_by_url(
                                  i_url = 'https://sapes5.sapdevcenter.com' ).

    lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination )   .

        ASSERT lo_http_client IS BOUND.
        " If you like to use IF_HTTP_CLIENT you must use the following factory: /IWBEP/CL_CP_CLIENT_PROXY_FACT
        lo_client_proxy = cl_web_odata_client_factory=>create_v2_remote_proxy(
          EXPORTING
            iv_service_definition_name = 'ZS3_PRODUCTS'
            io_http_client             = lo_http_client
            iv_relative_service_root   = '/sap/opu/odata/sap/ZPDCDS_SRV/' ).


        " Navigate to the resource and create a request for the read operation
        lo_request = lo_client_proxy->create_resource_for_entity_set( 'SEPMRA_I_PRODUCT_E' )->create_request_for_read( ).

        " Create the filter tree
*lo_filter_factory = lo_request->create_filter_factory( ).
*
*lo_filter_node_1  = lo_filter_factory->create_by_range( iv_property_path     = 'PRODUCT'
*                                                        it_range             = lt_range_PRODUCT ).
*lo_filter_node_2  = lo_filter_factory->create_by_range( iv_property_path     = 'PRODUCTTYPE'
*                                                        it_range             = lt_range_PRODUCTTYPE ).

*lo_filter_node_root = lo_filter_node_1->and( lo_filter_node_2 ).
*lo_request->set_filter( lo_filter_node_root ).

        io_request->get_paging( RECEIVING ro_paging = DATA(ls_paging) ).
        lo_request->set_top( ls_paging->get_page_size(  ) )->set_skip( ls_paging->get_offset(  ) ).

        DATA(lt_product_range) = io_request->get_filter(  )->get_as_ranges(  ).
        DATA(lo_filter_factory) = lo_request->create_filter_factory(  ).

        LOOP AT lt_product_range ASSIGNING FIELD-SYMBOL(<lf_cond>).
          DATA(lo_filter_node) = lo_filter_factory->create_by_range(  iv_property_path = <lf_cond>-name
                                                                      it_range         = <lf_cond>-range ).
          IF lo_filter_node_root IS INITIAL.
           lo_filter_node_root = lo_filter_node.
          ELSE.
           lo_filter_node_root = lo_filter_node_root->and( lo_filter_node ).
          ENDIF.
        ENDLOOP.

        IF lo_filter_node_root is NOT INITIAL.
        lo_request->set_filter(  io_filter_node = lo_filter_node_root ).
        ENDIF.

        " Execute the request and retrieve the business data
        lo_response = lo_request->execute(  ).

        lo_response->get_business_data( IMPORTING et_business_data = lt_business_data ).

      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
        " Handle remote Exception
        " It contains details about the problems of your http(s) connection

      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        " Handle Exception

      CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
        " Handle Exception
        RAISE SHORTDUMP lx_web_http_client_error.


    ENDTRY.



      io_response->set_data(  lt_business_data  ).
      io_response->set_total_number_of_records(  lines( lt_business_data ) ).




  ENDMETHOD.
ENDCLASS.
