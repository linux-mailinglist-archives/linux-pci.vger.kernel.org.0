Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2237512D7BB
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2019 11:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfLaKBt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Dec 2019 05:01:49 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53528 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfLaKBs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Dec 2019 05:01:48 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBVA1g5p093213;
        Tue, 31 Dec 2019 04:01:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577786502;
        bh=TIrGAMfYBliDBtaQKlV0MlGmf7iOyYCug35gAI9pUtQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SxC0oVBurZin9Llk5gPDE4uX1IcVbG3e7bmez9dkPtuo09kGfh7Zo6Ms3SRHWFL+5
         R2KuGQcOcDqrMHJSrNvKlhQsMwQW49+t6WIBIEYYoAmubUfrLEBNh1TOBHK6Nmi65Z
         ZSyB+m9gqrYuQ02pjkvuxsWkvXi51N87nuZq1Ny0=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBVA1gUW086796;
        Tue, 31 Dec 2019 04:01:42 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 31
 Dec 2019 04:01:41 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 31 Dec 2019 04:01:41 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBVA1TZj020876;
        Tue, 31 Dec 2019 04:01:39 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <andrew.murray@arm.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/5] PCI: endpoint: Protect concurrent access to pci_epf_ops with mutex
Date:   Tue, 31 Dec 2019 15:33:30 +0530
Message-ID: <20191231100331.6316-5-kishon@ti.com>
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

Protect concurrent access to pci_epf_ops with mutex.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-epf-core.c | 11 ++++++++++-
 include/linux/pci-epf.h             |  3 +++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 642f233efcaf..244e00f48c5c 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -35,7 +35,9 @@ void pci_epf_unbind(struct pci_epf *epf)
 		return;
 	}
 
+	mutex_lock(&epf->lock);
 	epf->driver->ops->unbind(epf);
+	mutex_unlock(&epf->lock);
 	module_put(epf->driver->owner);
 }
 EXPORT_SYMBOL_GPL(pci_epf_unbind);
@@ -49,6 +51,8 @@ EXPORT_SYMBOL_GPL(pci_epf_unbind);
  */
 int pci_epf_bind(struct pci_epf *epf)
 {
+	int ret;
+
 	if (!epf->driver) {
 		dev_WARN(&epf->dev, "epf device not bound to driver\n");
 		return -EINVAL;
@@ -57,7 +61,11 @@ int pci_epf_bind(struct pci_epf *epf)
 	if (!try_module_get(epf->driver->owner))
 		return -EAGAIN;
 
-	return epf->driver->ops->bind(epf);
+	mutex_lock(&epf->lock);
+	ret = epf->driver->ops->bind(epf);
+	mutex_unlock(&epf->lock);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(pci_epf_bind);
 
@@ -254,6 +262,7 @@ struct pci_epf *pci_epf_create(const char *name)
 	device_initialize(dev);
 	dev->bus = &pci_epf_bus_type;
 	dev->type = &pci_epf_type;
+	mutex_init(&epf->lock);
 
 	ret = dev_set_name(dev, "%s", name);
 	if (ret) {
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 75aa1003646b..efbc08a153ff 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -112,6 +112,7 @@ struct pci_epf_bar {
  * @driver: the EPF driver to which this EPF device is bound
  * @list: to add pci_epf as a list of PCI endpoint functions to pci_epc
  * @nb: notifier block to notify EPF of any EPC events (like linkup)
+ * @lock: mutex to protect pci_epf_ops
  */
 struct pci_epf {
 	struct device		dev;
@@ -126,6 +127,8 @@ struct pci_epf {
 	struct pci_epf_driver	*driver;
 	struct list_head	list;
 	struct notifier_block   nb;
+	/* mutex to protect against concurrent access of pci_epf_ops */
+	struct mutex		lock;
 };
 
 /**
-- 
2.17.1

