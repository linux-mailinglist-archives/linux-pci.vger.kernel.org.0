Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9536612D7BC
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2019 11:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfLaKBx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Dec 2019 05:01:53 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36890 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbfLaKBw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Dec 2019 05:01:52 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBVA1kSt129484;
        Tue, 31 Dec 2019 04:01:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577786506;
        bh=1GRfkaISBy6wPthQmpM0oglViPmws+LSOCqGq0K9NIE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SFG101fywHS2PS3+vCfNy0DET+YRjkobgMPrq1euVxOuhoWVc96Gk7NdWDVj58WWy
         IUabhdhv/sm9qIm4iD93zQ1gOrTOQZEOahFt1NMJ5KUU7TobgXF95UpK8hWk3vEtcW
         l827S4rQFB1n+mCN1XpwuNEtOg3TAb4mja6s8txs=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBVA1kG8079783
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 31 Dec 2019 04:01:46 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 31
 Dec 2019 04:01:44 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 31 Dec 2019 04:01:44 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBVA1TZk020876;
        Tue, 31 Dec 2019 04:01:42 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <andrew.murray@arm.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5] PCI: endpoint: Assign function number for each PF in EPC core
Date:   Tue, 31 Dec 2019 15:33:31 +0530
Message-ID: <20191231100331.6316-6-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191231100331.6316-1-kishon@ti.com>
References: <20191231100331.6316-1-kishon@ti.com>
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
index 0f8de1d97c15..13c03ccb39ac 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -474,22 +474,39 @@ EXPORT_SYMBOL_GPL(pci_epc_write_header);
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
 
@@ -506,6 +523,7 @@ void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf)
 		return;
 
 	mutex_lock(&epc->lock);
+	clear_bit(epf->func_no, &epc->function_num_map);
 	list_del(&epf->list);
 	epf->epc = NULL;
 	mutex_unlock(&epc->lock);
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 42c2b14ea2b4..105801f6e300 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -93,6 +93,7 @@ struct pci_epc_mem {
  * @max_functions: max number of functions that can be configured in this EPC
  * @group: configfs group representing the PCI EPC device
  * @lock: mutex to protect pci_epc ops
+ * @function_num_map: bitmap to manage physical function number
  * @notifier: used to notify EPF of any EPC events (like linkup)
  */
 struct pci_epc {
@@ -104,6 +105,7 @@ struct pci_epc {
 	struct config_group		*group;
 	/* mutex to protect against concurrent access of EP controller */
 	struct mutex			lock;
+	unsigned long			function_num_map;
 	struct atomic_notifier_head	notifier;
 };
 
-- 
2.17.1

