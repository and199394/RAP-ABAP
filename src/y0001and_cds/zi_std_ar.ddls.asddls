@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface Entity Student Academic Result'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZI_STD_AR
  as select from zstd_ar
  association to parent ZI_STD_DET as _student on $projection.Id = _student.Id
{
  key id        as Id,
  key course    as Course,
  key semester  as Semester,
      semresult as Semresult,
      _student
}
