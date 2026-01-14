Return-Path: <linux-pci+bounces-44821-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F818D20CDD
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 121B630131C4
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EBF335065;
	Wed, 14 Jan 2026 18:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4WmmS74m"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012043.outbound.protection.outlook.com [40.107.200.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317E833555B;
	Wed, 14 Jan 2026 18:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415238; cv=fail; b=ejY6ZD/gnr90obljHvRYyxQotfLDBt+Xg0E3RtiN3lLo5Bm+j4J7WsdL2EfDq3V2S7NBH8TVzhYMWNLNLSpVfRzbVLAYR4Rpe8KE+qLJj8trr1Ci0MJFpfViweoq5Q5LHgmD/2uToTXJppniSVrBNeZLzAQH6hlnvMC150Fd2fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415238; c=relaxed/simple;
	bh=ZKEdjVNMrQd2Wyp0EC/pwsOAgyYtwAZB7DanL5Hv1jw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KphjSM+BzVpdvPHeBqtdBVJiPqE45I3sHE24olAO7IyNGvHGA0FVyoWh8+tOzVJsnvdw7qnet+XTEBU30lMr8WV4BJcLUmLw4hKBJmTYqlN41gltt+g1dBVAqjDH1oiNR0l7ljd7oIjRkchuJpBEpMvjG2SIksAfhBZJCGB3yMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4WmmS74m; arc=fail smtp.client-ip=40.107.200.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lzwYFgFoj6oXtg5GQ+N0+wsXp1G9xEWZdAGA3kjmHdwMR6FRJ98whjFMxapUjV5oyDDyeeifAh7asVeehJ/1fcomVRmDWVNtFKhpIT+00oNWkD5cPi/di2zy/CrPJwo+5OmMQdcpNu57WVMfBsH13irNMN1yUPQnJPfTMySVLhTgFibN+bfdk4gI8vjwYlMkF0btPCMTQjOAedu6tL5mJ5D8f2Y6a0Ya2Xz7fA2D0B0TYUikVM1b9FMHcDMukt6LWVLZzdic0SlhgM1+KWEPnJfgRSYO7pTONcnVcWzCl5fGFT6DGsc10rYZZ21zONAYET206++8syIMkmERGM3pIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cWy4uVfiJ/umpwsDLhHMoXDODKBk3oOKRF9ICruNSY=;
 b=paPNCQ6wvGLO4WvG9zy1/9MSQ0XddQsJwGosYIU/0eoeq8m/oc9w7D6rWjLPQ+7PZQqqkWhLBGLteiEhIcs9Z9B9a+v+gs59CVuH6QouqVBcQVTkLFzXg2wfy2pbkCtqrnlzk7GlMbpJVNCFYOF4KZ+BHo+FZvtkxELg0I5avL956EL3hwaGlRegYDqP7uxYzNrNQewYnjp1crqwcw/LIxrNZamETBcozkphxgmkm5CR53RKCHAxu8FO/3CXwQUtk950x4r2dXaj6b2cl/G8XghmYja2tPX8N6jNiIlmh1ctXERK190p6PEoHBMTFf9uxwexqa9w99FJl9cLtrSqUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cWy4uVfiJ/umpwsDLhHMoXDODKBk3oOKRF9ICruNSY=;
 b=4WmmS74mFF4AKYW6Ac+GlMN+8huuehrN3gQddxdFmPFEJIMvYHvIBJ1P7U22w6Jakxkwt8w1waI8iszsd44PILCUH8nWy5UtcPowS7DLwqedrEVf42y/ZGnu+wToyM0MgLJ+ZrKeGXmY+TGGVvDLm90Tbn5lIMFYxOfCpZFPOms=
Received: from SJ0P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::6)
 by PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 14 Jan
 2026 18:27:03 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::5e) by SJ0P220CA0030.outlook.office365.com
 (2603:10b6:a03:41b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Wed,
 14 Jan 2026 18:26:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 18:27:03 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 12:27:02 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v14 28/34] PCI/AER: Move AER driver's CXL VH handling to pcie/aer_cxl_vh.c
Date: Wed, 14 Jan 2026 12:20:49 -0600
Message-ID: <20260114182055.46029-29-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114182055.46029-1-terry.bowman@amd.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|PH7PR12MB9174:EE_
X-MS-Office365-Filtering-Correlation-Id: fe4887e6-c7a8-46c6-4eb3-08de539a8395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5JplX9Pz/dSezJ1TZF6hAnjGoMquujAJnaTC1Q+36EjvIqD2lidiRpbHn+D2?=
 =?us-ascii?Q?6OU+nvborULO0I1FnYkpaBxm6PqBC91naORJfs0UzUTuNPR/NVMNAgc/tu+L?=
 =?us-ascii?Q?m4AyvJw8wd3fnIOCHTzAtN6/wtLEyra+/Ldp5yFfiX2owQTkbAlHT83HbH4L?=
 =?us-ascii?Q?pluFQH4J4SdfbaJ2vIT56n6xikwrGHwbz3rfws4H8YFJ1VIx2QemwwelaqPA?=
 =?us-ascii?Q?WhCcmP/AkUQS4rCSSd8TQjxWqcFTGB591QwpWNlB7ZeT4/sdEMcd3wPoGtP6?=
 =?us-ascii?Q?mloBsR8HF6J6UDpJuGMrZnHxgxTnhElsxLx3V8cC74LN7N9cPLVbcrHVxPfO?=
 =?us-ascii?Q?rfRMm+H3e9qj2kAyuqGgObsIj8WcrDMTnbIR9Xi7FKwcfocTHGG2wlzLiDU5?=
 =?us-ascii?Q?SZhyLO0EBRB6i2mXskVePpF/9MaNcDylhwQcpc0OiA59JLKKAJWxFkHdjFsY?=
 =?us-ascii?Q?jBuV8ldOAh5A1+/Nl7oKyTVWPF2mLijs/dhDufnQepmlJkLLUwSKZbLLxESp?=
 =?us-ascii?Q?pzEzQU+ZGAA0fBgzGrcxjTki4ZIjypzzZSw9mLTye6XB6cZz2rkiIA/K6aU5?=
 =?us-ascii?Q?HDhW+aAo+njUpGYlhN6gCcc4SOG1OL7DSvL0yNEHZ+V6JXcGTsC4AsW14Z4m?=
 =?us-ascii?Q?IMYzMiOOTSTzWxw2DGv3/mzsPK8RDCoAGMpfPRnBQeQj08nYD+B/XrYmSoc5?=
 =?us-ascii?Q?AZaHnZXw7/FF42yTGFct573ETh1jaarQmLbjcZ7OOuNvH2KIgkq4P9Sak0kG?=
 =?us-ascii?Q?vaVU/wxluYi8dDsWk0YxzL89C60l5ZNeFfYI2XDp5nNpl2PdqTPj9PmQ3BBE?=
 =?us-ascii?Q?+Y3QbnJ0pl6J0V+cIEaFcr2MNyhOogZ9YDcw5pUXAlhr/Tx2glCPrSwr9FIl?=
 =?us-ascii?Q?DX1+OEfd9PN+4zTHnikPpc+S5l4puKjCD4AfitJqGvJ9yne0t7TDTIVjrYDe?=
 =?us-ascii?Q?BXe+ZGuWfqBMmKCqE6XaKslV14gRdr6oS4fLW31vjS5Yf2gF/bSKn87WtCYF?=
 =?us-ascii?Q?Cs6bEXW76+kVTHtr6F7/aXDXkP6M+xnzB3rBKlp9qshwsrrxv4bEJVFaHtpt?=
 =?us-ascii?Q?E965xbI95kcn97UCUMRHZYzUm1hE7cTh4hhxTYcgKI+t/PEsJqjdG1lT/tCl?=
 =?us-ascii?Q?opcoiKe+8woEK0sFIzzfkX0Nnr80dekvalpsjiBFg/T2ZafmLUriS5Dhe+Pk?=
 =?us-ascii?Q?htk/k77+LwIfOIDKmnFV3v4kqv3rAhYgUEZzD01lHcdHBWfZfQ5mPoFgholq?=
 =?us-ascii?Q?+2eEfAKSDglxoH/dVP9QCnuFQEtjkBh7B63Sy5pQO4nOSZ6NQnQ3TDCqwG6M?=
 =?us-ascii?Q?HpZgtJgYVzuu1fIeYYoRqqMHzsk12zeaMpuuzydHqqN5QRZX+M3qdc1PfZl5?=
 =?us-ascii?Q?9NRywtN1fowjWMJSPeNyzQ1Hx3usyilacv1o2BjDmerH63MQkWTQRoMMME6M?=
 =?us-ascii?Q?1yqQ2kPCrKgyCReJOTtaSvFVdq4l6ButsLdKXcdaz0lXloYKQ0QrH9uOJA4l?=
 =?us-ascii?Q?C9da22GXwRdB9DE7pqvD79MdftLYt+KIUlc7f9QuTsiy4/PdmhcGubc1L2xY?=
 =?us-ascii?Q?3WB9Wc7V78t1QNvIXSi3LaxgvsaKriTinOqiB2vnxKzkbVkCzQ3iaWaIosTr?=
 =?us-ascii?Q?pXKwGoJeV9sHych8KQeFpiXRaGsWF8dVITygG2EXvqeowO37ZLhSaMJmuv/r?=
 =?us-ascii?Q?I+qCFI349nEshQpTe5tZ2fIR0wU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:27:03.0088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4887e6-c7a8-46c6-4eb3-08de539a8395
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9174

CXL virtual hierarchy (VH) RAS handling for CXL Port devices will be added
soon. This requires a notification mechanism for the AER driver to share
the AER interrupt with the CXL driver. The notification will be used as an
indication for the CXL drivers to handle and log the CXL RAS errors.

Note, 'CXL protocol error' terminology will refer to CXL VH and not
CXL RCH errors unless specifically noted going forward.

Introduce a new file in the AER driver to handle the CXL protocol errors
named pci/pcie/aer_cxl_vh.c.

Add a kfifo work queue to be used by the AER and CXL drivers. The AER
driver will be the sole kfifo producer adding work and the cxl_core will be
the sole kfifo consumer removing work. Add the boilerplate kfifo support.
Encapsulate the kfifo, RW semaphore, and work pointer in a single structure.

Add CXL work queue handler registration functions in the AER driver. Export
the functions allowing CXL driver to access. Implement registration
functions for the CXL driver to assign or clear the work handler function.
Synchronize accesses using the RW semaphore.

Introduce 'struct cxl_proto_err_work_data' to serve as the kfifo work data.
This will contain a reference to the PCI error source device and the error
severity. This will be used when the work is dequeued by the cxl_core driver.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

---

Changes in v13 -> v14:
- Replaced workqueue_types.h include with 'struct work_struct'
  predeclaration (Bjorn)
- Update error message (Bjorn)
- Reordered 'struct cxl_proto_err_work_data' (Bjorn)
- Remove export of cxl_error_is_native() here (Bjorn)

Changes in v12->v13:
- Added Dave Jiang's review-by
- Update error message (Ben)

Changes in v11->v12:
- None

Changes in v10->v11:
- cxl_error_detected() - Change handlers' scoped_guard() to guard() (Jonathan)
- cxl_error_detected() - Remove extra line (Shiju)
- Changes moved to core/ras.c (Terry)
- cxl_error_detected(), remove 'ue' and return with function call. (Jonathan)
- Remove extra space in documentation for PCI_ERS_RESULT_PANIC definition
- Move #include "pci.h from cxl.h to core.h (Terry)
- Remove unnecessary includes of cxl.h and core.h in mem.c (Terry)
---
 drivers/pci/pcie/Makefile     |  1 +
 drivers/pci/pcie/aer.c        | 15 ++-----
 drivers/pci/pcie/aer_cxl_vh.c | 78 +++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.h    |  4 ++
 include/linux/aer.h           | 22 ++++++++++
 5 files changed, 109 insertions(+), 11 deletions(-)
 create mode 100644 drivers/pci/pcie/aer_cxl_vh.c

diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index b0b43a18c304..62d3d3c69a5d 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o bwctrl.o
 obj-y				+= aspm.o
 obj-$(CONFIG_PCIEAER)		+= aer.o err.o tlp.o
 obj-$(CONFIG_CXL_RAS)		+= aer_cxl_rch.o
+obj-$(CONFIG_CXL_RAS)		+= aer_cxl_vh.o
 obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
 obj-$(CONFIG_PCIE_PME)		+= pme.o
 obj-$(CONFIG_PCIE_DPC)		+= dpc.o
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index d30a217fae46..c2030d32a19c 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1150,16 +1150,6 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_aer_unmask_internal_errors);
 
-#ifdef CONFIG_CXL_RAS
-bool is_aer_internal_error(struct aer_err_info *info)
-{
-	if (info->severity == AER_CORRECTABLE)
-		return info->status & PCI_ERR_COR_INTERNAL;
-
-	return info->status & PCI_ERR_UNC_INTN;
-}
-#endif
-
 /**
  * pci_aer_handle_error - handle logging error into an event log
  * @dev: pointer to pci_dev data structure of error source device
@@ -1196,7 +1186,10 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 {
 	cxl_rch_handle_error(dev, info);
-	pci_aer_handle_error(dev, info);
+	if (is_cxl_error(dev, info))
+		cxl_forward_error(dev, info);
+	else
+		pci_aer_handle_error(dev, info);
 	pci_dev_put(dev);
 }
 
diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
new file mode 100644
index 000000000000..2189d3c6cef1
--- /dev/null
+++ b/drivers/pci/pcie/aer_cxl_vh.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2025 AMD Corporation. All rights reserved. */
+
+#include <linux/types.h>
+#include <linux/aer.h>
+#include <linux/bitfield.h>
+#include <linux/kfifo.h>
+#include "../pci.h"
+#include "portdrv.h"
+
+#define CXL_ERROR_SOURCES_MAX          128
+
+struct cxl_proto_err_kfifo {
+	struct work_struct *work;
+	struct rw_semaphore rw_sema;
+	DECLARE_KFIFO(fifo, struct cxl_proto_err_work_data,
+		      CXL_ERROR_SOURCES_MAX);
+};
+
+static struct cxl_proto_err_kfifo cxl_proto_err_kfifo = {
+	.rw_sema = __RWSEM_INITIALIZER(cxl_proto_err_kfifo.rw_sema)
+};
+
+bool is_aer_internal_error(struct aer_err_info *info)
+{
+	if (info->severity == AER_CORRECTABLE)
+		return info->status & PCI_ERR_COR_INTERNAL;
+
+	return info->status & PCI_ERR_UNC_INTN;
+}
+
+bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
+{
+	if (!info || !info->is_cxl)
+		return false;
+
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
+		return false;
+
+	return is_aer_internal_error(info);
+}
+
+void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info)
+{
+	struct cxl_proto_err_work_data wd = (struct cxl_proto_err_work_data) {
+		.severity = info->severity,
+		.pdev = pdev
+	};
+
+	guard(rwsem_read)(&cxl_proto_err_kfifo.rw_sema);
+	if (!cxl_proto_err_kfifo.work || !kfifo_put(&cxl_proto_err_kfifo.fifo, wd)) {
+		dev_err_ratelimited(&pdev->dev, "AER-CXL kfifo error");
+		return;
+	}
+
+	schedule_work(cxl_proto_err_kfifo.work);
+}
+
+void cxl_register_proto_err_work(struct work_struct *work)
+{
+	guard(rwsem_write)(&cxl_proto_err_kfifo.rw_sema);
+	cxl_proto_err_kfifo.work = work;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_register_proto_err_work, "CXL");
+
+void cxl_unregister_proto_err_work(void)
+{
+	guard(rwsem_write)(&cxl_proto_err_kfifo.rw_sema);
+	cxl_proto_err_kfifo.work = NULL;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_unregister_proto_err_work, "CXL");
+
+int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd)
+{
+	guard(rwsem_read)(&cxl_proto_err_kfifo.rw_sema);
+	return kfifo_get(&cxl_proto_err_kfifo.fifo, wd);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_proto_err_kfifo_get, "CXL");
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index cc58bf2f2c84..66a6b8099c96 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -130,9 +130,13 @@ struct aer_err_info;
 bool is_aer_internal_error(struct aer_err_info *info);
 void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info);
 void cxl_rch_enable_rcec(struct pci_dev *rcec);
+bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info);
+void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info);
 #else
 static inline bool is_aer_internal_error(struct aer_err_info *info) { return false; }
 static inline void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info) { }
 static inline void cxl_rch_enable_rcec(struct pci_dev *rcec) { }
+static inline bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info) { return false; }
+static inline void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info) { }
 #endif /* CONFIG_CXL_RAS */
 #endif /* _PORTDRV_H_ */
diff --git a/include/linux/aer.h b/include/linux/aer.h
index df0f5c382286..f351e41dd979 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -53,6 +53,16 @@ struct aer_capability_regs {
 	u16 uncor_err_source;
 };
 
+/**
+ * struct cxl_proto_err_work_data - Error information used in CXL error handling
+ * @pdev: PCI device detecting the error
+ * @severity: AER severity
+ */
+struct cxl_proto_err_work_data {
+	struct pci_dev *pdev;
+	int severity;
+};
+
 #if defined(CONFIG_PCIEAER)
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
 int pcie_aer_is_native(struct pci_dev *dev);
@@ -66,6 +76,18 @@ static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
 static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
 #endif
 
+struct work_struct;
+
+#ifdef CONFIG_CXL_RAS
+int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd);
+void cxl_register_proto_err_work(struct work_struct *work);
+void cxl_unregister_proto_err_work(void);
+#else
+static inline int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd) { return 0; }
+static inline void cxl_register_proto_err_work(struct work_struct *work) { }
+static inline void cxl_unregister_proto_err_work(void) { }
+#endif
+
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		    struct aer_capability_regs *aer);
 int cper_severity_to_aer(int cper_severity);
-- 
2.34.1


