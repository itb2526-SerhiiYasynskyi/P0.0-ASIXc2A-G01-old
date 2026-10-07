# Arquitectura de la infraestructura

## Entorn: IsardVDI

Desplegament sobre màquines virtuals a IsardVDI, amb xarxes virtuals aïllades que simulen les 3 xarxes requerides (DMZ, Intranet, NAT/sortida a Internet).

## Màquines virtuals

| Hostname | Rol | Xarxa | SO |
|---|---|---|---|
| `R-NCC` | Router (3 interfícies: DMZ, Intranet, NAT) + DHCP + DNS | DMZ + Intranet + NAT | Linux (Debian/Ubuntu) |
| `W-NCC` | Web Server | DMZ | Linux |
| `F-NCC` | FTP Server (vsftpd) | DMZ | Linux |
| `B-NCC` | BBDD (MySQL) | Intranet | Linux |
| Client Windows | Client | Intranet | Windows |
| Client Linux | Client | Intranet | Linux |

## Xarxes

- **DMZ** (ex: `192.168.10.0/24`): serveis exposats — `W-NCC`, `F-NCC`
- **Intranet** (ex: `192.168.20.0/24`): serveis interns — `B-NCC`, clients
- **NAT** (ex: `192.168.1.0/24` o xarxa d'Isard amb sortida a Internet): interfície del router cap a l'exterior

## Rol del router (`R-NCC`)

- 3 interfícies de xarxa (una per xarxa)
- **NAT/IP forwarding**: `iptables` per donar sortida a Internet a DMZ i Intranet
- **DHCP**: `isc-dhcp-server` — assigna IPs a Intranet (i DMZ si cal)
- **DNS**: `bind9` — resol `R-NCC`, `R`, `W-NCC`, `B-NCC`, `F-NCC` dins de les xarxes internes
- Regles de firewall entre xarxes (DMZ no accedeix directament a Intranet sense passar pel router)

## Diagrama (text)

```
                    Internet (xarxa Isard amb sortida)
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
     │ W-NCC  │  │ F-NCC  │      │  B-NCC   │  │ Client Win/  │
     │  Web   │  │  FTP   │      │  MySQL   │  │ Client Linux │
     └────────┘  └────────┘      └──────────┘  └──────────────┘
```

## Usuari estàndard

Tots els equips: `bchecker` / `bchecker121`

## Millores previstes (bonus)

- Segmentació de BBDD (normalització 1-m, n-m)
- API REST (Flask) sobre la BBDD
- Honeypot a la DMZ
- Script de desplegament automatitzat
- SSH amb port knocking al router/serveis exposats
- (Opcional, si es disposa d'una màquina amb sortida pública real) DNS/domini públic + certificats TLS per FTP/Web
