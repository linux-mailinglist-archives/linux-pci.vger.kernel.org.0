Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171C22BA76F
	for <lists+linux-pci@lfdr.de>; Fri, 20 Nov 2020 11:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbgKTK1I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Nov 2020 05:27:08 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44367 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbgKTK1H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Nov 2020 05:27:07 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201120102655euoutp029d62045a32cfaf3d3d1a5f27af27325b~JMHOPCsY-1667916679euoutp02W
        for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2020 10:26:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201120102655euoutp029d62045a32cfaf3d3d1a5f27af27325b~JMHOPCsY-1667916679euoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1605868015;
        bh=4mw3nHzFZwP6Nf+X3tv8Vexa2lTwfIIZFvFFjCrXNm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ul5G8v7FedM24gI35nezyrWfiI/MV5ba3Dd9wyncqrChBZ4PS2opk3IGvgP4yGWfu
         g5NnRFbdCgvqs+s1sQ6vQYYNXpaePokAe27rGxBwKlwP60oaOtjWjIslJGQydw30+e
         J1uC27ZpVa7Zrf9UP0jamtrht1QdIksm461udbcQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201120102654eucas1p27c1da664481415e7cf9fcd6c3832e1d0~JMHN9ZGMl1024710247eucas1p2w;
        Fri, 20 Nov 2020 10:26:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id CB.EB.27958.EE997BF5; Fri, 20
        Nov 2020 10:26:54 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201120102654eucas1p2f7395e14632a019a58f0ed5002eff556~JMHNliW-b1429214292eucas1p2I;
        Fri, 20 Nov 2020 10:26:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201120102654eusmtrp2af82ddf8caa4eb4f229eaf7b1d08efc1~JMHNkx7-21132911329eusmtrp2W;
        Fri, 20 Nov 2020 10:26:54 +0000 (GMT)
X-AuditID: cbfec7f2-f15ff70000006d36-21-5fb799ee825d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 84.ED.21957.EE997BF5; Fri, 20
        Nov 2020 10:26:54 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201120102653eusmtip1ba2f10a85eb6df3e6b185ab68ef6ba43~JMHM66UsR1922519225eusmtip1k;
        Fri, 20 Nov 2020 10:26:53 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     Vinod Koul <vkoul@kernel.org>, linux-samsung-soc@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v4 4/5 REBASED RESEND] phy: samsung: phy-exynos-pcie: rework
 driver to support Exynos5433 PCIe PHY
Date:   Fri, 20 Nov 2020 11:26:27 +0100
Message-Id: <20201120102627.14450-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201120101138.GI2925@vkoul-mobl>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsWy7djPc7rvZm6PN3i7TN1i44z1rBZLmjIs
        5h85x2px41cbq8WKLzPZLS487WGzOH9+A7vF5V1z2CzOzjvOZjHj/D4mize/X7BbrD1yl93i
        /54d7BY775xgduDzWDNvDaPHzll32T0WbCr12LSqk82jb8sqRo/jN7YzeXzeJBfAHsVlk5Ka
        k1mWWqRvl8CVsWDOJdaCZWUVzy/tZmlgPJnWxcjJISFgInFoyTGWLkYuDiGBFYwSC7feZoJw
        vjBKzH63jg3C+cwo8eHVbWaYlo+3/0O1LGeUaJo4gxmu5eeu1ywgVWwChhJdb7vYQGwRgUSJ
        1gkr2UGKmAV2MEtcPf0DqIODQ1igROLu+nyQGhYBVYmtn5+A1fMK2EqsvXmXDWKbvMTqDQfA
        NnMK6Es8fHAQ7CQJgTscEj2HFrNAFLlIXHxwggnCFpZ4dXwLO4QtI/F/53wmiIZmRomH59ay
        Qzg9jBKXm2YwQlRZS9w594sN5CJmAU2J9bv0IcKOEl8fHAE7VEKAT+LGW0GQMDOQOWnbdKgw
        r0RHmxBEtZrErOPr4NYevHAJGloeEvfvHISGVhOjxMH1TawTGOVnISxbwMi4ilE8tbQ4Nz21
        2DAvtVyvODG3uDQvXS85P3cTIzD9nP53/NMOxrmvPuodYmTiYDzEKMHBrCTCu1Zza7wQb0pi
        ZVVqUX58UWlOavEhRmkOFiVx3lWz18QLCaQnlqRmp6YWpBbBZJk4OKUamPi4v26bMDvlUILv
        5wjbL4whAVt/f5h8jWfmC+bv0T1Toi/tt7VqWbk+fKHfAdakLT63/294tMXhTPGdr0ntdgtu
        lM5fM7Hnzm2fd1+3r55TmO9T15m0LeOvhMgXDWY+Ue798/S+7vdbraF+at7R3IBbc98+8q07
        ufKXXN0GWZtt88sST+WyMAjMqTJ5UezSunBBqQdzSn3TnbPG7yYbh6i+vfnJ+rn93cUti9en
        O31P3n7z1CmH/dv7t2aZz30Rr9ysmb21b6KV+fG9Cw7uubBl4ooFZ6Yc5OZ0ylcQnp0y32KV
        RH16i97UW1NyuN8XLuC8xe3pb3l5z50/Cq9uh03QNbXyEsg7eONS8aKeouccSizFGYmGWsxF
        xYkAPc3aJa4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsVy+t/xu7rvZm6PNzi+gddi44z1rBZLmjIs
        5h85x2px41cbq8WKLzPZLS487WGzOH9+A7vF5V1z2CzOzjvOZjHj/D4mize/X7BbrD1yl93i
        /54d7BY775xgduDzWDNvDaPHzll32T0WbCr12LSqk82jb8sqRo/jN7YzeXzeJBfAHqVnU5Rf
        WpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXsWDOJdaCZWUV
        zy/tZmlgPJnWxcjJISFgIvHx9n8WEFtIYCmjxLuTPBBxGYmT0xpYIWxhiT/Xuti6GLmAaj4x
        Skye940ZJMEmYCjR9RYkwckhIpAscfH8ORaQImaBA8wSs39uBpsqLFAk0Xj0E5jNIqAqsfXz
        E7AGXgFbibU377JBbJCXWL3hANhQTgF9iYcPDrJBXKQnsbpnC/MERr4FjAyrGEVSS4tz03OL
        DfWKE3OLS/PS9ZLzczcxAmNh27Gfm3cwznv1Ue8QIxMH4yFGCQ5mJRHetZpb44V4UxIrq1KL
        8uOLSnNSiw8xmgLdMZFZSjQ5HxiNeSXxhmYGpoYmZpYGppZmxkrivFvnrokXEkhPLEnNTk0t
        SC2C6WPi4JRqYNL7oWu/6YTy0awD4o1fl/h8uXDfYcGpwzsbO6IneBf+fmdbkr5tzaLPPPaM
        L46pLp6qcEa2atljiWlvmuXzI51VIrtlnjqL2AUdmRhRxH71/YQNb08X/DF/sUD1WanpZA+2
        R9Mepli+3vTF7v2VbTMvhVsYzl5crsRwLpNH1m0nw/THb7a/CZnqmb10Qt+Fn2KvXMIOMkRv
        lt/w9b1+c6PNBmHZhV46WjG+S/ufKZSfN9r+Sej7wQbGCNGwNV9nPPiqsbLieKmCDpdGXG6b
        lj33K7Wp0zQOqjGm7HjBubKp2Slgg3kHj8+eN+HMzCdvZM3uUQq9mWsekvnOKrd2Gtv92Uv7
        T3edtni37K7UEWUlluKMREMt5qLiRACWYaBcDgMAAA==
X-CMS-MailID: 20201120102654eucas1p2f7395e14632a019a58f0ed5002eff556
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201120102654eucas1p2f7395e14632a019a58f0ed5002eff556
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201120102654eucas1p2f7395e14632a019a58f0ed5002eff556
References: <20201120101138.GI2925@vkoul-mobl>
        <CGME20201120102654eucas1p2f7395e14632a019a58f0ed5002eff556@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jaehoon Chung <jh80.chung@samsung.com>

Exynos5440 SoC support has been dropped since commit 8c83315da1cf ("ARM:
dts: exynos: Remove Exynos5440"). Rework this driver to support PCIe PHY
variant found in the Exynos5433 SoCs.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
[mszyprow: reworked the driver to support only Exynos5433 variant, rebased
	   onto current kernel code, rewrote commit message]
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Jingoo Han <jingoohan1@gmail.com>
---
Resend reason: rebased onto current -next branch
---
 drivers/phy/samsung/phy-exynos-pcie.c | 301 ++++++++++----------------
 1 file changed, 112 insertions(+), 189 deletions(-)

diff --git a/drivers/phy/samsung/phy-exynos-pcie.c b/drivers/phy/samsung/phy-exynos-pcie.c
index c98fff5c1ac8..d91de323dd0e 100644
--- a/drivers/phy/samsung/phy-exynos-pcie.c
+++ b/drivers/phy/samsung/phy-exynos-pcie.c
@@ -4,70 +4,41 @@
  *
  * Phy provider for PCIe controller on Exynos SoC series
  *
- * Copyright (C) 2017 Samsung Electronics Co., Ltd.
+ * Copyright (C) 2017-2020 Samsung Electronics Co., Ltd.
  * Jaehoon Chung <jh80.chung@samsung.com>
  */
 
-#include <linux/delay.h>
 #include <linux/io.h>
-#include <linux/iopoll.h>
-#include <linux/init.h>
 #include <linux/mfd/syscon.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/phy/phy.h>
 #include <linux/regmap.h>
 
-/* PCIe Purple registers */
-#define PCIE_PHY_GLOBAL_RESET		0x000
-#define PCIE_PHY_COMMON_RESET		0x004
-#define PCIE_PHY_CMN_REG		0x008
-#define PCIE_PHY_MAC_RESET		0x00c
-#define PCIE_PHY_PLL_LOCKED		0x010
-#define PCIE_PHY_TRSVREG_RESET		0x020
-#define PCIE_PHY_TRSV_RESET		0x024
-
-/* PCIe PHY registers */
-#define PCIE_PHY_IMPEDANCE		0x004
-#define PCIE_PHY_PLL_DIV_0		0x008
-#define PCIE_PHY_PLL_BIAS		0x00c
-#define PCIE_PHY_DCC_FEEDBACK		0x014
-#define PCIE_PHY_PLL_DIV_1		0x05c
-#define PCIE_PHY_COMMON_POWER		0x064
-#define PCIE_PHY_COMMON_PD_CMN		BIT(3)
-#define PCIE_PHY_TRSV0_EMP_LVL		0x084
-#define PCIE_PHY_TRSV0_DRV_LVL		0x088
-#define PCIE_PHY_TRSV0_RXCDR		0x0ac
-#define PCIE_PHY_TRSV0_POWER		0x0c4
-#define PCIE_PHY_TRSV0_PD_TSV		BIT(7)
-#define PCIE_PHY_TRSV0_LVCC		0x0dc
-#define PCIE_PHY_TRSV1_EMP_LVL		0x144
-#define PCIE_PHY_TRSV1_RXCDR		0x16c
-#define PCIE_PHY_TRSV1_POWER		0x184
-#define PCIE_PHY_TRSV1_PD_TSV		BIT(7)
-#define PCIE_PHY_TRSV1_LVCC		0x19c
-#define PCIE_PHY_TRSV2_EMP_LVL		0x204
-#define PCIE_PHY_TRSV2_RXCDR		0x22c
-#define PCIE_PHY_TRSV2_POWER		0x244
-#define PCIE_PHY_TRSV2_PD_TSV		BIT(7)
-#define PCIE_PHY_TRSV2_LVCC		0x25c
-#define PCIE_PHY_TRSV3_EMP_LVL		0x2c4
-#define PCIE_PHY_TRSV3_RXCDR		0x2ec
-#define PCIE_PHY_TRSV3_POWER		0x304
-#define PCIE_PHY_TRSV3_PD_TSV		BIT(7)
-#define PCIE_PHY_TRSV3_LVCC		0x31c
-
-struct exynos_pcie_phy_data {
-	const struct phy_ops	*ops;
-};
+#define PCIE_PHY_OFFSET(x)		((x) * 0x4)
+
+/* Sysreg FSYS register offsets and bits for Exynos5433 */
+#define PCIE_EXYNOS5433_PHY_MAC_RESET		0x0208
+#define PCIE_MAC_RESET_MASK			0xFF
+#define PCIE_MAC_RESET				BIT(4)
+#define PCIE_EXYNOS5433_PHY_L1SUB_CM_CON	0x1010
+#define PCIE_REFCLK_GATING_EN			BIT(0)
+#define PCIE_EXYNOS5433_PHY_COMMON_RESET	0x1020
+#define PCIE_PHY_RESET				BIT(0)
+#define PCIE_EXYNOS5433_PHY_GLOBAL_RESET	0x1040
+#define PCIE_GLOBAL_RESET			BIT(0)
+#define PCIE_REFCLK				BIT(1)
+#define PCIE_REFCLK_MASK			0x16
+#define PCIE_APP_REQ_EXIT_L1_MODE		BIT(5)
+
+/* PMU PCIE PHY isolation control */
+#define EXYNOS5433_PMU_PCIE_PHY_OFFSET		0x730
 
 /* For Exynos pcie phy */
 struct exynos_pcie_phy {
-	const struct exynos_pcie_phy_data *drv_data;
-	void __iomem *phy_base;
-	void __iomem *blk_base; /* For exynos5440 */
+	void __iomem *base;
+	struct regmap *pmureg;
+	struct regmap *fsysreg;
 };
 
 static void exynos_pcie_phy_writel(void __iomem *base, u32 val, u32 offset)
@@ -75,153 +46,103 @@ static void exynos_pcie_phy_writel(void __iomem *base, u32 val, u32 offset)
 	writel(val, base + offset);
 }
 
-static u32 exynos_pcie_phy_readl(void __iomem *base, u32 offset)
-{
-	return readl(base + offset);
-}
-
-/* For Exynos5440 specific functions */
-static int exynos5440_pcie_phy_init(struct phy *phy)
+/* Exynos5433 specific functions */
+static int exynos5433_pcie_phy_init(struct phy *phy)
 {
 	struct exynos_pcie_phy *ep = phy_get_drvdata(phy);
 
-	/* DCC feedback control off */
-	exynos_pcie_phy_writel(ep->phy_base, 0x29, PCIE_PHY_DCC_FEEDBACK);
-
-	/* set TX/RX impedance */
-	exynos_pcie_phy_writel(ep->phy_base, 0xd5, PCIE_PHY_IMPEDANCE);
-
-	/* set 50Mhz PHY clock */
-	exynos_pcie_phy_writel(ep->phy_base, 0x14, PCIE_PHY_PLL_DIV_0);
-	exynos_pcie_phy_writel(ep->phy_base, 0x12, PCIE_PHY_PLL_DIV_1);
-
-	/* set TX Differential output for lane 0 */
-	exynos_pcie_phy_writel(ep->phy_base, 0x7f, PCIE_PHY_TRSV0_DRV_LVL);
-
-	/* set TX Pre-emphasis Level Control for lane 0 to minimum */
-	exynos_pcie_phy_writel(ep->phy_base, 0x0, PCIE_PHY_TRSV0_EMP_LVL);
-
-	/* set RX clock and data recovery bandwidth */
-	exynos_pcie_phy_writel(ep->phy_base, 0xe7, PCIE_PHY_PLL_BIAS);
-	exynos_pcie_phy_writel(ep->phy_base, 0x82, PCIE_PHY_TRSV0_RXCDR);
-	exynos_pcie_phy_writel(ep->phy_base, 0x82, PCIE_PHY_TRSV1_RXCDR);
-	exynos_pcie_phy_writel(ep->phy_base, 0x82, PCIE_PHY_TRSV2_RXCDR);
-	exynos_pcie_phy_writel(ep->phy_base, 0x82, PCIE_PHY_TRSV3_RXCDR);
-
-	/* change TX Pre-emphasis Level Control for lanes */
-	exynos_pcie_phy_writel(ep->phy_base, 0x39, PCIE_PHY_TRSV0_EMP_LVL);
-	exynos_pcie_phy_writel(ep->phy_base, 0x39, PCIE_PHY_TRSV1_EMP_LVL);
-	exynos_pcie_phy_writel(ep->phy_base, 0x39, PCIE_PHY_TRSV2_EMP_LVL);
-	exynos_pcie_phy_writel(ep->phy_base, 0x39, PCIE_PHY_TRSV3_EMP_LVL);
-
-	/* set LVCC */
-	exynos_pcie_phy_writel(ep->phy_base, 0x20, PCIE_PHY_TRSV0_LVCC);
-	exynos_pcie_phy_writel(ep->phy_base, 0xa0, PCIE_PHY_TRSV1_LVCC);
-	exynos_pcie_phy_writel(ep->phy_base, 0xa0, PCIE_PHY_TRSV2_LVCC);
-	exynos_pcie_phy_writel(ep->phy_base, 0xa0, PCIE_PHY_TRSV3_LVCC);
-
-	/* pulse for common reset */
-	exynos_pcie_phy_writel(ep->blk_base, 1, PCIE_PHY_COMMON_RESET);
-	udelay(500);
-	exynos_pcie_phy_writel(ep->blk_base, 0, PCIE_PHY_COMMON_RESET);
-
+	regmap_update_bits(ep->fsysreg,	PCIE_EXYNOS5433_PHY_COMMON_RESET,
+			   PCIE_PHY_RESET, 1);
+	regmap_update_bits(ep->fsysreg, PCIE_EXYNOS5433_PHY_MAC_RESET,
+			   PCIE_MAC_RESET, 0);
+
+	/* PHY refclk 24MHz */
+	regmap_update_bits(ep->fsysreg, PCIE_EXYNOS5433_PHY_GLOBAL_RESET,
+			   PCIE_REFCLK_MASK, PCIE_REFCLK);
+	regmap_update_bits(ep->fsysreg, PCIE_EXYNOS5433_PHY_GLOBAL_RESET,
+			   PCIE_GLOBAL_RESET, 0);
+
+
+	exynos_pcie_phy_writel(ep->base, 0x11, PCIE_PHY_OFFSET(0x3));
+
+	/* band gap reference on */
+	exynos_pcie_phy_writel(ep->base, 0, PCIE_PHY_OFFSET(0x20));
+	exynos_pcie_phy_writel(ep->base, 0, PCIE_PHY_OFFSET(0x4b));
+
+	/* jitter tunning */
+	exynos_pcie_phy_writel(ep->base, 0x34, PCIE_PHY_OFFSET(0x4));
+	exynos_pcie_phy_writel(ep->base, 0x02, PCIE_PHY_OFFSET(0x7));
+	exynos_pcie_phy_writel(ep->base, 0x41, PCIE_PHY_OFFSET(0x21));
+	exynos_pcie_phy_writel(ep->base, 0x7F, PCIE_PHY_OFFSET(0x14));
+	exynos_pcie_phy_writel(ep->base, 0xC0, PCIE_PHY_OFFSET(0x15));
+	exynos_pcie_phy_writel(ep->base, 0x61, PCIE_PHY_OFFSET(0x36));
+
+	/* D0 uninit.. */
+	exynos_pcie_phy_writel(ep->base, 0x44, PCIE_PHY_OFFSET(0x3D));
+
+	/* 24MHz */
+	exynos_pcie_phy_writel(ep->base, 0x94, PCIE_PHY_OFFSET(0x8));
+	exynos_pcie_phy_writel(ep->base, 0xA7, PCIE_PHY_OFFSET(0x9));
+	exynos_pcie_phy_writel(ep->base, 0x93, PCIE_PHY_OFFSET(0xA));
+	exynos_pcie_phy_writel(ep->base, 0x6B, PCIE_PHY_OFFSET(0xC));
+	exynos_pcie_phy_writel(ep->base, 0xA5, PCIE_PHY_OFFSET(0xF));
+	exynos_pcie_phy_writel(ep->base, 0x34, PCIE_PHY_OFFSET(0x16));
+	exynos_pcie_phy_writel(ep->base, 0xA3, PCIE_PHY_OFFSET(0x17));
+	exynos_pcie_phy_writel(ep->base, 0xA7, PCIE_PHY_OFFSET(0x1A));
+	exynos_pcie_phy_writel(ep->base, 0x71, PCIE_PHY_OFFSET(0x23));
+	exynos_pcie_phy_writel(ep->base, 0x4C, PCIE_PHY_OFFSET(0x24));
+
+	exynos_pcie_phy_writel(ep->base, 0x0E, PCIE_PHY_OFFSET(0x26));
+	exynos_pcie_phy_writel(ep->base, 0x14, PCIE_PHY_OFFSET(0x7));
+	exynos_pcie_phy_writel(ep->base, 0x48, PCIE_PHY_OFFSET(0x43));
+	exynos_pcie_phy_writel(ep->base, 0x44, PCIE_PHY_OFFSET(0x44));
+	exynos_pcie_phy_writel(ep->base, 0x03, PCIE_PHY_OFFSET(0x45));
+	exynos_pcie_phy_writel(ep->base, 0xA7, PCIE_PHY_OFFSET(0x48));
+	exynos_pcie_phy_writel(ep->base, 0x13, PCIE_PHY_OFFSET(0x54));
+	exynos_pcie_phy_writel(ep->base, 0x04, PCIE_PHY_OFFSET(0x31));
+	exynos_pcie_phy_writel(ep->base, 0, PCIE_PHY_OFFSET(0x32));
+
+	regmap_update_bits(ep->fsysreg, PCIE_EXYNOS5433_PHY_COMMON_RESET,
+			   PCIE_PHY_RESET, 0);
+	regmap_update_bits(ep->fsysreg, PCIE_EXYNOS5433_PHY_MAC_RESET,
+			   PCIE_MAC_RESET_MASK, PCIE_MAC_RESET);
 	return 0;
 }
 
-static int exynos5440_pcie_phy_power_on(struct phy *phy)
+static int exynos5433_pcie_phy_power_on(struct phy *phy)
 {
 	struct exynos_pcie_phy *ep = phy_get_drvdata(phy);
-	u32 val;
-
-	exynos_pcie_phy_writel(ep->blk_base, 0, PCIE_PHY_COMMON_RESET);
-	exynos_pcie_phy_writel(ep->blk_base, 0, PCIE_PHY_CMN_REG);
-	exynos_pcie_phy_writel(ep->blk_base, 0, PCIE_PHY_TRSVREG_RESET);
-	exynos_pcie_phy_writel(ep->blk_base, 0, PCIE_PHY_TRSV_RESET);
-
-	val = exynos_pcie_phy_readl(ep->phy_base, PCIE_PHY_COMMON_POWER);
-	val &= ~PCIE_PHY_COMMON_PD_CMN;
-	exynos_pcie_phy_writel(ep->phy_base, val, PCIE_PHY_COMMON_POWER);
-
-	val = exynos_pcie_phy_readl(ep->phy_base, PCIE_PHY_TRSV0_POWER);
-	val &= ~PCIE_PHY_TRSV0_PD_TSV;
-	exynos_pcie_phy_writel(ep->phy_base, val, PCIE_PHY_TRSV0_POWER);
-
-	val = exynos_pcie_phy_readl(ep->phy_base, PCIE_PHY_TRSV1_POWER);
-	val &= ~PCIE_PHY_TRSV1_PD_TSV;
-	exynos_pcie_phy_writel(ep->phy_base, val, PCIE_PHY_TRSV1_POWER);
-
-	val = exynos_pcie_phy_readl(ep->phy_base, PCIE_PHY_TRSV2_POWER);
-	val &= ~PCIE_PHY_TRSV2_PD_TSV;
-	exynos_pcie_phy_writel(ep->phy_base, val, PCIE_PHY_TRSV2_POWER);
-
-	val = exynos_pcie_phy_readl(ep->phy_base, PCIE_PHY_TRSV3_POWER);
-	val &= ~PCIE_PHY_TRSV3_PD_TSV;
-	exynos_pcie_phy_writel(ep->phy_base, val, PCIE_PHY_TRSV3_POWER);
 
+	regmap_update_bits(ep->pmureg, EXYNOS5433_PMU_PCIE_PHY_OFFSET,
+			   BIT(0), 1);
+	regmap_update_bits(ep->fsysreg, PCIE_EXYNOS5433_PHY_GLOBAL_RESET,
+			   PCIE_APP_REQ_EXIT_L1_MODE, 0);
+	regmap_update_bits(ep->fsysreg, PCIE_EXYNOS5433_PHY_L1SUB_CM_CON,
+			   PCIE_REFCLK_GATING_EN, 0);
 	return 0;
 }
 
-static int exynos5440_pcie_phy_power_off(struct phy *phy)
+static int exynos5433_pcie_phy_power_off(struct phy *phy)
 {
 	struct exynos_pcie_phy *ep = phy_get_drvdata(phy);
-	u32 val;
-
-	if (readl_poll_timeout(ep->phy_base + PCIE_PHY_PLL_LOCKED, val,
-				(val != 0), 1, 500)) {
-		dev_err(&phy->dev, "PLL Locked: 0x%x\n", val);
-		return -ETIMEDOUT;
-	}
-
-	val = exynos_pcie_phy_readl(ep->phy_base, PCIE_PHY_COMMON_POWER);
-	val |= PCIE_PHY_COMMON_PD_CMN;
-	exynos_pcie_phy_writel(ep->phy_base, val, PCIE_PHY_COMMON_POWER);
-
-	val = exynos_pcie_phy_readl(ep->phy_base, PCIE_PHY_TRSV0_POWER);
-	val |= PCIE_PHY_TRSV0_PD_TSV;
-	exynos_pcie_phy_writel(ep->phy_base, val, PCIE_PHY_TRSV0_POWER);
-
-	val = exynos_pcie_phy_readl(ep->phy_base, PCIE_PHY_TRSV1_POWER);
-	val |= PCIE_PHY_TRSV1_PD_TSV;
-	exynos_pcie_phy_writel(ep->phy_base, val, PCIE_PHY_TRSV1_POWER);
-
-	val = exynos_pcie_phy_readl(ep->phy_base, PCIE_PHY_TRSV2_POWER);
-	val |= PCIE_PHY_TRSV2_PD_TSV;
-	exynos_pcie_phy_writel(ep->phy_base, val, PCIE_PHY_TRSV2_POWER);
-
-	val = exynos_pcie_phy_readl(ep->phy_base, PCIE_PHY_TRSV3_POWER);
-	val |= PCIE_PHY_TRSV3_PD_TSV;
-	exynos_pcie_phy_writel(ep->phy_base, val, PCIE_PHY_TRSV3_POWER);
 
+	regmap_update_bits(ep->fsysreg, PCIE_EXYNOS5433_PHY_L1SUB_CM_CON,
+			   PCIE_REFCLK_GATING_EN, PCIE_REFCLK_GATING_EN);
+	regmap_update_bits(ep->pmureg, EXYNOS5433_PMU_PCIE_PHY_OFFSET,
+			   BIT(0), 0);
 	return 0;
 }
 
-static int exynos5440_pcie_phy_reset(struct phy *phy)
-{
-	struct exynos_pcie_phy *ep = phy_get_drvdata(phy);
-
-	exynos_pcie_phy_writel(ep->blk_base, 0, PCIE_PHY_MAC_RESET);
-	exynos_pcie_phy_writel(ep->blk_base, 1, PCIE_PHY_GLOBAL_RESET);
-	exynos_pcie_phy_writel(ep->blk_base, 0, PCIE_PHY_GLOBAL_RESET);
-
-	return 0;
-}
-
-static const struct phy_ops exynos5440_phy_ops = {
-	.init		= exynos5440_pcie_phy_init,
-	.power_on	= exynos5440_pcie_phy_power_on,
-	.power_off	= exynos5440_pcie_phy_power_off,
-	.reset		= exynos5440_pcie_phy_reset,
+static const struct phy_ops exynos5433_phy_ops = {
+	.init		= exynos5433_pcie_phy_init,
+	.power_on	= exynos5433_pcie_phy_power_on,
+	.power_off	= exynos5433_pcie_phy_power_off,
 	.owner		= THIS_MODULE,
 };
 
-static const struct exynos_pcie_phy_data exynos5440_pcie_phy_data = {
-	.ops		= &exynos5440_phy_ops,
-};
-
 static const struct of_device_id exynos_pcie_phy_match[] = {
 	{
-		.compatible = "samsung,exynos5440-pcie-phy",
-		.data = &exynos5440_pcie_phy_data,
+		.compatible = "samsung,exynos5433-pcie-phy",
 	},
 	{},
 };
@@ -232,27 +153,30 @@ static int exynos_pcie_phy_probe(struct platform_device *pdev)
 	struct exynos_pcie_phy *exynos_phy;
 	struct phy *generic_phy;
 	struct phy_provider *phy_provider;
-	const struct exynos_pcie_phy_data *drv_data;
-
-	drv_data = of_device_get_match_data(dev);
-	if (!drv_data)
-		return -ENODEV;
 
 	exynos_phy = devm_kzalloc(dev, sizeof(*exynos_phy), GFP_KERNEL);
 	if (!exynos_phy)
 		return -ENOMEM;
 
-	exynos_phy->phy_base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(exynos_phy->phy_base))
-		return PTR_ERR(exynos_phy->phy_base);
+	exynos_phy->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(exynos_phy->base))
+		return PTR_ERR(exynos_phy->base);
 
-	exynos_phy->blk_base = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(exynos_phy->blk_base))
-		return PTR_ERR(exynos_phy->blk_base);
+	exynos_phy->pmureg = syscon_regmap_lookup_by_phandle(dev->of_node,
+							"samsung,pmu-syscon");
+	if (IS_ERR(exynos_phy->pmureg)) {
+		dev_err(&pdev->dev, "PMU regmap lookup failed.\n");
+		return PTR_ERR(exynos_phy->pmureg);
+	}
 
-	exynos_phy->drv_data = drv_data;
+	exynos_phy->fsysreg = syscon_regmap_lookup_by_phandle(dev->of_node,
+							 "samsung,fsys-sysreg");
+	if (IS_ERR(exynos_phy->fsysreg)) {
+		dev_err(&pdev->dev, "FSYS sysreg regmap lookup failed.\n");
+		return PTR_ERR(exynos_phy->fsysreg);
+	}
 
-	generic_phy = devm_phy_create(dev, dev->of_node, drv_data->ops);
+	generic_phy = devm_phy_create(dev, dev->of_node, &exynos5433_phy_ops);
 	if (IS_ERR(generic_phy)) {
 		dev_err(dev, "failed to create PHY\n");
 		return PTR_ERR(generic_phy);
@@ -272,5 +196,4 @@ static struct platform_driver exynos_pcie_phy_driver = {
 		.suppress_bind_attrs = true,
 	}
 };
-
 builtin_platform_driver(exynos_pcie_phy_driver);
-- 
2.17.1

