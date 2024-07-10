Return-Path: <linux-pci+bounces-10117-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 514C692DBC7
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 00:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C00671F2211D
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 22:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC25158D7B;
	Wed, 10 Jul 2024 22:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dYtUicoZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459F8156993
	for <linux-pci@vger.kernel.org>; Wed, 10 Jul 2024 22:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720649807; cv=none; b=XD/EdRH34vqIk0+0lp9sMm8Bpng+7XzvvK+zRDBp6v4IbkxrYGjCEZEioMECKoJBB2ul7RGyhNWpky2997OaF2wrNeaiCLsG+f937ihajBBIZtVbnsbhuo8rdZ3FJWoX5bUp8VIxtM9mXRQ/9CSA+IAPi662/fW++bWIxFMKcEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720649807; c=relaxed/simple;
	bh=nXZk5iKWHssetGgmTmUwwTsYquF42OQQlrzYIQ7c7uI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type; b=jh+FU+/JoxPcMYqDR8rJCD1/z7Rp613J5hRdeGbzGjrBuF7po5/i5OaIwcYr37P1PHXQkdFuKGl8f8R5NUH7p9XADPVbX4BpeD42nW4MXBvdPSOpJfe7Xb+woRLz8pIngQO3ipDJFofgammZdfN0d8OVza/FrBmKCEdFeNEs+gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dYtUicoZ; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b5db7936b3so1703466d6.1
        for <linux-pci@vger.kernel.org>; Wed, 10 Jul 2024 15:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720649804; x=1721254604; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c5Ypsy6QKsJO+O9NU2y5VaqWfAYoMKveZc0mAKXXp+Y=;
        b=dYtUicoZQSh1TjEoBa7PZsRhGPGyGnMDYOhFQtZgcQjVWmwTsTKtafz17PRpQ6jmZ/
         wntKmlgTEscAs/KgA4utgb1ii+7//j4Yta+y1H9nRLVBev1zk8rkmrNUFWs6mBCQ7teg
         PcS7HT/53XTmuLz8eA2I7zcoqUC0wjswYTVmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720649804; x=1721254604;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c5Ypsy6QKsJO+O9NU2y5VaqWfAYoMKveZc0mAKXXp+Y=;
        b=uEB6MLVikWtX9YjtFm/k5+tXNXux+BK35dYUoP+cX4BipGwcy/VEak8vFihvjiCfmq
         l6hOUr0NewAJkhlxAKpXXDW5H0Gxb+pGVbEtwUaiCLlk2yEY8lPNSH8wmtLoazShaUTP
         7rTPfRX1hPAzaNI1IUvbh7d6HJiqZj+YZep/qzktm/2/5d5CoJiEv+GWD05f9URTf1SJ
         Dim7SxO07/y0sga038TwZKG9IQZ1pFE1v/Zy73/aicIwUKPtaGe1K7n029X31KZl1i0y
         srA1fXXN7XLx3ekjABRWNJ7nVd5HPsOl8O9GhNj0+wRsudRJiBf8KktyI7KGvxzKIVsK
         I3ow==
X-Gm-Message-State: AOJu0Ywz0hI488ZjTgGODQ51TmD5ak2pgs+BJDge4PVQVNJ9puxr/U2y
	WgM9R1NthICzwz0cCwS0rqEz6cBg+Jm302h2lChsNk/ADyr0Du5XeDJd9Xn7NC56/EHaaVyhjNp
	eJbF7v47daVXcR5UAx3S/8zNYYpnfj8T/RAUlDrVMZ1wAkiLQNZp7pzznboxhdlm2JLMosKXHnS
	PtAzamlkvFUxwIwSxD288x67VLT7Vv1AyDrUQCT27EgQh95zjw
X-Google-Smtp-Source: AGHT+IG8ry48NqfLFCbYkREGZRQiZDjSrLmTy664Unix+U8/fujtjevJZRLEjPDNIKX0cyQAduJjhQ==
X-Received: by 2002:a05:6214:c44:b0:6b5:dfc2:66b4 with SMTP id 6a1803df08f44-6b61c1fa4femr83308176d6.61.1720649803827;
        Wed, 10 Jul 2024 15:16:43 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61ba04c16sm20182326d6.60.2024.07.10.15.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 15:16:43 -0700 (PDT)
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
Subject: [PATCH v3 06/12] PCI: brcmstb: PCI: brcmstb: Make HARD_DEBUG, INTR2_CPU_BASE offsets SoC-specific
Date: Wed, 10 Jul 2024 18:16:20 -0400
Message-Id: <20240710221630.29561-7-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240710221630.29561-1-james.quinlan@broadcom.com>
References: <20240710221630.29561-1-james.quinlan@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005c5092061cec008d"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

--0000000000005c5092061cec008d

Our HW design has again changed a register offset which used to be standard
for all Broadcom SOCs with PCIe cores.  This difference is now reconciled
for the registers HARD_DEBUG and INTR2_CPU_BASE.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
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


--0000000000005c5092061cec008d
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBRxwC6eWnAM7eCrgkVW6MaNO1kBtuK
XQz9WNWs40NBEDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA3
MTAyMjE2NDRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAoXM5QbsaOH97S2vEtJq6lfXpnCGEE0aOl7Rvx6yhCAnoybjn
jXw9cpXs/XfbG9dkNdUE37P2d497NKPEaigRa/NP6f4OLOydgfuIyCHeVts0hrPvWdcBjGqZaPh4
eOa9yKkbgisrnN5DNpaybPotsY6f3me8IlyS0Ccq1cDy5Vu8eRFgFSmbFsmnOQyU0XFSyyHi/SyW
C+PaX3rjBLQqA5YUbj/Wx66NMK4SAGj9hVv7K9DZSBPo/kyCWYYrVcnjOot7eui3UQwd9beaTGM7
Js7jpgozmJA0WTJZF5rE5T1rrB7SgiZlW+MHYw2U1LJCuo4gp0ZyZxEiRZKQh90uNg==
--0000000000005c5092061cec008d--

