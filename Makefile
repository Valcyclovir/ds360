ifeq ($(PREFIX),)
    PREFIX := ~/.local
endif

ds360: ds360.cpp
	g++ -Wall -o ds360 ds360.cpp

install: ds360
	install -m 555 ds360 $(PREFIX)/bin/
	install -m 444 ds360.service /etc/systemd/system/
	systemctl daemon-reload

uninstall:
	rm -f $(PREFIX)/bin/ds360
	rm -f /etc/systemd/system/ds360.service
	systemctl daemon-reload
	sudo rm -f /usr/lib/udev/rules.d/80-ds360.rules
	sudo rm -f /usr/bin/ds360-stop.sh
	sudo udevadm control --reload