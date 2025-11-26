@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption View for Student'
@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define root view entity ZC_STD_DET
  as projection on ZI_STD_DET as Student
  
{
  @EndUserText.label: 'Student Id'
  key Id,
  
  @EndUserText.label: 'First Name'
      Firstname,
  
  @EndUserText.label: 'Last Name'    
      Lastname,
      
  @EndUserText.label: 'Age'    
      Age,
          
  @EndUserText.label: 'Status'    
      Status,
      
  @EndUserText.label: 'Gender'
  @ObjectModel.text.element: [ 'Genderdesc' ]
      Gender,
      
      Genderdesc,
      
  @EndUserText.label: 'DOB'    
      Dob,
      
      _academicres : redirected to composition child ZC_STD_AR

}
