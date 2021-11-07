Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319AB4473CE
	for <lists+linux-pci@lfdr.de>; Sun,  7 Nov 2021 17:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbhKGQcl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Nov 2021 11:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235784AbhKGQck (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 Nov 2021 11:32:40 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E408C061570;
        Sun,  7 Nov 2021 08:29:57 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id z21so7368153edb.5;
        Sun, 07 Nov 2021 08:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wTTKVOhs/I799H09rjmZEQmciYfZTgIQlicE2Jx3/dI=;
        b=OGrQJr9vPzS8s20yYhTQgkvBOGJ9+Qgal9QlQmZBKVnbi8gppt3Tv+q5zN4QteGLTV
         fDqFdWGBKvIx9ijqXUcv4xFF+/NB9eNZ5aHKFk2CYOckndRTRmf1rsJ25oUv6BFYqGOk
         s1ZbmMDn7sc1yhaYT0LXzBgvxMwycn/O+QXpMXdBCBaMxqV9zHEiJKuNqJ+JUD2THiiV
         lhdxYPAXMhnHdQSyvTU49SIVt5jsjC7uKbSU8AeKAXwX2vJHX1+RpovkYMbj0MRrH34L
         ls2Hj0R/88gzh95AEOAyRjV6AUo753puYXXcW6bnZ4ME80Iza+DKXfCObeJRZANPL9X6
         1g/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wTTKVOhs/I799H09rjmZEQmciYfZTgIQlicE2Jx3/dI=;
        b=oMvZ8TGwhOrJ3MyS8R9cJNlV2yi6LK+ilaGW+zQ/wBat2ATJ8G4qiXzj+WvH32bhiU
         OWchs8Ma3RsK2I5pVksk5DqcaK/BtgYQyvL91h4lv3UHDah7DKkddqDmRb80tlIX1eWn
         vkXM5M2v4zKZrZAHD5ISXeirtlQQKtW1rMBXimyXnMg1NShZ9BqAOeMIbTteii1vV9sh
         NYP+AH85rvfbOEvbCcaXh+Ru+nO0PHrYIyu9fgTCLemEKYqN/mi1OmPuyKDqXxtc74If
         vlKmgZCBDFN8Dfbi2qSrTpAvzPrZHjvZE8wtEvfIEtb0NJVgCKdb2xhXJIefWTzYPwO6
         mkYQ==
X-Gm-Message-State: AOAM533rU1yPN3wZSIihaVr5HSeKS9XiQ2gNNCgRJ0PWTST71RQ5vFvt
        N8yWf63CVUMSCXoVSuhvfJU=
X-Google-Smtp-Source: ABdhPJwvaqxkdw38G9cM22zthlgieTVet8j4doDWTL1ZAgDhWfCqdtX+ZKvHKVra0PGjSWNZpuqdow==
X-Received: by 2002:a17:906:26da:: with SMTP id u26mr90755877ejc.315.1636302596147;
        Sun, 07 Nov 2021 08:29:56 -0800 (PST)
Received: from localhost.localdomain ([2a02:ab88:109:9f0:f6a6:7fbe:807a:e1cc])
        by smtp.googlemail.com with ESMTPSA id hq37sm7195270ejc.116.2021.11.07.08.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 08:29:55 -0800 (PST)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Bolarinwa O. Saheed" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 2/5] PCI/ASPM: Remove struct pcie_link_state.parent
Date:   Sun,  7 Nov 2021 17:29:38 +0100
Message-Id: <20211107162941.1196-3-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211107162941.1196-1-refactormyself@gmail.com>
References: <20211107162941.1196-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Bolarinwa O. Saheed" <refactormyself@gmail.com>

Information cached in struct pcie_link_state.parent is accessible
via struct pci_dev.

 - remove *parent* from the struct pcie_link_state
 - creates pcie_upstream_link() to obtain this value directly
 - replaces references to pcie_link_state.parent with a call to
   pcie_upstream_link()
 - remove BUG_ON(root->parent), instead obtain the root of the
   device returned by pcie_upstream_link

NOTE/CLARIFICATION:
The logic of pcie_upstream_link() especially as expressed in its
use within alloc_pcie_link_state() assumes that:

pdev->bus->parent->self == pdev->bus->self->bus->self

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 013a47f587ce..75618302fb87 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -50,7 +50,6 @@ struct pcie_link_state {
 	struct pci_dev *pdev;		/* Upstream component of the Link */
 	struct pci_dev *downstream;	/* Downstream component, function 0 */
 	struct pcie_link_state *root;	/* pointer to the root port link */
-	struct pcie_link_state *parent;	/* pointer to the parent Link state */
 	struct list_head sibling;	/* node in link_list */
 
 	/* ASPM state */
@@ -139,6 +138,18 @@ static int policy_to_clkpm_state(struct pcie_link_state *link)
 	return 0;
 }
 
+static struct pcie_link_state *pcie_upstream_link(struct pci_dev *dev)
+{
+	struct pci_dev *bridge;
+
+	bridge = pci_upstream_bridge(dev);
+	if (!bridge)
+		return NULL;
+
+	bridge = pci_upstream_bridge(bridge);
+	return bridge ? bridge->link_state : NULL;
+}
+
 static void pcie_set_clkpm_nocheck(struct pcie_link_state *link, int enable)
 {
 	struct pci_dev *child;
@@ -419,7 +430,7 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 			link->aspm_capable &= ~ASPM_STATE_L1;
 		l1_switch_latency += 1000;
 
-		link = link->parent;
+		link = pcie_upstream_link(link->pdev);
 	}
 }
 
@@ -795,7 +806,7 @@ static void pcie_config_aspm_path(struct pcie_link_state *link)
 {
 	while (link) {
 		pcie_config_aspm_link(link, policy_to_aspm_state(link));
-		link = link->parent;
+		link = pcie_upstream_link(link->pdev);
 	}
 }
 
@@ -864,16 +875,15 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
 	    !pdev->bus->parent->self) {
 		link->root = link;
 	} else {
-		struct pcie_link_state *parent;
+		struct pcie_link_state *uplink_bridge;
 
-		parent = pdev->bus->parent->self->link_state;
-		if (!parent) {
+		uplink_bridge = pcie_upstream_link(pdev);
+		if (!uplink_bridge) {
 			kfree(link);
 			return NULL;
 		}
 
-		link->parent = parent;
-		link->root = link->parent->root;
+		link->root = ulink_bridge->root;
 	}
 
 	list_add(&link->sibling, &link_list);
@@ -962,7 +972,10 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
 static void pcie_update_aspm_capable(struct pcie_link_state *root)
 {
 	struct pcie_link_state *link;
-	BUG_ON(root->parent);
+	struct pcie_link_state *uplink = pcie_upstream_link(root->pdev);
+
+	root = uplink ? uplink->root : root;
+
 	list_for_each_entry(link, &link_list, sibling) {
 		if (link->root != root)
 			continue;
@@ -986,7 +999,7 @@ static void pcie_update_aspm_capable(struct pcie_link_state *root)
 void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 {
 	struct pci_dev *parent = pdev->bus->self;
-	struct pcie_link_state *link, *root, *parent_link;
+	struct pcie_link_state *link, *root, *uplink_bridge;
 
 	if (!parent || !parent->link_state)
 		return;
@@ -1002,7 +1015,7 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 
 	link = parent->link_state;
 	root = link->root;
-	parent_link = link->parent;
+	uplink_bridge = pcie_upstream_link(link->pdev);
 
 	/* All functions are removed, so just disable ASPM for the link */
 	pcie_config_aspm_link(link, 0);
@@ -1011,9 +1024,9 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 	free_link_state(link);
 
 	/* Recheck latencies and configure upstream links */
-	if (parent_link) {
+	if (uplink_bridge) {
 		pcie_update_aspm_capable(root);
-		pcie_config_aspm_path(parent_link);
+		pcie_config_aspm_path(uplink_bridge);
 	}
 out:
 	mutex_unlock(&aspm_lock);
-- 
2.20.1

