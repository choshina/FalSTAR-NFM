mdl = 'Autotrans_shift';
%mdl = 'Autotrans_shift_30';

phi = STL_Formula('phi', 'alw_[0,30]((speed[t]<135) and (RPM[t]<4780))');
%phi = STL_Formula('phi', 'alw_[0,30]((speed[t]< 4050) and (RPM[t]<4780))');

phi_set = STL_Break(phi);
phi1 = phi_set(1);
phi2 = phi_set(2);

% main function starts
phi_falsify(mdl, phi);
stlsource(mdl, phi, phi1, phi2);
draw_partial_rob();