Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3EF1BCF2
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2019 20:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732342AbfEMSJm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 May 2019 14:09:42 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:3272 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732358AbfEMSJl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 May 2019 14:09:41 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd9b2bd0000>; Mon, 13 May 2019 11:09:02 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 May 2019 11:09:41 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 May 2019 11:09:41 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 May
 2019 18:09:40 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 13 May 2019 18:09:36 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V3 28/29] PCI: tegra: Add support for GPIO based PERST#
Date:   Mon, 13 May 2019 23:37:43 +0530
Message-ID: <20190513180744.16493-29-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513180744.16493-1-mmaddireddy@nvidia.com>
References: <20190513180744.16493-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557770942; bh=toeksf94IcFffbV7lHSWVuPFH9eusr9/E+SSpcq87bM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=YIuM0DuA36FbXg9dkJqqK4fduHPcGn0esiRuCAgUVd5Bd/tEbXiE7ctLJOvlTV5lG
         QOVjUHwgnxNuR0IcCY82WQW8bk713uRM+80t9yUjApdINDU4GQu+FrPyYHMuBavM/j
         EeRjBchw/4MiogpKN7dYi4T5TDrDi/SfG7uB1Y/Qdm6IFRoMLXEGVATCPelMPC6Y+I
         qfYNkkfJksMF4litE26IJoiMNDZQ1LjuuPUJvRg5tMKNpDgdlR9m33sp64fuS9YN8k
         S9/6w9TgxRkU8CmRPOUhElV4ESlskDl/76UI1RPZ2Z+cf21sUnGTQKM4ECPcgnQVXo
         b08vE1rcYEibg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for GPIO based PERST# signal. GPIO number comes from per port
PCIe device tree node.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V3: Using helper function to get reset-gpios

V2: Using standard "reset-gpio" property

 drivers/pci/controller/pci-tegra.c | 42 +++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 06b99fcbf382..b021863303f1 100644
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
@@ -2296,6 +2308,24 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 		if (IS_ERR(rp->base))
 			return PTR_ERR(rp->base);
 
+		label = kasprintf(GFP_KERNEL, "pex-reset-%u", index);
+		if (!label) {
+			dev_err(dev, "failed to create reset GPIO label\n");
+			return -ENOMEM;
+		}
+
+		rp->reset_gpiod = of_pci_get_reset_gpio(dev, port,
+							GPIOD_OUT_LOW, label);
+		kfree(label);
+		if (!rp->reset_gpiod) {
+			dev_dbg(dev, "missing optional reset-gpios prop\n");
+		} else if (IS_ERR(rp->reset_gpiod)) {
+			err = PTR_ERR(rp->reset_gpiod);
+			rp->reset_gpiod = NULL;
+			dev_err(dev, "failed to get reset GPIO: %d\n", err);
+			return err;
+		}
+
 		list_add_tail(&rp->list, &pcie->ports);
 	}
 
-- 
2.17.1

