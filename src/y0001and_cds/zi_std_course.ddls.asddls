@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface Entity Student Course'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_STD_COURSE 
as select distinct from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name:'ZSTD_AR_COURSE_DOM' )
{
  key value_low as Value,
      @Semantics.text: true
      text      as Description
}
