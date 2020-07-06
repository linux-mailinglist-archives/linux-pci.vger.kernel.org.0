Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3C221559A
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jul 2020 12:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbgGFKcC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jul 2020 06:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728960AbgGFKcB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jul 2020 06:32:01 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AEDC061794;
        Mon,  6 Jul 2020 03:32:00 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q15so38663288wmj.2;
        Mon, 06 Jul 2020 03:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t6GU51on/sjAi6p+kLT9PGikn6ea3QP4rvjpiDaqtyQ=;
        b=r5XcN9OqOkS0fFKzvOC+DqsZw3O1pmDYS3v9XcE9r6dq5TDKngHKKcBC1bm8x4m6x1
         jiiQxPMHJezkuGHMalDZJE6TZjXVuubFQQLwCdS0odUeQh42P2gSuwlulB8MT7fOJ+gN
         071Hfr0bxfDdjCPC87n4OW3FqgfVxgyZJ7wBOXN2l4TsuNFEXsqNTUGyNk68OTuyutF5
         6hScBQAHYBV7GXzixO9133/UvmXgd32Sip+SFkIIfOc85Hh7iD76MBYUafKsnKqabWYr
         YNdwMfvZrBzi7nkSQjbLYgg4W65Md9E6RfHi49VoQfkCj0zNBV5AL+NZ7wpDeFArLWwx
         0oug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t6GU51on/sjAi6p+kLT9PGikn6ea3QP4rvjpiDaqtyQ=;
        b=exPiYSwgN1NRoWeSzJC58gTFMyks5aXjTvAGzejk9B0a+OLHkBcOHubK3+IOV1hx89
         gEBoq35AjIKkd1ovZLgu32w1CEskkhyRn+OYcT70ejtl7gqGk3lSKG+0gn47kEEfu87V
         Q50KZUr+72bVenj4XsZklGH4njUu0j6mxM+5eYZFGyU92od9w9SmvWl+j2JzeNcZmbYt
         sdUPrE5lxE9sDaZTfa2RG/csUcaA78EquTZdmxFzn9Kaknxqm1YxTXZXAgXUIHJy8qX/
         g1uIHxYl46SCFPmPIQ8TLCfpUH3wmBfveG7Ud/Jog/znl6w6vQDZ62OoPHMEAxOtbP1i
         MVug==
X-Gm-Message-State: AOAM532PXl1T0RxYvzbu1ur3GiEn5PTZQjGRf3usBxZm6g3wT1YvfqBK
        6e7vbue+oVQSuW6mnc0GRsw=
X-Google-Smtp-Source: ABdhPJyjotNeFrSLhXBXdNTY9AWQbsB9ir2KScfaQcnzXL4qoO9Wo945aZ7sxjmUiMKkvBPv4hfp7A==
X-Received: by 2002:a1c:8117:: with SMTP id c23mr46495692wmd.157.1594031519334;
        Mon, 06 Jul 2020 03:31:59 -0700 (PDT)
Received: from net.saheed (51B7C2DF.dsl.pool.telekom.hu. [81.183.194.223])
        by smtp.gmail.com with ESMTPSA id 22sm24216859wmb.11.2020.07.06.03.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 03:31:58 -0700 (PDT)
From:   Saheed Olayemi Bolarinwa <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/11 RFC] PCI/PM: Use error return value from pcie_capability_read_*()
Date:   Mon,  6 Jul 2020 11:31:18 +0200
Message-Id: <20200706093121.9731-9-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200706093121.9731-1-refactormyself@gmail.com>
References: <20200706093121.9731-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

On failure pcie_capability_read_dword() sets it's last parameter,
val to 0.
However, with Patch 11/11, it is possible that val is set to ~0 on
failure. This would introduce a bug because (x & x) == (~0 & x).

This bug can be avoided if the return value of pcie_capability_read_dword
is checked to confirm success.

Check the return value of pcie_capability_read_dword() to ensure success.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
---
 drivers/pci/pci.c | 52 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ce096272f52b..9f18ffbf7bd4 100644
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
+	return (!ret && !!(cap & PCI_EXP_DEVCAP_FLR));
 }
 EXPORT_SYMBOL_GPL(pcie_has_flr);
 
@@ -4672,7 +4676,7 @@ static bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active,
 		msleep(20);
 	for (;;) {
 		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
-		ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
+		ret = !!(!ret && (lnk_status & PCI_EXP_LNKSTA_DLLLA));
 		if (ret == active)
 			break;
 		if (timeout <= 0)
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
-- 
2.18.2

