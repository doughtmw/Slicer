################################################################################
#
#  Program: 3D Slicer
#
#  Copyright (c) 2010 Kitware Inc.
#
#  See COPYRIGHT.txt
#  or http://www.slicer.org/copyright/copyright.txt for details.
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#
#  This file was originally developed by Jean-Christophe Fillion-Robin, Kitware Inc.
#  and was partially funded by NIH grant 3P41RR013218-12S1
#
################################################################################

#SLicerMacroTranslation

#Parameters :
#
#   SRCS ..................: All sources witch need to be translated
#
#   UI_SRCS ...............: All ui_sources witch need to be translated
#
#   TS_DIR.................: Path to the TS files
#
#   TS_BASEFILENAME........: Name of the librairi
#
#   TS_LANGUAGES...........: Variable with all the languages
#
#   QM_OUTPUT_DIR_VAR .....: Translation's dirs generated by the macro
#
#   QM_OUTPUT_FILES_VAR....: Translation's files generated by the macro
#

macro(SlicerMacroTranslation)
  set(options)
  set(oneValueArgs QM_OUTPUT_DIR_VAR TS_DIR TS_BASEFILENAME)
  set(multiValueArgs SRCS UI_SRCS TS_LANGUAGES QM_OUTPUT_FILES_VAR)
  cmake_parse_arguments(MY "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

  # ---------------------------------------------------------------------------------
  # Sanity Checks
  # ---------------------------------------------------------------------------------
  #set(expected_nonempty_vars SRCS UI_SRCS TS_INPUT)
#add TS_LANGUAGES also
  set(expected_nonempty_vars SRCS TS_DIR TS_BASEFILENAME )
  foreach(var ${expected_nonempty_vars})
    if("${MY_${var}}" STREQUAL "")
      message(FATAL_ERROR "error : ${var} Cmake varianle is empty !")
    endif()
  endforeach()

  # ---------------------------------------------------------------------------------
  # Set File to translate
  # ---------------------------------------------------------------------------------

  set(FILES_TO_TRANSLATE
    ${MY_SRCS}
    ${MY_UI_SRCS}
  )

  # ---------------------------------------------------------------------------------
  # Set TS_FILES
  # ---------------------------------------------------------------------------------

  foreach(language ${MY_TS_LANGUAGES})
    set(TS_FILES
      ${TS_FILES}
      "${MY_TS_DIR}${MY_TS_BASEFILENAME}_${language}.ts"
    )
  endforeach()

  # ---------------------------------------------------------------------------------
  # UPDATE or ADD translation
  # ---------------------------------------------------------------------------------

  if(CTK_QT_VERSION VERSION_LESS "5")
    if(Slicer_UPDATE_TRANSLATION)
      QT4_CREATE_TRANSLATION(QM_OUTPUT_FILES ${FILES_TO_TRANSLATE} ${TS_FILES})
    else()
      QT4_ADD_TRANSLATION(QM_OUTPUT_FILES ${TS_FILES})
    endif()
  else()
    if(Slicer_UPDATE_TRANSLATION)
      QT5_CREATE_TRANSLATION(QM_OUTPUT_FILES ${FILES_TO_TRANSLATE} ${TS_FILES})
    else()
      QT5_ADD_TRANSLATION(QM_OUTPUT_FILES ${TS_FILES})
    endif()
  endif()

  # ---------------------------------------------------------------------------------
  # Set the variable MY_QM_OUTPUT_DIR_VAR
  # ---------------------------------------------------------------------------------
  # Extract the path associated with the first file of the list QM_OUTPUT_FILES
  # -> QM_OUTPUT_DIR

  list(GET QM_OUTPUT_FILES 0 QM_OUTPUT_FIRST_FILE)
  get_filename_component(${MY_QM_OUTPUT_DIR_VAR} "${QM_OUTPUT_FIRST_FILE}" PATH)

  # ---------------------------------------------------------------------------------
  # Set the variable MY_QM_OUTPUT_FILES_VAR
  # ---------------------------------------------------------------------------------

  set(${MY_QM_OUTPUT_FILES_VAR} ${QM_OUTPUT_FILES})

  # ---------------------------------------------------------------------------------
  # Install language
  # ---------------------------------------------------------------------------------
  install(
    FILES ${QM_OUTPUT_FILES}
    DESTINATION ${Slicer_INSTALL_QM_DIR}
    COMPONENT Runtime
  )

  # ---------------------------------------------------------------------------------
  # ADD custom command and target
  # ---------------------------------------------------------------------------------

  #add_custom_command(OUTPUT ${TS_FILES} DEPENDS ${FILES_TO_TRANSLATE} APPEND)
  #add_custom_target(TS_TRANSLATE DEPENDS ${MY_QM_FILES})

endmacro()
