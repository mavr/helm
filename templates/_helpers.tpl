# Labels

{{- define "selector.labels" }}
app: {{ .Release.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "common.labels" }}
{{- template "selector.labels" . }}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
{{- range $key, $val := .Values.labelsAdditional }}
{{ $key }}: {{ $val | quote }}
{{- end }}
{{- end }}

# Affinity

{{- define "selector.affinity" }}
- key: app
  operator: In
  values:
  - {{ .Release.Name }}
- key: app.kubernetes.io/instance
  operator: In
  values:
  - {{ .Release.Name }}
{{- end }}

# Image

{{/* Get "image" field value */}}
{{- define "chart.image" -}}
{{- printf "%s/%s:%s" .Values.image.repositoryPrefix .Values.image.imageName .Values.image.tag -}}
{{- end -}}

# Utils

{{/* DateTime now */}}
{{- define "chart.now" -}}
{{ now.UTC }}
{{- end -}}