all: mqtt_spec.html

%.html: %.md
	pandoc -s -o $@ $<
