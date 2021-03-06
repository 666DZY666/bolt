set(MODEL_TOOLS_PROJECT_NAME "model-tools")
unset(MODEL_TOOLS_ROOT)
find_path(MODEL_TOOLS_ROOT NAMES ${MODEL_TOOLS_PROJECT_NAME} HINTS ${BOLT_ROOT} $ENV{BOLT_ROOT})
set(MODEL_TOOLS_ROOT "${MODEL_TOOLS_ROOT}/${MODEL_TOOLS_PROJECT_NAME}")

set(MODEL_TOOLS_INCLUDE_DIR "${MODEL_TOOLS_ROOT}/include")
if (USE_DYNAMIC_LIBRARY)
    set(MODEL_TOOLS_LIBRARY "${MODEL_TOOLS_ROOT}/lib/lib${MODEL_TOOLS_PROJECT_NAME}.so")
else (USE_DYNAMIC_LIBRARY)
    set(MODEL_TOOLS_LIBRARY "${MODEL_TOOLS_ROOT}/lib/lib${MODEL_TOOLS_PROJECT_NAME}.a")
endif (USE_DYNAMIC_LIBRARY)

if (MODEL_TOOLS_INCLUDE_DIR AND MODEL_TOOLS_LIBRARY)
    set(MODEL_TOOLS_FOUND true)
endif (MODEL_TOOLS_INCLUDE_DIR AND MODEL_TOOLS_LIBRARY)

if (USE_CAFFE)
    find_package(ModelToolsCaffe)
endif (USE_CAFFE)
if (USE_ONNX)
    find_package(ModelToolsOnnx)
endif(USE_ONNX)
if (USE_TFLITE)
    find_package(ModelToolsTFLite)
endif (USE_TFLITE)

if (MODEL_TOOLS_FOUND)
    set(MODEL_TOOLS_LIBRARIES "${MODEL_TOOLS_LIBRARY};${MODEL_TOOLS_CAFFE_LIBRARIES};${MODEL_TOOLS_ONNX_LIBRARIES};${MODEL_TOOLS_TFLITE_LIBRARIES}")
    include_directories(include ${MODEL_TOOLS_INCLUDE_DIR})
    message(STATUS "Found ${MODEL_TOOLS_PROJECT_NAME}.h: ${MODEL_TOOLS_INCLUDE_DIR}")
    message(STATUS "Found ${MODEL_TOOLS_PROJECT_NAME}: ${MODEL_TOOLS_LIBRARIES}")
else (MODEL_TOOLS_FOUND)
    message(FATAL_ERROR "
FATAL: can not find lib${MODEL_TOOLS_PROJECT_NAME}.* library in <BOLT_ROOT>/model-tools/lib directory,
       please set shell or cmake environment variable BOLT_ROOT.
    ")
endif (MODEL_TOOLS_FOUND)
