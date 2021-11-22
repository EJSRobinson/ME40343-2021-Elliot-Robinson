global y_root;
global y_tip;
global thickness_chord_ratio;

chord_grad = 0.008; %Input chord gradient here

y_range = y_root:y_step:y_tip;
chord_range = chord_mean + (y_range - ((y_tip - y_root) / 2)) * chord_grad;

plot(y_range, chord_range / 2) %LE
hold on
plot(y_range, chord_range / -2) %TE
plot([y_range(1), y_range(1)], [chord_range(1)/2, chord_range(1)/-2])
plot([y_range(end), y_range(end)], [chord_range(end)/2, chord_range(end)/-2])
plot(y_range, y_range*0, '--');
plot([y_range(143), y_range(143)], [chord_range(143)/2, chord_range(143)/-2], '--')
xlabel('Spanwise displacement blade in rotor plane, y (m)')
ylabel('Chorwise displacement (m)')
legend('Leading edge', 'Trailing Edge','Root', 'Tip', 'Centre line', '3/4 Span')
xlim([0 23])