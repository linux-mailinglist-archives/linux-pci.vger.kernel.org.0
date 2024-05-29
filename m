Return-Path: <linux-pci+bounces-8052-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B1E8D3D0F
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 18:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 278BC1F24718
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 16:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F929181CFC;
	Wed, 29 May 2024 16:45:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A9A15B129;
	Wed, 29 May 2024 16:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717001114; cv=none; b=pPuTSCnpqK1Iyk9krQ/fqckbsZrZtLzgnkXe7n3ER3MmfzDIYmrXOhF/P4BkmO4NvXTU5bP59DsD89kEXrdR8YD4IVr7tOVJh2TAryNYAqKJOEpvkFA6BJ7h+JfkuG9ZWp1KB/C8FxaOlWOMyRPtqO+pBrQMjCNc9mZQMomS4x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717001114; c=relaxed/simple;
	bh=3Tb4ptQFGDmSvVIucXkDrYQAhOZWM+3uTZBilsMTdwQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ruoWbiyit7AcGSHkQIKFoowsVq2j+6NJO0ezTBSzcE7V4CyogPnimrtlRMFWrUB9wTGsHgVkyUkg6RxVJiqrlwHwAvzUqjvkdw2ijllNoSekI+wuToLCgNplqTxI/Jf6aKu0Tjd9+VSEGliXAotd5FUEDRK4DdvaKn4jm5CymhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VqFWW0Cg7z6J9mb;
	Thu, 30 May 2024 00:41:11 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 87A8C140B33;
	Thu, 30 May 2024 00:45:10 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 17:45:10 +0100
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
Subject: [RFC PATCH 8/9] perf: cxl: Make the cpmu driver also work with auxiliary_devices
Date: Wed, 29 May 2024 17:41:02 +0100
Message-ID: <20240529164103.31671-9-Jonathan.Cameron@huawei.com>
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

CXL PMUs can be found both in endpoints (already supported) and
in switch usp/dsp and root ports.  Those ports are all handled
by pcie/portdrv which will register auxiliary_devices rather
than devices on the CXL bus.

Make the CXL PMU driver register an auxiliary driver as well as
the existing one for device on /sys/bus/cxl.
There is no particular need for this driver to register early
or to deal with particularly compact kernel configurations, so just
make it dependent on both bus drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/perf/Kconfig   |  1 +
 drivers/perf/cxl_pmu.c | 99 +++++++++++++++++++++++++++++++++++-------
 2 files changed, 85 insertions(+), 15 deletions(-)

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 7526a9e714fa..4b7893a03a4c 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -255,6 +255,7 @@ source "drivers/perf/amlogic/Kconfig"
 config CXL_PMU
 	tristate "CXL Performance Monitoring Unit"
 	depends on CXL_BUS
+	depends on AUXILIARY_BUS
 	help
 	  Support performance monitoring as defined in CXL rev 3.0
 	  section 13.2: Performance Monitoring. CXL components may have
diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 65a8437ee236..30b2aad556ad 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/auxiliary_bus.h>
 #include <linux/perf_event.h>
 #include <linux/bitops.h>
 #include <linux/device.h>
@@ -20,6 +21,7 @@
 #include <linux/bug.h>
 #include <linux/pci.h>
 
+#include "../pci/pcie/portdrv.h"
 #include "../cxl/cxlpci.h"
 #include "../cxl/cxl.h"
 #include "../cxl/pmu.h"
@@ -753,13 +755,12 @@ static void cxl_pmu_cpuhp_remove(void *_info)
 	cpuhp_state_remove_instance_nocalls(cxl_pmu_cpuhp_state_num, &info->node);
 }
 
-static int cxl_pmu_probe(struct device *dev)
+static int __cxl_pmu_probe(struct device *dev, const char *dev_name,
+			   void __iomem *base)
 {
-	struct cxl_pmu *pmu = to_cxl_pmu(dev);
 	struct pci_dev *pdev = to_pci_dev(dev->parent);
 	struct cxl_pmu_info *info;
 	char *irq_name;
-	char *dev_name;
 	int rc, irq;
 
 	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
@@ -767,10 +768,10 @@ static int cxl_pmu_probe(struct device *dev)
 		return -ENOMEM;
 
 	dev_set_drvdata(dev, info);
+
 	INIT_LIST_HEAD(&info->event_caps_fixed);
 	INIT_LIST_HEAD(&info->event_caps_configurable);
-
-	info->base = pmu->base;
+	info->base = base;
 
 	info->on_cpu = -1;
 	rc = cxl_pmu_parse_caps(dev, info);
@@ -782,15 +783,6 @@ static int cxl_pmu_probe(struct device *dev)
 	if (!info->hw_events)
 		return -ENOMEM;
 
-	switch (pmu->type) {
-	case CXL_PMU_MEMDEV:
-		dev_name = devm_kasprintf(dev, GFP_KERNEL, "cxl_pmu_mem%d.%d",
-					  pmu->assoc_id, pmu->index);
-		break;
-	}
-	if (!dev_name)
-		return -ENOMEM;
-
 	info->pmu = (struct pmu) {
 		.name = dev_name,
 		.parent = dev,
@@ -843,6 +835,60 @@ static int cxl_pmu_probe(struct device *dev)
 		return rc;
 
 	return 0;
+
+}
+
+static int cxl_pmu_port_probe(struct auxiliary_device *adev,
+			      const struct auxiliary_device_id *id)
+{
+
+	struct pcie_port_aux_dev *pcie_adev = to_pcie_port_aux_dev(adev);
+	struct device *parent = adev->dev.parent;
+	struct pci_dev *pdev = to_pci_dev(parent);
+	struct device *dev = &adev->dev;
+	char *dev_name;
+	void __iomem *base;
+	struct resource *res;
+
+	/*
+	 * Map only the CPMU region because other parts are in control
+	 * of the CXL port driver.
+	 */
+	res = devm_request_mem_region(&adev->dev, pcie_adev->addr,
+				      CXL_PMU_REGMAP_SIZE, NULL);
+	if (!res) {
+		pci_err(pdev, "CPMU: could not map\n");
+		return -ENOMEM;
+	}
+
+	base = devm_ioremap(&adev->dev, pcie_adev->addr, CXL_PMU_REGMAP_SIZE);
+	if (!base) {
+		pci_err(pdev, "CPU: ioremap fail\n");
+		return -ENOMEM;
+	}
+	dev_name = devm_kasprintf(dev, GFP_KERNEL, "cxl_pmu_port%d",
+				  adev->id);
+	if (!dev_name)
+		return -ENOMEM;
+
+	return __cxl_pmu_probe(dev, dev_name, base);
+}
+
+static int cxl_pmu_probe(struct device *dev)
+{
+	struct cxl_pmu *pmu = to_cxl_pmu(dev);
+	char *dev_name;
+
+	switch (pmu->type) {
+	case CXL_PMU_MEMDEV:
+		dev_name = devm_kasprintf(dev, GFP_KERNEL, "cxl_pmu_mem%d.%d",
+					  pmu->assoc_id, pmu->index);
+		break;
+	}
+	if (!dev_name)
+		return -ENOMEM;
+
+	return __cxl_pmu_probe(dev, dev_name, pmu->base);
 }
 
 static struct cxl_driver cxl_pmu_driver = {
@@ -851,6 +897,17 @@ static struct cxl_driver cxl_pmu_driver = {
 	.id = CXL_DEVICE_PMU,
 };
 
+static const struct auxiliary_device_id cxl_port_pmu_ids[] = {
+	{ .name = "pcieportdrv.cpmu" },
+	{ }
+};
+
+static struct auxiliary_driver cxl_port_pmu_driver = {
+	.name = "cxl_port_pmu",
+	.probe = cxl_pmu_port_probe,
+	.id_table = cxl_port_pmu_ids,
+};
+
 static int cxl_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
 {
 	struct cxl_pmu_info *info = hlist_entry_safe(node, struct cxl_pmu_info, node);
@@ -907,13 +964,25 @@ static __init int cxl_pmu_init(void)
 
 	rc = cxl_driver_register(&cxl_pmu_driver);
 	if (rc)
-		cpuhp_remove_multi_state(cxl_pmu_cpuhp_state_num);
+		goto cleanup_hp;
+
+	rc = auxiliary_driver_register(&cxl_port_pmu_driver);
+	if (rc)
+		goto unregister_cxl_driver;
+
+	return 0;
+
+unregister_cxl_driver:
+	cxl_driver_unregister(&cxl_pmu_driver);
+cleanup_hp:
+	cpuhp_remove_multi_state(cxl_pmu_cpuhp_state_num);
 
 	return rc;
 }
 
 static __exit void cxl_pmu_exit(void)
 {
+	auxiliary_driver_unregister(&cxl_port_pmu_driver);
 	cxl_driver_unregister(&cxl_pmu_driver);
 	cpuhp_remove_multi_state(cxl_pmu_cpuhp_state_num);
 }
-- 
2.39.2


