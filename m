Return-Path: <linux-pci+bounces-3542-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D14856DEC
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 20:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF62F281F12
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 19:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A306C13A242;
	Thu, 15 Feb 2024 19:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5kISipCf"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB504369A;
	Thu, 15 Feb 2024 19:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708026091; cv=fail; b=c3luFXB5m44ffMo0GqwGlpqDjb9C+K/CKLg44BXIqEMlj19YmpHDYHl7geIzg/iK/ns4sn+oIGxDl3iST25Q/5tek9AG7WuS3l0g0bDGZufJqLotyVZWeqNOTYeLZpblXoPAhGEqDPDRZR1zGpBTKeqVCrD9Uorf69acRP/MB58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708026091; c=relaxed/simple;
	bh=KhmnA1QBrerVvkQrDdDawmgHwfhfKRcCC95Ot2QI6pk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cQuG/oW9BTBif0Y3Nmt3fEoPe4hIc6TrC3HGj3T/V6f9gBjFJ8fjqHkwIzYd0JiQkiogiqOjnLbpE3I+ovDUjaqgbYF+iq8LQOk34HZYc60sjT9SOpvMMmZSyBw8qrJZFja9c1gb/UKxhYjrMk6Xc3D9RPKpmGXWuhUrZqUV1y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5kISipCf; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzISvfjN0Im4l3/T2nLl6kaGrt8OwY+ltDkri0xU1BgI+nhY4ziRRdWVYi76MQY0tj97s0/31zANYnzlwtzbv2cgc0sPLB7AvYdxcpsckwDfTUXbvPQt4PYkb5UbmOm7CUtT3f1zKWzq6VoCy7FL8p6i8PNcbApPwu+Ohhg1S3pRW4xPAVkZxQw2oM6r83ud5W8V55fh3pYQNeUwEH/NQBr5JskHxA1ayBGnLgfh910dwHzNFaJNAFxRhNaGNpityCSJ0UFTLnbDPObp/lcZlEB15vgoMcRa1WwDWiIu41RO6yszvJ27CfUEQ9SrDdGaWT8VVMIX79gyR/NGKW886g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXVP4S+ewsqdgeSsCGUpj6oWHtKcNIOABCrYVZUrx3A=;
 b=WQIQzonIUTlwo3rQ4Aj+zbtxZ6nG6nuHlH7hj6uplfK7MRLQTileRiNFPzoKTyui9NKz+BUGjMq3TJ3g+/jik+f4/0VHmjkbH/eWy7D+uZnnrxdiZsxWa+gjaJDWEZ3XXFG50vyEEmL0cOw0KFn9kCYLfV6BJ+9kdtNfC2Q3zTlPQsTW5wad/mBWH1BGh6t0Hqyfd1yQPBt+60ytItiFVh4rkCGrbaeqcl7AgNJ3Vx6NOMex0YL5tTby1UrguO/U5nEY/IAN4p2JylDaiKuPg4BHxXWqeBR5h+Xog7m0lTtolgCYtQzfIcN1RTGIEFSy6EtDcPELHVP7RVze+JU8FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXVP4S+ewsqdgeSsCGUpj6oWHtKcNIOABCrYVZUrx3A=;
 b=5kISipCf/9/7VpW4Oh6imNBD5mYPR6ujmM+oPvxNuUdYNXAHynb0NX9viZED4GgiyOoOAVdYOQ+zaDKQDrMo2uX35HaSGJ5VJ+nSWd9uRYvi0IMbOtcXskT7rxS7mBLPG9LhBNEHScVvV80aFxHfLiQPlbyosRyXgA6kGWB9IFo=
Received: from BN0PR04CA0146.namprd04.prod.outlook.com (2603:10b6:408:ed::31)
 by DS0PR12MB8199.namprd12.prod.outlook.com (2603:10b6:8:de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Thu, 15 Feb
 2024 19:41:27 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:ed:cafe::e0) by BN0PR04CA0146.outlook.office365.com
 (2603:10b6:408:ed::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Thu, 15 Feb 2024 19:41:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 15 Feb 2024 19:41:26 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 13:41:24 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>,
	<benjamin.cheatham@amd.com>
Subject: [RFC PATCH 2/6] pcie/cxl_timeout: Add CXL Timeout & Isolation service driver
Date: Thu, 15 Feb 2024 13:40:44 -0600
Message-ID: <20240215194048.141411-3-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215194048.141411-1-Benjamin.Cheatham@amd.com>
References: <20240215194048.141411-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|DS0PR12MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: a4a82a52-2887-4f6d-5244-08dc2e5e1983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+7GNBHDyS+fjXqOEXeuUQuB5GcQXQlm5HLc58WaIAfwF/G1PILOHUNlI7TJxgF4qp0RHlDf3PAaTrGUnBFkEQyH6mxCRnpiotowx1J8h//ldrGsFWAy9hPNnW0NJHrCtgnWxc9UUbFTA6JkkcRveYk+LaG84RS7rP4mIGO6fIQMAmdXMTKAZ4qNVY5g0TP57Z3+AfyQcmhwL/3+8nKEMSC/EaR+VudMOoOjTqIJhthoiUuDMRaxwFrV+qDUzqXTVMEjJdong37J/ToL3qXJXeLHON0nQfnJtcRl5VD1oCipz87qtEtvALsVLXPT7kgdkh3Bqef/WHQWz7kmUvfFUYiyHifuE27uu2luhAd/2+O5BZ/f0GGnTCkuuoqjp5wX9v2NIx/NeawT7gSyMic2t/L+iZtwyr+2m+5/WFpRQcKLuCWbnFspPI40+Au3P3aV/A3t6tPRSNRUd1ljtjXye+B3cFMRE8GV2XxLVgq5hwhRyPpulUKUu1IUUrACECdt/3Q/ECErEkqmSbsW8Pg72ejLKNpu3CtXPTKOryDIKPW4DzOF65pEd1qRa9BwHzfiKwtL/wjHpxMaluFDvK65++sgKTMW0yLb2rtoZ3p6SD63xk/PB8xRRDMhBC4gjZnOvmpA+DwsziGGHQFxLo15o9KZrKHcruSnDQpiO0CoHl5U=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(64100799003)(451199024)(36860700004)(1800799012)(82310400011)(186009)(46966006)(40470700004)(7416002)(8676002)(70586007)(8936002)(70206006)(5660300002)(4326008)(2906002)(82740400003)(110136005)(36756003)(16526019)(356005)(81166007)(83380400001)(86362001)(478600001)(54906003)(316002)(7696005)(6666004)(426003)(2616005)(1076003)(26005)(41300700001)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 19:41:26.9139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a82a52-2887-4f6d-5244-08dc2e5e1983
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8199

Add a CXL Timeout & Isolation (CXL 3.0 12.3) service driver to the
PCIe port bus driver for CXL root ports. The service will support
enabling/programming CXL.mem transaction timeout, error isolation,
and interrupt handling.

Add code to find and map CXL Timeout & Isolation capability register
(CXL 3.0 8.2.4.23.1) from service driver. Then use capability register
mapping to enable CXL.mem transaction timeout with the default value.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/cxl.h              |   4 +
 drivers/pci/pcie/Kconfig       |  10 ++
 drivers/pci/pcie/Makefile      |   1 +
 drivers/pci/pcie/cxl_timeout.c | 197 +++++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.c     |   1 +
 drivers/pci/pcie/portdrv.h     |  10 +-
 6 files changed, 222 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/pcie/cxl_timeout.c

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 87f3178d6642..0c65f4ec7aae 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -129,7 +129,11 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 
 /* CXL 3.0 8.2.4.23 CXL Timeout and Isolation Capability Structure */
 #define CXL_TIMEOUT_CAPABILITY_OFFSET 0x0
+#define   CXL_TIMEOUT_CAP_MEM_TIMEOUT_SUPP BIT(4)
+#define CXL_TIMEOUT_CONTROL_OFFSET 0x8
+#define   CXL_TIMEOUT_CONTROL_MEM_TIMEOUT_ENABLE BIT(4)
 #define CXL_TIMEOUT_CAPABILITY_LENGTH 0x10
+
 /* RAS Registers CXL 2.0 8.2.5.9 CXL RAS Capability Structure */
 #define CXL_RAS_UNCORRECTABLE_STATUS_OFFSET 0x0
 #define   CXL_RAS_UNCORRECTABLE_STATUS_MASK (GENMASK(16, 14) | GENMASK(11, 0))
diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 8999fcebde6a..27820af4502e 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -58,6 +58,16 @@ config PCIEAER_CXL
 
 	  If unsure, say Y.
 
+config PCIE_CXL_TIMEOUT
+	bool "PCI Express CXL.mem Timeout & Isolation Interrupt support"
+	depends on PCIEPORTBUS
+	depends on CXL_BUS=PCIEPORTBUS && CXL_PORT
+	help
+	  Enables the CXL.mem Timeout & Isolation PCIE port service driver. This
+	  driver, in combination with the CXL driver core, is responsible for
+	  handling CXL capable PCIE root ports that undergo CXL.mem error isolation
+	  due to either a CXL.mem transaction timeout or uncorrectable device error.
+
 #
 # PCI Express ECRC
 #
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index 8de4ed5f98f1..433ef08efc6f 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_PCIE_PME)		+= pme.o
 obj-$(CONFIG_PCIE_DPC)		+= dpc.o
 obj-$(CONFIG_PCIE_PTM)		+= ptm.o
 obj-$(CONFIG_PCIE_EDR)		+= edr.o
+obj-$(CONFIG_PCIE_CXL_TIMEOUT)	+= cxl_timeout.o
diff --git a/drivers/pci/pcie/cxl_timeout.c b/drivers/pci/pcie/cxl_timeout.c
new file mode 100644
index 000000000000..84f2df0e0397
--- /dev/null
+++ b/drivers/pci/pcie/cxl_timeout.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Implements CXL Timeout & Isolation (CXL 3.0 12.3.2) interrupt support as a
+ * PCIE port service driver. The driver is set up such that near all of the
+ * work for setting up and handling interrupts are in this file, while the
+ * CXL core enables the interrupts during port enumeration.
+ *
+ * Copyright (C) 2024, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Author: Ben Cheatham <Benjamin.Cheatham@amd.com>
+ */
+
+#define pr_fmt(fmt) "cxl_timeout: " fmt
+#define dev_fmt pr_fmt
+
+#include <linux/pci.h>
+#include <linux/acpi.h>
+
+#include "../../cxl/cxlpci.h"
+#include "portdrv.h"
+
+struct cxl_timeout {
+	struct pcie_device *dev;
+	void __iomem *regs;
+	u32 cap;
+};
+
+struct pcie_cxlt_data {
+	struct cxl_timeout *cxlt;
+	struct cxl_dport *dport;
+};
+
+static int cxl_map_timeout_regs(struct pci_dev *port,
+				struct cxl_register_map *map,
+				struct cxl_component_regs *regs)
+{
+	int rc = 0;
+
+	rc = cxl_find_regblock(port, CXL_REGLOC_RBI_COMPONENT, map);
+	if (rc)
+		return rc;
+
+	rc = cxl_setup_regs(map);
+	if (rc)
+		return rc;
+
+	rc = cxl_map_component_regs(map, regs,
+				    BIT(CXL_CM_CAP_CAP_ID_TIMEOUT));
+	return rc;
+}
+
+static void cxl_unmap_timeout_regs(struct pci_dev *port,
+				   struct cxl_register_map *map,
+				   struct cxl_component_regs *regs)
+{
+	struct cxl_reg_map *timeout_map = &map->component_map.timeout;
+
+	devm_iounmap(map->host, regs->timeout);
+	devm_release_mem_region(map->host, map->resource + timeout_map->offset,
+				timeout_map->size);
+}
+
+static struct cxl_timeout *cxl_create_cxlt(struct pcie_device *dev)
+{
+	struct cxl_component_regs *regs;
+	struct cxl_register_map *map;
+	struct cxl_timeout *cxlt;
+	int rc;
+
+	regs = devm_kmalloc(&dev->device, sizeof(*regs), GFP_KERNEL);
+	if (!regs)
+		return ERR_PTR(-ENOMEM);
+
+	map = devm_kmalloc(&dev->device, sizeof(*map), GFP_KERNEL);
+	if (!map) {
+		devm_kfree(&dev->device, regs);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	rc = cxl_map_timeout_regs(dev->port, map, regs);
+	if (rc)
+		goto err;
+
+	cxlt = devm_kmalloc(&dev->device, sizeof(*cxlt), GFP_KERNEL);
+	if (!cxlt)
+		goto err;
+
+	cxlt->regs = regs->timeout;
+	cxlt->dev = dev;
+	cxlt->cap = readl(cxlt->regs + CXL_TIMEOUT_CAPABILITY_OFFSET);
+
+	return cxlt;
+
+err:
+	cxl_unmap_timeout_regs(dev->port, map, regs);
+	return ERR_PTR(rc);
+}
+
+int cxl_find_timeout_cap(struct pci_dev *dev, u32 *cap)
+{
+	struct cxl_component_regs regs;
+	struct cxl_register_map map;
+	int rc = 0;
+
+	rc = cxl_map_timeout_regs(dev, &map, &regs);
+	if (rc)
+		return rc;
+
+	*cap = readl(regs.timeout + CXL_TIMEOUT_CAPABILITY_OFFSET);
+	cxl_unmap_timeout_regs(dev, &map, &regs);
+
+	return rc;
+}
+
+static struct pcie_cxlt_data *cxlt_create_pdata(struct pcie_device *dev)
+{
+	struct pcie_cxlt_data *data;
+
+	data = devm_kzalloc(&dev->device, sizeof(*data), GFP_KERNEL);
+	if (IS_ERR_OR_NULL(data))
+		return ERR_PTR(-ENOMEM);
+
+	data->cxlt = cxl_create_cxlt(dev);
+	if (IS_ERR_OR_NULL(data->cxlt))
+		return ERR_PTR(PTR_ERR(data->cxlt));
+
+	data->dport = NULL;
+
+	return data;
+}
+
+static void cxl_disable_timeout(void *data)
+{
+	struct cxl_timeout *cxlt = data;
+	u32 cntrl = readl(cxlt->regs + CXL_TIMEOUT_CONTROL_OFFSET);
+
+	cntrl &= ~CXL_TIMEOUT_CONTROL_MEM_TIMEOUT_ENABLE;
+	writel(cntrl, cxlt->regs + CXL_TIMEOUT_CONTROL_OFFSET);
+}
+
+static int cxl_enable_timeout(struct pcie_device *dev, struct cxl_timeout *cxlt)
+{
+	u32 cntrl;
+
+	if (!cxlt || !FIELD_GET(CXL_TIMEOUT_CAP_MEM_TIMEOUT_SUPP, cxlt->cap))
+		return -ENXIO;
+
+	cntrl = readl(cxlt->regs + CXL_TIMEOUT_CONTROL_OFFSET);
+	cntrl |= CXL_TIMEOUT_CONTROL_MEM_TIMEOUT_ENABLE;
+	writel(cntrl, cxlt->regs + CXL_TIMEOUT_CONTROL_OFFSET);
+
+	return devm_add_action_or_reset(&dev->device, cxl_disable_timeout,
+					cxlt);
+}
+
+static int cxl_timeout_probe(struct pcie_device *dev)
+{
+	struct pci_dev *port = dev->port;
+	struct pcie_cxlt_data *pdata;
+	struct cxl_timeout *cxlt;
+	int rc = 0;
+
+	/* Limit to CXL root ports */
+	if (!pci_find_dvsec_capability(port, PCI_DVSEC_VENDOR_ID_CXL,
+				       CXL_DVSEC_PORT_EXTENSIONS))
+		return -ENODEV;
+
+	pdata = cxlt_create_pdata(dev);
+	if (IS_ERR_OR_NULL(pdata))
+		return PTR_ERR(pdata);
+
+	set_service_data(dev, pdata);
+	cxlt = pdata->cxlt;
+
+	rc = cxl_enable_timeout(dev, cxlt);
+	if (rc)
+		pci_dbg(dev->port, "Failed to enable CXL.mem timeout: %d\n",
+			rc);
+
+	return rc;
+}
+
+static struct pcie_port_service_driver cxltdriver = {
+	.name		= "cxl_timeout",
+	.port_type	= PCI_EXP_TYPE_ROOT_PORT,
+	.service	= PCIE_PORT_SERVICE_CXLT,
+
+	.probe		= cxl_timeout_probe,
+};
+
+int __init pcie_cxlt_init(void)
+{
+	return pcie_port_service_register(&cxltdriver);
+}
+
+MODULE_IMPORT_NS(CXL);
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 14a4b89a3b83..7aa0a6f2da4e 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -829,6 +829,7 @@ static void __init pcie_init_services(void)
 	pcie_pme_init();
 	pcie_dpc_init();
 	pcie_hp_init();
+	pcie_cxlt_init();
 }
 
 static int __init pcie_portdrv_init(void)
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 1f3803bde7ee..5395a0e36956 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -22,8 +22,10 @@
 #define PCIE_PORT_SERVICE_DPC		(1 << PCIE_PORT_SERVICE_DPC_SHIFT)
 #define PCIE_PORT_SERVICE_BWNOTIF_SHIFT	4	/* Bandwidth notification */
 #define PCIE_PORT_SERVICE_BWNOTIF	(1 << PCIE_PORT_SERVICE_BWNOTIF_SHIFT)
+#define PCIE_PORT_SERVICE_CXLT_SHIFT	5	/* CXL Timeout & Isolation */
+#define PCIE_PORT_SERVICE_CXLT		(1 << PCIE_PORT_SERVICE_CXLT_SHIFT)
 
-#define PCIE_PORT_DEVICE_MAXSERVICES   5
+#define PCIE_PORT_DEVICE_MAXSERVICES   6
 
 extern bool pcie_ports_dpc_native;
 
@@ -51,6 +53,12 @@ int pcie_dpc_init(void);
 static inline int pcie_dpc_init(void) { return 0; }
 #endif
 
+#ifdef CONFIG_PCIE_CXL_TIMEOUT
+int pcie_cxlt_init(void);
+#else
+static inline int pcie_cxlt_init(void) { return 0; }
+#endif
+
 /* Port Type */
 #define PCIE_ANY_PORT			(~0)
 
-- 
2.34.1


