#lang racket
(require racket/gui/base)
(require "../Conexion.rtk")
(require "../utilidades/CalcularCalendarioDeCitas.rkt")
(require db)
(require racket/date)

(provide listarTodasFechas)
(provide listarTodasEtapas)
(provide listarDatosMenor)
(provide listarTodasFechasReales)
(provide listarTodasEstados)
(provide listarTodasVacunas)
(provide listarDatosMenor)

(define (listarTodasFechas regCivil) (query-list conn listarTodasFechasQuery regCivil))
(define (listarTodasEtapas regCivil)(query-list conn listarTodasEtapasQuery regCivil))
(define (listarTodasFechasReales regCivil)(query-list conn listarTodasFechasRealesQuery regCivil))
(define (listarTodasEstados regCivil)(query-list conn listarTodasEstadosQuery regCivil))
(define (listarTodasVacunas regCivil)(query-list conn listarTodasVacunasQuery regCivil))
(define (listarDatosMenor regCivil)(vector->list (query-row conn listarMenorQuery regCivil)))
; (define getComunasSQL (query-list conn "SELECT com_nombre FROM COMUNAS"))
; (define getFrutasSQL (query-list conn "SELECT fru_nombre FROM FRUTAS"))
; (define getNutrientesSQL (query-list conn "SELECT nut_nombre FROM NUTRIENTES"))

(define listarTodasFechasQuery (prepare conn "SELECT DATE_FORMAT(pacienteetapa.FECHA,'%d %m %Y') FROM pacienteetapa INNER JOIN paciente ON pacienteetapa.IDREGISTROCIVIL = paciente.IDREGISTROCIVIL INNER JOIN etapa ON etapa.IDETAPA = pacienteetapa.IDETAPA INNER JOIN etapavacuna ON etapa.IDETAPA = etapavacuna.IDETAPA INNER JOIN vacuna ON vacuna.IDVACUNA = etapa.IDETAPA
WHERE paciente.IDREGISTROCIVIL = ?
ORDER BY FECHA"))
(define listarTodasEtapasQuery (prepare conn "SELECT etapa.nombre FROM pacienteetapa INNER JOIN paciente ON pacienteetapa.IDREGISTROCIVIL = paciente.IDREGISTROCIVIL INNER JOIN etapa ON etapa.IDETAPA = pacienteetapa.IDETAPA INNER JOIN etapavacuna ON etapa.IDETAPA = etapavacuna.IDETAPA INNER JOIN vacuna ON vacuna.IDVACUNA = etapa.IDETAPA
WHERE paciente.IDREGISTROCIVIL = ?
ORDER BY FECHA"))
(define listarTodasFechasRealesQuery (prepare conn "SELECT DATE_FORMAT(pacienteetapa.FECHAVACUNACION, '%d %m %Y') FROM pacienteetapa INNER JOIN paciente ON pacienteetapa.IDREGISTROCIVIL = paciente.IDREGISTROCIVIL INNER JOIN etapa ON etapa.IDETAPA = pacienteetapa.IDETAPA INNER JOIN etapavacuna ON etapa.IDETAPA = etapavacuna.IDETAPA INNER JOIN vacuna ON vacuna.IDVACUNA = etapa.IDETAPA
WHERE paciente.IDREGISTROCIVIL = ?
ORDER BY FECHA"))
(define listarTodasEstadosQuery (prepare conn "SELECT pacienteetapa.ESTADO FROM pacienteetapa INNER JOIN paciente ON pacienteetapa.IDREGISTROCIVIL = paciente.IDREGISTROCIVIL INNER JOIN etapa ON etapa.IDETAPA = pacienteetapa.IDETAPA INNER JOIN etapavacuna ON etapa.IDETAPA = etapavacuna.IDETAPA INNER JOIN vacuna ON vacuna.IDVACUNA = etapa.IDETAPA
WHERE paciente.IDREGISTROCIVIL = ?
ORDER BY FECHA" ))
(define listarTodasVacunasQuery (prepare conn "SELECT vacuna.NOMBRE FROM pacienteetapa INNER JOIN paciente ON pacienteetapa.IDREGISTROCIVIL = paciente.IDREGISTROCIVIL INNER JOIN etapa ON etapa.IDETAPA = pacienteetapa.IDETAPA INNER JOIN etapavacuna ON etapa.IDETAPA = etapavacuna.IDETAPA INNER JOIN vacuna ON vacuna.IDVACUNA = etapa.IDETAPA
WHERE paciente.IDREGISTROCIVIL = ?
ORDER BY FECHA"))

; FORMAT(VALUE,'yyyy-MM-dd')

;(define listarTodasEtapasQuery (prepare conn "SELECT etapa.NOMBRE from pacienteetapa inner join etapa ON pacienteetapa.IDETAPA = etapa.IDETAPA WHERE pacienteetapa.IDREGISTROCIVIL = ?  ORDER BY etapa.IDETAPA"))
(define listarMenorQuery (prepare conn "SELECT IDREGISTROCIVIL, NOMBRESAPELLIDOS, DATE_FORMAT(FECHANACIMIENTO, '%Y-%m-%d'), GENERO, NOMBRECONTACTO, TELEFONOCONTACTO, DIRECCION, GENERO FROM bdvacunacion.paciente WHERE IDREGISTROCIVIL = ?  LIMIT 1"))

(listarDatosMenor 123)
(first (listarDatosMenor 123))
(second (listarDatosMenor 123))
(third (listarDatosMenor 123))
(fourth (listarDatosMenor 123))
(fifth (listarDatosMenor 123))
(sixth (listarDatosMenor 123))
(seventh (listarDatosMenor 123))
(eighth (listarDatosMenor 123))
; (listarTodasFechas 123)

; (filter-map (lambda (x)  (date->string x) (listarTodasFechas 123)))

; MOSTRAR LAS FECHAS DE PACIENTEETAPA ORDENADA POR ID_ETAPA
; SELECT pacienteetapa.FECHA from pacienteetapa inner join etapa ON pacienteetapa.IDETAPA = etapa.IDETAPA WHERE pacienteetapa.IDREGISTROCIVIL = 123 ORDER BY etapa.IDETAPA

; MOSTRAR LOS NOMBRES DE LA ETAPA ORDENADO POR ID_ETAPA
; SELECT etapa.NOMBRE from pacienteetapa inner join etapa ON pacienteetapa.IDETAPA = etapa.IDETAPA WHERE pacienteetapa.IDREGISTROCIVIL = 123 ORDER BY etapa.IDETAPA

; Muestra l
; SELECT pacienteetapa.FECHA from pacienteetapa inner join etapa ON pacienteetapa.IDETAPA = etapa.IDETAPA WHERE pacienteetapa.IDREGISTROCIVIL = 123 AND pacienteetapa.ESTADO != 'no aplicada' ORDER BY etapa.IDETAPA
