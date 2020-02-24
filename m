Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F56B16A30D
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 10:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgBXJuR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 04:50:17 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41374 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgBXJuP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 04:50:15 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01O9o9co041541;
        Mon, 24 Feb 2020 03:50:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582537809;
        bh=LAHbe1ep18MRMLKppKExizKw+8T2sbESWHHKJMLTnvs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Gqa7nUisMfOXQOO0TSe1AbhPrlWNpoOYp7MkBTCMPdaeG9Y1Vq0UTzzTtY1XUPxQS
         Bf6+smAp4+3JOg6uHUeUc1aMLa8KgxnGdRVZh039ZrdlVSXMe1lMbXrIIcwzd9Lo/P
         1JVEexUv2hs+SXKihiM5k/SWI3XT4fAYH/q408TA=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01O9o9qG099304
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Feb 2020 03:50:09 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 24
 Feb 2020 03:50:09 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 24 Feb 2020 03:50:09 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01O9nsnG103443;
        Mon, 24 Feb 2020 03:50:07 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 5/5] PCI: endpoint: Assign function number for each PF in EPC core
Date:   Mon, 24 Feb 2020 15:23:38 +0530
Message-ID: <20200224095338.3758-6-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200224095338.3758-1-kishon@ti.com>
References: <20200224095338.3758-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIe endpoint core relies on the drivers that invoke the
pci_epc_add_epf() API to allocate and assign a function number
to each physical function (PF). Since endpoint function device can
be created by multiple mechanisms (configfs, devicetree, etc..),
allowing each of these mechanisms to assign a function number
would result in mutliple endpoint function devices having the
same function number. In order to avoid this, let EPC core assign
a function number to the endpoint device.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-ep-cfs.c   | 27 +++++----------------------
 drivers/pci/endpoint/pci-epc-core.c | 26 ++++++++++++++++++++++----
 include/linux/pci-epc.h             |  2 ++
 3 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index d1288a0bd530..e7e8367eead1 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -29,7 +29,6 @@ struct pci_epc_group {
 	struct config_group group;
 	struct pci_epc *epc;
 	bool start;
-	unsigned long function_num_map;
 };
 
 static inline struct pci_epf_group *to_pci_epf_group(struct config_item *item)
@@ -89,37 +88,22 @@ static int pci_epc_epf_link(struct config_item *epc_item,
 			    struct config_item *epf_item)
 {
 	int ret;
-	u32 func_no = 0;
 	struct pci_epf_group *epf_group = to_pci_epf_group(epf_item);
 	struct pci_epc_group *epc_group = to_pci_epc_group(epc_item);
 	struct pci_epc *epc = epc_group->epc;
 	struct pci_epf *epf = epf_group->epf;
 
-	func_no = find_first_zero_bit(&epc_group->function_num_map,
-				      BITS_PER_LONG);
-	if (func_no >= BITS_PER_LONG)
-		return -EINVAL;
-
-	set_bit(func_no, &epc_group->function_num_map);
-	epf->func_no = func_no;
-
 	ret = pci_epc_add_epf(epc, epf);
 	if (ret)
-		goto err_add_epf;
+		return ret;
 
 	ret = pci_epf_bind(epf);
-	if (ret)
-		goto err_epf_bind;
+	if (ret) {
+		pci_epc_remove_epf(epc, epf);
+		return ret;
+	}
 
 	return 0;
-
-err_epf_bind:
-	pci_epc_remove_epf(epc, epf);
-
-err_add_epf:
-	clear_bit(func_no, &epc_group->function_num_map);
-
-	return ret;
 }
 
 static void pci_epc_epf_unlink(struct config_item *epc_item,
@@ -134,7 +118,6 @@ static void pci_epc_epf_unlink(struct config_item *epc_item,
 
 	epc = epc_group->epc;
 	epf = epf_group->epf;
-	clear_bit(epf->func_no, &epc_group->function_num_map);
 	pci_epf_unbind(epf);
 	pci_epc_remove_epf(epc, epf);
 }
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index e51a12ed85bb..dc1c673534e0 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -471,22 +471,39 @@ EXPORT_SYMBOL_GPL(pci_epc_write_header);
  */
 int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf)
 {
+	u32 func_no;
+	int ret = 0;
+
 	if (epf->epc)
 		return -EBUSY;
 
 	if (IS_ERR(epc))
 		return -EINVAL;
 
-	if (epf->func_no > epc->max_functions - 1)
-		return -EINVAL;
+	mutex_lock(&epc->lock);
+	func_no = find_first_zero_bit(&epc->function_num_map,
+				      BITS_PER_LONG);
+	if (func_no >= BITS_PER_LONG) {
+		ret = -EINVAL;
+		goto ret;
+	}
+
+	if (func_no > epc->max_functions - 1) {
+		dev_err(&epc->dev, "Exceeding max supported Function Number\n");
+		ret = -EINVAL;
+		goto ret;
+	}
 
+	set_bit(func_no, &epc->function_num_map);
+	epf->func_no = func_no;
 	epf->epc = epc;
 
-	mutex_lock(&epc->lock);
 	list_add_tail(&epf->list, &epc->pci_epf);
+
+ret:
 	mutex_unlock(&epc->lock);
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(pci_epc_add_epf);
 
@@ -503,6 +520,7 @@ void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf)
 		return;
 
 	mutex_lock(&epc->lock);
+	clear_bit(epf->func_no, &epc->function_num_map);
 	list_del(&epf->list);
 	epf->epc = NULL;
 	mutex_unlock(&epc->lock);
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 4e3e527c49d1..ccaf6e3fa931 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -92,6 +92,7 @@ struct pci_epc_mem {
  * @max_functions: max number of functions that can be configured in this EPC
  * @group: configfs group representing the PCI EPC device
  * @lock: mutex to protect pci_epc ops
+ * @function_num_map: bitmap to manage physical function number
  * @notifier: used to notify EPF of any EPC events (like linkup)
  */
 struct pci_epc {
@@ -103,6 +104,7 @@ struct pci_epc {
 	struct config_group		*group;
 	/* mutex to protect against concurrent access of EP controller */
 	struct mutex			lock;
+	unsigned long			function_num_map;
 	struct atomic_notifier_head	notifier;
 };
 
-- 
2.17.1

