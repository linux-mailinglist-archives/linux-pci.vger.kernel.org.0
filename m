Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD78441BBD6
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 02:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243493AbhI2ApN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 20:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243496AbhI2ApM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Sep 2021 20:45:12 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE28C06161C;
        Tue, 28 Sep 2021 17:43:31 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id b26so2134540edt.0;
        Tue, 28 Sep 2021 17:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hVi+b42a7oKTH3rSNcSPzpFbX0inHCO5G8w5h2JTx2A=;
        b=Al7CIYd6CTuRMp0Rodfg3uW+5NZzASZkDXJDPQg8ixM8l4JeFDzGNQLlY6L4cpz7j1
         6sK8lSS/MAlg0V56eROlfLgKfhGaZmyfuE5nCz8k+f3n41vVTt2iEKLhLLxuhkaKUHd+
         /9472KNg4yZypwF7wJIiBy7zxRLix4hjXR6pCWctB2Meo4rGBPEpm9X5mEO4aL7JL/2u
         Dn3dGKEqcDdKOpUE8mWjsdtMadGAlFuYJ2NKpoS2rVsl8S8pnr81/ieNplPmrLD4ejY0
         kenHNQAA7m9sKuo1cYhtOfqgLX9khkF/b2V0ufY+icFNQZnpuANRD+lVUV3or0w/iuCl
         nMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hVi+b42a7oKTH3rSNcSPzpFbX0inHCO5G8w5h2JTx2A=;
        b=6uVzBenovspgW/YSvh92X2IT1LxGPgjY8CtTYCFr27XgqvFt6Z+2VTFoJf5AYT3RIU
         JXoev3FTkjCf+Sb8vDCQALPyFVTGgj4qybFRWLANeer5LtAe0v4D6VMp9oHIjR+UFcZ4
         b0udXPunMi9hR6RazZWVZVxi8m0+qiiukYqihVbRl+3pUdRAME3fOZG92QwWhIccx6T6
         B48rLCNh8k3u+iBlmBpYAFH9pk+af1hmHTC67/G4ldGyXS6RdX7WLTf+YhsZyJEHP45j
         aJKqsdwSmpRi3PMJkMYgYbulDOHPG3Mv0ZjWV5pAs0Qj4PZnXoQIFjuJbtkpyIuty9/q
         k5Dw==
X-Gm-Message-State: AOAM532lCM9T0MdK1r6OCZmGE05sgsfr/vwW5IFsz2fkogp/CoxnEc/b
        xKk8sP3YDRPsjPjiUWz1C/0pdS7gJzs=
X-Google-Smtp-Source: ABdhPJxnGXRncGlPxJ5fuzR8LvLkKmpGHBFWFAwNcPfWAG2ozbWYBOnHNXED2VkuTA0MZfsQlHnMZA==
X-Received: by 2002:a50:cfc1:: with SMTP id i1mr11283520edk.251.1632876210469;
        Tue, 28 Sep 2021 17:43:30 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:10f:c9f0:35c7:3af0:a197:61d0])
        by smtp.googlemail.com with ESMTPSA id u16sm358489ejy.14.2021.09.28.17.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 17:43:30 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Bolarinwa O. Saheed" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 4/4] PCI/ASPM: Remove unncessary linked list from aspm.c
Date:   Wed, 29 Sep 2021 02:43:15 +0200
Message-Id: <20210929004315.22558-5-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210929004315.22558-1-refactormyself@gmail.com>
References: <20210929004315.22558-1-refactormyself@gmail.com>
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
 drivers/pci/pcie/aspm.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 56d4fe7d50b5..4bef652dc63c 100644
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
 	root = root_dev ? root_dev->link_state : NULL;
 
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
@@ -1024,7 +1017,6 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 
 	/* All functions are removed, so just disable ASPM for the link */
 	pcie_config_aspm_link(link, 0);
-	list_del(&link->sibling);
 	/* Clock PM is for endpoint device */
 	free_link_state(link);
 
@@ -1164,6 +1156,8 @@ static int pcie_aspm_set_policy(const char *val,
 {
 	int i;
 	struct pcie_link_state *link;
+	struct pci_bus *bus;
+	struct pci_dev *pdev;
 
 	if (aspm_disabled)
 		return -EPERM;
@@ -1176,9 +1170,18 @@ static int pcie_aspm_set_policy(const char *val,
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

