%% Run unit tests
% This script runs unit test for Electric Aircraft

% Copyright 2025 The MathWorks, Inc.

RelStr = matlabRelease().Release;
disp("This is MATLAB " + RelStr + ".")

topFolder = currentProject().RootFolder;

% Create Test Suite

import matlab.unittest.TestSuite;
suite = [testsuite('eVTOLdroneUnitTest.m'),...
    testsuite('eVTOLdroneWorkflowTest.m'),...
    testsuite('BatteryHVUnitTestRunCheck.m'),...
    testsuite('PropellerUnitTestRunCheck.m'),...
    testsuite('MotorUnitTestRunCheck.m'),...
    testsuite('FMunitTestRunCheck.m')];

% Create test runner

runner = matlab.unittest.TestRunner.withTextOutput( ...
    OutputDetail = matlab.unittest.Verbosity.Detailed);

% Create Report Folder
reportFolder = fullfile(topFolder, "Reports" + RelStr);
if not(isfolder(reportFolder))
    mkdir(reportFolder)
end

% JUnit Style Test Result
TestResultFile = "VTOL_TestResults_" + RelStr + ".xml";
jUnitPlugin = matlab.unittest.plugins.XMLPlugin.producingJUnitFormat( ...
    fullfile(reportFolder, TestResultFile));
runner.addPlugin(jUnitPlugin);

% MATLAB Code Coverage Report
coverageReport = matlab.unittest.plugins.codecoverage.CoverageReport( ...
    reportFolder, MainFile = "VTOL_Coverage_" + RelStr + ".html" );
list = [dir(fullfile(topFolder, 'Scripts_Data') + filesep + '*.m');...
    dir(fullfile(topFolder, 'Utilities','ControlTuning') + filesep + '*.m')];
fileList = arrayfun(@(x)[x.folder, filesep, x.name], list, 'UniformOutput', false);
CC_Plugin = matlab.unittest.plugins.CodeCoveragePlugin.forFile(fileList, ...
    Producing = coverageReport);

addPlugin(runner, CC_Plugin);

% Run tests
results = run(runner, suite);
assertSuccess(results)

% Close project without save dialog
bdclose('all');
myDictionaryObj = Simulink.data.dictionary.open('VTOLDynamicsData.sldd');
discardChanges(myDictionaryObj);
close(myDictionaryObj);
proj = currentProject;
close(proj);