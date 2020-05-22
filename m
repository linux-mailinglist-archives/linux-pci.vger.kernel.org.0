Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC76F1DDE23
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 05:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgEVDhl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 23:37:41 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50158 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbgEVDhi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 May 2020 23:37:38 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04M3bOgG038294;
        Thu, 21 May 2020 22:37:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590118644;
        bh=RwLvhmNnnH2VW9QLiy9GMO2qxd6KfQ6LK/Fqbq2Nruc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hklXDf1ndTD7sA15Hyhlcq2zoTBX9LcFixJe5LHmUUkLiq8tPBF8pzVZPhl+ynQeG
         CaL7WbP4RmXHcK62lic1ZpBlIGUqBRoZ0M/GjGAg22hQ2k7SU+68KhqdrYRstLtZ4r
         xqJ/PyyZxkkAPo+56U6+SWY8vBEOtjwqXBZ+Ow/c=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04M3bOE1027559
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 May 2020 22:37:24 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 21
 May 2020 22:37:23 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 21 May 2020 22:37:23 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04M3aYc8062596;
        Thu, 21 May 2020 22:37:20 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v5 12/14] PCI: j721e: Add TI J721E PCIe driver
Date:   Fri, 22 May 2020 09:06:29 +0530
Message-ID: <20200522033631.32574-13-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200522033631.32574-1-kishon@ti.com>
References: <20200522033631.32574-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for PCIe controller in J721E SoC. The controller uses the
Cadence PCIe core programmed by pcie-cadence*.c. The PCIe controller
will work in both host mode and device mode.
Some of the features of the controller are:
  *) Supports both RC mode and EP mode
  *) Supports MSI and MSI-X support
  *) Supports upto GEN3 speed mode
  *) Supports SR-IOV capability
  *) Ability to route all transactions via SMMU (support will be added
     in a later patch).

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/cadence/Kconfig        |  23 +
 drivers/pci/controller/cadence/Makefile       |   1 +
 drivers/pci/controller/cadence/pci-j721e.c    | 490 ++++++++++++++++++
 .../controller/cadence/pcie-cadence-host.c    |   4 +-
 drivers/pci/controller/cadence/pcie-cadence.h |   8 +
 5 files changed, 524 insertions(+), 2 deletions(-)
 create mode 100644 drivers/pci/controller/cadence/pci-j721e.c

diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
index b76b3cf55ce5..5d30564190e1 100644
--- a/drivers/pci/controller/cadence/Kconfig
+++ b/drivers/pci/controller/cadence/Kconfig
@@ -42,4 +42,27 @@ config PCIE_CADENCE_PLAT_EP
 	  endpoint mode. This PCIe controller may be embedded into many
 	  different vendors SoCs.
 
+config PCI_J721E
+	bool
+
+config PCI_J721E_HOST
+	bool "TI J721E PCIe platform host controller"
+	depends on OF
+	select PCIE_CADENCE_HOST
+	select PCI_J721E
+	help
+	  Say Y here if you want to support the TI J721E PCIe platform
+	  controller in host mode. TI J721E PCIe controller uses Cadence PCIe
+	  core.
+
+config PCI_J721E_EP
+	bool "TI J721E PCIe platform endpoint controller"
+	depends on OF
+	depends on PCI_ENDPOINT
+	select PCIE_CADENCE_EP
+	select PCI_J721E
+	help
+	  Say Y here if you want to support the TI J721E PCIe platform
+	  controller in endpoint mode. TI J721E PCIe controller uses Cadence PCIe
+	  core.
 endmenu
diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
index 232a3f20876a..9bac5fb2f13d 100644
--- a/drivers/pci/controller/cadence/Makefile
+++ b/drivers/pci/controller/cadence/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence.o
 obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
 obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
 obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
+obj-$(CONFIG_PCI_J721E) += pci-j721e.o
diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
new file mode 100644
index 000000000000..9b3ab880a3c5
--- /dev/null
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -0,0 +1,490 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * pci-j721e - PCIe controller driver for TI's J721E SoCs
+ *
+ * Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com
+ * Author: Kishon Vijay Abraham I <kishon@ti.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/io.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/pci.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+
+#include "../../pci.h"
+#include "pcie-cadence.h"
+
+#define ENABLE_REG_SYS_2	0x108
+#define STATUS_REG_SYS_2	0x508
+#define STATUS_CLR_REG_SYS_2	0x708
+#define LINK_DOWN		BIT(1)
+
+#define J721E_PCIE_USER_CMD_STATUS	0x4
+#define LINK_TRAINING_ENABLE		BIT(0)
+
+#define J721E_PCIE_USER_LINKSTATUS	0x14
+#define LINK_STATUS			GENMASK(1, 0)
+
+enum link_status {
+	NO_RECEIVERS_DETECTED,
+	LINK_TRAINING_IN_PROGRESS,
+	LINK_UP_DL_IN_PROGRESS,
+	LINK_UP_DL_COMPLETED,
+};
+
+#define J721E_MODE_RC			BIT(7)
+#define LANE_COUNT_MASK			BIT(8)
+#define LANE_COUNT(n)			((n) << 8)
+
+#define GENERATION_SEL_MASK		GENMASK(1, 0)
+
+#define MAX_LANES			2
+
+struct j721e_pcie {
+	struct device		*dev;
+	u32			mode;
+	u32			num_lanes;
+	struct cdns_pcie	*cdns_pcie;
+	void __iomem		*user_cfg_base;
+	void __iomem		*intd_cfg_base;
+};
+
+enum j721e_pcie_mode {
+	PCI_MODE_RC,
+	PCI_MODE_EP,
+};
+
+struct j721e_pcie_data {
+	enum j721e_pcie_mode	mode;
+};
+
+static inline u32 j721e_pcie_user_readl(struct j721e_pcie *pcie, u32 offset)
+{
+	return readl(pcie->user_cfg_base + offset);
+}
+
+static inline void j721e_pcie_user_writel(struct j721e_pcie *pcie, u32 offset,
+					  u32 value)
+{
+	writel(value, pcie->user_cfg_base + offset);
+}
+
+static inline u32 j721e_pcie_intd_readl(struct j721e_pcie *pcie, u32 offset)
+{
+	return readl(pcie->intd_cfg_base + offset);
+}
+
+static inline void j721e_pcie_intd_writel(struct j721e_pcie *pcie, u32 offset,
+					  u32 value)
+{
+	writel(value, pcie->intd_cfg_base + offset);
+}
+
+static irqreturn_t j721e_pcie_link_irq_handler(int irq, void *priv)
+{
+	struct j721e_pcie *pcie = priv;
+	struct device *dev = pcie->dev;
+	u32 reg;
+
+	reg = j721e_pcie_intd_readl(pcie, STATUS_REG_SYS_2);
+	if (!(reg & LINK_DOWN))
+		return IRQ_NONE;
+
+	dev_err(dev, "LINK DOWN!\n");
+
+	j721e_pcie_intd_writel(pcie, STATUS_CLR_REG_SYS_2, LINK_DOWN);
+	return IRQ_HANDLED;
+}
+
+static void j721e_pcie_config_link_irq(struct j721e_pcie *pcie)
+{
+	u32 reg;
+
+	reg = j721e_pcie_intd_readl(pcie, ENABLE_REG_SYS_2);
+	reg |= LINK_DOWN;
+	j721e_pcie_intd_writel(pcie, ENABLE_REG_SYS_2, reg);
+}
+
+static int j721e_pcie_start_link(struct cdns_pcie *cdns_pcie)
+{
+	struct j721e_pcie *pcie = dev_get_drvdata(cdns_pcie->dev);
+	u32 reg;
+
+	reg = j721e_pcie_user_readl(pcie, J721E_PCIE_USER_CMD_STATUS);
+	reg |= LINK_TRAINING_ENABLE;
+	j721e_pcie_user_writel(pcie, J721E_PCIE_USER_CMD_STATUS, reg);
+
+	return 0;
+}
+
+static void j721e_pcie_stop_link(struct cdns_pcie *cdns_pcie)
+{
+	struct j721e_pcie *pcie = dev_get_drvdata(cdns_pcie->dev);
+	u32 reg;
+
+	reg = j721e_pcie_user_readl(pcie, J721E_PCIE_USER_CMD_STATUS);
+	reg &= ~LINK_TRAINING_ENABLE;
+	j721e_pcie_user_writel(pcie, J721E_PCIE_USER_CMD_STATUS, reg);
+}
+
+static bool j721e_pcie_link_up(struct cdns_pcie *cdns_pcie)
+{
+	struct j721e_pcie *pcie = dev_get_drvdata(cdns_pcie->dev);
+	u32 reg;
+
+	reg = j721e_pcie_user_readl(pcie, J721E_PCIE_USER_LINKSTATUS);
+	reg &= LINK_STATUS;
+	if (reg == LINK_UP_DL_COMPLETED)
+		return true;
+
+	return false;
+}
+
+static const struct cdns_pcie_ops j721e_ops_ops = {
+	.start_link = j721e_pcie_start_link,
+	.stop_link = j721e_pcie_stop_link,
+	.link_up = j721e_pcie_link_up,
+};
+
+static int j721e_pcie_set_mode(struct j721e_pcie *pcie, struct regmap *syscon)
+{
+	struct device *dev = pcie->dev;
+	u32 mask = J721E_MODE_RC;
+	u32 mode = pcie->mode;
+	u32 val = 0;
+	int ret = 0;
+
+	if (mode == PCI_MODE_RC)
+		val = J721E_MODE_RC;
+
+	ret = regmap_update_bits(syscon, 0, mask, val);
+	if (ret)
+		dev_err(dev, "failed to set pcie mode\n");
+
+	return ret;
+}
+
+static int j721e_pcie_set_link_speed(struct j721e_pcie *pcie,
+				     struct regmap *syscon)
+{
+	struct device *dev = pcie->dev;
+	struct device_node *np = dev->of_node;
+	int link_speed;
+	u32 val = 0;
+	int ret;
+
+	link_speed = of_pci_get_max_link_speed(np);
+	if (link_speed < 2)
+		link_speed = 2;
+
+	val = link_speed - 1;
+	ret = regmap_update_bits(syscon, 0, GENERATION_SEL_MASK, val);
+	if (ret)
+		dev_err(dev, "failed to set link speed\n");
+
+	return ret;
+}
+
+static int j721e_pcie_set_lane_count(struct j721e_pcie *pcie,
+				     struct regmap *syscon)
+{
+	struct device *dev = pcie->dev;
+	u32 lanes = pcie->num_lanes;
+	u32 val = 0;
+	int ret;
+
+	val = LANE_COUNT(lanes - 1);
+	ret = regmap_update_bits(syscon, 0, LANE_COUNT_MASK, val);
+	if (ret)
+		dev_err(dev, "failed to set link count\n");
+
+	return ret;
+}
+
+static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
+{
+	struct device *dev = pcie->dev;
+	struct device_node *node = dev->of_node;
+	struct regmap *syscon;
+	int ret;
+
+	syscon = syscon_regmap_lookup_by_phandle(node, "ti,syscon-pcie-ctrl");
+	if (IS_ERR(syscon)) {
+		dev_err(dev, "Unable to get ti,syscon-pcie-ctrl regmap\n");
+		return PTR_ERR(syscon);
+	}
+
+	ret = j721e_pcie_set_mode(pcie, syscon);
+	if (ret < 0) {
+		dev_err(dev, "Failed to set pci mode\n");
+		return ret;
+	}
+
+	ret = j721e_pcie_set_link_speed(pcie, syscon);
+	if (ret < 0) {
+		dev_err(dev, "Failed to set link speed\n");
+		return ret;
+	}
+
+	ret = j721e_pcie_set_lane_count(pcie, syscon);
+	if (ret < 0) {
+		dev_err(dev, "Failed to set num-lanes\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cdns_ti_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
+				    int where, int size, u32 *value)
+{
+	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
+	struct cdns_pcie_rc *rc = pci_host_bridge_priv(bridge);
+	unsigned int busn = bus->number;
+
+	if (busn == rc->bus_range->start)
+		return pci_generic_config_read32(bus, devfn, where, size,
+						 value);
+
+	return pci_generic_config_read(bus, devfn, where, size, value);
+}
+
+static int cdns_ti_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
+				     int where, int size, u32 value)
+{
+	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
+	struct cdns_pcie_rc *rc = pci_host_bridge_priv(bridge);
+	unsigned int busn = bus->number;
+
+	if (busn == rc->bus_range->start)
+		return pci_generic_config_write32(bus, devfn, where, size,
+						  value);
+
+	return pci_generic_config_write(bus, devfn, where, size, value);
+}
+
+static struct pci_ops cdns_ti_pcie_host_ops = {
+	.map_bus	= cdns_pci_map_bus,
+	.read		= cdns_ti_pcie_config_read,
+	.write		= cdns_ti_pcie_config_write,
+};
+
+static const struct j721e_pcie_data j721e_pcie_rc_data = {
+	.mode = PCI_MODE_RC,
+};
+
+static const struct j721e_pcie_data j721e_pcie_ep_data = {
+	.mode = PCI_MODE_EP,
+};
+
+static const struct of_device_id of_j721e_pcie_match[] = {
+	{
+		.compatible = "ti,j721e-pcie-host",
+		.data = &j721e_pcie_rc_data,
+	},
+	{
+		.compatible = "ti,j721e-pcie-ep",
+		.data = &j721e_pcie_ep_data,
+	},
+	{},
+};
+
+static int j721e_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+	struct pci_host_bridge *bridge;
+	struct j721e_pcie_data *data;
+	struct cdns_pcie *cdns_pcie;
+	struct j721e_pcie *pcie;
+	struct cdns_pcie_rc *rc;
+	struct cdns_pcie_ep *ep;
+	struct gpio_desc *gpiod;
+	void __iomem *base;
+	u32 num_lanes;
+	u32 mode;
+	int ret;
+	int irq;
+
+	data = (struct j721e_pcie_data *)of_device_get_match_data(dev);
+	if (!data)
+		return -EINVAL;
+
+	mode = (u32)data->mode;
+
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	pcie->dev = dev;
+	pcie->mode = mode;
+
+	base = devm_platform_ioremap_resource_byname(pdev, "intd_cfg");
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+	pcie->intd_cfg_base = base;
+
+	base = devm_platform_ioremap_resource_byname(pdev, "user_cfg");
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+	pcie->user_cfg_base = base;
+
+	ret = of_property_read_u32(node, "num-lanes", &num_lanes);
+	if (ret || num_lanes > MAX_LANES)
+		num_lanes = 1;
+	pcie->num_lanes = num_lanes;
+
+	irq = platform_get_irq_byname(pdev, "link_state");
+	if (irq < 0)
+		return irq;
+
+	dev_set_drvdata(dev, pcie);
+	pm_runtime_enable(dev);
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		dev_err(dev, "pm_runtime_get_sync failed\n");
+		goto err_get_sync;
+	}
+
+	ret = j721e_pcie_ctrl_init(pcie);
+	if (ret < 0) {
+		dev_err(dev, "pm_runtime_get_sync failed\n");
+		goto err_get_sync;
+	}
+
+	ret = devm_request_irq(dev, irq, j721e_pcie_link_irq_handler, 0,
+			       "j721e-pcie-link-down-irq", pcie);
+	if (ret < 0) {
+		dev_err(dev, "failed to request link state IRQ %d\n", irq);
+		goto err_get_sync;
+	}
+
+	j721e_pcie_config_link_irq(pcie);
+
+	switch (mode) {
+	case PCI_MODE_RC:
+		if (!IS_ENABLED(CONFIG_PCIE_CADENCE_HOST)) {
+			ret = -ENODEV;
+			goto err_get_sync;
+		}
+
+		bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
+		if (!bridge) {
+			ret = -ENOMEM;
+			goto err_get_sync;
+		}
+
+		bridge->ops = &cdns_ti_pcie_host_ops;
+		rc = pci_host_bridge_priv(bridge);
+
+		cdns_pcie = &rc->pcie;
+		cdns_pcie->dev = dev;
+		cdns_pcie->ops = &j721e_ops_ops;
+		pcie->cdns_pcie = cdns_pcie;
+
+		gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+		if (IS_ERR(gpiod)) {
+			ret = PTR_ERR(gpiod);
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "Failed to get reset GPIO\n");
+			goto err_get_sync;
+		}
+
+		ret = cdns_pcie_init_phy(dev, cdns_pcie);
+		if (ret) {
+			dev_err(dev, "Failed to init phy\n");
+			goto err_get_sync;
+		}
+
+		/*
+		 * "Power Sequencing and Reset Signal Timings" table in
+		 * PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION, REV. 3.0
+		 * indicates PERST# should be deasserted after minimum of 100us
+		 * once REFCLK is stable. The REFCLK to the connector in RC
+		 * mode is selected while enabling the PHY. So deassert PERST#
+		 * after 100 us.
+		 */
+		if (gpiod) {
+			usleep_range(100, 200);
+			gpiod_set_value_cansleep(gpiod, 1);
+		}
+
+		ret = cdns_pcie_host_setup(rc);
+		if (ret < 0)
+			goto err_pcie_setup;
+
+		break;
+	case PCI_MODE_EP:
+		if (!IS_ENABLED(CONFIG_PCIE_CADENCE_EP)) {
+			ret = -ENODEV;
+			goto err_get_sync;
+		}
+
+		ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
+		if (!ep) {
+			ret = -ENOMEM;
+			goto err_get_sync;
+		}
+
+		cdns_pcie = &ep->pcie;
+		cdns_pcie->dev = dev;
+		cdns_pcie->ops = &j721e_ops_ops;
+		pcie->cdns_pcie = cdns_pcie;
+
+		ret = cdns_pcie_init_phy(dev, cdns_pcie);
+		if (ret) {
+			dev_err(dev, "Failed to init phy\n");
+			goto err_get_sync;
+		}
+
+		ret = cdns_pcie_ep_setup(ep);
+		if (ret < 0)
+			goto err_pcie_setup;
+
+		break;
+	default:
+		dev_err(dev, "INVALID device type %d\n", mode);
+	}
+
+	return 0;
+
+err_pcie_setup:
+	cdns_pcie_disable_phy(cdns_pcie);
+
+err_get_sync:
+	pm_runtime_put(dev);
+	pm_runtime_disable(dev);
+
+	return ret;
+}
+
+static int j721e_pcie_remove(struct platform_device *pdev)
+{
+	struct j721e_pcie *pcie = platform_get_drvdata(pdev);
+	struct cdns_pcie *cdns_pcie = pcie->cdns_pcie;
+	struct device *dev = &pdev->dev;
+
+	cdns_pcie_disable_phy(cdns_pcie);
+	pm_runtime_put(dev);
+	pm_runtime_disable(dev);
+
+	return 0;
+}
+
+static struct platform_driver j721e_pcie_driver = {
+	.probe  = j721e_pcie_probe,
+	.remove = j721e_pcie_remove,
+	.driver = {
+		.name	= "j721e-pcie",
+		.of_match_table = of_j721e_pcie_match,
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver(j721e_pcie_driver);
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 7ee9e06f1285..cf8b34b71b8f 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -17,8 +17,8 @@ static u64 bar_max_size[] = {
 	[RP_NO_BAR] = _BITULL(63),
 };
 
-static void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
-				      int where)
+void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
+			       int where)
 {
 	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
 	struct cdns_pcie_rc *rc = pci_host_bridge_priv(bridge);
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 1bf7d4e09b8a..f8e8144e222d 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -469,11 +469,19 @@ static inline bool cdns_pcie_link_up(struct cdns_pcie *pcie)
 
 #ifdef CONFIG_PCIE_CADENCE_HOST
 int cdns_pcie_host_setup(struct cdns_pcie_rc *rc);
+void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
+			       int where);
 #else
 static inline int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 {
 	return 0;
 }
+
+static void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
+				      int where)
+{
+	return NULL;
+}
 #endif
 
 #ifdef CONFIG_PCIE_CADENCE_EP
-- 
2.17.1

