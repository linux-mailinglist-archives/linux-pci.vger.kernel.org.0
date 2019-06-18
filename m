Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77D084A951
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2019 20:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbfFRSDo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jun 2019 14:03:44 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8425 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730299AbfFRSDo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jun 2019 14:03:44 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d09277e0000>; Tue, 18 Jun 2019 11:03:42 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Jun 2019 11:03:42 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Jun 2019 11:03:42 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Jun
 2019 18:03:41 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Jun
 2019 18:03:41 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 18 Jun 2019 18:03:38 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V6 26/27] PCI: tegra: Add support for GPIO based PERST#
Date:   Tue, 18 Jun 2019 23:32:05 +0530
Message-ID: <20190618180206.4908-27-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190618180206.4908-1-mmaddireddy@nvidia.com>
References: <20190618180206.4908-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560881022; bh=ma0Y6uxby48nHCc9qqg2Mg0pI1WTsVY8jFrxhMiN90c=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=ZoEEvbgjsYmwZXSHSGU9K0fJbRyb0vk2mCuk+lkRHKEKXH0nPRRgYbfTAMFpSyaXM
         Kk69jwr1pExxH+FD6JWuk+OUj6iknfNmoMgAmIu2HbRj8f7E8SslZ77c3/OiyJMxcF
         BcOALInIwNn9PQEQy/y8GWDp5XGyS2VrX/a9srlQfUEMvw8fGZwBMGzz+Fw3Bo54mx
         YFg5ATebGdjreGoTjUsVPV73NLpjrFNLjyurJVnj3VJfumXc3tdo7NCKajGyq4sSNc
         FF6/XYcpoc5NhDv8M8FcrS+oDAK9hLP2mkbyb3UMas5ovRQbvnErVG+FNaLTidQetD
         7/skVtPGwd8gQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Tegra PCIe has fixed per port SFIO line to signal PERST#, which can be
controlled by AFI port register. However, if a platform routes a different
GPIO to the PCIe slot, then port register cannot control it. Add support
for GPIO based PERST# signal for such platforms. GPIO number comes from per
port PCIe device tree node. PCIe driver probe doesn't fail if per port
"reset-gpios" property is not populated, make sure that DT property is not
missed for such platforms.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V6: No change

V5:
* Updated reset gpio toggle logic to reflect active low usage
* Replaced kasprintf() with devm_kasprintf()
* Updated commit message with more information.

V4: Using devm_gpiod_get_from_of_node() to get reset-gpios

V3: Using helper function to get reset-gpios

V2: Using standard "reset-gpio" property

 drivers/pci/controller/pci-tegra.c | 45 ++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index d2841532ff0e..a819bc087a05 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -17,6 +17,7 @@
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/export.h>
+#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
 #include <linux/irq.h>
@@ -399,6 +400,8 @@ struct tegra_pcie_port {
 	unsigned int lanes;
 
 	struct phy **phys;
+
+	struct gpio_desc *reset_gpio;
 };
 
 struct tegra_pcie_bus {
@@ -544,15 +547,23 @@ static void tegra_pcie_port_reset(struct tegra_pcie_port *port)
 	unsigned long value;
 
 	/* pulse reset signal */
-	value = afi_readl(port->pcie, ctrl);
-	value &= ~AFI_PEX_CTRL_RST;
-	afi_writel(port->pcie, value, ctrl);
+	if (port->reset_gpio) {
+		gpiod_set_value(port->reset_gpio, 1);
+	} else {
+		value = afi_readl(port->pcie, ctrl);
+		value &= ~AFI_PEX_CTRL_RST;
+		afi_writel(port->pcie, value, ctrl);
+	}
 
 	usleep_range(1000, 2000);
 
-	value = afi_readl(port->pcie, ctrl);
-	value |= AFI_PEX_CTRL_RST;
-	afi_writel(port->pcie, value, ctrl);
+	if (port->reset_gpio) {
+		gpiod_set_value(port->reset_gpio, 0);
+	} else {
+		value = afi_readl(port->pcie, ctrl);
+		value |= AFI_PEX_CTRL_RST;
+		afi_writel(port->pcie, value, ctrl);
+	}
 }
 
 static void tegra_pcie_enable_rp_features(struct tegra_pcie_port *port)
@@ -2199,6 +2210,7 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 		struct tegra_pcie_port *rp;
 		unsigned int index;
 		u32 value;
+		char *label;
 
 		err = of_pci_get_devfn(port);
 		if (err < 0) {
@@ -2257,6 +2269,27 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 		if (IS_ERR(rp->base))
 			return PTR_ERR(rp->base);
 
+		label = devm_kasprintf(dev, GFP_KERNEL, "pex-reset-%u", index);
+		if (!label) {
+			dev_err(dev, "failed to create reset GPIO label\n");
+			return -ENOMEM;
+		}
+
+		/*
+		 * Returns null if reset-gpios property is not populated and
+		 * fall back to using AFI per port register to toggle PERST#
+		 * SFIO line.
+		 */
+		rp->reset_gpio = devm_gpiod_get_from_of_node(dev, port,
+							     "reset-gpios", 0,
+							     GPIOD_OUT_LOW,
+							     label);
+		if (IS_ERR(rp->reset_gpio)) {
+			err = PTR_ERR(rp->reset_gpio);
+			dev_err(dev, "failed to get reset GPIO: %d\n", err);
+			return err;
+		}
+
 		list_add_tail(&rp->list, &pcie->ports);
 	}
 
-- 
2.17.1

