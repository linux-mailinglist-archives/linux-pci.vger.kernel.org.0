Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62FCB40D522
	for <lists+linux-pci@lfdr.de>; Thu, 16 Sep 2021 10:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbhIPIxg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Sep 2021 04:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235316AbhIPIxf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Sep 2021 04:53:35 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3273C0613C1;
        Thu, 16 Sep 2021 01:52:14 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id g21so13984449edw.4;
        Thu, 16 Sep 2021 01:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B09QXAmkxO7Uv/3aDjImv67z6YW/x3i4crnjSFm1H6s=;
        b=c5swjq7Xwr+yxhe5ss211K76aHHiaYPquwXj3jkHmWr+9WzNgb8x9YU8acD61e4Ary
         JZLgHVwK5BmhgjQCLtSnntS9oeed9rTnFQxMiHu6+HKOfgdqZQXuMLkmd3WvdffZGVD1
         p5UUEVe4NR6XEBHt6wUMyPLaWk/hM/r8PZxvpFEmR2XQ5O6uWgn8fp40L0Yb9ca/6ZVh
         gUBn4yo8eUyUr0MSYCky8L7qp9quvzQRQVNcNSHdeQzThNQwC9eJkbAoVCdmx5xSZ/Xb
         5dKcp0yO71PzfHHIuDWERrBCHwdRQcEnNmiVdQ1B2pf3R7EnRPYaEy73wy/EKvPdD/WP
         dfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B09QXAmkxO7Uv/3aDjImv67z6YW/x3i4crnjSFm1H6s=;
        b=0+izjrUNnBMgIYiZcmwDI8Y6EDw5iNK49MvOI/FNm4lEYudSXj67UiDVlSTVzyDdNQ
         1T4nljTMNZaqpHIKzeHO/YLxPCuMDI7Wfb1HoI/b3yBLYwC6gfZN5QtyKaLG60mqEkGo
         1EMR8wv/xXSuM77II5uDif8tzyu2zN5lctJe/ozXQLSGEguAfnfo3rXxiBp5z3pcKDun
         rT6ZgLbYddz5uI+fR3irnd6Ak1CuZgIBLg0huUS9YxGMya6ZOjR4M/LSIqSvZ0KlgAVe
         8G8W5a8PpeWmdxWr93y9WHLW4DzCjJL7+6X0WjWOeBeeijuZ9KpdTmuNqYPbJ4EqO2wl
         3QXA==
X-Gm-Message-State: AOAM530GloF0FQEau5rlmeaT/4870zKjGxTmDE3HOr1SNw7eqnc97tRA
        HTOF0mCtFeWafMKiuGar+iY=
X-Google-Smtp-Source: ABdhPJyUZbd9L3cVBxoF/4U1cZ7bllNNLA6Lvf2zU+QH/24bUAvgMPaX1O2dwcZCMMYouOFm6hAAag==
X-Received: by 2002:a17:906:3591:: with SMTP id o17mr5204602ejb.158.1631782333474;
        Thu, 16 Sep 2021 01:52:13 -0700 (PDT)
Received: from localhost.localdomain (catv-176-63-0-115.catv.broadband.hu. [176.63.0.115])
        by smtp.googlemail.com with ESMTPSA id t24sm1112961edr.84.2021.09.16.01.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 01:52:13 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Bolarinwa O. Saheed" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com
Subject: [RFC PATCH 4/4] PCI/ASPM: Remove unncessary linked list defined within aspm.c
Date:   Thu, 16 Sep 2021 10:52:06 +0200
Message-Id: <20210916085206.2268-5-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210916085206.2268-1-refactormyself@gmail.com>
References: <20210916085206.2268-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Bolarinwa O. Saheed" <refactormyself@gmail.com>

aspm.c defines a linked list - `link_list` and stores each of
its node in struct pcie_link_state.sibling. This linked list
tracks devices for which the struct pcie_link_state object
was successfully created. It is used to loop through the list
for instance to set ASPM policy or update changes. However, it
is possible to access these devices via existing lists defined
inside pci.h

This patch:
- removes link_list and struct pcie_link_state.sibling
- accesses child devices via struct pci_dev.bust_list
- accesses all PCI buses via pci_root_buses on struct pci_bus.node

Signed-off-by: Bolarinwa O. Saheed <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 516a6f07ac6e..35bc16c00b32 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -48,7 +48,6 @@ struct aspm_latency {
 
 struct pcie_link_state {
 	struct pci_dev *pdev;		/* Upstream component of the Link */
-	struct list_head sibling;	/* node in link_list */
 
 	/* ASPM state */
 	u32 aspm_support:7;		/* Supported ASPM state */
@@ -76,7 +75,6 @@ struct pcie_link_state {
 static int aspm_disabled, aspm_force;
 static bool aspm_support_enabled = true;
 static DEFINE_MUTEX(aspm_lock);
-static LIST_HEAD(link_list);
 
 #define POLICY_DEFAULT 0	/* BIOS default setting */
 #define POLICY_PERFORMANCE 1	/* high performance */
@@ -872,10 +870,7 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
 	if (!link)
 		return NULL;
 
-	INIT_LIST_HEAD(&link->sibling);
 	link->pdev = pdev;
-
-	list_add(&link->sibling, &link_list);
 	pdev->link_state = link;
 	return link;
 }
@@ -961,21 +956,16 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
 static void pcie_update_aspm_capable(struct pcie_link_state *root)
 {
 	struct pci_dev *dev;
+	struct pci_bus *rootbus = root->pdev->bus;
 	struct pcie_link_state *link;
 	BUG_ON(root->pdev->bus->parent->self);
-	list_for_each_entry(link, &link_list, sibling) {
-		dev = pcie_get_root(link->pdev);
-		if (dev->link_state != root)
-			continue;
-
-		link->aspm_capable = link->aspm_support;
+	list_for_each_entry(dev, &rootbus->devices, bus_list) {
+		dev->link_state->aspm_capable = link->aspm_support;
 	}
-	list_for_each_entry(link, &link_list, sibling) {
+
+	list_for_each_entry(dev, &rootbus->devices, bus_list) {
 		struct pci_dev *child;
-		struct pci_bus *linkbus = link->pdev->subordinate;
-		dev = pcie_get_root(link->pdev);
-		if (dev->link_state != root)
-			continue;
+		struct pci_bus *linkbus = dev->subordinate;
 
 		list_for_each_entry(child, &linkbus->devices, bus_list) {
 			if ((pci_pcie_type(child) != PCI_EXP_TYPE_ENDPOINT) &&
@@ -1012,7 +1002,6 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 
 	/* All functions are removed, so just disable ASPM for the link */
 	pcie_config_aspm_link(link, 0);
-	list_del(&link->sibling);
 	/* Clock PM is for endpoint device */
 	free_link_state(link);
 
@@ -1152,6 +1141,8 @@ static int pcie_aspm_set_policy(const char *val,
 {
 	int i;
 	struct pcie_link_state *link;
+	struct pci_bus *bus;
+	struct pci_dev *pdev;
 
 	if (aspm_disabled)
 		return -EPERM;
@@ -1164,9 +1155,18 @@ static int pcie_aspm_set_policy(const char *val,
 	down_read(&pci_bus_sem);
 	mutex_lock(&aspm_lock);
 	aspm_policy = i;
-	list_for_each_entry(link, &link_list, sibling) {
-		pcie_config_aspm_link(link, policy_to_aspm_state(link));
-		pcie_set_clkpm(link, policy_to_clkpm_state(link));
+	list_for_each_entry(bus, &pci_root_buses, node) {
+		list_for_each_entry(pdev, &bus->devices, bus_list) {
+			if (!pci_is_pcie(pdev))
+				break;
+
+			link = pdev->link_state;
+			if (!link)
+				continue;
+
+			pcie_config_aspm_link(link, policy_to_aspm_state(link));
+			pcie_set_clkpm(link, policy_to_clkpm_state(link));
+		}
 	}
 	mutex_unlock(&aspm_lock);
 	up_read(&pci_bus_sem);
-- 
2.20.1

