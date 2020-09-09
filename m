Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C00262C6C
	for <lists+linux-pci@lfdr.de>; Wed,  9 Sep 2020 11:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgIIJst (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Sep 2020 05:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbgIIJsr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Sep 2020 05:48:47 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15426C061573;
        Wed,  9 Sep 2020 02:48:47 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id u3so1078287pjr.3;
        Wed, 09 Sep 2020 02:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qQLOx4lboBJj/WJQbW/iAO3Ytg7264C/ffuMfUy96Ug=;
        b=nn80wmq4XXx2zmLnRo1OM2NtkreT2HFfuQdZYu7hnC9A4VUT9kSMWYzzlv2F2tE2Np
         1f5vFqQUspTJH+ZDhQ43Mw0RsnZGnngB14uAy6BkQR46teV/o7yIU5XPO23wV3sibHP8
         5cEzQIzRy/5M0bsWS1lmYKwlvtS0XjEebrLqNpbZxmeRNz1leRkdPR1nBFnTaQQrPNZJ
         57/ZjoLsz1XBfG2LUumNx2zeIomWZJLsA0HdSpK5R49MwGg7EXX9TxlkpFmYdKLzGG7H
         F5g0FEQma2hTeZQhQc1niXtSVMhNnFgO0qfHGOs+gPK5CLIC0HscQ0WkG9MTDWACmC4G
         uWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qQLOx4lboBJj/WJQbW/iAO3Ytg7264C/ffuMfUy96Ug=;
        b=Sub5ft/0mt7DFYtcP80EOoJbrb45wyhQMe0kd8CAGU7Ct6K59rp70enYGv0y/Xm/KZ
         86X6U61uI2cz5g72Qp/DKEqRHuTezkM95Y8K0EhJE/f/0hyRMKK9DY+Fr0oZ/0cO94rO
         3ImSnMhexlgHjKFit4cxPD8nSmYefnQp0JMAfqvvXxFVZ7/bVkjzrTJNxAcSm7creoJI
         cET2aL6xRaso+rbAbg6h9DcT2KIIBXN1PebSBGfemfM0NDEyeqecVlwmFwcMwm8k3KE4
         ojD2OsLGoBzUHH7bE+gIAI5hzm6MDxsh8HMlWq8aAuGLE8M/Dqu+1qpP+bAAhPjUp1DU
         TfZw==
X-Gm-Message-State: AOAM532/CG3PcDq6dgdNa97bwTl3r3BjO9Heis5iNxyVSJCQb1ruV9re
        A94GJwmvN22HGewT+QYRf4rJSWJtpmA=
X-Google-Smtp-Source: ABdhPJxwMoBIZW/bbrMMaspHgiEXXqjo8MpvZEzK8Pwlq1eG4XN0Nz6oflJS9ThBBIS5pF+W02fkpg==
X-Received: by 2002:a17:90b:3105:: with SMTP id gc5mr85211pjb.225.1599644926585;
        Wed, 09 Sep 2020 02:48:46 -0700 (PDT)
Received: from sh05419pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id u14sm2224149pfc.203.2020.09.09.02.48.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Sep 2020 02:48:46 -0700 (PDT)
From:   Hongtao Wu <wuht06@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hongtao Wu <billows.wu@unisoc.com>
Subject: [PATCH v3 2/2] PCI: sprd: Add support for Unisoc SoCs' PCIe controller
Date:   Wed,  9 Sep 2020 17:48:32 +0800
Message-Id: <1599644912-29245-3-git-send-email-wuht06@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599644912-29245-1-git-send-email-wuht06@gmail.com>
References: <1599644912-29245-1-git-send-email-wuht06@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hongtao Wu <billows.wu@unisoc.com>

This series adds PCIe controller driver for Unisoc SoCs.
This controller is based on DesignWare PCIe IP.

Signed-off-by: Hongtao Wu <billows.wu@unisoc.com>
---
 drivers/pci/controller/dwc/Kconfig     |  13 ++
 drivers/pci/controller/dwc/Makefile    |   1 +
 drivers/pci/controller/dwc/pcie-sprd.c | 231 +++++++++++++++++++++++++++++++++
 3 files changed, 245 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-sprd.c

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 044a376..0553010 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -311,4 +311,17 @@ config PCIE_AL
 	  required only for DT-based platforms. ACPI platforms with the
 	  Annapurna Labs PCIe controller don't need to enable this.

+
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
index 0000000..cec4f34
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-sprd.c
@@ -0,0 +1,231 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe host controller driver for Unisoc SoCs
+ *
+ * Copyright (C) 2020 Unisoc, Inc.
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
+#define NUM_OF_ARGS 5
+
+struct sprd_pcie {
+	struct dw_pcie pci;
+};
+
+static int sprd_pcie_syscon_setting(struct platform_device *pdev, char *env)
+{
+	struct device_node *np = pdev->dev.of_node;
+	int i, count, err;
+	u32 type, delay, reg, mask, val, tmp_val;
+	struct of_phandle_args out_args;
+	struct regmap *iomap;
+	struct device *dev = &pdev->dev;
+
+	if (!of_find_property(np, env, NULL)) {
+		dev_info(dev, "There isn't property %s in dts\n", env);
+		return 0;
+	}
+
+	count = of_property_count_elems_of_size(np, env,
+					(NUM_OF_ARGS + 1) * sizeof(u32));
+	dev_info(dev, "Property (%s) reg count is %d :\n", env, count);
+
+	for (i = 0; i < count; i++) {
+		err = of_parse_phandle_with_fixed_args(np, env, NUM_OF_ARGS,
+						       i, &out_args);
+		if (err < 0)
+			return err;
+
+		type = out_args.args[0];
+		delay = out_args.args[1];
+		reg = out_args.args[2];
+		mask = out_args.args[3];
+		val = out_args.args[4];
+
+		iomap = syscon_node_to_regmap(out_args.np);
+
+		switch (type) {
+		case 0:
+			regmap_update_bits(iomap, reg, mask, val);
+			break;
+
+		case 1:
+			regmap_read(iomap, reg, &tmp_val);
+			tmp_val &= (~mask);
+			tmp_val |= (val & mask);
+			regmap_write(iomap, reg, tmp_val);
+			break;
+		default:
+			break;
+		}
+
+		if (delay)
+			usleep_range(delay, delay + 10);
+
+		regmap_read(iomap, reg, &tmp_val);
+		dev_dbg(dev,
+			"%2d:reg[0x%8x] mask[0x%8x] val[0x%8x] result[0x%8x]\n",
+			i, reg, mask, val, tmp_val);
+	}
+
+	return i;
+}
+
+static int sprd_pcie_perst_assert(struct platform_device *pdev)
+{
+	return sprd_pcie_syscon_setting(pdev, "sprd,pcie-perst-assert");
+}
+
+static int sprd_pcie_perst_deassert(struct platform_device *pdev)
+{
+	return sprd_pcie_syscon_setting(pdev, "sprd,pcie-perst-deassert");
+}
+
+static int sprd_pcie_power_on(struct platform_device *pdev)
+{
+	int ret;
+	struct device *dev = &pdev->dev;
+
+	ret = sprd_pcie_syscon_setting(pdev, "sprd,pcie-poweron-syscons");
+	if (ret < 0)
+		dev_err(dev,
+			"failed to set pcie poweroff syscons, return %d\n",
+			ret);
+
+	sprd_pcie_perst_deassert(pdev);
+
+	return ret;
+}
+
+static int sprd_pcie_power_off(struct platform_device *pdev)
+{
+	int ret;
+	struct device *dev = &pdev->dev;
+
+	sprd_pcie_perst_assert(pdev);
+
+	ret = sprd_pcie_syscon_setting(pdev, "sprd,pcie-poweroff-syscons");
+	if (ret < 0)
+		dev_err(dev,
+			"failed to set pcie poweroff syscons, return %d\n",
+			ret);
+
+	return ret;
+}
+
+static int sprd_pcie_host_init(struct pcie_port *pp)
+{
+	int ret;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+
+	dw_pcie_setup_rc(pp);
+	dw_pcie_msi_init(pp);
+
+	ret = dw_pcie_wait_for_link(pci);
+	if (ret)
+		dev_err(pci->dev, "pcie ep may has not been powered on yet\n");
+
+	return ret;
+}
+
+static const struct dw_pcie_host_ops sprd_pcie_host_ops = {
+	.host_init = sprd_pcie_host_init,
+};
+
+static int sprd_add_pcie_port(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct sprd_pcie *ctrl = platform_get_drvdata(pdev);
+	struct dw_pcie *pci = &ctrl->pci;
+	struct pcie_port *pp = &pci->pp;
+
+	pci->dbi_base = devm_platform_ioremap_resource_byname(pdev, "dbi");
+	if (IS_ERR(pci->dbi_base)) {
+		dev_err(dev, "failed to get rc dbi base\n");
+		return PTR_ERR(pci->dbi_base);
+	}
+
+	pp->ops = &sprd_pcie_host_ops;
+
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
+		if (pp->msi_irq < 0) {
+			dev_err(dev, "failed to get msi, return %d\n",
+				pp->msi_irq);
+			return pp->msi_irq;
+		}
+	}
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
+	pci = &ctrl->pci;
+	pci->dev = dev;
+
+	platform_set_drvdata(pdev, ctrl);
+
+	ret = sprd_pcie_power_on(pdev);
+	if (ret < 0) {
+		dev_err(dev, "failed to get pcie poweron syscons, return %d\n",
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
+
+	return ret;
+}
+
+static const struct of_device_id sprd_pcie_of_match[] = {
+	{
+		.compatible = "sprd,pcie-rc",
+	},
+	{},
+};
+
+static struct platform_driver sprd_pcie_driver = {
+	.probe = sprd_pcie_probe,
+	.driver = {
+		.name = "sprd-pcie",
+		.of_match_table = sprd_pcie_of_match,
+	},
+};
+
+module_platform_driver(sprd_pcie_driver);
+
+MODULE_DESCRIPTION("Unisoc PCIe host controller driver");
+MODULE_LICENSE("GPL v2");
--
2.7.4

