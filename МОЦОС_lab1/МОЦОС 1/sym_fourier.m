function sym_fourier
% Formation of the Fourier spectrum in the symbolic form

    % The segment on which the graph will be plot
    xmin = -3;
    xmax = 3;

    syms t v w f

    close all;
    f = -heaviside(t - 1 - 0.5) + heaviside(t - 0.5);
    Sw = fourier(f);
    S = subs(Sw, w, 2 * pi * v);

    % frequency response
    subplot(3, 1, 1);
    

    hold on
    h = ezplot(real(S), [xmin, xmax]);
    set_pretty(h, [xmin, xmax, -1, 1.5]);

    h = ezplot(imag(S), [xmin, xmax]);
    hold off
    set_pretty(h, [xmin, xmax, -1, 1.5], 'r');
    grid;
    title('Действительная и мнимая составляющие спектра')
    xlabel v, ylabel S(v)
    legend('Действительная','Мнимая');

    % amplitude frequency response
    subplot(3, 1, 2);
    % here you need to plot the amplitude frequency response
    h = ezplot(abs(S), [xmin, xmax]);
    set_pretty(h, [xmin, xmax, -1, 1.5]);
    title('АЧХ')
    xlabel v, ylabel abs(S(v))
    
   subplot(3, 1, 3);
    % here you need to plot the amplitude frequency response
    h = ezplot(angle(S), [xmin, xmax]);
    set_pretty(h, [xmin, xmax, -2, 3]);
    title('ФЧХ')
    xlabel v, ylabel angle(S(v))
    return;
end

function set_pretty(h, axis_xy, color)

    if nargin < 3
        color = 'b';
    end
    
    grid;
    set(h, 'LineWidth',2.5, 'Color', color);
    title(''); xlabel('');
    % xmin xmax ymin ymax
    axis(axis_xy);

end