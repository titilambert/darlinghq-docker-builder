build:
	docker build -t darling-builder .

build_lkm:
	docker run -it --rm \
	-v /usr/src/:/usr/src/ \
	-v /usr/lib/linux-kbuild-4.15/:/usr/lib/linux-kbuild-4.15/ \
	-v /lib/modules/4.15.0-2-amd64:/lib/modules/4.15.0-2-amd64 \
	-v `pwd`/output:/output \
	darling-builder bash -c "make lkm && echo 'Move /darling to /output' && mv /darling /output"

install:
	ln -s `pwd`/output/darling /darling
	sudo apt-get install clang libfuse-dev libcairo2-dev libgl1-mesa-dev libtiff5-dev
	cd /darling && sudo make install && sudo make lkm_install
	sudo apt-get purge clang libfuse-dev libcairo2-dev libgl1-mesa-dev libtiff5-dev

uninstall:
	cd /darling && sudo make uninstall && sudo make lkm_install
