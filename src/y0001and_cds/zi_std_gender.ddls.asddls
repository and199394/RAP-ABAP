@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gender Domain'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_STD_GENDER
  as select distinct from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name:'ZSTD_GENDER' )
{
  key value_low as Value,
      @Semantics.text: true
      text      as Description
}
