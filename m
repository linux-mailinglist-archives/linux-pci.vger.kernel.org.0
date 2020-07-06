Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC548215598
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jul 2020 12:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbgGFKcA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jul 2020 06:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728950AbgGFKb7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jul 2020 06:31:59 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70744C061794;
        Mon,  6 Jul 2020 03:31:59 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j4so37813161wrp.10;
        Mon, 06 Jul 2020 03:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h+kDFiIJUTsKW3n99UHZzrHB6kCAOHxPSRHyJei2C70=;
        b=hcaH530k48yc7s44pzmTgEgAKe9ym1JiRcDUKaoV18znhk84JN+6UTSautPPpn/KG5
         nfAWKFT49ue3SEQWExx2mPrSI3lwqdISJCA+tAfHLR9qo0ANtg9CjpYqWlfgTzDLrtL/
         6wuwGn0C/Q+amjCZ7I1KJdizN+8zBIkb6vzagJnHabiLCafVUDdKFjoWM0MSZoFiPA7H
         b5uPNVJrMStmy/Q3pf1Jvf+GOLEBum7VlB+0LXnPuZG6UX34bJD4/XKXzwREw/7jM2wW
         Su5BSnTS7RGuSww61CwHesVyp4m81v1ME537f62iMgNl8wH/qWgMH9R1YgBFKSwnwEoV
         0W5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h+kDFiIJUTsKW3n99UHZzrHB6kCAOHxPSRHyJei2C70=;
        b=PEnemhDXC8mfwWTJYwn+/ly8AAGxYeIhmB9LqxoMk4aAzqBIWRPgeASO+7qmZRMPKz
         TUeCUKMHlW2lM96Hff0L9X3v3FrcJsuYzHFAfzpuaTb1SqB0Iy0rarlMUNE7RMTR8Bz2
         BKaMlrXDilOUyLWBRwcSsyrj5os3IsPcrVmfUyS0IIWjl4Ps/6u1xPga1qCyrHYt1f2O
         ioYTKwB3/a0dzujQZg5QTCoyK8BQf2EudZ50RIz1eIpq29BsV4qk4hHjVACibmh8tbRX
         e7zPEszhq/ZKlGfQ6YTNPVulDVCmlqVWApnKJVeJPN0rzUp4wcZfe/4aTIh8tIucLKZ6
         lTKw==
X-Gm-Message-State: AOAM531ZrskBZ9Mn23SsR2KGlDu/RZ4OZ1nOT9xcJtf5SfRM6EuWyv0z
        Af+JDdaJo1C1AjmGTU19W70=
X-Google-Smtp-Source: ABdhPJwVg1BymNode15ugRIv8aKKBbIQzIjGgGl2HqCXAiJO/2zF3/GZe/M/NE/k4imThhnK3ydmwQ==
X-Received: by 2002:adf:e5d0:: with SMTP id a16mr45907268wrn.48.1594031518242;
        Mon, 06 Jul 2020 03:31:58 -0700 (PDT)
Received: from net.saheed (51B7C2DF.dsl.pool.telekom.hu. [81.183.194.223])
        by smtp.gmail.com with ESMTPSA id 22sm24216859wmb.11.2020.07.06.03.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 03:31:57 -0700 (PDT)
From:   Saheed Olayemi Bolarinwa <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/11 RFC] PCI: Validate with the return value of pcie_capability_read_*()
Date:   Mon,  6 Jul 2020 11:31:17 +0200
Message-Id: <20200706093121.9731-8-refactormyself@gmail.com>
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
 drivers/pci/probe.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2f66988cea25..3c87a8a1d4b5 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1121,10 +1121,11 @@ EXPORT_SYMBOL(pci_add_new_bus);
 static void pci_enable_crs(struct pci_dev *pdev)
 {
 	u16 root_cap = 0;
+	int ret;
 
 	/* Enable CRS Software Visibility if supported */
-	pcie_capability_read_word(pdev, PCI_EXP_RTCAP, &root_cap);
-	if (root_cap & PCI_EXP_RTCAP_CRSVIS)
+	ret = pcie_capability_read_word(pdev, PCI_EXP_RTCAP, &root_cap);
+	if (!ret && (root_cap & PCI_EXP_RTCAP_CRSVIS))
 		pcie_capability_set_word(pdev, PCI_EXP_RTCTL,
 					 PCI_EXP_RTCTL_CRSSVE);
 }
@@ -1519,9 +1520,10 @@ void set_pcie_port_type(struct pci_dev *pdev)
 void set_pcie_hotplug_bridge(struct pci_dev *pdev)
 {
 	u32 reg32;
+	int ret;
 
-	pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &reg32);
-	if (reg32 & PCI_EXP_SLTCAP_HPC)
+	ret = pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &reg32);
+	if (!ret && (reg32 & PCI_EXP_SLTCAP_HPC))
 		pdev->is_hotplug_bridge = 1;
 }
 
@@ -2057,10 +2059,11 @@ int pci_configure_extended_tags(struct pci_dev *dev, void *ign)
 bool pcie_relaxed_ordering_enabled(struct pci_dev *dev)
 {
 	u16 v;
+	int ret;
 
-	pcie_capability_read_word(dev, PCI_EXP_DEVCTL, &v);
+	ret = pcie_capability_read_word(dev, PCI_EXP_DEVCTL, &v);
 
-	return !!(v & PCI_EXP_DEVCTL_RELAX_EN);
+	return (!ret && !!(v & PCI_EXP_DEVCTL_RELAX_EN));
 }
 EXPORT_SYMBOL(pcie_relaxed_ordering_enabled);
 
@@ -2096,16 +2099,17 @@ static void pci_configure_ltr(struct pci_dev *dev)
 	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
 	struct pci_dev *bridge;
 	u32 cap, ctl;
+	int ret;
 
 	if (!pci_is_pcie(dev))
 		return;
 
-	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
-	if (!(cap & PCI_EXP_DEVCAP2_LTR))
+	ret = pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
+	if (ret || !(cap & PCI_EXP_DEVCAP2_LTR))
 		return;
 
-	pcie_capability_read_dword(dev, PCI_EXP_DEVCTL2, &ctl);
-	if (ctl & PCI_EXP_DEVCTL2_LTR_EN) {
+	ret = pcie_capability_read_dword(dev, PCI_EXP_DEVCTL2, &ctl);
+	if (!ret && (ctl & PCI_EXP_DEVCTL2_LTR_EN)) {
 		if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
 			dev->ltr_path = 1;
 			return;
@@ -2142,12 +2146,13 @@ static void pci_configure_eetlp_prefix(struct pci_dev *dev)
 	struct pci_dev *bridge;
 	int pcie_type;
 	u32 cap;
+	int ret;
 
 	if (!pci_is_pcie(dev))
 		return;
 
-	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
-	if (!(cap & PCI_EXP_DEVCAP2_EE_PREFIX))
+	ret = pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
+	if (ret || !(cap & PCI_EXP_DEVCAP2_EE_PREFIX))
 		return;
 
 	pcie_type = pci_pcie_type(dev);
-- 
2.18.2

