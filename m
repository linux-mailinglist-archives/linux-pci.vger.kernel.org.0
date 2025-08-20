Return-Path: <linux-pci+bounces-34351-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1520FB2D581
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 10:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54A215A43BE
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 08:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7649E2D9782;
	Wed, 20 Aug 2025 07:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="5Zle2nhA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA012D9795;
	Wed, 20 Aug 2025 07:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755676796; cv=none; b=TKVFe7xhYcPo8mzpzqZ0/qgwkmhwtQj4zmJbtXVchDPBJYOz7hZh1NgFduXVltsQHQl9OFSuNfJqMAtUgfr04DHO78a3uFy5Qq+XKADZ6tW8j05dK82pPqU5L4ZDuCsg03ERU3+if30n91htIr2WdaMiZd96V7HybB5K2NzGIPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755676796; c=relaxed/simple;
	bh=E5OAxrCJtfqf/kJ4fq1ndAu8X5DfgdiE13ErNTuQ9Wo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q+vQCPveIleQP+g8S2GJJR7LRcIyY/e6dJsUbE/ZRoSrjHL45WOhEcmxZv7+sr6wIOGpZh0WZSZIIX2tcTs2oV5iuEhDnF6QKn6innjijf+1eTdgb8RwN0mUwKxTLQ5sYADI3hCMfvGXEIUmiKpA5s6kwUiQJZsxDzmjciouJZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=5Zle2nhA; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K7mDOm000448;
	Wed, 20 Aug 2025 09:59:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	V7pDN2QsWi68h0Pgw4S/otGNcYYQUoSlPYlDoWrqANw=; b=5Zle2nhAqY8EV3uu
	dYw4wJaSVpmLoXLtusObC6iQF6g6K/QSW1iPxV0IwUO6A6L/y95W0led81yoL+oP
	1i3KKqMdk3FPmbT1IuqYhXXBYuY2jcFWenlk2ZiLN9lXU5pcwnGBtwqOafltNQGS
	YmKkMyrpRqsrpM+338O1GIXfLE/Fmsv/2R0YTiqm7Hy8nkI1f5wF0KkZQNOCL4DN
	4e3vAn20Pcgav5JT5F6cKbNO0OaHSCXR3zlyX9bVbUMvLA/Kgz0VrsP22s3qEwcR
	Pb+mI29EgD0oWYnSjZQzXp7pw4knT7d1tKFoFI+zLbTDUSfg6mgOmeKaQqtTP642
	s+s2Fw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48n7548x92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 09:59:26 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A0F5D40044;
	Wed, 20 Aug 2025 09:57:31 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8D7275E811F;
	Wed, 20 Aug 2025 09:56:08 +0200 (CEST)
Received: from localhost (10.130.77.120) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 09:56:08 +0200
From: Christian Bruel <christian.bruel@foss.st.com>
To: <christian.bruel@foss.st.com>, <lpieralisi@kernel.org>,
        <kwilczynski@kernel.org>, <mani@kernel.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <linus.walleij@linaro.org>, <corbet@lwn.net>, <p.zabel@pengutronix.de>,
        <shradha.t@samsung.com>, <mayank.rana@oss.qualcomm.com>,
        <namcao@linutronix.de>, <qiang.yu@oss.qualcomm.com>,
        <thippeswamy.havalige@amd.com>, <inochiama@gmail.com>,
        <quic_schintav@quicinc.com>
CC: <johan+linaro@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v13 06/11] PCI: stm32: Add PCIe Endpoint support for STM32MP25
Date: Wed, 20 Aug 2025 09:54:06 +0200
Message-ID: <20250820075411.1178729-7-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820075411.1178729-1-christian.bruel@foss.st.com>
References: <20250820075411.1178729-1-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_01,2025-03-28_01

Add driver to configure the STM32MP25 SoC PCIe Gen1 2.5GT/s or Gen2 5GT/s
controller based on the DesignWare PCIe core in endpoint mode.

Uses the common reference clock provided by the host.

The PCIe core_clk receives the pipe0_clk from the ComboPHY as input,
and the ComboPHY PLL must be locked for pipe0_clk to be ready.
Consequently, PCIe core registers cannot be accessed until the ComboPHY is
fully initialised and REFCLK is enabled and ready.

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
 drivers/pci/controller/dwc/Kconfig         |  12 +
 drivers/pci/controller/dwc/Makefile        |   1 +
 drivers/pci/controller/dwc/pcie-stm32-ep.c | 384 +++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-stm32.h    |   1 +
 4 files changed, 398 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-stm32-ep.c

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index a8174817fd5b..34abc859c107 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -435,6 +435,18 @@ config PCIE_STM32_HOST
 	  This driver can also be built as a module. If so, the module
 	  will be called pcie-stm32.
 
+config PCIE_STM32_EP
+	tristate "STMicroelectronics STM32MP25 PCIe Controller (endpoint mode)"
+	depends on ARCH_STM32 || COMPILE_TEST
+	depends on PCI_ENDPOINT
+	select PCIE_DW_EP
+	help
+	  Enables Endpoint (EP) support for the DesignWare core based PCIe
+	  controller found in STM32MP25 SoC.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called pcie-stm32-ep.
+
 config PCI_DRA7XX
 	tristate
 
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index 1307a87b1cf0..7ae28f3b0fb3 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
 obj-$(CONFIG_PCIE_VISCONTI_HOST) += pcie-visconti.o
 obj-$(CONFIG_PCIE_RCAR_GEN4) += pcie-rcar-gen4.o
 obj-$(CONFIG_PCIE_STM32_HOST) += pcie-stm32.o
+obj-$(CONFIG_PCIE_STM32_EP) += pcie-stm32-ep.o
 
 # The following drivers are for devices that use the generic ACPI
 # pci_root.c driver but don't support standard ECAM config access.
diff --git a/drivers/pci/controller/dwc/pcie-stm32-ep.c b/drivers/pci/controller/dwc/pcie-stm32-ep.c
new file mode 100644
index 000000000000..1f46bcf0c79f
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-stm32-ep.c
@@ -0,0 +1,384 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * STMicroelectronics STM32MP25 PCIe endpoint driver.
+ *
+ * Copyright (C) 2025 STMicroelectronics
+ * Author: Christian Bruel <christian.bruel@foss.st.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of_platform.h>
+#include <linux/of_gpio.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include "pcie-designware.h"
+#include "pcie-stm32.h"
+
+enum stm32_pcie_ep_link_status {
+	STM32_PCIE_EP_LINK_DISABLED,
+	STM32_PCIE_EP_LINK_ENABLED,
+};
+
+struct stm32_pcie {
+	struct dw_pcie pci;
+	struct regmap *regmap;
+	struct reset_control *rst;
+	struct phy *phy;
+	struct clk *clk;
+	struct gpio_desc *perst_gpio;
+	enum stm32_pcie_ep_link_status link_status;
+	unsigned int perst_irq;
+};
+
+static void stm32_pcie_ep_init(struct dw_pcie_ep *ep)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	enum pci_barno bar;
+
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
+		dw_pcie_ep_reset_bar(pci, bar);
+}
+
+static int stm32_pcie_enable_link(struct dw_pcie *pci)
+{
+	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
+
+	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
+			   STM32MP25_PCIECR_LTSSM_EN,
+			   STM32MP25_PCIECR_LTSSM_EN);
+
+	return dw_pcie_wait_for_link(pci);
+}
+
+static void stm32_pcie_disable_link(struct dw_pcie *pci)
+{
+	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
+
+	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR, STM32MP25_PCIECR_LTSSM_EN, 0);
+}
+
+static int stm32_pcie_start_link(struct dw_pcie *pci)
+{
+	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
+	int ret;
+
+	if (stm32_pcie->link_status == STM32_PCIE_EP_LINK_ENABLED) {
+		dev_dbg(pci->dev, "Link is already enabled\n");
+		return 0;
+	}
+
+	dev_dbg(pci->dev, "Enable link\n");
+
+	ret = stm32_pcie_enable_link(pci);
+	if (ret) {
+		dev_err(pci->dev, "PCIe cannot establish link: %d\n", ret);
+		return ret;
+	}
+
+	enable_irq(stm32_pcie->perst_irq);
+
+	stm32_pcie->link_status = STM32_PCIE_EP_LINK_ENABLED;
+
+	return 0;
+}
+
+static void stm32_pcie_stop_link(struct dw_pcie *pci)
+{
+	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
+
+	if (stm32_pcie->link_status == STM32_PCIE_EP_LINK_DISABLED) {
+		dev_dbg(pci->dev, "Link is already disabled\n");
+		return;
+	}
+
+	dev_dbg(pci->dev, "Disable link\n");
+
+	disable_irq(stm32_pcie->perst_irq);
+
+	stm32_pcie_disable_link(pci);
+
+	stm32_pcie->link_status = STM32_PCIE_EP_LINK_DISABLED;
+}
+
+static int stm32_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
+				unsigned int type, u16 interrupt_num)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+
+	switch (type) {
+	case PCI_IRQ_INTX:
+		return dw_pcie_ep_raise_intx_irq(ep, func_no);
+	case PCI_IRQ_MSI:
+		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
+	default:
+		dev_err(pci->dev, "UNKNOWN IRQ type\n");
+		return -EINVAL;
+	}
+}
+
+static const struct pci_epc_features stm32_pcie_epc_features = {
+	.msi_capable = true,
+	.align = SZ_64K,
+};
+
+static const struct pci_epc_features*
+stm32_pcie_get_features(struct dw_pcie_ep *ep)
+{
+	return &stm32_pcie_epc_features;
+}
+
+static const struct dw_pcie_ep_ops stm32_pcie_ep_ops = {
+	.init = stm32_pcie_ep_init,
+	.raise_irq = stm32_pcie_raise_irq,
+	.get_features = stm32_pcie_get_features,
+};
+
+static const struct dw_pcie_ops dw_pcie_ops = {
+	.start_link = stm32_pcie_start_link,
+	.stop_link = stm32_pcie_stop_link,
+};
+
+static int stm32_pcie_enable_resources(struct stm32_pcie *stm32_pcie)
+{
+	int ret;
+
+	ret = phy_init(stm32_pcie->phy);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(stm32_pcie->clk);
+	if (ret)
+		phy_exit(stm32_pcie->phy);
+
+	return ret;
+}
+
+static void stm32_pcie_disable_resources(struct stm32_pcie *stm32_pcie)
+{
+	clk_disable_unprepare(stm32_pcie->clk);
+
+	phy_exit(stm32_pcie->phy);
+}
+
+static void stm32_pcie_perst_assert(struct dw_pcie *pci)
+{
+	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
+	struct dw_pcie_ep *ep = &stm32_pcie->pci.ep;
+	struct device *dev = pci->dev;
+
+	dev_dbg(dev, "PERST asserted by host\n");
+
+	pci_epc_deinit_notify(ep->epc);
+
+	stm32_pcie_disable_resources(stm32_pcie);
+
+	pm_runtime_put_sync(dev);
+}
+
+static void stm32_pcie_perst_deassert(struct dw_pcie *pci)
+{
+	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
+	struct device *dev = pci->dev;
+	struct dw_pcie_ep *ep = &pci->ep;
+	int ret;
+
+	dev_dbg(dev, "PERST de-asserted by host\n");
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to resume runtime PM: %d\n", ret);
+		return;
+	}
+
+	ret = stm32_pcie_enable_resources(stm32_pcie);
+	if (ret) {
+		dev_err(dev, "Failed to enable resources: %d\n", ret);
+		goto err_pm_put_sync;
+	}
+
+	/*
+	 * Need to reprogram the configuration space registers here because the
+	 * DBI registers were incorrectly reset by the PHY RCC during phy_init().
+	 */
+	ret = dw_pcie_ep_init_registers(ep);
+	if (ret) {
+		dev_err(dev, "Failed to complete initialization: %d\n", ret);
+		goto err_disable_resources;
+	}
+
+	pci_epc_init_notify(ep->epc);
+
+	return;
+
+err_disable_resources:
+	stm32_pcie_disable_resources(stm32_pcie);
+
+err_pm_put_sync:
+	pm_runtime_put_sync(dev);
+}
+
+static irqreturn_t stm32_pcie_ep_perst_irq_thread(int irq, void *data)
+{
+	struct stm32_pcie *stm32_pcie = data;
+	struct dw_pcie *pci = &stm32_pcie->pci;
+	u32 perst;
+
+	perst = gpiod_get_value(stm32_pcie->perst_gpio);
+	if (perst)
+		stm32_pcie_perst_assert(pci);
+	else
+		stm32_pcie_perst_deassert(pci);
+
+	irq_set_irq_type(gpiod_to_irq(stm32_pcie->perst_gpio),
+			 (perst ? IRQF_TRIGGER_HIGH : IRQF_TRIGGER_LOW));
+
+	return IRQ_HANDLED;
+}
+
+static int stm32_add_pcie_ep(struct stm32_pcie *stm32_pcie,
+			     struct platform_device *pdev)
+{
+	struct dw_pcie_ep *ep = &stm32_pcie->pci.ep;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	ret = regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
+				 STM32MP25_PCIECR_TYPE_MASK,
+				 STM32MP25_PCIECR_EP);
+	if (ret)
+		return ret;
+
+	reset_control_assert(stm32_pcie->rst);
+	reset_control_deassert(stm32_pcie->rst);
+
+	ep->ops = &stm32_pcie_ep_ops;
+
+	ret = dw_pcie_ep_init(ep);
+	if (ret) {
+		dev_err(dev, "Failed to initialize ep: %d\n", ret);
+		return ret;
+	}
+
+	ret = stm32_pcie_enable_resources(stm32_pcie);
+	if (ret) {
+		dev_err(dev, "Failed to enable resources: %d\n", ret);
+		dw_pcie_ep_deinit(ep);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int stm32_pcie_probe(struct platform_device *pdev)
+{
+	struct stm32_pcie *stm32_pcie;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	stm32_pcie = devm_kzalloc(dev, sizeof(*stm32_pcie), GFP_KERNEL);
+	if (!stm32_pcie)
+		return -ENOMEM;
+
+	stm32_pcie->pci.dev = dev;
+	stm32_pcie->pci.ops = &dw_pcie_ops;
+
+	stm32_pcie->regmap = syscon_regmap_lookup_by_compatible("st,stm32mp25-syscfg");
+	if (IS_ERR(stm32_pcie->regmap))
+		return dev_err_probe(dev, PTR_ERR(stm32_pcie->regmap),
+				     "No syscfg specified\n");
+
+	stm32_pcie->phy = devm_phy_get(dev, NULL);
+	if (IS_ERR(stm32_pcie->phy))
+		return dev_err_probe(dev, PTR_ERR(stm32_pcie->phy),
+				     "failed to get pcie-phy\n");
+
+	stm32_pcie->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(stm32_pcie->clk))
+		return dev_err_probe(dev, PTR_ERR(stm32_pcie->clk),
+				     "Failed to get PCIe clock source\n");
+
+	stm32_pcie->rst = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(stm32_pcie->rst))
+		return dev_err_probe(dev, PTR_ERR(stm32_pcie->rst),
+				     "Failed to get PCIe reset\n");
+
+	stm32_pcie->perst_gpio = devm_gpiod_get(dev, "reset", GPIOD_IN);
+	if (IS_ERR(stm32_pcie->perst_gpio))
+		return dev_err_probe(dev, PTR_ERR(stm32_pcie->perst_gpio),
+				     "Failed to get reset GPIO\n");
+
+	ret = phy_set_mode(stm32_pcie->phy, PHY_MODE_PCIE);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, stm32_pcie);
+
+	pm_runtime_get_noresume(dev);
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(&pdev->dev);
+		return dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
+	}
+
+	stm32_pcie->perst_irq = gpiod_to_irq(stm32_pcie->perst_gpio);
+
+	/* Will be enabled in start_link when device is initialized. */
+	irq_set_status_flags(stm32_pcie->perst_irq, IRQ_NOAUTOEN);
+
+	ret = devm_request_threaded_irq(dev, stm32_pcie->perst_irq, NULL,
+					stm32_pcie_ep_perst_irq_thread,
+					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					"perst_irq", stm32_pcie);
+	if (ret) {
+		pm_runtime_put_noidle(&pdev->dev);
+		return dev_err_probe(dev, ret, "Failed to request PERST IRQ\n");
+	}
+
+	ret = stm32_add_pcie_ep(stm32_pcie, pdev);
+	if (ret)
+		pm_runtime_put_noidle(&pdev->dev);
+
+	return ret;
+}
+
+static void stm32_pcie_remove(struct platform_device *pdev)
+{
+	struct stm32_pcie *stm32_pcie = platform_get_drvdata(pdev);
+	struct dw_pcie *pci = &stm32_pcie->pci;
+	struct dw_pcie_ep *ep = &pci->ep;
+
+	dw_pcie_stop_link(pci);
+
+	pci_epc_deinit_notify(ep->epc);
+	dw_pcie_ep_deinit(ep);
+
+	stm32_pcie_disable_resources(stm32_pcie);
+
+	pm_runtime_put_sync(&pdev->dev);
+}
+
+static const struct of_device_id stm32_pcie_ep_of_match[] = {
+	{ .compatible = "st,stm32mp25-pcie-ep" },
+	{},
+};
+
+static struct platform_driver stm32_pcie_ep_driver = {
+	.probe = stm32_pcie_probe,
+	.remove = stm32_pcie_remove,
+	.driver = {
+		.name = "stm32-ep-pcie",
+		.of_match_table = stm32_pcie_ep_of_match,
+	},
+};
+
+module_platform_driver(stm32_pcie_ep_driver);
+
+MODULE_AUTHOR("Christian Bruel <christian.bruel@foss.st.com>");
+MODULE_DESCRIPTION("STM32MP25 PCIe Endpoint Controller driver");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(of, stm32_pcie_ep_of_match);
diff --git a/drivers/pci/controller/dwc/pcie-stm32.h b/drivers/pci/controller/dwc/pcie-stm32.h
index 387112c4e42c..09d39f04e469 100644
--- a/drivers/pci/controller/dwc/pcie-stm32.h
+++ b/drivers/pci/controller/dwc/pcie-stm32.h
@@ -9,6 +9,7 @@
 #define to_stm32_pcie(x)	dev_get_drvdata((x)->dev)
 
 #define STM32MP25_PCIECR_TYPE_MASK	GENMASK(11, 8)
+#define STM32MP25_PCIECR_EP		0
 #define STM32MP25_PCIECR_LTSSM_EN	BIT(2)
 #define STM32MP25_PCIECR_RC		BIT(10)
 
-- 
2.34.1


