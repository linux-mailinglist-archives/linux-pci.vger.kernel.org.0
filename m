Return-Path: <linux-pci+bounces-10410-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFA693339F
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 23:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6186B237FF
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 21:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153AA1448F2;
	Tue, 16 Jul 2024 21:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NpfuGIVt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796A2144D21
	for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 21:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721165523; cv=none; b=KDnU1f32B+25J9/6froHUU6WQ57dQorOkM3opcXo7k2rqztqZ2IXnLaOHakF1fplfeOsAnJJjiDLCfikkIFIlANwKpQ/koT+jhTwDMrpKxn7rvL5iR0WcmIEw76YalJNr2QyltQxMcqbLOLb4v+pcX0Zerw8n157tK0kif6tzGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721165523; c=relaxed/simple;
	bh=mGZw0GnMIITmhN9sV017/Px1pHC3gfpN1Q17tjvNzi4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type; b=D+mhULYMOLSFX1i25pex1Btb5R5y/P3qKHP7ytShdnnNziLCR/oNnSXWaNgJdnqt3xy3papVbuEDAFnkTRxROWqU56ayI03OfX+jhB4C3mg0bBYISyZiadsbYfSRjsvMnvLhnc7xjrAh8iGB9Wf8XPKYfyAA2Q5jGLbBRt6hb/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NpfuGIVt; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70b703eda27so2753909b3a.3
        for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 14:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1721165520; x=1721770320; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+CT/8sh6Sx20eFyhLTxzwzht5rbY+Mj7TPohRSFW5t8=;
        b=NpfuGIVtyLGejzdwD1A0Q5BfXjlssaJNFlp+mHekC3mvI2NfSlcYGNCErJaXi/DR+i
         jS5F/mahp5RJezBwNRnRRv/OkX/x7hvdvA3wW53385f38+JQDORT1byeDILaMB7kMV9X
         nnb3f8HcdRSD46QsGUKkFjrjDUpcqZ9u9cDT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721165520; x=1721770320;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+CT/8sh6Sx20eFyhLTxzwzht5rbY+Mj7TPohRSFW5t8=;
        b=Xxbg/DEbmTn4bc/qyXvzaAHK6laOxH+UtZJcEaYZbr6LX1Dlsl+I1ceShrLY8EJthL
         6X3Oa+Nav6vyJuGRGQEkxNAgdCX06qLwtB35JcYUxhP42V0ey7tu2Q1T+vgOeQifev1u
         TNu/GvyQ6cHx4Wa6ElSo0/LziBc7CtQlsYsbTkwjzUhL/yDPoWrlDF1RNrpB+8eef1kq
         6w1rJXYAMSXho6/rhwjE8O9W6sDCv6idyPdyB7bvM/QE3uIWTLw///OW+8Rs9mVfJ6fZ
         fD1SC6tPqWHNorATAwHthbvUE/uX7VpQnxWp7QjolO94P+sS4QYRgmy5jS66P187I4xp
         KSjQ==
X-Gm-Message-State: AOJu0YxZ3JeBP3cG67/OZf1VpntZNjpySvTWW3NYDfQDtsjXZNMjhzvS
	l18SsXOKS+UtZ0LeKJYkgldPy+2ImWNseiTsi8KwsGQO1IjTLGw0izS2c4WildjMI2rd8s5Xxpl
	gKcvKXl6G1z3rfiV9nCpRRBtJtRYNViY+2Q3HZiMUAjorz4ebSJ4U0zC4KCtE2AuaQOZ6AV1hUc
	cz1zqFSxNihmKNp2OYGo6eTZrcjeMaOoATcNEV+7WZRtsxpQ==
X-Google-Smtp-Source: AGHT+IHSYiDtAOt6vkPiOmOGzoCjlK8JNJow6N9e9x7/paF1mesMY/nehkea9fDquwFmwcedQMkkSQ==
X-Received: by 2002:a05:6a00:138b:b0:705:c0a1:61c9 with SMTP id d2e1a72fcca58-70c1fb9162bmr4131254b3a.9.1721165520137;
        Tue, 16 Jul 2024 14:32:00 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eb9e20fsm6812828b3a.31.2024.07.16.14.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 14:31:59 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
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
Subject: [PATCH v4 06/12] PCI: brcmstb: PCI: brcmstb: Make HARD_DEBUG, INTR2_CPU_BASE offsets SoC-specific
Date: Tue, 16 Jul 2024 17:31:21 -0400
Message-Id: <20240716213131.6036-7-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240716213131.6036-1-james.quinlan@broadcom.com>
References: <20240716213131.6036-1-james.quinlan@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000007799ac061d6413b5"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

--0000000000007799ac061d6413b5

Our HW design has again changed a register offset which used to be standard
for all Broadcom SOCs with PCIe cores.  This difference is now reconciled
for the registers HARD_DEBUG and INTR2_CPU_BASE.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 39 ++++++++++++++++-----------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 4dc2ff7f3167..073d790d97b7 100644
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


--0000000000007799ac061d6413b5
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mOAplh6h3nMZUZxBguxG3g2p3iD4EgibUYneEzqOQafIQB/naf2uetKb8y9jKgWJxq2Y4y8Jqg2u
uVIO1AyOJjWwqdgN+QhuIlat+qZd03P48Gim9ZPEMDUCAwEAAaOCAdswggHXMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJQYDVR0R
BB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYD
VR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFGx/E27aeGBP2eJktrILxlhK
z8f6MA0GCSqGSIb3DQEBCwUAA4IBAQBdQQukiELsPfse49X4QNy/UN43dPUw0I1asiQ8wye3nAuD
b3GFmf3SZKlgxBTdWJoaNmmUFW2H3HWOoQBnTeedLtV9M2Tb9vOKMncQD1f9hvWZR6LnZpjBIlKe
+R+v6CLF07qYmBI6olvOY/Rsv9QpW9W8qZYk+2RkWHz/fR5N5YldKlJHP0NDT4Wjc5fEzV+mZC8A
AlT80qiuCVv+IQP08ovEVSLPhUp8i1pwsHT9atbWOfXQjbq1B/ditFIbPzwmwJPuGUc7n7vpmtxB
75sSFMj27j4JXl5W9vORgHR2YzuPBzfzDJU1ul0DIofSWVF6E1dx4tZohRED1Yl/T/ZGMYICbTCC
AmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UE
AxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMSO43VW7D5NP1X/KD
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDFX3KwOcEa/yfeje4fI4wEEwE6xVEV
CYMJMhkvs/84njAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA3
MTYyMTMyMDBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAZkZn5QPx+eRYFZS4PG2TCyllIOhOqXfR0vRLQzsIpr1iSGIt
wikd8vc715a/mmXh3e0Op+zakatYnI5u2qCSjqhn0FEnVhpJbY/ItmTZ2FqnB1Q26sd2WwuWkORC
bOpWgHODts92f9Rh1clHjVRkRAGVXfAgEKuu3krNIO95gsl4FuUDK013rHe+bFY/dz15QNvqcl2J
+KKYgmkyoT75smHrUzkbiON+pmJWixQ3BmcAtWeXMSiCjE2EKUPG//3z8ZAHbW7QxPhRWWAxagiU
8z00pCgg2jfR2N0eswIgu/3+Sb7DouBcf0++6vahpS5oRiJuK3SxukuHM2rWs7hj+g==
--0000000000007799ac061d6413b5--

