Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC7DE12D7B6
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2019 11:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfLaKBk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Dec 2019 05:01:40 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52520 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfLaKBj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Dec 2019 05:01:39 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBVA1Zp6069008;
        Tue, 31 Dec 2019 04:01:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577786495;
        bh=zItPC6sC/N4x6xUAY/aBikTqQ+6S8t0fCSiHZX5Pwp4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=KqpETw7Bwtohg7YCM0GVJPPUw1IDho+Dt9ELAmOsHhDsnIt0ANVjOsjEqPugfCoJn
         GBDoulnkB4J6haMyg+wv/4d05rVaDJ3Wff6DcEBRtBEJiLwbqH/7/EkCf4CmunoTRx
         LMqZc3mOyJfd/z1xvEH0wyC117O6vYoJlJue39uc=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBVA1ZU3079427
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 31 Dec 2019 04:01:35 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 31
 Dec 2019 04:01:34 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 31 Dec 2019 04:01:34 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBVA1TZg020876;
        Tue, 31 Dec 2019 04:01:32 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <andrew.murray@arm.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/5] PCI: endpoint: Use notification chain mechanism to notify EPC events to EPF
Date:   Tue, 31 Dec 2019 15:33:27 +0530
Message-ID: <20191231100331.6316-2-kishon@ti.com>
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

Use atomic_notifier_call_chain() to notify EPC events like linkup to EPF
driver instead of using linkup ops in EPF driver. This is in preparation
for adding proper locking mechanism to EPF ops. This will also enable to
add more events (in addition to linkup) in the future.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 13 ++++++++---
 drivers/pci/endpoint/pci-epc-core.c           |  9 ++------
 drivers/pci/endpoint/pci-epf-core.c           | 22 +------------------
 include/linux/pci-epc.h                       |  8 +++++++
 include/linux/pci-epf.h                       |  6 ++---
 5 files changed, 23 insertions(+), 35 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index f4bd3200cd74..8de33219a364 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -361,12 +361,16 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 			   msecs_to_jiffies(1));
 }
 
-static void pci_epf_test_linkup(struct pci_epf *epf)
+static int pci_epf_test_notifier(struct notifier_block *nb, unsigned long val,
+				 void *data)
 {
+	struct pci_epf *epf = container_of(nb, struct pci_epf, nb);
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
 
 	queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
 			   msecs_to_jiffies(1));
+
+	return NOTIFY_OK;
 }
 
 static void pci_epf_test_unbind(struct pci_epf *epf)
@@ -565,8 +569,12 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 		}
 	}
 
-	if (!linkup_notifier)
+	if (linkup_notifier) {
+		epf->nb.notifier_call = pci_epf_test_notifier;
+		pci_epc_register_notifier(epc, &epf->nb);
+	} else {
 		queue_work(kpcitest_workqueue, &epf_test->cmd_handler.work);
+	}
 
 	return 0;
 }
@@ -599,7 +607,6 @@ static int pci_epf_test_probe(struct pci_epf *epf)
 static struct pci_epf_ops ops = {
 	.unbind	= pci_epf_test_unbind,
 	.bind	= pci_epf_test_bind,
-	.linkup = pci_epf_test_linkup,
 };
 
 static struct pci_epf_driver test_driver = {
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 3b278fb99206..82a0636fc562 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -542,16 +542,10 @@ EXPORT_SYMBOL_GPL(pci_epc_remove_epf);
  */
 void pci_epc_linkup(struct pci_epc *epc)
 {
-	unsigned long flags;
-	struct pci_epf *epf;
-
 	if (!epc || IS_ERR(epc))
 		return;
 
-	spin_lock_irqsave(&epc->lock, flags);
-	list_for_each_entry(epf, &epc->pci_epf, list)
-		pci_epf_linkup(epf);
-	spin_unlock_irqrestore(&epc->lock, flags);
+	atomic_notifier_call_chain(&epc->notifier, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(pci_epc_linkup);
 
@@ -615,6 +609,7 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
 
 	spin_lock_init(&epc->lock);
 	INIT_LIST_HEAD(&epc->pci_epf);
+	ATOMIC_INIT_NOTIFIER_HEAD(&epc->notifier);
 
 	device_initialize(&epc->dev);
 	epc->dev.class = pci_epc_class;
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 93ebe916949e..642f233efcaf 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -20,26 +20,6 @@ static DEFINE_MUTEX(pci_epf_mutex);
 static struct bus_type pci_epf_bus_type;
 static const struct device_type pci_epf_type;
 
-/**
- * pci_epf_linkup() - Notify the function driver that EPC device has
- *		      established a connection with the Root Complex.
- * @epf: the EPF device bound to the EPC device which has established
- *	 the connection with the host
- *
- * Invoke to notify the function driver that EPC device has established
- * a connection with the Root Complex.
- */
-void pci_epf_linkup(struct pci_epf *epf)
-{
-	if (!epf->driver) {
-		dev_WARN(&epf->dev, "epf device not bound to driver\n");
-		return;
-	}
-
-	epf->driver->ops->linkup(epf);
-}
-EXPORT_SYMBOL_GPL(pci_epf_linkup);
-
 /**
  * pci_epf_unbind() - Notify the function driver that the binding between the
  *		      EPF device and EPC device has been lost
@@ -216,7 +196,7 @@ int __pci_epf_register_driver(struct pci_epf_driver *driver,
 	if (!driver->ops)
 		return -EINVAL;
 
-	if (!driver->ops->bind || !driver->ops->unbind || !driver->ops->linkup)
+	if (!driver->ops->bind || !driver->ops->unbind)
 		return -EINVAL;
 
 	driver->driver.bus = &pci_epf_bus_type;
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 4e2bed5fd39c..ff9e0b3e5424 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -90,6 +90,7 @@ struct pci_epc_mem {
  * @max_functions: max number of functions that can be configured in this EPC
  * @group: configfs group representing the PCI EPC device
  * @lock: spinlock to protect pci_epc ops
+ * @notifier: used to notify EPF of any EPC events (like linkup)
  */
 struct pci_epc {
 	struct device			dev;
@@ -100,6 +101,7 @@ struct pci_epc {
 	struct config_group		*group;
 	/* spinlock to protect against concurrent access of EP controller */
 	spinlock_t			lock;
+	struct atomic_notifier_head	notifier;
 };
 
 /**
@@ -142,6 +144,12 @@ static inline void *epc_get_drvdata(struct pci_epc *epc)
 	return dev_get_drvdata(&epc->dev);
 }
 
+static inline int
+pci_epc_register_notifier(struct pci_epc *epc, struct notifier_block *nb)
+{
+	return atomic_notifier_chain_register(&epc->notifier, nb);
+}
+
 struct pci_epc *
 __devm_pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
 		      struct module *owner);
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index bc5ce7afd79a..75aa1003646b 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -55,13 +55,10 @@ struct pci_epf_header {
  * @bind: ops to perform when a EPC device has been bound to EPF device
  * @unbind: ops to perform when a binding has been lost between a EPC device
  *	    and EPF device
- * @linkup: ops to perform when the EPC device has established a connection with
- *	    a host system
  */
 struct pci_epf_ops {
 	int	(*bind)(struct pci_epf *epf);
 	void	(*unbind)(struct pci_epf *epf);
-	void	(*linkup)(struct pci_epf *epf);
 };
 
 /**
@@ -114,6 +111,7 @@ struct pci_epf_bar {
  * @epc: the EPC device to which this EPF device is bound
  * @driver: the EPF driver to which this EPF device is bound
  * @list: to add pci_epf as a list of PCI endpoint functions to pci_epc
+ * @nb: notifier block to notify EPF of any EPC events (like linkup)
  */
 struct pci_epf {
 	struct device		dev;
@@ -127,6 +125,7 @@ struct pci_epf {
 	struct pci_epc		*epc;
 	struct pci_epf_driver	*driver;
 	struct list_head	list;
+	struct notifier_block   nb;
 };
 
 /**
@@ -169,5 +168,4 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar);
 int pci_epf_bind(struct pci_epf *epf);
 void pci_epf_unbind(struct pci_epf *epf);
-void pci_epf_linkup(struct pci_epf *epf);
 #endif /* __LINUX_PCI_EPF_H */
-- 
2.17.1

