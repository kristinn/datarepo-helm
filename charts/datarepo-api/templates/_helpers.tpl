{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "datarepo-api.name" -}}
{{- default .Chart.Name .Values.api.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "datarepo-api.fullname" -}}
{{- if .Values.api.fullnameOverride -}}
{{- .Values.api.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.api.nameOverride -}}
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
{{- define "datarepo-api.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "datarepo-api.labels" -}}
helm.sh/chart: {{ include "datarepo-api.chart" . }}
{{ include "datarepo-api.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "datarepo-api.selectorLabels" -}}
app.kubernetes.io/name: {{ include "datarepo-api.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: api
app.kubernetes.io/part-of: terra
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "datarepo-api.serviceAccountName" -}}
{{- if .Values.api.serviceAccount.create -}}
    {{ default (include "datarepo-api.fullname" .) .Values.api.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.api.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Generate existingDatarepoDbSecretKey key name in the secret
*/}}
{{- define "datarepo-api.secretKeyDatarepoDb" -}}
{{ default "datarepo-password" .Values.api.existingDatarepoDbSecretKey }}
{{- end -}}

{{/*
Generate existingStairwayDbSecretKey key name in the secret
*/}}
{{- define "datarepo-api.secretKeyStairwayDb" -}}
{{ default "stairway-password" .Values.api.existingStairwayDbSecretKey }}
{{- end -}}

{{/*
Generate existingServiceAccountSecretKey key name in the secret
*/}}
{{- define "datarepo-api.secretKeyServiceAccount" -}}
{{ default "credential-file-json" .Values.api.existingServiceAccountSecretKey }}
{{- end -}}

{{/*
Generate the secret name for DB
*/}}
{{- define "datarepo-api.secretNameDB" -}}
{{ default (include "datarepo-api.fullname" .) .Values.api.existingSecretDB }}
{{- end -}}

{{/*
Generate the secret name for SA
*/}}
{{- define "datarepo-api.secretNameSA" -}}
{{ default (include "datarepo-api.fullname" .) .Values.api.existingSecretSA }}
{{- end -}}

{{/*
Check if any type of credentials are defined
*/}}
{{- define "datarepo-api.hasCredentials" -}}
{{ or .Values.api.secretsgeneric.datarepoPassword ( or .Values.api.existingSecretDB .Values.api.existingSecretSA .Values.api.existingDatarepoDbSecretKey .Values.api.existingStairwayDbSecretKey .Values.api.existingServiceAccountSecretKey ) -}}
{{- end -}}
