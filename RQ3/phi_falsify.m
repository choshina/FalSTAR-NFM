clear;

InitBreach;


mdl = 'Autotrans_shift_30';
Br = BreachSimulinkSystem(mdl);

Br.Sys.tspan = 0:.01: 30;

input_gen.type = 'UniStep';
input_gen.cp = input('\n Please input control points\n');
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



phi1 = STL_Formula('phi1','alw_[0,30] (speed[t] < 120)');
phi1111 = STL_Formula('phi1','alw_[0,30] ((throttle[t]*brake[t] == 0) => (speed[t] < 120))');

phi1112 = STL_Formula('phi1','(alw_[0,30](throttle[t]*brake[t] == 0)) => (alw_[0,30] (speed[t] < 120))');

phi1113 = STL_Formula('phi1','true => (alw_[0,30] (speed[t] < 120))');

phi1114 = STL_Formula('phi1','(alw_[0,30]((throttle[t] == 0)or (brake[t] == 0))) => (alw_[0,30] (speed[t] < 110))');
%phi1115 = STL_Formula('phi1','(alw_[0,30](((throttle[t] == 0)or (brake[t] == 0)) => (alw_[0,30] (speed[t] < 110))))');
phi102 = STL_Formula('phi1','(alw_[6,30]((throttle[t] == 0)or (brake[t] == 0))) and alw_[0, 6](brake[t] == 0) => (alw_[0,30] (speed[t] < 110))');

phi103 = STL_Formula('phi1','(alw_[0,30]((throttle[t] <= 5)or (brake[t] <= 10)))=>(alw_[0,30] (speed[t] < 100))');

phi104 = STL_Formula('phi1','(alw_[0,30]((throttle[t] >3* brake[t]) or (brake[t] > 3*throttle[t])))=>(alw_[0,30] (speed[t] < 100))');
phi105 = STL_Formula('phi1','(alw_[12,18]((throttle[t] == 0) and (brake[t] == 0)))=>(alw_[0,30] (speed[t] < 100))');
phi106 = STL_Formula('phi1','(alw_[0, 24]((throttle[t] > 70) => throttle[t+6] <10 ))=>(alw_[0,30] (speed[t] < 100))');


phi111 = STL_Formula('phi11', 'alw_[0,30](RPM[t]<4775)');
phi112 = STL_Formula('phi11', 'alw_[0,10](RPM[t]<4750)');
phi2 = STL_Formula('phi2','alw_[0,30]((gear[t]*30 == 40*3) => (speed[t] >= 43))');

phi27 = STL_Formula('phi2','alw_[0,30]((gear[t] == 3) => (speed[t] >= 20))');
phi26 = STL_Formula('phi2', 'alw_[0,30]((gear[t] > 2 and gear[t]<4) => (speed[t] > 20))');

phi3 = STL_Formula('phi3','alw_[0,30](not (gear[t] == 4 and speed[t] < 35))');
phi4 = STL_Formula('phi4','not alw_[10,30](50 < speed[t] and speed[t] < 60)');
%phi4 = STL_Formula('phi4','(not alw_[10,30](50 < speed[t] and speed[t] < 60)) or ev_[6,10](RPM[t]>2000)');


phi5 = STL_Formula('phi5','alw_[0,10](speed[t]<80) or ev_[0,30](RPM[t] > 2520)');
phi51 = STL_Formula('phi51','alw_[0,10](50*speed[t]<2500) or ev_[0,30](RPM[t] > 2520)');


phi6 = STL_Formula('phi6','alw_[0,30]((not (gear[t] == 1)) or RPM[t]<4625)');
phi61 = STL_Formula('phi6','alw_[0,30](gear[t]==3 => RPM[t]>1900)');
phi611 = STL_Formula('phi6','alw_[27, 28]((not (gear[t] == 3)) or RPM[t]>700)');
%phi62 = STL_Formula('phi6','alw_[0,10]((speed[t]>80) =>)');


phi7 = STL_Formula('phi7','alw_[0,10](speed[t]<= 85) or ev_[0,30](RPM[t] >= 4500)');%good case

%phi8 = STL_Formula('phi8','alw_[0,30](ev_[0,10](RPM[t]<4450 or RPM[t]>4460)) or alw_[0,30](ev_[0,10](speed[t]<130))');

%phi9 = STL_Formula('phi9','ev_[0,30](ev_[9,13](gear[t] < 3) or alw_[0,1](gear[t] == 3))');

phi10 = STL_Formula('phi10','alw_[0,30](ev_[0,15](RPM[t]<=3500 or RPM[t]>=4500))');

phi11 = STL_Formula('phi11','alw_[0,6](not gear[t] == 4)');

phi12 = STL_Formula('phi12','alw_[0,30]((not((not gear[t] == 3) and ev_[0,0.04](gear[t] == 3))) or (alw_[0.04,8.04](gear[t] == 3)))');

phi13 = STL_Formula('phi13','not ev_[0,4](alw_[0,3](gear[t] == 3))');

phi14 = STL_Formula('phi14','(not (ev_[0,21](alw_[0,9](RPM[t]>4000)))) ');

phi15 = STL_Formula('phi15','alw_[0,30](speed[t+1] - speed[t] < 25 and speed[t+1] - speed[t] > -25)');

phi16 = STL_Formula('phi16','alw_[0,10](speed[t]<60) and alw_[10,20](speed[t]>40) and alw_[20,30](speed[t]<80)');

phi17 = STL_Formula('phi17','alw_[0,20](speed[t]<100) or alw_[20,30](speed[t]>10)');

phi18= STL_Formula('R6','alw_[0,29](speed[t]<100) or alw_[29,30](speed[t]>30)');

phi19= STL_Formula('R7','alw_[10,13](not(gear[t] == 4))');

phi20= STL_Formula('R8','alw_[0,30](rpm[t] < 3000 or alw_[0,1](rpm[t] > 1500))');


phi21= STL_Formula('R9','alw_[3,5](speed[t]<100)');

%ARCH 2016

phi22 = STL_Formula('phi1', 'alw_[0,30](speed[t]<130 and RPM[t] < 5000)');



phi23 = STL_Formula('phi2', 'alw_[0,15](RPM[t+10]-RPM[t]>2000 => gear[t+15]-gear[t]>0)');

phi24 = STL_Formula('phi3', 'alw_[0,26](speed[t+4]-speed[t]>30 => gear[t+4]-gear[t]>0 )');

phi25 = STL_Formula('phi3', 'alw_[0.0, 30.0] ((not(gear[t] == 1.0) and ev_[0.001, 0.1] (gear[t] == 1.0)) => ev_[0.001, 0.1] alw_[0.0, 2.5] (gear[t] == 1.0))');

% phi20= STL_Formula('R9','alw_[10,13](gear[t] ~= 4) or alw_[13,25](speed[t]>80)');

phi26 = STL_Formula('phi3', 'alw_[0,30]((speed[t]<4050) and (RPM[t]<4780))');

phi_in = '\n Please input which property? \n';
phi_input = input(phi_in);
phi = eval(strcat('phi', num2str(phi_input)));
    
BreachProblem.list_solvers();
solver_input = input('\n Please input a solver:\n', 's');
IterNum = input('\n Please input the number of trials:\n');

total_time = 0.0;
succ_iter = 0;
succ_trial = 0;
obj_best = [];
num_sim = [];

for n = 0:IterNum-1
    
    falsif_pb = FalsificationProblem(Br, phi);
    falsif_pb.max_time = Inf;
    falsif_pb.max_obj_eval = 1000;
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

