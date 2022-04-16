Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072595036FD
	for <lists+linux-pci@lfdr.de>; Sat, 16 Apr 2022 16:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbiDPOGg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Apr 2022 10:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbiDPOGg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Apr 2022 10:06:36 -0400
X-Greylist: delayed 509 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 16 Apr 2022 07:04:03 PDT
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDE831227
        for <linux-pci@vger.kernel.org>; Sat, 16 Apr 2022 07:04:03 -0700 (PDT)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout2.routing.net (Postfix) with ESMTP id 760D8600FB;
        Sat, 16 Apr 2022 13:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1650117335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W8Yttbf87dzNTlll+D5is5InbIbylrBMs8gIG6gmnzI=;
        b=IhPT4PmSVwWfW2X6qFxQffOXLrGvxk7lmaYuCo6wCXxwXaSLL/g5/FWLF6FldYEGc7/VRp
        com7f9kHiLPq0fzYAE6lgeZxgps7bFROetU2PhuMwV5Pbg/RHs9Pg/xmhh/dS65AOYfGSY
        XxPNj4PiaNKI7Wgyh05BnGxakhJOa70=
Received: from localhost.localdomain (fttx-pool-217.61.150.108.bambit.de [217.61.150.108])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id D0290100CE0;
        Sat, 16 Apr 2022 13:55:33 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [RFC/RFT 3/6] phy: rockchip: Support pcie v3
Date:   Sat, 16 Apr 2022 15:54:55 +0200
Message-Id: <20220416135458.104048-4-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220416135458.104048-1-linux@fw-web.de>
References: <20220416135458.104048-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: f3fb3b7a-31c9-483e-b842-4742139be3ca
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

RK3568 supports PCIe v3 using not Combphy like PCIe v2 on rk3566.
It use a dedicated pcie-phy. Add support for this.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
driver was taken from linux 5.10 based on in
https://github.com/JeffyCN/mirrors
which now has disappeared
---
 drivers/phy/rockchip/Kconfig                  |   9 +
 drivers/phy/rockchip/Makefile                 |   1 +
 .../phy/rockchip/phy-rockchip-snps-pcie3.c    | 278 ++++++++++++++++++
 include/dt-bindings/phy/phy-snps-pcie3.h      |  21 ++
 include/linux/phy/pcie.h                      |  12 +
 5 files changed, 321 insertions(+)
 create mode 100644 drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
 create mode 100644 include/dt-bindings/phy/phy-snps-pcie3.h
 create mode 100644 include/linux/phy/pcie.h

diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
index 9022e395c056..94360fc96a6f 100644
--- a/drivers/phy/rockchip/Kconfig
+++ b/drivers/phy/rockchip/Kconfig
@@ -83,6 +83,15 @@ config PHY_ROCKCHIP_PCIE
 	help
 	  Enable this to support the Rockchip PCIe PHY.
 
+config PHY_ROCKCHIP_SNPS_PCIE3
+	tristate "Rockchip Snps PCIe3 PHY Driver"
+	depends on (ARCH_ROCKCHIP && OF) || COMPILE_TEST
+	depends on HAS_IOMEM
+	select GENERIC_PHY
+	select MFD_SYSCON
+	help
+	  Enable this to support the Rockchip snps PCIe3 PHY.
+
 config PHY_ROCKCHIP_TYPEC
 	tristate "Rockchip TYPEC PHY Driver"
 	depends on OF && (ARCH_ROCKCHIP || COMPILE_TEST)
diff --git a/drivers/phy/rockchip/Makefile b/drivers/phy/rockchip/Makefile
index a5041efb5b8f..7eab129230d1 100644
--- a/drivers/phy/rockchip/Makefile
+++ b/drivers/phy/rockchip/Makefile
@@ -8,5 +8,6 @@ obj-$(CONFIG_PHY_ROCKCHIP_INNO_HDMI)	+= phy-rockchip-inno-hdmi.o
 obj-$(CONFIG_PHY_ROCKCHIP_INNO_USB2)	+= phy-rockchip-inno-usb2.o
 obj-$(CONFIG_PHY_ROCKCHIP_NANENG_COMBO_PHY)	+= phy-rockchip-naneng-combphy.o
 obj-$(CONFIG_PHY_ROCKCHIP_PCIE)		+= phy-rockchip-pcie.o
+obj-$(CONFIG_PHY_ROCKCHIP_SNPS_PCIE3)	+= phy-rockchip-snps-pcie3.o
 obj-$(CONFIG_PHY_ROCKCHIP_TYPEC)	+= phy-rockchip-typec.o
 obj-$(CONFIG_PHY_ROCKCHIP_USB)		+= phy-rockchip-usb.o
diff --git a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
new file mode 100644
index 000000000000..992b9709a97a
--- /dev/null
+++ b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Rockchip PCIE3.0 phy driver
+ *
+ * Copyright (C) 2020 Rockchip Electronics Co., Ltd.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/phy/pcie.h>
+#include <linux/phy/phy.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <dt-bindings/phy/phy-snps-pcie3.h>
+
+/* Register for RK3568 */
+#define GRF_PCIE30PHY_CON1 0x4
+#define GRF_PCIE30PHY_CON6 0x18
+#define GRF_PCIE30PHY_CON9 0x24
+#define GRF_PCIE30PHY_STATUS0 0x80
+#define SRAM_INIT_DONE(reg) (reg & BIT(14))
+
+/* Register for RK3588 */
+#define PHP_GRF_PCIESEL_CON 0x100
+#define RK3588_PCIE3PHY_GRF_CMN_CON0 0x0
+#define RK3588_PCIE3PHY_GRF_PHY0_STATUS1 0x904
+#define RK3588_PCIE3PHY_GRF_PHY1_STATUS1 0xa04
+#define RK3588_SRAM_INIT_DONE(reg) (reg & BIT(0))
+
+struct rockchip_p3phy_ops;
+
+struct rockchip_p3phy_priv {
+	const struct rockchip_p3phy_ops *ops;
+	void __iomem *mmio;
+	/* mode: RC, EP */
+	int mode;
+	/* pcie30_phymode: Aggregation, Bifurcation */
+	int pcie30_phymode;
+	struct regmap *phy_grf;
+	struct regmap *pipe_grf;
+	struct reset_control *p30phy;
+	struct phy *phy;
+	struct clk_bulk_data *clks;
+	int num_clks;
+	bool is_bifurcation;
+};
+
+struct rockchip_p3phy_ops {
+	int (*phy_init)(struct rockchip_p3phy_priv *priv);
+};
+
+static int rockchip_p3phy_set_mode(struct phy *phy, enum phy_mode mode, int submode)
+{
+	struct rockchip_p3phy_priv *priv = phy_get_drvdata(phy);
+
+	/* Actually We don't care EP/RC mode, but just record it */
+	switch (submode) {
+	case PHY_MODE_PCIE_RC:
+		priv->mode = PHY_MODE_PCIE_RC;
+		break;
+	case PHY_MODE_PCIE_EP:
+		priv->mode = PHY_MODE_PCIE_EP;
+		break;
+	case PHY_MODE_PCIE_BIFURCATION:
+		priv->is_bifurcation = true;
+		break;
+	default:
+		pr_info("%s, invalid mode\n", __func__);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int rockchip_p3phy_rk3568_init(struct rockchip_p3phy_priv *priv)
+{
+	int ret = 0;
+	u32 reg;
+
+	/* Deassert PCIe PMA output clamp mode */
+	regmap_write(priv->phy_grf, GRF_PCIE30PHY_CON9,
+		     (0x1 << 15) | (0x1 << 31));
+	/* Set bifurcation if needed, and it doesn't care RC/EP */
+	if (priv->is_bifurcation) {
+		regmap_write(priv->phy_grf, GRF_PCIE30PHY_CON6,
+			     0x1 | (0xf << 16));
+		regmap_write(priv->phy_grf, GRF_PCIE30PHY_CON1,
+			     (0x1 << 15) | (0x1 << 31));
+	}
+
+	reset_control_deassert(priv->p30phy);
+
+	ret = regmap_read_poll_timeout(priv->phy_grf,
+				       GRF_PCIE30PHY_STATUS0,
+				       reg, SRAM_INIT_DONE(reg),
+				       0, 500);
+	if (ret)
+		pr_err("%s: lock failed 0x%x, check input refclk and power supply\n",
+		       __func__, reg);
+	return ret;
+}
+
+static const struct rockchip_p3phy_ops rk3568_ops = {
+	.phy_init = rockchip_p3phy_rk3568_init,
+};
+
+static int rockchip_p3phy_rk3588_init(struct rockchip_p3phy_priv *priv)
+{
+	int ret = 0;
+	u32 reg;
+
+	/* Deassert PCIe PMA output clamp mode */
+	regmap_write(priv->phy_grf, RK3588_PCIE3PHY_GRF_CMN_CON0,
+		     (0x1 << 8) | (0x1 << 24));
+
+	reset_control_deassert(priv->p30phy);
+
+	ret = regmap_read_poll_timeout(priv->phy_grf,
+				       RK3588_PCIE3PHY_GRF_PHY0_STATUS1,
+				       reg, RK3588_SRAM_INIT_DONE(reg),
+				       0, 500);
+	ret |= regmap_read_poll_timeout(priv->phy_grf,
+					RK3588_PCIE3PHY_GRF_PHY1_STATUS1,
+					reg, RK3588_SRAM_INIT_DONE(reg),
+					0, 500);
+	if (ret)
+		pr_err("%s: lock failed 0x%x, check input refclk and power supply\n",
+		       __func__, reg);
+	return ret;
+}
+
+static const struct rockchip_p3phy_ops rk3588_ops = {
+	.phy_init = rockchip_p3phy_rk3588_init,
+};
+
+static int rochchip_p3phy_init(struct phy *phy)
+{
+	struct rockchip_p3phy_priv *priv = phy_get_drvdata(phy);
+	int ret;
+
+	ret = clk_bulk_prepare_enable(priv->num_clks, priv->clks);
+	if (ret) {
+		pr_err("failed to enable PCIe bulk clks %d\n", ret);
+		return ret;
+	}
+
+	reset_control_assert(priv->p30phy);
+	udelay(1);
+
+	if (priv->ops->phy_init) {
+		ret = priv->ops->phy_init(priv);
+		if (ret)
+			clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
+	};
+
+	return ret;
+}
+
+static int rochchip_p3phy_exit(struct phy *phy)
+{
+	struct rockchip_p3phy_priv *priv = phy_get_drvdata(phy);
+
+	clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
+	reset_control_assert(priv->p30phy);
+	return 0;
+}
+
+static const struct phy_ops rochchip_p3phy_ops = {
+	.init = rochchip_p3phy_init,
+	.exit = rochchip_p3phy_exit,
+	.set_mode = rockchip_p3phy_set_mode,
+	.owner = THIS_MODULE,
+};
+
+static int rockchip_p3phy_probe(struct platform_device *pdev)
+{
+	struct phy_provider *phy_provider;
+	struct device *dev = &pdev->dev;
+	struct rockchip_p3phy_priv *priv;
+	struct device_node *np = dev->of_node;
+	struct resource *res;
+	int ret;
+	u32 val, reg;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->mmio = devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->mmio)) {
+		ret = PTR_ERR(priv->mmio);
+		return ret;
+	}
+
+	priv->ops = of_device_get_match_data(&pdev->dev);
+	if (!priv->ops) {
+		dev_err(&pdev->dev, "no of match data provided\n");
+		return -EINVAL;
+	}
+
+	priv->phy_grf = syscon_regmap_lookup_by_phandle(np, "rockchip,phy-grf");
+	if (IS_ERR(priv->phy_grf)) {
+		dev_err(dev, "failed to find rockchip,phy_grf regmap\n");
+		return PTR_ERR(priv->phy_grf);
+	}
+
+	priv->pipe_grf = syscon_regmap_lookup_by_phandle(dev->of_node,
+							 "rockchip,pipe-grf");
+	if (IS_ERR(priv->pipe_grf))
+		dev_info(dev, "failed to find rockchip,pipe_grf regmap\n");
+
+	ret = device_property_read_u32(dev, "rockchip,pcie30-phymode", &val);
+	if (!ret)
+		priv->pcie30_phymode = val;
+	else
+		priv->pcie30_phymode = PHY_MODE_PCIE_AGGREGATION;
+
+	/* Select correct pcie30_phymode */
+	if (priv->pcie30_phymode > 4)
+		priv->pcie30_phymode = PHY_MODE_PCIE_AGGREGATION;
+
+	regmap_write(priv->phy_grf, RK3588_PCIE3PHY_GRF_CMN_CON0,
+		     (0x7<<16) | priv->pcie30_phymode);
+
+	/* Set pcie1ln_sel in PHP_GRF_PCIESEL_CON */
+	if (!IS_ERR(priv->pipe_grf)) {
+		reg = priv->pcie30_phymode & 3;
+		if (reg)
+			regmap_write(priv->pipe_grf, PHP_GRF_PCIESEL_CON,
+				     (reg << 16) | reg);
+	};
+
+	priv->phy = devm_phy_create(dev, NULL, &rochchip_p3phy_ops);
+	if (IS_ERR(priv->phy)) {
+		dev_err(dev, "failed to create combphy\n");
+		return PTR_ERR(priv->phy);
+	}
+
+	priv->p30phy = devm_reset_control_get(dev, "phy");
+	if (IS_ERR(priv->p30phy)) {
+		dev_warn(dev, "no phy reset control specified\n");
+		priv->p30phy = NULL;
+	}
+
+	priv->num_clks = devm_clk_bulk_get_all(dev, &priv->clks);
+	if (priv->num_clks < 1)
+		return -ENODEV;
+
+	dev_set_drvdata(dev, priv);
+	phy_set_drvdata(priv->phy, priv);
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static const struct of_device_id rockchip_p3phy_of_match[] = {
+	{ .compatible = "rockchip,rk3568-pcie3-phy", .data = &rk3568_ops },
+	{ .compatible = "rockchip,rk3588-pcie3-phy", .data = &rk3588_ops },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, rockchip_p3phy_of_match);
+
+static struct platform_driver rockchip_p3phy_driver = {
+	.probe	= rockchip_p3phy_probe,
+	.driver = {
+		.name = "rockchip-snps-pcie3-phy",
+		.of_match_table = rockchip_p3phy_of_match,
+	},
+};
+module_platform_driver(rockchip_p3phy_driver);
+MODULE_DESCRIPTION("Rockchip Synopsys PCIe 3.0 PHY driver");
+MODULE_LICENSE("GPL");
diff --git a/include/dt-bindings/phy/phy-snps-pcie3.h b/include/dt-bindings/phy/phy-snps-pcie3.h
new file mode 100644
index 000000000000..5006947f2285
--- /dev/null
+++ b/include/dt-bindings/phy/phy-snps-pcie3.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
+ */
+
+#ifndef _DT_BINDINGS_PHY_SNPS_PCIE3
+#define _DT_BINDINGS_PHY_SNPS_PCIE3
+
+/*
+ * pcie30_phy_mode[2:0]
+ * bit2: aggregation
+ * bit1: bifurcation for port 1
+ * bit0: bifurcation for port 0
+ */
+#define PHY_MODE_PCIE_AGGREGATION 4	/* PCIe3x4 */
+#define PHY_MODE_PCIE_NANBNB	0	/* P1:PCIe3x2  +  P0:PCIe3x2 */
+#define PHY_MODE_PCIE_NANBBI	1	/* P1:PCIe3x2  +  P0:PCIe3x1*2 */
+#define PHY_MODE_PCIE_NABINB	2	/* P1:PCIe3x1*2 + P0:PCIe3x2 */
+#define PHY_MODE_PCIE_NABIBI	3	/* P1:PCIe3x1*2 + P0:PCIe3x1*2 */
+
+#endif /* _DT_BINDINGS_PHY_SNPS_PCIE3 */
diff --git a/include/linux/phy/pcie.h b/include/linux/phy/pcie.h
new file mode 100644
index 000000000000..93c997f520fe
--- /dev/null
+++ b/include/linux/phy/pcie.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
+ */
+#ifndef __PHY_PCIE_H
+#define __PHY_PCIE_H
+
+#define PHY_MODE_PCIE_RC 20
+#define PHY_MODE_PCIE_EP 21
+#define PHY_MODE_PCIE_BIFURCATION 22
+
+#endif
-- 
2.25.1

