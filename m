Return-Path: <linux-pci+bounces-16570-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 382709C5D41
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 17:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC42A2835D4
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 16:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548F820607C;
	Tue, 12 Nov 2024 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="PwnARzP/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A73205AB3;
	Tue, 12 Nov 2024 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731428890; cv=none; b=FUdPufJS2YEbS4SpfQs+M9vpLbPuAl2ejELCLmgNpR1mb21nnwI1jifIBDC88sAPSvE5fxicrUsPV2bJ+2xxW5LeMdakMqanHG5ncREOxyCg1qF9IsFNdUJCEduesFvmU8mjmOyGKvwIgJ0Aqg0upFyozLzl8gfWRBPyXI/PNAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731428890; c=relaxed/simple;
	bh=VmlJ+5tkf7cPA8aQdH0t4UyOzQ6Vzni9g2qOr8s3fRE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=frUoOHHkmLCpq8weDk0Yn5cZibEd1zBcsVrx1lo9QV44OUhQgdV+rjUinIajuAg8AkLY+HSnvyWcDpeo4foU/XcLWym/QOhuGwJl3EEWSYQhThu2Q19xKBA0qMMyc603V7dIugiAMgfZQw1fbSicW3GbQE0ps3izKChT4nsSimc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=PwnARzP/; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACBxTvJ003037;
	Tue, 12 Nov 2024 17:24:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	ySsDK7/B8c8BdQvcR6YJzHIWglvn/MPXnKe03TuYtSU=; b=PwnARzP/vMWWvNiu
	ZE/+GS0gMbTlKMdnvmosMTp/Wby1tfQC+IrE6dWGBY1KayMAJMDhtPW3iFJHpGOG
	4c5IoLMngRsx+ou2WPM6/a2SkYzGBvS+n+fc8vIP646jLFzUFy0pyjbijL/piAR5
	f46QKu9KQHYmLzrR9WqUoKrvBncb7HJj7l3QXKkb1c0XiAJYO3fuiybzPNoBu8DP
	j2+tggSbKlr/o6kOsidIgnfSlkdJO7iRzgIApS90xPlkFWe4xlHbBXwvJaz0XlMv
	z0+uzf+MYCpaK2B0Mtn9iMH6BSNiFhunQKAivKErExZpOxNN4Vf9RPI+p3SRmB1A
	rdpq+Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42syy1ndgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 17:24:42 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9AE684005A;
	Tue, 12 Nov 2024 17:23:21 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8AC152A4C8F;
	Tue, 12 Nov 2024 17:20:21 +0100 (CET)
Received: from localhost (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 12 Nov
 2024 17:20:21 +0100
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
Subject: [PATCH 2/5] PCI: stm32: Add PCIe host support for STM32MP25
Date: Tue, 12 Nov 2024 17:19:22 +0100
Message-ID: <20241112161925.999196-3-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112161925.999196-1-christian.bruel@foss.st.com>
References: <20241112161925.999196-1-christian.bruel@foss.st.com>
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
 drivers/pci/controller/dwc/Kconfig      |  11 +
 drivers/pci/controller/dwc/Makefile     |   1 +
 drivers/pci/controller/dwc/pcie-stm32.c | 493 ++++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-stm32.h |  24 ++
 4 files changed, 529 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-stm32.c
 create mode 100644 drivers/pci/controller/dwc/pcie-stm32.h

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index b6d6778b0698..50a014c2dfd0 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -459,4 +459,15 @@ config PCIE_VISCONTI_HOST
 	  Say Y here if you want PCIe controller support on Toshiba Visconti SoC.
 	  This driver supports TMPV7708 SoC.
 
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
 endmenu
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
index 000000000000..c27ab580a3bf
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-stm32.c
@@ -0,0 +1,493 @@
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
+
+struct stm32_pcie {
+	struct dw_pcie *pci;
+	struct regmap *regmap;
+	struct reset_control *rst;
+	struct phy *phy;
+	struct clk *clk;
+	struct gpio_desc *reset_gpio;
+	struct gpio_desc *wake_gpio;
+	unsigned int wake_irq;
+	u32 max_payload;
+	bool limit_downstream_mrrs;
+	bool link_is_up;
+};
+
+static const struct of_device_id stm32_pcie_of_match[] = {
+	{ .compatible = "st,stm32mp25-pcie-rc" },
+	{},
+};
+
+static int stm32_pcie_set_max_payload(struct dw_pcie *pci, int mps)
+{
+	int ret;
+	struct device *dev = pci->dev;
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (mps != 128 && mps != 256) {
+		dev_err(dev, "Unexpected payload size %d\n", mps);
+		return -EINVAL;
+	}
+
+	ret = pcie_set_mps(pdev, mps);
+	if (ret)
+		dev_err(dev, "failed to set mps %d, error %d\n", mps, ret);
+
+	return ret;
+}
+
+static int stm32_pcie_host_init(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
+
+	if (stm32_pcie->max_payload)
+		return stm32_pcie_set_max_payload(pci, stm32_pcie->max_payload);
+
+	return 0;
+}
+
+static int stm32_pcie_start_link(struct dw_pcie *pci)
+{
+	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
+	u32 ret;
+
+	if (stm32_pcie->reset_gpio) {
+		/* Make sure PERST# is asserted. */
+		gpiod_set_value(stm32_pcie->reset_gpio, 1);
+
+		/* Deassert PERST# after 100us */
+		usleep_range(100, 200);
+		gpiod_set_value(stm32_pcie->reset_gpio, 0);
+	}
+
+	ret = regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
+				 STM32MP25_PCIECR_LTSSM_EN,
+				 STM32MP25_PCIECR_LTSSM_EN);
+
+	/*
+	 * PCIe specification states that you should not issue any config
+	 * requests until 100ms after asserting reset, so we enforce that here
+	 */
+	if (stm32_pcie->reset_gpio)
+		msleep(100);
+
+	return ret;
+}
+
+static void stm32_pcie_stop_link(struct dw_pcie *pci)
+{
+	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
+
+	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR, STM32MP25_PCIECR_LTSSM_EN, 0);
+
+	/* Assert PERST# */
+	if (stm32_pcie->reset_gpio)
+		gpiod_set_value(stm32_pcie->reset_gpio, 1);
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
+	/* init_state was set in pinctrl_bind_pins() before probe */
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
+	ret = stm32_pcie_host_init(pp);
+	if (ret)
+		goto host_err;
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
+host_err:
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
+	.init = stm32_pcie_host_init
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
+	dev_dbg(dev, "PCIE host wakeup by EP");
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
+				 STM32MP25_PCIECR_TYPE_MASK, STM32MP25_PCIECR_RC);
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
+		dev_err(dev, "failed to initialize host: %d\n", ret);
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
+				     "failed to get pcie-phy\n");
+
+	stm32_pcie->clk = devm_clk_get(dev, "core");
+	if (IS_ERR(stm32_pcie->clk))
+		return dev_err_probe(dev, PTR_ERR(stm32_pcie->clk),
+				     "Failed to get PCIe clock source\n");
+
+	stm32_pcie->rst = devm_reset_control_get_exclusive(dev, "core");
+	if (IS_ERR(stm32_pcie->rst))
+		return dev_err_probe(dev, PTR_ERR(stm32_pcie->rst),
+				     "Failed to get PCIe reset\n");
+
+	/* Optionally limit payload */
+	ret = of_property_read_u32(np, "st,max-payload-size", &stm32_pcie->max_payload);
+	if (ret && ret != -EINVAL)
+		return dev_err_probe(dev, ret, "Error reading max-payload value\n");
+
+	if (of_property_read_bool(np, "st,limit-mrrs"))
+		stm32_pcie->limit_downstream_mrrs = true;
+
+	stm32_pcie->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(stm32_pcie->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(stm32_pcie->reset_gpio),
+				     "Failed to get reset GPIO\n");
+
+	platform_set_drvdata(pdev, stm32_pcie);
+
+	if (device_property_read_bool(dev, "wakeup-source")) {
+		stm32_pcie->wake_gpio = devm_gpiod_get_optional(dev, "wake", GPIOD_IN);
+		if (IS_ERR(stm32_pcie->wake_gpio))
+			return dev_err_probe(dev, PTR_ERR(stm32_pcie->wake_gpio),
+					     "Failed to get wake GPIO\n");
+	}
+
+	if (stm32_pcie->wake_gpio) {
+		stm32_pcie->wake_irq = gpiod_to_irq(stm32_pcie->wake_gpio);
+
+		ret = devm_request_threaded_irq(&pdev->dev, stm32_pcie->wake_irq, NULL,
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
+		dev_err(dev, "Failed to enable pm runtime %d\n", ret);
+		return ret;
+	}
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0) {
+		dev_err(dev, "pm runtime resume failed: %d\n", ret);
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
+static struct platform_driver stm32_pcie_driver = {
+	.probe = stm32_pcie_probe,
+	.remove_new = stm32_pcie_remove,
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
+static bool apply_mrrs_quirk(struct pci_dev *root_port)
+{
+	struct dw_pcie_rp *pp;
+	struct dw_pcie *dw_pci;
+	struct stm32_pcie *stm32_pcie;
+
+	if (WARN_ON(!root_port) || !is_stm32_pcie_driver(root_port->dev.parent))
+		return false;
+
+	pp = root_port->bus->sysdata;
+	dw_pci = to_dw_pcie_from_pp(pp);
+	stm32_pcie = to_stm32_pcie(dw_pci);
+
+	if (!stm32_pcie->limit_downstream_mrrs)
+		return false;
+
+	return true;
+}
+
+static void quirk_stm32_pcie_limit_mrrs(struct pci_dev *pci)
+{
+	struct pci_dev *root_port;
+	struct pci_bus *bus = pci->bus;
+	int readrq;
+	int mps;
+
+	if (pci_is_root_bus(bus))
+		return;
+
+	root_port = pcie_find_root_port(pci);
+
+	if (!apply_mrrs_quirk(root_port))
+		return;
+
+	mps = pcie_get_mps(root_port);
+
+	/*
+	 * STM32 PCI controller has a h/w performance limitation on the AXI DDR requests.
+	 * Limit the maximum read request size to 256B on all downstream devices.
+	 */
+	readrq = pcie_get_readrq(pci);
+	if (readrq > 256) {
+		int mrrs = min(mps, 256);
+
+		pcie_set_readrq(pci, mrrs);
+
+		pci_info(pci, "Max Read Rq set to %4d (was %4d)\n", mrrs, readrq);
+	}
+}
+
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID,
+			 quirk_stm32_pcie_limit_mrrs);
+
+static int stm32_dma_limit(struct pci_dev *pdev, void *data)
+{
+	dev_dbg(&pdev->dev, "set bus_dma_limit");
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
index 000000000000..7e9300bfddce
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-stm32.h
@@ -0,0 +1,24 @@
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
+#define STM32MP25_PCIECR_EP		0
+#define STM32MP25_PCIECR_RC		BIT(10)
+#define STM32MP25_PCIECR_REQ_RETRY_EN	BIT(3)
+#define STM32MP25_PCIECR_LTSSM_EN	BIT(2)
+
+#define SYSCFG_PCIECR			0x6000
+#define SYSCFG_PCIEPMEMSICR		0x6004
+#define SYSCFG_PCIEAERRCMSICR		0x6008
+#define SYSCFG_PCIESR1			0x6100
+#define SYSCFG_PCIESR2			0x6104
+
+#define PCIE_CAP_MAX_PAYLOAD_SIZE(x)	((x) << 5)
+#define PCIE_CAP_MAX_READ_REQ_SIZE(x)	((x) << 12)
-- 
2.34.1


