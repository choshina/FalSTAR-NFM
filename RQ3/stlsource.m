function stlsource(mdl, phi, phi1, phi2)

    th_range = [0, 100];
    br_range = [0, 325];

    %phi = STL_Formula('phi', 'alw_[0,30]((speed[t]<4050) and (RPM[t]<4780))');
    %phi1 = STL_Formula('phi1', 'speed[t]<4050');
    %phi2 = STL_Formula('phi2', 'RPM[t]< 4780');
    type = 'and';
    g_type = 'alw';

    %mdl = 'Autotrans_shift_30';
    Br = BreachSimulinkSystem(mdl);
    input_gen.type = 'UniStep';
    input_gen.cp = 5;
    Br.SetInputGen(input_gen);

    %rng(round(rem(now,1)*1000000),'twister');

    load('test.mat');
    
    leng = numel(falsif_pb.obj_log);

    con1_list = [];
    con2_list = [];


    for trial = 1:leng

        for cpi = 0:input_gen.cp-1
            brake_sig = strcat('brake_u', num2str(cpi));
            throttle_sig = strcat('throttle_u', num2str(cpi));
            %br = rand*(br_range(2)-br_range(1)) + br_range(1)
            %th = rand*(th_range(2)-th_range(1))+ th_range(1)
            br = falsif_pb.X_log(cpi + 1, trial);
            th = falsif_pb.X_log(cpi + 1 + input_gen.cp, trial);
            Br.SetParam({brake_sig}, br);
            Br.SetParam({throttle_sig}, th);
        end


        Br.Sim(0:.01:30);

        Br.CheckSpec(phi)

        [tr1, tau1] = STL_Eval(Br.Sys, phi1, Br.P, Br.P.traj{1});
        [tr2, tau2] = STL_Eval(Br.Sys, phi2, Br.P, Br.P.traj{1});



        source = [];
        combined = [];

        %source1 = [];
        %source2 = [];

        if strcmp(type, 'and')  %and
            for pt = 1: numel(tr1)
                if tr1(pt)< tr2(pt)
                    source(pt) = 1;
                    combined(pt) = tr1(pt);
                else
                    source(pt) = 2;
                    combined(pt) = tr2(pt);
                end
            end
        else                    %or
            for pt = 1:numel(tr1)
                if tr1(pt)< tr2(pt)
                    source(pt) = 2;
                    combined(pt) = tr2(pt);
                else
                    source(pt) = 1;
                    combined(pt) = tr1(pt);
                end
            end
        end


        con1 = 0;
        con2 = 0;
        if strcmp(g_type, 'alw')
            con1 = 100000;
            con2 = 100000;
            for pt = 1:numel(source)
                if source(pt) == 1 && combined(pt)< con1
                    con1 = combined(pt);
                end
                if source(pt) == 2 && combined(pt)< con2
                    con2 = combined(pt);
                end 
            end
            if con1 == 100000
                con1 = NaN;
            end
            if con2 == 100000
                con2 = NaN;
            end
        elseif strcmp(g_type, 'ev')
            con1 = -9999;
            con2 = -9999;
            for pt = 1:numel(source)
                if source(pt) == 1 && combined(pt)> con1
                    con1 = combined(pt);
                end
                if source(pt) == 2 && combined(pt)< con2
                    con2 = combined(pt);
                end 
            end
            if con1 == -9999
                con1 = NaN;
            end
            if con2 == -9999
                con2 = NaN;
            end
        else
             con1 = tr1(1);
             con2 = tr2(2);
        end

        con1_list = [con1_list con1];
        con2_list = [con2_list con2];

    end

    save('AT3', 'con1_list', 'con2_list', 'falsif_pb');

end