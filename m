Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D5421ED9D
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jul 2020 12:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgGNKEo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jul 2020 06:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgGNKEh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2020 06:04:37 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77C2C061755;
        Tue, 14 Jul 2020 03:04:36 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id z17so16406616edr.9;
        Tue, 14 Jul 2020 03:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AjG9ZXkNlThAdSsdCQVBfTOrnZyMZnOrLKfSK8ObxrE=;
        b=XktoSDHvwVEyA2qSIGNOe+27lD8+It+w/oscI06k1+IugxY4fNo2iArgZd7tJ3tb5O
         RZLCpZitcssWbDWunZax7lwh9Ub95pp+os7YmA1wVFQDvEkawcTNqADWbZKkp6tPST+L
         0s2KtGLEv1ioVe3n135P1Uxczafk+qydGAZ3fXM6ExjpuPgazhaCAFxHSbqeWtQhQZYJ
         UaXEnOhyR07Hvudk1fhTt6QO6f57G7Lu9TsSqwH+516GePqs2elh6vuHaWvsBRyfb9vL
         ijKUVWQqPdfzp/6LgoJCP0wzjZ1REOKByf9BIwseFbU07cEx/bPJr7KvC+/n6vjQqGQ/
         0zJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AjG9ZXkNlThAdSsdCQVBfTOrnZyMZnOrLKfSK8ObxrE=;
        b=ku0vuYgkIqG0JhqPOvabSObs2wT4DAd71DoCBCpIKflyVWwPYK1RnJN4TPr3MLVBi9
         3d5tNvapVs1tcu93AZl6OwicBAnxs15ajElKK5FhCxR9/nR+9eCy2RDu6bQxn6pQjJ/c
         afDIrx2Vz9RphrgaY13qCczdNmyRjXHY8J8lvFXnMMYl6gEYf331NakZgF4mF1HWnGQv
         WNY0efN6o8p5ilnLOob2InpzAnIMpYDTNXTQqtSu5q+UGz6hIumDGuevcw2OcVkRcjeo
         JW5YDuG2/gQO6NWePoFmC6jaYE/DiFOAv5+lBsUHdlrMwU3tnWSs+jcwYBWSNikkVyRr
         xXMw==
X-Gm-Message-State: AOAM532axULvVGz09qzDcibd+MQX2Ef8FX0jNEym2me4HDJkDrcKrDG/
        8i3X6baKGy+dIi+iX1vWCs4=
X-Google-Smtp-Source: ABdhPJw4d+6fAHfArS6YVCLKVPm4T/c8KMuzMlKt/TwrMSjQlmp+/J9pYfzHKZouoVLK/LJ5+omnQQ==
X-Received: by 2002:aa7:c305:: with SMTP id l5mr3754952edq.163.1594721075471;
        Tue, 14 Jul 2020 03:04:35 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id bs18sm14137672edb.38.2020.07.14.03.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 03:04:35 -0700 (PDT)
From:   Saheed Olayemi Bolarinwa <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/14 v4] PCI: Check return value of pcie_capability_read_*()
Date:   Tue, 14 Jul 2020 13:04:44 +0200
Message-Id: <20200714110445.32605-3-refactormyself@gmail.com>
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

This bug can be avoided if the return value of pcie_capability_read_word
is checked to confirm success.

Check the return value of pcie_capability_read_word() to ensure success.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
---
v4 changes:
Remove unnecessary boolean conversion.

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
+	return (!ret && (v & PCI_EXP_DEVCTL_RELAX_EN));
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

