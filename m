Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5F34EC6D9
	for <lists+linux-pci@lfdr.de>; Wed, 30 Mar 2022 16:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347053AbiC3Op1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Mar 2022 10:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347045AbiC3OpZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2022 10:45:25 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0E9C5BD35;
        Wed, 30 Mar 2022 07:43:35 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 5AB1C16AD;
        Wed, 30 Mar 2022 17:43:38 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 5AB1C16AD
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 30 Mar 2022 17:43:34 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        <linux-clk@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/4] clk: baikal-t1: Move reset-controls code into a dedicated module
Date:   Wed, 30 Mar 2022 17:43:19 +0300
Message-ID: <20220330144320.27039-4-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220330144320.27039-1-Sergey.Semin@baikalelectronics.ru>
References: <20220330144320.27039-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Before adding the directly controlled resets support it's reasonable to
move the existing resets control functionality into a dedicated object for
the sake of the CCU dividers clock driver simplification. After the new
functionality is added clk-ccu-div.c would have got to a mixture of the
weakly dependent clocks and resets methods. Splitting the methods up into
the two objects will make code easier to read especially seeing it isn't
that hard to do.

As before the CCU reset module will support the trigger-like CCU resets
only, which are responsible for the AXI-bus, APB-bus and SATA-ref blocks
reset. The assert/de-assert-capable reset controls support will be added
in the next commit.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/clk/baikal-t1/Kconfig       |  12 +-
 drivers/clk/baikal-t1/Makefile      |   1 +
 drivers/clk/baikal-t1/ccu-rst.c     | 258 ++++++++++++++++++++++++++++
 drivers/clk/baikal-t1/ccu-rst.h     |  60 +++++++
 drivers/clk/baikal-t1/clk-ccu-div.c |  94 ++--------
 5 files changed, 342 insertions(+), 83 deletions(-)
 create mode 100644 drivers/clk/baikal-t1/ccu-rst.c
 create mode 100644 drivers/clk/baikal-t1/ccu-rst.h

diff --git a/drivers/clk/baikal-t1/Kconfig b/drivers/clk/baikal-t1/Kconfig
index 03102f1094bc..666de354d513 100644
--- a/drivers/clk/baikal-t1/Kconfig
+++ b/drivers/clk/baikal-t1/Kconfig
@@ -29,7 +29,6 @@ config CLK_BT1_CCU_PLL
 
 config CLK_BT1_CCU_DIV
 	bool "Baikal-T1 CCU Dividers support"
-	select RESET_CONTROLLER
 	select MFD_SYSCON
 	default MIPS_BAIKAL_T1
 	help
@@ -39,4 +38,15 @@ config CLK_BT1_CCU_DIV
 	  either gateable or ungateable. Some of the CCU dividers can be as well
 	  used to reset the domains they're supplying clock to.
 
+config CLK_BT1_CCU_RST
+	bool "Baikal-T1 CCU Resets support"
+	select RESET_CONTROLLER
+	select MFD_SYSCON
+	default MIPS_BAIKAL_T1
+	help
+	  Enable this to support the CCU reset blocks responsible for the
+	  AXI-bus and some subsystems reset. These are mainly the trigger-based
+	  reset controls but there are several lines which can be directly
+	  asserted/de-asserted (PCIe and DDR sub-domains).
+
 endif
diff --git a/drivers/clk/baikal-t1/Makefile b/drivers/clk/baikal-t1/Makefile
index b3b9590b95ed..9c3637de9407 100644
--- a/drivers/clk/baikal-t1/Makefile
+++ b/drivers/clk/baikal-t1/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_CLK_BT1_CCU_PLL) += ccu-pll.o clk-ccu-pll.o
 obj-$(CONFIG_CLK_BT1_CCU_DIV) += ccu-div.o clk-ccu-div.o
+obj-$(CONFIG_CLK_BT1_CCU_RST) += ccu-rst.o
diff --git a/drivers/clk/baikal-t1/ccu-rst.c b/drivers/clk/baikal-t1/ccu-rst.c
new file mode 100644
index 000000000000..5e33c3ce962a
--- /dev/null
+++ b/drivers/clk/baikal-t1/ccu-rst.c
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021 BAIKAL ELECTRONICS, JSC
+ *
+ * Authors:
+ *   Serge Semin <Sergey.Semin@baikalelectronics.ru>
+ *
+ * Baikal-T1 CCU Resets interface driver
+ */
+
+#define pr_fmt(fmt) "bt1-ccu-rst: " fmt
+
+#include <linux/bits.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/printk.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include <dt-bindings/clock/bt1-ccu.h>
+#include <dt-bindings/reset/bt1-ccu.h>
+
+#include "ccu-div.h"
+#include "ccu-rst.h"
+
+#define CCU_RST_MAP(_rst_id, _clk_id)		\
+	{					\
+		.rst_id = _rst_id,		\
+		.clk_id = _clk_id,		\
+	}
+
+struct ccu_rst_map {
+	unsigned int rst_id;
+	unsigned int clk_id;
+};
+
+struct ccu_rst_data {
+	struct device_node *np;
+	struct regmap *sys_regs;
+
+	unsigned int rsts_num;
+	struct ccu_rst *rsts;
+
+	unsigned int rsts_map_num;
+	const struct ccu_rst_map *rsts_map;
+
+	unsigned int divs_num;
+	struct ccu_div **divs;
+
+	struct reset_controller_dev rcdev;
+};
+#define to_ccu_rst_data(_rcdev) container_of(_rcdev, struct ccu_rst_data, rcdev)
+
+/*
+ * Each AXI-bus clock divider is equipped with the corresponding clock-consumer
+ * domain reset (it's trigger-based).
+ */
+static const struct ccu_rst_map axi_rst_map[] = {
+	CCU_RST_MAP(CCU_AXI_MAIN_RST, CCU_AXI_MAIN_CLK),
+	CCU_RST_MAP(CCU_AXI_DDR_RST, CCU_AXI_DDR_CLK),
+	CCU_RST_MAP(CCU_AXI_SATA_RST, CCU_AXI_SATA_CLK),
+	CCU_RST_MAP(CCU_AXI_GMAC0_RST, CCU_AXI_GMAC0_CLK),
+	CCU_RST_MAP(CCU_AXI_GMAC1_RST, CCU_AXI_GMAC1_CLK),
+	CCU_RST_MAP(CCU_AXI_XGMAC_RST, CCU_AXI_XGMAC_CLK),
+	CCU_RST_MAP(CCU_AXI_PCIE_M_RST, CCU_AXI_PCIE_M_CLK),
+	CCU_RST_MAP(CCU_AXI_PCIE_S_RST, CCU_AXI_PCIE_S_CLK),
+	CCU_RST_MAP(CCU_AXI_USB_RST, CCU_AXI_USB_CLK),
+	CCU_RST_MAP(CCU_AXI_HWA_RST, CCU_AXI_HWA_CLK),
+	CCU_RST_MAP(CCU_AXI_SRAM_RST, CCU_AXI_SRAM_CLK),
+};
+
+/*
+ * SATA reference clock domain and APB-bus domain are connected with the
+ * trigger-based reset control, which can be activated via the corresponding
+ * clock divider register.
+ */
+static const struct ccu_rst_map sys_rst_map[] = {
+	CCU_RST_MAP(CCU_SYS_SATA_REF_RST, CCU_SYS_SATA_REF_CLK),
+	CCU_RST_MAP(CCU_SYS_APB_RST, CCU_SYS_APB_CLK),
+};
+
+static int ccu_rst_reset(struct reset_controller_dev *rcdev,
+			 unsigned long idx)
+{
+	struct ccu_rst_data *data = to_ccu_rst_data(rcdev);
+	struct ccu_rst *rst;
+
+	if (idx >= data->rsts_num) {
+		pr_err("Invalid reset ID %lu specified\n", idx);
+		return -EINVAL;
+	}
+
+	rst = &data->rsts[idx];
+	return ccu_div_reset_domain(rst->div);
+}
+
+static const struct reset_control_ops ccu_rst_ops = {
+	.reset = ccu_rst_reset,
+};
+
+static int ccu_rst_of_idx_get(struct reset_controller_dev *rcdev,
+			      const struct of_phandle_args *rstspec)
+{
+	struct ccu_rst_data *data = to_ccu_rst_data(rcdev);
+	unsigned int rst_id, idx;
+
+	rst_id = rstspec->args[0];
+	for (idx = 0; idx < data->rsts_num; ++idx) {
+		if (data->rsts[idx].id == rst_id)
+			break;
+	}
+	if (idx == data->rsts_num) {
+		pr_err("Invalid reset ID %u specified\n", rst_id);
+		return -EINVAL;
+	}
+
+	return idx;
+}
+
+static struct ccu_div *ccu_rst_find_div(struct ccu_rst_data *data,
+					unsigned int clk_id)
+{
+	struct ccu_div *div;
+	int idx;
+
+	for (idx = 0; idx < data->divs_num; ++idx) {
+		div = data->divs[idx];
+		if (div->id == clk_id)
+			return div;
+	}
+
+	return ERR_PTR(-EINVAL);
+}
+
+static struct ccu_rst_data *ccu_rst_create_data(const struct ccu_rst_init_data *rst_init)
+{
+	struct ccu_rst_data *data;
+	int ret;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return ERR_PTR(-ENOMEM);
+
+	data->np = rst_init->np;
+	data->sys_regs = rst_init->sys_regs;
+	data->divs_num = rst_init->divs_num;
+	data->divs = rst_init->divs;
+	if (of_device_is_compatible(data->np, "baikal,bt1-ccu-axi")) {
+		data->rsts_map_num = ARRAY_SIZE(axi_rst_map);
+		data->rsts_map = axi_rst_map;
+	} else if (of_device_is_compatible(data->np, "baikal,bt1-ccu-sys")) {
+		data->rsts_map_num = ARRAY_SIZE(sys_rst_map);
+		data->rsts_map = sys_rst_map;
+	} else {
+		pr_err("Incompatible DT node '%s' specified\n",
+			of_node_full_name(data->np));
+		ret = -EINVAL;
+		goto err_kfree_data;
+	}
+
+	data->rsts_num = data->rsts_map_num;
+	data->rsts = kcalloc(data->rsts_num, sizeof(*data->rsts), GFP_KERNEL);
+	if (!data->rsts) {
+		ret = -ENOMEM;
+		goto err_kfree_data;
+	}
+
+	return data;
+
+err_kfree_data:
+	kfree(data);
+
+	return ERR_PTR(ret);
+}
+
+static void ccu_rst_free_data(struct ccu_rst_data *data)
+{
+	kfree(data->rsts);
+
+	kfree(data);
+}
+
+static int ccu_rst_init_desc(struct ccu_rst_data *data)
+{
+	struct ccu_rst *rst = data->rsts;
+	unsigned int idx;
+
+	for (idx = 0; idx < data->rsts_map_num; ++idx, ++rst) {
+		const struct ccu_rst_map *map = &data->rsts_map[idx];
+
+		rst->id = map->rst_id;
+		rst->div = ccu_rst_find_div(data, map->clk_id);
+		if (IS_ERR(rst->div)) {
+			pr_err("Couldn't find clock divider '%u'\n", map->clk_id);
+			return PTR_ERR(rst->div);
+		}
+	}
+
+	return 0;
+}
+
+static int ccu_rst_dev_register(struct ccu_rst_data *data)
+{
+	int ret;
+
+	data->rcdev.ops = &ccu_rst_ops;
+	data->rcdev.of_node = data->np;
+	data->rcdev.nr_resets = data->rsts_num;
+	data->rcdev.of_reset_n_cells = 1;
+	data->rcdev.of_xlate = ccu_rst_of_idx_get;
+
+	ret = reset_controller_register(&data->rcdev);
+	if (ret) {
+		pr_err("Couldn't register '%s' reset controller\n",
+			of_node_full_name(data->np));
+	}
+
+	return ret;
+}
+
+static void ccu_rst_dev_unregister(struct ccu_rst_data *data)
+{
+	reset_controller_unregister(&data->rcdev);
+}
+
+struct ccu_rst_data *ccu_rst_hw_register(const struct ccu_rst_init_data *rst_init)
+{
+	struct ccu_rst_data *data;
+	int ret;
+
+	data = ccu_rst_create_data(rst_init);
+	if (IS_ERR(data))
+		return data;
+
+	ret = ccu_rst_init_desc(data);
+	if (ret)
+		goto err_free_data;
+
+	ret = ccu_rst_dev_register(data);
+	if (ret)
+		goto err_free_data;
+
+	return data;
+
+err_free_data:
+	ccu_rst_free_data(data);
+
+	return ERR_PTR(ret);
+}
+
+void ccu_rst_hw_unregister(struct ccu_rst_data *data)
+{
+	ccu_rst_dev_unregister(data);
+
+	ccu_rst_free_data(data);
+}
diff --git a/drivers/clk/baikal-t1/ccu-rst.h b/drivers/clk/baikal-t1/ccu-rst.h
new file mode 100644
index 000000000000..2ef82899dba8
--- /dev/null
+++ b/drivers/clk/baikal-t1/ccu-rst.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 BAIKAL ELECTRONICS, JSC
+ *
+ * Baikal-T1 CCU Resets interface driver
+ */
+#ifndef __CLK_BT1_CCU_RST_H__
+#define __CLK_BT1_CCU_RST_H__
+
+#include <linux/regmap.h>
+#include <linux/of.h>
+
+#include "ccu-div.h"
+
+struct ccu_rst_data;
+
+/*
+ * struct ccu_rst_init_data - CCU Resets initialization data
+ * @sys_regs: Baikal-T1 System Controller registers map.
+ * @np: Pointer to the node with the System CCU block.
+ * @divs_num: Number of the CCU dividers the module supports.
+ * @divs: Array of pointers to the CCU divider descriptors.
+ */
+struct ccu_rst_init_data {
+	struct regmap *sys_regs;
+	struct device_node *np;
+
+	unsigned int divs_num;
+	struct ccu_div **divs;
+};
+
+/*
+ * struct ccu_div - CCU Reset descriptor
+ * @id: Reset identifier.
+ * @div: Pointer to the CCU Divider descriptor (can be NULL).
+ */
+struct ccu_rst {
+	unsigned int id;
+	struct ccu_div *div;
+};
+
+#ifdef CONFIG_CLK_BT1_CCU_RST
+
+struct ccu_rst_data *ccu_rst_hw_register(const struct ccu_rst_init_data *init);
+
+void ccu_rst_hw_unregister(struct ccu_rst_data *rcd);
+
+#else
+
+static inline
+struct ccu_rst_data *ccu_rst_hw_register(const struct ccu_rst_init_data *init)
+{
+	return NULL;
+}
+
+static inline void ccu_rst_hw_unregister(struct ccu_rst_data *rcd) {}
+
+#endif
+
+#endif /* __CLK_BT1_CCU_RST_H__ */
diff --git a/drivers/clk/baikal-t1/clk-ccu-div.c b/drivers/clk/baikal-t1/clk-ccu-div.c
index e544129a7543..1ad7db7ea785 100644
--- a/drivers/clk/baikal-t1/clk-ccu-div.c
+++ b/drivers/clk/baikal-t1/clk-ccu-div.c
@@ -24,9 +24,9 @@
 #include <linux/regmap.h>
 
 #include <dt-bindings/clock/bt1-ccu.h>
-#include <dt-bindings/reset/bt1-ccu.h>
 
 #include "ccu-div.h"
+#include "ccu-rst.h"
 
 #define CCU_AXI_MAIN_BASE		0x030
 #define CCU_AXI_DDR_BASE		0x034
@@ -85,12 +85,6 @@
 		.divider = _divider				\
 	}
 
-#define CCU_DIV_RST_MAP(_rst_id, _clk_id)	\
-	{					\
-		.rst_id = _rst_id,		\
-		.clk_id = _clk_id		\
-	}
-
 struct ccu_div_info {
 	unsigned int id;
 	const char *name;
@@ -105,11 +99,6 @@ struct ccu_div_info {
 	unsigned long features;
 };
 
-struct ccu_div_rst_map {
-	unsigned int rst_id;
-	unsigned int clk_id;
-};
-
 struct ccu_div_data {
 	struct device_node *np;
 	struct regmap *sys_regs;
@@ -118,11 +107,8 @@ struct ccu_div_data {
 	const struct ccu_div_info *divs_info;
 	struct ccu_div **divs;
 
-	unsigned int rst_num;
-	const struct ccu_div_rst_map *rst_map;
-	struct reset_controller_dev rcdev;
+	struct ccu_rst_data *rcd;
 };
-#define to_ccu_div_data(_rcdev) container_of(_rcdev, struct ccu_div_data, rcdev)
 
 /*
  * AXI Main Interconnect (axi_main_clk) and DDR AXI-bus (axi_ddr_clk) clocks
@@ -169,20 +155,6 @@ static const struct ccu_div_info axi_info[] = {
 			 CLK_SET_RATE_GATE, CCU_DIV_RESET_DOMAIN)
 };
 
-static const struct ccu_div_rst_map axi_rst_map[] = {
-	CCU_DIV_RST_MAP(CCU_AXI_MAIN_RST, CCU_AXI_MAIN_CLK),
-	CCU_DIV_RST_MAP(CCU_AXI_DDR_RST, CCU_AXI_DDR_CLK),
-	CCU_DIV_RST_MAP(CCU_AXI_SATA_RST, CCU_AXI_SATA_CLK),
-	CCU_DIV_RST_MAP(CCU_AXI_GMAC0_RST, CCU_AXI_GMAC0_CLK),
-	CCU_DIV_RST_MAP(CCU_AXI_GMAC1_RST, CCU_AXI_GMAC1_CLK),
-	CCU_DIV_RST_MAP(CCU_AXI_XGMAC_RST, CCU_AXI_XGMAC_CLK),
-	CCU_DIV_RST_MAP(CCU_AXI_PCIE_M_RST, CCU_AXI_PCIE_M_CLK),
-	CCU_DIV_RST_MAP(CCU_AXI_PCIE_S_RST, CCU_AXI_PCIE_S_CLK),
-	CCU_DIV_RST_MAP(CCU_AXI_USB_RST, CCU_AXI_USB_CLK),
-	CCU_DIV_RST_MAP(CCU_AXI_HWA_RST, CCU_AXI_HWA_CLK),
-	CCU_DIV_RST_MAP(CCU_AXI_SRAM_RST, CCU_AXI_SRAM_CLK)
-};
-
 /*
  * APB-bus clock is marked as critical since it's a main communication bus
  * for the SoC devices registers IO-operations.
@@ -241,11 +213,6 @@ static const struct ccu_div_info sys_info[] = {
 			 CLK_SET_RATE_GATE, CCU_DIV_SKIP_ONE_TO_THREE)
 };
 
-static const struct ccu_div_rst_map sys_rst_map[] = {
-	CCU_DIV_RST_MAP(CCU_SYS_SATA_REF_RST, CCU_SYS_SATA_REF_CLK),
-	CCU_DIV_RST_MAP(CCU_SYS_APB_RST, CCU_SYS_APB_CLK),
-};
-
 static struct ccu_div *ccu_div_find_desc(struct ccu_div_data *data,
 					 unsigned int clk_id)
 {
@@ -261,42 +228,6 @@ static struct ccu_div *ccu_div_find_desc(struct ccu_div_data *data,
 	return ERR_PTR(-EINVAL);
 }
 
-static int ccu_div_reset(struct reset_controller_dev *rcdev,
-			 unsigned long rst_id)
-{
-	struct ccu_div_data *data = to_ccu_div_data(rcdev);
-	const struct ccu_div_rst_map *map;
-	struct ccu_div *div;
-	int idx, ret;
-
-	for (idx = 0, map = data->rst_map; idx < data->rst_num; ++idx, ++map) {
-		if (map->rst_id == rst_id)
-			break;
-	}
-	if (idx == data->rst_num) {
-		pr_err("Invalid reset ID %lu specified\n", rst_id);
-		return -EINVAL;
-	}
-
-	div = ccu_div_find_desc(data, map->clk_id);
-	if (IS_ERR(div)) {
-		pr_err("Invalid clock ID %d in mapping\n", map->clk_id);
-		return PTR_ERR(div);
-	}
-
-	ret = ccu_div_reset_domain(div);
-	if (ret) {
-		pr_err("Reset isn't supported by divider %s\n",
-			clk_hw_get_name(ccu_div_get_clk_hw(div)));
-	}
-
-	return ret;
-}
-
-static const struct reset_control_ops ccu_div_rst_ops = {
-	.reset = ccu_div_reset,
-};
-
 static struct ccu_div_data *ccu_div_create_data(struct device_node *np)
 {
 	struct ccu_div_data *data;
@@ -310,13 +241,9 @@ static struct ccu_div_data *ccu_div_create_data(struct device_node *np)
 	if (of_device_is_compatible(np, "baikal,bt1-ccu-axi")) {
 		data->divs_num = ARRAY_SIZE(axi_info);
 		data->divs_info = axi_info;
-		data->rst_num = ARRAY_SIZE(axi_rst_map);
-		data->rst_map = axi_rst_map;
 	} else if (of_device_is_compatible(np, "baikal,bt1-ccu-sys")) {
 		data->divs_num = ARRAY_SIZE(sys_info);
 		data->divs_info = sys_info;
-		data->rst_num = ARRAY_SIZE(sys_rst_map);
-		data->rst_map = sys_rst_map;
 	} else {
 		pr_err("Incompatible DT node '%s' specified\n",
 			of_node_full_name(np));
@@ -439,18 +366,21 @@ static void ccu_div_clk_unregister(struct ccu_div_data *data)
 
 static int ccu_div_rst_register(struct ccu_div_data *data)
 {
-	int ret;
+	struct ccu_rst_init_data init = {0};
 
-	data->rcdev.ops = &ccu_div_rst_ops;
-	data->rcdev.of_node = data->np;
-	data->rcdev.nr_resets = data->rst_num;
+	init.sys_regs = data->sys_regs;
+	init.np = data->np;
+	init.divs_num = data->divs_num;
+	init.divs = data->divs;
 
-	ret = reset_controller_register(&data->rcdev);
-	if (ret)
+	data->rcd = ccu_rst_hw_register(&init);
+	if (IS_ERR(data->rcd)) {
 		pr_err("Couldn't register divider '%s' reset controller\n",
 			of_node_full_name(data->np));
+		return PTR_ERR(data->rcd);
+	}
 
-	return ret;
+	return 0;
 }
 
 static void ccu_div_init(struct device_node *np)
-- 
2.35.1

