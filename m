Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E880446F99
	for <lists+linux-pci@lfdr.de>; Sat,  6 Nov 2021 18:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbhKFR54 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Nov 2021 13:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbhKFR5y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Nov 2021 13:57:54 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F811C061570;
        Sat,  6 Nov 2021 10:55:12 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id m14so44030357edd.0;
        Sat, 06 Nov 2021 10:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zNMcoDy+urPCjbL8WvhZ7GWXlrRboR3b2AarG7TVayM=;
        b=PDonr5eSpV0B1wWMCsPholmfVIfaH8T2XamfJx/zwpdV6Nl6rferfudFs/Adt/nZic
         lnJPdyZ0VML73yL1dYvOvH1bV5Lx1vZEZAcewsU/RSObmCLc59T9e65NTWqL09MebmnQ
         fkK8CdRql5lZoFZ6UWdX91Tz3NQKNRMjbQdPTjeyUC4yqtDmqt3u7Ns3byskgNqzLHqO
         pN8jogywzHh9O9ojuoWlpBnU/JGpCINf8lKXNzOql2pHC/pq55UbEuzjnZSwn6qBy0qd
         PqYgzljUrtVXD5g6KwLNtFAA902VFPO3jCPuhIYAuCpPKhZE3jH08XZbfdThSN1fqj/j
         XDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zNMcoDy+urPCjbL8WvhZ7GWXlrRboR3b2AarG7TVayM=;
        b=pV5KGNZh3iuV4f9WPm2a6FUWon4aH6NbUZp+FuAcjpTldv5aELEjmUDC2XyYoGkFev
         nE5hzSChBK8A6EARTxKwI0eejchykNsYl+LMoGC3UfS7ktIc8bUMkrg6kobghYKjsKWS
         9Oz8LHFpQaPlloF3IFuDGOo4cQR8iZdN45dEdEZR3NKJq3GstenSWrOsUNMKPMbHwO4W
         m3XX298mf9lKNlOSE6Cijk/3dE2K9TK8nCdoPClKn4MYLYz4EpA0e+DXGEGaGy9p1YfA
         NVwgsFqlUO5rayn3mQTiJpi8i1GSDrCBHIeYr8L6F5KxzfSnLzMnD83/Z1TeaNzVPkxU
         VVKQ==
X-Gm-Message-State: AOAM530F9NL8axF2NNQdVIuCRXoZzeSsNPYXEIQIZwfcWc7Z4rlmwdHr
        qUj2ACRVd9c43Ig9frwCDNNohEhCpAI=
X-Google-Smtp-Source: ABdhPJy+nNjrpZL5EWmz+2ExevSX0dZ2XgfhvixJqGi4/BbaMn1lgJnLhZX5uyRLXncZQcZ5ZWt/AQ==
X-Received: by 2002:a17:906:6149:: with SMTP id p9mr79339640ejl.362.1636221311076;
        Sat, 06 Nov 2021 10:55:11 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:109:9f0:f6a6:7fbe:807a:e1cc])
        by smtp.googlemail.com with ESMTPSA id 25sm6542848edw.19.2021.11.06.10.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 10:55:10 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Bolarinwa O. Saheed" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 5/5] PCI/ASPM: Remove unncessary linked list from aspm.c
Date:   Sat,  6 Nov 2021 18:55:03 +0100
Message-Id: <20211106175503.27178-6-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211106175503.27178-1-refactormyself@gmail.com>
References: <20211106175503.27178-1-refactormyself@gmail.com>
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

- removes link_list and struct pcie_link_state.sibling
- accesses child devices via struct pci_dev.bust_list
- create pcie_config_bus_devices() which walk across the device
  heirarchies linked to the bus
- accesses all PCI buses via pci_root_buses on struct pci_bus.node

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 53 +++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 12623556f750..65da034dc290 100644
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
@@ -880,10 +878,7 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
 	if (!link)
 		return NULL;
 
-	INIT_LIST_HEAD(&link->sibling);
 	link->pdev = pdev;
-
-	list_add(&link->sibling, &link_list);
 	pdev->link_state = link;
 	return link;
 }
@@ -970,24 +965,22 @@ static void pcie_update_aspm_capable(struct pcie_link_state *root)
 {
 	struct pcie_link_state *link;
 	struct pci_dev *dev, *root_dev;
+	struct pci_bus *rootbus = root->pdev->bus;
 
 	/* Ensure it is the root device */
 	root_dev = pcie_get_root(root->pdev);
 	root = root_dev ? root_dev->link_state : root;
 
-	list_for_each_entry(link, &link_list, sibling) {
-		dev = pcie_get_root(link->pdev);
-		if (dev->link_state != root)
+	list_for_each_entry(dev, &rootbus->devices, bus_list) {
+		if (!dev->link_state)
 			continue;
 
-		link->aspm_capable = link->aspm_support;
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
@@ -1022,7 +1015,6 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 
 	/* All functions are removed, so just disable ASPM for the link */
 	pcie_config_aspm_link(link, 0);
-	list_del(&link->sibling);
 	/* Clock PM is for endpoint device */
 	free_link_state(link);
 
@@ -1157,11 +1149,33 @@ int pci_disable_link_state(struct pci_dev *pdev, int state)
 }
 EXPORT_SYMBOL(pci_disable_link_state);
 
+static void pcie_config_bus_devices(struct pci_bus *bus)
+{
+	struct pci_dev *pdev;
+	struct pcie_link_state *link;
+
+	list_for_each_entry(pdev, &bus->devices, bus_list) {
+		if (!pci_is_pcie(pdev))
+			break;
+
+		link = pdev->link_state;
+		if (!link)
+			continue;
+
+		pcie_config_aspm_link(link, policy_to_aspm_state(link));
+		pcie_set_clkpm(link, policy_to_clkpm_state(link));
+
+		/* if this is a bridge, cross it */
+		if (pdev->subordinate && pdev->subordinate != bus)
+			pcie_config_bus_devices(pdev->subordinate);
+	}
+}
+
 static int pcie_aspm_set_policy(const char *val,
 				const struct kernel_param *kp)
 {
 	int i;
-	struct pcie_link_state *link;
+	struct pci_bus *bus;
 
 	if (aspm_disabled)
 		return -EPERM;
@@ -1174,10 +1188,9 @@ static int pcie_aspm_set_policy(const char *val,
 	down_read(&pci_bus_sem);
 	mutex_lock(&aspm_lock);
 	aspm_policy = i;
-	list_for_each_entry(link, &link_list, sibling) {
-		pcie_config_aspm_link(link, policy_to_aspm_state(link));
-		pcie_set_clkpm(link, policy_to_clkpm_state(link));
-	}
+	list_for_each_entry(bus, &pci_root_buses, node)
+		pcie_config_bus_devices(bus);
+
 	mutex_unlock(&aspm_lock);
 	up_read(&pci_bus_sem);
 	return 0;
-- 
2.20.1

