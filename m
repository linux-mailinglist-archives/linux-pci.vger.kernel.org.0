Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99DE24D1BE
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 11:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgHUJwR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Aug 2020 05:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728453AbgHUJwP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2020 05:52:15 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9FBC061385;
        Fri, 21 Aug 2020 02:52:14 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id d4so593596pjx.5;
        Fri, 21 Aug 2020 02:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8/mFnrSXtT6iJdnnmlP6WpblSsale1o7O600k1jCLPc=;
        b=FqEmlDrrRUjV4MBe4qxSeC55eEkA9Hy/clzDJG4gySzoqS2CjV0UcoEw4bUK3NJ1BM
         8zqYo3rWuhCebsDL6zV3Q7S0UREbmhT3roWaxGV/3k6KmoEhz5+PBIeuW6rpb95RPsB3
         76Ki+GrHmks80o81Ku4+dYGl2yDBJ8QNVt+F1v7iLI6jJn9rJ2XKCYXqAS880dVTJppl
         U3OW9CXUfThBgkQ0ipWAIB8IcM31mR+GRVaH9aVNpsRJgK9AstwbNlewPqKYqUtAspEH
         l+X3ZJSwYKy623gCrN8YlD/O/aU2HOH+sDS1l0QJQfT4u48QgbeiCaElF2mqoDo823qJ
         HWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8/mFnrSXtT6iJdnnmlP6WpblSsale1o7O600k1jCLPc=;
        b=W3I6jqo/sgVHd+Ji5yZfNOdjKU1DUXXbabY+1nqMlULGmeRaJv6Rcq+Rk1t0/HhTTe
         bxKNgoRG4OVmD/4qmiue4xvaeAwA98Yx9mUuJYleBS+lq3NCQInzpo0YEsKCa2fT3+Z7
         2K9f2RaoDhVbhassgdjkWpBHmfjnOpRJOMUUe0g/3xcgWpSsMb5BKMKORBUMkseMvvRV
         HnysWK7cdaDyXQWxvGE7jj6cxHhbOar3U/Fajkf91vBxEUvLF+wfGzI5Daz8eKWpBE5J
         ncheD36vLeRjq8i66KVncosO+0mik+YfSxYtnhpi87XYPftFg38p4zXO9HK5au2u2q/J
         1R2w==
X-Gm-Message-State: AOAM532qJQTgsGmJVAiwOMYMY2E90mMu8+MuCAO0FhSQasIXSflAc+fR
        UzDTuHIAGi9LJbW1EBuS7ic=
X-Google-Smtp-Source: ABdhPJwBV0mMl6gw8eh6XoQvaGTvnTQHM9XaSVnxKz6y+OQgOFx7vGtiCAMRPgHsjSidGz+OgdQBuw==
X-Received: by 2002:a17:902:d715:: with SMTP id w21mr1915631ply.14.1598003534446;
        Fri, 21 Aug 2020 02:52:14 -0700 (PDT)
Received: from sh05419pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id d5sm1479828pjw.18.2020.08.21.02.52.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 02:52:13 -0700 (PDT)
From:   Hongtao Wu <wuht06@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Billows Wu <billows.wu@unisoc.com>
Subject: [PATCH 2/2] PCI: sprd: Add support for Unisoc SoCs' PCIe controller
Date:   Fri, 21 Aug 2020 17:51:49 +0800
Message-Id: <1598003509-27896-3-git-send-email-wuht06@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598003509-27896-1-git-send-email-wuht06@gmail.com>
References: <1598003509-27896-1-git-send-email-wuht06@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Billows Wu <billows.wu@unisoc.com>

This series adds PCIe controller driver for Unisoc SoCs.
This controller is based on DesignWare PCIe IP.

Signed-off-by: Billows Wu <billows.wu@unisoc.com>
---
 drivers/pci/controller/dwc/Kconfig     |  12 ++
 drivers/pci/controller/dwc/Makefile    |   1 +
 drivers/pci/controller/dwc/pcie-sprd.c | 256 +++++++++++++++++++++++++++++++++
 3 files changed, 269 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-sprd.c

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 044a376..d26ce94 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -311,4 +311,16 @@ config PCIE_AL
 	  required only for DT-based platforms. ACPI platforms with the
 	  Annapurna Labs PCIe controller don't need to enable this.

+config PCIE_SPRD
+       tristate "Unisoc PCIe controller - RC mode"
+       depends on ARCH_SPRD
+       depends on PCI_MSI_IRQ_DOMAIN
+       select PCIE_DW_HOST
+       help
+         Some Uisoc SoCs contain two PCIe controllers as RC: One is gen2,
+         and the other is gen3. While other Unisoc SoCs may have only one
+         PCIe controller which can be configured as an Endpoint(EP) or a Root
+         complex(RC). In order to enable host-specific features PCIE_SPRD must
+         be selected, which uses the Designware core.
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
index 0000000..cda812d
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-sprd.c
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe host controller driver for Unisoc SoCs
+ *
+ * Copyright (C) 2020 Unisoc corporation. http://www.unisoc.com
+ *
+ * Author: Billows Wu <Billows.Wu@unisoc.com>
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
+#include <linux/pm_runtime.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+
+#include "pcie-designware.h"
+
+#define NUM_OF_ARGS 5
+
+struct sprd_pcie {
+       struct dw_pcie *pci;
+};
+
+struct sprd_pcie_of_data {
+       enum dw_pcie_device_mode mode;
+};
+
+static int sprd_pcie_establish_link(struct dw_pcie *pci)
+{
+       return 0;
+}
+
+static const struct dw_pcie_ops sprd_pcie_ops = {
+       .start_link = sprd_pcie_establish_link,
+};
+
+int sprd_pcie_syscon_setting(struct platform_device *pdev, char *env)
+{
+       struct device_node *np = pdev->dev.of_node;
+       int i, count, err;
+       u32 type, delay, reg, mask, val, tmp_val;
+       struct of_phandle_args out_args;
+       struct regmap *iomap;
+       struct device *dev = &pdev->dev;
+
+       if (!of_find_property(np, env, NULL)) {
+               dev_info(dev, "There isn't property %s in dts\n", env);
+               return 0;
+       }
+
+       count = of_property_count_elems_of_size(np, env,
+                               (NUM_OF_ARGS + 1) * sizeof(u32));
+       dev_info(dev, "Property (%s) reg count is %d :\n", env, count);
+
+       for (i = 0; i < count; i++) {
+               err = of_parse_phandle_with_fixed_args(np, env, NUM_OF_ARGS,
+                                                      i, &out_args);
+               if (err < 0)
+                       return err;
+
+               type = out_args.args[0];
+               delay = out_args.args[1];
+               reg = out_args.args[2];
+               mask = out_args.args[3];
+               val = out_args.args[4];
+
+               iomap = syscon_node_to_regmap(out_args.np);
+
+               switch (type) {
+               case 0:
+                       regmap_update_bits(iomap, reg, mask, val);
+                       break;
+
+               case 1:
+                       regmap_read(iomap, reg, &tmp_val);
+                       tmp_val &= (~mask);
+                       tmp_val |= (val & mask);
+                       regmap_write(iomap, reg, tmp_val);
+                       break;
+               default:
+                       break;
+               }
+
+               if (delay)
+                       usleep_range(delay, delay + 10);
+
+               regmap_read(iomap, reg, &tmp_val);
+               dev_dbg(&pdev->dev,
+                       "%2d:reg[0x%8x] mask[0x%8x] val[0x%8x] result[0x%8x]\n",
+                       i, reg, mask, val, tmp_val);
+       }
+
+       return i;
+}
+
+static void sprd_pcie_perst_assert(struct platform_device *pdev)
+{
+       sprd_pcie_syscon_setting(pdev, "sprd,pcie-perst-assert");
+}
+
+static void sprd_pcie_perst_deassert(struct platform_device *pdev)
+{
+       sprd_pcie_syscon_setting(pdev, "sprd,pcie-perst-deassert");
+}
+
+static int sprd_pcie_host_shutdown(struct platform_device *pdev)
+{
+       int ret;
+       struct device *dev = &pdev->dev;
+
+       ret = sprd_pcie_syscon_setting(pdev, "sprd,pcie-shutdown-syscons");
+       if (ret < 0)
+               dev_err(dev,
+                       "Failed to set pcie shutdown syscons, return %d\n",
+                       ret);
+
+       sprd_pcie_perst_assert(pdev);
+
+       ret = pm_runtime_put(&pdev->dev);
+       if (ret < 0)
+               dev_warn(&pdev->dev,
+                        "Failed to put runtime,return %d\n", ret);
+
+       return ret;
+}
+
+static int sprd_pcie_host_init(struct pcie_port *pp)
+{
+       struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+       struct platform_device *pdev = to_platform_device(pci->dev);
+
+       sprd_pcie_perst_deassert(pdev);
+
+       dw_pcie_setup_rc(pp);
+
+       if (IS_ENABLED(CONFIG_PCI_MSI))
+               dw_pcie_msi_init(pp);
+
+       if (dw_pcie_wait_for_link(pci)) {
+               dev_warn(pci->dev,
+                        "pcie ep may has not been powered on yet\n");
+               sprd_pcie_host_shutdown(pdev);
+       }
+
+       return 0;
+}
+
+static const struct dw_pcie_host_ops sprd_pcie_host_ops = {
+       .host_init = sprd_pcie_host_init,
+};
+
+static int sprd_add_pcie_port(struct platform_device *pdev)
+{
+       struct resource *res;
+       struct device *dev = &pdev->dev;
+       struct sprd_pcie *ctrl = platform_get_drvdata(pdev);
+       struct dw_pcie *pci = ctrl->pci;
+       struct pcie_port *pp = &pci->pp;
+
+       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
+       if (!res)
+               return -EINVAL;
+
+       pci->dbi_base = devm_ioremap(dev, res->start, resource_size(res));
+       if (!pci->dbi_base)
+               return -ENOMEM;
+
+       pp->ops = &sprd_pcie_host_ops;
+
+       if (IS_ENABLED(CONFIG_PCI_MSI)) {
+               pp->msi_irq = platform_get_irq_byname(pdev, "msi");
+               if (pp->msi_irq < 0) {
+                       dev_err(dev, "Failed to get msi, return %d\n",
+                               pp->msi_irq);
+                       return pp->msi_irq;
+               }
+       }
+
+       return dw_pcie_host_init(pp);
+}
+
+static int sprd_pcie_probe(struct platform_device *pdev)
+{
+       struct device *dev = &pdev->dev;
+       struct dw_pcie *pci;
+       struct sprd_pcie *ctrl;
+       int ret;
+
+       ctrl = devm_kzalloc(dev, sizeof(*ctrl), GFP_KERNEL);
+       if (!ctrl)
+               return -ENOMEM;
+
+       pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
+       if (!pci)
+               return -ENOMEM;
+
+       pci->dev = dev;
+       pci->ops = &sprd_pcie_ops;
+       ctrl->pci = pci;
+
+       platform_set_drvdata(pdev, ctrl);
+
+       pm_runtime_enable(dev);
+       ret = pm_runtime_get_sync(dev);
+       if (ret < 0) {
+               dev_err(dev, "Fialed to get runtime sync, return %d\n", ret);
+               goto err_get_sync;
+       }
+
+       ret = sprd_pcie_syscon_setting(pdev, "sprd,pcie-startup-syscons");
+       if (ret < 0) {
+               dev_err(dev, "Failed to get pcie syscons, return %d\n", ret);
+               goto err_power_off;
+       }
+
+       ret = sprd_add_pcie_port(pdev);
+       if (ret)
+               dev_warn(dev, "Failed to initialize RC controller\n");
+
+       return 0;
+
+err_power_off:
+       sprd_pcie_syscon_setting(pdev, "sprd,pcie-shutdown-syscons");
+
+err_get_sync:
+       pm_runtime_put(&pdev->dev);
+       pm_runtime_disable(dev);
+
+       return ret;
+}
+
+static const struct of_device_id sprd_pcie_of_match[] = {
+       {
+               .compatible = "sprd,pcie",
+       },
+       {},
+};
+
+static struct platform_driver sprd_pcie_driver = {
+       .probe = sprd_pcie_probe,
+       .driver = {
+               .name = "sprd-pcie",
+               .of_match_table = sprd_pcie_of_match,
+       },
+};
+
+module_platform_driver(sprd_pcie_driver);
+
+MODULE_DESCRIPTION("Unisoc PCIe host controller driver");
+MODULE_LICENSE("GPL v2");
--
2.7.4

