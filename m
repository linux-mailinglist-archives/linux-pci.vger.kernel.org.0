Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D387B1FF39
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2019 07:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfEPFyv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 May 2019 01:54:51 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19858 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfEPFyv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 May 2019 01:54:51 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cdcfb010000>; Wed, 15 May 2019 22:54:09 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 15 May 2019 22:54:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 15 May 2019 22:54:50 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 May
 2019 05:54:49 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 16 May 2019 05:54:46 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V4 27/28] PCI: tegra: Add support for GPIO based PERST#
Date:   Thu, 16 May 2019 11:23:06 +0530
Message-ID: <20190516055307.25737-28-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516055307.25737-1-mmaddireddy@nvidia.com>
References: <20190516055307.25737-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557986049; bh=q3gcIxRntTEVOX50/JJjAco9c+GAcOT2hHoy5oD6HRk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Iz62FTd19dT3EbRQQxkMg/Due5MBOBozzNzcdE+DmgCebPu6HtcxMznf8hnanC3F3
         umjG8nqQPIgsGnBENablhRQgI0S9K9gvwEUyH7PKT2O6SqlZmeL5+V20v/SRy4zyzm
         Jdm5m5ucMNJcqL6OM1+cn2hgPIDmKdJZTk8tEYsRnV3SMmlXui6iDoE57Jh4G+Boby
         yseYWn4i28QEGY0/gAZp9i1Ktl9vKakvV1eDxCzxofo9ByVd9X9pUtUUAzwzXmkg9r
         kQ5Y4/GWAtdLdZ+UsoUH6FxHUYFNU85I3wEwjzFAYHTh7WTrGKuiyRr7Yfk/rgZCY3
         p110HBc5k7Ntw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for GPIO based PERST# signal. GPIO number comes from per port
PCIe device tree node.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V4: Using devm_gpiod_get_from_of_node() to get reset-gpios

V3: Using helper function to get reset-gpios

V2: Using standard "reset-gpio" property

 drivers/pci/controller/pci-tegra.c | 41 +++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 06b99fcbf382..09b4d384ba38 100644
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
@@ -400,6 +401,8 @@ struct tegra_pcie_port {
 	unsigned int lanes;
 
 	struct phy **phys;
+
+	struct gpio_desc *reset_gpiod;
 };
 
 struct tegra_pcie_bus {
@@ -583,15 +586,23 @@ static void tegra_pcie_port_reset(struct tegra_pcie_port *port)
 	unsigned long value;
 
 	/* pulse reset signal */
-	value = afi_readl(port->pcie, ctrl);
-	value &= ~AFI_PEX_CTRL_RST;
-	afi_writel(port->pcie, value, ctrl);
+	if (port->reset_gpiod) {
+		gpiod_set_value(port->reset_gpiod, 0);
+	} else {
+		value = afi_readl(port->pcie, ctrl);
+		value &= ~AFI_PEX_CTRL_RST;
+		afi_writel(port->pcie, value, ctrl);
+	}
 
 	usleep_range(1000, 2000);
 
-	value = afi_readl(port->pcie, ctrl);
-	value |= AFI_PEX_CTRL_RST;
-	afi_writel(port->pcie, value, ctrl);
+	if (port->reset_gpiod) {
+		gpiod_set_value(port->reset_gpiod, 1);
+	} else {
+		value = afi_readl(port->pcie, ctrl);
+		value |= AFI_PEX_CTRL_RST;
+		afi_writel(port->pcie, value, ctrl);
+	}
 }
 
 static void tegra_pcie_enable_rp_features(struct tegra_pcie_port *port)
@@ -2238,6 +2249,7 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 		struct tegra_pcie_port *rp;
 		unsigned int index;
 		u32 value;
+		char *label;
 
 		err = of_pci_get_devfn(port);
 		if (err < 0) {
@@ -2296,6 +2308,23 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 		if (IS_ERR(rp->base))
 			return PTR_ERR(rp->base);
 
+		label = kasprintf(GFP_KERNEL, "pex-reset-%u", index);
+		if (!label) {
+			dev_err(dev, "failed to create reset GPIO label\n");
+			return -ENOMEM;
+		}
+
+		rp->reset_gpiod = devm_gpiod_get_from_of_node(dev, port,
+							      "reset-gpios", 0,
+							      GPIOD_OUT_LOW,
+							      label);
+		kfree(label);
+		if (IS_ERR(rp->reset_gpiod)) {
+			err = PTR_ERR(rp->reset_gpiod);
+			dev_err(dev, "failed to get reset GPIO: %d\n", err);
+			return err;
+		}
+
 		list_add_tail(&rp->list, &pcie->ports);
 	}
 
-- 
2.17.1

