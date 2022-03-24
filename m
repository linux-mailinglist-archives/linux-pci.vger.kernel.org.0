Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB924E9BD7
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 18:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240932AbiC1QFw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 12:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239807AbiC1QFv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 12:05:51 -0400
X-Greylist: delayed 4200 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Mar 2022 09:04:09 PDT
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24D011A3B7;
        Mon, 28 Mar 2022 09:04:08 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 9FBFB1E28FC;
        Thu, 24 Mar 2022 04:09:18 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 9FBFB1E28FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1648084158;
        bh=KwgRwEaLuj9S7bcXvNqk9nfNR+7FKV+wml4/e4DFTxo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ROn3Fxd7SVgCbaeh6EHEBzZUnw8DuOGGUcegQOYTAYZvEY3BVkS5M2U6zepKglqWd
         9myfruuGLx7AYQj3Md1hvAY+74MZ5LG+KS8U3q2ruZyBLKiM28d7A7kbhUjHjFiwob
         UwTBGx9Z1V4Mv7PW31AlvsxHa513RByGtX9NprIM=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Mar 2022 04:09:18 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        <linux-clk@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 4/4] clk: baikal-t1: Add DDR/PCIe directly controlled resets support
Date:   Thu, 24 Mar 2022 04:09:05 +0300
Message-ID: <20220324010905.15589-5-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220324010905.15589-1-Sergey.Semin@baikalelectronics.ru>
References: <20220324010905.15589-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Aside with a set of the trigger-like resets Baikal-T1 CCU provides two
additional blocks with directly controlled reset signals. In particular it
concerns DDR full and initial resets and various PCIe sub-domains resets.
Let's add the direct reset assertion/de-assertion of the corresponding
flags support into the Baikal-T1 CCU driver then. It will be required at
least for the PCIe platform driver. Obviously the DDR controller isn't
supposed to be fully reset in the kernel, so the corresponding controls
are added just for the sake of the interface implementation completeness.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/clk/baikal-t1/ccu-rst.c     | 117 +++++++++++++++++++++++++++-
 drivers/clk/baikal-t1/ccu-rst.h     |   4 +
 include/dt-bindings/reset/bt1-ccu.h |   9 +++
 3 files changed, 129 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/baikal-t1/ccu-rst.c b/drivers/clk/baikal-t1/ccu-rst.c
index 5e33c3ce962a..186a1491a7d9 100644
--- a/drivers/clk/baikal-t1/ccu-rst.c
+++ b/drivers/clk/baikal-t1/ccu-rst.c
@@ -25,17 +25,33 @@
 #include "ccu-div.h"
 #include "ccu-rst.h"
 
+#define CCU_SYS_DDR_BASE		0x02c
+#define CCU_SYS_PCIE_BASE		0x144
+
 #define CCU_RST_MAP(_rst_id, _clk_id)		\
 	{					\
 		.rst_id = _rst_id,		\
 		.clk_id = _clk_id,		\
 	}
 
+#define CCU_RST_DIR(_rst_id, _base, _ofs)	\
+	{					\
+		.rst_id = _rst_id,		\
+		.base = _base,			\
+		.ofs = _ofs			\
+	}
+
 struct ccu_rst_map {
 	unsigned int rst_id;
 	unsigned int clk_id;
 };
 
+struct ccu_rst_dir {
+	unsigned int rst_id;
+	unsigned int base;
+	unsigned int ofs;
+};
+
 struct ccu_rst_data {
 	struct device_node *np;
 	struct regmap *sys_regs;
@@ -46,6 +62,9 @@ struct ccu_rst_data {
 	unsigned int rsts_map_num;
 	const struct ccu_rst_map *rsts_map;
 
+	unsigned int rsts_dir_num;
+	const struct ccu_rst_dir *rsts_dir;
+
 	unsigned int divs_num;
 	struct ccu_div **divs;
 
@@ -81,6 +100,23 @@ static const struct ccu_rst_map sys_rst_map[] = {
 	CCU_RST_MAP(CCU_SYS_APB_RST, CCU_SYS_APB_CLK),
 };
 
+/*
+ * DDR and PCIe sub-domains can be reset with directly controlled reset
+ * signals. I wouldn't suggest to reset the DDR controller though at least
+ * while the Linux kernel is working.
+ */
+static const struct ccu_rst_dir sys_rst_dir[] = {
+	CCU_RST_DIR(CCU_SYS_DDR_FULL_RST, CCU_SYS_DDR_BASE, 1),
+	CCU_RST_DIR(CCU_SYS_DDR_INIT_RST, CCU_SYS_DDR_BASE, 2),
+	CCU_RST_DIR(CCU_SYS_PCIE_PCS_PHY_RST, CCU_SYS_PCIE_BASE, 0),
+	CCU_RST_DIR(CCU_SYS_PCIE_PIPE0_RST, CCU_SYS_PCIE_BASE, 4),
+	CCU_RST_DIR(CCU_SYS_PCIE_CORE_RST, CCU_SYS_PCIE_BASE, 8),
+	CCU_RST_DIR(CCU_SYS_PCIE_PWR_RST, CCU_SYS_PCIE_BASE, 9),
+	CCU_RST_DIR(CCU_SYS_PCIE_STICKY_RST, CCU_SYS_PCIE_BASE, 10),
+	CCU_RST_DIR(CCU_SYS_PCIE_NSTICKY_RST, CCU_SYS_PCIE_BASE, 11),
+	CCU_RST_DIR(CCU_SYS_PCIE_HOT_RST, CCU_SYS_PCIE_BASE, 12),
+};
+
 static int ccu_rst_reset(struct reset_controller_dev *rcdev,
 			 unsigned long idx)
 {
@@ -92,12 +128,81 @@ static int ccu_rst_reset(struct reset_controller_dev *rcdev,
 		return -EINVAL;
 	}
 
+	/*
+	 * No CCU divider descriptor means having directly handled reset control,
+	 * which is mapped into the CCU Divider registers.
+	 */
 	rst = &data->rsts[idx];
+	if (!rst->div)
+		return -EOPNOTSUPP;
+
 	return ccu_div_reset_domain(rst->div);
 }
 
+static int ccu_rst_set(struct ccu_rst_data *data,
+		       unsigned long idx, bool high)
+{
+	struct ccu_rst *rst;
+
+	if (idx >= data->rsts_num) {
+		pr_err("Invalid reset ID %lu specified\n", idx);
+		return -EINVAL;
+	}
+
+	/*
+	 * Having CCU divider descriptor means trigger-like reset control so
+	 * direct assertion/de-assertion is unsupported.
+	 */
+	rst = &data->rsts[idx];
+	if (rst->div)
+		return high ? -EOPNOTSUPP : 0;
+
+	return regmap_update_bits(data->sys_regs, rst->reg_ctl,
+				  rst->mask, high ? rst->mask : 0);
+}
+
+static int ccu_rst_assert(struct reset_controller_dev *rcdev,
+			  unsigned long idx)
+{
+	struct ccu_rst_data *data = to_ccu_rst_data(rcdev);
+
+	return ccu_rst_set(data, idx, true);
+}
+
+static int ccu_rst_deassert(struct reset_controller_dev *rcdev,
+			    unsigned long idx)
+{
+	struct ccu_rst_data *data = to_ccu_rst_data(rcdev);
+
+	return ccu_rst_set(data, idx, false);
+}
+
+static int ccu_rst_status(struct reset_controller_dev *rcdev,
+			  unsigned long idx)
+{
+	struct ccu_rst_data *data = to_ccu_rst_data(rcdev);
+	struct ccu_rst *rst;
+	u32 val;
+
+	if (idx >= data->rsts_num) {
+		pr_err("Invalid reset ID %lu specified\n", idx);
+		return -EINVAL;
+	}
+
+	rst = &data->rsts[idx];
+	if (rst->div)
+		return -EOPNOTSUPP;
+
+	regmap_read(data->sys_regs, rst->reg_ctl, &val);
+
+	return !!(val & rst->mask);
+}
+
 static const struct reset_control_ops ccu_rst_ops = {
 	.reset = ccu_rst_reset,
+	.assert = ccu_rst_assert,
+	.deassert = ccu_rst_deassert,
+	.status = ccu_rst_status,
 };
 
 static int ccu_rst_of_idx_get(struct reset_controller_dev *rcdev,
@@ -153,6 +258,8 @@ static struct ccu_rst_data *ccu_rst_create_data(const struct ccu_rst_init_data *
 	} else if (of_device_is_compatible(data->np, "baikal,bt1-ccu-sys")) {
 		data->rsts_map_num = ARRAY_SIZE(sys_rst_map);
 		data->rsts_map = sys_rst_map;
+		data->rsts_dir_num = ARRAY_SIZE(sys_rst_dir);
+		data->rsts_dir = sys_rst_dir;
 	} else {
 		pr_err("Incompatible DT node '%s' specified\n",
 			of_node_full_name(data->np));
@@ -160,7 +267,7 @@ static struct ccu_rst_data *ccu_rst_create_data(const struct ccu_rst_init_data *
 		goto err_kfree_data;
 	}
 
-	data->rsts_num = data->rsts_map_num;
+	data->rsts_num = data->rsts_map_num + data->rsts_dir_num;
 	data->rsts = kcalloc(data->rsts_num, sizeof(*data->rsts), GFP_KERNEL);
 	if (!data->rsts) {
 		ret = -ENOMEM;
@@ -198,6 +305,14 @@ static int ccu_rst_init_desc(struct ccu_rst_data *data)
 		}
 	}
 
+	for (idx = 0; idx < data->rsts_dir_num; ++idx, ++rst) {
+		const struct ccu_rst_dir *dir = &data->rsts_dir[idx];
+
+		rst->id = dir->rst_id;
+		rst->reg_ctl = dir->base;
+		rst->mask = BIT(dir->ofs);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/clk/baikal-t1/ccu-rst.h b/drivers/clk/baikal-t1/ccu-rst.h
index 2ef82899dba8..58347dc8a504 100644
--- a/drivers/clk/baikal-t1/ccu-rst.h
+++ b/drivers/clk/baikal-t1/ccu-rst.h
@@ -33,10 +33,14 @@ struct ccu_rst_init_data {
  * struct ccu_div - CCU Reset descriptor
  * @id: Reset identifier.
  * @div: Pointer to the CCU Divider descriptor (can be NULL).
+ * @reg_ctl: reset control register base address.
+ * @mask: reset flag within the control register.
  */
 struct ccu_rst {
 	unsigned int id;
 	struct ccu_div *div;
+	unsigned int reg_ctl;
+	unsigned int mask;
 };
 
 #ifdef CONFIG_CLK_BT1_CCU_RST
diff --git a/include/dt-bindings/reset/bt1-ccu.h b/include/dt-bindings/reset/bt1-ccu.h
index 3578e83026bc..c691efaa678f 100644
--- a/include/dt-bindings/reset/bt1-ccu.h
+++ b/include/dt-bindings/reset/bt1-ccu.h
@@ -21,5 +21,14 @@
 
 #define CCU_SYS_SATA_REF_RST		0
 #define CCU_SYS_APB_RST			1
+#define CCU_SYS_DDR_FULL_RST		2
+#define CCU_SYS_DDR_INIT_RST		3
+#define CCU_SYS_PCIE_PCS_PHY_RST	4
+#define CCU_SYS_PCIE_PIPE0_RST		5
+#define CCU_SYS_PCIE_CORE_RST		6
+#define CCU_SYS_PCIE_PWR_RST		7
+#define CCU_SYS_PCIE_STICKY_RST		8
+#define CCU_SYS_PCIE_NSTICKY_RST	9
+#define CCU_SYS_PCIE_HOT_RST		10
 
 #endif /* __DT_BINDINGS_RESET_BT1_CCU_H */
-- 
2.35.1

