Return-Path: <linux-pci+bounces-27725-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CB7AB6E68
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 16:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AC18188B558
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 14:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D611A5B82;
	Wed, 14 May 2025 14:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ap8g2a1q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3A68488;
	Wed, 14 May 2025 14:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747234107; cv=none; b=agYG5UzZXp+aXlcaHWw+25lZ1aXG5Yg7NVIzsGdtUEGz2Jlg2VbDW//lPFdrcxjHYAM8qZerZ+nc7Tks0+MN7LIohTGiB/kfC5310NZivtgGMeFva5hg+y1CQ/z7qr3u/a1iRKbc+punESK1JLbTsQopUuiEVTPx7gdXZiW+cPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747234107; c=relaxed/simple;
	bh=SCXHLzweUhrUJ4W/a5xtDXw1cIdiaxcL2f89K1zgy2I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mRDgmAA+ifQmoz8QF6JUDQHgpT2ORZOQGL3RmNgzBCStNXdRj6XrbZpkNYXWLa40G3NML9/QJJfPR7AHlE8Ksj9P1WHrbM4fmz7P4UdRbSc/Cp2w0jrFOZ4+uTXTGc0J5J734F2uGeNhjONWRbc6X7AZkugfo0WiottnmyGcqs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ap8g2a1q; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EDT6QK031895;
	Wed, 14 May 2025 16:48:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	2ge3N4SZms2+ktUaFsxam/0rl408JhaycQhZhQP/FUk=; b=ap8g2a1qAJ9iIEES
	sY59CdHhi7ly4RXgSWittRMml56Jf48N+bgNyleO/KbCtcwlithFowpLqKNHDTdZ
	JY54UTM7SDYJZxjTcfa8hiS9ZFjrabLlwDieIvagMixLEl1mPWr8LFYZG+J86ugH
	r8NPmeF5zU3fQ12BxkC8RBrEkZpQRr2iNknf8VYHXale9/R7zZ3RgSHOEKLNMVf6
	bZ4Jno3ocB3/UydEg//vOI1ynNmcr036vf7hKX/azxV1eOt8EEr81pQk2TrfzYaM
	8wDiQVnG05KiRn8IbBZeGDZ8a4LAAy5dfo57R9nMxU7YulOfCmOisdTweAsxfspu
	BOi4iw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46mbdw4b9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 16:48:01 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B955340052;
	Wed, 14 May 2025 16:46:36 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C0098AF054D;
	Wed, 14 May 2025 16:44:33 +0200 (CEST)
Received: from localhost (10.130.77.120) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 16:44:33 +0200
From: Christian Bruel <christian.bruel@foss.st.com>
To: <christian.bruel@foss.st.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <p.zabel@pengutronix.de>, <thippeswamy.havalige@amd.com>,
        <shradha.t@samsung.com>, <quic_schintav@quicinc.com>,
        <cassel@kernel.org>, <johan+linaro@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 2/9] PCI: stm32: Add PCIe host support for STM32MP25
Date: Wed, 14 May 2025 16:44:21 +0200
Message-ID: <20250514144428.3340709-3-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514144428.3340709-1-christian.bruel@foss.st.com>
References: <20250514144428.3340709-1-christian.bruel@foss.st.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01

Add driver for the STM32MP25 SoC PCIe Gen1 2.5 GT/s and Gen2 5GT/s
controller based on the DesignWare PCIe core.

Supports MSI via GICv2m, Single Virtual Channel, Single Function

Supports WAKE# GPIO.

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
 drivers/pci/controller/dwc/Kconfig      |  12 +
 drivers/pci/controller/dwc/Makefile     |   1 +
 drivers/pci/controller/dwc/pcie-stm32.c | 364 ++++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-stm32.h |  15 +
 4 files changed, 392 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-stm32.c
 create mode 100644 drivers/pci/controller/dwc/pcie-stm32.h

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index d9f0386396ed..387151f25f5f 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -410,6 +410,18 @@ config PCIE_SPEAR13XX
 	help
 	  Say Y here if you want PCIe support on SPEAr13XX SoCs.
 
+config PCIE_STM32_HOST
+	tristate "STMicroelectronics STM32MP25 PCIe Controller (host mode)"
+	depends on ARCH_STM32 || COMPILE_TEST
+	depends on PCI_MSI
+	select PCIE_DW_HOST
+	help
+	  Enables Root Complex (RC) support for the DesignWare core based PCIe
+	  controller found in STM32MP25 SoC.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called pcie-stm32.
+
 config PCI_DRA7XX
 	tristate
 
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index 908cb7f345db..9d3b43504725 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
 obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
 obj-$(CONFIG_PCIE_VISCONTI_HOST) += pcie-visconti.o
 obj-$(CONFIG_PCIE_RCAR_GEN4) += pcie-rcar-gen4.o
+obj-$(CONFIG_PCIE_STM32_HOST) += pcie-stm32.o
 
 # The following drivers are for devices that use the generic ACPI
 # pci_root.c driver but don't support standard ECAM config access.
diff --git a/drivers/pci/controller/dwc/pcie-stm32.c b/drivers/pci/controller/dwc/pcie-stm32.c
new file mode 100644
index 000000000000..f08c81a5797f
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-stm32.c
@@ -0,0 +1,364 @@
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
+	/* Delay PERST# de-assertion until the power stabilizes */
+	msleep(PCIE_T_PVPERL_MS);
+
+	gpiod_set_value(stm32_pcie->perst_gpio, 0);
+
+	/* Wait for the REFCLK to stabilize */
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
+	if (ret)
+		return ret;
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
+	/* Start to enable resources with PERST# asserted */
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
+			dev_err(dev, "Failed to enable wakeup irq %d\n", ret);
+			goto err_assert_perst;
+		}
+		irq_set_irq_type(wake_irq, IRQ_TYPE_EDGE_FALLING);
+	}
+
+	return 0;
+
+err_assert_perst:
+	stm32_pcie_assert_perst(stm32_pcie);
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
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to activate runtime PM\n");
+
+	pm_runtime_get_noresume(dev);
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
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
+		device_init_wakeup(dev, true);
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


