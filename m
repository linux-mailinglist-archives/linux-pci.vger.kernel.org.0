Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46A34473D2
	for <lists+linux-pci@lfdr.de>; Sun,  7 Nov 2021 17:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbhKGQco (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Nov 2021 11:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbhKGQcn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 Nov 2021 11:32:43 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A74C061570;
        Sun,  7 Nov 2021 08:30:00 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id x15so21541747edv.1;
        Sun, 07 Nov 2021 08:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mnh2Je31kXke/FQYVUvveakBauZ5U23X82U3Kp0Tx3M=;
        b=pPJ8t2F2hYPuA0XqqwyPMokwhNggc2Zh2Gh9kergnf6M0TqiTK/EgVJJAvY5j8Ug7b
         JXQgwKeJ8bBhZ7Ze+3q29Wz7J04pgoha83RG6IrxXA03UaP0lxA0jT71Cw9gJVwKCh7B
         58b/vXkqK+E5iowZQYlPfJKgPq1Uec0MMXcj62XdXBLOX35CrjE1DJJCCRo15WgrsvC4
         1g0UUmglXhmEyUlYk+5FmroOl+kbYXf4MFVQTg2cB0uHnEdtMDiAFXT1lC71MAYV66Hn
         P4MbJObTNFq8ukRYIpPJfVhh9XKdR5WQh/ke6vN5an6VfD8juG7NhZMiQZOLQTh1H9sb
         83FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mnh2Je31kXke/FQYVUvveakBauZ5U23X82U3Kp0Tx3M=;
        b=3f1bYllywKB7vuaR49RHTynokz9QJ4Nh9UVSIbSTHCNSZop+u0vInTWui6MjEbsoJC
         wiY07aJXpZnWFO339Cnpb1iZGKOsVgZHBw5Cuq2cYEsHL0mZsQATxbSnlYzK/N10TpH2
         5uuups3Dfu/Xgnwrec4+He9zLm3D8DPNqVkCpKXt03c64kKRkxNmMIm2Jn3VHGWOn0p+
         wN2926Zi2QmIo8LJ7j36j6T3K0U+lJGpnMKoXBeBWrNME/p2lVkvvTxtG/sz4t0fZOtn
         zHEXNQoZWpwVBQIrxnQpjqBTxDbI5CJC02sXKVmvQDNDEC1agUtr41/rDh6Ewmk8eBFV
         Y/FQ==
X-Gm-Message-State: AOAM532VC8hRGUkjCbsv+/bGod4edOT3aHxC/q5hEHYPXdNs9JNkapzg
        lEQ/SJG8Ou5UWc1/9Jl1gWIcL7MIuZs=
X-Google-Smtp-Source: ABdhPJz9tHCyYeaQqHalsAEWI0OM70CjMfJ0PGSoZyL3d9SlVSykW4/2hTfsKlOzK9sHwKYhcZXwyA==
X-Received: by 2002:a17:906:7951:: with SMTP id l17mr17698654ejo.284.1636302599087;
        Sun, 07 Nov 2021 08:29:59 -0800 (PST)
Received: from localhost.localdomain ([2a02:ab88:109:9f0:f6a6:7fbe:807a:e1cc])
        by smtp.googlemail.com with ESMTPSA id hq37sm7195270ejc.116.2021.11.07.08.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 08:29:58 -0800 (PST)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Bolarinwa O. Saheed" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 5/5] PCI/ASPM: Remove unncessary linked list from aspm.c
Date:   Sun,  7 Nov 2021 17:29:41 +0100
Message-Id: <20211107162941.1196-6-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211107162941.1196-1-refactormyself@gmail.com>
References: <20211107162941.1196-1-refactormyself@gmail.com>
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
 drivers/pci/pcie/aspm.c | 54 ++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 12623556f750..f9e52c785f91 100644
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
@@ -968,26 +963,25 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
 /* Recheck latencies and update aspm_capable for links under the root */
 static void pcie_update_aspm_capable(struct pcie_link_state *root)
 {
-	struct pcie_link_state *link;
 	struct pci_dev *dev, *root_dev;
+	struct pci_bus *rootbus = root->pdev->bus;
 
 	/* Ensure it is the root device */
 	root_dev = pcie_get_root(root->pdev);
 	root = root_dev ? root_dev->link_state : root;
 
-	list_for_each_entry(link, &link_list, sibling) {
-		dev = pcie_get_root(link->pdev);
-		if (dev->link_state != root)
+	list_for_each_entry(dev, &rootbus->devices, bus_list) {
+		struct pcie_link_state *link = dev->link_state;
+
+		if (!link)
 			continue;
 
 		link->aspm_capable = link->aspm_support;
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
@@ -1022,7 +1016,6 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 
 	/* All functions are removed, so just disable ASPM for the link */
 	pcie_config_aspm_link(link, 0);
-	list_del(&link->sibling);
 	/* Clock PM is for endpoint device */
 	free_link_state(link);
 
@@ -1157,11 +1150,33 @@ int pci_disable_link_state(struct pci_dev *pdev, int state)
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
@@ -1174,10 +1189,9 @@ static int pcie_aspm_set_policy(const char *val,
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

