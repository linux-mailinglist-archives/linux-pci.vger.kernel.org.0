Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2598E73603
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2019 19:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfGXRt5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jul 2019 13:49:57 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14421 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfGXRt5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jul 2019 13:49:57 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d389a430000>; Wed, 24 Jul 2019 10:49:55 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 24 Jul 2019 10:49:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 24 Jul 2019 10:49:55 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 24 Jul
 2019 17:49:54 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 24 Jul 2019 17:49:54 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d389a3d0001>; Wed, 24 Jul 2019 10:49:54 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <kishon@ti.com>, <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V14 12/13] phy: tegra: Add PCIe PIPE2UPHY support
Date:   Wed, 24 Jul 2019 23:18:23 +0530
Message-ID: <20190724174824.20933-13-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190724174824.20933-1-vidyas@nvidia.com>
References: <20190724174824.20933-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1563990595; bh=nmOS1qmFEdc6gzTnDb+mMTdjQmzk0tzJdy1BDGTdZVE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=hm239ohLLSxRkcCte57dOStfQPlRaOoD4IOQhg7qUwexBguUWGSrK07piwn3SmYXS
         ED5vj+AaHiB92NRAibw0W5piLMrBlJFKO0kESd2WPMjUBlZ6Gp2N3TS4XH703A4mKH
         VHVtnJHkYZs4OfJcvCeLk7Hk7D/85wimMxueDqfAk1ZRMSN7vBFtDtatFBqYN/pzzo
         IKN0SJ3cI1veJ5m4RSRoDOrmSF7lEPAHhK68HIEQVuFZC0wWPqXwTdrOI8lQ+aHHO0
         YrG+TWosBJ/9miIPz/eElzu+5IQ6Zhvx24OaApgKieoXW5sGMQUqlf1Wga88BwvyRu
         4DqaLMSQDhRmw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Synopsys DesignWare core based PCIe controllers in Tegra 194 SoC interface
with Universal PHY (UPHY) module through a PIPE2UPHY (P2U) module.
For each PCIe lane of a controller, there is a P2U unit instantiated at
hardware level. This driver provides support for the programming required
for each P2U that is going to be used for a PCIe controller.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
V14:
* None

V13:
* None

V12:
* None

V11:
* Replaced PTR_ERR_OR_ZERO() with PTR_ERR() as the check for zero is already
  present in the code.

V10:
* Used _relaxed() versions of readl() & writel()

V9:
* Made it dependent on ARCH_TEGRA_194_SOC directly instead of ARCH_TEGRA

V8:
* Changed P2U driver file name from pcie-p2u-tegra194.c to phy-tegra194-p2u.c

V7:
* None

V6:
* Addressed review comments from Thierry

V5:
* None

V4:
* Rebased on top of linux-next top of the tree

V3:
* Replaced spaces with tabs in Kconfig file
* Sorted header file inclusion alphabetically

V2:
* Added COMPILE_TEST in Kconfig
* Removed empty phy_ops implementations
* Modified code according to DT documentation file modifications

 drivers/phy/tegra/Kconfig            |   7 ++
 drivers/phy/tegra/Makefile           |   1 +
 drivers/phy/tegra/phy-tegra194-p2u.c | 120 +++++++++++++++++++++++++++
 3 files changed, 128 insertions(+)
 create mode 100644 drivers/phy/tegra/phy-tegra194-p2u.c

diff --git a/drivers/phy/tegra/Kconfig b/drivers/phy/tegra/Kconfig
index e516967d695b..f9817c3ae85f 100644
--- a/drivers/phy/tegra/Kconfig
+++ b/drivers/phy/tegra/Kconfig
@@ -7,3 +7,10 @@ config PHY_TEGRA_XUSB
 
 	  To compile this driver as a module, choose M here: the module will
 	  be called phy-tegra-xusb.
+
+config PHY_TEGRA194_P2U
+	tristate "NVIDIA Tegra194 PIPE2UPHY PHY driver"
+	depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
+	select GENERIC_PHY
+	help
+	  Enable this to support the P2U (PIPE to UPHY) that is part of Tegra 19x SOCs.
diff --git a/drivers/phy/tegra/Makefile b/drivers/phy/tegra/Makefile
index 64ccaeacb631..320dd389f34d 100644
--- a/drivers/phy/tegra/Makefile
+++ b/drivers/phy/tegra/Makefile
@@ -6,3 +6,4 @@ phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_124_SOC) += xusb-tegra124.o
 phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_132_SOC) += xusb-tegra124.o
 phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_210_SOC) += xusb-tegra210.o
 phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_186_SOC) += xusb-tegra186.o
+obj-$(CONFIG_PHY_TEGRA194_P2U) += phy-tegra194-p2u.o
diff --git a/drivers/phy/tegra/phy-tegra194-p2u.c b/drivers/phy/tegra/phy-tegra194-p2u.c
new file mode 100644
index 000000000000..7042bed9feaa
--- /dev/null
+++ b/drivers/phy/tegra/phy-tegra194-p2u.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * P2U (PIPE to UPHY) driver for Tegra T194 SoC
+ *
+ * Copyright (C) 2019 NVIDIA Corporation.
+ *
+ * Author: Vidya Sagar <vidyas@nvidia.com>
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/phy/phy.h>
+
+#define P2U_PERIODIC_EQ_CTRL_GEN3	0xc0
+#define P2U_PERIODIC_EQ_CTRL_GEN3_PERIODIC_EQ_EN		BIT(0)
+#define P2U_PERIODIC_EQ_CTRL_GEN3_INIT_PRESET_EQ_TRAIN_EN	BIT(1)
+#define P2U_PERIODIC_EQ_CTRL_GEN4	0xc4
+#define P2U_PERIODIC_EQ_CTRL_GEN4_INIT_PRESET_EQ_TRAIN_EN	BIT(1)
+
+#define P2U_RX_DEBOUNCE_TIME				0xa4
+#define P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_MASK	0xffff
+#define P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_VAL		160
+
+struct tegra_p2u {
+	void __iomem *base;
+};
+
+static inline void p2u_writel(struct tegra_p2u *phy, const u32 value,
+			      const u32 reg)
+{
+	writel_relaxed(value, phy->base + reg);
+}
+
+static inline u32 p2u_readl(struct tegra_p2u *phy, const u32 reg)
+{
+	return readl_relaxed(phy->base + reg);
+}
+
+static int tegra_p2u_power_on(struct phy *x)
+{
+	struct tegra_p2u *phy = phy_get_drvdata(x);
+	u32 val;
+
+	val = p2u_readl(phy, P2U_PERIODIC_EQ_CTRL_GEN3);
+	val &= ~P2U_PERIODIC_EQ_CTRL_GEN3_PERIODIC_EQ_EN;
+	val |= P2U_PERIODIC_EQ_CTRL_GEN3_INIT_PRESET_EQ_TRAIN_EN;
+	p2u_writel(phy, val, P2U_PERIODIC_EQ_CTRL_GEN3);
+
+	val = p2u_readl(phy, P2U_PERIODIC_EQ_CTRL_GEN4);
+	val |= P2U_PERIODIC_EQ_CTRL_GEN4_INIT_PRESET_EQ_TRAIN_EN;
+	p2u_writel(phy, val, P2U_PERIODIC_EQ_CTRL_GEN4);
+
+	val = p2u_readl(phy, P2U_RX_DEBOUNCE_TIME);
+	val &= ~P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_MASK;
+	val |= P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_VAL;
+	p2u_writel(phy, val, P2U_RX_DEBOUNCE_TIME);
+
+	return 0;
+}
+
+static const struct phy_ops ops = {
+	.power_on = tegra_p2u_power_on,
+	.owner = THIS_MODULE,
+};
+
+static int tegra_p2u_probe(struct platform_device *pdev)
+{
+	struct phy_provider *phy_provider;
+	struct device *dev = &pdev->dev;
+	struct phy *generic_phy;
+	struct tegra_p2u *phy;
+	struct resource *res;
+
+	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctl");
+	phy->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(phy->base))
+		return PTR_ERR(phy->base);
+
+	platform_set_drvdata(pdev, phy);
+
+	generic_phy = devm_phy_create(dev, NULL, &ops);
+	if (IS_ERR(generic_phy))
+		return PTR_ERR(generic_phy);
+
+	phy_set_drvdata(generic_phy, phy);
+
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	if (IS_ERR(phy_provider))
+		return PTR_ERR(phy_provider);
+
+	return 0;
+}
+
+static const struct of_device_id tegra_p2u_id_table[] = {
+	{
+		.compatible = "nvidia,tegra194-p2u",
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, tegra_p2u_id_table);
+
+static struct platform_driver tegra_p2u_driver = {
+	.probe = tegra_p2u_probe,
+	.driver = {
+		.name = "tegra194-p2u",
+		.of_match_table = tegra_p2u_id_table,
+	},
+};
+module_platform_driver(tegra_p2u_driver);
+
+MODULE_AUTHOR("Vidya Sagar <vidyas@nvidia.com>");
+MODULE_DESCRIPTION("NVIDIA Tegra194 PIPE2UPHY PHY driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

