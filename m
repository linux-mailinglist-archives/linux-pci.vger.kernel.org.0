Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3688816A303
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 10:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgBXJuH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 04:50:07 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48180 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbgBXJuH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 04:50:07 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01O9o1JM115064;
        Mon, 24 Feb 2020 03:50:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582537801;
        bh=NSN1PR6BbRLEFJcGl71r2ydoe9MEFXsXvNsWp5yET48=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gEVRsWKsekt3USyysCsgW3K/8Jtc4hHo7/LoWnVJDeBJr5mc+Uef8MX3xdYRr1GMo
         lmn4HRVjXvy9n4yFPfQV0ipdYOswdXB1f/M8wXlnhGlgZg0FPpcXS1M4K3a94z5LEY
         x5zz4Ekjxba48epe5yuNSlUKV4cTfSbdZcwg+ed0=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01O9o1vA097485
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Feb 2020 03:50:01 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 24
 Feb 2020 03:50:00 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 24 Feb 2020 03:49:59 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01O9nsnC103443;
        Mon, 24 Feb 2020 03:49:58 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/5] PCI: endpoint: Use notification chain mechanism to notify EPC events to EPF
Date:   Mon, 24 Feb 2020 15:23:34 +0530
Message-ID: <20200224095338.3758-2-kishon@ti.com>
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
index 5d74f81ddfe4..bddff15052cc 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -360,12 +360,16 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
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
@@ -546,8 +550,12 @@ static int pci_epf_test_bind(struct pci_epf *epf)
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
@@ -580,7 +588,6 @@ static int pci_epf_test_probe(struct pci_epf *epf)
 static struct pci_epf_ops ops = {
 	.unbind	= pci_epf_test_unbind,
 	.bind	= pci_epf_test_bind,
-	.linkup = pci_epf_test_linkup,
 };
 
 static struct pci_epf_driver test_driver = {
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 2091508c1620..2f6436599fcb 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -539,16 +539,10 @@ EXPORT_SYMBOL_GPL(pci_epc_remove_epf);
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
 
@@ -612,6 +606,7 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
 
 	spin_lock_init(&epc->lock);
 	INIT_LIST_HEAD(&epc->pci_epf);
+	ATOMIC_INIT_NOTIFIER_HEAD(&epc->notifier);
 
 	device_initialize(&epc->dev);
 	epc->dev.class = pci_epc_class;
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index fb1306de8f40..93f28c65ace0 100644
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
@@ -214,7 +194,7 @@ int __pci_epf_register_driver(struct pci_epf_driver *driver,
 	if (!driver->ops)
 		return -EINVAL;
 
-	if (!driver->ops->bind || !driver->ops->unbind || !driver->ops->linkup)
+	if (!driver->ops->bind || !driver->ops->unbind)
 		return -EINVAL;
 
 	driver->driver.bus = &pci_epf_bus_type;
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 56f1846b9d39..36644ccd32ac 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -89,6 +89,7 @@ struct pci_epc_mem {
  * @max_functions: max number of functions that can be configured in this EPC
  * @group: configfs group representing the PCI EPC device
  * @lock: spinlock to protect pci_epc ops
+ * @notifier: used to notify EPF of any EPC events (like linkup)
  */
 struct pci_epc {
 	struct device			dev;
@@ -99,6 +100,7 @@ struct pci_epc {
 	struct config_group		*group;
 	/* spinlock to protect against concurrent access of EP controller */
 	spinlock_t			lock;
+	struct atomic_notifier_head	notifier;
 };
 
 /**
@@ -141,6 +143,12 @@ static inline void *epc_get_drvdata(struct pci_epc *epc)
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
index 2d6f07556682..4993f7f6439b 100644
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
@@ -112,6 +109,7 @@ struct pci_epf_bar {
  * @epc: the EPC device to which this EPF device is bound
  * @driver: the EPF driver to which this EPF device is bound
  * @list: to add pci_epf as a list of PCI endpoint functions to pci_epc
+ * @nb: notifier block to notify EPF of any EPC events (like linkup)
  */
 struct pci_epf {
 	struct device		dev;
@@ -125,6 +123,7 @@ struct pci_epf {
 	struct pci_epc		*epc;
 	struct pci_epf_driver	*driver;
 	struct list_head	list;
+	struct notifier_block   nb;
 };
 
 #define to_pci_epf(epf_dev) container_of((epf_dev), struct pci_epf, dev)
@@ -154,5 +153,4 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar);
 int pci_epf_bind(struct pci_epf *epf);
 void pci_epf_unbind(struct pci_epf *epf);
-void pci_epf_linkup(struct pci_epf *epf);
 #endif /* __LINUX_PCI_EPF_H */
-- 
2.17.1

