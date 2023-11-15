{{/*
Expand the name of the chart.
*/}}
{{- define "diazoxide-symfony.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "diazoxide-symfony.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "diazoxide-symfony.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "diazoxide-symfony.labels" -}}
helm.sh/chart: {{ include "diazoxide-symfony.chart" . }}
{{ include "diazoxide-symfony.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Common labels PWA
*/}}
{{- define "diazoxide-symfony.labelsPWA" -}}
helm.sh/chart: {{ include "diazoxide-symfony.chart" . }}
{{ include "diazoxide-symfony.selectorLabelsPWA" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "diazoxide-symfony.selectorLabels" -}}
app.kubernetes.io/name: {{ include "diazoxide-symfony.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/part-of: {{ include "diazoxide-symfony.name" . }}
{{- end }}

{{/*
Selector labels PWA
*/}}
{{- define "diazoxide-symfony.selectorLabelsPWA" -}}
app.kubernetes.io/name: {{ include "diazoxide-symfony.name" . }}-pwa
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/part-of: {{ include "diazoxide-symfony.name" . }}
{{- end }}

{{/*
Selector labels Fixtures job
*/}}
{{- define "diazoxide-symfony.selectorLabelsFixtures" -}}
app.kubernetes.io/name: {{ include "diazoxide-symfony.name" . }}-pwa
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "diazoxide-symfony.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "diazoxide-symfony.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Env vars for the php containers
*/}}
{{- define "diazoxide-symfony.env" -}}
- name: API_ENTRYPOINT_HOST
  valueFrom:
    configMapKeyRef:
      name: {{ include "diazoxide-symfony.fullname" . }}
      key: php-host
- name: JWT_PASSPHRASE
  valueFrom:
    secretKeyRef:
      name: {{ include "diazoxide-symfony.fullname" . }}
      key: php-jwt-passphrase
- name: JWT_PUBLIC_KEY
  valueFrom:
    secretKeyRef:
      name: {{ include "diazoxide-symfony.fullname" . }}
      key: php-jwt-public-key
- name: JWT_SECRET_KEY
  valueFrom:
    secretKeyRef:
      name: {{ include "diazoxide-symfony.fullname" . }}
      key: php-jwt-secret-key
- name: TRUSTED_HOSTS
  valueFrom:
    configMapKeyRef:
      name: {{ include "diazoxide-symfony.fullname" . }}
      key: php-trusted-hosts
- name: TRUSTED_PROXIES
  valueFrom:
    configMapKeyRef:
      name: {{ include "diazoxide-symfony.fullname" . }}
      key: php-trusted-proxies
- name: APP_ENV
  valueFrom:
    configMapKeyRef:
      name: {{ include "diazoxide-symfony.fullname" . }}
      key: php-app-env
- name: APP_DEBUG
  valueFrom:
    configMapKeyRef:
      name: {{ include "diazoxide-symfony.fullname" . }}
      key: php-app-debug
- name: APP_SECRET
  valueFrom:
    secretKeyRef:
      name: {{ include "diazoxide-symfony.fullname" . }}
      key: php-app-secret
- name: CORS_ALLOW_ORIGIN
  valueFrom:
    configMapKeyRef:
      name: {{ include "diazoxide-symfony.fullname" . }}
      key: php-cors-allow-origin
- name: DATABASE_URL
  valueFrom:
    secretKeyRef:
      name: {{ include "diazoxide-symfony.fullname" . }}
      key: database-url
- name: REDIS_URL
  valueFrom:
    secretKeyRef:
      name: {{ include "diazoxide-symfony.fullname" . }}
      key: redis-url
- name: MERCURE_URL
  valueFrom:
    configMapKeyRef:
      name: {{ include "diazoxide-symfony.fullname" . }}
      key: mercure-url
- name: MERCURE_PUBLIC_URL
  valueFrom:
    configMapKeyRef:
      name: {{ include "diazoxide-symfony.fullname" . }}
      key: mercure-public-url
- name: MERCURE_JWT_SECRET
  valueFrom:
    secretKeyRef:
      name: {{ include "diazoxide-symfony.fullname" . }}
      key: mercure-jwt-secret
- name: MERCURE_PUBLISHER_JWT_KEY
  valueFrom:
    secretKeyRef:
      name: {{ include "diazoxide-symfony.fullname" . }}
      key: mercure-jwt-secret
- name: MERCURE_SUBSCRIBER_JWT_KEY
  valueFrom:
    secretKeyRef:
      name: {{ include "diazoxide-symfony.fullname" . }}
      key: mercure-jwt-secret
{{- range $key, $value := .Values.frankenphp.secrets }}
- name: {{ $key }}
  valueFrom:
    secretKeyRef:
      name: {{ include "diazoxide-symfony.fullname" $ }}
      key: {{ $key }}
{{- end }}
{{- range $key, $value := .Values.frankenphp.env }}
- name: {{ $key }}
  valueFrom:
    configMapKeyRef:
      name: {{ include "diazoxide-symfony.fullname" $ }}
      key: {{ $key }}
{{- end }}
{{- end }}
