function phi_falsify(mdl, phi)


    %mdl = 'Autotrans_shift_30';
    Br = BreachSimulinkSystem(mdl);

    Br.Sys.tspan = 0:.01: 30;

    input_gen.type = 'UniStep';
    input_gen.cp = 5;
    Br.SetInputGen(input_gen);
    %Br.PrintParams();


    for cpi = 0:input_gen.cp-1
        throttle_sig = strcat('throttle_u', num2str(cpi));
        brake_sig = strcat('brake_u', num2str(cpi));
        Br.SetParamRanges({throttle_sig},[0 100]);
        %Br.SetParam({throttle_sig}, 50);
        Br.SetParamRanges({brake_sig},[0 325]);
        %Br.SetParam({brake_sig},100);
    end


    %phi = STL_Formula('phi', 'alw_[0,30]((speed[t]<4050) and (RPM[t]<4780))');


    BreachProblem.list_solvers();
    solver_input = 'cmaes';
    IterNum = 1;

    total_time = 0.0;
    succ_iter = 0;
    succ_trial = 0;
    obj_best = [];
    num_sim = [];

    for n = 0:IterNum-1

        falsif_pb = FalsificationProblem(Br, phi);
        falsif_pb.max_time = Inf;
        falsif_pb.max_obj_eval = 50;
        falsif_pb.setup_solver(solver_input);
        falsif_pb.solve();


        if falsif_pb.obj_best < 0
           total_time = total_time + falsif_pb.time_spent;
           succ_iter = succ_iter + falsif_pb.nb_obj_eval;
           succ_trial = succ_trial + 1; 
        end
        obj_best = [obj_best; falsif_pb.obj_best]
        num_sim = [num_sim; falsif_pb.nb_obj_eval]

        save('test.mat', 'falsif_pb');
    end

    aver_time = total_time/succ_trial
    aver_succ_iter = succ_iter/succ_trial
    succ_trial

end