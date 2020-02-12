Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC6AA15A7B9
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2020 12:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgBLLWM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Feb 2020 06:22:12 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:51802 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbgBLLWL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Feb 2020 06:22:11 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01CBLvGN014361;
        Wed, 12 Feb 2020 05:21:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581506517;
        bh=LAHbe1ep18MRMLKppKExizKw+8T2sbESWHHKJMLTnvs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=sCaAqDj2+59ftqzv0t66V8M3cHSXhnCnXnMfmhnOhOD0SnTx2ejUnoePSJ87Z7AcV
         66MqYyfeLQhDS4NFUOfzjkHDJqKgjI8I2GSgskNDzIWjL2l/VSMfqUi5/4QCdkIQmp
         ziXGgYyxU+ZUdb2stNJoc7hZc8yEfLb75gXqVcSo=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01CBLv5F113060
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Feb 2020 05:21:57 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 12
 Feb 2020 05:21:57 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 12 Feb 2020 05:21:57 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01CBLc5b049841;
        Wed, 12 Feb 2020 05:21:54 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Vidya Sagar <vidyas@nvidia.com>,
        Athani Nadeem Ladkhan <nadeem@cadence.com>,
        Tom Joseph <tjoseph@cadence.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 5/5] PCI: endpoint: Assign function number for each PF in EPC core
Date:   Wed, 12 Feb 2020 16:55:14 +0530
Message-ID: <20200212112514.2000-6-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200212112514.2000-1-kishon@ti.com>
References: <20200212112514.2000-1-kishon@ti.com>
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

