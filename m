Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C27346FD9
	for <lists+linux-pci@lfdr.de>; Wed, 24 Mar 2021 04:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbhCXDGN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Mar 2021 23:06:13 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:43690 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235017AbhCXDFx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Mar 2021 23:05:53 -0400
X-UUID: 22b1c5066191443d8503f3663d63dad5-20210324
X-UUID: 22b1c5066191443d8503f3663d63dad5-20210324
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 826618577; Wed, 24 Mar 2021 11:05:48 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 24 Mar 2021 11:05:47 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 24 Mar 2021 11:05:46 +0800
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        <youlin.pei@mediatek.com>, <chuanjia.liu@mediatek.com>,
        <qizhong.cheng@mediatek.com>, <sin_jieyang@mediatek.com>,
        <drinkcat@chromium.org>, <Rex-BC.Chen@mediatek.com>,
        <anson.chuang@mediatek.com>, Krzysztof Wilczyski <kw@linux.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [v9,3/7] PCI: mediatek-gen3: Add MediaTek Gen3 driver for MT8192
Date:   Wed, 24 Mar 2021 11:05:06 +0800
Message-ID: <20210324030510.29177-4-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210324030510.29177-1-jianjun.wang@mediatek.com>
References: <20210324030510.29177-1-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

MediaTek's PCIe host controller has three generation HWs, the new
generation HW is an individual bridge, it supports Gen3 speed and
compatible with Gen2, Gen1 speed.

Add support for new Gen3 controller which can be found on MT8192.

Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
Acked-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pci/controller/Kconfig              |  13 +
 drivers/pci/controller/Makefile             |   1 +
 drivers/pci/controller/pcie-mediatek-gen3.c | 464 ++++++++++++++++++++
 3 files changed, 478 insertions(+)
 create mode 100644 drivers/pci/controller/pcie-mediatek-gen3.c

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 5aa8977d7b0f..1e925ac47279 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -233,6 +233,19 @@ config PCIE_MEDIATEK
 	  Say Y here if you want to enable PCIe controller support on
 	  MediaTek SoCs.
 
+config PCIE_MEDIATEK_GEN3
+	tristate "MediaTek Gen3 PCIe controller"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on PCI_MSI_IRQ_DOMAIN
+	help
+	  Adds support for PCIe Gen3 MAC controller for MediaTek SoCs.
+	  This PCIe controller is compatible with Gen3, Gen2 and Gen1 speed,
+	  and support up to 256 MSI interrupt numbers for
+	  multi-function devices.
+
+	  Say Y here if you want to enable Gen3 PCIe controller support on
+	  MediaTek SoCs.
+
 config VMD
 	depends on PCI_MSI && X86_64 && SRCU
 	tristate "Intel Volume Management Device Driver"
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index e4559f2182f2..579973327815 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_PCIE_ROCKCHIP) += pcie-rockchip.o
 obj-$(CONFIG_PCIE_ROCKCHIP_EP) += pcie-rockchip-ep.o
 obj-$(CONFIG_PCIE_ROCKCHIP_HOST) += pcie-rockchip-host.o
 obj-$(CONFIG_PCIE_MEDIATEK) += pcie-mediatek.o
+obj-$(CONFIG_PCIE_MEDIATEK_GEN3) += pcie-mediatek-gen3.o
 obj-$(CONFIG_PCIE_MICROCHIP_HOST) += pcie-microchip-host.o
 obj-$(CONFIG_VMD) += vmd.o
 obj-$(CONFIG_PCIE_BRCMSTB) += pcie-brcmstb.o
diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
new file mode 100644
index 000000000000..3546e53b3c85
--- /dev/null
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -0,0 +1,464 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MediaTek PCIe host controller driver.
+ *
+ * Copyright (c) 2020 MediaTek Inc.
+ * Author: Jianjun Wang <jianjun.wang@mediatek.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+
+#include "../pci.h"
+
+#define PCIE_SETTING_REG		0x80
+#define PCIE_PCI_IDS_1			0x9c
+#define PCI_CLASS(class)		(class << 8)
+#define PCIE_RC_MODE			BIT(0)
+
+#define PCIE_CFGNUM_REG			0x140
+#define PCIE_CFG_DEVFN(devfn)		((devfn) & GENMASK(7, 0))
+#define PCIE_CFG_BUS(bus)		(((bus) << 8) & GENMASK(15, 8))
+#define PCIE_CFG_BYTE_EN(bytes)		(((bytes) << 16) & GENMASK(19, 16))
+#define PCIE_CFG_FORCE_BYTE_EN		BIT(20)
+#define PCIE_CFG_OFFSET_ADDR		0x1000
+#define PCIE_CFG_HEADER(bus, devfn) \
+	(PCIE_CFG_BUS(bus) | PCIE_CFG_DEVFN(devfn))
+
+#define PCIE_RST_CTRL_REG		0x148
+#define PCIE_MAC_RSTB			BIT(0)
+#define PCIE_PHY_RSTB			BIT(1)
+#define PCIE_BRG_RSTB			BIT(2)
+#define PCIE_PE_RSTB			BIT(3)
+
+#define PCIE_LTSSM_STATUS_REG		0x150
+
+#define PCIE_LINK_STATUS_REG		0x154
+#define PCIE_PORT_LINKUP		BIT(8)
+
+#define PCIE_TRANS_TABLE_BASE_REG	0x800
+#define PCIE_ATR_SRC_ADDR_MSB_OFFSET	0x4
+#define PCIE_ATR_TRSL_ADDR_LSB_OFFSET	0x8
+#define PCIE_ATR_TRSL_ADDR_MSB_OFFSET	0xc
+#define PCIE_ATR_TRSL_PARAM_OFFSET	0x10
+#define PCIE_ATR_TLB_SET_OFFSET		0x20
+
+#define PCIE_MAX_TRANS_TABLES		8
+#define PCIE_ATR_EN			BIT(0)
+#define PCIE_ATR_SIZE(size) \
+	(((((size) - 1) << 1) & GENMASK(6, 1)) | PCIE_ATR_EN)
+#define PCIE_ATR_ID(id)			((id) & GENMASK(3, 0))
+#define PCIE_ATR_TYPE_MEM		PCIE_ATR_ID(0)
+#define PCIE_ATR_TYPE_IO		PCIE_ATR_ID(1)
+#define PCIE_ATR_TLP_TYPE(type)		(((type) << 16) & GENMASK(18, 16))
+#define PCIE_ATR_TLP_TYPE_MEM		PCIE_ATR_TLP_TYPE(0)
+#define PCIE_ATR_TLP_TYPE_IO		PCIE_ATR_TLP_TYPE(2)
+
+/**
+ * struct mtk_pcie_port - PCIe port information
+ * @dev: pointer to PCIe device
+ * @base: IO mapped register base
+ * @reg_base: physical register base
+ * @mac_reset: MAC reset control
+ * @phy_reset: PHY reset control
+ * @phy: PHY controller block
+ * @clks: PCIe clocks
+ * @num_clks: PCIe clocks count for this port
+ */
+struct mtk_pcie_port {
+	struct device *dev;
+	void __iomem *base;
+	phys_addr_t reg_base;
+	struct reset_control *mac_reset;
+	struct reset_control *phy_reset;
+	struct phy *phy;
+	struct clk_bulk_data *clks;
+	int num_clks;
+};
+
+/**
+ * mtk_pcie_config_tlp_header() - Configure a configuration TLP header
+ * @bus: PCI bus to query
+ * @devfn: device/function number
+ * @where: offset in config space
+ * @size: data size in TLP header
+ *
+ * Set byte enable field and device information in configuration TLP header.
+ */
+static void mtk_pcie_config_tlp_header(struct pci_bus *bus, unsigned int devfn,
+					int where, int size)
+{
+	struct mtk_pcie_port *port = bus->sysdata;
+	int bytes;
+	u32 val;
+
+	bytes = (GENMASK(size - 1, 0) & 0xf) << (where & 0x3);
+
+	val = PCIE_CFG_FORCE_BYTE_EN | PCIE_CFG_BYTE_EN(bytes) |
+	      PCIE_CFG_HEADER(bus->number, devfn);
+
+	writel_relaxed(val, port->base + PCIE_CFGNUM_REG);
+}
+
+static void __iomem *mtk_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
+				      int where)
+{
+	struct mtk_pcie_port *port = bus->sysdata;
+
+	return port->base + PCIE_CFG_OFFSET_ADDR + where;
+}
+
+static int mtk_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
+				int where, int size, u32 *val)
+{
+	mtk_pcie_config_tlp_header(bus, devfn, where, size);
+
+	return pci_generic_config_read32(bus, devfn, where, size, val);
+}
+
+static int mtk_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
+				 int where, int size, u32 val)
+{
+	mtk_pcie_config_tlp_header(bus, devfn, where, size);
+
+	if (size <= 2)
+		val <<= (where & 0x3) * 8;
+
+	return pci_generic_config_write32(bus, devfn, where, 4, val);
+}
+
+static struct pci_ops mtk_pcie_ops = {
+	.map_bus = mtk_pcie_map_bus,
+	.read  = mtk_pcie_config_read,
+	.write = mtk_pcie_config_write,
+};
+
+static int mtk_pcie_set_trans_table(struct mtk_pcie_port *port,
+				    resource_size_t cpu_addr,
+				    resource_size_t pci_addr,
+				    resource_size_t size,
+				    unsigned long type, int num)
+{
+	void __iomem *table;
+	u32 val;
+
+	if (num >= PCIE_MAX_TRANS_TABLES) {
+		dev_err(port->dev, "not enough translate table for addr: %#llx, limited to [%d]\n",
+			(unsigned long long)cpu_addr, PCIE_MAX_TRANS_TABLES);
+		return -ENODEV;
+	}
+
+	table = port->base + PCIE_TRANS_TABLE_BASE_REG +
+		num * PCIE_ATR_TLB_SET_OFFSET;
+
+	writel_relaxed(lower_32_bits(cpu_addr) | PCIE_ATR_SIZE(fls(size) - 1),
+		       table);
+	writel_relaxed(upper_32_bits(cpu_addr),
+		       table + PCIE_ATR_SRC_ADDR_MSB_OFFSET);
+	writel_relaxed(lower_32_bits(pci_addr),
+		       table + PCIE_ATR_TRSL_ADDR_LSB_OFFSET);
+	writel_relaxed(upper_32_bits(pci_addr),
+		       table + PCIE_ATR_TRSL_ADDR_MSB_OFFSET);
+
+	if (type == IORESOURCE_IO)
+		val = PCIE_ATR_TYPE_IO | PCIE_ATR_TLP_TYPE_IO;
+	else
+		val = PCIE_ATR_TYPE_MEM | PCIE_ATR_TLP_TYPE_MEM;
+
+	writel_relaxed(val, table + PCIE_ATR_TRSL_PARAM_OFFSET);
+
+	return 0;
+}
+
+static int mtk_pcie_startup_port(struct mtk_pcie_port *port)
+{
+	struct resource_entry *entry;
+	struct pci_host_bridge *host = pci_host_bridge_from_priv(port);
+	unsigned int table_index = 0;
+	int err;
+	u32 val;
+
+	/* Set as RC mode */
+	val = readl_relaxed(port->base + PCIE_SETTING_REG);
+	val |= PCIE_RC_MODE;
+	writel_relaxed(val, port->base + PCIE_SETTING_REG);
+
+	/* Set class code */
+	val = readl_relaxed(port->base + PCIE_PCI_IDS_1);
+	val &= ~GENMASK(31, 8);
+	val |= PCI_CLASS(PCI_CLASS_BRIDGE_PCI << 8);
+	writel_relaxed(val, port->base + PCIE_PCI_IDS_1);
+
+	/* Assert all reset signals */
+	val = readl_relaxed(port->base + PCIE_RST_CTRL_REG);
+	val |= PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RSTB;
+	writel_relaxed(val, port->base + PCIE_RST_CTRL_REG);
+
+	/*
+	 * Described in PCIe CEM specification setctions 2.2 (PERST# Signal)
+	 * and 2.2.1 (Initial Power-Up (G3 to S0)).
+	 * The deassertion of PERST# should be delayed 100ms (TPVPERL)
+	 * for the power and clock to become stable.
+	 */
+	msleep(100);
+
+	/* De-assert reset signals */
+	val &= ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RSTB);
+	writel_relaxed(val, port->base + PCIE_RST_CTRL_REG);
+
+	/* Check if the link is up or not */
+	err = readl_poll_timeout(port->base + PCIE_LINK_STATUS_REG, val,
+				 !!(val & PCIE_PORT_LINKUP), 20,
+				 PCI_PM_D3COLD_WAIT * USEC_PER_MSEC);
+	if (err) {
+		val = readl_relaxed(port->base + PCIE_LTSSM_STATUS_REG);
+		dev_err(port->dev, "PCIe link down, ltssm reg val: %#x\n", val);
+		return err;
+	}
+
+	/* Set PCIe translation windows */
+	resource_list_for_each_entry(entry, &host->windows) {
+		struct resource *res = entry->res;
+		unsigned long type = resource_type(res);
+		resource_size_t cpu_addr;
+		resource_size_t pci_addr;
+		resource_size_t size;
+		const char *range_type;
+
+		if (type == IORESOURCE_IO) {
+			cpu_addr = pci_pio_to_address(res->start);
+			range_type = "IO";
+		} else if (type == IORESOURCE_MEM) {
+			cpu_addr = res->start;
+			range_type = "MEM";
+		} else {
+			continue;
+		}
+
+		pci_addr = res->start - entry->offset;
+		size = resource_size(res);
+		err = mtk_pcie_set_trans_table(port, cpu_addr, pci_addr, size,
+					       type, table_index);
+		if (err)
+			return err;
+
+		dev_dbg(port->dev, "set %s trans window[%d]: cpu_addr = %#llx, pci_addr = %#llx, size = %#llx\n",
+			range_type, table_index, (unsigned long long)cpu_addr,
+			(unsigned long long)pci_addr, (unsigned long long)size);
+
+		table_index++;
+	}
+
+	return 0;
+}
+
+static int mtk_pcie_parse_port(struct mtk_pcie_port *port)
+{
+	struct device *dev = port->dev;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct resource *regs;
+	int ret;
+
+	regs = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pcie-mac");
+	port->base = devm_ioremap_resource(dev, regs);
+	if (IS_ERR(port->base)) {
+		dev_err(dev, "failed to map register base\n");
+		return PTR_ERR(port->base);
+	}
+
+	port->reg_base = regs->start;
+
+	port->phy_reset = devm_reset_control_get_optional_exclusive(dev, "phy");
+	if (IS_ERR(port->phy_reset)) {
+		ret = PTR_ERR(port->phy_reset);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to get PHY reset\n");
+
+		return ret;
+	}
+
+	port->mac_reset = devm_reset_control_get_optional_exclusive(dev, "mac");
+	if (IS_ERR(port->mac_reset)) {
+		ret = PTR_ERR(port->mac_reset);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to get MAC reset\n");
+
+		return ret;
+	}
+
+	port->phy = devm_phy_optional_get(dev, "pcie-phy");
+	if (IS_ERR(port->phy)) {
+		ret = PTR_ERR(port->phy);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to get PHY\n");
+
+		return ret;
+	}
+
+	port->num_clks = devm_clk_bulk_get_all(dev, &port->clks);
+	if (port->num_clks < 0) {
+		dev_err(dev, "failed to get clocks\n");
+		return port->num_clks;
+	}
+
+	return 0;
+}
+
+static int mtk_pcie_power_up(struct mtk_pcie_port *port)
+{
+	struct device *dev = port->dev;
+	int err;
+
+	/* PHY power on and enable pipe clock */
+	reset_control_deassert(port->phy_reset);
+
+	err = phy_init(port->phy);
+	if (err) {
+		dev_err(dev, "failed to initialize PHY\n");
+		goto err_phy_init;
+	}
+
+	err = phy_power_on(port->phy);
+	if (err) {
+		dev_err(dev, "failed to power on PHY\n");
+		goto err_phy_on;
+	}
+
+	/* MAC power on and enable transaction layer clocks */
+	reset_control_deassert(port->mac_reset);
+
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
+
+	err = clk_bulk_prepare_enable(port->num_clks, port->clks);
+	if (err) {
+		dev_err(dev, "failed to enable clocks\n");
+		goto err_clk_init;
+	}
+
+	return 0;
+
+err_clk_init:
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+	reset_control_assert(port->mac_reset);
+	phy_power_off(port->phy);
+err_phy_on:
+	phy_exit(port->phy);
+err_phy_init:
+	reset_control_assert(port->phy_reset);
+
+	return err;
+}
+
+static void mtk_pcie_power_down(struct mtk_pcie_port *port)
+{
+	clk_bulk_disable_unprepare(port->num_clks, port->clks);
+
+	pm_runtime_put_sync(port->dev);
+	pm_runtime_disable(port->dev);
+	reset_control_assert(port->mac_reset);
+
+	phy_power_off(port->phy);
+	phy_exit(port->phy);
+	reset_control_assert(port->phy_reset);
+}
+
+static int mtk_pcie_setup(struct mtk_pcie_port *port)
+{
+	int err;
+
+	err = mtk_pcie_parse_port(port);
+	if (err)
+		return err;
+
+	/* Don't touch the hardware registers before power up */
+	err = mtk_pcie_power_up(port);
+	if (err)
+		return err;
+
+	/* Try link up */
+	err = mtk_pcie_startup_port(port);
+	if (err)
+		goto err_setup;
+
+	return 0;
+
+err_setup:
+	mtk_pcie_power_down(port);
+
+	return err;
+}
+
+static int mtk_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mtk_pcie_port *port;
+	struct pci_host_bridge *host;
+	int err;
+
+	host = devm_pci_alloc_host_bridge(dev, sizeof(*port));
+	if (!host)
+		return -ENOMEM;
+
+	port = pci_host_bridge_priv(host);
+
+	port->dev = dev;
+	platform_set_drvdata(pdev, port);
+
+	err = mtk_pcie_setup(port);
+	if (err)
+		return err;
+
+	host->ops = &mtk_pcie_ops;
+	host->sysdata = port;
+
+	err = pci_host_probe(host);
+	if (err) {
+		mtk_pcie_power_down(port);
+		return err;
+	}
+
+	return 0;
+}
+
+static int mtk_pcie_remove(struct platform_device *pdev)
+{
+	struct mtk_pcie_port *port = platform_get_drvdata(pdev);
+	struct pci_host_bridge *host = pci_host_bridge_from_priv(port);
+
+	pci_lock_rescan_remove();
+	pci_stop_root_bus(host->bus);
+	pci_remove_root_bus(host->bus);
+	pci_unlock_rescan_remove();
+
+	mtk_pcie_power_down(port);
+
+	return 0;
+}
+
+static const struct of_device_id mtk_pcie_of_match[] = {
+	{ .compatible = "mediatek,mt8192-pcie" },
+	{},
+};
+
+static struct platform_driver mtk_pcie_driver = {
+	.probe = mtk_pcie_probe,
+	.remove = mtk_pcie_remove,
+	.driver = {
+		.name = "mtk-pcie",
+		.of_match_table = mtk_pcie_of_match,
+	},
+};
+
+module_platform_driver(mtk_pcie_driver);
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

