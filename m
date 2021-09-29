Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011AF41BBD2
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 02:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243381AbhI2ApK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 20:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243429AbhI2ApJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Sep 2021 20:45:09 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B210C06161C;
        Tue, 28 Sep 2021 17:43:29 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id b26so2134266edt.0;
        Tue, 28 Sep 2021 17:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L+uzfIlDc0/BI6+RnBLdVYHOCavYJo90T/u3FgP+yR4=;
        b=JZIWoZPEH/vCzQi1YHcVWh9bW1DLT9s0gtt6auVL4c/AXCjmag22i1FBcbxGOZ3Xyd
         WH3NQVj5c/e4Vg6PibJPhzMG25yhwzgZaRLqkLM6ZiHgNGDxfLFIanlHYC+lPizpLZXr
         ItRuP3PA4yvrmi8nly2NEw5jBs5EVxDrOTdmfXcv2xRWsgHjJG8Yqd6p3lVgSyOjY2s3
         oXjQi2m+hgu5NfjDYmNww55a9YgoXhH8bJCRLgx0SJI/f94e+zLWQwwm35j3P2SI9SDL
         r4Oq7HdoWoFJrVX3+ny2ynSkl5LyO+py4gdbjj4tin4AqdTF1/T2Lvl4QW+YwsdHEkkL
         S82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L+uzfIlDc0/BI6+RnBLdVYHOCavYJo90T/u3FgP+yR4=;
        b=e9lJOygqRC85OyVGoGOVQ/6KIhCTMnovgJNwZJmH/acbD4Hz7akjJhF/dRuW0THJAZ
         sG4z4s94DqbRd1ema0cA08pvdmq448AXokF82nTtUxU9IdARvdp9sykSo1oYvo3CkleF
         xj3/w+wRfTRhhhyV0h3IiRT+f6ioUqESO8RmWxIsDl4UqiMYrLxh1JE4xq8CmRiw5ZPD
         pqUjnkruBWpNSwTfsDRUJ5LvPkzZ+RaeM0M+0qY306n84iMqZ+QmaJkqXOHcmgNOnrMQ
         Y8iDz5Aj7U7sz9/fLCADzo3gbaJ4B3EiVALpH5kKDKxDXiEekAMlMv4T5MyQghhr/dqH
         HwKQ==
X-Gm-Message-State: AOAM53385ezOZHbZx2j+EUzJV1Gn8QOKW8oSm+Vk5DTbVOxOpdMkx/qi
        q3cs6SG3AjVCQPxlQMxBZXk=
X-Google-Smtp-Source: ABdhPJwFD6mqM5OMmarBKhSmWpJiFrxP/O2BzFQ5JFC6vtaGrLPHU7T9NQM12l4XtYoV0kDlBXD6lA==
X-Received: by 2002:a17:906:b052:: with SMTP id bj18mr10308003ejb.55.1632876207844;
        Tue, 28 Sep 2021 17:43:27 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:10f:c9f0:35c7:3af0:a197:61d0])
        by smtp.googlemail.com with ESMTPSA id u16sm358489ejy.14.2021.09.28.17.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 17:43:27 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Bolarinwa O. Saheed" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 1/4] PCI/ASPM: Remove struct pcie_link_state.parent
Date:   Wed, 29 Sep 2021 02:43:12 +0200
Message-Id: <20210929004315.22558-2-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210929004315.22558-1-refactormyself@gmail.com>
References: <20210929004315.22558-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Bolarinwa O. Saheed" <refactormyself@gmail.com>

Information cached in struct pcie_link_state.parent is accessible
via struct pci_dev.

This patch:
 - removes *parent* from the *struct pcie_link_state*
 - creates pci_get_parent() which returns the parent of a pci_dev
 - replaces references to pcie_link_state.parent with a call to
   pci_get_parent()
 - removes BUG_ON(root->parent), instead uses the parent's root

Signed-off-by: Bolarinwa O. Saheed <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 013a47f587ce..414c04ffe962 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -50,7 +50,6 @@ struct pcie_link_state {
 	struct pci_dev *pdev;		/* Upstream component of the Link */
 	struct pci_dev *downstream;	/* Downstream component, function 0 */
 	struct pcie_link_state *root;	/* pointer to the root port link */
-	struct pcie_link_state *parent;	/* pointer to the parent Link state */
 	struct list_head sibling;	/* node in link_list */
 
 	/* ASPM state */
@@ -139,6 +138,14 @@ static int policy_to_clkpm_state(struct pcie_link_state *link)
 	return 0;
 }
 
+static struct pci_dev *pci_get_parent(struct pci_dev *pdev)
+{
+	if (!pdev || !pdev->bus->parent || !pdev->bus->parent->self)
+		return NULL;
+
+	return pdev->bus->parent->self;
+}
+
 static void pcie_set_clkpm_nocheck(struct pcie_link_state *link, int enable)
 {
 	struct pci_dev *child;
@@ -379,6 +386,7 @@ static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 {
 	u32 latency, l1_switch_latency = 0;
+	struct pci_dev *parent;
 	struct aspm_latency *acceptable;
 	struct pcie_link_state *link;
 
@@ -419,7 +427,8 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 			link->aspm_capable &= ~ASPM_STATE_L1;
 		l1_switch_latency += 1000;
 
-		link = link->parent;
+		parent = pci_get_parent(link->pdev);
+		link = parent ? parent->link_state : NULL;
 	}
 }
 
@@ -793,9 +802,11 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
 
 static void pcie_config_aspm_path(struct pcie_link_state *link)
 {
+	struct pci_dev *parent;
 	while (link) {
 		pcie_config_aspm_link(link, policy_to_aspm_state(link));
-		link = link->parent;
+		parent = pci_get_parent(link->pdev);
+		link = parent ? parent->link_state : NULL;
 	}
 }
 
@@ -864,16 +875,15 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
 	    !pdev->bus->parent->self) {
 		link->root = link;
 	} else {
-		struct pcie_link_state *parent;
+		struct pci_dev *parent;
 
-		parent = pdev->bus->parent->self->link_state;
-		if (!parent) {
+		parent = pci_get_parent(pdev);
+		if (!parent->link_state) {
 			kfree(link);
 			return NULL;
 		}
 
-		link->parent = parent;
-		link->root = link->parent->root;
+		link->root = parent->link_state->root;
 	}
 
 	list_add(&link->sibling, &link_list);
@@ -962,7 +972,11 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
 static void pcie_update_aspm_capable(struct pcie_link_state *root)
 {
 	struct pcie_link_state *link;
-	BUG_ON(root->parent);
+	struct pci_dev *parent = pci_get_parent(root->pdev);
+
+	if (parent && parent->link_state)
+		root = parent->link_state->root;
+
 	list_for_each_entry(link, &link_list, sibling) {
 		if (link->root != root)
 			continue;
@@ -985,6 +999,7 @@ static void pcie_update_aspm_capable(struct pcie_link_state *root)
 /* @pdev: the endpoint device */
 void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 {
+	struct pci_dev *parent_dev;
 	struct pci_dev *parent = pdev->bus->self;
 	struct pcie_link_state *link, *root, *parent_link;
 
@@ -1002,7 +1017,8 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 
 	link = parent->link_state;
 	root = link->root;
-	parent_link = link->parent;
+	parent_dev = pci_get_parent(link->pdev);
+	parent_link = parent_dev ? parent_dev->link_state : NULL;
 
 	/* All functions are removed, so just disable ASPM for the link */
 	pcie_config_aspm_link(link, 0);
-- 
2.20.1

