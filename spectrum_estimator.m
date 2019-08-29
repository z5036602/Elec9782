function [spectrum] = spectrum_estimator(data,lag)
    f_res = 1000;
    spectrum = ones(1,f_res); 
    counter = 0;
    for f_c = 1:f_res;
        w_0 = (f_c/f_res)*pi;
        total_acs = 0;
        counter = 1;
        for r = -lag:lag
            total_acs = total_acs+data(counter)*exp(-1i*w_0*r);
            counter = counter +1;
        end
        spectrum(f_c) = total_acs;
    end 
end 
