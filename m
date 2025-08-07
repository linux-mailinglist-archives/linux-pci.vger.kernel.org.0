Return-Path: <linux-pci+bounces-33585-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E67B1DF49
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 00:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34641720EC2
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 22:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BB6255240;
	Thu,  7 Aug 2025 22:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gs5vQknq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D3C21D3EE
	for <linux-pci@vger.kernel.org>; Thu,  7 Aug 2025 22:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754604922; cv=none; b=poImgtEkA4v0b8zU3Gbvv4Hd7OG8y04iPOUWwRUeJq/CAVQb8et4E9KwmqIkr2FJNBNG7x7soo/SfnyAT0MS1sdmna4bhqj/Cva1aV3XIV0rEryi9+XCipSHjJTaLPJhBgCblW8GCLWZBYK4BzvrQf7tTTPv+itncZSxcVB+9d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754604922; c=relaxed/simple;
	bh=bZhK3Ug6n0M7Y/KebJqwpWQBQMbBn47GnkGv84IdfUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jGACt72OUwd1liBy7ZfYVK4mHezlT3KGaXxGGpSpfYQYMEoJ6KlqCvfe6D94MiNQs3MFHA08pmOeL6i8l4TpNZ5bbwX+WTbNldX6Q7d11F4zHgU7uWn6N/kifaE6Ku9jKzOZB5DrGxGkb2micJzYuprYdD4JoVecfexv8m+w9Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gs5vQknq; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b0ad5fa282so6582941cf.1
        for <linux-pci@vger.kernel.org>; Thu, 07 Aug 2025 15:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754604919; x=1755209719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7aXLLLTdaewYlSZFKdW1YKq/QeHggS65uLCSdSCq1A=;
        b=gs5vQknqRQgPA7eiTLdmhkTrJ7WAUhhGBXsv3zglPgt0aNRNok2kFc8xEwv0xTMzYP
         P4XjOtSj9/tX29sfV++H7qFp3LnJSyBRiaUYqTdUVlilAD+W7kWTvwD5N/rFJCCimFXr
         dtLl2QW8tVqpiKxjuRLzcdqSglCGeHyO2gx2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754604919; x=1755209719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7aXLLLTdaewYlSZFKdW1YKq/QeHggS65uLCSdSCq1A=;
        b=kCHpXmE2rr3hxUYqNBc81CspqJaNslN0+gb/agFygdAZybXTX2pf4iTK1BXLaGaGtJ
         k2RAuefCULkkuO8K9J8Y5beKOmqWOMLi1B1SjGI7BLNRVJxaiA0iARU5ONJWmkdj7k44
         lW9DJwdfNfa81mIJsPnAhCfQyAD6v0l6PSABcKtYZDoGRYmyB9tuZqAbqKeK9lM/cdXA
         xb7scd0sEItwUx74oyUahKU5H7RR4l/Jq7XBS7RjV0jvAH2VsljXMsM2Zfly/uwlQDWX
         FJlNiUseMkLgVe8uWFytHsNUnelAThn4RnQYe869Zd0miFDiTTF/yIr9KVlAmqF+SdR+
         RsSA==
X-Gm-Message-State: AOJu0YzGdkSQ+q03nyodrjxkhuYseudH76V0Sbp6rNcQsRy9j4knZOss
	96AOPqLuUcwveFoNHimNvNWQeZ+IkzfqFFOy5rcLskpH6gbq/ymyWwFN4FhUUud/TnyYeG6kp04
	mDle9LrMAnC1KDVHkpDeGk18okOS3u+fHdn1l/jytTJxiCxQNk9oHSiKqtl1w1VKbHFG1owdAMt
	wdNHavhCEqozTDtNjKOY49IObRw5R75Bib97PcXsgbKpxR42Pl0g==
X-Gm-Gg: ASbGncs/Tn5t5bUyvfkxFujkquV6vo11UhiH8XXy1FChOuUyQcJLWLM3VkvJuD8X/9Q
	DaLcyumiHVAWNT+zB+BifpppXVexZv5cLVGtapSguy5X6iUY5b7dRdizh9BhWUQrimob83E/E8x
	ZkmCQFmppqS36llQRzBUvAAilM59P+VebvJbvhbd4pduKCn0WTAq+7EiDYYrgQpixAtiYVvt60l
	OMRmZTh698BH4D7PuVzXr/LbGmg2DilFhEmncjsfAbTuT7903FU6RaV2535ZpSDu7jKuSohrPxC
	Ms63f40zo89BzsnxL8UwfUt7ckPFGHjZ4Gco9LirombzntzQO6V5WMhxbpKlROMb8eqCHYWD+o5
	Gc6Rj+3vsbsuE0m4uNylEC8v6uSB1CE4wx0TIZ/wYFaCTRokYV8uGm59ITcqJKzJXGWmHUMeMX0
	hVBQvga0pNE9lm
X-Google-Smtp-Source: AGHT+IFECAtHrfofLNszmttHHQwFVkK40S3ZHWrqpD2n3W0M30Gfsipiqbx2ZOcLlQJ+kKSkdKgcYg==
X-Received: by 2002:a05:622a:1a8a:b0:4a7:81f6:331e with SMTP id d75a77b69052e-4b0afd8200bmr6892381cf.6.1754604918375;
        Thu, 07 Aug 2025 15:15:18 -0700 (PDT)
Received: from stband-bld-1.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0aa1efe78sm9527421cf.8.2025.08.07.15.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 15:15:17 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] PCI: brcmstb: Add a way to indicate if PCIe bridge is active
Date: Thu,  7 Aug 2025 18:15:12 -0400
Message-Id: <20250807221513.1439407-2-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807221513.1439407-1-james.quinlan@broadcom.com>
References: <20250807221513.1439407-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a future commit, a new handler will be introduced that in part does
reads and writes to some of the PCIe registers.  When this handler is
invoked, it is paramount that it does not do these register accesses when
the PCIe bridge is inactive, as this will cause CPU abort errors.

To solve this we keep a spinlock that guards a variable which indicates
whether the bridge is on or off.  When the bridge is on, access of the PCIe
HW registers may proceed.

Since there are multiple ways to reset the bridge, we introduce a general
function to obtain the spinlock, call the specific function that is used
for the specific SoC, sets the bridge active indicator variable, and
releases the spinlock.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 51 +++++++++++++++++++++------
 1 file changed, 40 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 9afbd02ded35..ceb431a252b7 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -30,6 +30,7 @@
 #include <linux/reset.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/string.h>
 #include <linux/types.h>
 
@@ -259,6 +260,7 @@ struct pcie_cfg_data {
 	int (*perst_set)(struct brcm_pcie *pcie, u32 val);
 	int (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 	int (*post_setup)(struct brcm_pcie *pcie);
+	bool has_err_report;
 };
 
 struct subdev_regulators {
@@ -303,6 +305,8 @@ struct brcm_pcie {
 	struct subdev_regulators *sr;
 	bool			ep_wakeup_capable;
 	const struct pcie_cfg_data	*cfg;
+	bool			bridge_on;
+	spinlock_t		bridge_lock;
 };
 
 static inline bool is_bmips(const struct brcm_pcie *pcie)
@@ -310,6 +314,24 @@ static inline bool is_bmips(const struct brcm_pcie *pcie)
 	return pcie->cfg->soc_base == BCM7435 || pcie->cfg->soc_base == BCM7425;
 }
 
+static inline int brcm_pcie_bridge_sw_init_set(struct brcm_pcie *pcie, u32 val)
+{
+	unsigned long flags;
+	int ret;
+
+	if (pcie->cfg->has_err_report)
+		spin_lock_irqsave(&pcie->bridge_lock, flags);
+
+	ret = pcie->cfg->bridge_sw_init_set(pcie, val);
+	/* If we fail, assume the bridge is in reset (off) */
+	pcie->bridge_on = ret ? false : !val;
+
+	if (pcie->cfg->has_err_report)
+		spin_unlock_irqrestore(&pcie->bridge_lock, flags);
+
+	return ret;
+}
+
 /*
  * This is to convert the size of the inbound "BAR" region to the
  * non-linear values of PCIE_X_MISC_RC_BAR[123]_CONFIG_LO.SIZE
@@ -756,9 +778,8 @@ static void __iomem *brcm7425_pcie_map_bus(struct pci_bus *bus,
 
 static int brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
 {
-	u32 tmp, mask = RGR1_SW_INIT_1_INIT_GENERIC_MASK;
-	u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
-	int ret = 0;
+	u32 tmp;
+	int ret;
 
 	if (pcie->bridge_reset) {
 		if (val)
@@ -774,10 +795,10 @@ static int brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
 	}
 
 	tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
-	tmp = (tmp & ~mask) | ((val << shift) & mask);
+	u32p_replace_bits(&tmp, val, RGR1_SW_INIT_1_INIT_GENERIC_MASK);
 	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
 
-	return ret;
+	return 0;
 }
 
 static int brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32 val)
@@ -1081,7 +1102,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	int memc, ret;
 
 	/* Reset the bridge */
-	ret = pcie->cfg->bridge_sw_init_set(pcie, 1);
+	ret = brcm_pcie_bridge_sw_init_set(pcie, 1);
 	if (ret)
 		return ret;
 
@@ -1097,7 +1118,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	usleep_range(100, 200);
 
 	/* Take the bridge out of reset */
-	ret = pcie->cfg->bridge_sw_init_set(pcie, 0);
+	ret = brcm_pcie_bridge_sw_init_set(pcie, 0);
 	if (ret)
 		return ret;
 
@@ -1565,7 +1586,7 @@ static int brcm_pcie_turn_off(struct brcm_pcie *pcie)
 
 	if (!(pcie->cfg->quirks & CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN))
 		/* Shutdown PCIe bridge */
-		ret = pcie->cfg->bridge_sw_init_set(pcie, 1);
+		ret = brcm_pcie_bridge_sw_init_set(pcie, 1);
 
 	return ret;
 }
@@ -1653,7 +1674,9 @@ static int brcm_pcie_resume_noirq(struct device *dev)
 		goto err_reset;
 
 	/* Take bridge out of reset so we can access the SERDES reg */
-	pcie->cfg->bridge_sw_init_set(pcie, 0);
+	ret = brcm_pcie_bridge_sw_init_set(pcie, 0);
+	if (ret)
+		goto err_reset;
 
 	/* SERDES_IDDQ = 0 */
 	tmp = readl(base + HARD_DEBUG(pcie));
@@ -1921,7 +1944,10 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "could not enable clock\n");
 
-	pcie->cfg->bridge_sw_init_set(pcie, 0);
+	ret = brcm_pcie_bridge_sw_init_set(pcie, 0);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "could not un-reset the bridge\n");
 
 	if (pcie->swinit_reset) {
 		ret = reset_control_assert(pcie->swinit_reset);
@@ -1938,7 +1964,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		if (ret) {
 			clk_disable_unprepare(pcie->clk);
 			return dev_err_probe(&pdev->dev, ret,
-					     "could not de-assert reset 'swinit'\n");
+					     "could not deassert bridge reset\n");
 		}
 	}
 
@@ -1996,6 +2022,9 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (pcie->cfg->has_err_report)
+		spin_lock_init(&pcie->bridge_lock);
+
 	return 0;
 
 fail:
-- 
2.34.1


