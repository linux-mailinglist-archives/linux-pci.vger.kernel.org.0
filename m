Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1EB446F94
	for <lists+linux-pci@lfdr.de>; Sat,  6 Nov 2021 18:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbhKFR5w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Nov 2021 13:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbhKFR5v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Nov 2021 13:57:51 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4ADC061570;
        Sat,  6 Nov 2021 10:55:09 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id c8so28018867ede.13;
        Sat, 06 Nov 2021 10:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wTTKVOhs/I799H09rjmZEQmciYfZTgIQlicE2Jx3/dI=;
        b=fP6LQ6dAJc52TmEgncKsSnHKMLSZeF1qai0kdTkhDU4JCSaaHc7FK1kZiKPlRM2Zcu
         jW0pL+DthYMtxKvHvfZ3evYvEKo8MGqoRCzFTXaAIrKBTDHwaWKu8BUXrNCdOQX1KI6N
         eZNUA23cmxWYMDU+U80DgU6PVuBpXJMOq4CnnQj9Uynhs12uSesrwQmmfswEay0N979l
         sieRwU+LNsm7x3xit6LNhyALz46A1aNsywLhB+M5nQPRTcXd66AgQtvw39zFZ/kbyCbe
         2t+6bA47XFjNT//NKw6Vm5WA23NgiiRxQKUNY5ccAnX5LfgNm/0p/zgoJKp5kbmWbtkE
         4qHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wTTKVOhs/I799H09rjmZEQmciYfZTgIQlicE2Jx3/dI=;
        b=itdR+O9jgnpClgP0rwJo+GR963y+8jxA/PBnMWiUT8OxcbcPD1qLlSnaTzEZBBAsn2
         u0qf2lyJwun602xtc7BCpYQch+If+MAOLS/7HU1aDViewZGInFWIYIxhmXgx3wH5WtK9
         0y7eDbCNKEiL6zTrXFsHD2R7ptrXW989gM55Rq1B2oAlB1kUtdG5EIr/39P7YDymZHRj
         VRBf3yUVUAFarVeg/e3biYLZF4tRCk4sFVrNPxStqvhgf1WnGBHkbVm7MWlTWM5uUH14
         hMtZKXk+s8uSKFA9FxjM1b0i80DkrcPYVwyxYFE1ooJ1x4CtTPbSVxpsLA1iZn6YX5ZK
         k+lQ==
X-Gm-Message-State: AOAM533p1oZv1KAFHdv02DB3Yo08DoAe/JfY7S4dmgsNZVmcXpl04HTU
        JHMg+r/IsVkfZN8mlLwkGU1RuM3eKlQ=
X-Google-Smtp-Source: ABdhPJxNbluPO1DgW4gCj+wmoSdDbQB5Svm1eVcQdx0xbuUyd++cwBGIpBdC9ZLoLENRkzmIkivuaA==
X-Received: by 2002:a17:906:a057:: with SMTP id bg23mr22245742ejb.375.1636221308452;
        Sat, 06 Nov 2021 10:55:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:109:9f0:f6a6:7fbe:807a:e1cc])
        by smtp.googlemail.com with ESMTPSA id 25sm6542848edw.19.2021.11.06.10.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 10:55:08 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Bolarinwa O. Saheed" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 2/5] PCI/ASPM: Remove struct pcie_link_state.parent
Date:   Sat,  6 Nov 2021 18:55:00 +0100
Message-Id: <20211106175503.27178-3-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211106175503.27178-1-refactormyself@gmail.com>
References: <20211106175503.27178-1-refactormyself@gmail.com>
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

