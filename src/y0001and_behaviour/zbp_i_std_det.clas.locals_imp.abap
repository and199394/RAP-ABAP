CLASS lhc_academicresult DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR AcademicResult RESULT result.

ENDCLASS.

CLASS lhc_academicresult IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZI_STD_DET DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zi_std_det RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zi_std_det RESULT result.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR student RESULT result.

    METHODS setadmitted FOR MODIFY
      IMPORTING keys FOR ACTION student~setadmitted RESULT result.

ENDCLASS.

CLASS lhc_ZI_STD_DET IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD get_instance_features.
    READ ENTITIES OF zi_std_det IN LOCAL MODE ENTITY Student
    FIELDS ( Status )
    WITH CORRESPONDING #( keys )
    RESULT DATA(studentadmitted)
    FAILED failed.

    result = VALUE #( FOR stud IN studentadmitted
                        LET statusval = COND #( WHEN stud-status = abap_true
                                                THEN if_abap_behv=>fc-o-disabled
                                                ELSE if_abap_behv=>fc-o-enabled )
                        IN  ( %tky = stud-%tky %action-setAdmitted = statusval ) ).
  ENDMETHOD.

  METHOD setAdmitted.
    MODIFY ENTITIES OF zi_std_det IN LOCAL MODE ENTITY Student
     UPDATE FIELDS ( Status )
     WITH VALUE #( FOR key IN keys ( %tky = key-%tky Status = abap_true ) )
     FAILED failed
     REPORTED reported.

    READ ENTITIES OF zi_std_det IN LOCAL MODE ENTITY Student
    ALL FIELDS WITH CORRESPONDING #(  keys )
    RESULT DATA(studentdata).

    result = VALUE #( FOR studentrec IN studentdata ( %tky = studentrec-%tky %param = studentrec ) ).

  ENDMETHOD.

ENDCLASS.
