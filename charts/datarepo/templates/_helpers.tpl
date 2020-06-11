{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "datarepo-api.name" -}}
{{- default .Chart.Name .Values.datarepo-api.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "datarepo-api.fullname" -}}
{{- if .Values.datarepo-api.fullnameOverride -}}
{{- .Values.datarepo-api.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.datarepo-api.nameOverride -}}
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
{{- if .Values.datarepo-api.serviceAccount.create -}}
    {{ default (include "datarepo-api.fullname" .) .Values.datarepo-api.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.datarepo-api.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Generate existingDatarepoDbSecretKey key name in the secret
*/}}
{{- define "datarepo-api.secretKeyDatarepoDb" -}}
{{ default "datarepo-password" .Values.datarepo-api.existingDatarepoDbSecretKey }}
{{- end -}}

{{/*
Generate existingStairwayDbSecretKey key name in the secret
*/}}
{{- define "datarepo-api.secretKeyStairwayDb" -}}
{{ default "stairway-password" .Values.datarepo-api.existingStairwayDbSecretKey }}
{{- end -}}

{{/*
Generate existingServiceAccountSecretKey key name in the secret
*/}}
{{- define "datarepo-api.secretKeyServiceAccount" -}}
{{ default "credential-file-json" .Values.datarepo-api.existingServiceAccountSecretKey }}
{{- end -}}

{{/*
Generate the secret name for DB
*/}}
{{- define "datarepo-api.secretNameDB" -}}
{{ default (include "datarepo-api.fullname" .) .Values.datarepo-api.existingSecretDB }}
{{- end -}}

{{/*
Generate the secret name for SA
*/}}
{{- define "datarepo-api.secretNameSA" -}}
{{ default (include "datarepo-api.fullname" .) .Values.datarepo-api.existingSecretSA }}
{{- end -}}

{{/*
Check if any type of credentials are defined
*/}}
{{- define "datarepo-api.hasCredentials" -}}
{{ or .Values.datarepo-api.secretsgeneric.datarepoPassword ( or .Values.datarepo-api.existingSecretDB .Values.datarepo-api.existingSecretSA .Values.datarepo-api.existingDatarepoDbSecretKey .Values.datarepo-api.existingStairwayDbSecretKey .Values.datarepo-api.existingServiceAccountSecretKey ) -}}
{{- end -}}


{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "datarepo-ui.name" -}}
{{- default .Chart.Name .Values.datarepo-ui.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "datarepo-ui.fullname" -}}
{{- if .Values.datarepo-ui.fullnameOverride -}}
{{- .Values.datarepo-ui.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.datarepo-ui.nameOverride -}}
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
{{- define "datarepo-ui.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "datarepo-ui.labels" -}}
helm.sh/chart: {{ include "datarepo-ui.chart" . }}
{{ include "datarepo-ui.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "datarepo-ui.selectorLabels" -}}
app.kubernetes.io/name: {{ include "datarepo-ui.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: ui
app.kubernetes.io/part-of: terra
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "datarepo-ui.serviceAccountName" -}}
{{- if .Values.datarepo-ui.serviceAccount.create -}}
    {{ default (include "datarepo-ui.fullname" .) .Values.datarepo-ui.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.datarepo-ui.serviceAccount.name }}
{{- end -}}
{{- end -}}



{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "gcloud-sqlproxy.name" -}}
{{- default .Chart.Name .Values.gcloud-sqlproxy.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "gcloud-sqlproxy.fullname" -}}
{{- if .Values.gcloud-sqlproxy.fullnameOverride -}}
{{- .Values.gcloud-sqlproxy.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.gcloud-sqlproxy.nameOverride -}}
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
{{- define "gcloud-sqlproxy.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Generate gcp service account name
*/}}
{{- define "gcloud-sqlproxy.serviceAccountName" -}}
{{ default (include "gcloud-sqlproxy.fullname" .) .Values.gcloud-sqlproxy.serviceAccountName }}
{{- end -}}

{{/*
Generate key name in the secret
*/}}
{{- define "gcloud-sqlproxy.secretKey" -}}
{{ default "credentials.json" .Values.gcloud-sqlproxy.existingSecretKey }}
{{- end -}}

{{/*
Generate the secret name
*/}}
{{- define "gcloud-sqlproxy.secretName" -}}
{{ default (include "gcloud-sqlproxy.fullname" .) .Values.gcloud-sqlproxy.existingSecret }}
{{- end -}}

{{/*
Check if any type of credentials are defined
*/}}
{{- define "gcloud-sqlproxy.hasCredentials" -}}
{{ or .Values.gcloud-sqlproxy.serviceAccountKey ( or .Values.gcloud-sqlproxy.existingSecret .Values.gcloud-sqlproxy.usingGCPController ) -}}
{{- end -}}


{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "oidc-proxy.name" -}}
{{- default .Chart.Name .Values.oidc-proxy.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "oidc-proxy.fullname" -}}
{{- if .Values.oidc-proxy.fullnameOverride -}}
{{- .Values.oidc-proxy.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.oidc-proxy.nameOverride -}}
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
{{- if .Values.oidc-proxy.serviceAccount.create -}}
    {{ default (include "oidc-proxy.fullname" .) .Values.oidc-proxy.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.oidc-proxy.serviceAccount.name }}
{{- end -}}
{{- end -}}


{{/*
Generate the secret name
*/}}
{{- define "oidc-proxy.secretName" -}}
{{ default (include "oidc-proxy.fullname" .) .Values.oidc-proxy.existingTlsSecret }}
{{- end -}}

{{/*
Check if any type of credentials are defined
*/}}
{{- define "oidc-proxy.hasCredentials" -}}
{{ .Values.oidc-proxy.existingTlsSecret -}}
{{- end -}}
