{{- if static }}
{{- end }}
syntax = "proto3";

package api.v1;
option go_package = "{{ .manifest.Arguments.org }}/{{ .manifest.Name }}/api/api";

service {{ title (mustRegexReplaceAll "([^A-Za-z])+" .manifest.Name "") }} {}
