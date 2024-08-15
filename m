Return-Path: <linux-pci+bounces-11726-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11021953DB5
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 00:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6342BB26472
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 22:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6BE156C72;
	Thu, 15 Aug 2024 22:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TP08sGAM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF83915B140
	for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 22:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723762688; cv=none; b=MU2KWYAx03WhIDqtv4V6T4qRQVckoiLvwF3GftpFhdrEUp8jkglgG3zYqFwLbjJbL0OKJY/SoUWCqY+jYZ0jR2WIxQSPvcE0PH4BlZCViqzlvKVv4ZacUUNQn4+v3iyyWXzvy0w4UF9bHb4YwNS9w1xtgNQT/QSbnto6maH7c2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723762688; c=relaxed/simple;
	bh=8zgVOFnf//yDrO4FbJegdLa4h3V40iTv0OWSjRYQzPo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SXm792JC/3aJoCIx9DCzllKqcASCqSPherfTG2jmp1MsOpt3Zoz9a5/19Z1HG/pp/PyEKk6gvb1l3lHd+wdQkeLU8v9hTB9gZUSu76mFSY+Cr9X7LUEIY41pnQW1a80APp0qBaAdMrvNffIMPQws0Yr380LGnFrnrmg7ry7qVt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TP08sGAM; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fc692abba4so12204645ad.2
        for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 15:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723762686; x=1724367486; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B0X1wn9NMaiuQrJz2MlOiOWSzcZgLEDGUdh3XvBe1/A=;
        b=TP08sGAM1o439gyKkkc3oCXkwDDPHpLG39DKdibiwACY9SCsLuKuxS3omYWLHuVqH/
         gGAu2OnXAKy022CU7wxMksrm0zXQK9JIHV8v351yh70NkJVjk5+JQQ9b1rrJwVHZ9pRe
         1Asv/rCPCSZ6D8nM7gjXJfIjmGzbc4p8i1UCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723762686; x=1724367486;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B0X1wn9NMaiuQrJz2MlOiOWSzcZgLEDGUdh3XvBe1/A=;
        b=ZsTYAul1781K6QV09oBENIc5Jx1oZeANSUJLFsbUDRr0ChWwS6Tlq7eHRfJP6PX4JZ
         vpFGIEAZ1ZXCdznyqE74P06QYLkoHOa4ukf68zroUNsMvhPDVeBm4PJzR17nbdOVWYRS
         7rmb50gIWhgBwnDE2pX1XJlZoBUfybx6RIKutaFu3eTTlgY+S9VvpvHeVBa4+0Z2VQLd
         aLdE/5WsIEWMbHo7ngGEVVMpf6xLf0U8wQSNIis30v4tncHJIYpLoc6cF3p28oqf/zdu
         c+PyeEpTe6snqwaXC/LI6kqPfdu9VapekWxTcIaAsuZPWOu4X036N8G14DIszv/kWp8t
         9yyA==
X-Gm-Message-State: AOJu0Yxe2jmqZRAk72pOj02RyPUJ0o9jFsycDuNX+llQEt+PG1+Fk1Wk
	wac9D8fMHy07VdyR5FRgMuHCs2EfMje/fq2kYnCWnYH1qiD6WYrQFgAo8acn7XOlNebE6YfpDvy
	RaOpgOzMK7TVFBmSnkWSzuJ2+vuaY3zu90eRxDatBQ6c0IzmvMvFjftsrlogz8KIgvyB4nntCxL
	eh0Sa6hDfdAqH5o/KHd641GjplAbEmN+CgEpPjli989fDbkQ==
X-Google-Smtp-Source: AGHT+IEGn/rCG97NahVwT/mQs4TqVzkFRTUgFUvrLGVXrwglBEYFVn1dhN6p57opZidOhlSTfzh6dQ==
X-Received: by 2002:a17:90b:4b02:b0:2cb:5134:562a with SMTP id 98e67ed59e1d1-2d3dfc2402fmr1371267a91.7.1723762685606;
        Thu, 15 Aug 2024 15:58:05 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2e6b2d1sm373997a91.18.2024.08.15.15.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 15:58:05 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 07/13] PCI: brcmstb: PCI: brcmstb: Make HARD_DEBUG, INTR2_CPU_BASE offsets SoC-specific
Date: Thu, 15 Aug 2024 18:57:20 -0400
Message-Id: <20240815225731.40276-8-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240815225731.40276-1-james.quinlan@broadcom.com>
References: <20240815225731.40276-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Do prepatory work for the 7712 SoC, which is introduced in a future commit.
Our HW design has changed two register offsets for the 7712, where
previously it was a common value for all Broadcom SOCs with PCIe cores.
Specifically, the two offsets are to the registers HARD_DEBUG and
INTR2_CPU_BASE.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/pcie-brcmstb.c | 39 ++++++++++++++++-----------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index aa21c4c7b7f7..1444f2a9c21e 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -122,7 +122,6 @@
 #define PCIE_MEM_WIN0_LIMIT_HI(win)	\
 		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI + ((win) * 8)
 
-#define PCIE_MISC_HARD_PCIE_HARD_DEBUG					0x4204
 #define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK	0x2
 #define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_ENABLE_MASK		0x200000
 #define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK		0x08000000
@@ -131,9 +130,9 @@
 	  (PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK | \
 	   PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_ENABLE_MASK)
 
-#define PCIE_INTR2_CPU_BASE		0x4300
 #define PCIE_MSI_INTR2_BASE		0x4500
-/* Offsets from PCIE_INTR2_CPU_BASE and PCIE_MSI_INTR2_BASE */
+
+/* Offsets from INTR2_CPU and MSI_INTR2 BASE offsets */
 #define  MSI_INT_STATUS			0x0
 #define  MSI_INT_CLR			0x8
 #define  MSI_INT_MASK_SET		0x10
@@ -184,9 +183,11 @@
 #define SSC_STATUS_PLL_LOCK_MASK	0x800
 #define PCIE_BRCM_MAX_MEMC		3
 
-#define IDX_ADDR(pcie)			(pcie->reg_offsets[EXT_CFG_INDEX])
-#define DATA_ADDR(pcie)			(pcie->reg_offsets[EXT_CFG_DATA])
-#define PCIE_RGR1_SW_INIT_1(pcie)	(pcie->reg_offsets[RGR1_SW_INIT_1])
+#define IDX_ADDR(pcie)			((pcie)->reg_offsets[EXT_CFG_INDEX])
+#define DATA_ADDR(pcie)			((pcie)->reg_offsets[EXT_CFG_DATA])
+#define PCIE_RGR1_SW_INIT_1(pcie)	((pcie)->reg_offsets[RGR1_SW_INIT_1])
+#define HARD_DEBUG(pcie)		((pcie)->reg_offsets[PCIE_HARD_DEBUG])
+#define INTR2_CPU_BASE(pcie)		((pcie)->reg_offsets[PCIE_INTR2_CPU_BASE])
 
 /* Rescal registers */
 #define PCIE_DVT_PMU_PCIE_PHY_CTRL				0xc700
@@ -205,6 +206,8 @@ enum {
 	RGR1_SW_INIT_1,
 	EXT_CFG_INDEX,
 	EXT_CFG_DATA,
+	PCIE_HARD_DEBUG,
+	PCIE_INTR2_CPU_BASE,
 };
 
 enum {
@@ -651,7 +654,7 @@ static int brcm_pcie_enable_msi(struct brcm_pcie *pcie)
 	BUILD_BUG_ON(BRCM_INT_PCI_MSI_LEGACY_NR > BRCM_INT_PCI_MSI_NR);
 
 	if (msi->legacy) {
-		msi->intr_base = msi->base + PCIE_INTR2_CPU_BASE;
+		msi->intr_base = msi->base + INTR2_CPU_BASE(pcie);
 		msi->nr = BRCM_INT_PCI_MSI_LEGACY_NR;
 		msi->legacy_shift = 24;
 	} else {
@@ -898,12 +901,12 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	/* Take the bridge out of reset */
 	pcie->bridge_sw_init_set(pcie, 0);
 
-	tmp = readl(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
+	tmp = readl(base + HARD_DEBUG(pcie));
 	if (is_bmips(pcie))
 		tmp &= ~PCIE_BMIPS_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK;
 	else
 		tmp &= ~PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK;
-	writel(tmp, base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
+	writel(tmp, base + HARD_DEBUG(pcie));
 	/* Wait for SerDes to be stable */
 	usleep_range(100, 200);
 
@@ -1072,7 +1075,7 @@ static void brcm_config_clkreq(struct brcm_pcie *pcie)
 	}
 
 	/* Start out assuming safe mode (both mode bits cleared) */
-	clkreq_cntl = readl(pcie->base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
+	clkreq_cntl = readl(pcie->base + HARD_DEBUG(pcie));
 	clkreq_cntl &= ~PCIE_CLKREQ_MASK;
 
 	if (strcmp(mode, "no-l1ss") == 0) {
@@ -1115,7 +1118,7 @@ static void brcm_config_clkreq(struct brcm_pcie *pcie)
 			dev_err(pcie->dev, err_msg);
 		mode = "safe";
 	}
-	writel(clkreq_cntl, pcie->base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
+	writel(clkreq_cntl, pcie->base + HARD_DEBUG(pcie));
 
 	dev_info(pcie->dev, "clkreq-mode set to %s\n", mode);
 }
@@ -1337,9 +1340,9 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
 	writel(tmp, base + PCIE_MISC_PCIE_CTRL);
 
 	/* Turn off SerDes */
-	tmp = readl(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
+	tmp = readl(base + HARD_DEBUG(pcie));
 	u32p_replace_bits(&tmp, 1, PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK);
-	writel(tmp, base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
+	writel(tmp, base + HARD_DEBUG(pcie));
 
 	/* Shutdown PCIe bridge */
 	pcie->bridge_sw_init_set(pcie, 1);
@@ -1425,9 +1428,9 @@ static int brcm_pcie_resume_noirq(struct device *dev)
 	pcie->bridge_sw_init_set(pcie, 0);
 
 	/* SERDES_IDDQ = 0 */
-	tmp = readl(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
+	tmp = readl(base + HARD_DEBUG(pcie));
 	u32p_replace_bits(&tmp, 0, PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK);
-	writel(tmp, base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
+	writel(tmp, base + HARD_DEBUG(pcie));
 
 	/* wait for serdes to be stable */
 	udelay(100);
@@ -1499,12 +1502,16 @@ static const int pcie_offsets[] = {
 	[RGR1_SW_INIT_1] = 0x9210,
 	[EXT_CFG_INDEX]  = 0x9000,
 	[EXT_CFG_DATA]   = 0x9004,
+	[PCIE_HARD_DEBUG] = 0x4204,
+	[PCIE_INTR2_CPU_BASE] = 0x4300,
 };
 
 static const int pcie_offsets_bmips_7425[] = {
 	[RGR1_SW_INIT_1] = 0x8010,
 	[EXT_CFG_INDEX]  = 0x8300,
 	[EXT_CFG_DATA]   = 0x8304,
+	[PCIE_HARD_DEBUG] = 0x4204,
+	[PCIE_INTR2_CPU_BASE] = 0x4300,
 };
 
 static const struct pcie_cfg_data generic_cfg = {
@@ -1539,6 +1546,8 @@ static const int pcie_offset_bcm7278[] = {
 	[RGR1_SW_INIT_1] = 0xc010,
 	[EXT_CFG_INDEX] = 0x9000,
 	[EXT_CFG_DATA] = 0x9004,
+	[PCIE_HARD_DEBUG] = 0x4204,
+	[PCIE_INTR2_CPU_BASE] = 0x4300,
 };
 
 static const struct pcie_cfg_data bcm7278_cfg = {
-- 
2.17.1


