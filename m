Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E75234604
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jul 2020 14:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733254AbgGaMnM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Jul 2020 08:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733101AbgGaMnL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Jul 2020 08:43:11 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B9AC061574;
        Fri, 31 Jul 2020 05:43:11 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id w9so31265152ejc.8;
        Fri, 31 Jul 2020 05:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mu3KVS+jjnoE6TtDYHUGs04kgKz7VUXIOhtqaMe4L8k=;
        b=GMfvm+H2DwlxEhK0B+zbV8ssTcAL/5E/KjNfTanwFqrgfEUOmkR2UszOuUm7NVCrQN
         H2yKipSG9Y/TmMbjseu0nl0keYDGluJ3fDRpgdZMJeRxgqTstTW1wzvsWGDuVuoDlVaG
         bFRd5gafMnXo9eD/Euk/xm9KE8aw4gVr92jhqjEGso5l+IGn0sc4KAhJwkE5lN3sZ9Ww
         tLF3HFcNAuCgtTL7/81bU/WDHJahrvkMneLlHmiZpZgEuiTaOEBcpzcnrcI68OL9WVn+
         6m93gwcBBdMRa2MIn6d7Il9Aus1rFT1xzX9fJLS00rEOMyzvX5yoky8uGiW+iKYQci1j
         PHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mu3KVS+jjnoE6TtDYHUGs04kgKz7VUXIOhtqaMe4L8k=;
        b=Tn2hy4p6XxwT+i5z9e3bhH+rFz75HgArbwgTvkHXE7FaB/EI6Wsl8Xm7yCq2ymD/Vp
         MMsl79pqFkvJAIj8bpdK7vgB7s7IN07qHNL+OlKfbjhR8qtWjbHdek+pVlWKX1veN4Ki
         96ImNksy9a4xCyhCRQJQj7n+VxalhUmZR8FWiRxTQY1TQJd94h8P7o6kJ3RMydZ6oWLX
         1acBlMROOAv4Ma89/svbzSqkZwyUnqHy7RHbQFtitsFx/JMN5sDh9uL7JQrm4Ihe7umg
         M7uxAUSk7vE8fLxZ/12I8EnBlHq6z1yDskAq5jEGs82vgWFQ05NEo/B1MthAgjB9dDHp
         njbQ==
X-Gm-Message-State: AOAM533fmf1c/DT7QI70oFwKZwnc1yEfDg9opXvPTSesLBWG5INO93oa
        F4jmAFNjnQzI2EPMyNnIedU=
X-Google-Smtp-Source: ABdhPJzFvrIqdL0TTLhGyuFNtlAocl0tVTusk/30IvWSRwDYeEoMZH80mm/NNJqy7fAqpVg+0+r2Gg==
X-Received: by 2002:a17:906:26d6:: with SMTP id u22mr4066761ejc.271.1596199390289;
        Fri, 31 Jul 2020 05:43:10 -0700 (PDT)
Received: from net.saheed (95C84E0A.dsl.pool.telekom.hu. [149.200.78.10])
        by smtp.gmail.com with ESMTPSA id g23sm8668514ejb.24.2020.07.31.05.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 05:43:09 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/12] PCI/PM: Check if pcie_capability_read_*() reads ~0
Date:   Fri, 31 Jul 2020 13:43:26 +0200
Message-Id: <20200731114329.100848-2-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200731114329.100848-1-refactormyself@gmail.com>
References: <20200731114329.100848-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On failure pcie_capability_read_*() sets it's last parameter, val
to 0. However, with Patch 12/12, it is possible that val is set
to ~0 on failure. This would introduce a bug because
(x & x) == (~0 & x).

Since ~0 is an invalid value in here,

Add extra check for ~0 to ensure success or failure.

pci_enable_atomic_ops_to_root():
Continue looping through the device heirarchy on failure.

pcie_wait_for_link_delay():
Add extra check for ~0 to the condition for breaking out of the
loop. Delay only on success otherwise report error and return
false.

pcie_bandwidth_available():
On read failure move up the device heirarchy and continue.

pcie_get_speed_cap():
On read failure, report error and return PCI_SPEED_UNKNOWN

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pci.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c9338f914a0e..1dd3659f1388 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3216,7 +3216,7 @@ void pci_configure_ari(struct pci_dev *dev)
 		return;
 
 	pcie_capability_read_dword(bridge, PCI_EXP_DEVCAP2, &cap);
-	if (!(cap & PCI_EXP_DEVCAP2_ARI))
+	if ((cap == (u32)~0) || !(cap & PCI_EXP_DEVCAP2_ARI))
 		return;
 
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI)) {
@@ -3635,13 +3635,13 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
 		/* Ensure switch ports support AtomicOp routing */
 		case PCI_EXP_TYPE_UPSTREAM:
 		case PCI_EXP_TYPE_DOWNSTREAM:
-			if (!(cap & PCI_EXP_DEVCAP2_ATOMIC_ROUTE))
+			if ((cap == (u32)~0) || !(cap & PCI_EXP_DEVCAP2_ATOMIC_ROUTE))
 				return -EINVAL;
 			break;
 
 		/* Ensure root port supports all the sizes we care about */
 		case PCI_EXP_TYPE_ROOT_PORT:
-			if ((cap & cap_mask) != cap_mask)
+			if ((cap == (u32)~0) || ((cap & cap_mask) != cap_mask)
 				return -EINVAL;
 			break;
 		}
@@ -3650,7 +3650,7 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
 		if (pci_pcie_type(bridge) == PCI_EXP_TYPE_UPSTREAM) {
 			pcie_capability_read_dword(bridge, PCI_EXP_DEVCTL2,
 						   &ctl2);
-			if (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_EGRESS_BLOCK)
+			if ((ctl2 != (u32)~0) && (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_EGRESS_BLOCK))
 				return -EINVAL;
 		}
 
@@ -4512,7 +4512,7 @@ bool pcie_has_flr(struct pci_dev *dev)
 		return false;
 
 	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
-	return cap & PCI_EXP_DEVCAP_FLR;
+	return ((cap != (u32)~0) && (cap & PCI_EXP_DEVCAP_FLR));
 }
 EXPORT_SYMBOL_GPL(pcie_has_flr);
 
@@ -4672,19 +4672,19 @@ static bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active,
 	for (;;) {
 		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
 		ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
-		if (ret == active)
+		if ((lnk_status != (u16)~0) && (ret == active))
 			break;
 		if (timeout <= 0)
 			break;
 		msleep(10);
 		timeout -= 10;
 	}
-	if (active && ret)
+	if ((lnk_status != (u16)~0) && active && ret)
 		msleep(delay);
-	else if (ret != active)
+	else if ((lnk_status == (u16)~0) || (ret != active))
 		pci_info(pdev, "Data Link Layer Link Active not %s in 1000 msec\n",
 			active ? "set" : "cleared");
-	return ret == active;
+	return ((lnk_status != (u16)~0) && (ret == active));
 }
 
 /**
@@ -5773,6 +5773,11 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 	while (dev) {
 		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
 
+		if (lnksta == (u16)~0) {
+			dev = pci_upstream_bridge(dev);
+			continue;
+		}
+
 		next_speed = pcie_link_speed[lnksta & PCI_EXP_LNKSTA_CLS];
 		next_width = (lnksta & PCI_EXP_LNKSTA_NLW) >>
 			PCI_EXP_LNKSTA_NLW_SHIFT;
@@ -5819,12 +5824,21 @@ enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev)
 	 * where only 2.5 GT/s and 5.0 GT/s speeds were defined.
 	 */
 	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2, &lnkcap2);
+	if (lnkcap2 == (u32)~0) {
+		dev_err(dev, "Read link speed capability has failed.\n");
+		return PCI_SPEED_UNKNOWN;
+	}
 
 	/* PCIe r3.0-compliant */
 	if (lnkcap2)
 		return PCIE_LNKCAP2_SLS2SPEED(lnkcap2);
 
 	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
+	if (lnkcap == (u32)~0) {
+		dev_err(dev, "Read link speed capability has failed.\n");
+		return PCI_SPEED_UNKNOWN;
+	}
+
 	if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_5_0GB)
 		return PCIE_SPEED_5_0GT;
 	else if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_2_5GB)
@@ -5846,7 +5860,7 @@ enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev)
 	u32 lnkcap;
 
 	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
-	if (lnkcap)
+	if (lnkcap && (lnkcap != (u32)~0))
 		return (lnkcap & PCI_EXP_LNKCAP_MLW) >> 4;
 
 	return PCIE_LNK_WIDTH_UNKNOWN;
-- 
2.18.4

