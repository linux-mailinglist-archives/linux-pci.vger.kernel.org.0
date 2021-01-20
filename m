Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233F12FCF5E
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jan 2021 13:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389459AbhATLYQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jan 2021 06:24:16 -0500
Received: from lucky1.263xmail.com ([211.157.147.130]:46598 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732761AbhATKTt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jan 2021 05:19:49 -0500
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id 7CF6DCF3D6;
        Wed, 20 Jan 2021 18:17:26 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from xxm-vm.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P24739T140081880880896S1611137823657337_;
        Wed, 20 Jan 2021 18:17:26 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <8bb47be61c1b17ff213ae8cebc836f6e>
X-RL-SENDER: xxm@rock-chips.com
X-SENDER: xxm@rock-chips.com
X-LOGIN-NAME: xxm@rock-chips.com
X-FST-TO: bhelgaas@google.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Simon Xue <xxm@rock-chips.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Simon Xue <xxm@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 2/2] PCI: rockchip: add DesignWare based PCIe controller
Date:   Wed, 20 Jan 2021 18:16:58 +0800
Message-Id: <20210120101658.241134-2-xxm@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210120101658.241134-1-xxm@rock-chips.com>
References: <20210120101658.241134-1-xxm@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pcie-dw-rockchip is based on DWC IP. But pcie-rockchip-host
is another IP which is only used for RK3399. So all the following
non-RK3399 SoCs should use this driver.

Signed-off-by: Simon Xue <xxm@rock-chips.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---
 drivers/pci/controller/Kconfig                |   4 +-
 drivers/pci/controller/dwc/Kconfig            |   9 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 370 ++++++++++++++++++
 4 files changed, 382 insertions(+), 2 deletions(-)
 create mode 100644 drivers/pci/controller/dwc/pcie-dw-rockchip.c

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 64e2f5e379aa..48a7d62f97f3 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -219,7 +219,7 @@ config PCIE_ROCKCHIP_HOST
 	help
 	  Say Y here if you want internal PCI support on Rockchip SoC.
 	  There is 1 internal PCIe port available to support GEN2 with
-	  4 slots.
+	  4 slots. Only for RK3399.
 
 config PCIE_ROCKCHIP_EP
 	bool "Rockchip PCIe endpoint controller"
@@ -231,7 +231,7 @@ config PCIE_ROCKCHIP_EP
 	help
 	  Say Y here if you want to support Rockchip PCIe controller in
 	  endpoint mode on Rockchip SoC. There is 1 internal PCIe port
-	  available to support GEN2 with 4 slots.
+	  available to support GEN2 with 4 slots. Only for RK3399.
 
 config PCIE_MEDIATEK
 	tristate "MediaTek PCIe controller"
diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 22c5529e9a65..110733d0c241 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -214,6 +214,15 @@ config PCIE_ARTPEC6_EP
 	  Enables support for the PCIe controller in the ARTPEC-6 SoC to work in
 	  endpoint mode. This uses the DesignWare core.
 
+config PCIE_DW_ROCKCHIP_HOST
+	bool "Rockchip DesignWare PCIe controller"
+	select PCIE_DW
+	select PCIE_DW_HOST
+	depends on ARCH_ROCKCHIP
+	depends on OF
+	help
+	  Enables support for the DW PCIe controller in the Rockchip SoC.
+
 config PCIE_INTEL_GW
 	bool "Intel Gateway PCIe host controller support"
 	depends on OF && (X86 || COMPILE_TEST)
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index a751553fa0db..9c7048d2be17 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_PCI_LAYERSCAPE_EP) += pci-layerscape-ep.o
 obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
 obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
 obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
+obj-$(CONFIG_PCIE_DW_ROCKCHIP_HOST) += pcie-dw-rockchip.o
 obj-$(CONFIG_PCIE_INTEL_GW) += pcie-intel-gw.o
 obj-$(CONFIG_PCIE_KIRIN) += pcie-kirin.o
 obj-$(CONFIG_PCIE_HISI_STB) += pcie-histb.o
diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
new file mode 100644
index 000000000000..e41cd6041c3f
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -0,0 +1,370 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe host controller driver for Rockchip SoCs
+ *
+ * Copyright (C) 2021 Rockchip Electronics Co., Ltd.
+ *		http://www.rock-chips.com
+ *
+ * Author: Simon Xue <xxm@rock-chips.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/gpio/consumer.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+
+#include "pcie-designware.h"
+
+/*
+ * The upper 16 bits of PCIE_CLIENT_CONFIG are a write
+ * mask for the lower 16 bits.  This allows atomic updates
+ * of the register without locking.
+ */
+#define HIWORD_UPDATE(mask, val) (((mask) << 16) | (val))
+#define HIWORD_UPDATE_BIT(val)	HIWORD_UPDATE(val, val)
+
+#define to_rockchip_pcie(x) dev_get_drvdata((x)->dev)
+
+#define PCIE_CLIENT_RC_MODE		HIWORD_UPDATE_BIT(0x40)
+#define PCIE_CLIENT_ENABLE_LTSSM	HIWORD_UPDATE_BIT(0xc)
+#define PCIE_SMLH_LINKUP		BIT(16)
+#define PCIE_RDLH_LINKUP		BIT(17)
+#define PCIE_L0S_ENTRY			0x11
+#define PCIE_CLIENT_GENERAL_CONTROL	0x0
+#define PCIE_CLIENT_GENERAL_DEBUG	0x104
+#define PCIE_CLIENT_HOT_RESET_CTRL      0x180
+#define PCIE_CLIENT_LTSSM_STATUS	0x300
+#define PCIE_CLIENT_DBG_FIFO_MODE_CON	0x310
+#define PCIE_CLIENT_DBG_FIFO_PTN_HIT_D0 0x320
+#define PCIE_CLIENT_DBG_FIFO_PTN_HIT_D1 0x324
+#define PCIE_CLIENT_DBG_FIFO_TRN_HIT_D0 0x328
+#define PCIE_CLIENT_DBG_FIFO_TRN_HIT_D1 0x32c
+#define PCIE_CLIENT_DBG_FIFO_STATUS	0x350
+#define PCIE_CLIENT_DBG_TRANSITION_DATA	0xffff0000
+#define PCIE_CLIENT_DBF_EN		0xffff0003
+#define PCIE_LTSSM_ENABLE_ENHANCE       BIT(4)
+
+struct rockchip_pcie {
+	struct dw_pcie			*pci;
+	void __iomem			*apb_base;
+	struct phy			*phy;
+	struct clk_bulk_data		*clks;
+	unsigned int			clk_cnt;
+	struct reset_control		*rst;
+	struct gpio_desc		*rst_gpio;
+	struct pcie_port		pp;
+	struct regulator                *vpcie3v3;
+};
+
+static inline int rockchip_pcie_readl_apb(struct rockchip_pcie *rockchip,
+					  u32 reg)
+{
+	return readl(rockchip->apb_base + reg);
+}
+
+static inline void rockchip_pcie_writel_apb(struct rockchip_pcie *rockchip,
+					    u32 reg, u32 val)
+{
+	writel(val, rockchip->apb_base + reg);
+}
+
+static inline void rockchip_pcie_set_mode(struct rockchip_pcie *rockchip)
+{
+	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_GENERAL_CONTROL,
+				 PCIE_CLIENT_RC_MODE);
+}
+
+static inline void rockchip_pcie_enable_ltssm(struct rockchip_pcie *rockchip)
+{
+	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_GENERAL_CONTROL,
+				 PCIE_CLIENT_ENABLE_LTSSM);
+}
+
+static int rockchip_pcie_link_up(struct dw_pcie *pci)
+{
+	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
+	u32 val = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_LTSSM_STATUS);
+
+	if ((val & (PCIE_RDLH_LINKUP | PCIE_SMLH_LINKUP)) == 0x30000 &&
+	    (val & GENMASK(5, 0)) == PCIE_L0S_ENTRY)
+		return 1;
+
+	return 0;
+}
+
+static void rockchip_pcie_establish_link(struct dw_pcie *pci)
+{
+	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
+
+	if (dw_pcie_link_up(pci)) {
+		dev_err(pci->dev, "link already up\n");
+		return;
+	}
+
+	/* Reset device */
+	gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
+	msleep(100);
+	gpiod_set_value_cansleep(rockchip->rst_gpio, 1);
+
+	rockchip_pcie_enable_ltssm(rockchip);
+}
+
+static void rockchip_pcie_enable_debug(struct rockchip_pcie *rockchip)
+{
+	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_DBG_FIFO_PTN_HIT_D0,
+				 PCIE_CLIENT_DBG_TRANSITION_DATA);
+	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_DBG_FIFO_PTN_HIT_D1,
+				 PCIE_CLIENT_DBG_TRANSITION_DATA);
+	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_DBG_FIFO_TRN_HIT_D0,
+				 PCIE_CLIENT_DBG_TRANSITION_DATA);
+	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_DBG_FIFO_TRN_HIT_D1,
+				 PCIE_CLIENT_DBG_TRANSITION_DATA);
+	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_DBG_FIFO_MODE_CON,
+				 PCIE_CLIENT_DBF_EN);
+}
+
+static void rockchip_pcie_debug_dump(struct rockchip_pcie *rockchip)
+{
+	u32 loop;
+	struct dw_pcie *pci = rockchip->pci;
+
+	dev_dbg(pci->dev, "ltssm = 0x%x\n",
+		rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_LTSSM_STATUS));
+	for (loop = 0; loop < 64; loop++)
+		dev_dbg(pci->dev, "fifo_status = 0x%x\n",
+			rockchip_pcie_readl_apb(rockchip,
+						PCIE_CLIENT_DBG_FIFO_STATUS));
+}
+
+static int rockchip_pcie_host_init(struct pcie_port *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
+
+	dw_pcie_setup_rc(pp);
+
+	rockchip_pcie_enable_debug(rockchip);
+
+	rockchip_pcie_establish_link(pci);
+	dw_pcie_wait_for_link(pci);
+
+	rockchip_pcie_debug_dump(rockchip);
+
+	return 0;
+}
+
+static const struct dw_pcie_host_ops rockchip_pcie_host_ops = {
+	.host_init = rockchip_pcie_host_init,
+};
+
+static int rockchip_add_pcie_port(struct rockchip_pcie *rockchip)
+{
+	int ret;
+	struct dw_pcie *pci = rockchip->pci;
+	struct pcie_port *pp = &pci->pp;
+
+	pp->ops = &rockchip_pcie_host_ops;
+
+	rockchip_pcie_set_mode(rockchip);
+
+	ret = dw_pcie_host_init(pp);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void rockchip_pcie_clk_deinit(struct rockchip_pcie *rockchip)
+{
+	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
+}
+
+static int rockchip_pcie_clk_init(struct rockchip_pcie *rockchip)
+{
+	struct device *dev = rockchip->pci->dev;
+	int ret;
+
+	ret = devm_clk_bulk_get_all(dev, &rockchip->clks);
+	if (ret < 0)
+		return ret;
+
+	rockchip->clk_cnt = ret;
+
+	ret = clk_bulk_prepare_enable(rockchip->clk_cnt, rockchip->clks);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int rockchip_pcie_resource_get(struct platform_device *pdev,
+				      struct rockchip_pcie *rockchip)
+{
+	struct dw_pcie *pci = rockchip->pci;
+
+	pci->dbi_base = devm_platform_ioremap_resource_byname(pdev, "pcie-dbi");
+	if (IS_ERR(pci->dbi_base))
+		return PTR_ERR(pci->dbi_base);
+
+	rockchip->apb_base = devm_platform_ioremap_resource_byname(pdev,
+								   "pcie-apb");
+	if (IS_ERR(rockchip->apb_base))
+		return PTR_ERR(rockchip->apb_base);
+
+	rockchip->rst_gpio = devm_gpiod_get_optional(&pdev->dev, "reset",
+						     GPIOD_OUT_HIGH);
+	if (IS_ERR(rockchip->rst_gpio))
+		return PTR_ERR(rockchip->rst_gpio);
+
+	return 0;
+}
+
+static int rockchip_pcie_phy_init(struct rockchip_pcie *rockchip)
+{
+	int ret;
+	struct device *dev = rockchip->pci->dev;
+
+	rockchip->phy = devm_phy_get(dev, "pcie-phy");
+	if (IS_ERR(rockchip->phy))
+		return dev_err_probe(dev, PTR_ERR(rockchip->phy),
+				     "missing phy\n");
+
+	ret = phy_init(rockchip->phy);
+	if (ret < 0)
+		return ret;
+
+	phy_power_on(rockchip->phy);
+
+	return 0;
+}
+
+static void rockchip_pcie_phy_deinit(struct rockchip_pcie *rockchip)
+{
+	phy_exit(rockchip->phy);
+	phy_power_off(rockchip->phy);
+}
+
+static int rockchip_pcie_reset_control_release(struct rockchip_pcie *rockchip)
+{
+	struct device *dev = rockchip->pci->dev;
+	int ret;
+
+	rockchip->rst = devm_reset_control_array_get_exclusive(dev);
+	if (IS_ERR(rockchip->rst))
+		return dev_err_probe(dev, PTR_ERR(rockchip->rst),
+				     "failed to get reset lines\n");
+
+	ret = reset_control_deassert(rockchip->rst);
+
+	return ret;
+}
+
+static void rockchip_pcie_fast_link_setup(struct rockchip_pcie *rockchip)
+{
+	u32 val;
+
+	/* LTSSM EN ctrl mode */
+	val = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_HOT_RESET_CTRL);
+	val |= PCIE_LTSSM_ENABLE_ENHANCE | (PCIE_LTSSM_ENABLE_ENHANCE << 16);
+	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_HOT_RESET_CTRL, val);
+}
+
+static const struct of_device_id rockchip_pcie_of_match[] = {
+	{ .compatible = "rockchip,rk3568-pcie", },
+	{ /* sentinel */ },
+};
+
+static const struct dw_pcie_ops dw_pcie_ops = {
+	.link_up = rockchip_pcie_link_up,
+};
+
+static int rockchip_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct rockchip_pcie *rockchip;
+	struct dw_pcie *pci;
+	int ret;
+
+	rockchip = devm_kzalloc(dev, sizeof(*rockchip), GFP_KERNEL);
+	if (!rockchip)
+		return -ENOMEM;
+
+	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
+	if (!pci)
+		return -ENOMEM;
+
+	pci->dev = dev;
+	pci->ops = &dw_pcie_ops;
+
+	rockchip->pci = pci;
+
+	ret = rockchip_pcie_resource_get(pdev, rockchip);
+	if (ret)
+		return ret;
+
+	/* DON'T MOVE ME: must be enable before phy init */
+	rockchip->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
+	if (IS_ERR(rockchip->vpcie3v3)) {
+		if (PTR_ERR(rockchip->vpcie3v3) != -ENODEV)
+			return PTR_ERR(rockchip->vpcie3v3);
+		dev_info(dev, "no vpcie3v3 regulator found\n");
+	}
+
+	if (!IS_ERR(rockchip->vpcie3v3)) {
+		ret = regulator_enable(rockchip->vpcie3v3);
+		if (ret) {
+			dev_err(pci->dev, "fail to enable vpcie3v3 regulator\n");
+			return ret;
+		}
+	}
+
+	ret = rockchip_pcie_phy_init(rockchip);
+	if (ret)
+		goto disable_regulator;
+
+	ret = rockchip_pcie_reset_control_release(rockchip);
+	if (ret)
+		goto deinit_phy;
+
+	ret = rockchip_pcie_clk_init(rockchip);
+	if (ret)
+		goto deinit_phy;
+
+	rockchip_pcie_fast_link_setup(rockchip);
+
+	platform_set_drvdata(pdev, rockchip);
+
+	ret = rockchip_add_pcie_port(rockchip);
+	if (ret)
+		goto deinit_clk;
+
+	return 0;
+
+deinit_clk:
+	rockchip_pcie_clk_deinit(rockchip);
+deinit_phy:
+	rockchip_pcie_phy_deinit(rockchip);
+disable_regulator:
+	if (!IS_ERR(rockchip->vpcie3v3))
+		regulator_disable(rockchip->vpcie3v3);
+
+	return ret;
+}
+
+MODULE_DEVICE_TABLE(of, rockchip_pcie_of_match);
+
+static struct platform_driver rockchip_pcie_driver = {
+	.driver = {
+		.name	= "rk-pcie",
+		.of_match_table = rockchip_pcie_of_match,
+		.suppress_bind_attrs = true,
+	},
+	.probe = rockchip_pcie_probe,
+};
+
+builtin_platform_driver(rockchip_pcie_driver);
-- 
2.25.1



