%cleanupVTOL clean up VTOL parameters.

% Copyright 2023 The MathWorks, Inc.

% Close all open Simulink models without saving
bdclose('all');

% Discard and close the data dictionary
myDictionaryObj = Simulink.data.dictionary.open('VTOLDynamicsData.sldd');
discardChanges(myDictionaryObj);
close(myDictionaryObj);

% Clear workspace variables
clear AAC FSState controlParams FWControlParams FixedWingCommandBus FixedWingCtrlBus ForwardVelocityCutoff HoverMission R_LOOKAHEAD R_WAYPOINTTRANSITION ReferenceFilterDen ReferenceFilterNum RotorCntrlBus SensorAAFiltDen SensorAAFiltNum SensorType TestMode TuningMode Visualization controlMode controlParams dDataSectObj guidanceType iniRoll iniYaw initPitch mdl minPWM myDictionaryObj simTimeParam tiltIni tilt_max uavParam vIni