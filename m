Return-Path: <linux-pci+bounces-21506-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D172A364DF
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 18:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89D6C1898523
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 17:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4162686A8;
	Fri, 14 Feb 2025 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gQpuV36v"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4D826989B
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 17:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554816; cv=none; b=a4Fm7ZpaxHSbWUzlv18UwVfUEP8Cn4oeApVFEHMpjq5Z64Ua1akjk0tg2dNp5dvEXEdEU+FKqpIEyyKRzLY80Z6iaKBle/LbN6C6SAWICU+ii4AhUn+hv7/DE1DlSwnMQgbZJwTr52qdeCBBabyXaCoe/LA9KqK73TTBrwuuf6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554816; c=relaxed/simple;
	bh=x1WpMbPrXt/ixRuU1MPNtZbnxurSV3/WnsYb3wurrDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fUo05Z+FuXg60EZ0bxowH1H1M1I4vGmJUpoWZz2mozTEW6SRfFPJstXCkjiNloVFC949HxAfQQOHlK/ueuU50Xjzc6MmS1hfvmdBGttaXSpqTT32FwCzjLikHDL/ylHZcWcCjp32eEFYXAVp7poogJCCXzv1+ivMuunoPcyUvdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gQpuV36v; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5fcb3ee41c5so590165eaf.1
        for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 09:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739554813; x=1740159613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsOCGGo9ceVGY3SPzwGNmGL7lbsQrpsFZ6ZHHv/lIws=;
        b=gQpuV36vdspRU5zZ2FXNCaga46Ot3BoAeEtI84k8+2qJ/783RJIJA0gnvsCNxZk1yl
         DovhyagfWGKVjCVZAqEYczLTWKHWr6WZ1ySE/LqoCLi+o8YJCgWV1Jy8qlZdzGI0x8c7
         wQrJAm1F1TyX46g5x3ZSzxtccgYiculkUTpM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739554813; x=1740159613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TsOCGGo9ceVGY3SPzwGNmGL7lbsQrpsFZ6ZHHv/lIws=;
        b=lH7gdIRAoyBHp9frYqoUYFE5iaRdl/4C8MCcMU7m5kLN+wTLrJMbd5V79yt3nXyjYv
         fWIhmO837OVuBz9v5BqMAiR+tdtPFqnz12sAm5yhaHP4oidb6KJ03S/38aLI1MStLZL3
         yTGkSs+t0jwYj6ot5nitZs6QzQrHbUKK+0GkYcX64MMjUI2Y6q8203nZjcGKtN/URrgV
         TAgwBC71yw/kqWLNn/tArs7fmtZ2rtm3Fo94aTIWGRTp7Vxq0on461imgDUaBwV88ozh
         b3/MCzfQ4dXfunxSev10WWtqkblW+809omZRuWH8poMSTbcMxjOIElDkXJ7OpKfAO6hi
         v+FA==
X-Gm-Message-State: AOJu0YyjJk1eQFXShoL3udyUTNT3bzrwIrPclaELrDso/BUVO4RA7fON
	j3HXGJQh3zAwTlLc7m+Lwi+MrwIaMHDESg9hYt3LzQpyl+A8PWRGpXOhoyyvjZZ7TSN+OW0xjY+
	SjqkpbFqZQZ+k0YdLTepA4tSku6zQGRlE+5LDscMnFSuS6SGQR4t3YaP8Pf4M1XZ097xLLxuDoj
	r8w8inmC0m/m8+8p6ensF1X8Io9RrQUjcxbGI/3tpCkrj7Wy73
X-Gm-Gg: ASbGncuOCjLqyuxMW6CkelxpTKWmrhz/0l6VREUEGUj4yDsaF2M0WbuO9Rh9I3nOEHL
	hMHmeG4nukA1jvnkxNrBLkrRRJ9SCDUl0EhC01ZHzF9f56mLU4mTaYPX8ccDSXhOyTwzTiW37HL
	UIK/yDzQTvZwW08sOAW4UFwZnoDF6tzBlBD8nZOvtO+hqWI9A6qC/QW136bE8eBA/aCrxr/ezsc
	xoL62Cf7/jW74yX7BWVDwRIbw7gSw6vDqO/wPmvhhaJV11qpdhjs8vvsn7GSdp2BBY9JZ5JNNAH
	IklZukH0Moq1PMFA3ePpAJOrL9vvpj3MFdqlLvusTA7UJtJjvWq1QDHfd/JUFlgchNx3XNA=
X-Google-Smtp-Source: AGHT+IEHK/RYufUjO2+odce57Cx5Dp9JDUKZ5jsTgSO+dN2Z245MJjJKtjxMOKhmnO9Jpvg4aHpnVA==
X-Received: by 2002:a05:6820:310a:b0:5fc:9bb2:f78 with SMTP id 006d021491bc7-5fcaf564190mr4940899eaf.8.1739554813562;
        Fri, 14 Feb 2025 09:40:13 -0800 (PST)
Received: from stbsrv-and-02.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fcb17a4ca4sm1284073eaf.30.2025.02.14.09.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:40:12 -0800 (PST)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 6/8] PCI: brcmstb: Use same constant table for config space access
Date: Fri, 14 Feb 2025 12:39:34 -0500
Message-ID: <20250214173944.47506-7-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250214173944.47506-1-james.quinlan@broadcom.com>
References: <20250214173944.47506-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The constants EXT_CFG_DATA and EXT_CFG_INDEX vary by SOC. One of the
map_bus methods used these constants, the other used different constants.
Fortunately there was no problem because the SoCs that used the latter
map_bus method all had the same register constants.

Remove the redundant constants and adjust the code to use them.  In
addition, update EXT_CFG_DATA to use the 4k-page based config space access
system, which is what the second map_bus method was already using.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index e1059e3365bd..923ac1a03f85 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -150,9 +150,6 @@
 #define  MSI_INT_MASK_SET		0x10
 #define  MSI_INT_MASK_CLR		0x14
 
-#define PCIE_EXT_CFG_DATA				0x8000
-#define PCIE_EXT_CFG_INDEX				0x9000
-
 #define  PCIE_RGR1_SW_INIT_1_PERST_MASK			0x1
 #define  PCIE_RGR1_SW_INIT_1_PERST_SHIFT		0x0
 
@@ -727,8 +724,8 @@ static void __iomem *brcm_pcie_map_bus(struct pci_bus *bus,
 
 	/* For devices, write to the config space index register */
 	idx = PCIE_ECAM_OFFSET(bus->number, devfn, 0);
-	writel(idx, pcie->base + PCIE_EXT_CFG_INDEX);
-	return base + PCIE_EXT_CFG_DATA + PCIE_ECAM_REG(where);
+	writel(idx, base + IDX_ADDR(pcie));
+	return base + DATA_ADDR(pcie) + PCIE_ECAM_REG(where);
 }
 
 static void __iomem *brcm7425_pcie_map_bus(struct pci_bus *bus,
@@ -1711,7 +1708,7 @@ static void brcm_pcie_remove(struct platform_device *pdev)
 static const int pcie_offsets[] = {
 	[RGR1_SW_INIT_1]	= 0x9210,
 	[EXT_CFG_INDEX]		= 0x9000,
-	[EXT_CFG_DATA]		= 0x9004,
+	[EXT_CFG_DATA]		= 0x8000,
 	[PCIE_HARD_DEBUG]	= 0x4204,
 	[PCIE_INTR2_CPU_BASE]	= 0x4300,
 };
@@ -1719,7 +1716,7 @@ static const int pcie_offsets[] = {
 static const int pcie_offsets_bcm7278[] = {
 	[RGR1_SW_INIT_1]	= 0xc010,
 	[EXT_CFG_INDEX]		= 0x9000,
-	[EXT_CFG_DATA]		= 0x9004,
+	[EXT_CFG_DATA]		= 0x8000,
 	[PCIE_HARD_DEBUG]	= 0x4204,
 	[PCIE_INTR2_CPU_BASE]	= 0x4300,
 };
@@ -1733,8 +1730,9 @@ static const int pcie_offsets_bcm7425[] = {
 };
 
 static const int pcie_offsets_bcm7712[] = {
+	[RGR1_SW_INIT_1]	= 0x9210,
 	[EXT_CFG_INDEX]		= 0x9000,
-	[EXT_CFG_DATA]		= 0x9004,
+	[EXT_CFG_DATA]		= 0x8000,
 	[PCIE_HARD_DEBUG]	= 0x4304,
 	[PCIE_INTR2_CPU_BASE]	= 0x4400,
 };
-- 
2.43.0


