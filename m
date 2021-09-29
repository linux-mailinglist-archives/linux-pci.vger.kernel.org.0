Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A84641BBD4
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 02:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243429AbhI2ApL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 20:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243445AbhI2ApK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Sep 2021 20:45:10 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E650C06161C;
        Tue, 28 Sep 2021 17:43:30 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b26so2134354edt.0;
        Tue, 28 Sep 2021 17:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DSFOLGj+ldMLpWwvrw+YF05JUnP09SptyU46Tu5pKP8=;
        b=MfgLaif9MxDFglnFowBdbImagCB3aKbME40C2VMsZFfRaqtkg8zx2a3ZGNP226ftdB
         NG5O94glOA6iIkWd8srW3nuwD7q4Q12VRASf94jT9kfjtmcW0APWrGgrKiUwcubnYgRz
         TgOi+6w45j2yx53yqWXNwAOXoistDSjfVD8uQsW0FhBBEp52zfEM/y/kkZFQ4VrvJSDN
         zqaGvA9LQfu1KcDatEqBQMa1kxMWWy/CJ79BqOcyWXwPnUmYR9lWeTM/NEOMDjuf4r1p
         3DrGPPdyFzUi+yccCAghI5BnR/0PeqO17RnrjFXXJFIjvW1cM3MQhIUad3yBijStIExX
         tXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DSFOLGj+ldMLpWwvrw+YF05JUnP09SptyU46Tu5pKP8=;
        b=rHTZvLdwCmkcpB9209DV3qaxxDkSkIMU30YsjOPdGDSzwuOSQw8xLnsNDPTekHiwL0
         cmExVfs+wVn75GFgyyyInY5mrXFtuI0gbJBLFp52q2kB42nQTd45pQE8kHXIz1xL63gq
         IojhtVeKyUuHc+beaWKr1mL7vlV1+L0S1Q0SurFUcKVvq4H6g0adfwxEPin0v93cflq6
         icEI2I22D/Q6JJ7BEBFjfMWEDB9QJR5aj4dbar3Db8iJ0Y8nF6RmAQjnNzLTnTsXnqbt
         eacNOI33Bm9a/1BLW9+OLiIV6dvKzcjKLuhohJAJuUSW9+GYrMsCd+AXgXXT/tJaIRf9
         6TsQ==
X-Gm-Message-State: AOAM5308nQ/2R0L8DfKpEU+drHNrjqWia36fBDSm+dB+3Hy/PCKC0p+/
        7TTq6tiOs+QAk5XQADbp+WUpt+ef6rs=
X-Google-Smtp-Source: ABdhPJxorhRNcrxYpwWl+HWgSIvah92yltiH8ybFhvmNOkaRT0MzFhc05p8M/dDnwnjVbfnUvOb+MQ==
X-Received: by 2002:a05:6402:1b8d:: with SMTP id cc13mr11359421edb.235.1632876208678;
        Tue, 28 Sep 2021 17:43:28 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:10f:c9f0:35c7:3af0:a197:61d0])
        by smtp.googlemail.com with ESMTPSA id u16sm358489ejy.14.2021.09.28.17.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 17:43:28 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Bolarinwa O. Saheed" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/4] PCI/ASPM: Remove struct pcie_link_state.root
Date:   Wed, 29 Sep 2021 02:43:13 +0200
Message-Id: <20210929004315.22558-3-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210929004315.22558-1-refactormyself@gmail.com>
References: <20210929004315.22558-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Bolarinwa O. Saheed" <refactormyself@gmail.com>

Information on the root device is cached in
struct pcie_link_state.root it obtained within
alloc_pcie_link_state().

This patch:
 - creates *pcie_get_root()* which return the root pci_dev
   of a pci_dev.
 - removes *root* from the *struct pcie_link_state*.
 - replaces references to struct pcie_link_state.root with
   a call to pcie_get_root().

Signed-off-by: Bolarinwa O. Saheed <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 69 +++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 414c04ffe962..ad78aaeea444 100644
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
+	struct pci_dev *parent = pci_get_parent(pdev);
+
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT ||
+	    pci_pcie_type(pdev) == PCI_EXP_TYPE_PCIE_BRIDGE || !parent) {
+		return pdev;
+	} else {
+		return pcie_get_root(parent);
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
-		struct pci_dev *parent;
-
-		parent = pci_get_parent(pdev);
-		if (!parent->link_state) {
-			kfree(link);
-			return NULL;
-		}
-
-		link->root = parent->link_state->root;
-	}
-
 	list_add(&link->sibling, &link_list);
 	pdev->link_state = link;
 	return link;
@@ -972,21 +967,26 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
 static void pcie_update_aspm_capable(struct pcie_link_state *root)
 {
 	struct pcie_link_state *link;
-	struct pci_dev *parent = pci_get_parent(root->pdev);
+	struct pci_dev *dev, *root_dev;
 
-	if (parent && parent->link_state)
-		root = parent->link_state->root;
+	/* Ensure it is the root device */
+	root_dev = pcie_get_root(root->pdev);
+	root = root_dev ? root_dev->link_state : NULL;
 
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
@@ -999,9 +999,9 @@ static void pcie_update_aspm_capable(struct pcie_link_state *root)
 /* @pdev: the endpoint device */
 void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 {
-	struct pci_dev *parent_dev;
+	struct pci_dev *parent_dev, *root_dev;
 	struct pci_dev *parent = pdev->bus->self;
-	struct pcie_link_state *link, *root, *parent_link;
+	struct pcie_link_state *link, *parent_link;
 
 	if (!parent || !parent->link_state)
 		return;
@@ -1016,7 +1016,7 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 		goto out;
 
 	link = parent->link_state;
-	root = link->root;
+	root_dev = pcie_get_root(link->pdev);
 	parent_dev = pci_get_parent(link->pdev);
 	parent_link = parent_dev ? parent_dev->link_state : NULL;
 
@@ -1028,7 +1028,7 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 
 	/* Recheck latencies and configure upstream links */
 	if (parent_link) {
-		pcie_update_aspm_capable(root);
+		pcie_update_aspm_capable(root_dev->link_state);
 		pcie_config_aspm_path(parent_link);
 	}
 out:
@@ -1040,6 +1040,7 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 void pcie_aspm_pm_state_change(struct pci_dev *pdev)
 {
 	struct pcie_link_state *link = pdev->link_state;
+	struct pci_dev *root = pcie_get_root(pdev);
 
 	if (aspm_disabled || !link)
 		return;
@@ -1049,7 +1050,7 @@ void pcie_aspm_pm_state_change(struct pci_dev *pdev)
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

