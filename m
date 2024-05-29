Return-Path: <linux-pci+bounces-8049-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99AD8D3D0A
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 18:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068E11C20AAC
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 16:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1E6181D06;
	Wed, 29 May 2024 16:43:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782E2181BA7;
	Wed, 29 May 2024 16:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717001022; cv=none; b=eWyeNzUkL7+spmyr6UMDtTb7mbHO+tdmJJrCBvH0ALeqaGdNbFokDncUWw66UGmiq0947dSyicEHcaSpq8TEjcTmMi1t/ozY0c06a65j0Hvb2KOX2yEPP2nmo/1fBygtKlpimtkcVIg6G5aVZ2hWDaZm7Ne1no7zEYWgFYk3GnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717001022; c=relaxed/simple;
	bh=jIeGdYFx30PYF6XG4P8ur737aTM5Kur2xUWLRLVoQ84=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ao5fAAfuyvlL4B0lRPiOT1oUOhhxaXxgCRh/SCGerWSVgLxqeDmjg2W1uWYC2/RNBJomNTgJtj3XnsQRoo+iGYxUgCdKXQQAevc9vhICKpSFSAzhHhwFQGCtuKsBJCLbzZ+jFkktcaZq7ObqyhLgJbu8OjesDNHzlmkgnbIwk1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VqFY85w1Vz6K9Jr;
	Thu, 30 May 2024 00:42:36 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B79EF140CF4;
	Thu, 30 May 2024 00:43:37 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 17:43:37 +0100
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
Subject: [RFC PATCH 5/9] pci: pcie: portdrv: Add a auxiliary_bus
Date: Wed, 29 May 2024 17:40:59 +0100
Message-ID: <20240529164103.31671-6-Jonathan.Cameron@huawei.com>
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

Nothing registered on this bus yet, but it will provide an extensible
means to register child devices that may use drivers that are present
at portdrv probe time, or due to other dependencies only become present
later.  The existing pci_express sysfs bus is not suitable for cases
like the CXL PMU where there may be 0-N independent instances on each
port.

Note that the portdrv must know how to query any msi/msix interrupt
numbers so that it can enable sufficient vectors before the
auxiliary devices are added that make use fo these interrupts.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pcie/Kconfig   |   1 +
 drivers/pci/pcie/portdrv.c | 118 +++++++++++++++++++++++++++++++++++--
 drivers/pci/pcie/portdrv.h |  13 ++++
 3 files changed, 127 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 17919b99fa66..840f87eb4b28 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -4,6 +4,7 @@
 #
 config PCIEPORTBUS
 	bool "PCI Express Port Bus support"
+	select AUXILIARY_BUS
 	default y if USB4
 	help
 	  This enables PCI Express Port Bus support. Users can then enable
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 7f053bab7745..6314da76de9f 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -6,12 +6,14 @@
  * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
  */
 
+#include <linux/auxiliary_bus.h>
 #include <linux/bitfield.h>
 #include <linux/dmi.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
+#include <linux/list.h>
 #include <linux/errno.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
@@ -208,6 +210,7 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
 /**
  * get_port_device_capability - discover capabilities of a PCI Express port
  * @dev: PCI Express port to examine
+ * @aux_dev_list: Auxiliary devices to create after interrupt vectors resoved.
  *
  * The capabilities are read from the port's PCI Express configuration registers
  * as described in PCI Express Base Specification 1.0a sections 7.8.2, 7.8.9 and
@@ -215,7 +218,8 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
  *
  * Return value: Bitmask of discovered port capabilities
  */
-static int get_port_device_capability(struct pci_dev *dev)
+static int get_port_device_capability(struct pci_dev *dev,
+				      struct list_head *aux_dev_list)
 {
 	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
 	int services = 0;
@@ -317,6 +321,20 @@ static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
 	return 0;
 }
 
+static void pcie_port_auxdev_delete(void *p_ad)
+{
+	struct pcie_port_aux_dev *pcie_adev = p_ad;
+
+	auxiliary_device_delete(&pcie_adev->adev);
+}
+
+static void pcie_port_auxdev_uninit(void *p_ad)
+{
+	struct pcie_port_aux_dev *pcie_adev = p_ad;
+
+	auxiliary_device_uninit(&pcie_adev->adev);
+}
+
 static int remove_iter(struct device *dev, void *data)
 {
 	if (dev->bus == &pcie_port_bus_type)
@@ -324,6 +342,15 @@ static int remove_iter(struct device *dev, void *data)
 	return 0;
 }
 
+static int aux_remove_iter(struct device *dev, void *data)
+{
+	if (dev->bus == &auxiliary_bus_type) {
+		auxiliary_device_delete(to_auxiliary_dev(dev));
+		auxiliary_device_uninit(to_auxiliary_dev(dev));
+	}
+	return 0;
+}
+
 /**
  * pcie_port_device_remove - unregister PCI Express port service devices
  * @d: PCI Express port the service devices to unregister are associated with
@@ -338,6 +365,20 @@ static void pcie_port_device_remove(void *d)
 	device_for_each_child(&dev->dev, NULL, remove_iter);
 }
 
+/* Should be called when device created to ensure resource cleanup */
+int devm_pcie_port_aux_dev_init(struct device *dev,
+				struct pcie_port_aux_dev *pcie_adev)
+{
+	int status;
+
+	status = auxiliary_device_init(&pcie_adev->adev);
+	if (status)
+		return status;
+
+	return devm_add_action_or_reset(dev, pcie_port_auxdev_uninit,
+					pcie_adev);
+}
+
 /**
  * pcie_port_device_register - register PCI Express port
  * @dev: PCI Express port to register
@@ -349,6 +390,8 @@ static int pcie_port_device_register(struct pci_dev *dev)
 {
 	int status, capabilities, i, nr_service;
 	int irqs[PCIE_PORT_DEVICE_MAXSERVICES];
+	struct pcie_port_aux_dev *pcie_adev;
+	LIST_HEAD(aux_dev_list);
 
 	/* Enable PCI Express port device */
 	status = pcim_enable_device(dev);
@@ -356,8 +399,8 @@ static int pcie_port_device_register(struct pci_dev *dev)
 		return status;
 
 	/* Get and check PCI Express port services */
-	capabilities = get_port_device_capability(dev);
-	if (!capabilities)
+	capabilities = get_port_device_capability(dev, &aux_dev_list);
+	if (!capabilities && list_empty(&aux_dev_list))
 		return 0;
 
 	pci_set_master(dev);
@@ -385,6 +428,33 @@ static int pcie_port_device_register(struct pci_dev *dev)
 		if (!pcie_device_init(dev, service, irqs[i]))
 			nr_service++;
 	}
+
+	/*
+	 * Register auxiliary bus device found earlier.
+	 * This is done after PCI irq vectors have been requested
+	 * so the indidividual drivers may use their IRQs immediately.
+	 */
+	list_for_each_entry(pcie_adev, &aux_dev_list, node) {
+		status = auxiliary_device_add(&pcie_adev->adev);
+		if (status)
+			return status;
+
+		status = devm_add_action_or_reset(&dev->dev,
+						pcie_port_auxdev_delete,
+						pcie_adev);
+		if (status)
+			return status;
+
+		if (pcie_adev->optional) {
+			nr_service++; /* Need to register even if no one is ready yet */
+		} else {
+			device_lock(&pcie_adev->adev.dev);
+			if (pcie_adev->adev.dev.driver)
+				nr_service++;
+			device_unlock(&pcie_adev->adev.dev);
+		}
+	}
+
 	if (!nr_service)
 		return -ENODEV; /* Why carry on if nothing supported? */
 
@@ -408,6 +478,31 @@ static int pcie_port_device_iter(struct device *dev, void *data)
 	return 0;
 }
 
+static int pcie_port_adev_resume_iter(struct device *dev, void *data)
+{
+	if ((dev->bus == &auxiliary_bus_type) && dev->driver) {
+		struct auxiliary_driver *adrv = to_auxiliary_drv(dev->driver);
+		struct auxiliary_device *adev = to_auxiliary_dev(dev);
+
+		if (adrv->resume)
+			adrv->resume(adev);
+	}
+	return 0;
+}
+
+static int pcie_port_adev_suspend_iter(struct device *dev, void *data)
+{
+	if ((dev->bus == &auxiliary_bus_type) && dev->driver) {
+		struct auxiliary_driver *adrv = to_auxiliary_drv(dev->driver);
+		struct auxiliary_device *adev = to_auxiliary_dev(dev);
+		pm_message_t pm = {};
+
+		if (adrv->suspend)
+			adrv->suspend(adev, pm);
+	}
+	return 0;
+}
+
 #ifdef CONFIG_PM
 /**
  * pcie_port_device_suspend - suspend port services associated with a PCIe port
@@ -415,8 +510,13 @@ static int pcie_port_device_iter(struct device *dev, void *data)
  */
 static int pcie_port_device_suspend(struct device *dev)
 {
+	int ret;
 	size_t off = offsetof(struct pcie_port_service_driver, suspend);
-	return device_for_each_child(dev, &off, pcie_port_device_iter);
+	ret = device_for_each_child(dev, &off, pcie_port_device_iter);
+	if (ret)
+		return ret;
+
+	return device_for_each_child(dev, NULL, pcie_port_adev_suspend_iter);
 }
 
 static int pcie_port_device_resume_noirq(struct device *dev)
@@ -431,7 +531,14 @@ static int pcie_port_device_resume_noirq(struct device *dev)
  */
 static int pcie_port_device_resume(struct device *dev)
 {
-	size_t off = offsetof(struct pcie_port_service_driver, resume);
+	int ret;
+	size_t off;
+
+	ret = device_for_each_child(dev, NULL, pcie_port_adev_resume_iter);
+	if (ret)
+		return ret;
+
+	off = offsetof(struct pcie_port_service_driver, resume);
 	return device_for_each_child(dev, &off, pcie_port_device_iter);
 }
 
@@ -732,6 +839,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 static void pcie_portdrv_shutdown(struct pci_dev *dev)
 {
 	pcie_portdrv_runtime_pm_disable(dev);
+	device_for_each_child(&dev->dev, NULL, aux_remove_iter);
 	pcie_port_device_remove(dev);
 	pci_free_irq_vectors(dev);
 }
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index ea320fb026e6..243a6c9e9bf1 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -9,6 +9,7 @@
 #ifndef _PORTDRV_H_
 #define _PORTDRV_H_
 
+#include <linux/auxiliary_bus.h>
 #include <linux/compiler.h>
 
 /* Service Type */
@@ -51,6 +52,18 @@ int pcie_dpc_init(void);
 static inline int pcie_dpc_init(void) { return 0; }
 #endif
 
+struct pcie_port_aux_dev {
+	struct auxiliary_device adev;
+	u64 addr;
+	struct list_head node;
+	bool optional; /* Drivers may not yet be available */
+};
+#define to_pcie_port_aux_dev(adev)\
+	container_of(adev, struct pcie_port_aux_dev, adev)
+
+int devm_pcie_port_aux_dev_init(struct device *dev,
+				struct pcie_port_aux_dev *pcie_adev);
+
 struct pcie_device {
 	int		irq;	    /* Service IRQ/MSI/MSI-X Vector */
 	struct pci_dev *port;	    /* Root/Upstream/Downstream Port */
-- 
2.39.2


