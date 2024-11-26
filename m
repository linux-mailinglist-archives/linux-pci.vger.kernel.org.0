Return-Path: <linux-pci+bounces-17348-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083709D97FE
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 14:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFD311629D5
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 13:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005C21D4607;
	Tue, 26 Nov 2024 13:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="jHRkhx8R"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D559E1CD219;
	Tue, 26 Nov 2024 13:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732626332; cv=none; b=TgwG6N2wgjAZFFZxiz1vwbUW7MNUnSid/ksyJ8LB5uwsKUZHeSr7zMeztNDUWvlYk5OutgSJC6/UyZK9vHGRs7a8qPLl9n17QqOyexfeRyYFLZhM4aP8+LNS3+F1eUMCF4PG9EG9CYrqITkadutNKjmuCo/EX4HGRFa3GXpKgXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732626332; c=relaxed/simple;
	bh=UoAnJcN7rhg37rHUar+e7rc6Ui0/D5BrKqXVM++jD74=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F4UgPU5EOdjGi1mUbztmtCJLBIbLh0+0S+PC52MfMck2VMa2UNdkx8VcWoEd8rRo33VZSZ2YgPHkrV2g+xQ0z45GeXskpwjwiOmYUlJYEecqLlW4GpagpzAtSw6AnZjJ088Z4EjHDA4Dkhimn+68g2PyAfMgT7okwNWb46idrT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=jHRkhx8R; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQAk5Fr013054;
	Tue, 26 Nov 2024 14:05:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	Ckv8DU3wVRBsedsU5ghPXH+xu3unAgyEHKX2ZlBqv9k=; b=jHRkhx8R7DLX5aBJ
	dMMXhqqLe6zG2GOi/X4n7PN3z9CNth7GRi9eXOKXKxTU0M+EUduNHfJX2sr+2/Zm
	i1eCW5OLd2o1IJXarROtOtDSCjAiqr/RAJfFmAaq/CG39olfdXroN+n5jgUrAPdu
	9IBgMBRPa369CjspAD9qYKornATuyScVtLtM0uW3e4VgNhCsz77lRQ1FHkg+o8/Z
	YXh6xjsenFuIPjav+L/72TeqwAzKEbe/TPmyutv69Rw4qGEyVFxVCml2/PciHs5d
	TXxr59MB5Lee4wpkXL2BEv89MNqhF270SggtCsN6FxuktKdkE3GkzdWOvCvVPkDL
	Ixiqsg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 433tvnjf9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 14:05:09 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B2A1A40048;
	Tue, 26 Nov 2024 14:03:28 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8FCF926FCF3;
	Tue, 26 Nov 2024 14:00:27 +0100 (CET)
Received: from localhost (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 26 Nov
 2024 14:00:27 +0100
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
Subject: [PATCH v1 2/5] PCI: stm32: Add PCIe host support for STM32MP25
Date: Tue, 26 Nov 2024 14:00:01 +0100
Message-ID: <20241126130004.1570091-3-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241126130004.1570091-1-christian.bruel@foss.st.com>
References: <20241126130004.1570091-1-christian.bruel@foss.st.com>
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

Add driver for the STM32MP25 SoC PCIe Gen2 controller based on the
DesignWare PCIe core.

Supports MSI via GICv2m, Single Virtual Channel, Single Function

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
 drivers/pci/controller/dwc/Kconfig      |  12 +
 drivers/pci/controller/dwc/Makefile     |   1 +
 drivers/pci/controller/dwc/pcie-stm32.c | 402 ++++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-stm32.h |  15 +
 4 files changed, 430 insertions(+)
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
index 000000000000..fa787406c0e4
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-stm32.c
@@ -0,0 +1,402 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * STMicroelectronics STM32MP25 PCIe root complex driver.
+ *
+ * Copyright (C) 2024 STMicroelectronics
+ * Author: Christian Bruel <christian.bruel@foss.st.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of_platform.h>
+#include <linux/phy/phy.h>
+#include <linux/pinctrl/devinfo.h>
+#include <linux/pm_runtime.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include "pcie-designware.h"
+#include "pcie-stm32.h"
+#include "../../pci.h"
+
+struct stm32_pcie {
+	struct dw_pcie *pci;
+	struct regmap *regmap;
+	struct reset_control *rst;
+	struct phy *phy;
+	struct clk *clk;
+	struct gpio_desc *perst_gpio;
+	struct gpio_desc *wake_gpio;
+	unsigned int wake_irq;
+	bool link_is_up;
+};
+
+static int stm32_pcie_start_link(struct dw_pcie *pci)
+{
+	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
+	u32 ret;
+
+	if (stm32_pcie->perst_gpio) {
+		/* Make sure PERST# is asserted. */
+		gpiod_set_value(stm32_pcie->perst_gpio, 1);
+
+		fsleep(PCIE_T_PERST_CLK_US);
+		gpiod_set_value(stm32_pcie->perst_gpio, 0);
+	}
+
+	ret = regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
+				 STM32MP25_PCIECR_LTSSM_EN,
+				 STM32MP25_PCIECR_LTSSM_EN);
+
+	if (stm32_pcie->perst_gpio)
+		msleep(PCIE_T_RRS_READY_MS);
+
+	return ret;
+}
+
+static void stm32_pcie_stop_link(struct dw_pcie *pci)
+{
+	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
+
+	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
+			   STM32MP25_PCIECR_LTSSM_EN, 0);
+
+	/* Assert PERST# */
+	if (stm32_pcie->perst_gpio)
+		gpiod_set_value(stm32_pcie->perst_gpio, 1);
+}
+
+static int stm32_pcie_suspend(struct device *dev)
+{
+	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev) || device_wakeup_path(dev))
+		enable_irq_wake(stm32_pcie->wake_irq);
+
+	return 0;
+}
+
+static int stm32_pcie_resume(struct device *dev)
+{
+	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev) || device_wakeup_path(dev))
+		disable_irq_wake(stm32_pcie->wake_irq);
+
+	return 0;
+}
+
+static int stm32_pcie_suspend_noirq(struct device *dev)
+{
+	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
+
+	stm32_pcie->link_is_up = dw_pcie_link_up(stm32_pcie->pci);
+
+	stm32_pcie_stop_link(stm32_pcie->pci);
+	clk_disable_unprepare(stm32_pcie->clk);
+
+	if (!device_may_wakeup(dev) && !device_wakeup_path(dev))
+		phy_exit(stm32_pcie->phy);
+
+	return pinctrl_pm_select_sleep_state(dev);
+}
+
+static int stm32_pcie_resume_noirq(struct device *dev)
+{
+	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
+	struct dw_pcie *pci = stm32_pcie->pci;
+	struct dw_pcie_rp *pp = &pci->pp;
+	int ret;
+
+	/* init_state must be called first to force clk_req# gpio when no
+	 * device is plugged.
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
+	if (!device_may_wakeup(dev) && !device_wakeup_path(dev)) {
+		ret = phy_init(stm32_pcie->phy);
+		if (ret) {
+			pinctrl_pm_select_default_state(dev);
+			return ret;
+		}
+	}
+
+	ret = clk_prepare_enable(stm32_pcie->clk);
+	if (ret)
+		goto clk_err;
+
+	ret = dw_pcie_setup_rc(pp);
+	if (ret)
+		goto pcie_err;
+
+	if (stm32_pcie->link_is_up) {
+		ret = stm32_pcie_start_link(stm32_pcie->pci);
+		if (ret)
+			goto pcie_err;
+
+		/* Ignore errors, the link may come up later */
+		dw_pcie_wait_for_link(stm32_pcie->pci);
+	}
+
+	pinctrl_pm_select_default_state(dev);
+
+	return 0;
+
+pcie_err:
+	dw_pcie_host_deinit(pp);
+	clk_disable_unprepare(stm32_pcie->clk);
+clk_err:
+	phy_exit(stm32_pcie->phy);
+	pinctrl_pm_select_default_state(dev);
+
+	return ret;
+}
+
+static const struct dev_pm_ops stm32_pcie_pm_ops = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(stm32_pcie_suspend_noirq,
+				  stm32_pcie_resume_noirq)
+	SYSTEM_SLEEP_PM_OPS(stm32_pcie_suspend, stm32_pcie_resume)
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
+static irqreturn_t stm32_pcie_wake_irq_handler(int irq, void *priv)
+{
+	struct stm32_pcie *stm32_pcie = priv;
+	struct device *dev = stm32_pcie->pci->dev;
+
+	dev_dbg(dev, "PCIe host wakeup by EP");
+
+	/* Notify PM core we are wakeup source */
+	pm_wakeup_event(dev, 0);
+	pm_system_wakeup();
+
+	return IRQ_HANDLED;
+}
+
+static int stm32_add_pcie_port(struct stm32_pcie *stm32_pcie,
+			       struct platform_device *pdev)
+{
+	struct dw_pcie *pci = stm32_pcie->pci;
+	struct device *dev = pci->dev;
+	struct dw_pcie_rp *pp = &pci->pp;
+	int ret;
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
+		goto phy_disable;
+
+	reset_control_assert(stm32_pcie->rst);
+	reset_control_deassert(stm32_pcie->rst);
+
+	ret = clk_prepare_enable(stm32_pcie->clk);
+	if (ret) {
+		dev_err(dev, "Core clock enable failed %d\n", ret);
+		goto phy_disable;
+	}
+
+	pp->ops = &stm32_pcie_host_ops;
+	ret = dw_pcie_host_init(pp);
+	if (ret) {
+		dev_err(dev, "Failed to initialize host: %d\n", ret);
+		clk_disable_unprepare(stm32_pcie->clk);
+		goto phy_disable;
+	}
+
+	return 0;
+
+phy_disable:
+	phy_exit(stm32_pcie->phy);
+
+	return ret;
+}
+
+static int stm32_pcie_probe(struct platform_device *pdev)
+{
+	struct stm32_pcie *stm32_pcie;
+	struct dw_pcie *dw;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = pdev->dev.of_node;
+	int ret;
+
+	stm32_pcie = devm_kzalloc(dev, sizeof(*stm32_pcie), GFP_KERNEL);
+	if (!stm32_pcie)
+		return -ENOMEM;
+
+	dw = devm_kzalloc(dev, sizeof(*dw), GFP_KERNEL);
+	if (!dw)
+		return -ENOMEM;
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
+				     "Failed to get pcie-phy\n");
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
+	stm32_pcie->perst_gpio = devm_gpiod_get_optional(dev, "reset",
+							 GPIOD_OUT_HIGH);
+	if (IS_ERR(stm32_pcie->perst_gpio))
+		return dev_err_probe(dev, PTR_ERR(stm32_pcie->perst_gpio),
+				     "Failed to get reset GPIO\n");
+
+	platform_set_drvdata(pdev, stm32_pcie);
+
+	if (device_property_read_bool(dev, "wakeup-source")) {
+		stm32_pcie->wake_gpio = devm_gpiod_get_optional(dev, "wake",
+								GPIOD_IN);
+		if (IS_ERR(stm32_pcie->wake_gpio))
+			return dev_err_probe(dev, PTR_ERR(stm32_pcie->wake_gpio),
+					     "Failed to get wake GPIO\n");
+	}
+
+	if (stm32_pcie->wake_gpio) {
+		stm32_pcie->wake_irq = gpiod_to_irq(stm32_pcie->wake_gpio);
+
+		ret = devm_request_threaded_irq(&pdev->dev,
+						stm32_pcie->wake_irq, NULL,
+						stm32_pcie_wake_irq_handler,
+						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+						"wake_irq", stm32_pcie);
+
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to request WAKE IRQ: %d\n", ret);
+	}
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enable runtime PM %d\n", ret);
+		return ret;
+	}
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to get runtime PM %d\n", ret);
+		return ret;
+	}
+
+	ret = stm32_add_pcie_port(stm32_pcie, pdev);
+	if (ret)  {
+		pm_runtime_put_sync(&pdev->dev);
+		return ret;
+	}
+
+	if (stm32_pcie->wake_gpio)
+		device_set_wakeup_capable(dev, true);
+
+	return 0;
+}
+
+static void stm32_pcie_remove(struct platform_device *pdev)
+{
+	struct stm32_pcie *stm32_pcie = platform_get_drvdata(pdev);
+	struct dw_pcie_rp *pp = &stm32_pcie->pci->pp;
+
+	if (stm32_pcie->wake_gpio)
+		device_init_wakeup(&pdev->dev, false);
+
+	dw_pcie_host_deinit(pp);
+	clk_disable_unprepare(stm32_pcie->clk);
+
+	phy_exit(stm32_pcie->phy);
+
+	pm_runtime_put_sync(&pdev->dev);
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
+		.pm		= &stm32_pcie_pm_ops,
+	},
+};
+
+static bool is_stm32_pcie_driver(struct device *dev)
+{
+	/* PCI bridge */
+	dev = get_device(dev);
+
+	/* Platform driver */
+	dev = get_device(dev->parent);
+
+	return (dev->driver == &stm32_pcie_driver.driver);
+}
+
+/*
+ * DMA masters can only access the first 4GB of memory space,
+ * so we setup the bus DMA limit accordingly.
+ */
+static int stm32_dma_limit(struct pci_dev *pdev, void *data)
+{
+	dev_dbg(&pdev->dev, "disabling DMA DAC for device");
+
+	pdev->dev.bus_dma_limit = DMA_BIT_MASK(32);
+
+	return 0;
+}
+
+static void quirk_stm32_dma_mask(struct pci_dev *pci)
+{
+	struct pci_dev *root_port;
+
+	root_port = pcie_find_root_port(pci);
+
+	if (root_port && is_stm32_pcie_driver(root_port->dev.parent))
+		pci_walk_bus(pci->bus, stm32_dma_limit, NULL);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SYNOPSYS, 0x0550, quirk_stm32_dma_mask);
+
+module_platform_driver(stm32_pcie_driver);
+
+MODULE_AUTHOR("Christian Bruel <christian.bruel@foss.st.com>");
+MODULE_DESCRIPTION("STM32MP25 PCIe Controller driver");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(of, stm32_pcie_of_match);
diff --git a/drivers/pci/controller/dwc/pcie-stm32.h b/drivers/pci/controller/dwc/pcie-stm32.h
new file mode 100644
index 000000000000..3efd00937d3d
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-stm32.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * ST PCIe driver definitions for STM32-MP25 SoC
+ *
+ * Copyright (C) 2024 STMicroelectronics - All Rights Reserved
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


