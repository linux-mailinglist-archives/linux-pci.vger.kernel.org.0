Return-Path: <linux-pci+bounces-22218-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD20A426BC
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 16:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC021188D16F
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 15:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D972024EF7C;
	Mon, 24 Feb 2025 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ayqAneO0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02D58828;
	Mon, 24 Feb 2025 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740411656; cv=none; b=rLcb6LTvGDsrhpwkKWKNpneaNAYMfJt6frkR3kt33UaYvdwPPPCQtmBnVOdC2ACBDWW2OLSvtCrNkWVKwv46mP8nOvZmnZZI/275oOIUwdGBrZEEIyqaKurgpq0fYJK+ANtS5j470bD2lmY026tfsYWhNQs08/gVoUsqBgC5W98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740411656; c=relaxed/simple;
	bh=xwj28Y0NKkTnTR+qxjt235NFwDZZLetKW4BmplCsWTs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mKdspxCoSkWeMbQC0MgyJ0HhIM6qV4u//hwNa22D9rj1A0d9b3PEDQbZimUIbpjaFRp3SD1PCpmpuSdiVfAopk21d5zAnhMKNwQcTF5k2PjyYF0c/1MJaOO6h2uXPTBDKKezWrmiwqDS1DoqaECGFvG5vPQA0s1emTIlfyY30oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ayqAneO0; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OCQ0ui016699;
	Mon, 24 Feb 2025 16:40:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	iFL/UwD7ZYLuPqFlRywH/IOLCB5u8lVFFftFM9waj7g=; b=ayqAneO01Lw+S72n
	G+S3M18XiwmVC4S3CJPjlnbe/QspBYi52KKFVb7iTvTR9ZScU5hBXtvVVhdSABPU
	huCuU8kBZXSOk4IeSuFABSfiQz9pJviMIXpkOMcLvhCHkjzS2a3yZhAWJeNvnEy/
	/fzeKu92wag1t4ZagklQctIvbm1XY8D5DxQUu4peNDmRevHAwMPkARN67QlepiGw
	tvMsw8SvrAoSFrzbYudHQpTZQPX9R6I5l8MRx+eHE+nWBlDcP4Mm2MKxdf6HQFE8
	30ILECtyNfZjDvWhpjM0/Pghn8g3E3yv308mZrYRiQqpFC0d7PNH/bmMS3Qnlqdr
	hIEqMg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44y4vm0fax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 16:40:30 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id BD55B40082;
	Mon, 24 Feb 2025 16:39:09 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BCF095250E2;
	Mon, 24 Feb 2025 16:33:42 +0100 (CET)
Received: from localhost (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 16:33:42 +0100
From: Christian Bruel <christian.bruel@foss.st.com>
To: <christian.bruel@foss.st.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <p.zabel@pengutronix.de>, <johan+linaro@kernel.org>,
        <cassel@kernel.org>, <quic_schintav@quicinc.com>
CC: <fabrice.gasnier@foss.st.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 2/9] PCI: stm32: Add PCIe host support for STM32MP25
Date: Mon, 24 Feb 2025 16:33:06 +0100
Message-ID: <20250224153313.3416318-3-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224153313.3416318-1-christian.bruel@foss.st.com>
References: <20250224153313.3416318-1-christian.bruel@foss.st.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_06,2025-02-24_02,2024-11-22_01

Add driver for the STM32MP25 SoC PCIe Gen1 2.5 GT/s and Gen2 5GT/s
controller based on the DesignWare PCIe core.

Supports MSI via GICv2m, Single Virtual Channel, Single Function

Supports WAKE# GPIO.

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
 drivers/pci/controller/dwc/Kconfig      |  12 +
 drivers/pci/controller/dwc/Makefile     |   1 +
 drivers/pci/controller/dwc/pcie-stm32.c | 367 ++++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-stm32.h |  15 +
 4 files changed, 395 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-stm32.c
 create mode 100644 drivers/pci/controller/dwc/pcie-stm32.h

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index b6d6778b0698..0c18879b604c 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -389,6 +389,18 @@ config PCIE_SPEAR13XX
 	help
 	  Say Y here if you want PCIe support on SPEAr13XX SoCs.
 
+config PCIE_STM32
+	tristate "STMicroelectronics STM32MP25 PCIe Controller (host mode)"
+	depends on ARCH_STM32 || COMPILE_TEST
+	depends on PCI_MSI
+	select PCIE_DW_HOST
+	help
+	  Enables support for the DesignWare core based PCIe host controller
+	  found in STM32MP25 SoC.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called pcie-stm32.
+
 config PCI_DRA7XX
 	tristate
 
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index a8308d9ea986..576d99cb3bc5 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
 obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
 obj-$(CONFIG_PCIE_VISCONTI_HOST) += pcie-visconti.o
 obj-$(CONFIG_PCIE_RCAR_GEN4) += pcie-rcar-gen4.o
+obj-$(CONFIG_PCIE_STM32) += pcie-stm32.o
 
 # The following drivers are for devices that use the generic ACPI
 # pci_root.c driver but don't support standard ECAM config access.
diff --git a/drivers/pci/controller/dwc/pcie-stm32.c b/drivers/pci/controller/dwc/pcie-stm32.c
new file mode 100644
index 000000000000..3937777d9eb9
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-stm32.c
@@ -0,0 +1,367 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * STMicroelectronics STM32MP25 PCIe root complex driver.
+ *
+ * Copyright (C) 2025 STMicroelectronics
+ * Author: Christian Bruel <christian.bruel@foss.st.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of_platform.h>
+#include <linux/phy/phy.h>
+#include <linux/pinctrl/devinfo.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/pm_wakeirq.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include "pcie-designware.h"
+#include "pcie-stm32.h"
+#include "../../pci.h"
+
+struct stm32_pcie {
+	struct dw_pcie pci;
+	struct regmap *regmap;
+	struct reset_control *rst;
+	struct phy *phy;
+	struct clk *clk;
+	struct gpio_desc *perst_gpio;
+	struct gpio_desc *wake_gpio;
+};
+
+static void stm32_pcie_deassert_perst(struct stm32_pcie *stm32_pcie)
+{
+	gpiod_set_value(stm32_pcie->perst_gpio, 0);
+
+	if (stm32_pcie->perst_gpio)
+		msleep(PCIE_T_RRS_READY_MS);
+}
+
+static void stm32_pcie_assert_perst(struct stm32_pcie *stm32_pcie)
+{
+	gpiod_set_value(stm32_pcie->perst_gpio, 1);
+}
+
+static int stm32_pcie_start_link(struct dw_pcie *pci)
+{
+	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
+
+	return regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
+				  STM32MP25_PCIECR_LTSSM_EN,
+				  STM32MP25_PCIECR_LTSSM_EN);
+}
+
+static void stm32_pcie_stop_link(struct dw_pcie *pci)
+{
+	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
+
+	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
+			   STM32MP25_PCIECR_LTSSM_EN, 0);
+}
+
+static int stm32_pcie_suspend_noirq(struct device *dev)
+{
+	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
+	int ret;
+
+	ret = dw_pcie_suspend_noirq(&stm32_pcie->pci);
+	if (ret) {
+		stm32_pcie_deassert_perst(stm32_pcie);
+		return ret;
+	}
+
+	stm32_pcie_assert_perst(stm32_pcie);
+
+	clk_disable_unprepare(stm32_pcie->clk);
+
+	if (!device_wakeup_path(dev))
+		phy_exit(stm32_pcie->phy);
+
+	return pinctrl_pm_select_sleep_state(dev);
+}
+
+static int stm32_pcie_resume_noirq(struct device *dev)
+{
+	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
+	int ret;
+
+	/*
+	 * The core clock is gated with CLKREQ# from the COMBOPHY REFCLK,
+	 * thus if no device is present, must force it low with an init pinmux
+	 * to be able to access the DBI registers.
+	 */
+	if (!IS_ERR(dev->pins->init_state))
+		ret = pinctrl_select_state(dev->pins->p, dev->pins->init_state);
+	else
+		ret = pinctrl_pm_select_default_state(dev);
+
+	if (ret) {
+		dev_err(dev, "Failed to activate pinctrl pm state: %d\n", ret);
+		return ret;
+	}
+
+	if (!device_wakeup_path(dev)) {
+		ret = phy_init(stm32_pcie->phy);
+		if (ret) {
+			pinctrl_pm_select_default_state(dev);
+			return ret;
+		}
+	}
+
+	ret = clk_prepare_enable(stm32_pcie->clk);
+	if (ret)
+		goto err_phy_exit;
+
+	stm32_pcie_deassert_perst(stm32_pcie);
+
+	ret = dw_pcie_resume_noirq(&stm32_pcie->pci);
+	if (ret)
+		goto err_disable_clk;
+
+	pinctrl_pm_select_default_state(dev);
+
+	return 0;
+
+err_disable_clk:
+	stm32_pcie_assert_perst(stm32_pcie);
+	clk_disable_unprepare(stm32_pcie->clk);
+
+err_phy_exit:
+	phy_exit(stm32_pcie->phy);
+	pinctrl_pm_select_default_state(dev);
+
+	return ret;
+}
+
+static const struct dev_pm_ops stm32_pcie_pm_ops = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(stm32_pcie_suspend_noirq,
+				  stm32_pcie_resume_noirq)
+};
+
+static const struct dw_pcie_host_ops stm32_pcie_host_ops = {
+};
+
+static const struct dw_pcie_ops dw_pcie_ops = {
+	.start_link = stm32_pcie_start_link,
+	.stop_link = stm32_pcie_stop_link
+};
+
+static int stm32_add_pcie_port(struct stm32_pcie *stm32_pcie,
+			       struct platform_device *pdev)
+{
+	struct device *dev = stm32_pcie->pci.dev;
+	unsigned int wake_irq;
+	int ret;
+
+	/* Start to enable resources with PERST# asserted from GPIO */
+
+	ret = phy_set_mode(stm32_pcie->phy, PHY_MODE_PCIE);
+	if (ret)
+		return ret;
+
+	ret = phy_init(stm32_pcie->phy);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
+				 STM32MP25_PCIECR_TYPE_MASK,
+				 STM32MP25_PCIECR_RC);
+	if (ret)
+		goto err_phy_exit;
+
+	stm32_pcie_deassert_perst(stm32_pcie);
+
+	if (stm32_pcie->wake_gpio) {
+		wake_irq = gpiod_to_irq(stm32_pcie->wake_gpio);
+		ret = dev_pm_set_dedicated_wake_irq(dev, wake_irq);
+		if (ret) {
+			dev_info(dev, "Failed to enable wake# %d\n", ret);
+			goto err_disable_clk;
+		}
+		irq_set_irq_type(wake_irq, IRQ_TYPE_EDGE_FALLING);
+	}
+
+	return 0;
+
+err_disable_clk:
+	stm32_pcie_assert_perst(stm32_pcie);
+	clk_disable_unprepare(stm32_pcie->clk);
+
+err_phy_exit:
+	phy_exit(stm32_pcie->phy);
+
+	return ret;
+}
+
+static void stm32_remove_pcie_port(struct stm32_pcie *stm32_pcie)
+{
+	stm32_pcie_assert_perst(stm32_pcie);
+
+	phy_exit(stm32_pcie->phy);
+}
+
+static int stm32_pcie_parse_port(struct stm32_pcie *stm32_pcie)
+{
+	struct device *dev = stm32_pcie->pci.dev;
+	struct device_node *root_port;
+
+	root_port = of_get_next_available_child(dev->of_node, NULL);
+
+	stm32_pcie->phy = devm_of_phy_get(dev, root_port, NULL);
+	if (IS_ERR(stm32_pcie->phy)) {
+		of_node_put(root_port);
+		return dev_err_probe(dev, PTR_ERR(stm32_pcie->phy),
+				     "Failed to get pcie-phy\n");
+	}
+
+	stm32_pcie->perst_gpio = devm_fwnode_gpiod_get(dev, of_fwnode_handle(root_port),
+						       "reset", GPIOD_OUT_HIGH, NULL);
+	if (IS_ERR(stm32_pcie->perst_gpio)) {
+		if (PTR_ERR(stm32_pcie->perst_gpio) != -ENOENT) {
+			of_node_put(root_port);
+			return dev_err_probe(dev, PTR_ERR(stm32_pcie->perst_gpio),
+					     "Failed to get reset GPIO\n");
+		}
+		stm32_pcie->perst_gpio = NULL;
+	}
+
+	stm32_pcie->wake_gpio = devm_fwnode_gpiod_get(dev, of_fwnode_handle(root_port),
+						      "wake", GPIOD_IN, NULL);
+
+	if (IS_ERR(stm32_pcie->wake_gpio)) {
+		if (PTR_ERR(stm32_pcie->wake_gpio) != -ENOENT) {
+			of_node_put(root_port);
+			return dev_err_probe(dev, PTR_ERR(stm32_pcie->wake_gpio),
+					     "Failed to get wake GPIO\n");
+		}
+		stm32_pcie->wake_gpio = NULL;
+	}
+
+	of_node_put(root_port);
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
+	stm32_pcie->pci.pp.ops = &stm32_pcie_host_ops;
+
+	stm32_pcie->regmap = syscon_regmap_lookup_by_compatible("st,stm32mp25-syscfg");
+	if (IS_ERR(stm32_pcie->regmap))
+		return dev_err_probe(dev, PTR_ERR(stm32_pcie->regmap),
+				     "No syscfg specified\n");
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
+	ret = stm32_pcie_parse_port(stm32_pcie);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, stm32_pcie);
+
+	ret = pm_runtime_set_active(dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to activate runtime PM %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enable runtime PM %d\n", ret);
+		return ret;
+	}
+
+	pm_runtime_get_noresume(dev);
+
+	ret = stm32_add_pcie_port(stm32_pcie, pdev);
+	if (ret) {
+		pm_runtime_put_noidle(&pdev->dev);
+		return ret;
+	}
+
+	reset_control_assert(stm32_pcie->rst);
+	reset_control_deassert(stm32_pcie->rst);
+
+	ret = clk_prepare_enable(stm32_pcie->clk);
+	if (ret) {
+		dev_err(dev, "Core clock enable failed %d\n", ret);
+		goto err_remove_port;
+	}
+
+	ret = dw_pcie_host_init(&stm32_pcie->pci.pp);
+	if (ret)
+		goto err_disable_clk;
+
+	if (stm32_pcie->wake_gpio)
+		device_set_wakeup_capable(dev, true);
+
+	return 0;
+
+err_disable_clk:
+	clk_disable_unprepare(stm32_pcie->clk);
+
+err_remove_port:
+	stm32_remove_pcie_port(stm32_pcie);
+	pm_runtime_put_noidle(&pdev->dev);
+
+	return ret;
+}
+
+static void stm32_pcie_remove(struct platform_device *pdev)
+{
+	struct stm32_pcie *stm32_pcie = platform_get_drvdata(pdev);
+	struct dw_pcie_rp *pp = &stm32_pcie->pci.pp;
+
+	if (stm32_pcie->wake_gpio)
+		device_init_wakeup(&pdev->dev, false);
+
+	dw_pcie_host_deinit(pp);
+
+	clk_disable_unprepare(stm32_pcie->clk);
+
+	stm32_remove_pcie_port(stm32_pcie);
+
+	pm_runtime_put_noidle(&pdev->dev);
+}
+
+static const struct of_device_id stm32_pcie_of_match[] = {
+	{ .compatible = "st,stm32mp25-pcie-rc" },
+	{},
+};
+
+static struct platform_driver stm32_pcie_driver = {
+	.probe = stm32_pcie_probe,
+	.remove = stm32_pcie_remove,
+	.driver = {
+		.name = "stm32-pcie",
+		.of_match_table = stm32_pcie_of_match,
+		.pm = &stm32_pcie_pm_ops,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+};
+
+module_platform_driver(stm32_pcie_driver);
+
+MODULE_AUTHOR("Christian Bruel <christian.bruel@foss.st.com>");
+MODULE_DESCRIPTION("STM32MP25 PCIe Controller driver");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(of, stm32_pcie_of_match);
diff --git a/drivers/pci/controller/dwc/pcie-stm32.h b/drivers/pci/controller/dwc/pcie-stm32.h
new file mode 100644
index 000000000000..387112c4e42c
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-stm32.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * ST PCIe driver definitions for STM32-MP25 SoC
+ *
+ * Copyright (C) 2025 STMicroelectronics - All Rights Reserved
+ * Author: Christian Bruel <christian.bruel@foss.st.com>
+ */
+
+#define to_stm32_pcie(x)	dev_get_drvdata((x)->dev)
+
+#define STM32MP25_PCIECR_TYPE_MASK	GENMASK(11, 8)
+#define STM32MP25_PCIECR_LTSSM_EN	BIT(2)
+#define STM32MP25_PCIECR_RC		BIT(10)
+
+#define SYSCFG_PCIECR			0x6000
-- 
2.34.1


