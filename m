Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5316D2B2149
	for <lists+linux-pci@lfdr.de>; Fri, 13 Nov 2020 18:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgKMRCN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Nov 2020 12:02:13 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36207 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgKMRCM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Nov 2020 12:02:12 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201113170159euoutp02da4f6f9c6d7a11cbf3cbd470acf4d2dd~HH-K7MxDr0454504545euoutp028
        for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2020 17:01:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201113170159euoutp02da4f6f9c6d7a11cbf3cbd470acf4d2dd~HH-K7MxDr0454504545euoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1605286919;
        bh=gdjMW45LH1V7a5PoXN2PEBDKCHwl6twq6OwR+g7pkZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KyV60EQ2Frvl0ib/TDFuQ1H0vuRjEVTisDtN79fdfZMc4wcRzdwGteTvsEsl+Knqi
         hBl3shEkzgjpNPRVZbrVX3Uf2FwA1DNIAWINsvjejijRqZv3FvWGAEAlB9hGBjdiTP
         8rBUMNZ2cGTfGEfJ8rMmGxztjeaz8nN4iIKzgwvU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201113170159eucas1p15b4bbb4645ddbc7d31a1fb81ad4d4591~HH-KoBU6g2485424854eucas1p1R;
        Fri, 13 Nov 2020 17:01:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id CD.9F.45488.70CBEAF5; Fri, 13
        Nov 2020 17:01:59 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201113170158eucas1p14b9e58e35f929e14aeb4f533071c8a47~HH-KUvm8s0059700597eucas1p1S;
        Fri, 13 Nov 2020 17:01:58 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201113170158eusmtrp1072c737fc04dd44fd1b0199283000e39~HH-KT-xi41302013020eusmtrp1m;
        Fri, 13 Nov 2020 17:01:58 +0000 (GMT)
X-AuditID: cbfec7f5-c77ff7000000b1b0-db-5faebc07f5da
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 74.50.16282.60CBEAF5; Fri, 13
        Nov 2020 17:01:58 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201113170158eusmtip24c5aa68d4e90b0a884593606a7eb15ca~HH-Jmxio02027620276eusmtip2F;
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
Subject: [PATCH v4 4/5] phy: samsung: phy-exynos-pcie: rework driver to
 support Exynos5433 PCIe PHY
Date:   Fri, 13 Nov 2020 18:01:38 +0100
Message-Id: <20201113170139.29956-5-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201113170139.29956-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7djPc7rse9bFG/ydxGGxccZ6VoslTRkW
        84+cY7W48auN1WLFl5nsFhee9rBZnD+/gd3i8q45bBZn5x1ns5hxfh+TxZvfL9gt1h65y27x
        f88Odoudd04wO/B5rJm3htFj56y77B4LNpV6bFrVyebRt2UVo8fxG9uZPD5vkgtgj+KySUnN
        ySxLLdK3S+DKeDDLt+BVWcWze1/ZGxhb0rsYOTkkBEwkOk5uYAaxhQRWMEp0fpHrYuQCsr8w
        Suyb0McI4XxmlHh97gcjTMevXyugEssZJdbvOc0G13L59XwWkCo2AUOJrrddQAkODhEBB4kf
        Xy1AapgFrjNLnFw6mwmkRlggVeJl01qw3SwCqhKHj8wA28ArYCuxYc1DqG3yEqs3HACr4RSw
        k/h1YiY7yCAJgTscEjdfrGGDKHKROLAJ4gkJAWGJV8e3sEPYMhKnJ/ewQDQ0M0o8PLcWqrsH
        6NSmGVArrCXunPsFdiqzgKbE+l36EGFHieNPFzOChCUE+CRuvBUECTMDmZO2TWeGCPNKdLQJ
        QVSrScw6vg5u7cELl6DO8ZCYurUDGkATGSWu9U1gm8AoPwth2QJGxlWM4qmlxbnpqcXGeanl
        esWJucWleel6yfm5mxiBqef0v+NfdzCuePVR7xAjEwfjIUYJDmYlEV5lhzXxQrwpiZVVqUX5
        8UWlOanFhxilOViUxHl3bQVKCaQnlqRmp6YWpBbBZJk4OKUamMwLnuVYNastm5Gc2MDS599x
        3zR6yiMHG9lz7bPDXBKnOy9P7mHVkFE8FS3iblghZKae8NM+dRFD2qzrb69dOLrA9M/Nfx9r
        Cr69y8t/WR4Sw3rzaJdvrb5fi55DQR87X6nwii1r+Gr7lGc0yD5K/Z7/W5xrKXPEaSb+9/y1
        s6ad2r/76f7jC38nPcmdtDb9+C/tRnbu1xe/Xt7+L1f4TrjjLIc+lws6G/R+f7Q+65caw/Oq
        5ZPAm0+H9ti+YfF1lWneYnaH2e2FroDEsfV/rWK2vF3MecDpWUvRjt0NE1Iy11hcEJQICFwn
        49cdfUR08aOsEluLqV9UeybJW2+1PfbwwuszGZPFO49dkFQ9rsRSnJFoqMVcVJwIADNqtmOs
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsVy+t/xe7pse9bFGyx6pWuxccZ6VoslTRkW
        84+cY7W48auN1WLFl5nsFhee9rBZnD+/gd3i8q45bBZn5x1ns5hxfh+TxZvfL9gt1h65y27x
        f88Odoudd04wO/B5rJm3htFj56y77B4LNpV6bFrVyebRt2UVo8fxG9uZPD5vkgtgj9KzKcov
        LUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLeDDLt+BVWcWz
        e1/ZGxhb0rsYOTkkBEwkfv1awdjFyMUhJLCUUaJ3y1sWiISMxMlpDawQtrDEn2tdbBBFnxgl
        Zix9DVbEJmAo0fUWJMHJISLgJPF+8kVmkCJmgYfMEhPmHATrFhZIltjUNZkJxGYRUJU4fGQG
        I4jNK2ArsWHNQ0aIDfISqzccYAaxOQXsJH6dmMnexcgBtM1WYvmO0AmMfAsYGVYxiqSWFuem
        5xYb6RUn5haX5qXrJefnbmIERsK2Yz+37GBc+eqj3iFGJg7GQ4wSHMxKIrzKDmvihXhTEiur
        Uovy44tKc1KLDzGaAp0xkVlKNDkfGIt5JfGGZgamhiZmlgamlmbGSuK8JkeAmgTSE0tSs1NT
        C1KLYPqYODilGpgmXlO/kL+xSVTh6Lfiv0U8S+eK3nt76g/vnM7v6pbmxTqfnpb+SVLeryP1
        YdXm7LPbOTQmbVc6/+p3j8ER1cqNtQVfOXJUpabeeVoimiTwZWVYj9TlPZ9UKo7+tskq/KNp
        +8H0YFOoj+2WX7/YRUoOH34n75W98eS0j6JMVT+2bp0ezcoTc+6fifHO94pGl4yeRH5Wf3+9
        3FD7+IuDOvvPb+X9/CGFTctDZ+XKrB0HPzgveVdUNHFpkWQyT8jOLoXVqhsPPTpVwJr6ddaU
        S2xvGnaG5vJwv5vLwu2sddJ191vRX71PSvvenPYvK1skxG9SYXTjuGUFS9mS+pWPPnk/vvZ6
        XdmJyJuP18h7sVWEKrEUZyQaajEXFScCAPby97oNAwAA
X-CMS-MailID: 20201113170158eucas1p14b9e58e35f929e14aeb4f533071c8a47
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201113170158eucas1p14b9e58e35f929e14aeb4f533071c8a47
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201113170158eucas1p14b9e58e35f929e14aeb4f533071c8a47
References: <20201113170139.29956-1-m.szyprowski@samsung.com>
        <CGME20201113170158eucas1p14b9e58e35f929e14aeb4f533071c8a47@eucas1p1.samsung.com>
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

