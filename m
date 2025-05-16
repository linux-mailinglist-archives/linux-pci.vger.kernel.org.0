Return-Path: <linux-pci+bounces-27844-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC51AAB991D
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 11:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 073453BB5A1
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 09:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C8F231826;
	Fri, 16 May 2025 09:43:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EFE23315C;
	Fri, 16 May 2025 09:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747388629; cv=none; b=FrUR17vCNRAFmbHwbAt2qLqVaKRzK/QgELTx+jbWYIpe5jM4fD0K8WAshE3alup+zd5lsf1me3wvW27PC+11CeAcQYiJDFrnDe18HB40HjWI/FBzZGg7Zd3iDT5B4syLVvr/vjyRRcg36MUEuwUm445nTvE3CDOvPZUUH7U/PpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747388629; c=relaxed/simple;
	bh=ZeN1/RCYbStfo+goph2p2P5AN78zGC7EvLUzRMIiCfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KVXkZthUu3D+b0cgtozhWgofFcTTS4MdyP2c2boDcg9W8HgaNICS7nVZiSXQ7tDHGrwX4uZW7pSy6Cv4dtdPeXmqcM4ttyqVVVMC06Bjk5tti+I1qEnN+rU7BES6RuiNL92GrltKgT2ydSNHKQAqTF8f0vYA7jhwh+3OSeegsGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0004758DT.eswin.cn (unknown [10.12.96.83])
	by app1 (Coremail) with SMTP id TAJkCgAXLxC8CCdo3st8AA--.47476S2;
	Fri, 16 May 2025 17:43:26 +0800 (CST)
From: zhangsenchuan@eswincomputing.com
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.or,
	linux-kernel@vger.kernel.org,
	p.zabel@pengutronix.de,
	johan+linaro@kernel.org,
	quic_schintav@quicinc.com,
	shradha.t@samsung.com,
	cassel@kernel.org,
	thippeswamy.havalige@amd.com
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>
Subject: [PATCH v1 2/2] PCI: eic7700: Add Eswin eic7700 PCIe host controller driver
Date: Fri, 16 May 2025 17:43:14 +0800
Message-ID: <20250516094315.179-1-zhangsenchuan@eswincomputing.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20250516094057.1300-1-zhangsenchuan@eswincomputing.com>
References: <20250516094057.1300-1-zhangsenchuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgAXLxC8CCdo3st8AA--.47476S2
X-Coremail-Antispam: 1UD129KBjvAXoW3Kw4kCrWrtF1rJFy7ZFWxtFb_yoW8Gw1xGo
	Z7Xr93W3WxJr1rArZ2vF1aga47Za42qa9xJrn09rZ7C3s7Arn8Kr1DCw15Zw1akF4rKFW5
	Zr1DJwnxuF48Zw1Un29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYN7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
	Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7M4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE-syl42
	xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
	GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI4
	8JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4U
	JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
	C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRihF4tUUUUU==
X-CM-SenderInfo: x2kd0wpvhquxxxdqqvxvzl0uprps33xlqjhudrp/

From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>

Add driver for the Eswin EIC7700 PCIe host controller.
The controller is based on the DesignWare PCIe core.

Co-developed-by: Yu Ning <ningyu@eswincomputing.com>
Signed-off-by: Yu Ning <ningyu@eswincomputing.com>
Signed-off-by: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
---
 drivers/pci/controller/dwc/Kconfig        |  12 +
 drivers/pci/controller/dwc/Makefile       |   1 +
 drivers/pci/controller/dwc/pcie-eic7700.c | 437 ++++++++++++++++++++++
 3 files changed, 450 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-eic7700.c

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index d9f0386396ed..21258f7dada9 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -480,4 +480,16 @@ config PCIE_VISCONTI_HOST
 	  Say Y here if you want PCIe controller support on Toshiba Visconti SoC.
 	  This driver supports TMPV7708 SoC.

+config PCIE_EIC7700
+	tristate "ESWIN PCIe host controller"
+	depends on PCI_MSI
+	depends on ARCH_ESWIN || COMPILE_TEST
+	select PCIE_DW_HOST
+	help
+      Enables support for the PCIe controller in the Eswin SoC
+      The PCI controller on Eswin is based on DesignWare hardware
+      It is a high-speed hardware bus standard used to connect
+      processors with external devices. Say Y here if you want
+      PCIe controller support for the ESWIN.
+
 endmenu
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index 908cb7f345db..2906477d92a5 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
 obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
 obj-$(CONFIG_PCIE_VISCONTI_HOST) += pcie-visconti.o
 obj-$(CONFIG_PCIE_RCAR_GEN4) += pcie-rcar-gen4.o
+obj-$(CONFIG_PCIE_EIC7700) += pcie-eic7700.o

 # The following drivers are for devices that use the generic ACPI
 # pci_root.c driver but don't support standard ECAM config access.
diff --git a/drivers/pci/controller/dwc/pcie-eic7700.c b/drivers/pci/controller/dwc/pcie-eic7700.c
new file mode 100644
index 000000000000..0413d1f61cb4
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-eic7700.c
@@ -0,0 +1,437 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ESWIN PCIe root complex driver
+ *
+ * Copyright 2024, Beijing ESWIN Computing Technology Co., Ltd.. All rights reserved.
+ *
+ * Authors: Yu Ning <ningyu@eswincomputing.com>
+ *          Senchuan Zhang <zhangsenchuan@eswincomputing.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/resource.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/reset.h>
+#include <linux/gpio/consumer.h>
+#include <linux/property.h>
+#include "pcie-designware.h"
+#include <linux/pm_runtime.h>
+struct eswin_pcie {
+	struct dw_pcie pci;
+	void __iomem *mgmt_base;
+	struct gpio_desc *reset;
+	struct clk *pcie_aux;
+	struct clk *pcie_cfg;
+	struct clk *pcie_cr;
+	struct clk *pcie_aclk;
+	struct reset_control *powerup_rst;
+	struct reset_control *cfg_rst;
+	struct reset_control *perst;
+};
+
+#define PCIE_PM_SEL_AUX_CLK BIT(16)
+#define PCIEMGMT_APP_HOLD_PHY_RST BIT(6)
+#define PCIEMGMT_APP_LTSSM_ENABLE BIT(5)
+#define PCIEMGMT_DEVICE_TYPE_MASK 0xf
+
+#define PCIEMGMT_CTRL0_OFFSET 0x0
+#define PCIEMGMT_STATUS0_OFFSET 0x100
+
+#define PCIE_TYPE_DEV_VEND_ID 0x0
+#define PCIE_DSP_PF0_MSI_CAP 0x50
+#define PCIE_NEXT_CAP_PTR 0x70
+#define DEVICE_CONTROL_DEVICE_STATUS 0x78
+
+#define PCIE_MSI_MULTIPLE_MSG_32 (0x5 << 17)
+#define PCIE_MSI_MULTIPLE_MSG_MASK (0x7 << 17)
+
+#define PCIEMGMT_LINKUP_STATE_VALIDATE ((0x11 << 2) | 0x3)
+#define PCIEMGMT_LINKUP_STATE_MASK 0xff
+
+static void eswin_pcie_shutdown(struct platform_device *pdev)
+{
+	struct eswin_pcie *pcie = platform_get_drvdata(pdev);
+
+	/* Bring down link, so bootloader gets clean state in case of reboot */
+	reset_control_assert(pcie->perst);
+}
+
+static int eswin_pcie_start_link(struct dw_pcie *pci)
+{
+	struct device *dev = pci->dev;
+	struct eswin_pcie *pcie = dev_get_drvdata(dev);
+	u32 val;
+
+	/* Enable LTSSM */
+	val = readl_relaxed(pcie->mgmt_base + PCIEMGMT_CTRL0_OFFSET);
+	val |= PCIEMGMT_APP_LTSSM_ENABLE;
+	writel_relaxed(val, pcie->mgmt_base + PCIEMGMT_CTRL0_OFFSET);
+	return 0;
+}
+
+static int eswin_pcie_link_up(struct dw_pcie *pci)
+{
+	struct device *dev = pci->dev;
+	struct eswin_pcie *pcie = dev_get_drvdata(dev);
+	u32 val;
+
+	val = readl_relaxed(pcie->mgmt_base + PCIEMGMT_STATUS0_OFFSET);
+	if ((val & PCIEMGMT_LINKUP_STATE_MASK) ==
+	    PCIEMGMT_LINKUP_STATE_VALIDATE)
+		return 1;
+	else
+		return 0;
+}
+
+static int eswin_pcie_clk_enable(struct eswin_pcie *pcie)
+{
+	int ret;
+
+	ret = clk_prepare_enable(pcie->pcie_cr);
+	if (ret) {
+		pr_err("PCIe: failed to enable cr clk: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(pcie->pcie_aclk);
+	if (ret) {
+		pr_err("PCIe: failed to enable aclk: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(pcie->pcie_cfg);
+	if (ret) {
+		pr_err("PCIe: failed to enable cfg_clk: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(pcie->pcie_aux);
+	if (ret) {
+		pr_err("PCIe: failed to enable aux_clk: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int eswin_pcie_clk_disable(struct eswin_pcie *eswin_pcie)
+{
+	clk_disable_unprepare(eswin_pcie->pcie_aux);
+	clk_disable_unprepare(eswin_pcie->pcie_cfg);
+	clk_disable_unprepare(eswin_pcie->pcie_cr);
+	clk_disable_unprepare(eswin_pcie->pcie_aclk);
+
+	return 0;
+}
+
+static int eswin_pcie_power_on(struct eswin_pcie *pcie)
+{
+	int ret = 0;
+
+	/* pciet_cfg_rstn */
+	ret = reset_control_reset(pcie->cfg_rst);
+	WARN_ON(ret != 0);
+
+	/* pciet_powerup_rstn */
+	ret = reset_control_reset(pcie->powerup_rst);
+	WARN_ON(ret != 0);
+
+	return ret;
+}
+
+static int eswin_pcie_power_off(struct eswin_pcie *eswin_pcie)
+{
+	reset_control_assert(eswin_pcie->perst);
+
+	reset_control_assert(eswin_pcie->powerup_rst);
+
+	reset_control_assert(eswin_pcie->cfg_rst);
+
+	return 0;
+}
+
+static int eswin_evb_socket_power_on(struct device *dev)
+{
+	int err_desc = 0;
+	struct gpio_desc *gpio;
+
+	gpio = devm_gpiod_get(dev, "pci-socket", GPIOD_OUT_LOW);
+	err_desc = IS_ERR(gpio);
+
+	if (err_desc) {
+		pr_debug("No power control gpio found, maybe not needed\n");
+		return 0;
+	}
+
+	gpiod_set_value(gpio, 1);
+
+	return err_desc;
+}
+
+static int eswin_pcie_host_init(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct eswin_pcie *pcie = dev_get_drvdata(pci->dev);
+	int ret;
+	u32 val;
+
+	/* pciet_aux_clken, pcie_cfg_clken */
+	ret = eswin_pcie_clk_enable(pcie);
+	if (ret)
+		return ret;
+
+	ret = eswin_pcie_power_on(pcie);
+	if (ret)
+		return ret;
+
+	/* set device type : rc */
+	val = readl_relaxed(pcie->mgmt_base + PCIEMGMT_CTRL0_OFFSET);
+	val &= 0xfffffff0;
+	writel_relaxed(val | 0x4, pcie->mgmt_base + PCIEMGMT_CTRL0_OFFSET);
+
+	ret = reset_control_assert(pcie->perst);
+	WARN_ON(ret != 0);
+
+	eswin_evb_socket_power_on(pcie->pci.dev);
+	msleep(100);
+	ret = reset_control_deassert(pcie->perst);
+	WARN_ON(ret != 0);
+
+	/* app_hold_phy_rst */
+	val = readl_relaxed(pcie->mgmt_base + PCIEMGMT_CTRL0_OFFSET);
+	val &= ~(0x40);
+	writel_relaxed(val, pcie->mgmt_base + PCIEMGMT_CTRL0_OFFSET);
+
+	/* wait pm_sel_aux_clk to 0 */
+	for (ret = 50; ret > 0; ret--) {
+		val = readl_relaxed(pcie->mgmt_base + PCIEMGMT_STATUS0_OFFSET);
+		if (!(val & PCIE_PM_SEL_AUX_CLK))
+			break;
+		msleep(2);
+	}
+
+	if (!ret) {
+		dev_info(pcie->pci.dev, "No clock exist.\n");
+		eswin_pcie_power_off(pcie);
+		eswin_pcie_clk_disable(pcie);
+		return -ENODEV;
+	}
+
+	/* config eswin vendor id and win2030 device id */
+	dw_pcie_writel_dbi(pci, PCIE_TYPE_DEV_VEND_ID, 0x20301fe1);
+
+	/* lane fix config, real driver NOT need, default x4 */
+	val = dw_pcie_readl_dbi(pci, PCIE_PORT_MULTI_LANE_CTRL);
+	val &= 0xffffff80;
+	val |= 0x44;
+	dw_pcie_writel_dbi(pci, PCIE_PORT_MULTI_LANE_CTRL, val);
+
+	val = dw_pcie_readl_dbi(pci, DEVICE_CONTROL_DEVICE_STATUS);
+	val &= ~(0x7 << 5);
+	val |= (0x2 << 5);
+	dw_pcie_writel_dbi(pci, DEVICE_CONTROL_DEVICE_STATUS, val);
+
+	/*  config support 32 msi vectors */
+	val = dw_pcie_readl_dbi(pci, PCIE_DSP_PF0_MSI_CAP);
+	val &= ~PCIE_MSI_MULTIPLE_MSG_MASK;
+	val |= PCIE_MSI_MULTIPLE_MSG_32;
+	dw_pcie_writel_dbi(pci, PCIE_DSP_PF0_MSI_CAP, val);
+
+	/* disable msix cap */
+	val = dw_pcie_readl_dbi(pci, PCIE_NEXT_CAP_PTR);
+	val &= 0xffff00ff;
+	dw_pcie_writel_dbi(pci, PCIE_NEXT_CAP_PTR, val);
+
+	return 0;
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
+static int __exit eswin_pcie_remove(struct platform_device *pdev)
+{
+	struct eswin_pcie *pcie = platform_get_drvdata(pdev);
+
+	dw_pcie_host_deinit(&pcie->pci.pp);
+
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
+	eswin_pcie_power_off(pcie);
+	eswin_pcie_clk_disable(pcie);
+
+	return 0;
+}
+
+static int eswin_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct dw_pcie *pci;
+	struct eswin_pcie *pcie;
+	int err;
+
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+	pci = &pcie->pci;
+	pci->dev = dev;
+	pci->ops = &dw_pcie_ops;
+	pci->pp.ops = &eswin_pcie_host_ops;
+
+	/* SiFive specific region: mgmt */
+	pcie->mgmt_base = devm_platform_ioremap_resource_byname(pdev, "mgmt");
+	if (IS_ERR(pcie->mgmt_base))
+		return PTR_ERR(pcie->mgmt_base);
+
+	/* Fetch clocks */
+	pcie->pcie_aux = devm_clk_get(dev, "pcie_aux_clk");
+	if (IS_ERR(pcie->pcie_aux)) {
+		return dev_err_probe(
+			dev, PTR_ERR(pcie->pcie_aux),
+			"pcie_aux clock source missing or invalid\n");
+	}
+
+	pcie->pcie_cfg = devm_clk_get(dev, "pcie_cfg_clk");
+	if (IS_ERR(pcie->pcie_cfg)) {
+		return dev_err_probe(
+			dev, PTR_ERR(pcie->pcie_cfg),
+			"pcie_cfg_clk clock source missing or invalid\n");
+	}
+
+	pcie->pcie_cr = devm_clk_get(dev, "pcie_cr_clk");
+	if (IS_ERR(pcie->pcie_cr)) {
+		return dev_err_probe(
+			dev, PTR_ERR(pcie->pcie_cr),
+			"pcie_cr_clk clock source missing or invalid\n");
+	}
+
+	pcie->pcie_aclk = devm_clk_get(dev, "pcie_aclk");
+
+	if (IS_ERR(pcie->pcie_aclk)) {
+		return dev_err_probe(
+			dev, PTR_ERR(pcie->pcie_aclk),
+			"pcie_aclk clock source missing or invalid\n");
+	}
+
+	/* Fetch reset */
+	pcie->powerup_rst =
+		devm_reset_control_get_optional(&pdev->dev, "pcie_powerup");
+	if (IS_ERR_OR_NULL(pcie->powerup_rst))
+		dev_err_probe(dev, PTR_ERR(pcie->powerup_rst),
+			      "unable to get powerup reset\n");
+
+	pcie->cfg_rst = devm_reset_control_get_optional(&pdev->dev, "pcie_cfg");
+	if (IS_ERR_OR_NULL(pcie->cfg_rst))
+		dev_err_probe(dev, PTR_ERR(pcie->cfg_rst),
+			      "unable to get cfg reset\n");
+
+	pcie->perst = devm_reset_control_get_optional(&pdev->dev, "pcie_pwren");
+	if (IS_ERR_OR_NULL(pcie->perst))
+		dev_err_probe(dev, PTR_ERR(pcie->perst),
+			      "unable to get perst\n");
+
+	platform_set_drvdata(pdev, pcie);
+
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	err = pm_runtime_get_sync(dev);
+	if (err < 0) {
+		dev_err(dev, "pm_runtime_get_sync failed: %d\n", err);
+		goto pm_runtime_put;
+	}
+
+	return dw_pcie_host_init(&pci->pp);
+
+pm_runtime_put:
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+	return err;
+}
+
+static const struct of_device_id eswin_pcie_of_match[] = {
+	{
+		.compatible = "eswin,eic7700-pcie",
+	},
+	{},
+};
+
+static int eswin_pcie_suspend(struct device *dev)
+{
+	struct eswin_pcie *pcie = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "suspend %s\n", __func__);
+	if (!pm_runtime_status_suspended(dev))
+		eswin_pcie_clk_disable(pcie);
+
+	return 0;
+}
+
+static int eswin_pcie_resume(struct device *dev)
+{
+	struct eswin_pcie *pcie = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "resume %s\n", __func__);
+	if (!pm_runtime_status_suspended(dev))
+		eswin_pcie_clk_enable(pcie);
+
+	return 0;
+}
+
+static int eswin_pcie_runtime_suspend(struct device *dev)
+{
+	struct eswin_pcie *pcie = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "runtime suspend %s\n", __func__);
+	return eswin_pcie_clk_disable(pcie);
+}
+
+static int eswin_pcie_runtime_resume(struct device *dev)
+{
+	struct eswin_pcie *pcie = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "runtime resume %s\n", __func__);
+	return eswin_pcie_clk_enable(pcie);
+}
+
+static const struct dev_pm_ops eswin_pcie_pm_ops = {
+	RUNTIME_PM_OPS(eswin_pcie_runtime_suspend, eswin_pcie_runtime_resume,
+		       NULL)
+		NOIRQ_SYSTEM_SLEEP_PM_OPS(eswin_pcie_suspend, eswin_pcie_resume)
+};
+
+static struct platform_driver eswin_pcie_driver = {
+	.driver = {
+			.name = "eic7700-pcie",
+			.of_match_table = eswin_pcie_of_match,
+			.suppress_bind_attrs = true,
+			.pm = &eswin_pcie_pm_ops,
+	},
+	.probe = eswin_pcie_probe,
+	.remove = __exit_p(eswin_pcie_remove),
+	.shutdown = eswin_pcie_shutdown,
+};
+
+module_platform_driver(eswin_pcie_driver);
+
+MODULE_DEVICE_TABLE(of, eswin_pcie_of_match);
+MODULE_DESCRIPTION("PCIe host controller driver for eic7700 SoCs");
+MODULE_AUTHOR("Yu Ning <ningyu@eswincomputing.com>");
+MODULE_AUTHOR("Senchuan Zhang <zhangsenchuan@eswincomputing.com>");
+MODULE_LICENSE("GPL");
--
2.25.1


