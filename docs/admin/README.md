# Documentación administrador

> Dirigida a un administrador de sistemas técnico que debe mantener, ampliar o recuperar la infraestructura.

## 1. Arquitectura

_Enlazar/resumir [docs/arquitectura](../arquitectura/README.md): diagrama, redes (Default/Personal1/Personal2), hostnames (R-N01, W-N02, F-N03, B-N04, C-N05, C-N06)._

## 2. Inventario de equipos

| Hostname | Rol | IP | Red | SO |
|---|---|---|---|---|
| R-N01 | Router + DHCP + DNS | | | |
| W-N02 | Web Server | | | |
| F-N03 | FTP Server | | | |
| B-N04 | BBDD MySQL | | | |
| C-N05 | Cliente Windows | | | |
| C-N06 | Cliente Linux | | | |

## 3. Procedimiento de instalación (paso a paso real, lo que se ha hecho)

### 3.1 Redes
_Comandos/pasos exactos usados para crear/asignar las redes Default, Personal1, Personal2._

### 3.2 Router R-N01 (NAT, DHCP, DNS)
_Configuración real de `iptables`, `isc-dhcp-server` (`/etc/dhcp/dhcpd.conf`), `bind9` (zonas, `named.conf.local`)._

### 3.3 Web Server W-N02
_Paquetes instalados, configuración del servicio web._

### 3.4 FTP F-N03
_Configuración de `vsftpd.conf`, chroot, usuarios._

### 3.5 BBDD B-N04
_Instalación MySQL, carga del CSV, estructura de tablas (relaciones 1-m, n-m tras segmentación)._

### 3.6 Clientes C-N05 / C-N06
_Configuración de red, verificación DNS/DHCP._

## 4. Credenciales

- Usuario estándar en todos los equipos: `bchecker` / `bchecker121` (con sudo)

## 5. Mantenimiento

- Cómo reiniciar cada servicio
- Cómo actualizar el sistema
- Logs importantes y dónde están

## 6. Plan de prevención de riesgos (RA3)

| Riesgo | Probabilidad | Impacto | Medida preventiva |
|---|---|---|---|
| Caída del router (R-N01) | | | |
| Pérdida de datos en BBDD | | | |
| Acceso no autorizado vía FTP | | | |
| Fallo de disco en una VM | | | |

## 7. Copias de seguridad y recuperación

_Qué se respalda, cada cuánto, cómo restaurar (joc de pruebas: contingencia)._

## 8. Pruebas realizadas (joc de proves)

- Automatización: _..._
- Contingencia: _..._
- Monitorización: _..._
- Seguridad: _..._

## 9. Mejoras aplicadas (bonus)

- [ ] Segmentación BBDD
- [ ] API REST (Flask)
- [ ] Honeypot en DMZ
- [ ] Script de despliegue automatizado
- [ ] SSH con port knocking
- [ ] Certificados TLS + dominio público
