FROM ubuntu:18.04

RUN apt-get -qq update
RUN apt-get install -qq --yes --no-install-recommends sudo locales
RUN locale-gen 'ru_RU' && update-locale
RUN \
    apt-get install -qq --yes --no-install-recommends software-properties-common && \
    add-apt-repository --yes ppa:js-reynaud/kicad-5.1 && \
    apt-get update -qq && \
    apt-get install -qq --yes --no-install-recommends \
                      kicad \
                      kicad-symbols \
                      kicad-templates \
                      kicad-footprints \
#                      kicad-packages3d \
                      kicad-locale-ru && \
    apt-get purge --yes software-properties-common && \
    apt-get autoremove --yes && \
    apt-get autoclean --yes

ADD ./entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
    
