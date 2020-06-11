{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "oidc-proxy.name" -}}
{{- default .Chart.Name .Values.oidc.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "oidc-proxy.fullname" -}}
{{- if .Values.oidc.fullnameOverride -}}
{{- .Values.oidc.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.oidc.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "oidc-proxy.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "oidc-proxy.labels" -}}
helm.sh/chart: {{ include "oidc-proxy.chart" . }}
{{ include "oidc-proxy.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "oidc-proxy.selectorLabels" -}}
app.kubernetes.io/name: {{ include "oidc-proxy.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: frontend
app.kubernetes.io/part-of: terra
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "oidc-proxy.serviceAccountName" -}}
{{- if .Values.oidc.serviceAccount.create -}}
    {{ default (include "oidc-proxy.fullname" .) .Values.oidc.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.oidc.serviceAccount.name }}
{{- end -}}
{{- end -}}


{{/*
Generate the secret name
*/}}
{{- define "oidc-proxy.secretName" -}}
{{ default (include "oidc-proxy.fullname" .) .Values.oidc.existingTlsSecret }}
{{- end -}}

{{/*
Check if any type of credentials are defined
*/}}
{{- define "oidc-proxy.hasCredentials" -}}
{{ .Values.oidc.existingTlsSecret -}}
{{- end -}}
