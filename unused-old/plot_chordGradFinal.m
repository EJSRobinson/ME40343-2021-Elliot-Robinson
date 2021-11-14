subplot(1, 2, 1)
plot(chord_grad_range, stress_max)
hold on
plot(chord_grad_range, stress_max * safety_factor)
plot(chord_grad_range, zeros(1, 151) + stress_max_limit,'--')
xlabel('Chord_{grad}')
ylabel('Stress (Pa)')
legend('Stress', 'Stress w. SF', 'Material Yeild Stress')
% 
subplot(1, 2, 2)
plot(chord_grad_range, deflection)
hold on
plot(chord_grad_range, deflection * safety_factor)
plot(chord_grad_range, zeros(1, 151) + deflection_max_limit,'--')
plot([0.008, 0.008], [0, 3],'--')
xlabel('Chord_{grad}')
ylabel('Deflection (m)')
legend('Deflection', 'Deflection w. SF', 'Specified Deflection Limit', 'Max Chord_{grad} mark')