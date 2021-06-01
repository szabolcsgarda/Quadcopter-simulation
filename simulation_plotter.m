%Plot Pitch step
figure
t = tiledlayout(1,1); % Requires R2019b or later
ax1 = nexttile;
plot(ax1,out.psi_ref.time, out.psi_ref.signals.values,out.psi.time,out.psi.signals.values)
xlim([0 9])
xlabel('time [s]')
ylabel('Pitch angle [Degree]')
legend('Reference','System','FontSize',8)


saveas(gcf,'acc_estimations.pdf')

%Plot Altitude step
figure
t = tiledlayout(1,1); % Requires R2019b or later
ax1 = nexttile;
plot(ax1,out.z_ref.time, out.z_ref.signals.values,out.z.time,out.z.signals.values)
xlim([0 6])
xlabel('time [s]')
ylabel('Attitude [m]')
legend('Reference','System','FontSize',8)

saveas(gcf,'simulation_attitude.pdf')