Return-Path: <linux-pci+bounces-39723-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC05C1D067
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 20:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9454718888CE
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 19:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64223590B5;
	Wed, 29 Oct 2025 19:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IABwTOm4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f228.google.com (mail-il1-f228.google.com [209.85.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A133563E9
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 19:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761766589; cv=none; b=JhTby48dt50/IEBXpgtFGpNvWDRvktywGfOxbtwVsh47UsqWCty01hdUKVmxGGLuvw2ebLLTxfio/0RozI+Pq6OTCVJBNRUeBQGQqXwPVOHIrZ7yiNMGb8hbuude+cDjyR6yetASrgmIvsziJmCzxea+w7mVpiDhGhRPkFQ3h4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761766589; c=relaxed/simple;
	bh=+uLXOevcin9GX8uM8pwPTi35EjkCinCKRxZQkv7MOrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GnnUXVECcwsA+epoKVqvxysMfvxR5bPeH4y4JPwlvYw/XF5Uvq/4IR1d6V7oyMPMt+8COjccVzESooLqwSjg62FTLAPDGdGCGO4MBQNc6Ls2ayw4I9AJjGTtevHZ1lQCU0MP3rKjphGy95IC3t3MLg23UWSyN3+cd6qzIa2wReM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IABwTOm4; arc=none smtp.client-ip=209.85.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f228.google.com with SMTP id e9e14a558f8ab-430d0cad0deso682575ab.2
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 12:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761766587; x=1762371387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dbpDWJdZfVTVSB8z3KjE43n+mbMdK6iqWDy5+ydNGZc=;
        b=D7CrNQtD2oSn2WhqRhNRQkR2Y8mLVy7BW7Koj462DPyOwl48JUP/eJaKlArq5S5xCx
         k38j8PZan4CmzvcIoV0oquHcVvqR+eijbtch/lldMPdDh9ss9yfMFEg1v2H+byMHHZVD
         2SUhInnSDP69zC9hyDgsWwiowMWK1NvRpV3AHB5W1zO79yDY7aHDuJut+LfHu/aPf6U+
         nxJI6e6EMOnrozXx+He6rdIKOk9lwsDom3ldWHGQ/O4gM0NkvTvVqdZ/iTL3Q6k/iVmd
         VzV1NrqWu4aUnt2f+6sZtDwUZK+w0Mq3NuJIButYnOglhpPqMlVecZvOa1p8EOXarMZf
         G8VQ==
X-Gm-Message-State: AOJu0YwlCKyAnzaxRtsFJtDti9AgB9HJa8CFZ8sQLL26yRs92oWUGIvJ
	yXAwBAvI5g+Q92YsU7P9utQ80bztH4FeHrcs8Xp+QYxualjsddjnm+cC7yS7JGmSFTXTx7ztYgo
	yd30t+LsCDcIqU9FFTmn+CyZ65mTNeNFWW0Aa0vtu0WMKorc28aCBsRXE79EWYVPRL7dfN8xD8g
	a3jSdmXogrpkH3tb3JSzdRgn3rIWWnyB/fjfHgCr0/64OUWfDJQZdMcThzq7bReJACgO7fSPemd
	Xswd0GEpuHDzAKK
X-Gm-Gg: ASbGncuS5hKApL0lf7U6M/gfmnRpmSZ8NeazYvnWrP+j0E2Y6eEtDir2Icam935eic9
	wUh5bvnRN84qs9mncFvcrMjmUu87nqABHKRrPur2DLSuMamhjM1XC217qFwIBqENv6V4Zzdc/NV
	VHxw2RHbmM2jS9thC2Et4axPNIIFcD1jgMG9m1T8tEs75U8A3fF6n4cdVek/f4QHJOAfiWPvEhj
	EiaxtUGmrIcH0HkjJUZNsJnzPRx/VFkVFRfH//+HmOUeQapCS/5MX6OlUXLvfmi7/42LXBuNyGY
	n6hzEMIjoG/YL0XM01qbH/DnaIXQrM3qzpPT86N7hxeeZEyXwzXNNreK4FaDeT3zx2Cr1FmQFDE
	BegxvhWUFCLf+NipnmhDLxCZzgMH8tzxOMjnNsU7sGExAMFGk2i3TzZrzsUkmJ7HM6WAiwPnNJb
	e8Sk0W19QU4Sng8GkNt4k7sq1NWLYnqwy2PCiNtA==
X-Google-Smtp-Source: AGHT+IGLZhp08NhrclKuQf/ZjVd049xSzu7ZnXlJKHdNIJg2QknSSh9n/9dhbhM3VcIbUWzdVOjJ8RHr8UAJ
X-Received: by 2002:a05:6e02:3a04:b0:430:b59b:5f2b with SMTP id e9e14a558f8ab-4330153ddbdmr8067975ab.16.1761766587095;
        Wed, 29 Oct 2025 12:36:27 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-431f67ea498sm14125245ab.6.2025.10.29.12.36.25
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Oct 2025 12:36:27 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7a285bb5376so213495b3a.1
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 12:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761766584; x=1762371384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbpDWJdZfVTVSB8z3KjE43n+mbMdK6iqWDy5+ydNGZc=;
        b=IABwTOm4C8oTrRwjiXv9cREc0r7Y7q16xnQrEH4H1rKENPJCU1z8nDgKGz+qCb5TyJ
         fnp4ejoGlHaJAO33eH+hnSp+/QyEZ5CUWZ6VuRUOcW/icJ1mFysk6oTPPrNXyzxKP3j/
         kFUe4TetzPVRzz3Nm6TFsdUqdxZTXmE3CVgQc=
X-Received: by 2002:a05:6a00:c95:b0:78c:97fa:619c with SMTP id d2e1a72fcca58-7a6275ee9e7mr645032b3a.32.1761766583854;
        Wed, 29 Oct 2025 12:36:23 -0700 (PDT)
X-Received: by 2002:a05:6a00:c95:b0:78c:97fa:619c with SMTP id d2e1a72fcca58-7a6275ee9e7mr644977b3a.32.1761766583175;
        Wed, 29 Oct 2025 12:36:23 -0700 (PDT)
Received: from stband-bld-1.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a4140a0d47sm15895260b3a.73.2025.10.29.12.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 12:36:22 -0700 (PDT)
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
Subject: [PATCH v4 1/2] PCI: brcmstb: Add a way to indicate if PCIe bridge is active
Date: Wed, 29 Oct 2025 15:36:14 -0400
Message-Id: <20251029193616.3670003-2-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029193616.3670003-1-james.quinlan@broadcom.com>
References: <20251029193616.3670003-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

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
index 9afbd02ded35..9f1f746091be 100644
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
+	bool			bridge_in_reset;
+	spinlock_t		bridge_lock;
 };
 
 static inline bool is_bmips(const struct brcm_pcie *pcie)
@@ -310,6 +314,24 @@ static inline bool is_bmips(const struct brcm_pcie *pcie)
 	return pcie->cfg->soc_base == BCM7435 || pcie->cfg->soc_base == BCM7425;
 }
 
+static int brcm_pcie_bridge_sw_init_set(struct brcm_pcie *pcie, u32 val)
+{
+	unsigned long flags;
+	int ret;
+
+	if (pcie->cfg->has_err_report)
+		spin_lock_irqsave(&pcie->bridge_lock, flags);
+
+	ret = pcie->cfg->bridge_sw_init_set(pcie, val);
+	/* If we fail, assume the bridge is in reset (off) */
+	pcie->bridge_in_reset = ret ? true : val;
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
@@ -1081,7 +1103,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	int memc, ret;
 
 	/* Reset the bridge */
-	ret = pcie->cfg->bridge_sw_init_set(pcie, 1);
+	ret = brcm_pcie_bridge_sw_init_set(pcie, 1);
 	if (ret)
 		return ret;
 
@@ -1097,7 +1119,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	usleep_range(100, 200);
 
 	/* Take the bridge out of reset */
-	ret = pcie->cfg->bridge_sw_init_set(pcie, 0);
+	ret = brcm_pcie_bridge_sw_init_set(pcie, 0);
 	if (ret)
 		return ret;
 
@@ -1565,7 +1587,7 @@ static int brcm_pcie_turn_off(struct brcm_pcie *pcie)
 
 	if (!(pcie->cfg->quirks & CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN))
 		/* Shutdown PCIe bridge */
-		ret = pcie->cfg->bridge_sw_init_set(pcie, 1);
+		ret = brcm_pcie_bridge_sw_init_set(pcie, 1);
 
 	return ret;
 }
@@ -1653,7 +1675,9 @@ static int brcm_pcie_resume_noirq(struct device *dev)
 		goto err_reset;
 
 	/* Take bridge out of reset so we can access the SERDES reg */
-	pcie->cfg->bridge_sw_init_set(pcie, 0);
+	ret = brcm_pcie_bridge_sw_init_set(pcie, 0);
+	if (ret)
+		goto err_reset;
 
 	/* SERDES_IDDQ = 0 */
 	tmp = readl(base + HARD_DEBUG(pcie));
@@ -1921,7 +1945,10 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "could not enable clock\n");
 
-	pcie->cfg->bridge_sw_init_set(pcie, 0);
+	ret = brcm_pcie_bridge_sw_init_set(pcie, 0);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "could not de-assert bridge reset\n");
 
 	if (pcie->swinit_reset) {
 		ret = reset_control_assert(pcie->swinit_reset);
@@ -1996,6 +2023,9 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (pcie->cfg->has_err_report)
+		spin_lock_init(&pcie->bridge_lock);
+
 	return 0;
 
 fail:
-- 
2.34.1


