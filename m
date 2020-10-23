Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD662296ACB
	for <lists+linux-pci@lfdr.de>; Fri, 23 Oct 2020 09:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S376061AbgJWH6g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Oct 2020 03:58:36 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50060 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S376071AbgJWH6f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Oct 2020 03:58:35 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201023075817euoutp01e47d993567e5bc787ddd82a8e3c846cb~AkBd17F0j2398723987euoutp015
        for <linux-pci@vger.kernel.org>; Fri, 23 Oct 2020 07:58:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201023075817euoutp01e47d993567e5bc787ddd82a8e3c846cb~AkBd17F0j2398723987euoutp015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603439897;
        bh=s3Gm79p5rSWZihN7jMHBjJXXACNAHEx3H0zk/DwMSFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q1xtKe5wbOduDYyY0sd5S+5l1ICmYztmp+8y6l/ac/chTXM6EulnVClko8ifD5SmB
         rIJzTUxRQD99mwJcYzDRVntGJC92nwXrHGweocGAxLpx9ajNd7puwPiU7Rl9n9j36C
         gvUa/lILzLICRwwmakOnmqqOyZmLtmDNGYa+H0OU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201023075756eucas1p2816dd27f07e02d2a7225fec1fab244dd~AkBKMQEOH1770417704eucas1p2G;
        Fri, 23 Oct 2020 07:57:56 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 53.06.06318.40D829F5; Fri, 23
        Oct 2020 08:57:56 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201023075756eucas1p2c27cc3e6372127d107e5b84c810ba98f~AkBJ4e5_81763917639eucas1p2J;
        Fri, 23 Oct 2020 07:57:56 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201023075756eusmtrp2eb3321d087ce46ee30c71eef7e81ef1f~AkBJ30GzC2108721087eusmtrp2g;
        Fri, 23 Oct 2020 07:57:56 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-b2-5f928d0409d9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A4.27.06017.40D829F5; Fri, 23
        Oct 2020 08:57:56 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201023075755eusmtip18a8566b6b14a0d114b6c3e5cbc2f3fcd~AkBJVI4gA1824918249eusmtip1a;
        Fri, 23 Oct 2020 07:57:55 +0000 (GMT)
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
Subject: [PATCH v2 4/6] phy: samsung: phy-exynos-pcie: rework driver to
 support Exynos5433 PCIe PHY
Date:   Fri, 23 Oct 2020 09:57:42 +0200
Message-Id: <20201023075744.26200-5-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201023075744.26200-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsWy7djP87osvZPiDfo+qVgsacqwmH/kHKvF
        jV9trBYrvsxkt7jwtIfN4vz5DewWl3fNYbM4O+84m8WM8/uYLN78fsFusfbIXXaL1r1H2C12
        3jnB7MDrsWbeGkaPnbPusnss2FTqsWlVJ5tH35ZVjB7Hb2xn8vi8SS6APYrLJiU1J7MstUjf
        LoErY8PPvIJdZRUvHn9ibWC8mdbFyMkhIWAicXX2QvYuRi4OIYEVjBL3391ihHC+MErs3HoQ
        yvnMKHG7YS4jTMvu58tZIRLLGSV+rbzDBJIAa9nYYAJiswkYSnS97WLrYuTgEBFwkPjx1QKk
        nllgEbNEQ/8RsEHCAqkSbxavZAWxWQRUJdbsfgUW5xWwlXhy4xUbxDJ5idUbDjCD2JwCdhLv
        Gu6BXSQhsI5d4m3LJqgiF4ltE08wQ9jCEq+Ob2GHsGUk/u+czwTR0Mwo8fDcWnYIp4dR4nLT
        DKh/rCXunPsFdiqzgKbE+l36EGFHiQ0Hz4KFJQT4JG68FQQJMwOZk7ZNZ4YI80p0tAlBVKtJ
        zDq+Dm7twQuXoM7xkJj2dA0LJLAmMkq8Xn2GbQKj/CyEZQsYGVcxiqeWFuempxYb56WW6xUn
        5haX5qXrJefnbmIEJpzT/45/3cG470/SIUYBDkYlHt6ECRPjhVgTy4orcw8xSnAwK4nwOp09
        HSfEm5JYWZValB9fVJqTWnyIUZqDRUmc13jRy1ghgfTEktTs1NSC1CKYLBMHp1QD49WQ0O/h
        jL39Di+2eLc4/NPasuD4ZO7be4rznnI9Pdz9dl7cy/l3Pl6JOzn7wVdGTQ/xZ9+qu9+5cDzp
        mbxVsp7ZqDzxbsK/vXvEwmu3fXrwqGVOjvNho4WMC8oZj5zaUiVTnVIamjaZ3+/xX7Uvf+NO
        JH/m5N7cf6J6qp6u4KS/T6bl2PxN91ViKc5INNRiLipOBAD/01A0NAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42I5/e/4XV2W3knxBgtWC1ksacqwmH/kHKvF
        jV9trBYrvsxkt7jwtIfN4vz5DewWl3fNYbM4O+84m8WM8/uYLN78fsFusfbIXXaL1r1H2C12
        3jnB7MDrsWbeGkaPnbPusnss2FTqsWlVJ5tH35ZVjB7Hb2xn8vi8SS6APUrPpii/tCRVISO/
        uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEvY8PPvIJdZRUvHn9ibWC8
        mdbFyMkhIWAisfv5ctYuRi4OIYGljBIzbz5jh0jISJyc1sAKYQtL/LnWxQZR9IlRYtbZ5Swg
        CTYBQ4mutyAJTg4RASeJ95MvMoMUMQusYZZobOtmAkkICyRLvD05G8xmEVCVWLP7FSOIzStg
        K/Hkxis2iA3yEqs3HGAGsTkF7CTeNdwDqxECqjl86CrzBEa+BYwMqxhFUkuLc9Nzi430ihNz
        i0vz0vWS83M3MQIjYNuxn1t2MHa9Cz7EKMDBqMTDmzBhYrwQa2JZcWXuIUYJDmYlEV6ns6fj
        hHhTEiurUovy44tKc1KLDzGaAh01kVlKNDkfGJ15JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE
        0hNLUrNTUwtSi2D6mDg4pRoY3XN1N+2rjF22Izj4+pbDc04p/bvx+82zTUerZxzavJuR97B1
        xEPW+WdOsZnPkZKUcvwnLlz+QYSt+hqTF7Pa703pk4pkJ5xVeewk8ymu4sjv1RP3sbWx7fnz
        7H2GrNWvGbM2vpj6+FrVuaVyFzV/VigUPTeRVJibViF07uW+T/riJ38d09mcw6DEUpyRaKjF
        XFScCAAtape7lgIAAA==
X-CMS-MailID: 20201023075756eucas1p2c27cc3e6372127d107e5b84c810ba98f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201023075756eucas1p2c27cc3e6372127d107e5b84c810ba98f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201023075756eucas1p2c27cc3e6372127d107e5b84c810ba98f
References: <20201023075744.26200-1-m.szyprowski@samsung.com>
        <CGME20201023075756eucas1p2c27cc3e6372127d107e5b84c810ba98f@eucas1p2.samsung.com>
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
---
 drivers/phy/samsung/phy-exynos-pcie.c | 304 ++++++++++----------------
 1 file changed, 112 insertions(+), 192 deletions(-)

diff --git a/drivers/phy/samsung/phy-exynos-pcie.c b/drivers/phy/samsung/phy-exynos-pcie.c
index 7e28b1aea0d1..d91de323dd0e 100644
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
@@ -232,30 +153,30 @@ static int exynos_pcie_phy_probe(struct platform_device *pdev)
 	struct exynos_pcie_phy *exynos_phy;
 	struct phy *generic_phy;
 	struct phy_provider *phy_provider;
-	struct resource *res;
-	const struct exynos_pcie_phy_data *drv_data;
-
-	drv_data = of_device_get_match_data(dev);
-	if (!drv_data)
-		return -ENODEV;
 
 	exynos_phy = devm_kzalloc(dev, sizeof(*exynos_phy), GFP_KERNEL);
 	if (!exynos_phy)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	exynos_phy->phy_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(exynos_phy->phy_base))
-		return PTR_ERR(exynos_phy->phy_base);
+	exynos_phy->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(exynos_phy->base))
+		return PTR_ERR(exynos_phy->base);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	exynos_phy->blk_base = devm_ioremap_resource(dev, res);
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
@@ -275,5 +196,4 @@ static struct platform_driver exynos_pcie_phy_driver = {
 		.suppress_bind_attrs = true,
 	}
 };
-
 builtin_platform_driver(exynos_pcie_phy_driver);
-- 
2.17.1

