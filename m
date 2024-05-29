Return-Path: <linux-pci+bounces-8051-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8489D8D3D0E
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 18:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE351B20CD9
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 16:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB229181BA9;
	Wed, 29 May 2024 16:44:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA020181BA7;
	Wed, 29 May 2024 16:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717001083; cv=none; b=WhgcEEfF1Jqo+XnuvuP8HKmC9pjJyldKrNxs0ladn4cgS4n8kTkpjgv0ByiXilV1+l37JLkFpwN83+3s0hyOPNcAzDCmc+VYI33Aok4By2K5wjthEd9QGFZYZfLwLPoiEY/qc/vKJnHw/plazU0l8KUGxMJm5BwIogronqpnyqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717001083; c=relaxed/simple;
	bh=leFT2CK5MV9zoLorRvAhV9bHUS93Y8WwaVWkNr6Kq+Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pHIDCJCkqkg3rV462vfi6lhZfCzG6it4kWyyf2w106ZpC7TZh+l3mbQoZEjNEkSXuo6ps6wiOsmsL6bOsy78uDh0k3SohQxUQS1kxKTfCWsIwlvgexkYVEWJMA4h8MpY5N5OxguXanW//vTqZIbCpJPV6R8lzp/scrFBFE5MTmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VqFVw2SKpz6JBHx;
	Thu, 30 May 2024 00:40:40 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D0DA1140B33;
	Thu, 30 May 2024 00:44:39 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 17:44:39 +0100
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
Subject: [RFC PATCH 7/9] pci: pcie/cxl: Register an auxiliary device for each CPMU instance
Date: Wed, 29 May 2024 17:41:01 +0100
Message-ID: <20240529164103.31671-8-Jonathan.Cameron@huawei.com>
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

As CXL PMU instances can be found in root and switch ports and
they want to use an interrupt they must be hung of the portdrv
instance.  Use the new auxiliary bus to do this.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pcie/Kconfig   |   9 +++
 drivers/pci/pcie/Makefile  |   1 +
 drivers/pci/pcie/cxlpmu.c  | 129 +++++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.c |  11 +++-
 drivers/pci/pcie/portdrv.h |  11 ++++
 5 files changed, 160 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 840f87eb4b28..8f43fdec333d 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -156,3 +156,12 @@ config PCIE_EDR
 	  the PCI Firmware Specification r3.2.  Enable this if you want to
 	  support hybrid DPC model which uses both firmware and OS to
 	  implement DPC.
+
+config PCIE_CXL_PMU
+	bool "CXL performance monitoring units on RP and Switch Ports"
+	depends on AUXILIARY_BUS
+	help
+	  CXL root ports, switch upstream and switch downstream ports may
+	  have one or more CXL PMU devices. Enable this option to look
+	  for these and register a device to which the cxl_pmu driver
+	  may bind
\ No newline at end of file
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index 6461aa93fe76..037959bf91bb 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_PCIE_PME)		+= pme.o
 obj-$(CONFIG_PCIE_DPC)		+= dpc.o
 obj-$(CONFIG_PCIE_PTM)		+= ptm.o
 obj-$(CONFIG_PCIE_EDR)		+= edr.o
+obj-$(CONFIG_PCIE_CXL_PMU)	+= cxlpmu.o
diff --git a/drivers/pci/pcie/cxlpmu.c b/drivers/pci/pcie/cxlpmu.c
new file mode 100644
index 000000000000..7716663e567c
--- /dev/null
+++ b/drivers/pci/pcie/cxlpmu.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Discovery of presence of CXL PMU instances and the maximum irqnum.
+ * Registers a auxiliary_device to which a driver can bind after the
+ * CXL bus is available and new devices can be added to ti.
+ */
+#include <linux/kernel.h>
+#include <linux/idr.h>
+#include <linux/list.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+
+#include "portdrv.h"
+#include "../../cxl/cxl.h"
+#include "../../cxl/cxlpci.h"
+#include "../../cxl/pmu.h"
+
+static DEFINE_IDA(pcie_cxl_pmu_ida);
+static void cpmu_adev_release(struct device *dev)
+{
+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
+
+	ida_free(&pcie_cxl_pmu_ida, adev->id);
+}
+
+int pcie_cxl_pmu_get_irqs(struct pci_dev *dev, u32 *max_irq,
+			  struct list_head *aux_dev_list)
+{
+	u32 regblocks, regloc_size;
+	int i, regloc, ret;
+	bool found = false;
+
+	regloc = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
+					   CXL_DVSEC_REG_LOCATOR);
+	if (!regloc)
+		return -ENODEV;
+
+	pci_read_config_dword(dev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
+	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
+
+	regloc += CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET;
+	regblocks = (regloc_size - CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET) / 8;
+
+	for (i = 0; i < regblocks; i++, regloc += 8) {
+		u32 reg_lo, reg_hi;
+		u8 reg_type;
+		struct resource *res;
+		void __iomem *base;
+		u64 offset, val;
+		int bar;
+
+		pci_read_config_dword(dev, regloc, &reg_lo);
+		reg_type = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK,
+				     reg_lo);
+		if (reg_type != CXL_REGLOC_RBI_PMU)
+			continue;
+
+		found = true;
+		/* Now we need to map just enough to get the irq */
+		bar = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BIR_MASK, reg_lo);
+		pci_read_config_dword(dev, regloc + 4, &reg_hi);
+
+		offset = ((u64) reg_hi << 32) |
+			(reg_lo & CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK);
+		if (offset > pci_resource_len(dev, bar)) {
+			pci_warn(dev, "CPMU BAR%d: %pr: too small\n",
+				bar, &dev->resource[bar]);
+			continue;
+		}
+		/*
+		 * Map only the CPMU region because other parts are in control
+		 * of the CXL port driver.
+		 */
+		res = request_mem_region(pci_resource_start(dev, bar) + offset,
+					 CXL_PMU_REGMAP_SIZE, NULL);
+		if (!res) {
+			pci_err(dev, "CPMU: could not map\n");
+			continue;
+		}
+
+		base = ioremap(pci_resource_start(dev, bar) + offset,
+		       CXL_PMU_REGMAP_SIZE);
+		if (!base) {
+			pci_err(dev, "CPU: ioremap fail\n");
+			release_mem_region(res->start, resource_size(res));
+			continue;
+		}
+		if (max_irq) {
+			val = readq(base + CXL_PMU_CAP_REG);
+			if (FIELD_GET(CXL_PMU_CAP_INT, val))
+				*max_irq = max(*max_irq,
+					       (u32)FIELD_GET(CXL_PMU_CAP_MSI_N_MSK, val));
+		}
+		iounmap(base);
+		release_mem_region(res->start, resource_size(res));
+
+		if (aux_dev_list) {
+			struct pcie_port_aux_dev *pcie_adev;
+			int id;
+
+			pcie_adev = devm_kzalloc(&dev->dev, sizeof(*pcie_adev),
+						GFP_KERNEL);
+			if (!pcie_adev)
+				return -ENOMEM;
+
+			/* Cleanup handled by release after devm_pcie_port_aux_dev_init() */
+			id = ida_alloc(&pcie_cxl_pmu_ida, GFP_KERNEL);
+			if (id < 0)
+				return -ENOMEM;
+
+			pcie_adev->adev.name = "cpmu";
+			pcie_adev->adev.id = id;
+			pcie_adev->adev.dev.parent = &dev->dev;
+			pcie_adev->adev.dev.release = cpmu_adev_release;
+			pcie_adev->addr = pci_resource_start(dev, bar) + offset;
+			pcie_adev->optional = true;
+
+			ret = devm_pcie_port_aux_dev_init(&dev->dev, pcie_adev);
+			if (ret)
+				return ret;
+
+			list_add(&pcie_adev->node, aux_dev_list);
+		}
+	}
+	if (!found)
+		return -ENODEV;
+
+	return 0;
+}
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 6314da76de9f..7274ee55a8c3 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -59,7 +59,7 @@ static void release_pcie_device(struct device *dev)
 static int pcie_message_numbers(struct pci_dev *dev, int mask,
 				u32 *pme, u32 *aer, u32 *dpc)
 {
-	u32 nvec = 0, pos;
+	u32 nvec = 0, pos, max_cpmu = 0;
 	u16 reg16;
 
 	/*
@@ -100,6 +100,9 @@ static int pcie_message_numbers(struct pci_dev *dev, int mask,
 		}
 	}
 
+	if (!pcie_cxl_pmu_get_irqs(dev, &max_cpmu, NULL))
+		nvec = max(nvec, max_cpmu + 1);
+
 	return nvec;
 }
 
@@ -278,6 +281,12 @@ static int get_port_device_capability(struct pci_dev *dev,
 			services |= PCIE_PORT_SERVICE_BWNOTIF;
 	}
 
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM ||
+	    pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
+	    pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
+		pcie_cxl_pmu_get_irqs(dev, NULL, aux_dev_list);
+	}
+
 	return services;
 }
 
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 243a6c9e9bf1..8fe6fad7b24a 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -52,6 +52,17 @@ int pcie_dpc_init(void);
 static inline int pcie_dpc_init(void) { return 0; }
 #endif
 
+struct list_head;
+#ifdef CONFIG_PCIE_CXL_PMU
+int pcie_cxl_pmu_get_irqs(struct pci_dev *dev, u32 *max_irq, struct list_head *aux_dev_list);
+#else
+static inline int pcie_cxl_pmu_get_irqs(struct pci_dev *dev, u32 *max_irq,
+					struct list_head *aux_dev_list)
+{
+	return 0;
+}
+#endif
+
 struct pcie_port_aux_dev {
 	struct auxiliary_device adev;
 	u64 addr;
-- 
2.39.2


