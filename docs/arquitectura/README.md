# Arquitectura de la infraestructura

## Entorno: IsardVDI

Despliegue sobre máquinas virtuales en IsardVDI, con redes virtuales aisladas que simulan las 3 redes requeridas (DMZ, Intranet, NAT/salida a Internet).

## Máquinas virtuales

| Hostname | Rol | Red | SO |
|---|---|---|---|
| `R-NCC` | Router (3 interfaces: DMZ, Intranet, NAT) + DHCP + DNS | DMZ + Intranet + NAT | Linux (Debian/Ubuntu) |
| `W-NCC` | Web Server | DMZ | Linux |
| `F-NCC` | FTP Server (vsftpd) | DMZ | Linux |
| `B-NCC` | BBDD (MySQL) | Intranet | Linux |
| Cliente Windows | Cliente | Intranet | Windows |
| Cliente Linux | Cliente | Intranet | Linux |

## Redes

- **DMZ** (ej: `192.168.10.0/24`): servicios expuestos — `W-NCC`, `F-NCC`
- **Intranet** (ej: `192.168.20.0/24`): servicios internos — `B-NCC`, clientes
- **NAT** (ej: `192.168.1.0/24` o red de Isard con salida a Internet): interfaz del router hacia el exterior

## Rol del router (`R-NCC`)

- 3 interfaces de red (una por red)
- **NAT/IP forwarding**: `iptables` para dar salida a Internet a DMZ e Intranet
- **DHCP**: `isc-dhcp-server` — asigna IPs a Intranet (y DMZ si procede)
- **DNS**: `bind9` — resuelve `R-NCC`, `R`, `W-NCC`, `B-NCC`, `F-NCC` dentro de las redes internas
- Reglas de firewall entre redes (DMZ no accede directamente a Intranet sin pasar por el router)

## Diagrama (texto)

```
                    Internet (red Isard con salida)
                       │
                  ┌────┴────┐
                  │  R-NCC  │  (router: NAT + DHCP + DNS)
                  │ 3 NICs  │
                  └──┬───┬──┘
         DMZ         │   │      Intranet
   192.168.10.0/24    │   │   192.168.20.0/24
         ┌────────────┘   └────────────┐
         │                             │
     ┌───┴────┐  ┌────────┐      ┌─────┴────┐  ┌──────────────┐
     │ W-NCC  │  │ F-NCC  │      │  B-NCC   │  │ Cliente Win/ │
     │  Web   │  │  FTP   │      │  MySQL   │  │ Cliente Linux│
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
