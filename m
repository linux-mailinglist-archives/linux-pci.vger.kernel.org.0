Return-Path: <linux-pci+bounces-29797-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 303E7AD9811
	for <lists+linux-pci@lfdr.de>; Sat, 14 Jun 2025 00:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3DC816E872
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 22:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DD528DF34;
	Fri, 13 Jun 2025 22:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iDHKVma6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2E428DEE9
	for <linux-pci@vger.kernel.org>; Fri, 13 Jun 2025 22:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749852535; cv=none; b=cX6jG8jiCklrlTZR0tXdohiis3AReG5wtDcuOZUvq0lV2ICaSgpYjd392OwJytEjoAyzdO0DVgiUu8g2nY/GSWUQCTRJUG5SkMy55rVQb1DmSmbpVvwcIvE5/oC8cSkgWfiUZjHhlL2PXYgO5wN9YddJYMXCwbkmug2OCIT2sBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749852535; c=relaxed/simple;
	bh=TRaVBAz7tbUSc6CM8t/iSL3Hwc9e4nCy7l6dTwQY3qI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FtW7EADiKBqo2QyE46ys2PuN9uq9+iJTTyRxhdTz1Ojiew0Hw65rAXEO3hP066TdWzictR4aA5hdHbIdnqFanGWMz5EpqV2MNkta2ZxEkgb0zPQRfxCup/G81ZjNIuz2MakjETirGEH7LjGCCg2wIzgtybZydu3QqlaoVGiVWWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iDHKVma6; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-235f9ea8d08so26747345ad.1
        for <linux-pci@vger.kernel.org>; Fri, 13 Jun 2025 15:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1749852533; x=1750457333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTOEPKoKv4ajHTNSTP84Hrxgzt+IR4WbeVWxtPlJWow=;
        b=iDHKVma6PJ64/7/SZN84RLKnK2KPBhwmSzc2KCpy6R2ADPiIPMwdUi0+AnqYO9DQSq
         31N09KoZmLmn9FpAXOZKENXiAMPvZhpPQ/tEf9GI9zipGyFbW2M+a9g7YW+NKwYxgqyU
         eS8XALelseqEGcI5UJnHg5AfsWFOWm5lG9pls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749852533; x=1750457333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTOEPKoKv4ajHTNSTP84Hrxgzt+IR4WbeVWxtPlJWow=;
        b=aU5TmNkL4L7fbv9sUteaMH7fIO2DM43e33F2X1AVP9chaWGmsOE8HiySmf2tm+lOqL
         f/wt8Y5cC2Dzlc4yN1frDvk4zpbiD3qYsgu8kWiQhvMsNX8MAiTeu2DxORioFsujMewY
         ZqCeH3G0l1uuY5u07xaSVuaYbqmjGwQ/H0dAOtxkrioQTohBoRn72mu84SwxlzjiKlkR
         beHHBYFJ05mu9LWbQXNGfNDIA5WdjQiID6/QrJ+jPFFob5WVcY0mt70EHO7u9MJ/2P+C
         9p18cf0A7Iq1o79+QNTnkX4uihSOeqdKysZMBXhs0YmLr8n4SZxU5x0VGRCdBqhFSJ9o
         +9sA==
X-Gm-Message-State: AOJu0Yz9OV/uQ08ES3DQLiLGEgZFbUiFvAGO2+u8yy4O7phX2jm60O3g
	PhEFibuFEznNhF51fBPhqXDoqA7DDTMYep/E8HzbiToHcmrhd0Z5FYZfbdZQ43p/ZB1KfcjZQMd
	LDllPUERx3x1Ge9DVJE/P3yVHcRE+WKzftP4ROoX24xXN7IoTpdRobNaKLwnm4j46oB0ZXbxczt
	71ivvUfbFVJWV5mxknm8W4qyvbEA8e0aHnWI731EO3/X6FTlWooZQ8
X-Gm-Gg: ASbGncsAU0WrZzctLIwCsRjIp/GvyrQxXeOYE+lxvT0n25SauKwZLrM3yzD1Ao+kh6w
	LuHyULflirmtBgRmEIKwqlf+PHMnMzpdDCgsFQw2Fx/rIalXK+rMTTDM1t8MMTkckMZRdYAhhy3
	QxKUmm6ArZOCZoh1KY1Uuw88pM+1YNfXKN888U9iCFq7+RCVASMJBoo1bC7X6qPAfW5gDOKrFLv
	YQVQRYPSIhUhiY9dqyEWO/gXrsbHYjmzl2w2bgiOyTMjS6YwYuK+2LaU9JcbDgPGuESaSIeKynS
	en2LLS7wT2IagzvNRCkpZrZc0JB4jp5Wm9N+1kekX/UYcyaUUNaPANpUnjICfx4aW+5ziqx2zMl
	JFlHUoZO8hFp1Y0R1ucLz3UMw5JAg2sF8LwjPqVXkqw==
X-Google-Smtp-Source: AGHT+IG1F1gAsXiF14k7CbCxmhGYBAPiFDXrNRzZMFVz3m3N5XXoe66Nkc5F+9nou5STw5a0DP1o4Q==
X-Received: by 2002:a17:902:d54a:b0:235:eb8d:7fff with SMTP id d9443c01a7336-2366b1224d8mr18110485ad.28.1749852532769;
        Fri, 13 Jun 2025 15:08:52 -0700 (PDT)
Received: from stband-bld-1.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365dea7d74sm19593105ad.152.2025.06.13.15.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 15:08:52 -0700 (PDT)
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
Subject: [PATCH 1/2] PCI: brcmstb: Add a way to indicate if PCIe bridge is active
Date: Fri, 13 Jun 2025 18:08:42 -0400
Message-Id: <20250613220843.698227-2-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250613220843.698227-1-james.quinlan@broadcom.com>
References: <20250613220843.698227-1-james.quinlan@broadcom.com>
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
 drivers/pci/controller/pcie-brcmstb.c | 40 +++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 92887b394eb4..400854c893d8 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -29,6 +29,7 @@
 #include <linux/reset.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/string.h>
 #include <linux/types.h>
 
@@ -254,6 +255,7 @@ struct pcie_cfg_data {
 	int (*perst_set)(struct brcm_pcie *pcie, u32 val);
 	int (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 	int (*post_setup)(struct brcm_pcie *pcie);
+	bool has_err_report;
 };
 
 struct subdev_regulators {
@@ -299,6 +301,8 @@ struct brcm_pcie {
 	struct subdev_regulators *sr;
 	bool			ep_wakeup_capable;
 	const struct pcie_cfg_data	*cfg;
+	bool			bridge_on;
+	spinlock_t		bridge_lock;
 };
 
 static inline bool is_bmips(const struct brcm_pcie *pcie)
@@ -306,6 +310,24 @@ static inline bool is_bmips(const struct brcm_pcie *pcie)
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
+	if (ret)
+		pcie->bridge_on = !val;
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
@@ -1078,7 +1100,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	int memc, ret;
 
 	/* Reset the bridge */
-	ret = pcie->cfg->bridge_sw_init_set(pcie, 1);
+	ret = brcm_pcie_bridge_sw_init_set(pcie, 1);
 	if (ret)
 		return ret;
 
@@ -1094,7 +1116,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	usleep_range(100, 200);
 
 	/* Take the bridge out of reset */
-	ret = pcie->cfg->bridge_sw_init_set(pcie, 0);
+	ret = brcm_pcie_bridge_sw_init_set(pcie, 0);
 	if (ret)
 		return ret;
 
@@ -1545,7 +1567,7 @@ static int brcm_pcie_turn_off(struct brcm_pcie *pcie)
 
 	if (!(pcie->cfg->quirks & CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN))
 		/* Shutdown PCIe bridge */
-		ret = pcie->cfg->bridge_sw_init_set(pcie, 1);
+		ret = brcm_pcie_bridge_sw_init_set(pcie, 1);
 
 	return ret;
 }
@@ -1633,7 +1655,9 @@ static int brcm_pcie_resume_noirq(struct device *dev)
 		goto err_reset;
 
 	/* Take bridge out of reset so we can access the SERDES reg */
-	pcie->cfg->bridge_sw_init_set(pcie, 0);
+	ret = brcm_pcie_bridge_sw_init_set(pcie, 0);
+	if (ret)
+		goto err_reset;
 
 	/* SERDES_IDDQ = 0 */
 	tmp = readl(base + HARD_DEBUG(pcie));
@@ -1901,7 +1925,10 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "could not enable clock\n");
 
-	pcie->cfg->bridge_sw_init_set(pcie, 0);
+	ret = brcm_pcie_bridge_sw_init_set(pcie, 0);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "could not un-reset the bridge\n");
 
 	if (pcie->swinit_reset) {
 		ret = reset_control_assert(pcie->swinit_reset);
@@ -1976,6 +2003,9 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (pcie->cfg->has_err_report)
+		spin_lock_init(&pcie->bridge_lock);
+
 	return 0;
 
 fail:
-- 
2.34.1


