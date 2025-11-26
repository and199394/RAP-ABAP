@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface Entity Student Detail'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass : #MIXED
}
define root view entity ZI_STD_DET
  as select from zstd_det
  association [0..1] to ZI_STD_GENDER    as _GENDER on $projection.Gender = _GENDER.Value
  composition [0..*] of ZI_STD_AR as _academicres
{
  key id                  as Id,
      firstname           as Firstname,
      lastname            as Lastname,
      age                 as Age,
      course              as Course,
      courseduration      as Courseduration,
      status              as Status,
      gender              as Gender,
      dob                 as Dob,
      lastchangedate      as LastChangeDate,
      locallastchangedate as LocalLastChangeDate,
      _GENDER,
      _GENDER.Description as Genderdesc,
      _academicres

}
