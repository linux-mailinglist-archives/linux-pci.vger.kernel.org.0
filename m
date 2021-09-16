Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E8D40D51E
	for <lists+linux-pci@lfdr.de>; Thu, 16 Sep 2021 10:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbhIPIxe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Sep 2021 04:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235398AbhIPIxd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Sep 2021 04:53:33 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFBFC061574;
        Thu, 16 Sep 2021 01:52:13 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v22so9781075edd.11;
        Thu, 16 Sep 2021 01:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j8T7HGGnetyv+ccrok96ONK9Emz86upX7TCAIvuw9K0=;
        b=qzWHHoKWiKeL+WqI56L4EhADlfpp30c0bQ22pTBCX7DJJr1vL9uMNyzMnNDD+Q+5hk
         KQZoM5WnV410FE/hvSvXFKv8cWKYZUixB+sq8MoUmUlmpjxaUPyj1Mt/9LShAzr9CGYp
         IasKpjxyut1a0HDbyFg83agphb06oG+UvE76+JiUM0Uqvbv8sNNpPzLMJN4L/C21r6l4
         3i4tEWUg49Hl4breWi4nO5B6I4KgjQd1nYF6aDU8II0Wm06J9qZhP0+S22ggOVNCcDfg
         qAkhokw3UArivb//wKZVyxkGvFvw+K6CRfhVBRW62eVfYq5B9Wf6S08S6UA6QTBed8Pk
         jvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j8T7HGGnetyv+ccrok96ONK9Emz86upX7TCAIvuw9K0=;
        b=ACPzKmoh57/hftu2ZQ4DTGY8+moaJjB+cX2Wx/V06/EIzTziRuV/gdfzMlOW65P72C
         +jmOEE83gn6gvfePAz1g1Wqv7LN3/BetJ5lpbbOIEVKK2SrfTV3SsU7Tt2ZUKn8RQ66m
         NUd2lBhxZh8CyEQILbZdilVciDg8LSSHV/6awbtcZxr2A+2l7Bj33UNkcsKrprqu9thi
         h+dxMNPlctJnZE9Cdbo40jkFHLMqMkOPIXYrqckyfCtHEzbPPRj6J7XhVmbVUlFrJic6
         hNEhtx21wn9+VbUUYBPq7K2lmV0XPohzlX8VnQSNHEE8HkN2XX+nBGcxGAnfmXXdWL9i
         CcAA==
X-Gm-Message-State: AOAM5337sEYreiSngtqsCeFzIqm+nE6f6xo+p146OORRFncqlOaWQ2ce
        bwUuQLO7fNqyN5apOM09mrKZYc5eO6QG8A==
X-Google-Smtp-Source: ABdhPJwlNOU1viWZUILzezi/S41RXofFODtIuaDQlbofavr6h3/YrkXFFMAP8BZ4dNqwuTzx4TI4pA==
X-Received: by 2002:a17:906:60c2:: with SMTP id f2mr4881832ejk.531.1631782331715;
        Thu, 16 Sep 2021 01:52:11 -0700 (PDT)
Received: from localhost.localdomain (catv-176-63-0-115.catv.broadband.hu. [176.63.0.115])
        by smtp.googlemail.com with ESMTPSA id t24sm1112961edr.84.2021.09.16.01.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 01:52:11 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Bolarinwa O. Saheed" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com
Subject: [RFC PATCH 2/4] PCI/ASPM: Remove struct pcie_link_state.root
Date:   Thu, 16 Sep 2021 10:52:04 +0200
Message-Id: <20210916085206.2268-3-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210916085206.2268-1-refactormyself@gmail.com>
References: <20210916085206.2268-1-refactormyself@gmail.com>
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
 drivers/pci/pcie/aspm.c | 63 +++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 48b83048aa30..8772a4ea4365 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -49,7 +49,6 @@ struct aspm_latency {
 struct pcie_link_state {
 	struct pci_dev *pdev;		/* Upstream component of the Link */
 	struct pci_dev *downstream;	/* Downstream component, function 0 */
-	struct pcie_link_state *root;	/* pointer to the root port link */
 	struct list_head sibling;	/* node in link_list */
 
 	/* ASPM state */
@@ -843,6 +842,25 @@ static int pcie_aspm_sanity_check(struct pci_dev *pdev)
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
+	struct pci_dev *parent = pdev->bus->parent->self;
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
@@ -855,29 +873,6 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
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
-		struct pcie_link_state *parent;
-
-		parent = pdev->bus->parent->self->link_state;
-		if (!parent) {
-			kfree(link);
-			return NULL;
-		}
-
-		link->root = parent->root;
-	}
-
 	list_add(&link->sibling, &link_list);
 	pdev->link_state = link;
 	return link;
@@ -963,18 +958,23 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
 /* Recheck latencies and update aspm_capable for links under the root */
 static void pcie_update_aspm_capable(struct pcie_link_state *root)
 {
+	struct pci_dev *dev;
 	struct pcie_link_state *link;
 	BUG_ON(root->pdev->bus->parent->self);
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
@@ -987,9 +987,9 @@ static void pcie_update_aspm_capable(struct pcie_link_state *root)
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
@@ -1004,7 +1004,7 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 		goto out;
 
 	link = parent->link_state;
-	root = link->root;
+	root_dev = pcie_get_root(link->pdev);
 	parent_dev = link->pdev->bus->parent->self;
 	parent_link = !parent_dev ? NULL : parent_dev->link_state;
 
@@ -1016,7 +1016,7 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 
 	/* Recheck latencies and configure upstream links */
 	if (parent_link) {
-		pcie_update_aspm_capable(root);
+		pcie_update_aspm_capable(root_dev->link_state);
 		pcie_config_aspm_path(parent_link);
 	}
 out:
@@ -1028,6 +1028,7 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 void pcie_aspm_pm_state_change(struct pci_dev *pdev)
 {
 	struct pcie_link_state *link = pdev->link_state;
+	struct pci_dev *root = pcie_get_root(pdev);
 
 	if (aspm_disabled || !link)
 		return;
@@ -1037,7 +1038,7 @@ void pcie_aspm_pm_state_change(struct pci_dev *pdev)
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

