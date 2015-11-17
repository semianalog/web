HTP_FILES = $(shell find src -type f -name '*.htp')
CHTML_FILES = $(patsubst src/%.htp,%.chtml,$(HTP_FILES))

INCLUDE = include
INCLUDES = $(shell find ${INCLUDE} -type f -name '*.hti')

.PHONY: all

%.chtml: src/%.htp ${INCLUDES}
	$(eval MACRO_MDATE := $(shell date -d @$$(stat -c "%Y" $<)))
	$(eval MACRO_DATE := $(shell date))
	m4 --prefix-builtins -I${INCLUDE} \
		-D "MDATE=${MACRO_MDATE}" \
		-D "DATE=${MACRO_DATE}" \
		-D "__page__=$@" \
		$< > $@

all: ${CHTML_FILES}
