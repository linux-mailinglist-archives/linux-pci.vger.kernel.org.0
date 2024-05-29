Return-Path: <linux-pci+bounces-8053-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9848D3D10
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 18:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4AAF1F24722
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 16:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537B415B129;
	Wed, 29 May 2024 16:45:45 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C10042A96;
	Wed, 29 May 2024 16:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717001145; cv=none; b=d6rh5Qhbir5pYkemMp6NFBelLWZ1xdG4594Ooh0iW4Ko6OCYZexvhzXohAPGWKeUwYF3Bcgf6Od6P9uo4jNqFDzFxKL/ieM9vZQQ2rPeYYllWhZ+OZjIZ96XRuIUFlQE/jggsT96Gc6B9pZgtEyCW3zg/h8D2/8jN0hUU9aJ4Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717001145; c=relaxed/simple;
	bh=4LwIbzkwgQpF6y04LHoBoQ42AbWEmnEEuHP5SFsAzU8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZtI44JSCsijWpGhdNDQ1V7wWKvCT/LGIHGa1GBHAuoKv8VENv54jqERqWMNC0sOG2AR9Cs4Ah8W/TmS8EB/lnc/K4LNqouBWoDLIMWFQFU71mYwjNfZbw3HhSWirtNOyWoR3cydis/DERdK9W/M5by7gpYzKSKNRGtftkC/Dn9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VqFbX37Bgz67l0C;
	Thu, 30 May 2024 00:44:40 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 594C314038F;
	Thu, 30 May 2024 00:45:41 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 17:45:40 +0100
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
Subject: [RFC PATCH 9/9] pci: pcie: portdrv: aer: Switch to auxiliary_bus
Date: Wed, 29 May 2024 17:41:03 +0100
Message-ID: <20240529164103.31671-10-Jonathan.Cameron@huawei.com>
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

Not sure if this is a good idea or not. (probably not!)
Is it useful to add a bus device for a feature that there is
only ever one of?  Maybe or perhaps better option is to convert
this to directly called library code rather than a device + separate
driver.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
Discussion of options / why in the cover letter.

 drivers/pci/pcie/aer.c     | 67 +++++++++++++++++++++++++-------------
 drivers/pci/pcie/portdrv.c | 34 ++++++++++++++++---
 2 files changed, 75 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index e07c5bf71372..2df996d80849 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -15,6 +15,7 @@
 #define pr_fmt(fmt) "AER: " fmt
 #define dev_fmt pr_fmt
 
+#include <linux/auxiliary_bus.h>
 #include <linux/bitops.h>
 #include <linux/cper.h>
 #include <linux/pci.h>
@@ -1327,8 +1328,9 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
  */
 static irqreturn_t aer_isr(int irq, void *context)
 {
-	struct pcie_device *dev = (struct pcie_device *)context;
-	struct aer_rpc *rpc = dev_get_drvdata(&dev->device);
+	struct pcie_port_aux_dev *pcie_adev = context;
+	struct device *dev = &pcie_adev->adev.dev;
+	struct aer_rpc *rpc = dev_get_drvdata(dev);
 	struct aer_err_source e_src;
 
 	if (kfifo_is_empty(&rpc->aer_fifo))
@@ -1348,8 +1350,9 @@ static irqreturn_t aer_isr(int irq, void *context)
  */
 static irqreturn_t aer_irq(int irq, void *context)
 {
-	struct pcie_device *pdev = (struct pcie_device *)context;
-	struct aer_rpc *rpc = dev_get_drvdata(&pdev->device);
+	struct pcie_port_aux_dev *pcie_adev = context;
+	struct device *dev = &pcie_adev->adev.dev;
+	struct aer_rpc *rpc = dev_get_drvdata(dev);
 	struct pci_dev *rp = rpc->rpd;
 	int aer = rp->aer_cap;
 	struct aer_err_source e_src = {};
@@ -1442,58 +1445,74 @@ static void aer_disable_rootport(struct aer_rpc *rpc)
 
 /**
  * aer_remove - clean up resources
- * @dev: pointer to the pcie_dev data structure
+ * @adev: pointer to the auxiliary device within the pcie_port_aux_dev
  *
  * Invoked when PCI Express bus unloads or AER probe fails.
  */
-static void aer_remove(struct pcie_device *dev)
+static void aer_remove(struct auxiliary_device *adev)
 {
-	struct aer_rpc *rpc = dev_get_drvdata(&dev->device);
-
+	struct aer_rpc *rpc = dev_get_drvdata(&adev->dev);
 	aer_disable_rootport(rpc);
 }
 
 /**
  * aer_probe - initialize resources
- * @dev: pointer to the pcie_dev data structure
+ * @adev: pointer to the auxiliary device within the pcie_port_aux_dev
+ * @id: id table entry that matched.
  *
  * Invoked when PCI Express bus loads AER service driver.
  */
-static int aer_probe(struct pcie_device *dev)
+static int aer_probe(struct auxiliary_device *adev,
+		     const struct auxiliary_device_id *id)
 {
+	struct pcie_port_aux_dev *pcie_adev = to_pcie_port_aux_dev(adev);
 	int status;
 	struct aer_rpc *rpc;
-	struct device *device = &dev->device;
-	struct pci_dev *port = dev->port;
+	struct device *dev = &adev->dev;
+	struct pci_dev *port = to_pci_dev(dev->parent);
+	u32 pos, reg32;
+	int irq_num, irq;
 
 	BUILD_BUG_ON(ARRAY_SIZE(aer_correctable_error_string) <
 		     AER_MAX_TYPEOF_COR_ERRS);
 	BUILD_BUG_ON(ARRAY_SIZE(aer_uncorrectable_error_string) <
 		     AER_MAX_TYPEOF_UNCOR_ERRS);
 
+	pos = port->aer_cap;
+	if (pos) {
+		pci_read_config_dword(port, pos + PCI_ERR_ROOT_STATUS,
+				&reg32);
+		irq_num = FIELD_GET(PCI_ERR_ROOT_AER_IRQ, reg32);
+		/* To check - is this sufficient to detect legacy case? */
+		if (pci_dev_msi_enabled(port))
+			irq = pci_irq_vector(port, irq_num);
+		else
+			irq = pci_irq_vector(port, 0);
+	}
+
 	/* Limit to Root Ports or Root Complex Event Collectors */
 	if ((pci_pcie_type(port) != PCI_EXP_TYPE_RC_EC) &&
 	    (pci_pcie_type(port) != PCI_EXP_TYPE_ROOT_PORT))
 		return -ENODEV;
 
-	rpc = devm_kzalloc(device, sizeof(struct aer_rpc), GFP_KERNEL);
+	rpc = devm_kzalloc(dev, sizeof(struct aer_rpc), GFP_KERNEL);
 	if (!rpc)
 		return -ENOMEM;
 
 	rpc->rpd = port;
 	INIT_KFIFO(rpc->aer_fifo);
-	dev_set_drvdata(&dev->device, rpc);
+	dev_set_drvdata(&adev->dev, rpc);
 
-	status = devm_request_threaded_irq(device, dev->irq, aer_irq, aer_isr,
-					   IRQF_SHARED, "aerdrv", dev);
+	status = devm_request_threaded_irq(dev, irq, aer_irq, aer_isr,
+					   IRQF_SHARED, "aerdrv", pcie_adev);
 	if (status) {
-		pci_err(port, "request AER IRQ %d failed\n", dev->irq);
+		pci_err(port, "request AER IRQ %d failed\n", irq);
 		return status;
 	}
 
 	cxl_rch_enable_rcec(port);
 	aer_enable_rootport(rpc);
-	pci_info(port, "enabled with IRQ %d\n", dev->irq);
+	pci_info(port, "enabled with IRQ %d\n", irq);
 	return 0;
 }
 
@@ -1555,12 +1574,16 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
 }
 
-static struct pcie_port_service_driver aerdriver = {
-	.name		= "aer",
-	.service	= PCIE_PORT_SERVICE_AER,
+static const struct auxiliary_device_id aer_ids[] = {
+	{ .name = "pcieportdrv.aer" },
+	{ }
+};
 
+static struct auxiliary_driver aerdriver = {
+	.name		= "aer",
 	.probe		= aer_probe,
 	.remove		= aer_remove,
+	.id_table	= aer_ids,
 };
 
 /**
@@ -1572,5 +1595,5 @@ int __init pcie_aer_init(void)
 {
 	if (!pci_aer_available())
 		return -ENXIO;
-	return pcie_port_service_register(&aerdriver);
+	return auxiliary_driver_register(&aerdriver);
 }
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 7274ee55a8c3..14aedce3be3b 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -162,9 +162,6 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 		irqs[PCIE_PORT_SERVICE_BWNOTIF_SHIFT] = pcie_irq;
 	}
 
-	if (mask & PCIE_PORT_SERVICE_AER)
-		irqs[PCIE_PORT_SERVICE_AER_SHIFT] = pci_irq_vector(dev, aer);
-
 	if (mask & PCIE_PORT_SERVICE_DPC)
 		irqs[PCIE_PORT_SERVICE_DPC_SHIFT] = pci_irq_vector(dev, dpc);
 
@@ -210,6 +207,15 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
 	return 0;
 }
 
+DEFINE_IDA(pcie_portdrv_aer_ida);
+
+static void pcie_port_aer_adev_release(struct device *dev)
+{
+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
+
+	ida_free(&pcie_portdrv_aer_ida, adev->id);
+}
+
 /**
  * get_port_device_capability - discover capabilities of a PCI Express port
  * @dev: PCI Express port to examine
@@ -245,8 +251,28 @@ static int get_port_device_capability(struct pci_dev *dev,
 	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
              pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
 	    dev->aer_cap && pci_aer_available() &&
-	    (pcie_ports_native || host->native_aer))
+	    (pcie_ports_native || host->native_aer)) {
+		struct pcie_port_aux_dev *pcie_adev;
+		int id, ret;
+
+		pcie_adev = devm_kzalloc(&dev->dev, sizeof(*pcie_adev), GFP_KERNEL);
+		if (!pcie_adev)
+			return -ENOMEM;
+
+		id = ida_alloc(&pcie_portdrv_aer_ida, GFP_KERNEL);
+		if (id < 0)
+			return id;
+		pcie_adev->adev.name = "aer";
+		pcie_adev->adev.id = id;
+		pcie_adev->adev.dev.parent = &dev->dev;
+		pcie_adev->adev.dev.release = pcie_port_aer_adev_release;
+
+		ret = devm_pcie_port_aux_dev_init(&dev->dev, pcie_adev);
+		if (ret)
+			return ret;
+		list_add(&pcie_adev->node, aux_dev_list);
 		services |= PCIE_PORT_SERVICE_AER;
+	}
 #endif
 
 	/* Root Ports and Root Complex Event Collectors may generate PMEs */
-- 
2.39.2


