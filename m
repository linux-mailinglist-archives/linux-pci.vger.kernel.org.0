Return-Path: <linux-pci+bounces-36764-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD3DB95CB9
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 14:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF96118983DA
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 12:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A05322DA8;
	Tue, 23 Sep 2025 12:12:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE42322C9A;
	Tue, 23 Sep 2025 12:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758629567; cv=none; b=VpxFLkQHG7AvTM4otrgTynai2RU6sS+tZyP7bwGz39h/gQLKbDfmDS+Fp72dhdCGEjKrVTesxKHkdT6j6x/F1vqQoJSicv2UzIESNKl1961IzCdeQOkcps2ONkS/ltPcfyyzQ4pu8jXFlv4e1G2apk1bfZzfQutbWN0moCHQj7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758629567; c=relaxed/simple;
	bh=tLI9jm8gb4Eu7bXtPLfdul04UNRf5f6d+L4oBECjJ8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d++sTbOo5TIQdR5hWO9Ye5Eg/rPjGYu7U2weml1OM367vdHF78qZiCdRKItzUbcb8REzmcuwCdaB7Dv+bS89U3ZT3YpKn1OeC4bCDiHGcuszvLf5rRk3eRp0mxcen/69czRiSk2DHpM70QVJr/NDj1h3k4MHtwA7M+lp97HTyyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0004758DT.eswin.cn (unknown [10.12.96.83])
	by app1 (Coremail) with SMTP id TAJkCgB3mxGvjtJoqDPYAA--.28256S2;
	Tue, 23 Sep 2025 20:12:33 +0800 (CST)
From: zhangsenchuan@eswincomputing.com
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	p.zabel@pengutronix.de,
	johan+linaro@kernel.org,
	quic_schintav@quicinc.com,
	shradha.t@samsung.com,
	cassel@kernel.org,
	thippeswamy.havalige@amd.com,
	mayank.rana@oss.qualcomm.com,
	inochiama@gmail.com
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
	Yanghui Ou <ouyanghui@eswincomputing.com>
Subject: [PATCH v3 2/2] PCI: EIC7700: Add Eswin PCIe host controller driver
Date: Tue, 23 Sep 2025 20:12:27 +0800
Message-ID: <20250923121228.1255-1-zhangsenchuan@eswincomputing.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20250923120946.1218-1-zhangsenchuan@eswincomputing.com>
References: <20250923120946.1218-1-zhangsenchuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgB3mxGvjtJoqDPYAA--.28256S2
X-Coremail-Antispam: 1UD129KBjvAXoW3Kw4ftryrtF4rJw45KFyDKFg_yoW8Xr1UWo
	Z3Xrs3Xw1rGr18urZ7CF1agryxZa42qFW5Jrnav397Ca4kArn8trWUCw15Zw1akF48GFW5
	Xr1IqwnxuF4Ivr17n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYN7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
	Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7M4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE-syl42
	xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
	GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI4
	8JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4U
	JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
	C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRiBT5PUUUUU==
X-CM-SenderInfo: x2kd0wpvhquxxxdqqvxvzl0uprps33xlqjhudrp/

From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>

Add driver for the Eswin EIC7700 PCIe host controller,the controller is
based on the DesignWare PCIe core, IP revision 6.00a The PCIe Gen.3
controller supports a data rate of 8 GT/s and 4 channels, support INTX
and MSI interrupts.

Signed-off-by: Yu Ning <ningyu@eswincomputing.com>
Signed-off-by: Yanghui Ou <ouyanghui@eswincomputing.com>
Signed-off-by: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
---
 drivers/pci/controller/dwc/Kconfig        |  11 +
 drivers/pci/controller/dwc/Makefile       |   1 +
 drivers/pci/controller/dwc/pcie-eic7700.c | 446 ++++++++++++++++++++++
 3 files changed, 458 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-eic7700.c

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index ff6b6d9e18ec..8474bc6356f7 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -375,6 +375,17 @@ config PCI_EXYNOS
 	  hardware and therefore the driver re-uses the DesignWare core
 	  functions to implement the driver.
 
+config PCIE_EIC7700
+	bool "ESWIN PCIe controller"
+	depends on ARCH_ESWIN || COMPILE_TEST
+	depends on PCI_MSI
+	select PCIE_DW_HOST
+	help
+	  Say Y here if you want PCIe controller support for the ESWIN.
+	  The PCIe controller on Eswin is based on DesignWare hardware,
+	  enables support for the PCIe controller in the Eswin SoC to
+	  work in host mode.
+
 config PCIE_FU740
 	bool "SiFive FU740 PCIe controller"
 	depends on PCI_MSI
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index 6919d27798d1..97b2ac4eb949 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_PCIE_AMD_MDB) += pcie-amd-mdb.o
 obj-$(CONFIG_PCIE_BT1) += pcie-bt1.o
 obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
 obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
+obj-$(CONFIG_PCIE_EIC7700) += pcie-eic7700.o
 obj-$(CONFIG_PCIE_FU740) += pcie-fu740.o
 obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
 obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
diff --git a/drivers/pci/controller/dwc/pcie-eic7700.c b/drivers/pci/controller/dwc/pcie-eic7700.c
new file mode 100644
index 000000000000..32da4a645bef
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-eic7700.c
@@ -0,0 +1,446 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ESWIN PCIe root complex driver
+ *
+ * Copyright 2025, Beijing ESWIN Computing Technology Co., Ltd.
+ *
+ * Authors: Yu Ning <ningyu@eswincomputing.com>
+ *          Senchuan Zhang <zhangsenchuan@eswincomputing.com>
+ *          Yanghui Ou <ouyanghui@eswincomputing.com>
+ */
+
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/resource.h>
+#include <linux/reset.h>
+#include <linux/types.h>
+
+#include "pcie-designware.h"
+
+/* PCIe top csr registers */
+#define PCIEMGMT_CTRL0_OFFSET		0x0
+#define PCIEMGMT_STATUS0_OFFSET		0x100
+
+/* LTSSM register fields */
+#define PCIEMGMT_APP_LTSSM_ENABLE	BIT(5)
+
+/* APP_HOLD_PHY_RST register fields */
+#define PCIEMGMT_APP_HOLD_PHY_RST	BIT(6)
+
+/* PM_SEL_AUX_CLK register fields */
+#define PCIEMGMT_PM_SEL_AUX_CLK		BIT(16)
+
+/* ROOT_PORT register fields */
+#define PCIEMGMT_CTRL0_ROOT_PORT_MASK	GENMASK(3, 0)
+
+/* Vendor and device id value */
+#define VENDOR_ID_VALUE			0x1fe1
+#define DEVICE_ID_VALUE			0x2030
+
+/* Disable MSI-X cap register fields */
+#define PCIE_MSIX_DISABLE_MASK		GENMASK(15, 8)
+
+struct eswin_pcie_data {
+	bool msix_cap;
+};
+
+struct eswin_pcie_port {
+	struct list_head list;
+	struct reset_control *perst;
+	int num_lanes;
+};
+
+struct eswin_pcie {
+	struct dw_pcie pci;
+	void __iomem *mgmt_base;
+	struct clk_bulk_data *clks;
+	struct reset_control *powerup_rst;
+	struct reset_control *cfg_rst;
+	struct list_head ports;
+	int num_clks;
+	bool suspended;
+	bool msix_cap;
+};
+
+#define to_eswin_pcie(x) dev_get_drvdata((x)->dev)
+
+static int eswin_pcie_start_link(struct dw_pcie *pci)
+{
+	struct eswin_pcie *pcie = to_eswin_pcie(pci);
+	u32 val;
+
+	/* Enable LTSSM */
+	val = readl_relaxed(pcie->mgmt_base + PCIEMGMT_CTRL0_OFFSET);
+	val |= PCIEMGMT_APP_LTSSM_ENABLE;
+	writel_relaxed(val, pcie->mgmt_base + PCIEMGMT_CTRL0_OFFSET);
+
+	return 0;
+}
+
+static bool eswin_pcie_link_up(struct dw_pcie *pci)
+{
+	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u16 val = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
+
+	return val & PCI_EXP_LNKSTA_DLLLA;
+}
+
+static int eswin_pcie_deassert(struct eswin_pcie *pcie)
+{
+	int ret;
+
+	ret = reset_control_deassert(pcie->cfg_rst);
+	if (ret) {
+		dev_err(pcie->pci.dev, "Failed to deassert CFG#");
+		return ret;
+	}
+
+	ret = reset_control_deassert(pcie->powerup_rst);
+	if (ret) {
+		dev_err(pcie->pci.dev, "Failed to deassert POWERUP#");
+		goto err_powerup;
+	}
+
+	return 0;
+
+err_powerup:
+	reset_control_assert(pcie->cfg_rst);
+
+	return ret;
+}
+
+static void eswin_pcie_assert(struct eswin_pcie *pcie)
+{
+	reset_control_assert(pcie->powerup_rst);
+	reset_control_assert(pcie->cfg_rst);
+}
+
+static int eswin_pcie_perst_deassert(struct eswin_pcie_port *port,
+				     struct eswin_pcie *pcie)
+{
+	int ret;
+
+	ret = reset_control_assert(port->perst);
+	if (ret) {
+		dev_err(pcie->pci.dev, "Failed to assert PERST#");
+		goto err_perst;
+	}
+
+	/* Ensure that PERST has been asserted for at least 100 ms */
+	msleep(PCIE_T_PVPERL_MS);
+
+	ret = reset_control_deassert(port->perst);
+	if (ret) {
+		dev_err(pcie->pci.dev, "Failed to deassert PERST#");
+		goto err_perst;
+	}
+
+	return 0;
+
+err_perst:
+	list_for_each_entry(port, &pcie->ports, list)
+		reset_control_put(port->perst);
+
+	return ret;
+}
+
+static int eswin_pcie_parse_port(struct eswin_pcie *pcie,
+				 struct device_node *node)
+{
+	struct device *dev = pcie->pci.dev;
+	struct eswin_pcie_port *port;
+
+	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	port->perst = of_reset_control_get(node, "perst");
+	if (IS_ERR(port->perst)) {
+		dev_err(dev, "Failed to get perst reset\n");
+		return PTR_ERR(port->perst);
+	}
+
+	/*
+	 * Since the root port node is separated out by pcie devicetree, the
+	 * DWC core initialization code cannot parse the num-lanes attribute
+	 * in the root port. Before entering the DWC core initialization code,
+	 * the platform driver code parses the root port node. The EIC7700 only
+	 * supports one root port node, and the num-lanes attribute is suitable
+	 * for the case of one root port.
+	*/
+	of_property_read_u32(node, "num-lanes", &port->num_lanes);
+	pcie->pci.num_lanes = port->num_lanes;
+
+	INIT_LIST_HEAD(&port->list);
+	list_add_tail(&port->list, &pcie->ports);
+
+	return 0;
+}
+
+static int eswin_pcie_parse_ports(struct eswin_pcie *pcie)
+{
+	struct device *dev = pcie->pci.dev;
+	struct eswin_pcie_port *port, *tmp;
+	int ret;
+
+	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
+		ret = eswin_pcie_parse_port(pcie, of_port);
+		if (ret)
+			goto err_port;
+	}
+
+	return ret;
+
+err_port:
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
+		list_del(&port->list);
+	return ret;
+}
+
+static void eswin_pcie_hide_broken_msix_cap(struct dw_pcie *pci)
+{
+	u16 offset, val;
+
+	/*
+	 * Hardware doesn't support MSI-X but it advertises MSI-X capability,
+	 * to avoid this problem, the MSI-X capability in the PCIe capabilities
+	 * linked-list needs to be disabled. Since the PCI Express capability
+	 * structure's next pointer points to the MSI-X capability, and the
+	 * MSI-X capability's next pointer is null (00H), so only the PCI
+	 * Express capability structure's next pointer needs to be set 00H.
+	 */
+	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	val = dw_pcie_readl_dbi(pci, offset);
+	val &= ~PCIE_MSIX_DISABLE_MASK;
+	dw_pcie_writel_dbi(pci, offset, val);
+}
+
+static int eswin_pcie_host_init(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct eswin_pcie *pcie = to_eswin_pcie(pci);
+	struct eswin_pcie_port *port;
+	u32 retries;
+	u8 msi_cap;
+	u32 val;
+	int ret;
+
+	pcie->num_clks = devm_clk_bulk_get_all_enabled(pci->dev, &pcie->clks);
+	if (pcie->num_clks < 0)
+		return dev_err_probe(pci->dev, pcie->num_clks,
+				     "Failed to get pcie clocks\n");
+
+	ret = eswin_pcie_deassert(pcie);
+	if (ret)
+		return ret;
+
+	/* Configure root port type */
+	val = readl_relaxed(pcie->mgmt_base + PCIEMGMT_CTRL0_OFFSET);
+	val &= ~PCIEMGMT_CTRL0_ROOT_PORT_MASK;
+	writel_relaxed(val | PCI_EXP_TYPE_ROOT_PORT,
+		       pcie->mgmt_base + PCIEMGMT_CTRL0_OFFSET);
+
+	list_for_each_entry(port, &pcie->ports, list) {
+		ret = eswin_pcie_perst_deassert(port, pcie);
+			if (ret)
+				goto err_perst;
+	}
+
+	/* Configure app_hold_phy_rst */
+	val = readl_relaxed(pcie->mgmt_base + PCIEMGMT_CTRL0_OFFSET);
+	val &= ~PCIEMGMT_APP_HOLD_PHY_RST;
+	writel_relaxed(val, pcie->mgmt_base + PCIEMGMT_CTRL0_OFFSET);
+
+	/* The maximum waiting time for the clock switch lock is 20ms */
+	retries = 20;
+	do {
+		val = readl_relaxed(pcie->mgmt_base + PCIEMGMT_STATUS0_OFFSET);
+		if (!(val & PCIEMGMT_PM_SEL_AUX_CLK))
+			break;
+		fsleep(1000);
+		retries--;
+	} while (retries);
+
+	if (!retries) {
+		dev_err(pci->dev, "Timeout waiting for PM_SEL_AUX_CLK ready\n");
+		ret = -ETIMEDOUT;
+		goto err_phy_init;
+	}
+
+	/*
+	 * Configure ESWIN VID:DID for Root Port as the default values are
+	 * invalid.
+	 */
+	dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, VENDOR_ID_VALUE);
+	dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, DEVICE_ID_VALUE);
+
+	/* Configure support 32 MSI vectors */
+	msi_cap = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
+	val = dw_pcie_readw_dbi(pci, msi_cap + PCI_MSI_FLAGS);
+	val &= ~PCI_MSI_FLAGS_QMASK;
+	val |= FIELD_PREP(PCI_MSI_FLAGS_QMASK, 5);
+	dw_pcie_writew_dbi(pci, msi_cap + PCI_MSI_FLAGS, val);
+
+	/* Configure disable MSI-X cap */
+	if (!pcie->msix_cap)
+		eswin_pcie_hide_broken_msix_cap(pci);
+
+	return 0;
+
+err_phy_init:
+	list_for_each_entry(port, &pcie->ports, list)
+		reset_control_assert(port->perst);
+err_perst:
+	eswin_pcie_assert(pcie);
+
+	return ret;
+}
+
+static const struct dw_pcie_host_ops eswin_pcie_host_ops = {
+	.init = eswin_pcie_host_init,
+};
+
+static const struct dw_pcie_ops dw_pcie_ops = {
+	.start_link = eswin_pcie_start_link,
+	.link_up = eswin_pcie_link_up,
+};
+
+static int eswin_pcie_probe(struct platform_device *pdev)
+{
+	const struct eswin_pcie_data *data;
+	struct eswin_pcie_port *port, *tmp;
+	struct device *dev = &pdev->dev;
+	struct eswin_pcie *pcie;
+	struct dw_pcie *pci;
+	int ret;
+
+	data = of_device_get_match_data(dev);
+	if (!data)
+		return dev_err_probe(dev, -EINVAL, "OF data missing\n");
+
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&pcie->ports);
+
+	pci = &pcie->pci;
+	pci->dev = dev;
+	pci->ops = &dw_pcie_ops;
+	pci->pp.ops = &eswin_pcie_host_ops;
+	pcie->msix_cap = data->msix_cap;
+
+	pcie->mgmt_base = devm_platform_ioremap_resource_byname(pdev, "mgmt");
+	if (IS_ERR(pcie->mgmt_base))
+		return dev_err_probe(dev, PTR_ERR(pcie->mgmt_base),
+				     "Failed to map mgmt registers\n");
+
+	pcie->powerup_rst = devm_reset_control_get(&pdev->dev, "powerup");
+	if (IS_ERR(pcie->powerup_rst))
+		return dev_err_probe(dev, PTR_ERR(pcie->powerup_rst),
+				     "Failed to get powerup reset\n");
+
+	pcie->cfg_rst = devm_reset_control_get(&pdev->dev, "cfg");
+	if (IS_ERR(pcie->cfg_rst))
+		return dev_err_probe(dev, PTR_ERR(pcie->cfg_rst),
+				     "Failed to get cfg reset\n");
+
+	ret = eswin_pcie_parse_ports(pcie);
+	if (ret)
+		dev_err_probe(pci->dev, ret,
+			      "Failed to parse Root Port: %d\n", ret);
+
+	platform_set_drvdata(pdev, pcie);
+
+	ret = dw_pcie_host_init(&pci->pp);
+	if (ret) {
+		dev_err(dev, "Failed to initialize host\n");
+		goto err_init;
+	}
+
+	return ret;
+
+err_init:
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
+		list_del(&port->list);
+		reset_control_put(port->perst);
+	}
+	return ret;
+}
+
+static int eswin_pcie_suspend(struct device *dev)
+{
+	struct eswin_pcie *pcie = dev_get_drvdata(dev);
+	struct eswin_pcie_port *port;
+
+	/*
+	 * For controllers with active devices, resources are retained and
+	 * cannot be turned off.
+	 */
+	if (!dw_pcie_link_up(&pcie->pci)) {
+		list_for_each_entry(port, &pcie->ports, list)
+			reset_control_assert(port->perst);
+		eswin_pcie_assert(pcie);
+		clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
+		pcie->suspended = true;
+	}
+
+	return 0;
+}
+
+static int eswin_pcie_resume(struct device *dev)
+{
+	struct eswin_pcie *pcie = dev_get_drvdata(dev);
+	int ret;
+
+	if (!pcie->suspended)
+		return 0;
+
+	ret = eswin_pcie_host_init(&pcie->pci.pp);
+	if (ret) {
+		dev_err(dev, "Failed to init host: %d\n", ret);
+		return ret;
+	}
+
+	dw_pcie_setup_rc(&pcie->pci.pp);
+	eswin_pcie_start_link(&pcie->pci);
+	dw_pcie_wait_for_link(&pcie->pci);
+
+	pcie->suspended = false;
+
+	return 0;
+}
+
+static const struct dev_pm_ops eswin_pcie_pm_ops = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(eswin_pcie_suspend, eswin_pcie_resume)
+};
+
+static const struct eswin_pcie_data eswin_7700_data = {
+	.msix_cap = false,
+};
+
+static const struct of_device_id eswin_pcie_of_match[] = {
+	{ .compatible = "eswin,eic7700-pcie", .data = &eswin_7700_data },
+	{},
+};
+
+static struct platform_driver eswin_pcie_driver = {
+	.probe = eswin_pcie_probe,
+	.driver = {
+		.name = "eic7700-pcie",
+		.of_match_table = eswin_pcie_of_match,
+		.suppress_bind_attrs = true,
+		.pm = &eswin_pcie_pm_ops,
+	},
+};
+builtin_platform_driver(eswin_pcie_driver);
+
+MODULE_DESCRIPTION("PCIe host controller driver for EIC7700 SoCs");
+MODULE_AUTHOR("Yu Ning <ningyu@eswincomputing.com>");
+MODULE_AUTHOR("Senchuan Zhang <zhangsenchuan@eswincomputing.com>");
+MODULE_AUTHOR("Yanghui Ou <ouyanghui@eswincomputing.com>");
+MODULE_LICENSE("GPL");
-- 
2.25.1


