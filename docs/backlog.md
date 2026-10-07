# Backlog del proyecto P0.0-ASIXc2A-G08

Lista completa y definitiva de tareas (priorizadas), con estimación en minutos.

1. Crear redes virtuales en IsardVDI (DMZ, Intranet, NAT) — 20m
2. Instalar máquina R-N01 (router) — 15m
3. Instalar máquina W-N02 (Web Server) — 15m
4. Instalar máquina F-N03 (FTP Server) — 15m
5. Instalar máquina B-N04 (BBDD MySQL) — 15m
6. Instalar cliente C-N05 (Windows) — 15m
7. Instalar cliente C-N06 (Linux) — 15m
8. Configurar SSH en todos los equipos — 12m
9. Configurar NAT/IP forwarding en R-N01 (iptables) — 20m
10. Configurar DHCP (isc-dhcp-server) en R-N01 — 18m
11. Configurar DNS (bind9) en R-N01 — 18m
12. Verificar conectividad entre redes (DMZ-Router-Intranet) — 12m
13. Definir plan de prevención de riesgos del proyecto — 15m
14. Validar diagrama de arquitectura final — 10m
15. Desplegar Web Server en W-N02 — 18m
16. Desplegar FTP (vsftpd) en F-N03 con chroot — 18m
17. Instalar y configurar MySQL en B-N04 — 18m
18. Cargar CSV de equipamientos educativos de Barcelona en la BBDD — 15m
19. Configurar clientes C-N05/C-N06 (red, DNS, DHCP) — 15m
20. Desarrollar mini-aplicación que muestre el contenido de las tablas — 25m
21. Segmentación de BBDD (normalizar relaciones 1-m y n-m) — 20m
22. API REST (Flask) sobre la BBDD — 25m
23. Joc de pruebas: automatización — 15m
24. Joc de pruebas: contingencia (backup/restore) — 15m
25. Joc de pruebas: monitorización — 15m
26. Joc de pruebas: seguridad — 15m
27. Implementar Honeypot en la DMZ — 20m
28. SSH con port knocking — 15m
29. Script de despliegue automatizado — 20m
30. Certificados TLS + dominio público para FTP/Web — 18m
31. Completar documentación cliente — 18m
32. Completar documentación administrador — 18m
33. Preparar y ensayar la defensa del proyecto — 15m

## Notas

- Usuario único en todos los equipos: `bchecker` / `bchecker121` (creado durante la instalación del SO, con sudo).
- Redes Isard usadas: `Default` (NAT/Internet), `Personal1` (DMZ), `Personal2` (Intranet).
- Entorno: IsardVDI (no AWS).
