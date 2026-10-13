# Arquitectura de la infraestructura

## Entorno: IsardVDI

Despliegue sobre máquinas virtuales en IsardVDI, con redes virtuales aisladas que simulan las 3 redes requeridas (DMZ, Intranet, NAT/salida a Internet).

## Convenio de nombres

Según el enunciado: *"Quan s'indica els noms dels equips, NCC indica el número d'equip N01, N02, ..."* — es decir, `NCC` es un marcador de posición que se sustituye por el número correlativo de cada equipo.

## Máquinas virtuales

| Hostname | Rol | Red | SO |
|---|---|---|---|
| `R-N01` | Router (3 interfaces: DMZ, Intranet, NAT) + DHCP + DNS | `Default` + `ASIXc2-ITB1` + `ASIXc2-ITB1a` | Linux (Debian/Ubuntu) |
| `W-N02` | Web Server | `ASIXc2-ITB1` (DMZ) | Linux |
| `F-N03` | FTP Server (vsftpd) | `ASIXc2-ITB1` (DMZ) | Linux |
| `B-N04` | BBDD (MySQL) | `ASIXc2-ITB1a` (Intranet) | Linux |
| `C-N05` | Cliente Windows | `ASIXc2-ITB1a` (Intranet) | Windows |
| `C-N06` | Cliente Linux | `ASIXc2-ITB1a` (Intranet) | Linux |

## Redes

Redes reales de IsardVDI utilizadas (compartidas a nivel de grupo/curso, no personales):

- **NAT**: red `Default` — salida a Internet, interfaz del router hacia el exterior
- **DMZ**: red `ASIXc2-ITB1` — servicios expuestos: `W-N02`, `F-N03`
- **Intranet**: red `ASIXc2-ITB1a` — servicios internos: `B-N04`, clientes (`C-N05`, `C-N06`)

> Nota: las redes `PersonalN` de Isard son privadas por usuario (no compartidas entre Piero y Sergi) — comprobado con una prueba de ping entre VMs de ambos. Por eso se usan las redes `ASIXc2-ITB1`/`ASIXc2-ITB1a`, que sí son compartidas a nivel de grupo.

## Rol del router (`R-N01`)

- 3 interfaces de red (una por red)
- **NAT/IP forwarding**: `iptables` para dar salida a Internet a DMZ e Intranet
- **DHCP**: `isc-dhcp-server` — asigna IPs a Intranet (y DMZ si procede)
- **DNS**: `bind9` — resuelve `R-N01`, `R`, `W-N02`, `B-N04`, `F-N03` dentro de las redes internas
- Reglas de firewall entre redes (DMZ no accede directamente a Intranet sin pasar por el router)

## Diagrama (texto)

```
                    Internet (red Isard con salida)
                       │
                  ┌────┴────┐
                  │  R-N01  │  (router: NAT + DHCP + DNS)
                  │ 3 NICs  │
                  └──┬───┬──┘
         DMZ         │   │      Intranet
   192.168.10.0/24    │   │   192.168.20.0/24
         ┌────────────┘   └────────────┐
         │                             │
     ┌───┴────┐  ┌────────┐      ┌─────┴────┐  ┌──────────────┐
     │ W-N02  │  │ F-N03  │      │  B-N04   │  │ C-N05 (Win)  │
     │  Web   │  │  FTP   │      │  MySQL   │  │ C-N06 (Linux)│
     └────────┘  └────────┘      └──────────┘  └──────────────┘
```

## Usuario estándar

Todos los equipos: `bchecker` / `bchecker121`

## Mejoras previstas (bonus)

- Segmentación de BBDD (normalización 1-m, n-m)
- API REST (Flask) sobre la BBDD
- Honeypot en la DMZ
- Script de despliegue automatizado
- SSH con port knocking en el router/servicios expuestos
- (Opcional, si se dispone de una máquina con salida pública real) DNS/dominio público + certificados TLS para FTP/Web
