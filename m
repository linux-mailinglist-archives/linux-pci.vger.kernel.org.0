Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBEC63EB2F8
	for <lists+linux-pci@lfdr.de>; Fri, 13 Aug 2021 10:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239327AbhHMIwi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 04:52:38 -0400
Received: from ni.piap.pl ([195.187.100.5]:54992 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239854AbhHMIwh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Aug 2021 04:52:37 -0400
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        by ni.piap.pl (Postfix) with ESMTPSA id E362BC36953E;
        Fri, 13 Aug 2021 10:52:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl E362BC36953E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1628844725; bh=TX5rCDLJb2nCnbUvL6MqCko4ydjGBRf/AGuQnXJXwQw=;
        h=From:To:Cc:Subject:Date:From;
        b=auHzP2qoHCXicZuNoV7aRZIYhu+lJcyG57NtMcO7DbymfND5mLQb3YlY7Vn4FkRZy
         TzGD2tlK3Xu70jI5o3GAMskwa0tGfF0eqvNe1iUHMsrP/RiXDnaFyU8tuZxY9ASHx7
         rI8lxwG9Eg7iO4n+MgTN/Xyl2arEK6RQtMZJo4bs=
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Artem Lapkin <email2tema@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCIe: limit Max Read Request Size on i.MX to 512 bytes
Sender: khalasa@piap.pl
Date:   Fri, 13 Aug 2021 10:52:04 +0200
Message-ID: <m37dgp20cr.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 165553 [Aug 13 2021]
X-KLMS-AntiSpam-Version: 5.9.20.0
X-KLMS-AntiSpam-Envelope-From: khalasa@piap.pl
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=pass header.d=piap.pl
X-KLMS-AntiSpam-Info: LuaCore: 454 454 39c6e442fd417993330528e7f9d13ac1bf7fdf8c, {Tracking_marketers, three}, {Tracking_from_domain_doesnt_match_to}, t19.piap.pl:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;piap.pl:7.1.1;127.0.0.199:7.1.2
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2021/08/13 08:21:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2021/08/13 05:50:00 #17026350
X-KLMS-AntiVirus-Status: Clean, skipped
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DWC PCIe controller imposes limits on the Read Request Size that it can
handle. For i.MX6 family it's fixed at 512 bytes by default.

If a memory read larger than the limit is requested, the CPU responds
with Completer Abort (CA) (on i.MX6 Unsupported Request (UR) is returned
instead due to a design error).

The i.MX6 documentation states that the limit can be changed by writing
to the PCIE_PL_MRCCR0 register, however there is a fixed (and
undocumented) maximum (CX_REMOTE_RD_REQ_SIZE constant). Tests indicate
that values larger than 512 bytes don't work, though.

This patch makes the RTL8111 work on i.MX6.

Signed-off-by: Krzysztof Ha=C5=82asa <khalasa@piap.pl>

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 0c473d75e625..a11ec93a8cd0 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -34,6 +34,9 @@ config PCI_DOMAINS_GENERIC
 config PCI_SYSCALL
 	bool
=20
+config NEED_PCIE_MAX_MRRS
+	bool
+
 source "drivers/pci/pcie/Kconfig"
=20
 config PCI_MSI
diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dw=
c/Kconfig
index 423d35872ce4..b59a4c91cb3b 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -98,6 +98,7 @@ config PCI_IMX6
 	depends on ARCH_MXC || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
+	select NEED_PCIE_MAX_MRRS
=20
 config PCIE_SPEAR13XX
 	bool "STMicroelectronics SPEAr PCIe controller"
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller=
/dwc/pci-imx6.c
index 80fc98acf097..7a83f677a632 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1148,6 +1148,7 @@ static int imx6_pcie_probe(struct platform_device *pd=
ev)
 		imx6_pcie->vph =3D NULL;
 	}
=20
+	max_pcie_mrrs =3D 512;
 	platform_set_drvdata(pdev, imx6_pcie);
=20
 	ret =3D imx6_pcie_attach_pd(dev);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index aacf575c15cf..8ed8d2e75f4c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -112,6 +112,10 @@ enum pcie_bus_config_types pcie_bus_config =3D PCIE_BU=
S_PEER2PEER;
 enum pcie_bus_config_types pcie_bus_config =3D PCIE_BUS_DEFAULT;
 #endif
=20
+#ifdef CONFIG_NEED_PCIE_MAX_MRRS
+u16 max_pcie_mrrs =3D 4096; // no limit
+#endif
+
 /*
  * The default CLS is used if arch didn't set CLS explicitly and not
  * all pci devices agree on the same value.  Arch can override either
@@ -5816,6 +5820,11 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
 			rq =3D mps;
 	}
=20
+#ifdef CONFIG_NEED_PCIE_MAX_MRRS
+	if (rq > max_pcie_mrrs)
+		rq =3D max_pcie_mrrs;
+#endif
+
 	v =3D (ffs(rq) - 8) << 12;
=20
 	ret =3D pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 540b377ca8f6..7368be024c31 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -994,6 +994,7 @@ enum pcie_bus_config_types {
 };
=20
 extern enum pcie_bus_config_types pcie_bus_config;
+extern u16 max_pcie_mrrs;
=20
 extern struct bus_type pci_bus_type;
=20

--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
