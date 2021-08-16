Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A89BA3ED30B
	for <lists+linux-pci@lfdr.de>; Mon, 16 Aug 2021 13:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236141AbhHPL2T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Aug 2021 07:28:19 -0400
Received: from ni.piap.pl ([195.187.100.5]:47088 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236079AbhHPL2L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Aug 2021 07:28:11 -0400
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        by ni.piap.pl (Postfix) with ESMTPSA id 9DD51C3F2A57;
        Mon, 16 Aug 2021 13:27:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 9DD51C3F2A57
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1629113258; bh=hjL+F/1mtGW2uhXsazKdolAjkVr/E/glS9niSfRINNU=;
        h=From:To:Cc:Subject:Date:From;
        b=hQMinBl917UkNopYsDD3yIfyKeNjaq2ombx9rikMOP8G8mxCeJiYHPHXGEwKtPWnk
         FUpwwHABho4WkWJ1RQgQ6lyT0qq7UPZUDdQqtGAQFNxpFtKcyIbuQCTQT8ydHArs4J
         loLFmIVhqJYvacjrLfKt//fIarBTJZs/i6Gt3DFo=
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Artem Lapkin <email2tema@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCIe: limit Max Read Request Size on i.MX to 512 bytes
Sender: khalasa@piap.pl
Date:   Mon, 16 Aug 2021 13:27:38 +0200
Message-ID: <m3k0klzl1x.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 165577 [Aug 16 2021]
X-KLMS-AntiSpam-Version: 5.9.20.0
X-KLMS-AntiSpam-Envelope-From: khalasa@piap.pl
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=pass header.d=piap.pl
X-KLMS-AntiSpam-Info: LuaCore: 454 454 39c6e442fd417993330528e7f9d13ac1bf7fdf8c, {Tracking_marketers, three}, {Tracking_from_domain_doesnt_match_to}, t19.piap.pl:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;piap.pl:7.1.1
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2021/08/16 10:32:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2021/08/15 23:54:00 #17042267
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
---
This version drops CONFIG_NEED_PCIE_MAX_MRRS.

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller=
/dwc/pci-imx6.c
index 80fc98acf097..225380e75fff 100644
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
index aacf575c15cf..44815af4ad85 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -112,6 +112,10 @@ enum pcie_bus_config_types pcie_bus_config =3D PCIE_BU=
S_PEER2PEER;
 enum pcie_bus_config_types pcie_bus_config =3D PCIE_BUS_DEFAULT;
 #endif
=20
+#ifdef CONFIG_ARM
+u16 max_pcie_mrrs =3D 4096; // no limit - needed mostly for DWC PCIe
+#endif
+
 /*
  * The default CLS is used if arch didn't set CLS explicitly and not
  * all pci devices agree on the same value.  Arch can override either
@@ -5816,6 +5820,11 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
 			rq =3D mps;
 	}
=20
+#ifdef CONFIG_ARM
+	if (rq > max_pcie_mrrs)
+		rq =3D max_pcie_mrrs;
+#endif
+
 	v =3D (ffs(rq) - 8) << 12;
=20
 	ret =3D pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 06ff1186c1ef..1f21ec662b8e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -996,6 +996,7 @@ enum pcie_bus_config_types {
 };
=20
 extern enum pcie_bus_config_types pcie_bus_config;
+extern u16 max_pcie_mrrs;	// currently ARM only
=20
 extern struct bus_type pci_bus_type;
=20

--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
