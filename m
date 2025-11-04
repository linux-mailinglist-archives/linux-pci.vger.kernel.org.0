Return-Path: <linux-pci+bounces-40172-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED51C2E8C3
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 01:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E7FF4203E4
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 00:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95CF72627;
	Tue,  4 Nov 2025 00:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0j7dghGo"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011064.outbound.protection.outlook.com [40.93.194.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BA142A8B;
	Tue,  4 Nov 2025 00:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762215193; cv=fail; b=ET3pouu9xjSQduFGTp/8lzJLHWcH0O/68RqA8yuEsvkdOV1eTdSG07kiWRl8V869qM+Fnm60oiwC6H8s22IClhZkMv/rtnTM6MuuweauycrO3JUIHYDA3xWrooFnA5lckxhD9B5fA5zuSp81j0J9Z0C69CgYNUcZsddA2r+mGC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762215193; c=relaxed/simple;
	bh=7L37MB6UXXE6Ok3SQeOfecDSKHme8+9P+jSJOZFBHxU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U81uBgbo6QOws7iK+tlxVat87lzJ1WKxbsM1io31tFBxPXTOPdT+P0IeIBV50RuJCQz1QkPVnDdaA9XF616fEd2gApHDu9nutnvYUBIVkIlghUwY0Yv3o5Murtc/RPocQH0oojF2KM8OzU1yiatboO2m7loj90pcfF8Z5Hks8u8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0j7dghGo; arc=fail smtp.client-ip=40.93.194.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hS9r1jjl+z3TvwzB3L8yo84dTk4ukwGexD5MzohPalD1Cs5loBEyLRlfZihkzsolG2IK0I2iRz1Jt4jaoDqQEEGyFl6GYg+uQDdaDu76I/wMQqR1iWOgqJd7Z+QvM/at0icihKn1NlrKBRAF58ovfXGTQK3pgLwsb2INjd9ajHFKhkdbtJDriJ9v5FUmH0I+xMpSbCrORstwLLukJ3T7qLsTyA9AemJLkLwOwDn8CDzJsiT/x3KSJBxbnsqXH9HkPL2RtaFRMZNtBpfMPoV3HKQ40B/8jaIYfA/T0daGXptxA+SfFSavE49xXf/74F7OwukkA8Vtr9z3bWgr6ehe7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yqh5gyjmImnolSyq9pSK95ah/vq5PQWKaQxWVKeXL+U=;
 b=obE5nlhJ/qEzEtZreJOkX0tj2YbxtwoaO1dJsWfnaotWaPIZ1HCb5yNiRQpO49PcOki7Do2B+0kA6Qw+wmyrCaePbFX9kkPfsKgN7r7MnKC/PMgaYB8+S09X1eXl3BwE7/kNIl8j4y4sF2rwipd9E4fz0W9soTJVNIzhERmixWi+zLS9ZWdTrbaqWK4apfXFYNXQxEgc3P613nafJJy4oPY20hfswOFQAB4Isy9HWoK473Aqo/3dJ6ZQxUL6ZAbyJLqTOztUArzbbunQw2XQX6twubc6036+Rjy1zPEKWWTfSJD0eKysEs9YiLc3FsZOH5dNnrIQswqI+nDHCkGvvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yqh5gyjmImnolSyq9pSK95ah/vq5PQWKaQxWVKeXL+U=;
 b=0j7dghGoBDJQzp+lEBfTV1DEIYYODm7WoO+V/rndV8k3rQTLwedyQIpeFI7m3+c0JNfZDBDBnQsMqyIDNZn0n+8OkJW/wCteshtlfjV16YO9RI5VUeTayvoWlQSX8jl1nHcSXVhbYq3C9vgLDx7W2mKZlq0eyVSKkzswAb5kK88=
Received: from CH0PR03CA0200.namprd03.prod.outlook.com (2603:10b6:610:e4::25)
 by SN7PR12MB7178.namprd12.prod.outlook.com (2603:10b6:806:2a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Tue, 4 Nov
 2025 00:13:07 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::d4) by CH0PR03CA0200.outlook.office365.com
 (2603:10b6:610:e4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 00:12:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 00:13:07 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 16:13:04 -0800
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v13 16/25] CXL/AER: Introduce pcie/aer_cxl_vh.c in AER driver for forwarding CXL errors
Date: Mon, 3 Nov 2025 18:09:52 -0600
Message-ID: <20251104001001.3833651-17-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104001001.3833651-1-terry.bowman@amd.com>
References: <20251104001001.3833651-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|SN7PR12MB7178:EE_
X-MS-Office365-Filtering-Correlation-Id: f967bbcc-90ae-4aa5-6de5-08de1b36ee6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oVnB2eUttaEzXiC5S0lcbZXrSwexL4Dk6jmXegeiPMMEuAI/OlLfEFc8m6LQ?=
 =?us-ascii?Q?aTkIljJ+9HY8L4gyIdaxXxxmKYxLYnPDDpkgKxH5450ETSbH5S1vLilq8WGX?=
 =?us-ascii?Q?vzHgiicD+hI9kw4kQ8djHFs5O/U4nKYjHX8tYrmpwPBopJWV4euX+jtu3Hif?=
 =?us-ascii?Q?mOdcViqSGQucn4LIcSmA5r5ks1Loo8jFeTLWAJyPyjEDgjp0Fswl3s/+Wp1T?=
 =?us-ascii?Q?FIJ6utRcM1cbkwrpDcTSEodJb0Ao2uRNAfCAjOzl7B5k13GVuGFEJkQM2wdP?=
 =?us-ascii?Q?khFy5OJ+XqRab1igvvsoD5l/RGbECU6RBd/1eemx6sGddDl0TXXaxWpP/aEZ?=
 =?us-ascii?Q?zw6pGSZE2NQICz2vYxwA6lFuGc2q5pvqbY3pxZF53Nh6i+G8D/78mecA27cH?=
 =?us-ascii?Q?PcQBeZy/TlNMsCYMLtxWNIA91qP4nI/nRbp6PDWjb/DOJEu/WOowoa0Z176+?=
 =?us-ascii?Q?Rtv3Y2tYmHIqaZUCI9fZodLUoHPbCJLGfXxpfDsIaCA6puEIEf+0KTiglR5R?=
 =?us-ascii?Q?FesI2PSc8cHjRh8u2BhKFv2CjZBcwCU4NqF1yDlAeNNSN6Pb82E6EbVSkpMu?=
 =?us-ascii?Q?3spRIcpVgIKwn5h6r6+RrYPOMWjrGb95dfmeFcBuJPQGjYX7hR8imTKCvZRh?=
 =?us-ascii?Q?BcivAkSbOCx99zYCzolWjBPZi759QERj7Xfeq34HiuYIL+wNnhrCL1OrR+CS?=
 =?us-ascii?Q?lrnxy5pvfvZxrcQPBtLtYvzMpH/CLMFxfxQR6yAa2NZmR6Tdk2tvopOPa3JJ?=
 =?us-ascii?Q?L9l9j0qNi266LvvLZRLAnULhKveQ5uL+F/GFbvbjJgpaM1Y7pESbo8i4+bOK?=
 =?us-ascii?Q?qGZUyXiaB0KLajIHgRhLV8r1f3efme9afuEbYGpfvHKUXjAh6cdcJzJ7lfnB?=
 =?us-ascii?Q?USbCHqFKU+ZkuvBinKK6FftmOawRHIVazg/6TPlkA7V6schmnBkfTNjBoHu4?=
 =?us-ascii?Q?CIafpEboAxMtViw8NoH2krB9Fw0CxUz79DnFyxzweyNEPMzN2zEBfJHMxmZ5?=
 =?us-ascii?Q?0MuytSpsj/8Fu9a1b3NDx7ff/mi0SWRiNICaCXEu9RFfp2CjgTqq8u14nuch?=
 =?us-ascii?Q?/LTBzHf5WAxJgleS8AhM8cMHhh87kwROiQs5AgRVaaaf+eF7CgvktYpEAk+t?=
 =?us-ascii?Q?8qcilkvwoCmNQgA+wMsvKe61bedr+nljcj+UyT7znxOhzNGjA5fpRDLf7pbb?=
 =?us-ascii?Q?C4tli9RCj4vzdfv9C4UwkRyorzNPnlc5BQK4tXJTLc5U9Cqyn4rF4U23rHCK?=
 =?us-ascii?Q?Mr7iOdVUNQN1ZXDbTXdzFyS+doqsSeLCAabnjR7hg0N5Vja6h3a+RpjOfitg?=
 =?us-ascii?Q?eXuE/BpRQ4qZw9HT0VeSTaiM30HWcoJxkU7EJIhXcZHODVW6eaIoE/aNFhfw?=
 =?us-ascii?Q?OJYYiNxNl6BLV2GBSamGHLn2v0eHfHCirpwKitwuDmic0d4yv5vERFA5qeNd?=
 =?us-ascii?Q?aBSrjNF5eywl6O7L/PISSjsp9aUn45IZOBDKmWne8C6LxQpPI0jUTyBjPOt2?=
 =?us-ascii?Q?3CW17od+XT/knqOdqSYFmYjhrSmXqr/IScdOTSP+cHlGgW+jMMyrqM8v8kkZ?=
 =?us-ascii?Q?MyIk67HxwCLbGEoHpt0rgFOJi2VRmF2V7I2krFMZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 00:13:07.4742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f967bbcc-90ae-4aa5-6de5-08de1b36ee6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7178

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
This will contain a reference to the erring PCI device and the error
severity. This will be used when the work is dequeued by the cxl_core driver.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

---

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
 drivers/pci/pci.h             |  4 ++
 drivers/pci/pcie/Makefile     |  1 +
 drivers/pci/pcie/aer.c        | 25 ++-------
 drivers/pci/pcie/aer_cxl_vh.c | 95 +++++++++++++++++++++++++++++++++++
 include/linux/aer.h           | 17 +++++++
 5 files changed, 121 insertions(+), 21 deletions(-)
 create mode 100644 drivers/pci/pcie/aer_cxl_vh.c

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 446251892bb7..a398e489318c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1330,8 +1330,12 @@ static inline void cxl_rch_enable_rcec(struct pci_dev *rcec) { }
 
 #ifdef CONFIG_CXL_RAS
 bool is_internal_error(struct aer_err_info *info);
+bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info);
+void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info);
 #else
 static inline bool is_internal_error(struct aer_err_info *info) { return false; }
+static inline bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info) { return false; }
+static inline void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info) { }
 #endif
 
 #endif /* DRIVERS_PCI_H */
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index 970e7cbc5b34..72992b3ea417 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o bwctrl.o
 obj-y				+= aspm.o
 obj-$(CONFIG_PCIEAER)		+= aer.o err.o tlp.o
 obj-$(CONFIG_CXL_RCH_RAS)	+= aer_cxl_rch.o
+obj-$(CONFIG_CXL_RAS)		+= aer_cxl_vh.o
 obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
 obj-$(CONFIG_PCIE_PME)		+= pme.o
 obj-$(CONFIG_PCIE_DPC)		+= dpc.o
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 39e99f438563..e806fa05280b 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1123,8 +1123,6 @@ static bool find_source_device(struct pci_dev *parent,
 	return true;
 }
 
-#ifdef CONFIG_PCIEAER_CXL
-
 /**
  * pci_aer_unmask_internal_errors - unmask internal errors
  * @dev: pointer to the pci_dev data structure
@@ -1150,24 +1148,6 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_aer_unmask_internal_errors);
 
-bool cxl_error_is_native(struct pci_dev *dev)
-{
-	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
-
-	return (pcie_ports_native || host->native_aer);
-}
-EXPORT_SYMBOL_NS_GPL(cxl_error_is_native, "CXL");
-
-bool is_internal_error(struct aer_err_info *info)
-{
-	if (info->severity == AER_CORRECTABLE)
-		return info->status & PCI_ERR_COR_INTERNAL;
-
-	return info->status & PCI_ERR_UNC_INTN;
-}
-EXPORT_SYMBOL_NS_GPL(is_internal_error, "CXL");
-#endif /* CONFIG_CXL_RAS */
-
 /**
  * pci_aer_handle_error - handle logging error into an event log
  * @dev: pointer to pci_dev data structure of error source device
@@ -1204,7 +1184,10 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
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
index 000000000000..5dbc81341dc4
--- /dev/null
+++ b/drivers/pci/pcie/aer_cxl_vh.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2025 AMD Corporation. All rights reserved. */
+
+#include <linux/pci.h>
+#include <linux/aer.h>
+#include <linux/pci.h>
+#include <linux/bitfield.h>
+#include <linux/kfifo.h>
+#include "../pci.h"
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
+bool cxl_error_is_native(struct pci_dev *dev)
+{
+	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
+
+	return (pcie_ports_native || host->native_aer);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_error_is_native, "CXL");
+
+bool is_internal_error(struct aer_err_info *info)
+{
+	if (info->severity == AER_CORRECTABLE)
+		return info->status & PCI_ERR_COR_INTERNAL;
+
+	return info->status & PCI_ERR_UNC_INTN;
+}
+EXPORT_SYMBOL_NS_GPL(is_internal_error, "CXL");
+
+bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
+{
+	if (!info || !info->is_cxl)
+		return false;
+
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
+		return false;
+
+	return is_internal_error(info);
+}
+EXPORT_SYMBOL_NS_GPL(is_cxl_error, "CXL");
+
+void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info)
+{
+	struct cxl_proto_err_work_data wd = (struct cxl_proto_err_work_data) {
+		.severity = info->severity,
+		.pdev = pdev
+	};
+
+	guard(rwsem_write)(&cxl_proto_err_kfifo.rw_sema);
+
+	if (!cxl_proto_err_kfifo.work) {
+		dev_warn_once(&pdev->dev, "CXL driver is unregistered. Unable to forward error.");
+		return;
+	}
+
+	if (!kfifo_put(&cxl_proto_err_kfifo.fifo, wd)) {
+		dev_err_ratelimited(&pdev->dev, "AER-CXL kfifo overflow\n");
+		return;
+	}
+
+	schedule_work(cxl_proto_err_kfifo.work);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_forward_error, "CXL");
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
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 2ef820563996..6b2c87d1b5b6 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -10,6 +10,7 @@
 
 #include <linux/errno.h>
 #include <linux/types.h>
+#include <linux/workqueue_types.h>
 
 #define AER_NONFATAL			0
 #define AER_FATAL			1
@@ -53,6 +54,16 @@ struct aer_capability_regs {
 	u16 uncor_err_source;
 };
 
+/**
+ * struct cxl_proto_err_work_data - Error information used in CXL error handling
+ * @severity: AER severity
+ * @pdev: PCI device detecting the error
+ */
+struct cxl_proto_err_work_data {
+	int severity;
+	struct pci_dev *pdev;
+};
+
 #if defined(CONFIG_PCIEAER)
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
 int pcie_aer_is_native(struct pci_dev *dev);
@@ -68,8 +79,14 @@ static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
 
 #ifdef CONFIG_CXL_RAS
 bool cxl_error_is_native(struct pci_dev *dev);
+int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd);
+void cxl_register_proto_err_work(struct work_struct *work);
+void cxl_unregister_proto_err_work(void);
 #else
 static inline bool cxl_error_is_native(struct pci_dev *dev) { return false; }
+static inline int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd) { return 0; }
+static inline void cxl_register_proto_err_work(struct work_struct *work) { }
+static inline void cxl_unregister_proto_err_work(void) { }
 #endif
 
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
-- 
2.34.1


