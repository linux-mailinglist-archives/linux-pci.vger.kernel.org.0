Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D957A34820
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2019 15:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfFDNSf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jun 2019 09:18:35 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:39336 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbfFDNSf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jun 2019 09:18:35 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x54DIKwr120006;
        Tue, 4 Jun 2019 08:18:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559654300;
        bh=oIzF4wPqwNRg9UTf2H8Siu9HoiPwFp65VY06zJhiVqk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wna+KbYt+4VB/bLdy1bkRaCyULLvGVx/mI+oJUkghKX4lGJWopq+C4sXX9eMeiSpx
         O5qN4L99Jrr4vwmjyI4vpeX2RsUM7jj7GTW7lxK0KgEuwSBzV+lB1qycprJVS2u0O0
         +m8ljAtaLaKCE72BeDwTxsNujVHrS3BOUK1eWMjQ=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x54DIKlP053724
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Jun 2019 08:18:20 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 4 Jun
 2019 08:18:19 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 4 Jun 2019 08:18:19 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x54DGdGX098972;
        Tue, 4 Jun 2019 08:18:14 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 17/30] PCI: endpoint: Protect concurrent access to pci_epf_ops with mutex
Date:   Tue, 4 Jun 2019 18:45:03 +0530
Message-ID: <20190604131516.13596-18-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604131516.13596-1-kishon@ti.com>
References: <20190604131516.13596-1-kishon@ti.com>
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
index 93f28c65ace0..6e0648991b5c 100644
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
 
@@ -252,6 +260,7 @@ struct pci_epf *pci_epf_create(const char *name)
 	device_initialize(dev);
 	dev->bus = &pci_epf_bus_type;
 	dev->type = &pci_epf_type;
+	mutex_init(&epf->lock);
 
 	ret = dev_set_name(dev, "%s", name);
 	if (ret) {
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 4993f7f6439b..bcdf4f07bde7 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -110,6 +110,7 @@ struct pci_epf_bar {
  * @driver: the EPF driver to which this EPF device is bound
  * @list: to add pci_epf as a list of PCI endpoint functions to pci_epc
  * @nb: notifier block to notify EPF of any EPC events (like linkup)
+ * @lock: mutex to protect pci_epf_ops
  */
 struct pci_epf {
 	struct device		dev;
@@ -124,6 +125,8 @@ struct pci_epf {
 	struct pci_epf_driver	*driver;
 	struct list_head	list;
 	struct notifier_block   nb;
+	/* mutex to protect against concurrent access of pci_epf_ops */
+	struct mutex		lock;
 };
 
 #define to_pci_epf(epf_dev) container_of((epf_dev), struct pci_epf, dev)
-- 
2.17.1

