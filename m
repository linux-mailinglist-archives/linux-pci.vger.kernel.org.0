Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655AF4237DF
	for <lists+linux-pci@lfdr.de>; Wed,  6 Oct 2021 08:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhJFGTB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 6 Oct 2021 02:19:01 -0400
Received: from ni.piap.pl ([195.187.100.5]:51728 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229638AbhJFGTB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Oct 2021 02:19:01 -0400
From:   Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
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
Subject: [PATCH v3 REPOST] PCIe: limit Max Read Request Size on i.MX to 512
 bytes
Date:   Wed, 06 Oct 2021 08:17:07 +0200
Message-ID: <m3lf36n0d8.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
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

Signed-off-by: Krzysztof Hałasa <khalasa@piap.pl>
---
While ATM needed only on ARM, this version is compiled in on all
archs.

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 80fc98acf097..225380e75fff 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1148,6 +1148,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		imx6_pcie->vph = NULL;
 	}
 
+	max_pcie_mrrs = 512;
 	platform_set_drvdata(pdev, imx6_pcie);
 
 	ret = imx6_pcie_attach_pd(dev);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index aacf575c15cf..abeb48a64ee3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -112,6 +112,8 @@ enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_PEER2PEER;
 enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_DEFAULT;
 #endif
 
+u16 max_pcie_mrrs = 4096; // no limit
+
 /*
  * The default CLS is used if arch didn't set CLS explicitly and not
  * all pci devices agree on the same value.  Arch can override either
@@ -5816,6 +5818,9 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
 			rq = mps;
 	}
 
+	if (rq > max_pcie_mrrs)
+		rq = max_pcie_mrrs;
+
 	v = (ffs(rq) - 8) << 12;
 
 	ret = pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 06ff1186c1ef..2b95a8204819 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -996,6 +996,7 @@ enum pcie_bus_config_types {
 };
 
 extern enum pcie_bus_config_types pcie_bus_config;
+extern u16 max_pcie_mrrs;
 
 extern struct bus_type pci_bus_type;
 

-- 
Krzysztof "Chris" Hałasa

Sieć Badawcza Łukasiewicz
Przemysłowy Instytut Automatyki i Pomiarów PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
