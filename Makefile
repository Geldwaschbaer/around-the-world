path = ~/.lexaloffle/pico-8/carts/upcoming-game/

all: test install

test:
	# test lua files for errors
	@lua _tests.lua

install:
	# copy new game files
	@mkdir -p ${path}
	@cp src/* ${path}

clean:
	# remove old files
	@rm -r ${path}

reinstall: clean install