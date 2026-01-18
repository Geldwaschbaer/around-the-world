path = ~/.lexaloffle/pico-8/carts/around-the-world/

all: clean install

install:
	# copy new game files
	@mkdir -p ${path}
	@cp src/* ${path}

clean:
	# remove old files
	@rm -fr ${path}

reinstall: clean install
