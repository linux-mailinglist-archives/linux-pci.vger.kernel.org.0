Return-Path: <linux-pci+bounces-8047-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0639D8D3D06
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 18:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67E5F281300
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 16:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F4A181D06;
	Wed, 29 May 2024 16:42:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A7E1C6B2;
	Wed, 29 May 2024 16:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000960; cv=none; b=FlRUk455UI5hNw+fVj/7UJhTLxVkbCCWafYB7/HxvkG4xkGgqi7Rihd/J3quOZwmakFCAOFsIYLZTsRb0LEv0ZBNswu2SXb8ZpUe+tDDu9u5P7fwARnBHMlKPoPvp2aZ9XoaAUPW/tk9VQ3jTw8X1ug3VvPTmeXtnCELWeyacjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000960; c=relaxed/simple;
	bh=RTHc/HEBgmVVjWIG8E4iWxyoIyhLqsEP/2is1gPmRGA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VDI0lRONmUG+OiKmvHJ8uzcY8zJbbREPGejEggibhNyB/ZBunWCM0M700q9QhrUYSTjEyT9kBQ4J4xPL2bO7M7V88NTL7YgZTsPtXc1zCTuumODrrEUPGlvGcoAYI6JeyT9nBLPNCXX1Bj+v2+FjKidcammcxBpYeY8GsZELiBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VqFSX3L1Bz6JBHF;
	Thu, 30 May 2024 00:38:36 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id F15DE140CB1;
	Thu, 30 May 2024 00:42:35 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 17:42:35 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Will Deacon <will@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	<linuxarm@huawei.com>, <terry.bowman@amd.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [RFC PATCH 3/9] pci: pcie: portdrv: Use managed device handling to simplify error and remove flows.
Date: Wed, 29 May 2024 17:40:57 +0100
Message-ID: <20240529164103.31671-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529164103.31671-1-Jonathan.Cameron@huawei.com>
References: <20240529164103.31671-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Intent here is to end with a simpler setup for the forthcomming
auxilliary_bus setup and tear down by enabling that to safely
use device managed calls.

One change here is that if none of the service drivers load, rather
than just disabling intterrupts etc this fails the portdrv probe and
relies on automated cleanup.

The shutdown callback still needs to manually call much of the
no automated flow, so directly call the same functions registered
with devm_add_action_or_reset() or unwinding the automated
cleanup of elements such as pci_free_irq_vectors().

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pcie/portdrv.c | 91 ++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 49 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index bb65dfe43409..7f053bab7745 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -317,6 +317,27 @@ static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
 	return 0;
 }
 
+static int remove_iter(struct device *dev, void *data)
+{
+	if (dev->bus == &pcie_port_bus_type)
+		device_unregister(dev);
+	return 0;
+}
+
+/**
+ * pcie_port_device_remove - unregister PCI Express port service devices
+ * @d: PCI Express port the service devices to unregister are associated with
+ *
+ * Remove PCI Express port service devices associated with given port and
+ * disable MSI-X or MSI for the port.
+ */
+static void pcie_port_device_remove(void *d)
+{
+	struct pci_dev *dev = d;
+
+	device_for_each_child(&dev->dev, NULL, remove_iter);
+}
+
 /**
  * pcie_port_device_register - register PCI Express port
  * @dev: PCI Express port to register
@@ -330,7 +351,7 @@ static int pcie_port_device_register(struct pci_dev *dev)
 	int irqs[PCIE_PORT_DEVICE_MAXSERVICES];
 
 	/* Enable PCI Express port device */
-	status = pci_enable_device(dev);
+	status = pcim_enable_device(dev);
 	if (status)
 		return status;
 
@@ -351,7 +372,7 @@ static int pcie_port_device_register(struct pci_dev *dev)
 	if (status) {
 		capabilities &= PCIE_PORT_SERVICE_HP;
 		if (!capabilities)
-			goto error_disable;
+			return status;
 	}
 
 	/* Allocate child services if any */
@@ -365,15 +386,9 @@ static int pcie_port_device_register(struct pci_dev *dev)
 			nr_service++;
 	}
 	if (!nr_service)
-		goto error_cleanup_irqs;
+		return -ENODEV; /* Why carry on if nothing supported? */
 
 	return 0;
-
-error_cleanup_irqs:
-	pci_free_irq_vectors(dev);
-error_disable:
-	pci_disable_device(dev);
-	return status;
 }
 
 typedef int (*pcie_callback_t)(struct pcie_device *);
@@ -441,13 +456,6 @@ static int pcie_port_device_runtime_resume(struct device *dev)
 }
 #endif /* PM */
 
-static int remove_iter(struct device *dev, void *data)
-{
-	if (dev->bus == &pcie_port_bus_type)
-		device_unregister(dev);
-	return 0;
-}
-
 static int find_service_iter(struct device *device, void *data)
 {
 	struct pcie_port_service_driver *service_driver;
@@ -491,19 +499,6 @@ struct device *pcie_port_find_device(struct pci_dev *dev,
 }
 EXPORT_SYMBOL_GPL(pcie_port_find_device);
 
-/**
- * pcie_port_device_remove - unregister PCI Express port service devices
- * @dev: PCI Express port the service devices to unregister are associated with
- *
- * Remove PCI Express port service devices associated with given port and
- * disable MSI-X or MSI for the port.
- */
-static void pcie_port_device_remove(struct pci_dev *dev)
-{
-	device_for_each_child(&dev->dev, NULL, remove_iter);
-	pci_free_irq_vectors(dev);
-}
-
 /**
  * pcie_port_probe_service - probe driver for given PCI Express port service
  * @dev: PCI Express port service device to probe against
@@ -669,6 +664,17 @@ static const struct dev_pm_ops pcie_portdrv_pm_ops = {
 #define PCIE_PORTDRV_PM_OPS	NULL
 #endif /* !PM */
 
+static void pcie_portdrv_runtime_pm_disable(void *d)
+{
+	struct pci_dev *dev = d;
+
+	if (pci_bridge_d3_possible(dev)) {
+		pm_runtime_forbid(&dev->dev);
+		pm_runtime_get_noresume(&dev->dev);
+		pm_runtime_dont_use_autosuspend(&dev->dev);
+	}
+}
+
 /*
  * pcie_portdrv_probe - Probe PCI-Express port devices
  * @dev: PCI-Express port device being probed
@@ -697,6 +703,11 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 	if (status)
 		return status;
 
+	status = devm_add_action_or_reset(&dev->dev, pcie_port_device_remove,
+					  dev);
+	if (status)
+		return status;
+
 	pci_save_state(dev);
 
 	dev_pm_set_driver_flags(&dev->dev, DPM_FLAG_NO_DIRECT_COMPLETE |
@@ -718,28 +729,11 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 	return 0;
 }
 
-static void pcie_portdrv_remove(struct pci_dev *dev)
-{
-	if (pci_bridge_d3_possible(dev)) {
-		pm_runtime_forbid(&dev->dev);
-		pm_runtime_get_noresume(&dev->dev);
-		pm_runtime_dont_use_autosuspend(&dev->dev);
-	}
-
-	pcie_port_device_remove(dev);
-
-	pci_disable_device(dev);
-}
-
 static void pcie_portdrv_shutdown(struct pci_dev *dev)
 {
-	if (pci_bridge_d3_possible(dev)) {
-		pm_runtime_forbid(&dev->dev);
-		pm_runtime_get_noresume(&dev->dev);
-		pm_runtime_dont_use_autosuspend(&dev->dev);
-	}
-
+	pcie_portdrv_runtime_pm_disable(dev);
 	pcie_port_device_remove(dev);
+	pci_free_irq_vectors(dev);
 }
 
 static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
@@ -789,7 +783,6 @@ static struct pci_driver pcie_portdriver = {
 	.id_table	= &port_pci_ids[0],
 
 	.probe		= pcie_portdrv_probe,
-	.remove		= pcie_portdrv_remove,
 	.shutdown	= pcie_portdrv_shutdown,
 
 	.err_handler	= &pcie_portdrv_err_handler,
-- 
2.39.2


