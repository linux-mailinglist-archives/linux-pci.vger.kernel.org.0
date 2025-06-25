Return-Path: <linux-pci+bounces-30678-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDE9AE9443
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 04:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00E683B79E8
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 02:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAACA232367;
	Thu, 26 Jun 2025 02:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KalJDQIK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63E4230D0E
	for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 02:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750905475; cv=none; b=gM6XSy72Z6pqpxCXJeSPqzbkN2Uw1GW3zXT9P7BieaXtLyMN5Wsy9mO7740War06g03Cknw0y7ZKyy3smT0I+HAZVnzwBS5xMQ16Vr/PH6lv2BiRoJ9jpbTKiUEgPNXJsq+khL+UA/sT2VKotLey7HCXw73W9JewAbPqLODxLWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750905475; c=relaxed/simple;
	bh=Wbc2+RfHeqtmOeNADPHwurzKqcvE/S8J8bwJ7a+PLJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=NjLZvJTidzVkrdmXDToquJiccRTRcdAAbTnP05PIsZkgsR4BSB84NadhcX0g7MO5jCYJh1XBmHA1gEgPufzROrx8DO/JWAinNGGrPiNgFiCfCMs9xotVq/StM8rdz3KN4SkTlWS++AC8JJHbN8Pih9mHEzsvMlqvh2awOoNKv4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=KalJDQIK; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250626023748epoutp03f5e7ceea6bfd4d29a3446f90cd1d9eb0~Mdz83IM1f1724017240epoutp03e
	for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 02:37:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250626023748epoutp03f5e7ceea6bfd4d29a3446f90cd1d9eb0~Mdz83IM1f1724017240epoutp03e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750905468;
	bh=hypIB6EeD7SA8ky1sUTiu7LEMiY1BgdF3951Sy1jLbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KalJDQIKs0mkAjI9/GLSiQTCM/NIYI06ARc5vL3yxHORVarCpWSKjBF7QHL+lFMCd
	 AZ5xSRu9dzSFo9Gg3IVdUA1SP1zy91F5GqdDmSQpBgZB9leVXAO8spwnG2b14dx8fc
	 EKASEqBUh9YiHTfDsAU8JFHQ7FZ6gMEK8TeInJUc=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250626023747epcas5p39892427826074d8057a24e5353deb00a~Mdz8CAyNL2141821418epcas5p3s;
	Thu, 26 Jun 2025 02:37:47 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.181]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4bSNBx75T8z2SSKd; Thu, 26 Jun
	2025 02:37:45 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250625165323epcas5p44d291cb0b46df7e015907e4c2903447f~MV1sCqbbU2145921459epcas5p4T;
	Wed, 25 Jun 2025 16:53:23 +0000 (GMT)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250625165320epsmtip2624f6329040ec6dc48d1bd48c57e56c9~MV1pSM69W1746917469epsmtip2Y;
	Wed, 25 Jun 2025 16:53:20 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-fsd@tesla.com
Cc: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
	vkoul@kernel.org, kishon@kernel.org, arnd@arndb.de,
	m.szyprowski@samsung.com, jh80.chung@samsung.com, pankaj.dubey@samsung.com,
	Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH v2 08/10] phy: exynos: Add PCIe PHY support for FSD SoC
Date: Wed, 25 Jun 2025 22:22:27 +0530
Message-ID: <20250625165229.3458-9-shradha.t@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250625165229.3458-1-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250625165323epcas5p44d291cb0b46df7e015907e4c2903447f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250625165323epcas5p44d291cb0b46df7e015907e4c2903447f
References: <20250625165229.3458-1-shradha.t@samsung.com>
	<CGME20250625165323epcas5p44d291cb0b46df7e015907e4c2903447f@epcas5p4.samsung.com>

Add PCIe PHY support for Tesla FSD SoC.

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/phy/samsung/phy-exynos-pcie.c | 317 +++++++++++++++++++++++++-
 1 file changed, 316 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/samsung/phy-exynos-pcie.c b/drivers/phy/samsung/phy-exynos-pcie.c
index 53c9230c2907..001a49bde2f4 100644
--- a/drivers/phy/samsung/phy-exynos-pcie.c
+++ b/drivers/phy/samsung/phy-exynos-pcie.c
@@ -34,11 +34,113 @@
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
+	int phy_id;
+	const struct samsung_drv_data *drv_data;
+};
+
+struct samsung_drv_data {
+	const struct phy_ops *phy_ops;
 };
 
 static void exynos_pcie_phy_writel(void __iomem *base, u32 val, u32 offset)
@@ -133,9 +235,212 @@ static const struct phy_ops exynos5433_phy_ops = {
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
+struct fsd_pcie_phy_pdata {
+	u32 phy_con_offset;
+	u32 phy_con_mask;
+	u32 phy_ref_sel;
+	u32 phy_ref_sel_mask;
+	u32 phy_aux_en;
+	u32 phy_cmn_rstn;
+	u32 phy_init_rstn;
+};
+
+static const struct fsd_pcie_phy_pdata fsd_phy_con[] = {
+{
+	.phy_con_offset		= FSD_PCIE_SYSREG_PHY_0_CON,
+	.phy_con_mask		= FSD_PCIE_SYSREG_PHY_0_CON_MASK,
+	.phy_ref_sel		= FSD_PCIE_SYSREG_PHY_0_REF_SEL,
+	.phy_ref_sel_mask	= FSD_PCIE_SYSREG_PHY_0_REF_SEL_MASK,
+	.phy_aux_en		= FSD_PCIE_SYSREG_PHY_0_AUX_EN,
+	.phy_cmn_rstn		= FSD_PCIE_SYSREG_PHY_0_CMN_RSTN,
+	.phy_init_rstn		= FSD_PCIE_SYSREG_PHY_0_INIT_RSTN,
+	},
+	{
+	.phy_con_offset		= FSD_PCIE_SYSREG_PHY_1_CON,
+	.phy_con_mask		= FSD_PCIE_SYSREG_PHY_1_CON_MASK,
+	.phy_ref_sel		= FSD_PCIE_SYSREG_PHY_1_REF_SEL,
+	.phy_ref_sel_mask	= FSD_PCIE_SYSREG_PHY_1_REF_SEL_MASK,
+	.phy_aux_en		= FSD_PCIE_SYSREG_PHY_1_AUX_EN,
+	.phy_cmn_rstn		= FSD_PCIE_SYSREG_PHY_1_CMN_RSTN,
+	.phy_init_rstn		= FSD_PCIE_SYSREG_PHY_1_INIT_RSTN,
+	},
+	{ },
+};
+
+static int fsd_pcie_phy_reset(struct phy *phy)
+{
+	struct exynos_pcie_phy *phy_ctrl = phy_get_drvdata(phy);
+	const struct fsd_pcie_phy_pdata *pdata = &fsd_phy_con[phy_ctrl->phy_id];
+
+	writel(0x1, phy_ctrl->pcs_base + FSD_PCIE_PCS_CLK);
+
+	regmap_update_bits(phy_ctrl->fsysreg, pdata->phy_con_offset,
+			pdata->phy_con_mask, 0x0);
+	regmap_update_bits(phy_ctrl->fsysreg, pdata->phy_con_offset,
+			pdata->phy_aux_en, pdata->phy_aux_en);
+	regmap_update_bits(phy_ctrl->fsysreg, pdata->phy_con_offset,
+			pdata->phy_ref_sel_mask, pdata->phy_ref_sel);
+	/* perform init reset release */
+	regmap_update_bits(phy_ctrl->fsysreg, pdata->phy_con_offset,
+			pdata->phy_init_rstn, pdata->phy_init_rstn);
+
+	return 0;
+}
+
+static void fsd_pcie_phy1_init(struct exynos_pcie_phy *phy_ctrl)
+{
+	void __iomem *pbase = phy_ctrl->base;
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
+}
+
+static void fsd_pcie_phy0_init(struct exynos_pcie_phy *phy_ctrl)
+{
+	void __iomem *pbase = phy_ctrl->base;
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
+}
+
+static int fsd_pcie_phy_init(struct phy *phy)
+{
+	struct exynos_pcie_phy *phy_ctrl = phy_get_drvdata(phy);
+	void __iomem *phy_base = phy_ctrl->base;
+	const struct fsd_pcie_phy_pdata *pdata = &fsd_phy_con[phy_ctrl->phy_id];
+
+	fsd_pcie_phy_reset(phy);
+
+	if (phy_ctrl->phy_id == 1)
+		writel(0x2, phy_base + FSD_PCIE_PHY_CMN_RESET);
+
+	writel(0x00, phy_ctrl->pcs_base + FSD_PCIE_PCS_BRF_0);
+	writel(0x00, phy_ctrl->pcs_base + FSD_PCIE_PCS_BRF_1);
+	writel(0x00, phy_base + FSD_PCIE_PHY_AGG_BIF_RESET);
+	writel(0x00, phy_base + FSD_PCIE_PHY_AGG_BIF_CLOCK);
+
+	if (phy_ctrl->phy_id == 1) {
+		fsd_pcie_phy1_init(phy_ctrl);
+		writel(0x3, phy_base + FSD_PCIE_PHY_CMN_RESET);
+	} else {
+		fsd_pcie_phy0_init(phy_ctrl);
+	}
+
+	regmap_update_bits(phy_ctrl->fsysreg, pdata->phy_con_offset,
+			pdata->phy_cmn_rstn, pdata->phy_cmn_rstn);
+
+	return 0;
+}
+
+static const struct phy_ops fsd_phy_ops = {
+	.init		= fsd_pcie_phy_init,
+	.reset		= fsd_pcie_phy_reset,
+	.owner		= THIS_MODULE,
+};
+
+static const struct samsung_drv_data exynos5433_drv_data = {
+	.phy_ops		= &exynos5433_phy_ops,
+};
+
+static const struct samsung_drv_data fsd_drv_data = {
+	.phy_ops		= &fsd_phy_ops,
+};
+
 static const struct of_device_id exynos_pcie_phy_match[] = {
 	{
 		.compatible = "samsung,exynos5433-pcie-phy",
+		.data = &exynos5433_drv_data,
+	},
+	{
+		.compatible = "tesla,fsd-pcie-phy",
+		.data = &fsd_drv_data,
 	},
 	{},
 };
@@ -146,11 +451,18 @@ static int exynos_pcie_phy_probe(struct platform_device *pdev)
 	struct exynos_pcie_phy *exynos_phy;
 	struct phy *generic_phy;
 	struct phy_provider *phy_provider;
+	const struct samsung_drv_data *drv_data;
+
+	drv_data = of_device_get_match_data(dev);
+	if (!drv_data)
+		return -ENODEV;
 
 	exynos_phy = devm_kzalloc(dev, sizeof(*exynos_phy), GFP_KERNEL);
 	if (!exynos_phy)
 		return -ENOMEM;
 
+	exynos_phy->drv_data = drv_data;
+
 	exynos_phy->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(exynos_phy->base))
 		return PTR_ERR(exynos_phy->base);
@@ -169,12 +481,15 @@ static int exynos_pcie_phy_probe(struct platform_device *pdev)
 		return PTR_ERR(exynos_phy->fsysreg);
 	}
 
-	generic_phy = devm_phy_create(dev, dev->of_node, &exynos5433_phy_ops);
+	generic_phy = devm_phy_create(dev, dev->of_node, drv_data->phy_ops);
 	if (IS_ERR(generic_phy)) {
 		dev_err(dev, "failed to create PHY\n");
 		return PTR_ERR(generic_phy);
 	}
 
+	exynos_phy->pcs_base = devm_platform_ioremap_resource(pdev, 1);
+
+	exynos_phy->phy_id = of_alias_get_id(dev->of_node, "pciephy");
 	phy_set_drvdata(generic_phy, exynos_phy);
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
 
-- 
2.49.0


