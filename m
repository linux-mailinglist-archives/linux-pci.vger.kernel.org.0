Return-Path: <linux-pci+bounces-8046-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DFF8D3D04
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 18:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621BD28118B
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 16:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACAD180A90;
	Wed, 29 May 2024 16:42:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B8F1C6B2;
	Wed, 29 May 2024 16:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000929; cv=none; b=KqcT9UQnf/8/0KrYhde8M9YE+BZ+a45OrmCV3cj5iEJgFi6svY7dD+3jbYALKxvLoXdi+1bZJdpWkHhwaTq+XOslWXBPEUie/Jq+wWGakQdGF2P6ig0WinYmO92OOISHNiy+hoXb83/JM6OTjBG+psWCS46uONM2j99B/kLATNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000929; c=relaxed/simple;
	bh=SG00POVN9C9ZbN4FA2bmaSh5sb1jAehMGHbe44RBbWw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XCXvSmbXJYEtzgFNAXQQQIb1Vfyv7A8d8X90REpkS0Go+xdIDgCP8zssr0qRso0Dvp5RJXtYTorN1obPvIcHqW0QUmmFTxgSPyCalsF8C8F+Zvt/7L4OYpZLSmma0iovY+OsW86xfuMqCBYjPwdUCoQgMUp+jJdaUYLQHkfUTDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VqFWN1n8bz67NNV;
	Thu, 30 May 2024 00:41:04 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 29FD51400CA;
	Thu, 30 May 2024 00:42:05 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 17:42:04 +0100
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
Subject: [RFC PATCH 2/9] pci: portdrv: Drop driver field for port type.
Date: Wed, 29 May 2024 17:40:56 +0100
Message-ID: <20240529164103.31671-3-Jonathan.Cameron@huawei.com>
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

Always set to PCIE_ANY_PORT so no information.
Drop PCIE_ANY_PORT definition as well as not used for anything else.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/hotplug/pciehp_core.c | 1 -
 drivers/pci/pci-driver.c          | 4 ----
 drivers/pci/pcie/aer.c            | 1 -
 drivers/pci/pcie/dpc.c            | 1 -
 drivers/pci/pcie/pme.c            | 1 -
 drivers/pci/pcie/portdrv.h        | 4 ----
 6 files changed, 12 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 8e8d88f0d501..be666771c6e3 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -337,7 +337,6 @@ static int pciehp_runtime_resume(struct pcie_device *dev)
 
 static struct pcie_port_service_driver hpdriver_portdrv = {
 	.name		= "pciehp",
-	.port_type	= PCIE_ANY_PORT,
 	.service	= PCIE_PORT_SERVICE_HP,
 
 	.probe		= pciehp_probe,
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index af2996d0d17f..cd84c0cb80a4 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1702,10 +1702,6 @@ static int pcie_port_bus_match(struct device *dev, struct device_driver *drv)
 	if (driver->service != pciedev->service)
 		return 0;
 
-	if (driver->port_type != PCIE_ANY_PORT &&
-	    driver->port_type != pci_pcie_type(pciedev->port))
-		return 0;
-
 	return 1;
 }
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 189b50e4bc8d..e07c5bf71372 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1557,7 +1557,6 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 
 static struct pcie_port_service_driver aerdriver = {
 	.name		= "aer",
-	.port_type	= PCIE_ANY_PORT,
 	.service	= PCIE_PORT_SERVICE_AER,
 
 	.probe		= aer_probe,
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index a668820696dc..130e00bfd1e1 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -462,7 +462,6 @@ static void dpc_remove(struct pcie_device *dev)
 
 static struct pcie_port_service_driver dpcdriver = {
 	.name		= "dpc",
-	.port_type	= PCIE_ANY_PORT,
 	.service	= PCIE_PORT_SERVICE_DPC,
 	.probe		= dpc_probe,
 	.remove		= dpc_remove,
diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index 2e23f131ed3e..dc6b1f5fbe48 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -456,7 +456,6 @@ static void pcie_pme_remove(struct pcie_device *srv)
 
 static struct pcie_port_service_driver pcie_pme_driver = {
 	.name		= "pcie_pme",
-	.port_type	= PCIE_ANY_PORT,
 	.service	= PCIE_PORT_SERVICE_PME,
 
 	.probe		= pcie_pme_probe,
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 344b796a8579..ea320fb026e6 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -51,9 +51,6 @@ int pcie_dpc_init(void);
 static inline int pcie_dpc_init(void) { return 0; }
 #endif
 
-/* Port Type */
-#define PCIE_ANY_PORT			(~0)
-
 struct pcie_device {
 	int		irq;	    /* Service IRQ/MSI/MSI-X Vector */
 	struct pci_dev *port;	    /* Root/Upstream/Downstream Port */
@@ -74,7 +71,6 @@ struct pcie_port_service_driver {
 
 	int (*slot_reset)(struct pcie_device *dev);
 
-	int port_type;  /* Type of the port this driver can handle */
 	u32 service;    /* Port service this device represents */
 
 	struct device_driver driver;
-- 
2.39.2


