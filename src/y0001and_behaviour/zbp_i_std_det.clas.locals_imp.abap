CLASS lsc_zi_std_det DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

ENDCLASS.

CLASS lsc_zi_std_det IMPLEMENTATION.

  METHOD save_modified.

    DATA lt_academicresult TYPE STANDARD TABLE OF zstd_ar.
    IF create-academicresult IS NOT INITIAL.

      lt_academicresult = VALUE #( FOR ar IN create-academicresult ( id = ar-id
                                                                     course = ar-Course
                                                                     semester = ar-Semester
                                                                     semresult = ar-Semresult ) ).

      LOOP AT lt_academicresult ASSIGNING FIELD-SYMBOL(<ls_result>).
        <ls_result>-course = 'C0001'.
      ENDLOOP.
      INSERT zstd_ar FROM TABLE @lt_academicresult.

    ENDIF.

    IF update-academicresult IS NOT INITIAL.
      lt_academicresult = VALUE #( FOR ar IN update-academicresult ( id = ar-id
                                                                     course = ar-Course
                                                                     semester = ar-Semester
                                                                     semresult = ar-Semresult ) ).
      UPDATE zstd_ar FROM TABLE @lt_academicresult.
    ENDIF.

    IF delete-academicresult IS NOT INITIAL.
      lt_academicresult = VALUE #( FOR ar2 IN delete-academicresult ( id = ar2-id
                                                                     course = ar2-Course
                                                                     semester = ar2-Semester ) ).
      DELETE zstd_ar FROM TABLE @lt_academicresult.
    ENDIF.

  ENDMETHOD.

ENDCLASS.

CLASS lhc_academicresult DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR AcademicResult RESULT result.
*    METHODS setid FOR DETERMINE ON MODIFY
*      IMPORTING keys FOR academicresult~setid.
    METHODS createprojectandrootnode FOR MODIFY
      IMPORTING keys FOR ACTION academicresult~createprojectandrootnode RESULT result.
    METHODS setkeys FOR DETERMINE ON SAVE
      IMPORTING keys FOR academicresult~setkeys.
    METHODS checkcourse FOR VALIDATE ON SAVE
      IMPORTING keys FOR academicresult~checkcourse.


ENDCLASS.

CLASS lhc_academicresult IMPLEMENTATION.

  METHOD get_instance_features.
    READ ENTITIES OF zi_std_det IN LOCAL MODE ENTITY AcademicResult
    FIELDS ( Course Semester Semresult )
    WITH CORRESPONDING #( keys )
    RESULT DATA(academics)
    FAILED failed.


  ENDMETHOD.


*  METHOD setId.

*    DATA: max_booking TYPE /dmo/booking_id,
*          update      TYPE TABLE FOR UPDATE zi_std_det\\AcademicResult.
*
*    READ ENTITIES OF zi_std_det IN LOCAL MODE
*      ENTITY AcademicResult
*      FIELDS ( Course Semester )
*      WITH CORRESPONDING #( keys )
*      RESULT DATA(academicress).
**
*    LOOP AT academicress INTO DATA(academicres).
*        MODIFY ENTITIES OF zi_std_det IN LOCAL MODE
*        ENTITY Student
*        CREATE BY \_academicres
*        FIELDS ( Course Semester )
*        WITH VALUE #( ( %tky = CORRESPONDING #( academicres-%tky )
*                        %target = VALUE #( ( %cid = 'cid3' Course = 'C0001' Semester = '1' ) ) ) )
*        MAPPED DATA(lt_mapped)
*        FAILED DATA(lt_failed).
*
*    ENDLOOP.

*  ENDMETHOD.

  METHOD createProjectAndRootNode.


    READ ENTITIES OF zi_std_det IN LOCAL MODE
      ENTITY AcademicResult
      FIELDS ( Course Semester )
      WITH CORRESPONDING #( keys )
      RESULT DATA(academicress).

*    LOOP AT academicress INTO DATA(academicres).
*
*        APPEND VALUE #( %tky   = academicres-%tky
*                        Course = 'C0001'
*                        Semester = '1' )
*          TO update.
*
*    ENDLOOP.
*
*    LOOP AT academicress INTO DATA(academicres).
*
*        APPEND VALUE #( %tky   = academicres-%tky
*                        Course = 'C0001'
*                        Semester = '1' )
*          TO update.
*
*    ENDLOOP.
*
*    MODIFY ENTITIES OF zi_std_det IN LOCAL MODE
*        ENTITY AcademicResult
*        UPDATE FIELDS(  Course )


  ENDMETHOD.

  METHOD setKeys.

    READ ENTITIES OF zi_std_det IN LOCAL MODE
          ENTITY AcademicResult
          FIELDS ( Course Semester )
          WITH CORRESPONDING #( keys )
          RESULT DATA(academicress).
  ENDMETHOD.

  METHOD checkCourse.
    READ ENTITIES OF zi_std_det IN LOCAL MODE
        ENTITY AcademicResult
        FIELDS ( Course )
        WITH CORRESPONDING #( keys )
        RESULT DATA(academicresults)
        ENTITY Student BY \_academicres
        FIELDS ( Course )
        WITH CORRESPONDING #( keys )
        RESULT DATA(academicresults2).

    SELECT FROM zi_std_course
        FIELDS *
        INTO TABLE @DATA(lt_course).

*    LOOP AT academicresults INTO DATA(academicresult).
*
*      IF NOT line_exists( lt_course[ Value = academicresult-Course ] ).
*        APPEND VALUE #(  %tky = academicresult-%tky
*                         %msg = new_message( id       = if_abap_behv_message=>if_t100_message~default_textid-msgid
*                                             number   = if_abap_behv_message=>if_t100_message~default_textid-msgno
*                                             severity = if_abap_behv_message=>severity-warning
*                                             v1       = 'Course not exists' )
*                         %element-course = if_abap_behv=>mk-on )
*                         TO reported-academicresult.
*      ENDIF.
*
*    ENDLOOP.

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

    METHODS get_global_features FOR GLOBAL FEATURES
      IMPORTING REQUEST requested_features FOR student RESULT result.
*    METHODS setid FOR DETERMINE ON MODIFY
*      IMPORTING keys FOR student~setid.
    METHODS getdefaultsforcreatechild FOR READ
      IMPORTING keys FOR FUNCTION student~getdefaultsforcreatechild RESULT result.

    METHODS createchild FOR MODIFY
      IMPORTING keys FOR ACTION student~createchild.

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

  METHOD get_global_features.
  ENDMETHOD.

*  METHOD setId.
**
*    MODIFY ENTITIES OF zi_std_det IN LOCAL MODE
*    ENTITY Student
*    CREATE BY \_academicres
*    FIELDS ( Course Semester )
*    WITH VALUE #( FOR key IN keys ( %tky = key-%tky
*                    %target = VALUE #( ( %cid = 'TEST' Course = 'C0001' Semester = '1' ) ) ) )
*    MAPPED DATA(lt_mapped)
*    FAILED DATA(lt_failed).
*
*  ENDMETHOD.

  METHOD GetDefaultsForCreateChild.
  ENDMETHOD.

  METHOD CreateChild.
    MODIFY ENTITY IN LOCAL MODE zi_std_det
        CREATE BY \_academicres
        AUTO FILL CID
        FIELDS ( Course Semester ) WITH VALUE #( FOR key IN keys (
          %is_draft = if_abap_behv=>mk-on
          id = key-Id
          %target = VALUE #(
           ( %is_draft = if_abap_behv=>mk-on
             Id = key-Id
             Course = key-%param-course
             Semester = key-%param-semester )
            ) ) )
        REPORTED reported FAILED failed MAPPED mapped.
  ENDMETHOD.

ENDCLASS.
