Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5D521ED9B
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jul 2020 12:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgGNKEk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jul 2020 06:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgGNKEj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2020 06:04:39 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7B7C061794;
        Tue, 14 Jul 2020 03:04:38 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id y10so20911044eje.1;
        Tue, 14 Jul 2020 03:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nmxYIVd0VfpP8/5JYBPjSipRO5vcl/2LLzPMpP8Wy5Q=;
        b=M6BF8Y/ogqjKG1sQerDUjvMfxOJUoQ4IDmRmr6SC25fH9bQDRD3inUDtJo5vIYcYNV
         GVoJeZM2bHqF6goed8h17WAMzukEsDLoE4TNNFKyRG1ddwH1SUJr+/f1M21TuAaF18ch
         UVAYrZkacansfdxKmwSTOLsfG97kkLJHlcp9esR2kH2lCyM3ykudairrZM3NAa3ub7Xm
         k26Cjsp2fcHJ+F62HdVo1yOpAQ6l8sKimgsJbpsdeuMnSSy4JFiFLsB11SRbrDRoVUou
         sPIMFT17j5DqyoK67Ak9vClBcKbEBgPJ39innRsnu7yalF6xwBV8yhNTe6ehsapABvjg
         UW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nmxYIVd0VfpP8/5JYBPjSipRO5vcl/2LLzPMpP8Wy5Q=;
        b=eFFKDoLnX/xwKbTXoVRfAieaHj7Zf2Nets5EmjZ8ZrltdhrCoUr8E4ZYLFft/FxBL8
         +pC0o1eacHacyOLVYLXDAfLg10I8RbW+abK0SQS+SFbTNiRHoHrpB7kRWHjSyL749aXQ
         iDWG1/3S6wedqWm1xjMkx3NrO+i9shn13GhEeWPgukl+BoXkp37LXguIsHcwbXns/vqK
         l90Hj9rkhVFfLRHIy7NLpmZbsZoRkR9NsyXR656zXgV36nVM2uPxI+BGYy4Cx79xBoJS
         buozfyXK7N+SvVTlK7oIitSp5gyCTzPl+jGq1/Ca3re34bfGuWouM67Nnb9/uey9DiNQ
         +dIw==
X-Gm-Message-State: AOAM530C+x8grCeydp7VrAVRA+VpEAh+OuoJ4tb5O8EGDR3zdq+tXosc
        7xfZCoO2lyhotjydI/QLF5Y=
X-Google-Smtp-Source: ABdhPJyVMd7rZKDdA42Cfz/SHZeT+y7p+5je7Lzrmo3+snFmBiiRwH8ZpcuxopEWCIx9CRqzmiphHw==
X-Received: by 2002:a17:906:364e:: with SMTP id r14mr3644852ejb.258.1594721076740;
        Tue, 14 Jul 2020 03:04:36 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id bs18sm14137672edb.38.2020.07.14.03.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 03:04:36 -0700 (PDT)
From:   Saheed Olayemi Bolarinwa <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/14 v4] PCI/PM: Check return value of pcie_capability_read_*()
Date:   Tue, 14 Jul 2020 13:04:45 +0200
Message-Id: <20200714110445.32605-4-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200714110445.32605-1-refactormyself@gmail.com>
References: <20200714110445.32605-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

On failure pcie_capability_read_dword() sets it's last parameter,
val to 0.
However, with Patch 14/14, it is possible that val is set to ~0 on
failure. This would introduce a bug because (x & x) == (~0 & x).

This bug can be avoided if the return value of pcie_capability_read_dword
is checked to confirm success/failure. This check helps ensure that
functions exit only when their post-condition is true. For functions which
walks through device heirarchy like pci_enable_atomic_ops_to_root(), this
is important.

Check the return value of pcie_capability_read_dword() to ensure success.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
---
v4 changes:
Remove unnecessary boolean conversion.
Fix bugs introduced by previous changes

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 4b2a348576cb..d82b79291742 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3207,6 +3207,7 @@ void pci_configure_ari(struct pci_dev *dev)
 {
 	u32 cap;
 	struct pci_dev *bridge;
+	int ret;
 
 	if (pcie_ari_disabled || !pci_is_pcie(dev) || dev->devfn)
 		return;
@@ -3215,8 +3216,8 @@ void pci_configure_ari(struct pci_dev *dev)
 	if (!bridge)
 		return;
 
-	pcie_capability_read_dword(bridge, PCI_EXP_DEVCAP2, &cap);
-	if (!(cap & PCI_EXP_DEVCAP2_ARI))
+	ret = pcie_capability_read_dword(bridge, PCI_EXP_DEVCAP2, &cap);
+	if (ret || !(cap & PCI_EXP_DEVCAP2_ARI))
 		return;
 
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI)) {
@@ -3606,6 +3607,7 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
 	struct pci_bus *bus = dev->bus;
 	struct pci_dev *bridge;
 	u32 cap, ctl2;
+	int ret;
 
 	if (!pci_is_pcie(dev))
 		return -EINVAL;
@@ -3629,28 +3631,29 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
 	while (bus->parent) {
 		bridge = bus->self;
 
-		pcie_capability_read_dword(bridge, PCI_EXP_DEVCAP2, &cap);
+		ret = pcie_capability_read_dword(bridge, PCI_EXP_DEVCAP2,
+								&cap);
 
 		switch (pci_pcie_type(bridge)) {
 		/* Ensure switch ports support AtomicOp routing */
 		case PCI_EXP_TYPE_UPSTREAM:
 		case PCI_EXP_TYPE_DOWNSTREAM:
-			if (!(cap & PCI_EXP_DEVCAP2_ATOMIC_ROUTE))
+			if (ret || !(cap & PCI_EXP_DEVCAP2_ATOMIC_ROUTE))
 				return -EINVAL;
 			break;
 
 		/* Ensure root port supports all the sizes we care about */
 		case PCI_EXP_TYPE_ROOT_PORT:
-			if ((cap & cap_mask) != cap_mask)
+			if (ret || ((cap & cap_mask) != cap_mask))
 				return -EINVAL;
 			break;
 		}
 
 		/* Ensure upstream ports don't block AtomicOps on egress */
 		if (pci_pcie_type(bridge) == PCI_EXP_TYPE_UPSTREAM) {
-			pcie_capability_read_dword(bridge, PCI_EXP_DEVCTL2,
-						   &ctl2);
-			if (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_EGRESS_BLOCK)
+			ret = pcie_capability_read_dword(bridge,
+						PCI_EXP_DEVCTL2, &ctl2);
+			if (!ret && (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_EGRESS_BLOCK)
 				return -EINVAL;
 		}
 
@@ -4507,12 +4510,13 @@ EXPORT_SYMBOL(pci_wait_for_pending_transaction);
 bool pcie_has_flr(struct pci_dev *dev)
 {
 	u32 cap;
+	int ret;
 
 	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
 		return false;
 
-	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
-	return cap & PCI_EXP_DEVCAP_FLR;
+	ret = pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
+	return (!ret && (cap & PCI_EXP_DEVCAP_FLR));
 }
 EXPORT_SYMBOL_GPL(pcie_has_flr);
 
@@ -4646,7 +4650,7 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
 static bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active,
 				     int delay)
 {
-	int timeout = 1000;
+	int rc, timeout = 1000;
 	bool ret;
 	u16 lnk_status;
 
@@ -4671,9 +4675,9 @@ static bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active,
 	if (active)
 		msleep(20);
 	for (;;) {
-		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
-		ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
-		if (ret == active)
+		rc = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
+		ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);	
+		if (!rc && (ret == active))
 			break;
 		if (timeout <= 0)
 			break;
@@ -4682,10 +4686,10 @@ static bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active,
 	}
 	if (active && ret && delay)
 		msleep(delay);
-	else if (ret != active)
+	else if (rc || (ret != active))
 		pci_info(pdev, "Data Link Layer Link Active not %s in 1000 msec\n",
 			active ? "set" : "cleared");
-	return ret == active;
+	return (!rc && (ret == active));
 }
 
 /**
@@ -5774,6 +5778,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 	enum pci_bus_speed next_speed;
 	enum pcie_link_width next_width;
 	u32 bw, next_bw;
+	int ret;
 
 	if (speed)
 		*speed = PCI_SPEED_UNKNOWN;
@@ -5783,7 +5788,12 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 	bw = 0;
 
 	while (dev) {
-		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
+		ret = pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
+
+		if (ret) {
+			dev = pci_upstream_bridge(dev);
+			continue;
+		}
 
 		next_speed = pcie_link_speed[lnksta & PCI_EXP_LNKSTA_CLS];
 		next_width = (lnksta & PCI_EXP_LNKSTA_NLW) >>
@@ -5820,6 +5830,7 @@ EXPORT_SYMBOL(pcie_bandwidth_available);
 enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev)
 {
 	u32 lnkcap2, lnkcap;
+	int ret;
 
 	/*
 	 * Link Capabilities 2 was added in PCIe r3.0, sec 7.8.18.  The
@@ -5830,16 +5841,18 @@ enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev)
 	 * should use the Supported Link Speeds field in Link Capabilities,
 	 * where only 2.5 GT/s and 5.0 GT/s speeds were defined.
 	 */
-	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2, &lnkcap2);
+	ret = pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2, &lnkcap2);
 
 	/* PCIe r3.0-compliant */
-	if (lnkcap2)
+	if (!ret && lnkcap2)
 		return PCIE_LNKCAP2_SLS2SPEED(lnkcap2);
 
-	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
-	if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_5_0GB)
+	ret = pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
+	if (!ret &&
+		((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_5_0GB))
 		return PCIE_SPEED_5_0GT;
-	else if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_2_5GB)
+	else if (!ret &&
+		((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_2_5GB))
 		return PCIE_SPEED_2_5GT;
 
 	return PCI_SPEED_UNKNOWN;
@@ -5856,9 +5869,10 @@ EXPORT_SYMBOL(pcie_get_speed_cap);
 enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev)
 {
 	u32 lnkcap;
+	int ret;
 
-	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
-	if (lnkcap)
+	ret = pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
+	if (!ret && lnkcap)
 		return (lnkcap & PCI_EXP_LNKCAP_MLW) >> 4;
 
 	return PCIE_LNK_WIDTH_UNKNOWN;
