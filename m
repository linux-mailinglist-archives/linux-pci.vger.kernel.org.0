Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5893519C6CD
	for <lists+linux-pci@lfdr.de>; Thu,  2 Apr 2020 18:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389573AbgDBQNS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Apr 2020 12:13:18 -0400
Received: from hermes.aosc.io ([199.195.250.187]:49280 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389392AbgDBQNS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Apr 2020 12:13:18 -0400
X-Greylist: delayed 384 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Apr 2020 12:13:17 EDT
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 1FEDD4E090;
        Thu,  2 Apr 2020 16:06:12 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [RFC PATCH] PCI: dwc: add support for Allwinner SoCs' PCIe controller
Date:   Fri,  3 Apr 2020 00:05:49 +0800
Message-Id: <20200402160549.296203-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aosc.io; s=dkim;
        t=1585843612;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding;
        bh=OWG5aklXqyhO/if6T9UlKJm6vGmGTHIu3r0LWcgmyF0=;
        b=j239pePt4nVC0Nxu+us1VkTySGFLlOa98PF0b2i0jdG0kizy/BDIXXWWZNdPq2pN1Ydxpe
        TROBJOFNfUSJZfvwvUEgxBz+oOFtACZWUVkXZ4w1Y3ph0ADFnuD/OD+9M5lSkhoXVz+3r1
        XWpkgg1p1Qwp24gJHNZCYRoELcBX9xQ=
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Allwinner H6 SoC uses DesignWare's PCIe controller to provide a PCIe
host.

However, on Allwinner H6, the PCIe host has bad MMIO, which needs to be
workarounded. A workaround with the EL2 hypervisor functionality of ARM
Cortex cores is now available, which wraps MMIO operations.

This patch is going to add a driver for the DWC PCIe controller
available in Allwinner SoCs, either the H6 one when wrapped by the
hypervisor (so that the driver can consider it as an ordinary PCIe
controller) or further not buggy ones.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
There's no device tree binding patch available, because I still have
questions on the device tree compatible string. I want to use it to
describe that this driver doesn't support the "native Allwinner H6 PCIe
controller", but a wrapped version with my hypervisor.

I think supporting a "para-physical" device is some new thing, so this
patch is RFC.

My hypervisor is at [1], and some basic usage documentation is at [2].

[1] https://github.com/Icenowy/aw-el2-barebone
[2] https://forum.armbian.com/topic/13529-a-try-on-utilizing-h6-pcie-with-virtualization/

 drivers/pci/controller/dwc/Kconfig      |  10 +
 drivers/pci/controller/dwc/Makefile     |   1 +
 drivers/pci/controller/dwc/pcie-sunxi.c | 580 ++++++++++++++++++++++++
 3 files changed, 591 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-sunxi.c

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 03dcaf65d159..23344e095668 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -247,6 +247,16 @@ config PCI_MESON
 	  and therefore the driver re-uses the DesignWare core functions to
 	  implement the driver.
 
+config PCIE_SUNXI
+	bool "Allwinner SoCs PCIe controllers"
+	depends on PCI_MSI_IRQ_DOMAIN
+	select PCIE_DW_HOST
+	help
+	  Say Y here it you want PCIe controller support on Allwinner SoCs.
+	  Currently no PCIe controller is directly support by this driver,
+	  although when wrapped with a hypervisor, Allwinner H6 PCIe controller
+	  can be supported.
+
 config PCIE_TEGRA194
 	tristate
 
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index 8a637cfcf6e9..c1f14a47a4ad 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_PCIE_KIRIN) += pcie-kirin.o
 obj-$(CONFIG_PCIE_HISI_STB) += pcie-histb.o
 obj-$(CONFIG_PCI_MESON) += pci-meson.o
 obj-$(CONFIG_PCIE_TEGRA194) += pcie-tegra194.o
+obj-$(CONFIG_PCIE_SUNXI) += pcie-sunxi.o
 obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
 
 # The following drivers are for devices that use the generic ACPI
diff --git a/drivers/pci/controller/dwc/pcie-sunxi.c b/drivers/pci/controller/dwc/pcie-sunxi.c
new file mode 100644
index 000000000000..555f910d8a03
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-sunxi.c
@@ -0,0 +1,580 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe RC driver for Allwinner DW PCIe controllers
+ *
+ * Copyright (C) 2018-2020 Icenowy Zheng <icenowy@aosc.io>
+ * Copyright (C) 2016 Allwinner Co., Ltd.
+ */
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_gpio.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/reset.h>
+#include <linux/resource.h>
+#include <linux/signal.h>
+#include <linux/types.h>
+
+#include "pcie-designware.h"
+
+#define PCIE_RC_LCR				0x7c
+#define USER_DEFINED_REGISTER_LIST		0x1000
+#define PCIE_LTSSM_ENABLE			0x1000
+#define PCIE_INT_PENDING			0x1018
+#define PCIE_ADDR_PAGE_CFG			0x1020
+#define PCIE_AWMISC_INF0_CTRL			0x1030
+#define PCIE_ARMISC_INF0_CTRL			0x1034
+#define PCIE_LINK_STATUS			0x143C
+#define PCIE_PHY_CFG				0x1800
+#define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1	0x1
+#define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2	0x2
+#define PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK	0xf
+#define SYS_CLK					0
+#define PAD_CLK					1
+#define RDLH_LINK_UP				BIT(1)
+#define SMLH_LINK_UP				BIT(0)
+#define PCIE_LINK_TRAINING			BIT(0)
+#define PCIE_LINK_UP_MASK			(0x3 << 16)
+#define LINK_WAIT_MAX_RETRIES			10
+#define LINK_WAIT_USLEEP_MIN			90000
+#define LINK_WAIT_USLEEP_MAX			100000
+
+#define PERST_DELAY_US				1000
+
+#define PCIE_BAR_NUM				6
+#define PCIE_MEM_FLAGS				0x4
+#define PCIE_IO_FLAGS				0x1
+#define PCIE_BAR_REG				0x4
+#define HIGH16_MASK				GENMASK(31, 16)
+#define LOW16_MASK				GENMASK(15, 0)
+
+#define to_sunxi_pcie(x)			dev_get_drvdata((x)->dev)
+
+struct sunxi_pcie {
+	struct dw_pcie		*pci;
+	int			link_irq;
+	int			msi_irq;
+	int			speed_gen;
+	int			io_voltage;
+	struct clk		*pcie_ref;
+	struct clk		*pcie_axi;
+	struct clk		*pcie_aux;
+	struct clk		*pcie_bus;
+	struct reset_control	*pcie_power_rst;
+	struct reset_control	*pcie_bus_rst;
+	struct regulator	*reg_vcc;
+	struct regulator	*reg_vdd;
+	struct regulator	*reg_slot;
+	struct gpio_desc	*perst_gpio;
+};
+
+static void sunxi_pcie_perst_gpio_assert(struct sunxi_pcie *pcie)
+{
+	gpiod_set_value_cansleep(pcie->perst_gpio, 1);
+	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
+}
+
+static void sunxi_pcie_perst_gpio_deassert(struct sunxi_pcie *pcie)
+{
+	gpiod_set_value_cansleep(pcie->perst_gpio, 0);
+	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
+}
+
+static void sunxi_pcie_clk_select(struct dw_pcie *pci, int status)
+{
+	u32 val;
+
+	val = dw_pcie_readl_dbi(pci, PCIE_PHY_CFG);
+	val &= ~(0x1 << 31);
+	val |= status << 31;
+	dw_pcie_writel_dbi(pci, PCIE_PHY_CFG, val);
+}
+
+static void sunxi_pcie_ltssm_enable(struct dw_pcie *pci)
+{
+	u32 val;
+
+	val = dw_pcie_readl_dbi(pci, PCIE_LTSSM_ENABLE);
+	val |= PCIE_LINK_TRAINING;
+	dw_pcie_writel_dbi(pci, PCIE_LTSSM_ENABLE, val);
+}
+
+static void sunxi_pcie_irqpending(struct dw_pcie *pci)
+{
+	u32 val;
+
+	val = dw_pcie_readl_dbi(pci, PCIE_INT_PENDING);
+	val &= ~(0x3<<16);
+	dw_pcie_writel_dbi(pci, PCIE_INT_PENDING, val);
+}
+
+static void sunxi_pcie_phy_cfg(struct dw_pcie *pci, int enable)
+{
+	u32 val;
+
+	val = dw_pcie_readl_dbi(pci, PCIE_PHY_CFG);
+	if (enable)
+		val |= 0x1<<0;
+	else
+		val &= ~(0x1<<0);
+	dw_pcie_writel_dbi(pci, PCIE_PHY_CFG, val);
+}
+
+static void sunxi_pcie_irqmask(struct dw_pcie *pci)
+{
+	u32 val;
+
+	val = dw_pcie_readl_dbi(pci, PCIE_INT_PENDING);
+	val |= 0x3<<16;
+	dw_pcie_writel_dbi(pci, PCIE_INT_PENDING, val);
+}
+
+static void sunxi_pcie_ltssm_disable(struct dw_pcie *pci)
+{
+	u32 val;
+
+	val = dw_pcie_readl_dbi(pci, PCIE_LTSSM_ENABLE);
+	val &= ~PCIE_LINK_TRAINING;
+	dw_pcie_writel_dbi(pci, PCIE_LTSSM_ENABLE, val);
+}
+
+static int sunxi_pcie_wait_for_speed_change(struct dw_pcie *pci)
+{
+	u32 tmp;
+	unsigned int retries;
+
+	for (retries = 0; retries < 200; retries++) {
+		tmp = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
+		/* Test if the speed change finished. */
+		if (!(tmp & PORT_LOGIC_SPEED_CHANGE))
+			return 0;
+		usleep_range(100, 1000);
+	}
+
+	dev_err(pci->dev, "Speed change timeout\n");
+	return -EINVAL;
+}
+
+static int sunxi_pcie_link_up_status(struct dw_pcie *pci)
+{
+	u32 rc;
+	int ret;
+
+	rc = dw_pcie_readl_dbi(pci, PCIE_LINK_STATUS);
+	if ((rc & RDLH_LINK_UP) && (rc & SMLH_LINK_UP))
+		ret = 1;
+	else
+		ret = 0;
+
+	return ret;
+}
+
+static int sunxi_pcie_speed_change(struct dw_pcie *pci, int gen)
+{
+	int val;
+	int ret;
+
+	if (gen == 2) {
+		val = dw_pcie_readl_dbi(pci, PCIE_RC_LCR);
+		val &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
+		val |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2;
+		dw_pcie_writel_dbi(pci, PCIE_RC_LCR, val);
+
+		/*
+		 * Start Directed Speed Change so the best possible
+		 * speed both link partners support can be negotiated.
+		 */
+		val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
+		val |= PORT_LOGIC_SPEED_CHANGE;
+		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
+		ret = sunxi_pcie_wait_for_speed_change(pci);
+
+		if (!ret)
+			dev_info(pci->dev, "PCI-e speed of Gen%d\n", gen);
+		else
+			dev_info(pci->dev, "PCI-e speed of Gen1\n");
+	} else {
+		dev_info(pci->dev, "PCI-e speed of Gen1\n");
+	}
+
+	return 0;
+}
+
+static int sunxi_pcie_establish_link(struct dw_pcie *pci)
+{
+	struct sunxi_pcie *pcie = to_sunxi_pcie(pci);
+
+	if (dw_pcie_link_up(pci)) {
+		dev_err(pcie->pci->dev, "link is already up\n");
+		return 0;
+	}
+
+	sunxi_pcie_ltssm_enable(pci);
+	dw_pcie_wait_for_link(pci);
+
+	return 0;
+}
+
+static int sunxi_pcie_reset_deassert(struct sunxi_pcie *pcie)
+{
+	int ret;
+
+	ret = reset_control_deassert(pcie->pcie_bus_rst);
+	if (ret) {
+		dev_err(pcie->pci->dev, "unable to deassert bus reset\n");
+		return ret;
+	}
+	usleep_range(1000, 2000);
+
+	if (pcie->io_voltage < 2000000)
+		sunxi_pcie_phy_cfg(pcie->pci, 1);
+	else
+		sunxi_pcie_phy_cfg(pcie->pci, 0);
+
+	usleep_range(1000, 2000);
+	ret = reset_control_deassert(pcie->pcie_power_rst);
+	if (ret) {
+		dev_err(pcie->pci->dev, "unable to deassert power reset\n");
+		goto bus_reset_assert;
+	}
+
+	return 0;
+
+bus_reset_assert:
+	reset_control_assert(pcie->pcie_bus_rst);
+	return ret;
+}
+
+static int sunxi_pcie_clk_setup(struct sunxi_pcie *pcie)
+{
+	int ret;
+
+	ret = clk_prepare_enable(pcie->pcie_ref);
+	if (ret) {
+		dev_err(pcie->pci->dev, "unable to enable pcie_ref clock\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(pcie->pcie_axi);
+	if (ret) {
+		dev_err(pcie->pci->dev, "unable to enable pcie_axi clock\n");
+		goto disable_ref;
+	}
+
+	ret = clk_prepare_enable(pcie->pcie_aux);
+	if (ret) {
+		dev_err(pcie->pci->dev, "unable to enable pcie_aux clock\n");
+		goto disable_axi;
+	}
+
+	ret = clk_prepare_enable(pcie->pcie_bus);
+	if (ret) {
+		dev_err(pcie->pci->dev, "unable to enable pcie_bus clock\n");
+		goto disable_aux;
+	}
+
+	return 0;
+
+disable_aux:
+	clk_disable_unprepare(pcie->pcie_aux);
+disable_axi:
+	clk_disable_unprepare(pcie->pcie_axi);
+disable_ref:
+	clk_disable_unprepare(pcie->pcie_ref);
+
+	return ret;
+}
+
+static int sunxi_pcie_regulator_enable(struct sunxi_pcie *pcie)
+{
+	int ret;
+
+	ret = regulator_enable(pcie->reg_vcc);
+	if (ret)
+		return ret;
+
+	pcie->io_voltage = regulator_get_voltage(pcie->reg_vcc);
+	if (pcie->io_voltage < 0) {
+		ret = pcie->io_voltage;
+		goto disable_vcc;
+	}
+
+	ret = regulator_enable(pcie->reg_vdd);
+	if (ret)
+		goto disable_vcc;
+
+	ret = regulator_enable(pcie->reg_slot);
+	if (ret)
+		goto disable_vdd;
+
+	return 0;
+
+disable_vdd:
+	regulator_disable(pcie->reg_vdd);
+disable_vcc:
+	regulator_disable(pcie->reg_vcc);
+
+	return ret;
+}
+
+static irqreturn_t sunxi_pcie_msi_irq_handler(int irq, void *arg)
+{
+	struct sunxi_pcie *pcie = (struct sunxi_pcie *)arg;
+
+	return dw_handle_msi_irq(&pcie->pci->pp);
+}
+
+static irqreturn_t sunxi_pcie_linkup_handler(int irq, void *arg)
+{
+	struct sunxi_pcie *pcie = (struct sunxi_pcie *)arg;
+
+	sunxi_pcie_irqpending(pcie->pci);
+
+	return IRQ_HANDLED;
+}
+
+static int sunxi_pcie_get_clk_rst(struct platform_device *pdev,
+				  struct sunxi_pcie *pcie)
+{
+	struct device *dev = &pdev->dev;
+
+	pcie->pcie_ref = devm_clk_get(dev, "ref");
+	if (IS_ERR(pcie->pcie_ref)) {
+		dev_err(dev, "failed to get pcie ref clk\n");
+		return PTR_ERR(pcie->pcie_ref);
+	}
+
+	pcie->pcie_axi = devm_clk_get(dev, "axi");
+	if (IS_ERR(pcie->pcie_axi)) {
+		dev_err(dev, "failed to get pcie axi clk\n");
+		return PTR_ERR(pcie->pcie_axi);
+	}
+
+	pcie->pcie_aux = devm_clk_get(dev, "aux");
+	if (IS_ERR(pcie->pcie_aux)) {
+		dev_err(dev, "failed to get pcie aux clk\n");
+		return PTR_ERR(pcie->pcie_aux);
+	}
+
+	pcie->pcie_bus = devm_clk_get(dev, "bus");
+	if (IS_ERR(pcie->pcie_bus)) {
+		dev_err(dev, "failed to get pcie bus clk\n");
+		return PTR_ERR(pcie->pcie_bus);
+	}
+
+	pcie->pcie_bus_rst = devm_reset_control_get(dev, "bus");
+	if (IS_ERR(pcie->pcie_bus_rst)) {
+		dev_err(dev, "failed to get pcie bus reset\n");
+		return PTR_ERR(pcie->pcie_bus_rst);
+	}
+
+	pcie->pcie_power_rst = devm_reset_control_get(dev, "power");
+	if (IS_ERR(pcie->pcie_power_rst)) {
+		dev_err(dev, "failed to get pcie power reset\n");
+		return PTR_ERR(pcie->pcie_power_rst);
+	}
+
+	return 0;
+}
+
+static int sunxi_pcie_get_regulator(struct platform_device *pdev,
+				    struct sunxi_pcie *pcie)
+{
+	struct device *dev = &pdev->dev;
+
+	pcie->reg_vcc = devm_regulator_get(dev, "vcc");
+	if (IS_ERR(pcie->reg_vcc)) {
+		dev_err(dev, "failed to get pcie vcc supply\n");
+		return PTR_ERR(pcie->reg_vcc);
+	}
+
+	pcie->reg_vdd = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(pcie->reg_vdd)) {
+		dev_err(dev, "failed to get pcie vdd supply\n");
+		return PTR_ERR(pcie->reg_vdd);
+	}
+
+	pcie->reg_slot = devm_regulator_get(dev, "slot");
+	if (IS_ERR(pcie->reg_slot)) {
+		dev_err(dev, "failed to get pcie slot supply\n");
+		return PTR_ERR(pcie->reg_slot);
+	}
+
+	return 0;
+}
+
+static int sunxi_pcie_host_init(struct pcie_port *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct sunxi_pcie *pcie = to_sunxi_pcie(pci);
+
+	sunxi_pcie_ltssm_disable(pci);
+	sunxi_pcie_clk_select(pci, PAD_CLK);
+
+	dw_pcie_setup_rc(pp);
+
+	sunxi_pcie_establish_link(pci);
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		dw_pcie_msi_init(pp);
+
+	sunxi_pcie_speed_change(pci, pcie->speed_gen);
+
+	return 0;
+}
+
+static const struct dw_pcie_host_ops sunxi_pcie_host_ops = {
+	.host_init = sunxi_pcie_host_init,
+};
+
+static const struct dw_pcie_ops sunxi_pcie_ops = {
+	.link_up = sunxi_pcie_link_up_status,
+};
+
+static int sunxi_add_pcie_port(struct sunxi_pcie *pcie,
+			       struct platform_device *pdev)
+{
+	int ret;
+	struct pcie_port *pp = &pcie->pci->pp;
+
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
+		if (pp->msi_irq < 0)
+			return pp->msi_irq;
+
+		ret = devm_request_irq(&pdev->dev, pp->msi_irq,
+					sunxi_pcie_msi_irq_handler,
+					IRQF_SHARED, "sunxi-pcie-msi", pcie);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to request MSI IRQ\n");
+			return ret;
+		}
+	}
+
+	pp->root_bus_nr = -1;
+	pp->ops = &sunxi_pcie_host_ops;
+
+	ret = dw_pcie_host_init(pp);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to initialize host\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int sunxi_pcie_probe(struct platform_device *pdev)
+{
+	struct sunxi_pcie *sunxi_pcie;
+	struct dw_pcie *pci;
+	struct resource *dbi_res;
+	int ret;
+
+	sunxi_pcie = devm_kzalloc(&pdev->dev, sizeof(*sunxi_pcie),
+				  GFP_KERNEL);
+	if (!sunxi_pcie)
+		return -ENOMEM;
+
+	pci = devm_kzalloc(&pdev->dev, sizeof(*pci), GFP_KERNEL);
+	if (!pci)
+		return -ENOMEM;
+
+	sunxi_pcie->pci = pci;
+
+	pci->dev = &pdev->dev;
+	pci->ops = &sunxi_pcie_ops;
+
+	platform_set_drvdata(pdev, sunxi_pcie);
+
+	dbi_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
+	if (!dbi_res)
+		return -ENODEV;
+
+	pci->dbi_base = devm_ioremap_resource(&pdev->dev, dbi_res);
+	if (IS_ERR(pci->dbi_base))
+		return PTR_ERR(pci->dbi_base);
+
+	ret = sunxi_pcie_get_clk_rst(pdev, sunxi_pcie);
+	if (ret)
+		return ret;
+
+	ret = sunxi_pcie_get_regulator(pdev, sunxi_pcie);
+	if (ret)
+		return ret;
+
+	sunxi_pcie->perst_gpio = devm_gpiod_get_optional(&pdev->dev, "perst", GPIOD_OUT_LOW);
+	if (IS_ERR(sunxi_pcie->perst_gpio))
+		return PTR_ERR(sunxi_pcie->perst_gpio);
+
+	ret = of_property_read_u32(pdev->dev.of_node, "max-link-speed", &sunxi_pcie->speed_gen);
+	if (ret) {
+		dev_info(&pdev->dev, "No speed generation info specified, fallback to Gen1\n");
+		sunxi_pcie->speed_gen = 0x1;
+	}
+
+	ret = sunxi_pcie_regulator_enable(sunxi_pcie);
+	if (ret)
+		return ret;
+
+	ret = sunxi_pcie_clk_setup(sunxi_pcie);
+	if (ret)
+		return ret;
+
+	ret = sunxi_pcie_reset_deassert(sunxi_pcie);
+	if (ret)
+		return ret;
+
+	sunxi_pcie_perst_gpio_deassert(sunxi_pcie);
+
+	sunxi_pcie_irqmask(pci);
+	sunxi_pcie->link_irq = platform_get_irq_byname(pdev, "linkup");
+	ret = devm_request_irq(&pdev->dev, sunxi_pcie->link_irq,
+			       sunxi_pcie_linkup_handler,
+			       IRQF_SHARED, "sunxi-pcie-linkup", sunxi_pcie);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to request linkup IRQ\n");
+		return ret;
+	}
+
+	ret = sunxi_add_pcie_port(sunxi_pcie, pdev);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int sunxi_pcie_remove(struct platform_device *pdev)
+{
+	struct sunxi_pcie *pcie = platform_get_drvdata(pdev);
+
+	sunxi_pcie_perst_gpio_assert(pcie);
+	reset_control_assert(pcie->pcie_bus_rst);
+	reset_control_assert(pcie->pcie_power_rst);
+	clk_disable_unprepare(pcie->pcie_ref);
+	clk_disable_unprepare(pcie->pcie_axi);
+	clk_disable_unprepare(pcie->pcie_aux);
+	clk_disable_unprepare(pcie->pcie_bus);
+
+	return 0;
+}
+
+static const struct of_device_id sunxi_pcie_of_match[] = {
+	{ .compatible = "pine64,allwinner-h6-pcie-wrapped", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sunxi_pcie_of_match);
+
+static struct platform_driver sunxi_pcie_driver = {
+	.driver = {
+		.name = "sunxi-pcie",
+		.suppress_bind_attrs = true,
+		.of_match_table = sunxi_pcie_of_match,
+	},
+	.remove = sunxi_pcie_remove,
+	.probe	= sunxi_pcie_probe,
+};
+builtin_platform_driver(sunxi_pcie_driver);
-- 
2.24.1

