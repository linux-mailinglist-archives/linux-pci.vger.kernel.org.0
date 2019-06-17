Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0099748AA8
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 19:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbfFQRl1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 13:41:27 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12025 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfFQRl1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2019 13:41:27 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d07d0c50001>; Mon, 17 Jun 2019 10:41:26 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 17 Jun 2019 10:41:26 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 17 Jun 2019 10:41:26 -0700
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 17 Jun
 2019 17:41:26 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 17 Jun 2019 17:41:22 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V5 26/27] PCI: tegra: Add support for GPIO based PERST#
Date:   Mon, 17 Jun 2019 23:09:51 +0530
Message-ID: <20190617173952.29363-27-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190617173952.29363-1-mmaddireddy@nvidia.com>
References: <20190617173952.29363-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560793286; bh=GYlXroIZyzfwRgNQQS7HK2npoIG6A7B3ze8RNY7D5yI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=diHJmWdzsvHBqG0mE8ztk/FJOtvdWqOaLqMRtmZnaXJEdqZ46jvjtDa8H4u7zeFuE
         t6+IT0sXMCZCidb9zP8BHfzHLIbPDcYl70ug7SghftmA+WztMfhbusWGz0DBL1D6ao
         3cC8pCp0CuGYA1PLv5poclNP0ls7zMFlNwpATujoHgUMLmwfaoGPi17SR9ZFwtJvfI
         meIQ1g7KO0wF5262G2g0yQWBotDQnl4i2wxxXdNb2wQZZ+wAeIqnQOXAST4+8qdiPH
         VezThAHUErb+vY/sMqaNatPBBW0oki7Ypf+kUIsTxJSMoXOyWWDg9c6z860P9FW5Hu
         8JpkVCfNy8oEw==
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
---
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
index d3b9e6440dd6..2e55d64a0428 100644
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
+	struct gpio_desc *reset_gpio;
 };
 
 struct tegra_pcie_bus {
@@ -545,15 +548,23 @@ static void tegra_pcie_port_reset(struct tegra_pcie_port *port)
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
@@ -2200,6 +2211,7 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 		struct tegra_pcie_port *rp;
 		unsigned int index;
 		u32 value;
+		char *label;
 
 		err = of_pci_get_devfn(port);
 		if (err < 0) {
@@ -2258,6 +2270,27 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
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

