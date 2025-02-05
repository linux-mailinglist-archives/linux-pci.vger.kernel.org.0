Return-Path: <linux-pci+bounces-20779-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C57A299E6
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 20:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C5A23A92A8
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 19:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1C020CCF4;
	Wed,  5 Feb 2025 19:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="f/6li2LR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD3E20C03C
	for <linux-pci@vger.kernel.org>; Wed,  5 Feb 2025 19:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738782789; cv=none; b=bkny8Ne88/5dP1jaRn4XJfRRe9sx3zq5bi3cXPnKYSYoMiuJLRCUFbMdfQKjNN8a/V4p9zGSFgrxD2/9ZZ8/Fzi4I7W1HtKuJMZPH3+BKMY60/lFWRIP+MdEWr2NqrztPTW85Nj90mLAB1/PnoVctJzCz4zzjF4Ep+209aK8YuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738782789; c=relaxed/simple;
	bh=tmKlWkoxyVVoBftC1tqR72Fa3nMd+vjFUErcYQ3Ogz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9Rv/DgW3NR51406niv/a2KvZCWTvUlLoOVWSsq9A3ADJR3AMDlsF/yEvKOptmrbOhooIkUkVThAHtWF5taq6nm4xOIBNwL6pe8+aqkrNW79aQL2NcIXtqEXN/Fsxb9Jg82N9+alR1ZMI1Mc0uXoxf+o2463GhWJRBXNCKVcGSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=f/6li2LR; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2f9c3ef6849so74195a91.3
        for <linux-pci@vger.kernel.org>; Wed, 05 Feb 2025 11:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738782786; x=1739387586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2SP8UN+7O3+LtijH955HifaeFHXMbD1xCtBylyCBjw=;
        b=f/6li2LRa/J3WFAPNqmbqk+D1JoF7B/SQOUf3vMHrbmfS1efayd0oAfSdDyfP5e83Q
         ygsXUXWtvhF7lvpm5mDmg8tmdpT/SY+lqE/YtCi+Ips05BmM7hCyPeHURDgO9/2QPlxM
         2Xv7SCmRE1pfOcrCCtyN1xUUB6UyHkgjQjd5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738782786; x=1739387586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p2SP8UN+7O3+LtijH955HifaeFHXMbD1xCtBylyCBjw=;
        b=S60YIIPMpxl7fOjApRkHsNcfJwZ9QB04tvGdVpLjgaNswdeBG4rNOs1fLkjfN0xcRY
         qM5Oc4E7p2Jt2aCObq2eKhUp2SlrNND3+2AQycdJ/J+5gOa5BNZsopRbYl4PTSou2D+z
         zjophUBiXRGVj8HqIFNOA6ScVLOkwdOkIhbrAVMW+t5uOiMl3wjZxJqoPiwpNAgrjr3c
         jk+wyEOdkoM1r0WLr3wnMRKpvAAdBDSU/Qsf2Pb337zaRDLnf64P7iMJjaltlJ4gMLdF
         fUkU6q1RLOyfPoK3Z9mlNgA1YZ2c4xH4LPdT4MAqFjioqAOcrs4yOX0kxeZfkxm5pNvs
         nz3Q==
X-Gm-Message-State: AOJu0YwyTegypC+Iw22cmA98eiOnjwNBFoUHg8XuixekaKCtx9dL/Ajf
	bQHCNsZGxg4ayuoRw3xvdJfHIjeC3eS3NEnNKHWzp81xfpgwV7d298sH6rT5SYLPqdGmBaVJZaT
	3DurpiLjCG2epL3/31ghpHJ5BJg9kJ99PoGXUx5L9nN+4CB0OOi8Oc54evyniyibZL/8Xr7IkXi
	1yk0t1r3IvrrPcfttkbMPPIH6eh/Z3LYhk7WYI4PkCe5ROcgeh
X-Gm-Gg: ASbGncsERq05G2UcqRizez+KnqUNAT7KtvOo8zVe+oWSPlev7BfMZVs4p9GQ/ojFd/P
	q85Aen/EPTBf4xhDJNxdwk9Zg7VFudTURYNpP2dPriH3yvXo849KU7BDmqzNZQRdXJB8bN5Lrbs
	bGQ4wZp9EIpCBxfBdKBpVWE7gnBWZp8I3Lb+zsb6SSVZaCHkUcW5awX8Lvs9aps8TSoDqIWpWwE
	biDXXgawK9MhGV2CyCp20Nlb1Ks0MdfbB+nWgom/IlJopMsgxNW6nmeVsN3gQrsXtY5vAeSG2h1
	fBnkmCO1FHpD/OXTBiUbLfzszwrfY5fxGt8j+KjSbClQM+TXbavPWwAKBjCb8lxQ6r0T6Ac=
X-Google-Smtp-Source: AGHT+IFWf34gqo2Cq3GC10EE4JpvnnXxd/baqFQ4/rfJGOY8K+FfkhKwIxsYtkyKK3/Ky0Uqi5YYwA==
X-Received: by 2002:a05:6a00:2908:b0:72d:8fa2:9998 with SMTP id d2e1a72fcca58-7303513ac4amr6540559b3a.14.1738782756542;
        Wed, 05 Feb 2025 11:12:36 -0800 (PST)
Received: from stbsrv-and-02.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ceb1csm12670842b3a.151.2025.02.05.11.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 11:12:36 -0800 (PST)
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
Subject: [PATCH v1 4/6] PCI: brcmstb: Use same constant table for config space access
Date: Wed,  5 Feb 2025 14:12:04 -0500
Message-ID: <20250205191213.29202-5-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205191213.29202-1-james.quinlan@broadcom.com>
References: <20250205191213.29202-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The constants EXT_CFG_DATA and EXT_CFG_INDEX vary by SOC. One of the
map_bus methods used these constants, the other used different
constants.  Fortunately there was no problem because the SoCs that used
the latter map_bus method all had the same register constants.

Remove the redundant constants and adjust the code to use them.
In addition, update EXT_CFG_DATA to use the 4k-page based config
space access system, which is what the second map_bus method was
already using.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 4f5d751cbdd7..2d1969d7fd30 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -151,9 +151,6 @@
 #define  MSI_INT_MASK_SET		0x10
 #define  MSI_INT_MASK_CLR		0x14
 
-#define PCIE_EXT_CFG_DATA				0x8000
-#define PCIE_EXT_CFG_INDEX				0x9000
-
 #define  PCIE_RGR1_SW_INIT_1_PERST_MASK			0x1
 #define  PCIE_RGR1_SW_INIT_1_PERST_SHIFT		0x0
 
@@ -728,8 +725,8 @@ static void __iomem *brcm_pcie_map_bus(struct pci_bus *bus,
 
 	/* For devices, write to the config space index register */
 	idx = PCIE_ECAM_OFFSET(bus->number, devfn, 0);
-	writel(idx, pcie->base + PCIE_EXT_CFG_INDEX);
-	return base + PCIE_EXT_CFG_DATA + PCIE_ECAM_REG(where);
+	writel(idx, base + IDX_ADDR(pcie));
+	return base + DATA_ADDR(pcie) + PCIE_ECAM_REG(where);
 }
 
 static void __iomem *brcm7425_pcie_map_bus(struct pci_bus *bus,
@@ -1712,7 +1709,7 @@ static void brcm_pcie_remove(struct platform_device *pdev)
 static const int pcie_offsets[] = {
 	[RGR1_SW_INIT_1]	= 0x9210,
 	[EXT_CFG_INDEX]		= 0x9000,
-	[EXT_CFG_DATA]		= 0x9004,
+	[EXT_CFG_DATA]		= 0x8000,
 	[PCIE_HARD_DEBUG]	= 0x4204,
 	[PCIE_INTR2_CPU_BASE]	= 0x4300,
 };
@@ -1720,7 +1717,7 @@ static const int pcie_offsets[] = {
 static const int pcie_offsets_bcm7278[] = {
 	[RGR1_SW_INIT_1]	= 0xc010,
 	[EXT_CFG_INDEX]		= 0x9000,
-	[EXT_CFG_DATA]		= 0x9004,
+	[EXT_CFG_DATA]		= 0x8000,
 	[PCIE_HARD_DEBUG]	= 0x4204,
 	[PCIE_INTR2_CPU_BASE]	= 0x4300,
 };
@@ -1734,8 +1731,9 @@ static const int pcie_offsets_bcm7425[] = {
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


