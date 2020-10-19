Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626062924EC
	for <lists+linux-pci@lfdr.de>; Mon, 19 Oct 2020 11:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgJSJsQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Oct 2020 05:48:16 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36230 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbgJSJsP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Oct 2020 05:48:15 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201019094741euoutp023536b0006bebf75e6f8d1844cd86c248~-W718FwKH2545825458euoutp02v
        for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2020 09:47:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201019094741euoutp023536b0006bebf75e6f8d1844cd86c248~-W718FwKH2545825458euoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603100861;
        bh=KvetAm9D9N/0AjGJp7HUMwZgeyIF9EG/FgB3Ic8daw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BC64fhfqnhMADR6broAVgXxlnafB4eVuECin0SHmndCgSLzgHqHCwpBjWoewkUFkN
         inRRwEqRjKdd6OBBZdIqwBauyljuR3hvbTUDwLFzrhTFvAzQie1iT60fbJO4+GWr28
         CHNNgqyDmdXqeRnd2JjyVTfWbhmrXtr8nIaq4qQw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201019094741eucas1p1d31ec4b28501eafec620a251fd927ea3~-W71aj8Dz0917509175eucas1p1j;
        Mon, 19 Oct 2020 09:47:41 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A2.19.06456.CB06D8F5; Mon, 19
        Oct 2020 10:47:40 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201019094740eucas1p2cd873b29bc19708f9a712d955cba62fe~-W70-QLIt0999409994eucas1p2l;
        Mon, 19 Oct 2020 09:47:40 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201019094740eusmtrp233311742ae5ce352bd9490f47a7e5797~-W70_catQ2609626096eusmtrp2R;
        Mon, 19 Oct 2020 09:47:40 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-37-5f8d60bc6549
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id DF.CB.06017.CB06D8F5; Mon, 19
        Oct 2020 10:47:40 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201019094740eusmtip18904e69583c586ad8bdeb9807773111b~-W70ZMNv71600016000eusmtip1R;
        Mon, 19 Oct 2020 09:47:40 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 5/6] pci: dwc: pci-exynos: rework the driver to support
 Exynos5433 variant
Date:   Mon, 19 Oct 2020 11:47:14 +0200
Message-Id: <20201019094715.15343-6-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201019094715.15343-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsWy7djP87p7EnrjDfZPtbFY0pRhMf/IOVaL
        G7/aWC1WfJnJbnHhaQ+bxfnzG9gtLu+aw2Zxdt5xNosZ5/cxWbz5/YLdYu2Ru+wWrXuPsFvs
        vHOC2YHXY828NYweO2fdZfdYsKnUY9OqTjaPvi2rGD2O39jO5PF5k1wAexSXTUpqTmZZapG+
        XQJXxt0fP1gL7s9jrOiac4GlgbGrlbGLkZNDQsBEYtHMa8xdjFwcQgIrGCU+z++Fcr4wSjzs
        uA3lfGaUaJ6wkgWmZeWlbUwQieWMEn0nHjLBtVzo3sIEUsUmYCjR9baLrYuRg0NEwEHix1cL
        kBpmgUXMEg39R8CWCwvESCx8fIcJpIZFQFVicVcwSJhXwFbi7tpOZohl8hKrNxwAszkF7CS6
        Fi4Du0hCYBW7RMfXy1BPuEjsurmbCcIWlnh1fAs7hC0j8X/nfCaIhmagf86tZYdwehglLjfN
        gOq2lrhz7hfYpcwCmhLrd+lDhB0lnvefYgEJSwjwSdx4KwgSZgYyJ22bzgwR5pXoaBOCqFaT
        mHV8HdzagxcuQd3vIfHz3mN2SPhMZJS49HU28wRG+VkIyxYwMq5iFE8tLc5NTy02zEst1ytO
        zC0uzUvXS87P3cQITDun/x3/tIPx66WkQ4wCHIxKPLwP8nvihVgTy4orcw8xSnAwK4nwOp09
        HSfEm5JYWZValB9fVJqTWnyIUZqDRUmc13jRy1ghgfTEktTs1NSC1CKYLBMHp1QDo8LrPEur
        yx8W9jiUPFZr/PNwZoRT8TsLBeGca1eMIqf4v98RuLL4+F3VnrodKuXm3Ws3rne/9lzfvCnX
        62RVdcjmP5ndD+86VlifzzVf9GXypF9nyra932FS0xPTeUGscN1znuKzCq0M7loFyQt+XTIt
        OxaYXKl1Q33vnI1VBz9rcDtofBZ7pcRSnJFoqMVcVJwIAIHoc283AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42I5/e/4Xd09Cb3xBpt3aFosacqwmH/kHKvF
        jV9trBYrvsxkt7jwtIfN4vz5DewWl3fNYbM4O+84m8WM8/uYLN78fsFusfbIXXaL1r1H2C12
        3jnB7MDrsWbeGkaPnbPusnss2FTqsWlVJ5tH35ZVjB7Hb2xn8vi8SS6APUrPpii/tCRVISO/
        uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEv4+6PH6wF9+cxVnTNucDS
        wNjVytjFyMkhIWAisfLSNqYuRi4OIYGljBLL5jQxQyRkJE5Oa2CFsIUl/lzrYoMo+sQocWRj
        OxNIgk3AUKLrLUiCk0NEwEni/eSLzCBFzAJrmCUa27rBioQFoiT+/VwFtI6Dg0VAVWJxVzBI
        mFfAVuLu2k6oZfISqzccALM5BewkuhYuA7OFgGq6Vk5jmcDIt4CRYRWjSGppcW56brGRXnFi
        bnFpXrpecn7uJkZgFGw79nPLDsaud8GHGAU4GJV4eB/k98QLsSaWFVfmHmKU4GBWEuF1Ons6
        Tog3JbGyKrUoP76oNCe1+BCjKdBNE5mlRJPzgRGaVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZI
        ID2xJDU7NbUgtQimj4mDU6qBsSTKIb+wPyJyi8UPvoeXZyklh752so7SSJHju/DE9+RZ5k+R
        eXfi9kkv+PEybWvZIYnJ09ZVz/eyq7d4l360WGdaYkQI0xm7mX83SkTsvia1ud3k/i/j/8bW
        EhG/c9+VciRo9N08IOIQc/OM2q+itdLJL59FlmQ+ETs53VPqksmWFcs3ftjwQomlOCPRUIu5
        qDgRAJ3c8XWYAgAA
X-CMS-MailID: 20201019094740eucas1p2cd873b29bc19708f9a712d955cba62fe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201019094740eucas1p2cd873b29bc19708f9a712d955cba62fe
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201019094740eucas1p2cd873b29bc19708f9a712d955cba62fe
References: <20201019094715.15343-1-m.szyprowski@samsung.com>
        <CGME20201019094740eucas1p2cd873b29bc19708f9a712d955cba62fe@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jaehoon Chung <jh80.chung@samsung.com>

Exynos5440 SoC support has been dropped since commit 8c83315da1cf ("ARM:
dts: exynos: Remove Exynos5440"). Rework this driver to support DWC PCIe
variant found in the Exynos5433 SoCs.

The main difference in Exynos5433 variant is lack of the MSI support
(the MSI interrupt is not even routed to the CPU).

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
[mszyprow: reworked the driver to support only Exynos5433 variant,
	   simplified code, rebased onto current kernel code, added
	   regulator support, converted to the regular platform driver,
	   removed MSI related code, rewrote commit message]
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/pci/controller/dwc/Kconfig      |   3 +-
 drivers/pci/controller/dwc/pci-exynos.c | 358 ++++++++++--------------
 drivers/pci/quirks.c                    |   1 +
 3 files changed, 145 insertions(+), 217 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index bc049865f8e0..ade07abd23c9 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -84,8 +84,7 @@ config PCIE_DW_PLAT_EP
 
 config PCI_EXYNOS
 	bool "Samsung Exynos PCIe controller"
-	depends on SOC_EXYNOS5440 || COMPILE_TEST
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on ARCH_EXYNOS || COMPILE_TEST
 	select PCIE_DW_HOST
 
 config PCI_IMX6
diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index 242683cde04a..58056fbdc2fa 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -2,26 +2,23 @@
 /*
  * PCIe host controller driver for Samsung Exynos SoCs
  *
- * Copyright (C) 2013 Samsung Electronics Co., Ltd.
+ * Copyright (C) 2013-2020 Samsung Electronics Co., Ltd.
  *		https://www.samsung.com
  *
  * Author: Jingoo Han <jg1.han@samsung.com>
+ *	   Jaehoon Chung <jh80.chung@samsung.com>
  */
 
 #include <linux/clk.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/phy/phy.h>
-#include <linux/resource.h>
-#include <linux/signal.h>
-#include <linux/types.h>
+#include <linux/regulator/consumer.h>
 
 #include "pcie-designware.h"
 
@@ -37,102 +34,47 @@
 #define PCIE_IRQ_SPECIAL		0x008
 #define PCIE_IRQ_EN_PULSE		0x00c
 #define PCIE_IRQ_EN_LEVEL		0x010
-#define IRQ_MSI_ENABLE			BIT(2)
 #define PCIE_IRQ_EN_SPECIAL		0x014
-#define PCIE_PWR_RESET			0x018
+#define PCIE_SW_WAKE			0x018
+#define PCIE_BUS_EN			BIT(1)
 #define PCIE_CORE_RESET			0x01c
 #define PCIE_CORE_RESET_ENABLE		BIT(0)
 #define PCIE_STICKY_RESET		0x020
 #define PCIE_NONSTICKY_RESET		0x024
 #define PCIE_APP_INIT_RESET		0x028
 #define PCIE_APP_LTSSM_ENABLE		0x02c
-#define PCIE_ELBI_RDLH_LINKUP		0x064
+#define PCIE_ELBI_RDLH_LINKUP		0x074
+#define PCIE_ELBI_XMLH_LINKUP		BIT(4)
 #define PCIE_ELBI_LTSSM_ENABLE		0x1
 #define PCIE_ELBI_SLV_AWMISC		0x11c
 #define PCIE_ELBI_SLV_ARMISC		0x120
 #define PCIE_ELBI_SLV_DBI_ENABLE	BIT(21)
 
-struct exynos_pcie_mem_res {
-	void __iomem *elbi_base;   /* DT 0th resource: PCIe CTRL */
-};
-
-struct exynos_pcie_clk_res {
-	struct clk *clk;
-	struct clk *bus_clk;
-};
+/* DBI register */
+#define PCIE_MISC_CONTROL_1_OFF		0x8BC
+#define DBI_RO_WR_EN			BIT(0)
 
 struct exynos_pcie {
-	struct dw_pcie			*pci;
-	struct exynos_pcie_mem_res	*mem_res;
-	struct exynos_pcie_clk_res	*clk_res;
-	const struct exynos_pcie_ops	*ops;
-	int				reset_gpio;
-
+	struct dw_pcie			pci;
+	void __iomem			*elbi_base;
+	struct clk			*clk;
+	struct clk			*bus_clk;
 	struct phy			*phy;
+	struct regulator_bulk_data	supplies[2];
 };
 
-struct exynos_pcie_ops {
-	int (*get_mem_resources)(struct platform_device *pdev,
-			struct exynos_pcie *ep);
-	int (*get_clk_resources)(struct exynos_pcie *ep);
-	int (*init_clk_resources)(struct exynos_pcie *ep);
-	void (*deinit_clk_resources)(struct exynos_pcie *ep);
-};
-
-static int exynos5440_pcie_get_mem_resources(struct platform_device *pdev,
-					     struct exynos_pcie *ep)
-{
-	struct dw_pcie *pci = ep->pci;
-	struct device *dev = pci->dev;
-
-	ep->mem_res = devm_kzalloc(dev, sizeof(*ep->mem_res), GFP_KERNEL);
-	if (!ep->mem_res)
-		return -ENOMEM;
-
-	ep->mem_res->elbi_base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(ep->mem_res->elbi_base))
-		return PTR_ERR(ep->mem_res->elbi_base);
-
-	return 0;
-}
-
-static int exynos5440_pcie_get_clk_resources(struct exynos_pcie *ep)
-{
-	struct dw_pcie *pci = ep->pci;
-	struct device *dev = pci->dev;
-
-	ep->clk_res = devm_kzalloc(dev, sizeof(*ep->clk_res), GFP_KERNEL);
-	if (!ep->clk_res)
-		return -ENOMEM;
-
-	ep->clk_res->clk = devm_clk_get(dev, "pcie");
-	if (IS_ERR(ep->clk_res->clk)) {
-		dev_err(dev, "Failed to get pcie rc clock\n");
-		return PTR_ERR(ep->clk_res->clk);
-	}
-
-	ep->clk_res->bus_clk = devm_clk_get(dev, "pcie_bus");
-	if (IS_ERR(ep->clk_res->bus_clk)) {
-		dev_err(dev, "Failed to get pcie bus clock\n");
-		return PTR_ERR(ep->clk_res->bus_clk);
-	}
-
-	return 0;
-}
-
-static int exynos5440_pcie_init_clk_resources(struct exynos_pcie *ep)
+static int exynos_pcie_init_clk_resources(struct exynos_pcie *ep)
 {
-	struct dw_pcie *pci = ep->pci;
-	struct device *dev = pci->dev;
+	struct device *dev = ep->pci.dev;
 	int ret;
 
-	ret = clk_prepare_enable(ep->clk_res->clk);
+	ret = clk_prepare_enable(ep->clk);
 	if (ret) {
 		dev_err(dev, "cannot enable pcie rc clock");
 		return ret;
 	}
 
-	ret = clk_prepare_enable(ep->clk_res->bus_clk);
+	ret = clk_prepare_enable(ep->bus_clk);
 	if (ret) {
 		dev_err(dev, "cannot enable pcie bus clock");
 		goto err_bus_clk;
@@ -141,24 +83,17 @@ static int exynos5440_pcie_init_clk_resources(struct exynos_pcie *ep)
 	return 0;
 
 err_bus_clk:
-	clk_disable_unprepare(ep->clk_res->clk);
+	clk_disable_unprepare(ep->clk);
 
 	return ret;
 }
 
-static void exynos5440_pcie_deinit_clk_resources(struct exynos_pcie *ep)
+static void exynos_pcie_deinit_clk_resources(struct exynos_pcie *ep)
 {
-	clk_disable_unprepare(ep->clk_res->bus_clk);
-	clk_disable_unprepare(ep->clk_res->clk);
+	clk_disable_unprepare(ep->bus_clk);
+	clk_disable_unprepare(ep->clk);
 }
 
-static const struct exynos_pcie_ops exynos5440_pcie_ops = {
-	.get_mem_resources	= exynos5440_pcie_get_mem_resources,
-	.get_clk_resources	= exynos5440_pcie_get_clk_resources,
-	.init_clk_resources	= exynos5440_pcie_init_clk_resources,
-	.deinit_clk_resources	= exynos5440_pcie_deinit_clk_resources,
-};
-
 static void exynos_pcie_writel(void __iomem *base, u32 val, u32 reg)
 {
 	writel(val, base + reg);
@@ -173,67 +108,57 @@ static void exynos_pcie_sideband_dbi_w_mode(struct exynos_pcie *ep, bool on)
 {
 	u32 val;
 
-	val = exynos_pcie_readl(ep->mem_res->elbi_base, PCIE_ELBI_SLV_AWMISC);
+	val = exynos_pcie_readl(ep->elbi_base, PCIE_ELBI_SLV_AWMISC);
 	if (on)
 		val |= PCIE_ELBI_SLV_DBI_ENABLE;
 	else
 		val &= ~PCIE_ELBI_SLV_DBI_ENABLE;
-	exynos_pcie_writel(ep->mem_res->elbi_base, val, PCIE_ELBI_SLV_AWMISC);
+	exynos_pcie_writel(ep->elbi_base, val, PCIE_ELBI_SLV_AWMISC);
 }
 
 static void exynos_pcie_sideband_dbi_r_mode(struct exynos_pcie *ep, bool on)
 {
 	u32 val;
 
-	val = exynos_pcie_readl(ep->mem_res->elbi_base, PCIE_ELBI_SLV_ARMISC);
+	val = exynos_pcie_readl(ep->elbi_base, PCIE_ELBI_SLV_ARMISC);
 	if (on)
 		val |= PCIE_ELBI_SLV_DBI_ENABLE;
 	else
 		val &= ~PCIE_ELBI_SLV_DBI_ENABLE;
-	exynos_pcie_writel(ep->mem_res->elbi_base, val, PCIE_ELBI_SLV_ARMISC);
+	exynos_pcie_writel(ep->elbi_base, val, PCIE_ELBI_SLV_ARMISC);
 }
 
 static void exynos_pcie_assert_core_reset(struct exynos_pcie *ep)
 {
 	u32 val;
 
-	val = exynos_pcie_readl(ep->mem_res->elbi_base, PCIE_CORE_RESET);
+	val = exynos_pcie_readl(ep->elbi_base, PCIE_CORE_RESET);
 	val &= ~PCIE_CORE_RESET_ENABLE;
-	exynos_pcie_writel(ep->mem_res->elbi_base, val, PCIE_CORE_RESET);
-	exynos_pcie_writel(ep->mem_res->elbi_base, 0, PCIE_PWR_RESET);
-	exynos_pcie_writel(ep->mem_res->elbi_base, 0, PCIE_STICKY_RESET);
-	exynos_pcie_writel(ep->mem_res->elbi_base, 0, PCIE_NONSTICKY_RESET);
+	exynos_pcie_writel(ep->elbi_base, val, PCIE_CORE_RESET);
+	exynos_pcie_writel(ep->elbi_base, 0, PCIE_STICKY_RESET);
+	exynos_pcie_writel(ep->elbi_base, 0, PCIE_NONSTICKY_RESET);
 }
 
 static void exynos_pcie_deassert_core_reset(struct exynos_pcie *ep)
 {
 	u32 val;
 
-	val = exynos_pcie_readl(ep->mem_res->elbi_base, PCIE_CORE_RESET);
+	val = exynos_pcie_readl(ep->elbi_base, PCIE_CORE_RESET);
 	val |= PCIE_CORE_RESET_ENABLE;
 
-	exynos_pcie_writel(ep->mem_res->elbi_base, val, PCIE_CORE_RESET);
-	exynos_pcie_writel(ep->mem_res->elbi_base, 1, PCIE_STICKY_RESET);
-	exynos_pcie_writel(ep->mem_res->elbi_base, 1, PCIE_NONSTICKY_RESET);
-	exynos_pcie_writel(ep->mem_res->elbi_base, 1, PCIE_APP_INIT_RESET);
-	exynos_pcie_writel(ep->mem_res->elbi_base, 0, PCIE_APP_INIT_RESET);
-}
-
-static void exynos_pcie_assert_reset(struct exynos_pcie *ep)
-{
-	struct dw_pcie *pci = ep->pci;
-	struct device *dev = pci->dev;
-
-	if (ep->reset_gpio >= 0)
-		devm_gpio_request_one(dev, ep->reset_gpio,
-				GPIOF_OUT_INIT_HIGH, "RESET");
+	exynos_pcie_writel(ep->elbi_base, val, PCIE_CORE_RESET);
+	exynos_pcie_writel(ep->elbi_base, 1, PCIE_STICKY_RESET);
+	exynos_pcie_writel(ep->elbi_base, 1, PCIE_NONSTICKY_RESET);
+	exynos_pcie_writel(ep->elbi_base, 1, PCIE_APP_INIT_RESET);
+	exynos_pcie_writel(ep->elbi_base, 0, PCIE_APP_INIT_RESET);
 }
 
 static int exynos_pcie_establish_link(struct exynos_pcie *ep)
 {
-	struct dw_pcie *pci = ep->pci;
+	struct dw_pcie *pci = &ep->pci;
 	struct pcie_port *pp = &pci->pp;
 	struct device *dev = pci->dev;
+	u32 val;
 
 	if (dw_pcie_link_up(pci)) {
 		dev_err(dev, "Link already up\n");
@@ -243,19 +168,25 @@ static int exynos_pcie_establish_link(struct exynos_pcie *ep)
 	exynos_pcie_assert_core_reset(ep);
 
 	phy_reset(ep->phy);
-
-	exynos_pcie_writel(ep->mem_res->elbi_base, 1,
-			PCIE_PWR_RESET);
-
 	phy_power_on(ep->phy);
 	phy_init(ep->phy);
 
 	exynos_pcie_deassert_core_reset(ep);
+
+	val = exynos_pcie_readl(ep->elbi_base, PCIE_SW_WAKE);
+	val &= ~PCIE_BUS_EN;
+	exynos_pcie_writel(ep->elbi_base, val, PCIE_SW_WAKE);
+
+	/*
+	 * Enable DBI_RO_WR_EN bit.
+	 * - When set to 1, some RO and HWinit bits are wriatble from
+	 *   the local application through the DBI.
+	 */
+	dw_pcie_writel_dbi(pci, PCIE_MISC_CONTROL_1_OFF, DBI_RO_WR_EN);
 	dw_pcie_setup_rc(pp);
-	exynos_pcie_assert_reset(ep);
 
 	/* assert LTSSM enable */
-	exynos_pcie_writel(ep->mem_res->elbi_base, PCIE_ELBI_LTSSM_ENABLE,
+	exynos_pcie_writel(ep->elbi_base, PCIE_ELBI_LTSSM_ENABLE,
 			  PCIE_APP_LTSSM_ENABLE);
 
 	/* check if the link is up or not */
@@ -270,18 +201,8 @@ static void exynos_pcie_clear_irq_pulse(struct exynos_pcie *ep)
 {
 	u32 val;
 
-	val = exynos_pcie_readl(ep->mem_res->elbi_base, PCIE_IRQ_PULSE);
-	exynos_pcie_writel(ep->mem_res->elbi_base, val, PCIE_IRQ_PULSE);
-}
-
-static void exynos_pcie_enable_irq_pulse(struct exynos_pcie *ep)
-{
-	u32 val;
-
-	/* enable INTX interrupt */
-	val = IRQ_INTA_ASSERT | IRQ_INTB_ASSERT |
-		IRQ_INTC_ASSERT | IRQ_INTD_ASSERT;
-	exynos_pcie_writel(ep->mem_res->elbi_base, val, PCIE_IRQ_EN_PULSE);
+	val = exynos_pcie_readl(ep->elbi_base, PCIE_IRQ_PULSE);
+	exynos_pcie_writel(ep->elbi_base, val, PCIE_IRQ_PULSE);
 }
 
 static irqreturn_t exynos_pcie_irq_handler(int irq, void *arg)
@@ -292,26 +213,14 @@ static irqreturn_t exynos_pcie_irq_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-static void exynos_pcie_msi_init(struct exynos_pcie *ep)
-{
-	struct dw_pcie *pci = ep->pci;
-	struct pcie_port *pp = &pci->pp;
-	u32 val;
-
-	dw_pcie_msi_init(pp);
-
-	/* enable MSI interrupt */
-	val = exynos_pcie_readl(ep->mem_res->elbi_base, PCIE_IRQ_EN_LEVEL);
-	val |= IRQ_MSI_ENABLE;
-	exynos_pcie_writel(ep->mem_res->elbi_base, val, PCIE_IRQ_EN_LEVEL);
-}
-
-static void exynos_pcie_enable_interrupts(struct exynos_pcie *ep)
+static void exynos_pcie_enable_irq_pulse(struct exynos_pcie *ep)
 {
-	exynos_pcie_enable_irq_pulse(ep);
+	u32 val = IRQ_INTA_ASSERT | IRQ_INTB_ASSERT |
+		  IRQ_INTC_ASSERT | IRQ_INTD_ASSERT;
 
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		exynos_pcie_msi_init(ep);
+	exynos_pcie_writel(ep->elbi_base, val, PCIE_IRQ_EN_PULSE);
+	exynos_pcie_writel(ep->elbi_base, 0, PCIE_IRQ_EN_LEVEL);
+	exynos_pcie_writel(ep->elbi_base, 0, PCIE_IRQ_EN_SPECIAL);
 }
 
 static u32 exynos_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
@@ -372,11 +281,8 @@ static int exynos_pcie_link_up(struct dw_pcie *pci)
 	struct exynos_pcie *ep = to_exynos_pcie(pci);
 	u32 val;
 
-	val = exynos_pcie_readl(ep->mem_res->elbi_base, PCIE_ELBI_RDLH_LINKUP);
-	if (val == PCIE_ELBI_LTSSM_ENABLE)
-		return 1;
-
-	return 0;
+	val = exynos_pcie_readl(ep->elbi_base, PCIE_ELBI_RDLH_LINKUP);
+	return (val & PCIE_ELBI_XMLH_LINKUP);
 }
 
 static int exynos_pcie_host_init(struct pcie_port *pp)
@@ -386,10 +292,8 @@ static int exynos_pcie_host_init(struct pcie_port *pp)
 
 	pp->bridge->ops = &exynos_pci_ops;
 
-	exynos_pcie_establish_link(ep);
-	exynos_pcie_enable_interrupts(ep);
-
-	return 0;
+	exynos_pcie_enable_irq_pulse(ep);
+	return exynos_pcie_establish_link(ep);
 }
 
 static const struct dw_pcie_host_ops exynos_pcie_host_ops = {
@@ -399,28 +303,22 @@ static const struct dw_pcie_host_ops exynos_pcie_host_ops = {
 static int __init exynos_add_pcie_port(struct exynos_pcie *ep,
 				       struct platform_device *pdev)
 {
-	struct dw_pcie *pci = ep->pci;
+	struct dw_pcie *pci = &ep->pci;
 	struct pcie_port *pp = &pci->pp;
 	struct device *dev = &pdev->dev;
 	int ret;
 
-	pp->irq = platform_get_irq(pdev, 1);
+	pp->irq = platform_get_irq(pdev, 0);
 	if (pp->irq < 0)
 		return pp->irq;
 
 	ret = devm_request_irq(dev, pp->irq, exynos_pcie_irq_handler,
-				IRQF_SHARED, "exynos-pcie", ep);
+			       IRQF_SHARED, "exynos-pcie", ep);
 	if (ret) {
 		dev_err(dev, "failed to request irq\n");
 		return ret;
 	}
 
-	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		pp->msi_irq = platform_get_irq(pdev, 0);
-		if (pp->msi_irq < 0)
-			return pp->msi_irq;
-	}
-
 	pp->ops = &exynos_pcie_host_ops;
 
 	ret = dw_pcie_host_init(pp);
@@ -438,10 +336,9 @@ static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = exynos_pcie_link_up,
 };
 
-static int __init exynos_pcie_probe(struct platform_device *pdev)
+static int exynos_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct dw_pcie *pci;
 	struct exynos_pcie *ep;
 	struct device_node *np = dev->of_node;
 	int ret;
@@ -450,42 +347,49 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
 	if (!ep)
 		return -ENOMEM;
 
-	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
-	if (!pci)
-		return -ENOMEM;
-
-	pci->dev = dev;
-	pci->ops = &dw_pcie_ops;
+	ep->pci.dev = dev;
+	ep->pci.ops = &dw_pcie_ops;
 
-	ep->pci = pci;
-	ep->ops = (const struct exynos_pcie_ops *)
-		of_device_get_match_data(dev);
+	ep->phy = devm_of_phy_get(dev, np, NULL);
+	if (IS_ERR(ep->phy))
+		return PTR_ERR(ep->phy);
 
-	ep->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
+	/* External Local Bus interface (ELBI) registers */
+	ep->elbi_base = devm_platform_ioremap_resource_byname(pdev, "elbi");
+	if (IS_ERR(ep->elbi_base))
+		return PTR_ERR(ep->elbi_base);
 
-	ep->phy = devm_of_phy_get(dev, np, NULL);
-	if (IS_ERR(ep->phy)) {
-		if (PTR_ERR(ep->phy) != -ENODEV)
-			return PTR_ERR(ep->phy);
+	/* Data Bus Interface (DBI) registers */
+	ep->pci.dbi_base = devm_platform_ioremap_resource_byname(pdev, "dbi");
+	if (IS_ERR(ep->pci.dbi_base))
+		return PTR_ERR(ep->pci.dbi_base);
 
-		ep->phy = NULL;
+	ep->clk = devm_clk_get(dev, "pcie");
+	if (IS_ERR(ep->clk)) {
+		dev_err(dev, "Failed to get pcie rc clock\n");
+		return PTR_ERR(ep->clk);
 	}
 
-	if (ep->ops && ep->ops->get_mem_resources) {
-		ret = ep->ops->get_mem_resources(pdev, ep);
-		if (ret)
-			return ret;
+	ep->bus_clk = devm_clk_get(dev, "pcie_bus");
+	if (IS_ERR(ep->bus_clk)) {
+		dev_err(dev, "Failed to get pcie bus clock\n");
+		return PTR_ERR(ep->bus_clk);
 	}
 
-	if (ep->ops && ep->ops->get_clk_resources &&
-			ep->ops->init_clk_resources) {
-		ret = ep->ops->get_clk_resources(ep);
-		if (ret)
-			return ret;
-		ret = ep->ops->init_clk_resources(ep);
-		if (ret)
-			return ret;
-	}
+	ep->supplies[0].supply = "vdd18";
+	ep->supplies[1].supply = "vdd10";
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ep->supplies),
+				      ep->supplies);
+	if (ret)
+		return ret;
+
+	ret = exynos_pcie_init_clk_resources(ep);
+	if (ret)
+		return ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(ep->supplies), ep->supplies);
+	if (ret)
+		return ret;
 
 	platform_set_drvdata(pdev, ep);
 
@@ -497,9 +401,9 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
 
 fail_probe:
 	phy_exit(ep->phy);
+	exynos_pcie_deinit_clk_resources(ep);
+	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
 
-	if (ep->ops && ep->ops->deinit_clk_resources)
-		ep->ops->deinit_clk_resources(ep);
 	return ret;
 }
 
@@ -507,32 +411,56 @@ static int __exit exynos_pcie_remove(struct platform_device *pdev)
 {
 	struct exynos_pcie *ep = platform_get_drvdata(pdev);
 
-	if (ep->ops && ep->ops->deinit_clk_resources)
-		ep->ops->deinit_clk_resources(ep);
+	phy_power_off(ep->phy);
+	phy_exit(ep->phy);
+	exynos_pcie_deinit_clk_resources(ep);
+	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
 
 	return 0;
 }
 
+static int __maybe_unused exynos_pcie_suspend_noirq(struct device *dev)
+{
+	struct exynos_pcie *ep = dev_get_drvdata(dev);
+
+	phy_power_off(ep->phy);
+	phy_exit(ep->phy);
+	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
+
+	return 0;
+}
+
+static int __maybe_unused exynos_pcie_resume_noirq(struct device *dev)
+{
+	struct exynos_pcie *ep = dev_get_drvdata(dev);
+	struct dw_pcie *pci = &ep->pci;
+	struct pcie_port *pp = &pci->pp;
+	int ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(ep->supplies), ep->supplies);
+	if (ret)
+		return ret;
+	/* exynos_pcie_host_init controls ep->phy */
+	return exynos_pcie_host_init(pp);
+}
+
+static const struct dev_pm_ops exynos_pcie_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(exynos_pcie_suspend_noirq,
+				      exynos_pcie_resume_noirq)
+};
+
 static const struct of_device_id exynos_pcie_of_match[] = {
-	{
-		.compatible = "samsung,exynos5440-pcie",
-		.data = &exynos5440_pcie_ops
-	},
-	{},
+	{ .compatible = "samsung,exynos5433-pcie", },
+	{ },
 };
 
 static struct platform_driver exynos_pcie_driver = {
+	.probe		= exynos_pcie_probe,
 	.remove		= __exit_p(exynos_pcie_remove),
 	.driver = {
 		.name	= "exynos-pcie",
 		.of_match_table = exynos_pcie_of_match,
+		.pm		= &exynos_pcie_pm_ops,
 	},
 };
-
-/* Exynos PCIe driver does not allow module unload */
-
-static int __init exynos_pcie_init(void)
-{
-	return platform_driver_probe(&exynos_pcie_driver, exynos_pcie_probe);
-}
-subsys_initcall(exynos_pcie_init);
+builtin_platform_driver(exynos_pcie_driver);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f70692ac79c5..8b93f0bba1f2 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2522,6 +2522,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_VT3351, quirk_disab
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_VT3364, quirk_disable_all_msi);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8380_0, quirk_disable_all_msi);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI, 0x0761, quirk_disable_all_msi);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SAMSUNG, 0xa5e3, quirk_disable_all_msi);
 
 /* Disable MSI on chipsets that are known to not support it */
 static void quirk_disable_msi(struct pci_dev *dev)
-- 
2.17.1

