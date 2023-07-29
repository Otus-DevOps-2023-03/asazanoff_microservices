FROM fluent/fluentd:v1.16.2-1.0
USER root
RUN fluent-gem install fluent-plugin-elasticsearch --no-document --verbose
RUN fluent-gem install fluent-plugin-grok-parser --no-document --verbose
USER fluent
ADD fluent.conf /fluentd/etc
