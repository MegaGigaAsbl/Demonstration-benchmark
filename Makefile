
DISTDIR= ./dist

# --------------------------------------------------------------

CC=       gcc
CFLAGS=   -O3
CIN=      benchmark.c
COUT=     ${DISTDIR}/benchmark_c

# --------------------------------------------------------------

COB=      cobc
COBFLAGS= -O3 -x
COBIN=    benchmark.cob
COBOUT=   ${DISTDIR}/benchmark_b

# --------------------------------------------------------------

FOR=      gfortran
FFLAGS=   -O3
FIN=      benchmark.f90
FOUT=     ${DISTDIR}/benchmark_f

# --------------------------------------------------------------

PAS=      fpc
PFLAGS=   -l- -v0 -O3 -Os -Xs -XX
PIN=      benchmark.pas
POUT=     ${DISTDIR}/benchmark_a

# --------------------------------------------------------------

PY=       cp
PYFLAGS=
PYIN=     benchmark.py
PYOUT=    ${DISTDIR}/benchmark_p1

PI=       pyinstaller
PIFLAGS=  --onefile --optimize=2 --log-level=ERROR
PIIN=     benchmark.py
PIOUT=    ${DISTDIR}/benchmark_p2

PN=       nuitka
PNFLAGS=  --standalone --quiet
PNIN=     benchmark.py
PNOUT=    ${DISTDIR}/benchmark_p3

# --------------------------------------------------------------

all:
	clear
	@echo 'Command sequence:'
	@echo '  make init'
	@echo '  source venv/bin/activate'
	@echo '  make build'
	@echo '  deactivate'
	@echo '  make exec'
	@echo '  make clean'

# --------------------------------------------------------------

build: ${COUT} ${COBOUT} ${FOUT} ${POUT} ${PYOUT} ${PIOUT} ${PNOUT}

${COUT}: ${CIN}
	${CC} ${CFLAGS} $^ -o $@

${COBOUT}: ${COBIN}
	${COB} ${COBFLAGS} $^ -o $@

${FOUT}: ${FIN}
	${FOR} ${FFLAGS} $^ -o $@

${POUT}: ${PIN}
	${PAS} ${PFLAGS} $^ -o$@
	@rm ${DISTDIR}/*.o

${PYOUT}: ${PYIN}
	${PY} ${PYFLAGS} $^ $@
	@chmod +x $@

${PIOUT}: ${PIIN}
	${PI} ${PIFLAGS} $^ 1>/dev/null 2>/dev/null
	@mv ${DISTDIR}/benchmark ${PIOUT}
	@rm -r build
	@rm benchmark.spec

${PNOUT}: ${PNIN}
	@pip install nuitka -q
	${PN} ${PNFLAGS} $^ 1>/dev/null 2>/dev/null
	@mv benchmark.dist/benchmark.bin ${PNOUT}
	@rm -r benchmark.build
	@rm -r benchmark.dist

# --------------------------------------------------------------

exec:
	@clear
	@${COUT}
	@${COBOUT} 2>/dev/null
	@${FOUT}
	@${POUT}
	@${PYOUT}
	@${PIOUT}
	@${PNOUT}

# --------------------------------------------------------------

init:
	@mkdir ${DISTDIR}
	@python -m venv venv
	@echo "To activate   the virtual environment: <source venv/bin/activate>"
	@echo "To deactivate the virtual environment: <deactivate>"

# --------------------------------------------------------------

clean:
	@rm -r ${DISTDIR}
	@rm -r venv
