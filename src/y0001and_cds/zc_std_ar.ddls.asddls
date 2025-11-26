@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption View For Academic Result'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true

@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define view entity ZC_STD_AR
  as projection on ZI_STD_AR
{
      @EndUserText.label: 'Student Id'
  key Id,

      @EndUserText.label: 'Course'
  key Course,

      @EndUserText.label: 'Semester'
  key Semester,

      @EndUserText.label: 'Result'
      Semresult,
      /* Associations */
      _student : redirected to parent ZC_STD_DET,
      
      _course
}
