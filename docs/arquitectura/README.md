# Arquitectura de la infraestructura

## Mapeig requisits → AWS

| Component requerit | Implementació AWS |
|---|---|
| Router (`R-NCC`) + xarxes DMZ/Intranet/NAT | 1 VPC amb subnet pública (DMZ) + subnet privada (Intranet); NAT Gateway a la subnet pública fa de NAT; Security Groups fan de firewall del router |
| Web Server (`W-NCC`) | EC2 a la subnet pública |
| BBDD (`B-NCC`, MySQL) | EC2 (o RDS MySQL) a la subnet privada |
| DHCP | Gestionat nativament per AWS (DHCP option sets de la VPC) |
| DNS | Route 53 Private Hosted Zone — resol `R-NCC`, `R`, `W-NCC`, `B-NCC`, `F-NCC` |
| FTP (`F-NCC`) | EC2 amb vsftpd |
| SSH | Habilitat (port 22) a totes les EC2 |
| Clients | 2 EC2 (1 Windows Server, 1 Linux) a la subnet privada |

## Diagrama (text)

```
                    Internet
                       │
                 [Internet GW]
                       │
        ┌──────────────┴───────────────┐
        │         VPC (10.0.0.0/16)     │
        │                               │
        │  Subnet pública (DMZ)         │
        │  10.0.1.0/24                  │
        │   ├── W-NCC (Web Server)      │
        │   ├── F-NCC (FTP)             │
        │   └── NAT Gateway             │
        │              │                │
        │  Subnet privada (Intranet)    │
        │  10.0.2.0/24                  │
        │   ├── B-NCC (BBDD MySQL)      │
        │   ├── Client Windows          │
        │   └── Client Linux            │
        │                               │
        │  Route 53 (DNS privat)        │
        └───────────────────────────────┘
```

## Usuari estàndard

Tots els equips: `bchecker` / `bchecker121`

## Millores previstes (bonus)

- Segmentació de BBDD (normalització 1-m, n-m)
- API REST (Flask) sobre la BBDD
- DNS/domini públic
- Honeypot a la DMZ
- Script de desplegament automatitzat (IaC)
- SSH amb port knocking
- Certificats TLS + domini públic per FTP/Web
