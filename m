Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDED6343CA7
	for <lists+linux-pci@lfdr.de>; Mon, 22 Mar 2021 10:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbhCVJVl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Mar 2021 05:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhCVJVh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Mar 2021 05:21:37 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F87C061574;
        Mon, 22 Mar 2021 02:21:37 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso8168304pjb.3;
        Mon, 22 Mar 2021 02:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CK80aFMX0bS1rniZA0KRM4WOA/j7creJGY+xWPncBlM=;
        b=TNVFpgwdW5CfOL4Gm2gKe/WGRBrz3LL6fYGrRg2BJIMMpbu++H/VtXU6q2YiWFhVtw
         ko4zjBqB5dTJaHhtDi9Tf/UvDqmsK+nJJ9U4ywQ8n5ziARp3DfGlEuv2D0c+owSdlRAc
         6aT+vIRyrxweqVLtG7SdD+L0IEidgPWKuQ8+7HYVKczC0C7iW/DEecrBXE70KdSygWGx
         0FIqFgpxKCJwbKej1KB5J2ULwY8M/cXph3Bunprxpip4yHEscso8i8WMVTCU3FxTnJsT
         ZKnb6pBTz9FLxNprMkcvYf7KqeQdZnCucjgfg8J8wLghwIdcuJfLSqdcI39PDBPVLCh+
         IaNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CK80aFMX0bS1rniZA0KRM4WOA/j7creJGY+xWPncBlM=;
        b=ipMIo2gWEbYamqy/vYKpTJ4heAOeKwpGyiGGxYxDpdgDzA9BciIYx9Y4kSUqabxrsa
         CXjo7QnyrLtNTffll0hOgTC6/XBqyJd/oeW0S7iQUsMwG0yocxIC7jIU3fn+4LUuVDvI
         JzUYx4abGJWhqQhbCPqslYAkntZgMl8HLdM7BdTp85Xs2uAW9It6n9wFCPRFFbvSAHOS
         nAWBagdvmK3qx+RX/1WXSpzR2tyzjj4c5BLGMy2vr5OCmniY9mLQZ0T6dgyty85bsmho
         0/WKA7C6wSi5/WRDMgQHkjw0omOqgb8O8YnldsjlT1NBn6gMeZuLJIiK8U/f9MyHay/V
         GNJw==
X-Gm-Message-State: AOAM531o5DKSJK3yxSKpw4eMATDJQsR0mETPS0knWCWL5MHEekmRbwQ0
        gihnEEgrlpJEyz9jN/OM1oGTSTcDdl0=
X-Google-Smtp-Source: ABdhPJx9TS01gWPFFmZ5gKAcG5BRS5rXBkE4ZBzc/ty4TeLFOQyWUWDcmwey8Hpk9DvCEE4dR7ALOA==
X-Received: by 2002:a17:902:d304:b029:e6:bab4:8df3 with SMTP id b4-20020a170902d304b02900e6bab48df3mr25845030plc.5.1616404896853;
        Mon, 22 Mar 2021 02:21:36 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id w17sm11987756pfu.29.2021.03.22.02.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 02:21:36 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Hongtao Wu <wuht06@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [RESEND PATCH V6 2/2] PCI: sprd: Add support for Unisoc SoCs' PCIe controller
Date:   Mon, 22 Mar 2021 17:18:31 +0800
Message-Id: <20210322091831.662279-3-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210322091831.662279-1-zhang.lyra@gmail.com>
References: <20210322091831.662279-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hongtao Wu <billows.wu@unisoc.com>

This series adds PCIe controller driver for Unisoc SoCs.
This controller is based on DesignWare PCIe IP.

Signed-off-by: Hongtao Wu <billows.wu@unisoc.com>
Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
---
 drivers/pci/controller/dwc/Kconfig     |  12 +
 drivers/pci/controller/dwc/Makefile    |   1 +
 drivers/pci/controller/dwc/pcie-sprd.c | 292 +++++++++++++++++++++++++
 3 files changed, 305 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-sprd.c

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 22c5529e9a65..61f0b79f963d 100644
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
index a751553fa0db..eb546e97c14a 100644
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
index 000000000000..2ccb99eda24f
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-sprd.c
@@ -0,0 +1,292 @@
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
+module_platform_driver(sprd_pcie_driver);
+
+MODULE_DESCRIPTION("Unisoc PCIe host controller driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

