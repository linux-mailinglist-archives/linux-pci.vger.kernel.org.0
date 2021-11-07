Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221584473D0
	for <lists+linux-pci@lfdr.de>; Sun,  7 Nov 2021 17:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbhKGQcn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Nov 2021 11:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235787AbhKGQcl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 Nov 2021 11:32:41 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89411C061714;
        Sun,  7 Nov 2021 08:29:58 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id v11so50205644edc.9;
        Sun, 07 Nov 2021 08:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mdiJ7lzX3Ms7UkaPuy+L6z/d3dXtyRjWewegyVGznlA=;
        b=I5rEqpyCm3FkQBtSl4whncXDqjF4h4SOtN8F7XPh51lTJOp+2uoMfXXZVNf67owu1i
         elg6SyGq9MySmTCnA0ndGZ3RCZecGuGTn3noBhDgPFVSgRvnU9rcT8SJQlQ8FIqOMncl
         btBgWxhI4DC9odwwgYacSVvQkpsusB1Vp6tpqJ9RCuzPytxpzFPzplCT/dZaSDs+hhuy
         9RoXheSibld/cnPUC2yxvzu5jz1zOz/GraM0C9Y8IMY96wLYy8hxBcWy0H6KH4HynkKk
         sElH7JNAHI+sKkpLLEJuFnDnDWlW1xMlMFNbxAG/xsjEbdUxTRA5eVkwlvH+anRUzShV
         JccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mdiJ7lzX3Ms7UkaPuy+L6z/d3dXtyRjWewegyVGznlA=;
        b=7OOto1lgT+orzLTby5/8QEFXx/kLYqpDl8om/Lh0ZnJEclgze7RD7BPEr5wd/j0YkV
         T0YLGPByerOFNsdfgen6QOv4sTTqqruNmzWXlu5Xov1QqzY9gKEjIhPx6P2FOg5BCYNk
         BHXZKIu2ShXT+g3FVishnkQqpY60ivrL9Kz7tjAWYv9lYT4vcZJQIWnStyR0+cSQWeld
         QiJrqFvvG0FM6GvpcqWPDu3aFV54TfHjyGACFWWTC55XyRKa16jNbwAKqwulKlfVW9+Z
         B3QlI2JwbFYCaLAc3gFvtDEoialGDJXa9fU8/tIdD2DY6I7wPyv7gQsgh5wSIeTbl9KF
         7FWg==
X-Gm-Message-State: AOAM532pJYgnNs9Fusq4d3eYXGc19gm5mOdLe4Ti9UhQ3/XkcELQxTXU
        xaE3pv+Qt7Aoq5NSTGNW0WU=
X-Google-Smtp-Source: ABdhPJysDRtCZ1K520GPRXrESIeAxSOLHWwDJPUV3YWakVOE36W4aCfuJC/XJhcbpco1Z0NwoR/Cnw==
X-Received: by 2002:a17:907:168f:: with SMTP id hc15mr4100256ejc.115.1636302597058;
        Sun, 07 Nov 2021 08:29:57 -0800 (PST)
Received: from localhost.localdomain ([2a02:ab88:109:9f0:f6a6:7fbe:807a:e1cc])
        by smtp.googlemail.com with ESMTPSA id hq37sm7195270ejc.116.2021.11.07.08.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 08:29:56 -0800 (PST)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Bolarinwa O. Saheed" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 3/5] PCI/ASPM: Remove struct pcie_link_state.root
Date:   Sun,  7 Nov 2021 17:29:39 +0100
Message-Id: <20211107162941.1196-4-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211107162941.1196-1-refactormyself@gmail.com>
References: <20211107162941.1196-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Bolarinwa O. Saheed" <refactormyself@gmail.com>

Information on the root device is calculated within
alloc_pcie_link_state() and stored in struct pcie_link_state.root.
If this calculation is extracted out, it make it possible to avoid
storing the value

 - extract the calculations of pcie_link_state->root into
   pcie_get_root().
 - remove *root* from the struct pcie_link_state.
 - replace references to struct pcie_link_state.root with
   a call to pcie_get_root().

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 68 +++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 75618302fb87..90c7a0b379f4 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -49,7 +49,6 @@ struct aspm_latency {
 struct pcie_link_state {
 	struct pci_dev *pdev;		/* Upstream component of the Link */
 	struct pci_dev *downstream;	/* Downstream component, function 0 */
-	struct pcie_link_state *root;	/* pointer to the root port link */
 	struct list_head sibling;	/* node in link_list */
 
 	/* ASPM state */
@@ -851,6 +850,25 @@ static int pcie_aspm_sanity_check(struct pci_dev *pdev)
 	return 0;
 }
 
+/*
+ * Root Ports and PCI/PCI-X to PCIe Bridges are roots of PCIe
+ * hierarchies.  Note that some PCIe host implementations omit
+ * the root ports entirely, in which case a downstream port on
+ * a switch may become the root of the link state chain for all
+ * its subordinate endpoints.
+ */
+static struct pci_dev *pcie_get_root(struct pci_dev *pdev)
+{
+	struct pcie_link_state *uplink_bridge = pcie_upstream_link(pdev);
+
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT ||
+	    pci_pcie_type(pdev) == PCI_EXP_TYPE_PCIE_BRIDGE || !uplink_bridge) {
+		return pdev;
+	} else {
+		return pcie_get_root(uplink_bridge->pdev);
+	}
+}
+
 static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
 {
 	struct pcie_link_state *link;
@@ -863,29 +881,6 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
 	link->pdev = pdev;
 	link->downstream = pci_function_0(pdev->subordinate);
 
-	/*
-	 * Root Ports and PCI/PCI-X to PCIe Bridges are roots of PCIe
-	 * hierarchies.  Note that some PCIe host implementations omit
-	 * the root ports entirely, in which case a downstream port on
-	 * a switch may become the root of the link state chain for all
-	 * its subordinate endpoints.
-	 */
-	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT ||
-	    pci_pcie_type(pdev) == PCI_EXP_TYPE_PCIE_BRIDGE ||
-	    !pdev->bus->parent->self) {
-		link->root = link;
-	} else {
-		struct pcie_link_state *uplink_bridge;
-
-		uplink_bridge = pcie_upstream_link(pdev);
-		if (!uplink_bridge) {
-			kfree(link);
-			return NULL;
-		}
-
-		link->root = ulink_bridge->root;
-	}
-
 	list_add(&link->sibling, &link_list);
 	pdev->link_state = link;
 	return link;
@@ -972,20 +967,26 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
 static void pcie_update_aspm_capable(struct pcie_link_state *root)
 {
 	struct pcie_link_state *link;
-	struct pcie_link_state *uplink = pcie_upstream_link(root->pdev);
+	struct pci_dev *dev, *root_dev;
 
-	root = uplink ? uplink->root : root;
+	/* Ensure it is the root device */
+	root_dev = pcie_get_root(root->pdev);
+	root = root_dev ? root_dev->link_state : root;
 
 	list_for_each_entry(link, &link_list, sibling) {
-		if (link->root != root)
+		dev = pcie_get_root(link->pdev);
+		if (dev->link_state != root)
 			continue;
+
 		link->aspm_capable = link->aspm_support;
 	}
 	list_for_each_entry(link, &link_list, sibling) {
 		struct pci_dev *child;
 		struct pci_bus *linkbus = link->pdev->subordinate;
-		if (link->root != root)
+		dev = pcie_get_root(link->pdev);
+		if (dev->link_state != root)
 			continue;
+
 		list_for_each_entry(child, &linkbus->devices, bus_list) {
 			if ((pci_pcie_type(child) != PCI_EXP_TYPE_ENDPOINT) &&
 			    (pci_pcie_type(child) != PCI_EXP_TYPE_LEG_END))
@@ -998,8 +999,8 @@ static void pcie_update_aspm_capable(struct pcie_link_state *root)
 /* @pdev: the endpoint device */
 void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 {
-	struct pci_dev *parent = pdev->bus->self;
-	struct pcie_link_state *link, *root, *uplink_bridge;
+	struct pci_dev *root_dev, *parent = pdev->bus->self;
+	struct pcie_link_state *link, *uplink_bridge;
 
 	if (!parent || !parent->link_state)
 		return;
@@ -1014,7 +1015,7 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 		goto out;
 
 	link = parent->link_state;
-	root = link->root;
+	root_dev = pcie_get_root(link->pdev);
 	uplink_bridge = pcie_upstream_link(link->pdev);
 
 	/* All functions are removed, so just disable ASPM for the link */
@@ -1025,7 +1026,7 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 
 	/* Recheck latencies and configure upstream links */
 	if (uplink_bridge) {
-		pcie_update_aspm_capable(root);
+		pcie_update_aspm_capable(root_dev->link_state);
 		pcie_config_aspm_path(uplink_bridge);
 	}
 out:
@@ -1037,6 +1038,7 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 void pcie_aspm_pm_state_change(struct pci_dev *pdev)
 {
 	struct pcie_link_state *link = pdev->link_state;
+	struct pci_dev *root = pcie_get_root(pdev);
 
 	if (aspm_disabled || !link)
 		return;
@@ -1046,7 +1048,7 @@ void pcie_aspm_pm_state_change(struct pci_dev *pdev)
 	 */
 	down_read(&pci_bus_sem);
 	mutex_lock(&aspm_lock);
-	pcie_update_aspm_capable(link->root);
+	pcie_update_aspm_capable(root->link_state);
 	pcie_config_aspm_path(link);
 	mutex_unlock(&aspm_lock);
 	up_read(&pci_bus_sem);
-- 
2.20.1

