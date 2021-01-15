Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4362F72B9
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jan 2021 07:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbhAOGFx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jan 2021 01:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbhAOGFv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jan 2021 01:05:51 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE327C0613C1;
        Thu, 14 Jan 2021 22:05:10 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id v1so4469131pjr.2;
        Thu, 14 Jan 2021 22:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6IuB7okmm4g8iZhOLGdXJ25ES928aPE/USDIOuy3fT4=;
        b=YMJoA9Szbpefv+EvZ1Dw3ayWhlClAI8fNedRpJhFmIC1bi1C1qY1vuU+ZJ3M9pmvN6
         8H8/NwSZO2uosSjzQBXMFfB81fV53h3pUUL27eK7DKOWC5O7grzd/79PdHPaosF4v0ta
         qG1w7thsU2NeOb1zM0dr6JqHsrp22recjLVt4b2sSX9LLLci2vQrHUZXoEaTPjtYwEQn
         OjA2t/6kvAS+L+UOxuhBBSTlFe4twxUQUglOPe4CCF4sI2Gj53qBFGRchWChKW89M8I5
         TlA3zN8MteWIZWG5o/mXcwp2pUkz3Nj+Fl1yvsCQ4Gmho009lOsVHrSU5ufls3PPFBq1
         iiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6IuB7okmm4g8iZhOLGdXJ25ES928aPE/USDIOuy3fT4=;
        b=TkhfSux7DlK2h8AYnPWHPktLbDIGzo343GB7iWLrKNOw910+hTwcJ5wyg8chpQMlxz
         YdkYW70bsva2pV/RGnJHI7yVPMxFXbe/oRuS8NtbhicIUJLffD1jpOnEiJXFHEmPhwib
         XdMvY6TFXFMEwhj6/gQ4GuMtNjhBpWhJ16Qmbtm6suz9NXYmoWwzRfinrfTsreebFXcz
         Ba0FwOHI+jP5Af4S2H2lMYSjIq1KRTbjyBCkC0foQXWNMTbLy0FenRtuL5GElJzay4z/
         Y6Xktsv7xnZki6RtIO+8fd3Mv3LNkCzaAUqM96BbflwxWJZYRoQgYfD/d8UHRq9MjZpZ
         UbKA==
X-Gm-Message-State: AOAM5309A5IGSu/49pQmGPSufs4qIhmoQfjuX8qqcL4BTKRdf1cgZYCa
        TwhfqiX63+A24Ux7y1Q+dd0=
X-Google-Smtp-Source: ABdhPJyR/+qt79x4Z+7Wm21ue+YRAf9Nat7+lqSDumQ9Y7pfN1HWoTEasvNMvjnE/J0uxp39BNN9WQ==
X-Received: by 2002:a17:902:c104:b029:da:5206:8b9b with SMTP id 4-20020a170902c104b02900da52068b9bmr11032747pli.46.1610690710254;
        Thu, 14 Jan 2021 22:05:10 -0800 (PST)
Received: from sh05419pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id t5sm7051929pjr.22.2021.01.14.22.05.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jan 2021 22:05:09 -0800 (PST)
From:   Hongtao Wu <wuht06@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hongtao Wu <billows.wu@unisoc.com>
Subject: [PATCH v6 2/2] PCI: sprd: Add support for Unisoc SoCs' PCIe controller
Date:   Fri, 15 Jan 2021 14:04:40 +0800
Message-Id: <1610690680-28493-3-git-send-email-wuht06@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610690680-28493-1-git-send-email-wuht06@gmail.com>
References: <1610690680-28493-1-git-send-email-wuht06@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hongtao Wu <billows.wu@unisoc.com>

This series adds PCIe controller driver for Unisoc SoCs.
This controller is based on DesignWare PCIe IP.

Signed-off-by: Hongtao Wu <billows.wu@unisoc.com>
---
 drivers/pci/controller/dwc/Kconfig     |  12 ++
 drivers/pci/controller/dwc/Makefile    |   1 +
 drivers/pci/controller/dwc/pcie-sprd.c | 293 +++++++++++++++++++++++++++++++++
 3 files changed, 306 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-sprd.c

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 22c5529..61f0b79 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -318,4 +318,16 @@ config PCIE_AL
 	  required only for DT-based platforms. ACPI platforms with the
 	  Annapurna Labs PCIe controller don't need to enable this.

+config PCIE_SPRD
+	tristate "Unisoc PCIe controller - Host Mode"
+	depends on ARCH_SPRD || COMPILE_TEST
+	depends on PCI_MSI_IRQ_DOMAIN
+	select PCIE_DW_HOST
+	help
+	  Unisoc PCIe controller uses the DesignWare core. It can be configured
+	  as an Endpoint (EP) or a Root complex (RC). In order to enable host
+	  mode (the controller works as RC), PCIE_SPRD must be selected.
+	  Say Y or M here if you want to PCIe RC controller support on Unisoc
+	  SoCs.
+
 endmenu
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index a751553..eb546e9 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_PCI_MESON) += pci-meson.o
 obj-$(CONFIG_PCIE_TEGRA194) += pcie-tegra194.o
 obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
 obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
+obj-$(CONFIG_PCIE_SPRD) += pcie-sprd.o

 # The following drivers are for devices that use the generic ACPI
 # pci_root.c driver but don't support standard ECAM config access.
diff --git a/drivers/pci/controller/dwc/pcie-sprd.c b/drivers/pci/controller/dwc/pcie-sprd.c
new file mode 100644
index 0000000..03e2064
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-sprd.c
@@ -0,0 +1,293 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe host controller driver for Unisoc SoCs
+ *
+ * Copyright (C) 2020-2021 Unisoc, Inc.
+ *
+ * Author: Hongtao Wu <Billows.Wu@unisoc.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+
+#include "pcie-designware.h"
+
+/* aon apb syscon */
+#define IPA_ACCESS_CFG		0xcd8
+#define  AON_ACCESS_PCIE_EN	BIT(1)
+
+/* pmu apb syscon */
+#define SNPS_PCIE3_SLP_CTRL	0xac
+#define  PERST_N_ASSERT		BIT(1)
+#define  PERST_N_AUTO_EN	BIT(0)
+#define PD_PCIE_CFG_0		0x3e8
+#define  PCIE_FORCE_SHUTDOWN	BIT(25)
+
+#define PCIE_SS_REG_BASE		0xE00
+#define APB_CLKFREQ_TIMEOUT		0x4
+#define  BUSERR_EN			BIT(12)
+#define  APB_TIMER_DIS			BIT(10)
+#define  APB_TIMER_LIMIT		GENMASK(31, 16)
+
+#define PE0_GEN_CTRL_3			0x58
+#define  LTSSM_EN			BIT(0)
+
+struct sprd_pcie_soc_data {
+	u32 syscon_offset;
+};
+
+static const struct sprd_pcie_soc_data ums9520_syscon_data = {
+	.syscon_offset = 0x1000,	/* The offset of set/clear register */
+};
+
+struct sprd_pcie {
+	u32 syscon_offset;
+	struct device	*dev;
+	struct dw_pcie	*pci;
+	struct regmap	*aon_map;
+	struct regmap	*pmu_map;
+	const struct sprd_pcie_soc_data *socdata;
+};
+
+enum sprd_pcie_syscon_type {
+	normal_syscon,		/* it's not a set/clear register */
+	set_syscon,		/* set a set/clear register */
+	clr_syscon,		/* clear a set/clear register */
+};
+
+static void sprd_pcie_buserr_enable(struct dw_pcie *pci)
+{
+	u32 val;
+
+	val = dw_pcie_readl_dbi(pci, PCIE_SS_REG_BASE + APB_CLKFREQ_TIMEOUT);
+	val &= ~APB_TIMER_DIS;
+	val |= BUSERR_EN;
+	val |= APB_TIMER_LIMIT & (0x1f4 << 16);
+	dw_pcie_writel_dbi(pci, PCIE_SS_REG_BASE + APB_CLKFREQ_TIMEOUT, val);
+}
+
+static void sprd_pcie_ltssm_enable(struct dw_pcie *pci, bool enable)
+{
+	u32 val;
+
+	val = dw_pcie_readl_dbi(pci, PCIE_SS_REG_BASE + PE0_GEN_CTRL_3);
+	if (enable)
+		dw_pcie_writel_dbi(pci, PCIE_SS_REG_BASE + PE0_GEN_CTRL_3,
+				   val | LTSSM_EN);
+	else
+		dw_pcie_writel_dbi(pci, PCIE_SS_REG_BASE + PE0_GEN_CTRL_3,
+				   val & ~LTSSM_EN);
+}
+
+static int sprd_pcie_syscon_set(struct sprd_pcie *ctrl, struct regmap *map,
+				u32 reg, u32 mask, u32 val,
+				enum sprd_pcie_syscon_type type)
+{
+	int ret = 0;
+	u32 read_val;
+	u32 offset = ctrl->syscon_offset;
+	struct device *dev = ctrl->pci->dev;
+
+	/*
+	 * Each set/clear register has three registers:
+	 * reg:			base register
+	 * reg + offset:	set register
+	 * reg + offset * 2:	clear register
+	 */
+	switch (type) {
+	case normal_syscon:
+		ret = regmap_read(map, reg, &read_val);
+		if (ret) {
+			dev_err(dev, "failed to read register 0x%x\n", reg);
+			return ret;
+		}
+		read_val &= ~mask;
+		read_val |= (val & mask);
+		ret = regmap_write(map, reg, read_val);
+		break;
+	case set_syscon:
+		reg = reg + offset;
+		ret = regmap_write(map, reg, val);
+		break;
+	case clr_syscon:
+		reg = reg + offset * 2;
+		ret = regmap_write(map, reg, val);
+		break;
+	default:
+		break;
+	}
+
+	if (ret)
+		dev_err(dev, "failed to write register 0x%x\n", reg);
+
+	return ret;
+}
+
+static int sprd_pcie_perst_assert(struct sprd_pcie *ctrl)
+{
+	return sprd_pcie_syscon_set(ctrl, ctrl->pmu_map, SNPS_PCIE3_SLP_CTRL,
+				    PERST_N_ASSERT, PERST_N_ASSERT, set_syscon);
+}
+
+static int sprd_pcie_perst_deassert(struct sprd_pcie *ctrl)
+{
+	int ret;
+
+	ret = sprd_pcie_syscon_set(ctrl, ctrl->pmu_map, SNPS_PCIE3_SLP_CTRL,
+				   PERST_N_ASSERT, 0, clr_syscon);
+	usleep_range(2000, 3000);
+
+	return ret;
+}
+
+static int sprd_pcie_power_on(struct platform_device *pdev)
+{
+	int ret;
+	struct sprd_pcie *ctrl = platform_get_drvdata(pdev);
+	struct dw_pcie *pci = ctrl->pci;
+
+	ret = sprd_pcie_syscon_set(ctrl, ctrl->aon_map, PD_PCIE_CFG_0,
+				   PCIE_FORCE_SHUTDOWN, 0, clr_syscon);
+	if (ret)
+		return ret;
+
+	ret = sprd_pcie_syscon_set(ctrl, ctrl->aon_map, IPA_ACCESS_CFG,
+				   AON_ACCESS_PCIE_EN, AON_ACCESS_PCIE_EN,
+				   set_syscon);
+	if (ret)
+		return ret;
+
+	ret = sprd_pcie_perst_deassert(ctrl);
+	if (ret)
+		return ret;
+
+	sprd_pcie_buserr_enable(pci);
+	sprd_pcie_ltssm_enable(pci, true);
+
+	return ret;
+}
+
+static int sprd_pcie_power_off(struct platform_device *pdev)
+{
+	struct sprd_pcie *ctrl = platform_get_drvdata(pdev);
+	struct dw_pcie *pci = ctrl->pci;
+
+	sprd_pcie_ltssm_enable(pci, false);
+
+	sprd_pcie_perst_assert(ctrl);
+	sprd_pcie_syscon_set(ctrl, ctrl->aon_map, PD_PCIE_CFG_0,
+			     PCIE_FORCE_SHUTDOWN, PCIE_FORCE_SHUTDOWN,
+			     set_syscon);
+	sprd_pcie_syscon_set(ctrl, ctrl->aon_map, IPA_ACCESS_CFG,
+			     AON_ACCESS_PCIE_EN, 0, clr_syscon);
+
+	return 0;
+}
+
+static int sprd_add_pcie_port(struct platform_device *pdev)
+{
+	struct sprd_pcie *ctrl = platform_get_drvdata(pdev);
+	struct dw_pcie *pci = ctrl->pci;
+	struct pcie_port *pp = &pci->pp;
+
+	return dw_pcie_host_init(pp);
+}
+
+static int sprd_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct sprd_pcie *ctrl;
+	struct dw_pcie *pci;
+	int ret;
+
+	ctrl = devm_kzalloc(dev, sizeof(*ctrl), GFP_KERNEL);
+	if (!ctrl)
+		return -ENOMEM;
+
+	ctrl->socdata =
+		(struct sprd_pcie_soc_data *)of_device_get_match_data(dev);
+	if (!ctrl->socdata) {
+		dev_warn(dev,
+			 "using the default set/clear register offset address");
+		ctrl->syscon_offset = 0x1000;
+	}
+	ctrl->syscon_offset = ctrl->socdata->syscon_offset;
+
+	ctrl->aon_map = syscon_regmap_lookup_by_phandle(dev->of_node,
+							"sprd, regmap-aon");
+	if (IS_ERR(ctrl->aon_map)) {
+		dev_err(dev, "failed to get syscon regmap aon\n");
+		ret = PTR_ERR(ctrl->aon_map);
+		goto err;
+	}
+
+	ctrl->pmu_map = syscon_regmap_lookup_by_phandle(dev->of_node,
+							"sprd, regmap-pmu");
+	if (IS_ERR(ctrl->pmu_map)) {
+		dev_err(dev, "failed to get syscon regmap pmu\n");
+		ret = PTR_ERR(ctrl->pmu_map);
+		goto err;
+	}
+
+	pci = ctrl->pci;
+	pci->dev = dev;
+
+	platform_set_drvdata(pdev, ctrl);
+
+	ret = sprd_pcie_power_on(pdev);
+	if (ret < 0) {
+		dev_err(dev, "failed to power on, return %d\n",
+			ret);
+		goto err_power_off;
+	}
+
+	ret = sprd_add_pcie_port(pdev);
+	if (ret) {
+		dev_warn(dev, "failed to initialize RC controller\n");
+		return ret;
+	}
+
+	return 0;
+
+err_power_off:
+	sprd_pcie_power_off(pdev);
+err:
+	return ret;
+}
+
+static int sprd_pcie_remove(struct platform_device *pdev)
+{
+	sprd_pcie_power_off(pdev);
+
+	return 0;
+}
+
+static const struct of_device_id sprd_pcie_of_match[] = {
+	{
+		.compatible = "sprd,ums9520-pcie",
+		.data  = &ums9520_syscon_data,
+	},
+	{},
+};
+
+static struct platform_driver sprd_pcie_driver = {
+	.probe = sprd_pcie_probe,
+	.remove = sprd_pcie_remove,
+	.driver = {
+		.name = "sprd-pcie",
+		.of_match_table = sprd_pcie_of_match,
+	},
+};
+
+module_platform_driver(sprd_pcie_driver);
+
+MODULE_DESCRIPTION("Unisoc PCIe host controller driver");
+MODULE_LICENSE("GPL");
--
2.7.4

