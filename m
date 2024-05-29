Return-Path: <linux-pci+bounces-8045-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2253D8D3D03
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 18:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9891F22FC0
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 16:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1298A181D06;
	Wed, 29 May 2024 16:41:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80AB1C6B2;
	Wed, 29 May 2024 16:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000899; cv=none; b=DA0UPUH+hqAcdwK6iVsRB/JoGi/ZFu0AbexdNG67ZlhEvkBqySatl4YQdCAl+Iu8LZBGBWarpq/YMYQJOXtzY+pTRW0aETuJZKeIZZRNq6o4c/SaRndy5kBbsyBliaPGBPg2zbb90PQY+P+qFXE9EQ2VgAkQDNuIyS/x85ZuM58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000899; c=relaxed/simple;
	bh=KyioEzZkMBKwpJONrLRvPEWUM/G6oi76nlR6eiaKuhw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j5O0jKr6haQQkmjdC80cPRQ/3D/Wq4RzeC3zRjYnFA+txLygTpKqCv2bHKsdMR3Nlv/Snk8Z6BWz/0SG1hbfqlFKYMY93WYItSeqsOVI68rwK28dpPDe1k2lueMO2MFhyhEEsBRdsRrxwIPtrg6lTiMvwtVrPtLB+IK3/JKE9mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VqFVn3777z67l0C;
	Thu, 30 May 2024 00:40:33 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 590F8140447;
	Thu, 30 May 2024 00:41:34 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 17:41:33 +0100
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
Subject: [RFC PATCH 1/9] pci: pcie: Drop priv_data from struct pcie_device and use dev_get/set_drvdata() instead.
Date: Wed, 29 May 2024 17:40:55 +0100
Message-ID: <20240529164103.31671-2-Jonathan.Cameron@huawei.com>
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

struct device has a driver_data pointer for the same purpose
as the priv_data in struct pcie_device, so use that via the
embedded struct device instead.

This will simplify moving to a different approach to the
pcie_device handling.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/hotplug/pciehp_core.c | 12 ++++++------
 drivers/pci/hotplug/pciehp_hpc.c  |  2 +-
 drivers/pci/pcie/aer.c            |  8 ++++----
 drivers/pci/pcie/pme.c            | 13 +++++++------
 drivers/pci/pcie/portdrv.h        | 11 -----------
 5 files changed, 18 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index ddd55ad97a58..8e8d88f0d501 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -202,7 +202,7 @@ static int pciehp_probe(struct pcie_device *dev)
 		pci_err(dev->port, "Controller initialization failed\n");
 		return -ENODEV;
 	}
-	set_service_data(dev, ctrl);
+	dev_set_drvdata(&dev->device, ctrl);
 
 	/* Setup the slot information structures */
 	rc = init_slot(ctrl);
@@ -243,7 +243,7 @@ static int pciehp_probe(struct pcie_device *dev)
 
 static void pciehp_remove(struct pcie_device *dev)
 {
-	struct controller *ctrl = get_service_data(dev);
+	struct controller *ctrl = dev_get_drvdata(&dev->device);
 
 	pci_hp_del(&ctrl->hotplug_slot);
 	pcie_shutdown_notification(ctrl);
@@ -267,7 +267,7 @@ static void pciehp_disable_interrupt(struct pcie_device *dev)
 	 * immediately when the downstream link goes down.
 	 */
 	if (pme_is_native(dev))
-		pcie_disable_interrupt(get_service_data(dev));
+		pcie_disable_interrupt(dev_get_drvdata(&dev->device));
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -286,7 +286,7 @@ static int pciehp_suspend(struct pcie_device *dev)
 
 static int pciehp_resume_noirq(struct pcie_device *dev)
 {
-	struct controller *ctrl = get_service_data(dev);
+	struct controller *ctrl = dev_get_drvdata(&dev->device);
 
 	/* pci_restore_state() just wrote to the Slot Control register */
 	ctrl->cmd_started = jiffies;
@@ -302,7 +302,7 @@ static int pciehp_resume_noirq(struct pcie_device *dev)
 
 static int pciehp_resume(struct pcie_device *dev)
 {
-	struct controller *ctrl = get_service_data(dev);
+	struct controller *ctrl = dev_get_drvdata(&dev->device);
 
 	if (pme_is_native(dev))
 		pcie_enable_interrupt(ctrl);
@@ -320,7 +320,7 @@ static int pciehp_runtime_suspend(struct pcie_device *dev)
 
 static int pciehp_runtime_resume(struct pcie_device *dev)
 {
-	struct controller *ctrl = get_service_data(dev);
+	struct controller *ctrl = dev_get_drvdata(&dev->device);
 
 	/* pci_restore_state() just wrote to the Slot Control register */
 	ctrl->cmd_started = jiffies;
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index b1d0a1b3917d..3e12ec4a2671 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -871,7 +871,7 @@ void pcie_disable_interrupt(struct controller *ctrl)
  */
 int pciehp_slot_reset(struct pcie_device *dev)
 {
-	struct controller *ctrl = get_service_data(dev);
+	struct controller *ctrl = dev_get_drvdata(&dev->device);
 
 	if (ctrl->state != ON_STATE)
 		return 0;
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index ac6293c24976..189b50e4bc8d 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1328,7 +1328,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 static irqreturn_t aer_isr(int irq, void *context)
 {
 	struct pcie_device *dev = (struct pcie_device *)context;
-	struct aer_rpc *rpc = get_service_data(dev);
+	struct aer_rpc *rpc = dev_get_drvdata(&dev->device);
 	struct aer_err_source e_src;
 
 	if (kfifo_is_empty(&rpc->aer_fifo))
@@ -1349,7 +1349,7 @@ static irqreturn_t aer_isr(int irq, void *context)
 static irqreturn_t aer_irq(int irq, void *context)
 {
 	struct pcie_device *pdev = (struct pcie_device *)context;
-	struct aer_rpc *rpc = get_service_data(pdev);
+	struct aer_rpc *rpc = dev_get_drvdata(&pdev->device);
 	struct pci_dev *rp = rpc->rpd;
 	int aer = rp->aer_cap;
 	struct aer_err_source e_src = {};
@@ -1448,7 +1448,7 @@ static void aer_disable_rootport(struct aer_rpc *rpc)
  */
 static void aer_remove(struct pcie_device *dev)
 {
-	struct aer_rpc *rpc = get_service_data(dev);
+	struct aer_rpc *rpc = dev_get_drvdata(&dev->device);
 
 	aer_disable_rootport(rpc);
 }
@@ -1482,7 +1482,7 @@ static int aer_probe(struct pcie_device *dev)
 
 	rpc->rpd = port;
 	INIT_KFIFO(rpc->aer_fifo);
-	set_service_data(dev, rpc);
+	dev_set_drvdata(&dev->device, rpc);
 
 	status = devm_request_threaded_irq(device, dev->irq, aer_irq, aer_isr,
 					   IRQF_SHARED, "aerdrv", dev);
diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index a2daebd9806c..2e23f131ed3e 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -265,13 +265,14 @@ static void pcie_pme_work_fn(struct work_struct *work)
  */
 static irqreturn_t pcie_pme_irq(int irq, void *context)
 {
+	struct pcie_device *srv = context;
 	struct pci_dev *port;
 	struct pcie_pme_service_data *data;
 	u32 rtsta;
 	unsigned long flags;
 
-	port = ((struct pcie_device *)context)->port;
-	data = get_service_data((struct pcie_device *)context);
+	port = srv->port;
+	data = dev_get_drvdata(&srv->device);
 
 	spin_lock_irqsave(&data->lock, flags);
 	pcie_capability_read_dword(port, PCI_EXP_RTSTA, &rtsta);
@@ -342,7 +343,7 @@ static int pcie_pme_probe(struct pcie_device *srv)
 	spin_lock_init(&data->lock);
 	INIT_WORK(&data->work, pcie_pme_work_fn);
 	data->srv = srv;
-	set_service_data(srv, data);
+	dev_set_drvdata(&srv->device, data);
 
 	pcie_pme_interrupt_enable(port, false);
 	pcie_clear_root_pme_status(port);
@@ -391,7 +392,7 @@ static void pcie_pme_disable_interrupt(struct pci_dev *port,
  */
 static int pcie_pme_suspend(struct pcie_device *srv)
 {
-	struct pcie_pme_service_data *data = get_service_data(srv);
+	struct pcie_pme_service_data *data = dev_get_drvdata(&srv->device);
 	struct pci_dev *port = srv->port;
 	bool wakeup;
 	int ret;
@@ -422,7 +423,7 @@ static int pcie_pme_suspend(struct pcie_device *srv)
  */
 static int pcie_pme_resume(struct pcie_device *srv)
 {
-	struct pcie_pme_service_data *data = get_service_data(srv);
+	struct pcie_pme_service_data *data = dev_get_drvdata(&srv->device);
 
 	spin_lock_irq(&data->lock);
 	if (data->noirq) {
@@ -445,7 +446,7 @@ static int pcie_pme_resume(struct pcie_device *srv)
  */
 static void pcie_pme_remove(struct pcie_device *srv)
 {
-	struct pcie_pme_service_data *data = get_service_data(srv);
+	struct pcie_pme_service_data *data = dev_get_drvdata(&srv->device);
 
 	pcie_pme_disable_interrupt(srv->port, data);
 	free_irq(srv->irq, srv);
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 12c89ea0313b..344b796a8579 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -58,21 +58,10 @@ struct pcie_device {
 	int		irq;	    /* Service IRQ/MSI/MSI-X Vector */
 	struct pci_dev *port;	    /* Root/Upstream/Downstream Port */
 	u32		service;    /* Port service this device represents */
-	void		*priv_data; /* Service Private Data */
 	struct device	device;     /* Generic Device Interface */
 };
 #define to_pcie_device(d) container_of(d, struct pcie_device, device)
 
-static inline void set_service_data(struct pcie_device *dev, void *data)
-{
-	dev->priv_data = data;
-}
-
-static inline void *get_service_data(struct pcie_device *dev)
-{
-	return dev->priv_data;
-}
-
 struct pcie_port_service_driver {
 	const char *name;
 	int (*probe)(struct pcie_device *dev);
-- 
2.39.2


