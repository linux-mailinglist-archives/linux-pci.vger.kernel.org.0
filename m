Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABFBF2B214B
	for <lists+linux-pci@lfdr.de>; Fri, 13 Nov 2020 18:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgKMRCO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Nov 2020 12:02:14 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36208 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbgKMRCM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Nov 2020 12:02:12 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201113170200euoutp02655e95ce770bd1f5db327beab41b8301~HH-LYWtPi0529105291euoutp02J
        for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2020 17:02:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201113170200euoutp02655e95ce770bd1f5db327beab41b8301~HH-LYWtPi0529105291euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1605286920;
        bh=JAVFHgrpkvDRZeMJH2yMlNxwlJK4riSmnRgQJJ4YLsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ridltlnI2GQ5M2FLG0QTonbvngueIUsrMkq7F3wc1Kt8DHC2HQ4PXDZZZKCOgXRmK
         dYtQXpGIWRWvwxrhmYEv0vvFfaGpIaWbR9ZA7jSrsjMZCIViMpe/Ry0pdF9cmCVJJR
         jJ9qLX8SBLrOTz9LG7e6vQyfcBlkpYLTfx6CD3XE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201113170159eucas1p17adbe590711d0e6fff728fe39fbe9057~HH-LL5WIQ0160401604eucas1p1c;
        Fri, 13 Nov 2020 17:01:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id BE.9F.45488.70CBEAF5; Fri, 13
        Nov 2020 17:01:59 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201113170159eucas1p2a479cba641c51368e0f15b6f8eaeb5f4~HH-K3JXNz1162311623eucas1p2G;
        Fri, 13 Nov 2020 17:01:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201113170159eusmtrp1e0863d705d1d5da4e927eb4562ec576b~HH-K2dPlz1294812948eusmtrp1v;
        Fri, 13 Nov 2020 17:01:59 +0000 (GMT)
X-AuditID: cbfec7f5-c5fff7000000b1b0-dc-5faebc07ada5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 75.50.16282.70CBEAF5; Fri, 13
        Nov 2020 17:01:59 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201113170158eusmtip2ece45c7e30038275147736dc74150aa3~HH-KLlewN1944119441eusmtip2c;
        Fri, 13 Nov 2020 17:01:58 +0000 (GMT)
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
        Rob Herring <robh@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v4 5/5] PCI: dwc: exynos: Rework the driver to support
 Exynos5433 variant
Date:   Fri, 13 Nov 2020 18:01:39 +0100
Message-Id: <20201113170139.29956-6-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201113170139.29956-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSf0yMcRzHfZ/n7nme0uUR01fIdkp+JEXsuyExtucPtthkk6kbjw51d3vO
        oWZzOiPXTZIf/ZJmlVx1XSeVXORWXVh3fqWzjjHFjTJHoVC6nsN/n8/783p/P+999qXwgCJh
        ELVPdpDlZJIUMeErqG8fti0hzYbEyMrecFSbVyNEpRlSdKXVJkSOkZNCVDGYT6JHfToC2e1G
        Ej1tKiJQZ7GVQHn2Oxjq/+kiUXXrSxKNmRtJdMvZgcf6M1XFVYC5VfCSZEpMKsakP00wZ+r0
        gLE6GjDmqyk4jtzhu3oPm7LvEMstjUnylXY4rbhi6DI4MjZagqlB+wmgBT4UpKPh9TENqQW+
        VABdAaDm1ymMbwYBNNjdAr75CmBbs5n4a8kr13qpawC67H3EP8vZXiPuoQg6CmoHtOMDippO
        x8IfQ8jD4HQ3Du+XFWIeZhqdAJ2drokgAjoUZr3KFnhqEb0G5uTc8AacCyuNLRNv+tAxcKQj
        fyIspJ0UbLncTPLQBlh07iLO19PgB2udV58NH+bqBLxBA+AbW7XXrQPwaUaed8Uq6LSNTETF
        6YWwpmkpL6+Dan0R6ZEh7Q8dA1M9Mj5enqu/hPOyCGaeDODp+bDAavi39t6jJ16EgQ1X4/j7
        5ADodrzFzoK5Bf93lQCgB4GsSpmazCqXy9jDEUpJqlIlS47YLU81gfEP9HDUOtQIKj64IywA
        o4AFQAoXTxfNi61KDBDtkaSls5w8kVOlsEoLmEUJxIGippvjIzpZcpA9wLIKlvs7xSifIDVm
        4EpX+sU9cDvEmVkhSSuGF8xc24Qe71ppCVwY5ZP+qusUsen2VWH2+r2o9VddGSCyv3cGt5e1
        sM8rXUddXI799fv02rdhV+7udJ9XDSiPbstNTQjSFa9fvr+Xa0Hytn525o2ErLWjpccnaaIe
        6Ln0zZrIjK3H+vQK9Ynb92qub/SbvNgcL40Pr3vi7/qYZq4N61R06UZfxJz/FH+64YK1XjrF
        0Lw3ZEw+L+ld27cNX8ILa4ZTRHcXqzfm9yiyLdHRoaXGA4eNikK2/11hwWBjR6Zsxv6RZ3N6
        u7YEdoe8vg9yE6jyXNuyNGbwu9yY+XvgEmuqD16lqO75rOoO88vaLhYopZKoRTinlPwB5LRc
        w68DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsVy+t/xe7rse9bFG6yYLmGxccZ6VoslTRkW
        84+cY7W48auN1WLFl5nsFhee9rBZnD+/gd3i8q45bBZn5x1ns5hxfh+TxZvfL9gt1h65y27x
        f88Odoudd04wO/B5rJm3htFj56y77B4LNpV6bFrVyebRt2UVo8fxG9uZPD5vkgtgj9KzKcov
        LUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLOHHnOHPB17mM
        Ff//LWBqYDzWwtjFyMkhIWAiMWNZF1MXIxeHkMBSRonTTz+yQyRkJE5Oa2CFsIUl/lzrYoMo
        +sQo8bdpEQtIgk3AUKLrLUiCk0NEwEni/eSLzCBFzAIPmSUmzDkI1i0sEClx6fIaZhCbRUBV
        ovteP1gzr4CtxMSJm6HOkJdYveEAWA2ngJ3ErxMzga7gANpmK7F8R+gERr4FjAyrGEVSS4tz
        03OLjfSKE3OLS/PS9ZLzczcxAuNh27GfW3Ywrnz1Ue8QIxMH4yFGCQ5mJRFeZYc18UK8KYmV
        ValF+fFFpTmpxYcYTYHOmMgsJZqcD4zIvJJ4QzMDU0MTM0sDU0szYyVxXpMjQE0C6Yklqdmp
        qQWpRTB9TBycUg1MEkYX9i5p3zFT2OLqdK4l2jPNT2lWT7zOXL62ni99nYytg8K8DOmzwSls
        uz79CG6+PF/R1eqkV8arqeetlu5uZzn7qqnNdtdKTalFjkKXSoXuWLfN1AooX3V43aQtPAHa
        rP9uvT1oO/W4kO2Tz6zlsUuOzmlbpFVy7hSvH4/+99jwRZ9UZJ7XX3z99aPoYcU9FqmvTT1n
        nNi+9HysdtuumCRHxdvHoj6wZC53XvzPvsjYJn/nQ063pMVmuxVVvty5I54T9jrn+EspjrSD
        IiVbff9WJNRoZ2Yc3ee31rUqa3bgwmep627YXZ3D1XxDqWzPwedB7b/MkvZc/zLlZHqqyary
        XTnT/a8k/XRb6MX1X4mlOCPRUIu5qDgRANL2K20QAwAA
X-CMS-MailID: 20201113170159eucas1p2a479cba641c51368e0f15b6f8eaeb5f4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201113170159eucas1p2a479cba641c51368e0f15b6f8eaeb5f4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201113170159eucas1p2a479cba641c51368e0f15b6f8eaeb5f4
References: <20201113170139.29956-1-m.szyprowski@samsung.com>
        <CGME20201113170159eucas1p2a479cba641c51368e0f15b6f8eaeb5f4@eucas1p2.samsung.com>
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
	   removed MSI related code, rewrote commit message, added help]
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Jingoo Han <jingoohan1@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/Kconfig      |  10 +-
 drivers/pci/controller/dwc/pci-exynos.c | 353 ++++++++++--------------
 drivers/pci/quirks.c                    |   1 +
 3 files changed, 147 insertions(+), 217 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index bc049865f8e0..b0d41a80edfc 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -83,10 +83,14 @@ config PCIE_DW_PLAT_EP
 	  selected.
 
 config PCI_EXYNOS
-	bool "Samsung Exynos PCIe controller"
-	depends on SOC_EXYNOS5440 || COMPILE_TEST
-	depends on PCI_MSI_IRQ_DOMAIN
+	tristate "Samsung Exynos PCIe controller"
+	depends on ARCH_EXYNOS || COMPILE_TEST
 	select PCIE_DW_HOST
+	help
+	  Enables support for the PCIe controller in the Samsung Exynos SoCs
+	  to work in host mode. The PCI controller is based on the DesignWare
+	  hardware and therefore the driver re-uses the DesignWare core
+	  functions to implement the driver.
 
 config PCI_IMX6
 	bool "Freescale i.MX6/7/8 PCIe controller"
diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index 5c10a5432896..c24dab383654 100644
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
 
@@ -37,102 +34,43 @@
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
-
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
+static int exynos_pcie_init_clk_resources(struct exynos_pcie *ep)
 {
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
-{
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
@@ -141,24 +79,17 @@ static int exynos5440_pcie_init_clk_resources(struct exynos_pcie *ep)
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
@@ -173,94 +104,71 @@ static void exynos_pcie_sideband_dbi_w_mode(struct exynos_pcie *ep, bool on)
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
 
 static int exynos_pcie_start_link(struct dw_pcie *pci)
 {
 	struct exynos_pcie *ep = to_exynos_pcie(pci);
+	u32 val;
+
+	val = exynos_pcie_readl(ep->elbi_base, PCIE_SW_WAKE);
+	val &= ~PCIE_BUS_EN;
+	exynos_pcie_writel(ep->elbi_base, val, PCIE_SW_WAKE);
 
 	/* assert LTSSM enable */
-	exynos_pcie_writel(ep->mem_res->elbi_base, PCIE_ELBI_LTSSM_ENABLE,
+	exynos_pcie_writel(ep->elbi_base, PCIE_ELBI_LTSSM_ENABLE,
 			  PCIE_APP_LTSSM_ENABLE);
-
-	/* check if the link is up or not */
-	if (!dw_pcie_wait_for_link(pci))
-		return 0;
-
-	phy_power_off(ep->phy);
-	return -ETIMEDOUT;
+	return 0;
 }
 
 static void exynos_pcie_clear_irq_pulse(struct exynos_pcie *ep)
 {
-	u32 val;
-
-	val = exynos_pcie_readl(ep->mem_res->elbi_base, PCIE_IRQ_PULSE);
-	exynos_pcie_writel(ep->mem_res->elbi_base, val, PCIE_IRQ_PULSE);
-}
-
-static void exynos_pcie_enable_irq_pulse(struct exynos_pcie *ep)
-{
-	u32 val;
+	u32 val = exynos_pcie_readl(ep->elbi_base, PCIE_IRQ_PULSE);
 
-	/* enable INTX interrupt */
-	val = IRQ_INTA_ASSERT | IRQ_INTB_ASSERT |
-		IRQ_INTC_ASSERT | IRQ_INTD_ASSERT;
-	exynos_pcie_writel(ep->mem_res->elbi_base, val, PCIE_IRQ_EN_PULSE);
+	exynos_pcie_writel(ep->elbi_base, val, PCIE_IRQ_PULSE);
 }
 
 static irqreturn_t exynos_pcie_irq_handler(int irq, void *arg)
@@ -271,22 +179,14 @@ static irqreturn_t exynos_pcie_irq_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-static void exynos_pcie_msi_init(struct exynos_pcie *ep)
-{
-	u32 val;
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
@@ -345,13 +245,9 @@ static struct pci_ops exynos_pci_ops = {
 static int exynos_pcie_link_up(struct dw_pcie *pci)
 {
 	struct exynos_pcie *ep = to_exynos_pcie(pci);
-	u32 val;
+	u32 val = exynos_pcie_readl(ep->elbi_base, PCIE_ELBI_RDLH_LINKUP);
 
-	val = exynos_pcie_readl(ep->mem_res->elbi_base, PCIE_ELBI_RDLH_LINKUP);
-	if (val == PCIE_ELBI_LTSSM_ENABLE)
-		return 1;
-
-	return 0;
+	return (val & PCIE_ELBI_XMLH_LINKUP);
 }
 
 static int exynos_pcie_host_init(struct pcie_port *pp)
@@ -364,17 +260,11 @@ static int exynos_pcie_host_init(struct pcie_port *pp)
 	exynos_pcie_assert_core_reset(ep);
 
 	phy_reset(ep->phy);
-
-	exynos_pcie_writel(ep->mem_res->elbi_base, 1,
-			PCIE_PWR_RESET);
-
 	phy_power_on(ep->phy);
 	phy_init(ep->phy);
 
 	exynos_pcie_deassert_core_reset(ep);
-	exynos_pcie_assert_reset(ep);
-
-	exynos_pcie_enable_interrupts(ep);
+	exynos_pcie_enable_irq_pulse(ep);
 
 	return 0;
 }
@@ -383,26 +273,27 @@ static const struct dw_pcie_host_ops exynos_pcie_host_ops = {
 	.host_init = exynos_pcie_host_init,
 };
 
-static int __init exynos_add_pcie_port(struct exynos_pcie *ep,
+static int exynos_add_pcie_port(struct exynos_pcie *ep,
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
 
 	pp->ops = &exynos_pcie_host_ops;
+	pp->msi_irq = -ENODEV;
 
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
@@ -420,10 +311,9 @@ static const struct dw_pcie_ops dw_pcie_ops = {
 	.start_link = exynos_pcie_start_link,
 };
 
-static int __init exynos_pcie_probe(struct platform_device *pdev)
+static int exynos_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct dw_pcie *pci;
 	struct exynos_pcie *ep;
 	struct device_node *np = dev->of_node;
 	int ret;
@@ -432,43 +322,45 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
 	if (!ep)
 		return -ENOMEM;
 
-	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
-	if (!pci)
-		return -ENOMEM;
-
-	pci->dev = dev;
-	pci->ops = &dw_pcie_ops;
-
-	ep->pci = pci;
-	ep->ops = (const struct exynos_pcie_ops *)
-		of_device_get_match_data(dev);
-
-	ep->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
+	ep->pci.dev = dev;
+	ep->pci.ops = &dw_pcie_ops;
 
 	ep->phy = devm_of_phy_get(dev, np, NULL);
-	if (IS_ERR(ep->phy)) {
-		if (PTR_ERR(ep->phy) != -ENODEV)
-			return PTR_ERR(ep->phy);
+	if (IS_ERR(ep->phy))
+		return PTR_ERR(ep->phy);
 
-		ep->phy = NULL;
-	}
+	/* External Local Bus interface (ELBI) registers */
+	ep->elbi_base = devm_platform_ioremap_resource_byname(pdev, "elbi");
+	if (IS_ERR(ep->elbi_base))
+		return PTR_ERR(ep->elbi_base);
 
-	if (ep->ops && ep->ops->get_mem_resources) {
-		ret = ep->ops->get_mem_resources(pdev, ep);
-		if (ret)
-			return ret;
+	ep->clk = devm_clk_get(dev, "pcie");
+	if (IS_ERR(ep->clk)) {
+		dev_err(dev, "Failed to get pcie rc clock\n");
+		return PTR_ERR(ep->clk);
 	}
 
-	if (ep->ops && ep->ops->get_clk_resources &&
-			ep->ops->init_clk_resources) {
-		ret = ep->ops->get_clk_resources(ep);
-		if (ret)
-			return ret;
-		ret = ep->ops->init_clk_resources(ep);
-		if (ret)
-			return ret;
+	ep->bus_clk = devm_clk_get(dev, "pcie_bus");
+	if (IS_ERR(ep->bus_clk)) {
+		dev_err(dev, "Failed to get pcie bus clock\n");
+		return PTR_ERR(ep->bus_clk);
 	}
 
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
+
 	platform_set_drvdata(pdev, ep);
 
 	ret = exynos_add_pcie_port(ep, pdev);
@@ -479,9 +371,9 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
 
 fail_probe:
 	phy_exit(ep->phy);
+	exynos_pcie_deinit_clk_resources(ep);
+	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
 
-	if (ep->ops && ep->ops->deinit_clk_resources)
-		ep->ops->deinit_clk_resources(ep);
 	return ret;
 }
 
@@ -489,32 +381,65 @@ static int __exit exynos_pcie_remove(struct platform_device *pdev)
 {
 	struct exynos_pcie *ep = platform_get_drvdata(pdev);
 
-	if (ep->ops && ep->ops->deinit_clk_resources)
-		ep->ops->deinit_clk_resources(ep);
+	dw_pcie_host_deinit(&ep->pci.pp);
+	exynos_pcie_assert_core_reset(ep);
+	phy_power_off(ep->phy);
+	phy_exit(ep->phy);
+	exynos_pcie_deinit_clk_resources(ep);
+	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
+
+	return 0;
+}
+
+static int __maybe_unused exynos_pcie_suspend_noirq(struct device *dev)
+{
+	struct exynos_pcie *ep = dev_get_drvdata(dev);
+
+	exynos_pcie_assert_core_reset(ep);
+	phy_power_off(ep->phy);
+	phy_exit(ep->phy);
+	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
 
 	return 0;
 }
 
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
+
+	/* exynos_pcie_host_init controls ep->phy */
+	exynos_pcie_host_init(pp);
+	dw_pcie_setup_rc(pp);
+	exynos_pcie_start_link(pci);
+	return dw_pcie_wait_for_link(pci);
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
+module_platform_driver(exynos_pcie_driver);
+MODULE_LICENSE("GPL v2");
+MODULE_DEVICE_TABLE(of, exynos_pcie_of_match);
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

