Return-Path: <linux-pci+bounces-17360-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC469D9AD8
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 16:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA142860A6
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 15:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED94E1DB52D;
	Tue, 26 Nov 2024 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="LdFiJ2io"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988801D89F8;
	Tue, 26 Nov 2024 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732636519; cv=none; b=O1hdLKYHYgXBPfYzj92c+c8Qq8niE27GD5jrwpmesHxxG4cGVypjMQnc2YbmNXuaVQR72oIsNv91joht2Ehr/Lbrq2VrEC/3IQaPCO/sjXUfvfNatzrWS1pI7hJUzV+5vWF3Mm4AE/wq6cst/AtaizP/m176NhyhHEJpRldk3CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732636519; c=relaxed/simple;
	bh=/vWhcOsX81JDvGVIJAd2dTvIedsJgnR9mYpaC1SN/Y8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S5cD3lhlTjzmLXUTt56hqlpkZVR1puxNn9EvUCtXrqeF0u4aTS03U0+59A5TMNFATfTUTyjGo5bhDoTinD/1EozZt5UL4Y+nQXlneybCvbiodzpgjEzbPsL0ByuT4ao1M6PzS7f1cNwhtkqOuqozP2T2l6FV6uEDcoOk571oBms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=LdFiJ2io; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQAk2Ug000958;
	Tue, 26 Nov 2024 16:54:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	W7l4BNUizCUR5V8bSBaxGgWLTgWNY75VDeVx7Zmfr4Q=; b=LdFiJ2ioMUk/mB8j
	SpYwW50DpblyLCVdoJjnlOq1kuNwdiQ5KbZQt9HRsRfNQJ2jdbIlwTfckK6JlxeW
	YI8GwZCbEyvCApmxE/d6HX1Uqs5vKXe1wR2VDHe7UN2meOWMtoY5PQ8DZoG0jUyo
	1xRH1KeubcJs9ORRfPGgf2c3vsAP2z5C62QjTXZ3uUl0AzWzel/JDt/rIYHL8iUZ
	UaIFhhEVfmCahTSY2ItEcWUkpPEvgLE6/AiP1uGZXHdv/dsNGqk7wVNTVTgwfCGO
	KeZwjmDfmZcu67UDuCqCI8prgSVdXtFdaHeacv5MtnCjjKVT1LLrQIsO9rDp/8yd
	dI7/bA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 433sg4bg25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 16:54:46 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8565D4004B;
	Tue, 26 Nov 2024 16:53:26 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ED95429E348;
	Tue, 26 Nov 2024 16:51:38 +0100 (CET)
Received: from localhost (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 26 Nov
 2024 16:51:38 +0100
From: Christian Bruel <christian.bruel@foss.st.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <p.zabel@pengutronix.de>, <cassel@kernel.org>,
        <quic_schintav@quicinc.com>, <fabrice.gasnier@foss.st.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Christian Bruel <christian.bruel@foss.st.com>
Subject: [PATCH v2 4/5] PCI: stm32: Add PCIe endpoint support for STM32MP25
Date: Tue, 26 Nov 2024 16:51:18 +0100
Message-ID: <20241126155119.1574564-5-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241126155119.1574564-1-christian.bruel@foss.st.com>
References: <20241126155119.1574564-1-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Add driver to configure the STM32MP25 SoC PCIe Gen2 controller based on the
DesignWare PCIe core in endpoint mode.

Uses the common reference clock provided by the host.

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
 drivers/pci/controller/dwc/Kconfig         |  12 +
 drivers/pci/controller/dwc/Makefile        |   1 +
 drivers/pci/controller/dwc/pcie-stm32-ep.c | 445 +++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-stm32.h    |   2 +
 4 files changed, 460 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-stm32-ep.c

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 0c18879b604c..f5601c81b56c 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -401,6 +401,18 @@ config PCIE_STM32
 	  This driver can also be built as a module. If so, the module
 	  will be called pcie-stm32.
 
+config PCIE_STM32_EP
+	tristate "STMicroelectronics STM32MP25 PCIe Controller (endpoint mode)"
+	depends on ARCH_STM32 || COMPILE_TEST
+	depends on PCI_ENDPOINT
+	select PCIE_DW_EP
+	help
+	  Enables endpoint support for DesignWare core based PCIe controller in found
+	  in STM32MP25 SoC.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called pcie-stm32-ep.
+
 config PCI_DRA7XX
 	tristate
 
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index 576d99cb3bc5..caebd98f6dd3 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
 obj-$(CONFIG_PCIE_VISCONTI_HOST) += pcie-visconti.o
 obj-$(CONFIG_PCIE_RCAR_GEN4) += pcie-rcar-gen4.o
 obj-$(CONFIG_PCIE_STM32) += pcie-stm32.o
+obj-$(CONFIG_PCIE_STM32_EP) += pcie-stm32-ep.o
 
 # The following drivers are for devices that use the generic ACPI
 # pci_root.c driver but don't support standard ECAM config access.
diff --git a/drivers/pci/controller/dwc/pcie-stm32-ep.c b/drivers/pci/controller/dwc/pcie-stm32-ep.c
new file mode 100644
index 000000000000..27f5725a7e76
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-stm32-ep.c
@@ -0,0 +1,445 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * STMicroelectronics STM32MP25 PCIe endpoint driver.
+ *
+ * Copyright (C) 2024 STMicroelectronics
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
+#define STM32MP25_PCIECR_EP 0
+#define STM32MP25_PCIECR_REQ_RETRY_EN	BIT(3)
+
+enum stm32_pcie_ep_link_status {
+	STM32_PCIE_EP_LINK_DISABLED,
+	STM32_PCIE_EP_LINK_ENABLED,
+};
+
+struct stm32_pcie {
+	struct dw_pcie *pci;
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
+	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
+	enum pci_barno bar;
+
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
+		dw_pcie_ep_reset_bar(pci, bar);
+
+	/* Defer Completion Requests until link started */
+	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
+			   STM32MP25_PCIECR_REQ_RETRY_EN,
+			   STM32MP25_PCIECR_REQ_RETRY_EN);
+}
+
+static int stm32_pcie_enable_link(struct dw_pcie *pci)
+{
+	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
+	int ret;
+
+	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
+			   STM32MP25_PCIECR_LTSSM_EN,
+			   STM32MP25_PCIECR_LTSSM_EN);
+
+	ret = dw_pcie_wait_for_link(pci);
+	if (ret)
+		return ret;
+
+	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
+			   STM32MP25_PCIECR_REQ_RETRY_EN,
+			   0);
+
+	return 0;
+}
+
+static void stm32_pcie_disable_link(struct dw_pcie *pci)
+{
+	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
+
+	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
+			   STM32MP25_PCIECR_REQ_RETRY_EN,
+			   STM32MP25_PCIECR_REQ_RETRY_EN);
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
+	ret = stm32_pcie_enable_link(pci);
+	if (ret) {
+		dev_err(pci->dev, "PCIe cannot establish link: %d\n", ret);
+		return ret;
+	}
+
+	stm32_pcie->link_status = STM32_PCIE_EP_LINK_ENABLED;
+
+	enable_irq(stm32_pcie->perst_irq);
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
+	.align = 1 << 16,
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
+	struct device *dev = pci->dev;
+
+	dev_dbg(dev, "PERST asserted by host. Shutting down the PCIe link\n");
+
+	/*
+	 * Do not try to release resources if the PERST# is
+	 * asserted before the link is started.
+	 */
+	if (stm32_pcie->link_status == STM32_PCIE_EP_LINK_DISABLED) {
+		dev_dbg(pci->dev, "Link is already disabled\n");
+		return;
+	}
+
+	stm32_pcie_disable_link(pci);
+
+	stm32_pcie_disable_resources(stm32_pcie);
+
+	pm_runtime_put_sync(dev);
+
+	stm32_pcie->link_status = STM32_PCIE_EP_LINK_DISABLED;
+}
+
+static void stm32_pcie_perst_deassert(struct dw_pcie *pci)
+{
+	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
+	struct device *dev = pci->dev;
+	struct dw_pcie_ep *ep = &pci->ep;
+	int ret;
+
+	if (stm32_pcie->link_status == STM32_PCIE_EP_LINK_ENABLED) {
+		dev_dbg(pci->dev, "Link is already enabled\n");
+		return;
+	}
+
+	dev_dbg(dev, "PERST de-asserted by host. Starting link training\n");
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0) {
+		dev_err(dev, "pm runtime resume failed: %d\n", ret);
+		return;
+	}
+
+	ret = stm32_pcie_enable_resources(stm32_pcie);
+	if (ret) {
+		dev_err(dev, "Failed to enable resources: %d\n", ret);
+		goto err_clk;
+	}
+
+	ret = dw_pcie_ep_init_registers(ep);
+	if (ret) {
+		dev_err(dev, "Failed to complete initialization: %d\n", ret);
+		goto err_init_regs;
+	}
+
+	pci_epc_init_notify(ep->epc);
+
+	ret = stm32_pcie_enable_link(pci);
+	if (ret) {
+		dev_err(dev, "PCIe Cannot establish link: %d\n", ret);
+		goto err_link;
+	}
+
+	stm32_pcie->link_status = STM32_PCIE_EP_LINK_ENABLED;
+
+	return;
+
+err_link:
+	pci_epc_deinit_notify(ep->epc);
+
+err_init_regs:
+	stm32_pcie_disable_resources(stm32_pcie);
+
+err_clk:
+	pm_runtime_put_sync(dev);
+}
+
+static irqreturn_t stm32_pcie_ep_perst_irq_thread(int irq, void *data)
+{
+	struct stm32_pcie *stm32_pcie = data;
+	struct dw_pcie *pci = stm32_pcie->pci;
+	u32 perst;
+
+	perst = gpiod_get_value(stm32_pcie->perst_gpio);
+	if (perst)
+		stm32_pcie_perst_assert(pci);
+	else
+		stm32_pcie_perst_deassert(pci);
+
+	return IRQ_HANDLED;
+}
+
+static int stm32_add_pcie_ep(struct stm32_pcie *stm32_pcie,
+			     struct platform_device *pdev)
+{
+	struct dw_pcie *pci = stm32_pcie->pci;
+	struct dw_pcie_ep *ep = &pci->ep;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	ret = regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
+				 STM32MP25_PCIECR_TYPE_MASK,
+				 STM32MP25_PCIECR_EP);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0) {
+		dev_err(dev, "pm runtime resume failed: %d\n", ret);
+		return ret;
+	}
+
+	reset_control_assert(stm32_pcie->rst);
+	reset_control_deassert(stm32_pcie->rst);
+
+	ep->ops = &stm32_pcie_ep_ops;
+
+	ret = dw_pcie_ep_init(ep);
+	if (ret) {
+		dev_err(dev, "failed to initialize ep: %d\n", ret);
+		goto err_init;
+	}
+
+	ret = stm32_pcie_enable_resources(stm32_pcie);
+	if (ret) {
+		dev_err(dev, "failed to enable resources: %d\n", ret);
+		goto err_clk;
+	}
+
+	ret = dw_pcie_ep_init_registers(ep);
+	if (ret) {
+		dev_err(dev, "Failed to initialize DWC endpoint registers\n");
+		goto err_init_regs;
+	}
+
+	pci_epc_init_notify(ep->epc);
+
+	return 0;
+
+err_init_regs:
+	stm32_pcie_disable_resources(stm32_pcie);
+
+err_clk:
+	dw_pcie_ep_deinit(ep);
+
+err_init:
+	pm_runtime_put_sync(dev);
+	return ret;
+}
+
+static int stm32_pcie_probe(struct platform_device *pdev)
+{
+	struct stm32_pcie *stm32_pcie;
+	struct dw_pcie *dw;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	stm32_pcie = devm_kzalloc(dev, sizeof(*stm32_pcie), GFP_KERNEL);
+	if (!stm32_pcie)
+		return -ENOMEM;
+
+	dw = devm_kzalloc(dev, sizeof(*dw), GFP_KERNEL);
+	if (!dw)
+		return -ENOMEM;
+
+	stm32_pcie->pci = dw;
+
+	dw->dev = dev;
+	dw->ops = &dw_pcie_ops;
+
+	stm32_pcie->regmap = syscon_regmap_lookup_by_compatible("st,stm32mp25-syscfg");
+	if (IS_ERR(stm32_pcie->regmap))
+		return dev_err_probe(dev, PTR_ERR(stm32_pcie->regmap),
+				     "No syscfg specified\n");
+
+	stm32_pcie->phy = devm_phy_get(dev, "pcie-phy");
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
+	ret = devm_pm_runtime_enable(dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enable pm runtime %d\n", ret);
+		return ret;
+	}
+
+	stm32_pcie->perst_irq = gpiod_to_irq(stm32_pcie->perst_gpio);
+
+	/* Will be enabled in start_link when device is initialized. */
+	irq_set_status_flags(stm32_pcie->perst_irq, IRQ_NOAUTOEN);
+
+	ret = devm_request_threaded_irq(dev, stm32_pcie->perst_irq, NULL,
+					stm32_pcie_ep_perst_irq_thread,
+					IRQF_TRIGGER_RISING |
+					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					"perst_irq", stm32_pcie);
+	if (ret) {
+		dev_err(dev, "Failed to request PERST IRQ: %d\n", ret);
+		return ret;
+	}
+
+	return stm32_add_pcie_ep(stm32_pcie, pdev);
+}
+
+static void stm32_pcie_remove(struct platform_device *pdev)
+{
+	struct stm32_pcie *stm32_pcie = platform_get_drvdata(pdev);
+	struct dw_pcie_ep *ep = &stm32_pcie->pci->ep;
+
+	disable_irq(stm32_pcie->perst_irq);
+
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
index 3efd00937d3d..ac0955adf150 100644
--- a/drivers/pci/controller/dwc/pcie-stm32.h
+++ b/drivers/pci/controller/dwc/pcie-stm32.h
@@ -9,7 +9,9 @@
 #define to_stm32_pcie(x)	dev_get_drvdata((x)->dev)
 
 #define STM32MP25_PCIECR_TYPE_MASK	GENMASK(11, 8)
+#define STM32MP25_PCIECR_EP		0
 #define STM32MP25_PCIECR_LTSSM_EN	BIT(2)
+#define STM32MP25_PCIECR_REQ_RETRY_EN	BIT(3)
 #define STM32MP25_PCIECR_RC		BIT(10)
 
 #define SYSCFG_PCIECR			0x6000
-- 
2.34.1


