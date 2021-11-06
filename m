Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22486446F96
	for <lists+linux-pci@lfdr.de>; Sat,  6 Nov 2021 18:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbhKFR5x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Nov 2021 13:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbhKFR5w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Nov 2021 13:57:52 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD914C061714;
        Sat,  6 Nov 2021 10:55:10 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id j21so44590923edt.11;
        Sat, 06 Nov 2021 10:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mdiJ7lzX3Ms7UkaPuy+L6z/d3dXtyRjWewegyVGznlA=;
        b=U5brS4q+ZV/VyyfCbC/Jj+7up3l0DMIB5wUkEXlLpdcDXuS1zkYTVfj7Es3cblrwfR
         nU3lGcf6o6eVU2ZxksREOegaCfmMRPlV+H/wsqot3hYPUe3TinQnNGnRtfTHXhhmc2o5
         S2wfOZyHhiLpO5rY0Vq7IgfWqk+q6Mv9qgoBRxLDL5FG0UKarvYVYECAOalAldp0a8tX
         hXxNTo7SQFver3iOqmcSq1lqIK2zx0omDf1f94/LiJv6RVEL79VcE1S4a+oSaGxYe7d+
         OKItILjmkDoreJsEYhX1vwPetJSNdb2CzDdIMvtuM80WBUnFYwDpWlfKgVG/FhpvjP6H
         777A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mdiJ7lzX3Ms7UkaPuy+L6z/d3dXtyRjWewegyVGznlA=;
        b=PGllBAV+IdQsX+jrnIN3RMKn9ZnmuN//3XtA7gaSKoI3kaAUmYJ2zCa91enrhY43ef
         4dzDr37npXsIgVZhZ/DljJoYoQhpPnGBJlt+5TwTzZygkzHbYXXhTwnMmEBEzvEGPWbw
         VmiMqCT/x0sKPVJXW5BdJkcZHMC6dtp4qWPDhe5v3MI1Oh0sHbP5s/78ofV4gnsCjKvz
         w2MI779vDeY313iL1jWpBG36+KJ/bGeEj+N6EKncYIFiYiY8JAYMAYt2US3i1yjYMTq0
         aqQCdxH8Ypld4GO0P/agjmu57B5f0HmTPgkEWPjfVcFsSZhFbVt18JkhHoefI6cbxjFe
         6YAg==
X-Gm-Message-State: AOAM532/9hcn4X7HJfLeI/FUSHWInhxqRAAyDuqQ+ukLvq2d4k97Ggg9
        tr/9B348K9LlwAN3nMz8EZ7WentrXNE=
X-Google-Smtp-Source: ABdhPJzeAczhbQq1/KPY2amb0QUPRmTY6o8zUiacMimDcZHRGUOK8evCnV9roemFO5g5D+6+5eAgpw==
X-Received: by 2002:a17:906:8a62:: with SMTP id hy2mr39004642ejc.347.1636221309296;
        Sat, 06 Nov 2021 10:55:09 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:109:9f0:f6a6:7fbe:807a:e1cc])
        by smtp.googlemail.com with ESMTPSA id 25sm6542848edw.19.2021.11.06.10.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 10:55:08 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Bolarinwa O. Saheed" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 3/5] PCI/ASPM: Remove struct pcie_link_state.root
Date:   Sat,  6 Nov 2021 18:55:01 +0100
Message-Id: <20211106175503.27178-4-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211106175503.27178-1-refactormyself@gmail.com>
References: <20211106175503.27178-1-refactormyself@gmail.com>
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

