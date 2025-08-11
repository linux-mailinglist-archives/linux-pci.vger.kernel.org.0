Return-Path: <linux-pci+bounces-33831-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C34B21C99
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 07:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C90EF1A27293
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 05:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBEE2E6138;
	Tue, 12 Aug 2025 05:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hF5HIN3a"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9881A9FA6
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 05:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754974958; cv=none; b=Ugu2zKHcs2BMJwdAXGDZUvXRaouuO5eKgue6NFtkP6IV1hAS4jJmFHPcCimuHhXaWJsg7AJj+HG9yZ5BtcfpmFllnyPBWOsl9lT/NWM7MIZ4JyH7DGJ3Iaadwr5t6BljZVvfFqBoTGnwIg2Q9mHeZaA8Cb6QM2Adzxric4FucA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754974958; c=relaxed/simple;
	bh=waDGSQz+LGYEy7UHi7OlVWjfdW75GnmuHNXi8kNYJZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=hu0X2pbHw3Wla9uk8nKeWGObx6oLDMlBEUW4qcdzMlyswcyQxc/AxBEzPeMbSoqKh/l4ZLfSoLINGzgiMgy+l9wkmuQU9ejcAZ+00WYZVVXjtIwwVkpBsLlYolcjIWJJdwa+n7qs5THwegDjodfZnEG2cylSlWEE3motRDoiKyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hF5HIN3a; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250812050234epoutp01422015125ec625524a6184edaf047f4f~a7GxR96Xs1029910299epoutp01N
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 05:02:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250812050234epoutp01422015125ec625524a6184edaf047f4f~a7GxR96Xs1029910299epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754974954;
	bh=uCphghzrKfKRz3BuKj/R9IE+H2oKxYOjbWYH1BufhmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hF5HIN3ajWk/wy1PDoHcFqf87NO8tx4UNh5j10cb29neDH5Mt2YAfJguCL0p7GEVY
	 WI+SLJUle8+WI9A1+VKLAUx96XAOTsr+Xl8Wpyp4K6sNk0VMaZz2v6i9KHBZW3QGT+
	 EkF+mfUTkaM9KXlixpKTkI1CBN/NHwhmXXvs5jT0=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250812050234epcas5p1fe437b2ebfedb1dbfe748217c865416a~a7GwncLvJ1637116371epcas5p15;
	Tue, 12 Aug 2025 05:02:34 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.91]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4c1KBK0WRnz6B9mJ; Tue, 12 Aug
	2025 05:02:33 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250811154738epcas5p1d1202f799c4d950c5d5e7f45e39a51e7~awQsLxpXe0384203842epcas5p16;
	Mon, 11 Aug 2025 15:47:38 +0000 (GMT)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250811154735epsmtip17c2186ff99f7d4ce9e9fd71d457a69e3~awQpjLYCi2560925609epsmtip1Y;
	Mon, 11 Aug 2025 15:47:35 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Cc: mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
	vkoul@kernel.org, kishon@kernel.org, arnd@arndb.de,
	m.szyprowski@samsung.com, jh80.chung@samsung.com, pankaj.dubey@samsung.com,
	Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH v3 10/12] phy: exynos: Add PCIe PHY support for FSD SoC
Date: Mon, 11 Aug 2025 21:16:36 +0530
Message-ID: <20250811154638.95732-11-shradha.t@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250811154638.95732-1-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250811154738epcas5p1d1202f799c4d950c5d5e7f45e39a51e7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250811154738epcas5p1d1202f799c4d950c5d5e7f45e39a51e7
References: <20250811154638.95732-1-shradha.t@samsung.com>
	<CGME20250811154738epcas5p1d1202f799c4d950c5d5e7f45e39a51e7@epcas5p1.samsung.com>

Add PCIe PHY support for Tesla FSD SoC.

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/phy/samsung/phy-exynos-pcie.c | 287 ++++++++++++++++++++++++++
 1 file changed, 287 insertions(+)

diff --git a/drivers/phy/samsung/phy-exynos-pcie.c b/drivers/phy/samsung/phy-exynos-pcie.c
index 022222a0212a..5a55a22f9661 100644
--- a/drivers/phy/samsung/phy-exynos-pcie.c
+++ b/drivers/phy/samsung/phy-exynos-pcie.c
@@ -34,9 +34,105 @@
 /* PMU PCIE PHY isolation control */
 #define EXYNOS5433_PMU_PCIE_PHY_OFFSET		0x730
 
+/* FSD: PCIe PHY common registers */
+#define FSD_PCIE_PHY_TRSV_CMN_REG03	0x000c
+#define FSD_PCIE_PHY_TRSV_CMN_REG01E	0x0078
+#define FSD_PCIE_PHY_TRSV_CMN_REG02D	0x00b4
+#define FSD_PCIE_PHY_TRSV_CMN_REG031	0x00c4
+#define FSD_PCIE_PHY_TRSV_CMN_REG036	0x00d8
+#define FSD_PCIE_PHY_TRSV_CMN_REG05F	0x017c
+#define FSD_PCIE_PHY_TRSV_CMN_REG060	0x0180
+#define FSD_PCIE_PHY_TRSV_CMN_REG062	0x0188
+#define FSD_PCIE_PHY_TRSV_CMN_REG061	0x0184
+#define FSD_PCIE_PHY_AGG_BIF_RESET	0x0200
+#define FSD_PCIE_PHY_AGG_BIF_CLOCK	0x0208
+#define FSD_PCIE_PHY_CMN_RESET		0x0228
+
+/* FSD: PCIe PHY lane registers */
+#define FSD_PCIE_LANE_OFFSET		0x0400
+#define FSD_PCIE_NUM_LANES		0x4
+
+#define FSD_PCIE_PHY_TRSV_REG001_LN_N	0x0404
+#define FSD_PCIE_PHY_TRSV_REG002_LN_N	0x0408
+#define FSD_PCIE_PHY_TRSV_REG005_LN_N	0x0414
+#define FSD_PCIE_PHY_TRSV_REG006_LN_N	0x0418
+#define FSD_PCIE_PHY_TRSV_REG007_LN_N	0x041c
+#define FSD_PCIE_PHY_TRSV_REG009_LN_N	0x0424
+#define FSD_PCIE_PHY_TRSV_REG00A_LN_N	0x0428
+#define FSD_PCIE_PHY_TRSV_REG00C_LN_N	0x0430
+#define FSD_PCIE_PHY_TRSV_REG012_LN_N	0x0448
+#define FSD_PCIE_PHY_TRSV_REG013_LN_N	0x044c
+#define FSD_PCIE_PHY_TRSV_REG014_LN_N	0x0450
+#define FSD_PCIE_PHY_TRSV_REG015_LN_N	0x0454
+#define FSD_PCIE_PHY_TRSV_REG016_LN_N	0x0458
+#define FSD_PCIE_PHY_TRSV_REG018_LN_N	0x0460
+#define FSD_PCIE_PHY_TRSV_REG020_LN_N	0x0480
+#define FSD_PCIE_PHY_TRSV_REG026_LN_N	0x0498
+#define FSD_PCIE_PHY_TRSV_REG029_LN_N	0x04a4
+#define FSD_PCIE_PHY_TRSV_REG031_LN_N	0x04c4
+#define FSD_PCIE_PHY_TRSV_REG036_LN_N	0x04d8
+#define FSD_PCIE_PHY_TRSV_REG039_LN_N	0x04e4
+#define FSD_PCIE_PHY_TRSV_REG03B_LN_N	0x04ec
+#define FSD_PCIE_PHY_TRSV_REG03C_LN_N	0x04f0
+#define FSD_PCIE_PHY_TRSV_REG03E_LN_N	0x04f8
+#define FSD_PCIE_PHY_TRSV_REG03F_LN_N	0x04fc
+#define FSD_PCIE_PHY_TRSV_REG043_LN_N	0x050c
+#define FSD_PCIE_PHY_TRSV_REG044_LN_N	0x0510
+#define FSD_PCIE_PHY_TRSV_REG046_LN_N	0x0518
+#define FSD_PCIE_PHY_TRSV_REG048_LN_N	0x0520
+#define FSD_PCIE_PHY_TRSV_REG049_LN_N	0x0524
+#define FSD_PCIE_PHY_TRSV_REG04E_LN_N	0x0538
+#define FSD_PCIE_PHY_TRSV_REG052_LN_N	0x0548
+#define FSD_PCIE_PHY_TRSV_REG068_LN_N	0x05a0
+#define FSD_PCIE_PHY_TRSV_REG069_LN_N	0x05a4
+#define FSD_PCIE_PHY_TRSV_REG06A_LN_N	0x05a8
+#define FSD_PCIE_PHY_TRSV_REG06B_LN_N	0x05ac
+#define FSD_PCIE_PHY_TRSV_REG07B_LN_N	0x05ec
+#define FSD_PCIE_PHY_TRSV_REG083_LN_N	0x060c
+#define FSD_PCIE_PHY_TRSV_REG084_LN_N	0x0610
+#define FSD_PCIE_PHY_TRSV_REG086_LN_N	0x0618
+#define FSD_PCIE_PHY_TRSV_REG087_LN_N	0x061c
+#define FSD_PCIE_PHY_TRSV_REG08B_LN_N	0x062c
+#define FSD_PCIE_PHY_TRSV_REG09C_LN_N	0x0670
+#define FSD_PCIE_PHY_TRSV_REG09D_LN_N	0x0674
+#define FSD_PCIE_PHY_TRSV_REG09E_LN_N	0x0678
+#define FSD_PCIE_PHY_TRSV_REG09F_LN_N	0x067c
+#define FSD_PCIE_PHY_TRSV_REG0A2_LN_N	0x0688
+#define FSD_PCIE_PHY_TRSV_REG0A4_LN_N	0x0690
+#define FSD_PCIE_PHY_TRSV_REG0CE_LN_N	0x0738
+#define FSD_PCIE_PHY_TRSV_REG0FC_LN_N	0x07f0
+#define FSD_PCIE_PHY_TRSV_REG0FD_LN_N	0x07f4
+#define FSD_PCIE_PHY_TRSV_REG0FE_LN_N	0x07f8
+#define FSD_PCIE_PHY_TRSV_REG0CE_LN_1	0x0b38
+#define FSD_PCIE_PHY_TRSV_REG0CE_LN_2	0x0f38
+#define FSD_PCIE_PHY_TRSV_REG0CE_LN_3	0x1338
+
+/* FSD: PCIe PCS registers */
+#define FSD_PCIE_PCS_BRF_0		0x0004
+#define FSD_PCIE_PCS_BRF_1		0x0804
+#define FSD_PCIE_PCS_CLK		0x0180
+
+/* FSD: PCIe SYSREG registers */
+#define FSD_PCIE_SYSREG_PHY_0_CON			0x042c
+#define FSD_PCIE_SYSREG_PHY_0_CON_MASK			0x03ff
+#define FSD_PCIE_SYSREG_PHY_0_REF_SEL			(0x2 << 0)
+#define FSD_PCIE_SYSREG_PHY_0_REF_SEL_MASK		0x3
+#define FSD_PCIE_SYSREG_PHY_0_AUX_EN			BIT(4)
+#define FSD_PCIE_SYSREG_PHY_0_CMN_RSTN			BIT(8)
+#define FSD_PCIE_SYSREG_PHY_0_INIT_RSTN			BIT(9)
+
+#define FSD_PCIE_SYSREG_PHY_1_CON			0x0500
+#define FSD_PCIE_SYSREG_PHY_1_CON_MASK			0x01ff
+#define FSD_PCIE_SYSREG_PHY_1_REF_SEL			(0x2 << 4)
+#define FSD_PCIE_SYSREG_PHY_1_REF_SEL_MASK		0x30
+#define FSD_PCIE_SYSREG_PHY_1_AUX_EN			BIT(0)
+#define FSD_PCIE_SYSREG_PHY_1_CMN_RSTN			BIT(1)
+#define FSD_PCIE_SYSREG_PHY_1_INIT_RSTN			BIT(3)
+
 /* For Exynos pcie phy */
 struct exynos_pcie_phy {
 	void __iomem *base;
+	void __iomem *pcs_base;
 	struct regmap *pmureg;
 	struct regmap *fsysreg;
 };
@@ -133,11 +229,200 @@ static const struct phy_ops exynos5433_phy_ops = {
 	.owner		= THIS_MODULE,
 };
 
+static void fsd_pcie_phy_writel(struct exynos_pcie_phy *phy_ctrl, u32 offset, u32 val)
+{
+	void __iomem *phy_base = phy_ctrl->base;
+	u32 i;
+
+	for (i = 0; i < FSD_PCIE_NUM_LANES; i++)
+		writel(val, phy_base + (offset + i * FSD_PCIE_LANE_OFFSET));
+}
+
+static int fsd_pcie_phy0_reset(struct phy *phy)
+{
+	struct exynos_pcie_phy *phy_ctrl = phy_get_drvdata(phy);
+
+	writel(0x1, phy_ctrl->pcs_base + FSD_PCIE_PCS_CLK);
+
+	regmap_update_bits(phy_ctrl->fsysreg, FSD_PCIE_SYSREG_PHY_0_CON,
+			FSD_PCIE_SYSREG_PHY_0_CON_MASK, 0x0);
+	regmap_update_bits(phy_ctrl->fsysreg, FSD_PCIE_SYSREG_PHY_0_CON,
+		FSD_PCIE_SYSREG_PHY_0_AUX_EN, FSD_PCIE_SYSREG_PHY_0_AUX_EN);
+	regmap_update_bits(phy_ctrl->fsysreg, FSD_PCIE_SYSREG_PHY_0_CON,
+		FSD_PCIE_SYSREG_PHY_0_REF_SEL_MASK, FSD_PCIE_SYSREG_PHY_0_REF_SEL);
+	regmap_update_bits(phy_ctrl->fsysreg, FSD_PCIE_SYSREG_PHY_0_CON,
+		FSD_PCIE_SYSREG_PHY_0_INIT_RSTN, FSD_PCIE_SYSREG_PHY_0_INIT_RSTN);
+
+	return 0;
+}
+
+static int fsd_pcie_phy1_reset(struct phy *phy)
+{
+	struct exynos_pcie_phy *phy_ctrl = phy_get_drvdata(phy);
+
+	writel(0x1, phy_ctrl->pcs_base + FSD_PCIE_PCS_CLK);
+
+	regmap_update_bits(phy_ctrl->fsysreg, FSD_PCIE_SYSREG_PHY_1_CON,
+			FSD_PCIE_SYSREG_PHY_1_CON_MASK, 0x0);
+	regmap_update_bits(phy_ctrl->fsysreg, FSD_PCIE_SYSREG_PHY_1_CON,
+		FSD_PCIE_SYSREG_PHY_1_AUX_EN, FSD_PCIE_SYSREG_PHY_1_AUX_EN);
+	regmap_update_bits(phy_ctrl->fsysreg, FSD_PCIE_SYSREG_PHY_1_CON,
+		FSD_PCIE_SYSREG_PHY_1_REF_SEL_MASK, FSD_PCIE_SYSREG_PHY_1_REF_SEL);
+	regmap_update_bits(phy_ctrl->fsysreg, FSD_PCIE_SYSREG_PHY_1_CON,
+		FSD_PCIE_SYSREG_PHY_1_INIT_RSTN, FSD_PCIE_SYSREG_PHY_1_INIT_RSTN);
+
+	return 0;
+}
+
+static int fsd_pcie_phy0_init(struct phy *phy)
+{
+	struct exynos_pcie_phy *phy_ctrl = phy_get_drvdata(phy);
+	void __iomem *pbase = phy_ctrl->base;
+
+	fsd_pcie_phy0_reset(phy);
+
+	writel(0x00, phy_ctrl->pcs_base + FSD_PCIE_PCS_BRF_0);
+	writel(0x00, phy_ctrl->pcs_base + FSD_PCIE_PCS_BRF_1);
+	writel(0x00, pbase + FSD_PCIE_PHY_AGG_BIF_RESET);
+	writel(0x00, pbase + FSD_PCIE_PHY_AGG_BIF_CLOCK);
+
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG07B_LN_N, 0x20);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG052_LN_N, 0x00);
+	writel(0x11, pbase + FSD_PCIE_PHY_TRSV_CMN_REG05F);
+	writel(0x23, pbase + FSD_PCIE_PHY_TRSV_CMN_REG060);
+	writel(0x0, pbase + FSD_PCIE_PHY_TRSV_CMN_REG062);
+	writel(0x15, pbase + FSD_PCIE_PHY_TRSV_CMN_REG03);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG0CE_LN_N, 0x8);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG039_LN_N, 0xf);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG03B_LN_N, 0x13);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG03C_LN_N, 0xf6);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG044_LN_N, 0x57);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG03E_LN_N, 0x10);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG03F_LN_N, 0x04);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG043_LN_N, 0x11);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG049_LN_N, 0x6f);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG04E_LN_N, 0x18);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG068_LN_N, 0x1f);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG069_LN_N, 0xc);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG06B_LN_N, 0x78);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG083_LN_N, 0xa);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG084_LN_N, 0x80);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG086_LN_N, 0xff);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG087_LN_N, 0x3c);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG09D_LN_N, 0x7c);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG09E_LN_N, 0x33);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG09F_LN_N, 0x33);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG001_LN_N, 0x3f);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG002_LN_N, 0x1c);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG005_LN_N, 0x2b);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG006_LN_N, 0x3);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG007_LN_N, 0x0c);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG009_LN_N, 0x10);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG00A_LN_N, 0x1);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG00C_LN_N, 0x93);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG012_LN_N, 0x1);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG013_LN_N, 0x0);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG014_LN_N, 0x70);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG015_LN_N, 0x0);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG016_LN_N, 0x70);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG0FC_LN_N, 0x80);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG0FD_LN_N, 0x0);
+
+	regmap_update_bits(phy_ctrl->fsysreg, FSD_PCIE_SYSREG_PHY_0_CON,
+		FSD_PCIE_SYSREG_PHY_0_CMN_RSTN, FSD_PCIE_SYSREG_PHY_0_CMN_RSTN);
+
+	return 0;
+}
+
+static int fsd_pcie_phy1_init(struct phy *phy)
+{
+	struct exynos_pcie_phy *phy_ctrl = phy_get_drvdata(phy);
+	void __iomem *pbase = phy_ctrl->base;
+
+	fsd_pcie_phy1_reset(phy);
+
+	writel(0x2, pbase + FSD_PCIE_PHY_CMN_RESET);
+
+	writel(0x00, phy_ctrl->pcs_base + FSD_PCIE_PCS_BRF_0);
+	writel(0x00, phy_ctrl->pcs_base + FSD_PCIE_PCS_BRF_1);
+	writel(0x00, pbase + FSD_PCIE_PHY_AGG_BIF_RESET);
+	writel(0x00, pbase + FSD_PCIE_PHY_AGG_BIF_CLOCK);
+
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG07B_LN_N, 0x20);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG052_LN_N, 0x00);
+	writel(0xaa, pbase + FSD_PCIE_PHY_TRSV_CMN_REG01E);
+	writel(0x28, pbase + FSD_PCIE_PHY_TRSV_CMN_REG02D);
+	writel(0x28, pbase + FSD_PCIE_PHY_TRSV_CMN_REG031);
+	writel(0x21, pbase + FSD_PCIE_PHY_TRSV_CMN_REG036);
+	writel(0x12, pbase + FSD_PCIE_PHY_TRSV_CMN_REG05F);
+	writel(0x23, pbase + FSD_PCIE_PHY_TRSV_CMN_REG060);
+	writel(0x0, pbase + FSD_PCIE_PHY_TRSV_CMN_REG061);
+	writel(0x0, pbase + FSD_PCIE_PHY_TRSV_CMN_REG062);
+	writel(0x15, pbase + FSD_PCIE_PHY_TRSV_CMN_REG03);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG039_LN_N, 0xf);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG03B_LN_N, 0x13);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG03C_LN_N, 0x66);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG044_LN_N, 0x57);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG03E_LN_N, 0x10);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG03F_LN_N, 0x44);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG043_LN_N, 0x11);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG046_LN_N, 0xef);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG048_LN_N, 0x06);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG049_LN_N, 0xaf);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG04E_LN_N, 0x28);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG068_LN_N, 0x1f);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG069_LN_N, 0xc);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG06A_LN_N, 0x8);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG06B_LN_N, 0x78);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG083_LN_N, 0xa);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG084_LN_N, 0x80);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG087_LN_N, 0x30);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG08B_LN_N, 0xa0);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG09C_LN_N, 0xf7);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG09E_LN_N, 0x33);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG0A2_LN_N, 0xfa);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG0A4_LN_N, 0xf2);
+	writel(0x8, pbase + FSD_PCIE_PHY_TRSV_REG0CE_LN_N);
+	writel(0x9, pbase + FSD_PCIE_PHY_TRSV_REG0CE_LN_1);
+	writel(0x9, pbase + FSD_PCIE_PHY_TRSV_REG0CE_LN_2);
+	writel(0x9, pbase + FSD_PCIE_PHY_TRSV_REG0CE_LN_3);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG0FE_LN_N, 0x33);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG001_LN_N, 0x3f);
+	fsd_pcie_phy_writel(phy_ctrl, FSD_PCIE_PHY_TRSV_REG005_LN_N, 0x2b);
+
+	writel(0x3, pbase + FSD_PCIE_PHY_CMN_RESET);
+
+	regmap_update_bits(phy_ctrl->fsysreg, FSD_PCIE_SYSREG_PHY_1_CON,
+		FSD_PCIE_SYSREG_PHY_1_CMN_RSTN, FSD_PCIE_SYSREG_PHY_1_CMN_RSTN);
+
+	return 0;
+}
+
+static const struct phy_ops fsd_phy0_ops = {
+	.init		= fsd_pcie_phy0_init,
+	.reset		= fsd_pcie_phy0_reset,
+	.owner		= THIS_MODULE,
+};
+
+static const struct phy_ops fsd_phy1_ops = {
+	.init		= fsd_pcie_phy1_init,
+	.reset		= fsd_pcie_phy1_reset,
+	.owner		= THIS_MODULE,
+};
+
 static const struct of_device_id exynos_pcie_phy_match[] = {
 	{
 		.compatible = "samsung,exynos5433-pcie-phy",
 		.data = &exynos5433_phy_ops,
 	},
+	{
+		.compatible = "tesla,fsd-pcie-phy0",
+		.data = &fsd_phy0_ops,
+	},
+	{
+		.compatible = "tesla,fsd-pcie-phy1",
+		.data = &fsd_phy1_ops,
+	},
 	{},
 };
 
@@ -181,6 +466,8 @@ static int exynos_pcie_phy_probe(struct platform_device *pdev)
 		return PTR_ERR(generic_phy);
 	}
 
+	exynos_phy->pcs_base = devm_platform_ioremap_resource(pdev, 1);
+
 	phy_set_drvdata(generic_phy, exynos_phy);
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
 
-- 
2.49.0


