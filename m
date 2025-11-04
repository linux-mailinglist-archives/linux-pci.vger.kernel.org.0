Return-Path: <linux-pci+bounces-40248-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4A9C32405
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 18:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D333A4DD7
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 17:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5570F338F39;
	Tue,  4 Nov 2025 17:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DRzXpXWP"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011061.outbound.protection.outlook.com [52.101.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60255338F5E;
	Tue,  4 Nov 2025 17:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275981; cv=fail; b=JPVHGDl5pNu40bTy+5/fuXzJdyOXkXvv5DXqtuS1FwPyvmDH4Kq7xnsxPz9WypHwiZnWUfSjoujXSe2/zHaH/5MGddRY/TUMQ45NBOKcBz7g/XbBCshsdAKzwbxhlVkvYJ+Z/z1gnHtjNeWBTNQ11rfwfZynpsc29MnaQPiukFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275981; c=relaxed/simple;
	bh=7L37MB6UXXE6Ok3SQeOfecDSKHme8+9P+jSJOZFBHxU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rZT5UAljZ6Ag9CXvxD1FKV/xxn5j1sgmLqOcZkaUDGwesmqKUyCOavv0CocCqsWykZ4dp+X7JKk6G13Bfx4Vs8Q/8W+SQtqTSqj/9eg/m8HpP9sIdtkuGtpxSdLUQtb/LrMAyltVyBhv/bgcVzlBP/80QAPVbdePF186w/fZDD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DRzXpXWP; arc=fail smtp.client-ip=52.101.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R6OgHCOfPw0atYBkxKcOlEo6205VN0XRFrIMVhHMZkVAV+49gnPKJPYOaOWMho7gO4qi9EIvSfysOrmRFMY3eLtHVpakWZ0pY52O5h/e9IGQaFdxSRW9i7emgzMX69wbKNCfwUVfJ5r4bTZGfBtaBxe9tpxQ7ro8VXEUzYAf3LAXsK/dgn5L6+9L3iuVJWSY54sYwpc1VPKS7G34/QQEz99NDP++etIFs29hukWgh7Q4VlIFYJ58JoCJYVOvWjnD5SOBdbhlAAqCMRJu6ufmFBQBHJtjzp1IJIIaHw5ykk8SD5P/P7dVRxnJa8Um0eI69lpWUsJyB5xoFmRIGw7q6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yqh5gyjmImnolSyq9pSK95ah/vq5PQWKaQxWVKeXL+U=;
 b=cWSKOTR/KemNeA3uON+Kzji2wqMe18zJSFGhJeTkreledAd6HSMdJtthsovDbWgiefxe3Jdm92JSztUjLb2LYeydJtKNIdJdkolql+GLWdrcDn4ZlQ2DihjFB3edn34pLnEu6IrWrm2OUdPngKYfrhd43p+hSuQsb1s+q8gwnpGmhQRbJgN9dQDkDCIrqNBext98N1vQ0aChTk9TZEANtcEXQ6kkaTM/4cEK4vyiNXlp+jl0aSLPT4UKKG1cMvN22r2BrGe1//M2MA4g/tZegSU7w0lq2FLoKalMmBpDx363kR2iQT+94XQlxfW6SgedFzZUJ8u+/BTnQ7BXYJhISg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yqh5gyjmImnolSyq9pSK95ah/vq5PQWKaQxWVKeXL+U=;
 b=DRzXpXWPpTUkHrV7/i1M9Ow5v5Wpha7nVYW3ehrod/z+WycmvIpzk5oFvD38Gzh6LcN6naZJXxbAYaGlWkfuoB6qUyHQhAAMX/FspFjNgx9o+vsoVXvVk5A2gP/DNkdyatzlCsdvhfFB+QR815MgB2cH42myUE4L2evCbhgSmsQ=
Received: from BN9PR03CA0980.namprd03.prod.outlook.com (2603:10b6:408:109::25)
 by PH7PR12MB9066.namprd12.prod.outlook.com (2603:10b6:510:1f6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 17:06:11 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:408:109:cafe::ec) by BN9PR03CA0980.outlook.office365.com
 (2603:10b6:408:109::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 17:06:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 17:06:10 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 09:06:09 -0800
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
Subject: [RESEND v13 16/25] CXL/AER: Introduce pcie/aer_cxl_vh.c in AER driver for forwarding CXL errors
Date: Tue, 4 Nov 2025 11:02:56 -0600
Message-ID: <20251104170305.4163840-17-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104170305.4163840-1-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|PH7PR12MB9066:EE_
X-MS-Office365-Filtering-Correlation-Id: bb99f11d-44d8-4724-8d77-08de1bc4742b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W/GmisRUYyQTndrFQsy5ti7YvLP8OjWVTbxvawk4YaIhb62R2kjr9yrmbql5?=
 =?us-ascii?Q?ntDNXyDFmpot9o+Rj4ocnPefs0AFveMzeRLzYwD4Z4P5MC4eOpmURyz09h9r?=
 =?us-ascii?Q?XjIaYRipmnqz/gr2eeB0wzs9UriS0KDQpFcLGH1QeDcNnpeZ5i2gh3pORGdQ?=
 =?us-ascii?Q?TV8N4u8kZok8RuYcMl1Bgh++/s6dOuRyZDNopHUMbQh6Q9V1Pc1hIhmTrYia?=
 =?us-ascii?Q?cxCJof+bRAnTIexMGLf5xkynbE/+2WKTzvqC4loj0fHfsnLgADDD9vyUTDfZ?=
 =?us-ascii?Q?iSnC+ScZ2rGJoAnlKgAPm/1/Fa1QYUuI4ZjSlVp9c7ZzPy7UKYwYrRRbNevl?=
 =?us-ascii?Q?EqfFL+UuRRRBauCTFS8oce7clRWt9pJsF+XATx++2j1lZJw45sUHGn9pyevX?=
 =?us-ascii?Q?oRDapXlrTM1q/UWcuwvHxmz85iwqIE+bEdzXpjiK06sr0qTRqjJiAFBFR26g?=
 =?us-ascii?Q?P4g9q+V05rB9TxCskGrNce1BXRw0oUYGZsFXzOGaWZZ/DSJGOMrORdYWyg4c?=
 =?us-ascii?Q?2IsmJp7tS09DRwX0GwmaRBoSrKdmD6Zeugy/8wx1NwordDUTB6yWDs1evaI5?=
 =?us-ascii?Q?6+F1VafzRVyRUmtu/LkFeQLcqQfYWp3W4vkxzCFbX5zagqpjMNtiGBW2XjqU?=
 =?us-ascii?Q?GnuuzajGOvlZ2HpSt7/b1cI2E0Xxp2/SnMWy1fY/NsOFiP1h9pm12aCOC+Dt?=
 =?us-ascii?Q?b9yA7pBzvAbgTDXnZbHiR/s8eyP5Xb1vRZGydoZm6z6/GhsJDNn+PJR90oYE?=
 =?us-ascii?Q?BzbdrqsUUJk8az8eFmUZEB7P2D5pBoHvIANcxM8EgLGT6CmSvdlTIoncOH9z?=
 =?us-ascii?Q?oXWH8Ezxw35iixn3GQg+pokIqlqq9/lwgVzRWzxNfvZzASmuA0kouN4bcyef?=
 =?us-ascii?Q?lKZH1yuNnHTgWijcrI4stmD0YQTqPVJyxC1vZel6N2Aw0pemWH4RGkpzKjjW?=
 =?us-ascii?Q?apNAJXhu1y+3GOBvfqcx1mATjzClht4TGYddSeDNlR635IV5z6sB9Lhm/9oM?=
 =?us-ascii?Q?UJX7ckpneayl2hEuBdb383DQGFdCb3ooljBCvO3tmCZro/O7P5Xzp3D/840N?=
 =?us-ascii?Q?uawIz/xPMlbYQ/RmkrYO11dHJdCjKUZ0R1tYwOL6KXTWf+FXuVLolnwfHZp/?=
 =?us-ascii?Q?PSOjLR2Pdb6Z1/dB3UtSB3i9cBEUmjZ+VbRGQ2gedGZxXv5xzqqRlIYXTsaK?=
 =?us-ascii?Q?eSDiWYhWBfIyIof9sTLw1L8z+gG5w35TzBYLSkD0bU5ZTOtwPBBl7CnqvITQ?=
 =?us-ascii?Q?QBuQ6qA7rDXRRb3TMUuy3HDdzEwGDhBOQvR7x37Rs+yW9xzPMedBOs4orw3t?=
 =?us-ascii?Q?PgNj1EKe3QcYxzT+ZK+0WNP+q+UEyQslVyRt8eZNumQJJ5u+3zeZb4GixOut?=
 =?us-ascii?Q?BHfeIDFWNPyqL5Um/ZbWuageX9szrCGO8JCyBUmRlEIMzdFKM2XUx+abc7vo?=
 =?us-ascii?Q?+twZS6dMykvoeDaLuhwifyEsuaG2jnWQGXyFKqKbAFOPSCWsrAkO0ltMoqpS?=
 =?us-ascii?Q?kNbnbIVtn+pxDis7gZD9j6JWlgSxQmdXvCSKbTO9+YthJuuLumXeFn4Wi7kB?=
 =?us-ascii?Q?469A0u1vG7CNNJWKdBEt2C3MyuLVl/mH7ojKeyTZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:06:10.9312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb99f11d-44d8-4724-8d77-08de1bc4742b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9066

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


