classdef eVTOLdroneWorkflowTest < matlab.unittest.TestCase
    %% Class implementation of workflow test

    % Copyright 2025 The MathWorks, Inc.
    properties
        openfigureListBefore;
    end

    methods(TestMethodSetup)
        function listOpenFigures(test)
            % List all open figures
            test.openfigureListBefore = findall(0,'Type','Figure');
        end

        function setupWorkingFolder(test)
            % Set up working folder
            import matlab.unittest.fixtures.WorkingFolderFixture;
            test.applyFixture(WorkingFolderFixture);
        end
    end

    methods(TestMethodTeardown)
        function closeOpenedFigures(test)
            % Close all figure opened during test
            figureListAfter = findall(0,'Type','Figure');
            figuresOpenedByTest = setdiff(figureListAfter, test.openfigureListBefore);
            arrayfun(@close, figuresOpenedByTest);
        end
    end

    methods (Test)
        function BatterySizingWorkflow(testCase)
            evalin('base','BatterySizing');
        end
      
        function BatterySizingSim(testCase)
            evalin('base','flightModeSimulation');
        end

        function ControlTuningWorkflow(testCase)
            evalin('base','MotorControlTuning');
        end

        function ControlStabilityWorkflow(testCase)
            evalin('base','StabilityAnalysis');
        end

    end


end