{{- if writeIf "type" "grpc" }}{{- end }}
package grpc

import (
	"context"
	"fmt"

	"github.com/google/uuid"
	"github.com/pkg/errors"
	"github.com/sirupsen/logrus"

	apiv1 "{{ .manifest.Arguments.org }}/{{ .manifest.Name }}/api/v1"
	"{{ .manifest.Arguments.org }}/{{ .manifest.Name }}/internal/ent"

	///StartBlock(imports)
	{{- if .imports }}
{{ .imports }}
	{{- end }}
	///EndBlock(imports)	
)

///StartBlock(globalVars)
{{- if .globalVars }}
{{ .globalVars }}
{{- end }}
///EndBlock(globalVars)

type GRPCServiceHandler struct {
	log logrus.FieldLogger

	///StartBlock(grpcConfig)
	{{- if .grpcConfig }}
{{ .grpcConfig }}
	{{- end }}
	///EndBlock(grpcConfig)
}

///StartBlock(global)
{{- if .global }}
{{ .global }}
{{- end }}
///EndBlock(global)

func NewServiceHandler(ctx context.Context, log logrus.FieldLogger) (*GRPCServiceHandler, error) {
	///StartBlock(grpcInit)
	{{- if .grpcInit }}
{{ .grpcInit }}
	{{- end }}
	///EndBlock(grpcInit)

	return &GRPCServiceHandler{
		log,
		///StartBlock(grpcConfigInit)
		{{- if .grpcConfigInit }}
{{ .grpcConfigInit }}
		{{- end }}
		///EndBlock(grpcConfigInit)
	}, nil
}

///StartBlock(grpcHandlers)
{{- if .grpcHandlers }}
{{ .grpcHandlers }}
{{- end }}
///EndBlock(grpcHandlers)
