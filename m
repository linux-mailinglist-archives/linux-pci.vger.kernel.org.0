Return-Path: <linux-pci+bounces-34834-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB61EB37730
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 994491BA0BC3
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 01:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A91B1F12F4;
	Wed, 27 Aug 2025 01:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G3sWNcFY"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492921DDA24;
	Wed, 27 Aug 2025 01:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258746; cv=fail; b=i6TL5qzIRdLfOC0llMXTk7k/ZG09lt2UMYxUdqdAyO2EScaMgA2Futm1ZRvEEGXnObQ6DmKc+eQnDfhP3LE+9nxwB7UnhO+8TQ7uiVjU5aL9E3laigpdfZff/9w3JPkeYzi5BPEA/505EDkkS7XvCyXN7xn8oHZDpgiRlz/BCDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258746; c=relaxed/simple;
	bh=hCYxSs2FZei4ORka4h36RvYIF9PbNPAA6fxqgstdImI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tqZeH+mIACn0f1SVPzOW3NTBWoJTNO9AgUMpzfn/ZeFQttDy9yrhfx8GpPLS1FyAlyICuMIk4Nod8o8scCvX94f9ACTKkrcrM9zR5Cd8F952lg3hJA09NGOPmjmUilm9ZCC1y+KjeQx7LAO6c5pRtQHxCkXh7+CSwtlxWFpSyB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G3sWNcFY; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aqNf6k44t6Sq+YwKD0G0mXJ+hSDf+Qr52pj6gLIp1raW4mu9uKHLESEU8kS39Axp/J1r0QijXWEkXgRD3I/Qg9Z8HhxYbfv7s/yMYACkRaXr8jPiH60jMq8d724ZjFFMOuLeouLBK7pTPzKRdh0hxjodHkyVpjdA38gOd/tCngu2P+i/I6oCN+m9Elihpy3Gqj7by1ISJwSsCMN5wQKYv3+RFbSQClEWgyVrsfIZz+UqIzrN7S6h4sIiYc40zIjy3sJBubhkjlR10hpROTodWC1Wfv5jZiityk8zmlOndPssaFxK86WhV4fBRnaJg203gM426prAaAL4a2nUJqhgVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7/tETxKiD0WggabVkKpjdyV0P81lr6X8h8EqnJTMzw=;
 b=FDw9+TWGicH9SN6I0PsrIVfJ8sgiLCjkIABcMqkFhiIsClTMo2LXKanDkZOwtJP3hpFBlxwAjDgi6uhypD1s2PSzIOlzx0DEmGRHbRVOvYE07WFdy7HSI/bKbFNd5P55AqoU4TjsYdYNBv6lZT/0LXS9BbltbcASPZcA8GGfHIsyJxJMUZFCnofGNQ31kqMw1ydMuS3gjNGApXAT9kUBfxQ83StZZWRhyj3G4WDLAXIEzvlkU4fv1XkGbuVsPHyE0K2RncvFStO3oVfz7Vxc9/Fpy67025ojW+VcWzd3ijSA6x4fW2szAgupP1indD3PDmBMrlG5nG0az92CiOWYoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7/tETxKiD0WggabVkKpjdyV0P81lr6X8h8EqnJTMzw=;
 b=G3sWNcFYK+xqHyIi6Jt4zR9Oe6ceZBgJS4W5azek+JMAepuq7zo9/2hJHUcPgYFe+UowXCq3+SFl9daFnSa6XJKlF+2PsPx1cjoBEgSlkrBTaQKkZPK6IbiEJMYL3rA7BEAmL/2Uh/wLG2NzXmteBGX1x376O2+1/RhX80qjjoI=
Received: from SJ0PR13CA0013.namprd13.prod.outlook.com (2603:10b6:a03:2c0::18)
 by SJ1PR12MB6217.namprd12.prod.outlook.com (2603:10b6:a03:458::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 01:38:55 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::96) by SJ0PR13CA0013.outlook.office365.com
 (2603:10b6:a03:2c0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.13 via Frontend Transport; Wed,
 27 Aug 2025 01:38:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 01:38:55 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 20:38:53 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v11 17/23] CXL/AER: Introduce cxl_aer.c into AER driver for forwarding CXL errors
Date: Tue, 26 Aug 2025 20:35:32 -0500
Message-ID: <20250827013539.903682-18-terry.bowman@amd.com>
X-Mailer: git-send-email 2.51.0.rc2.21.ge5ab6b3e5a
In-Reply-To: <20250827013539.903682-1-terry.bowman@amd.com>
References: <20250827013539.903682-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|SJ1PR12MB6217:EE_
X-MS-Office365-Filtering-Correlation-Id: d761670d-8be8-4949-c626-08dde50a7c26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7bplsEBPKNQogueM2vwG47qUt1EftaiG39GRL4BTDmUBrvmuOOuXDnsrYt9E?=
 =?us-ascii?Q?8rg4Y7D6yAZOqDY1JodxckM3GPBg7D5fv7MGTlYmusaMhXVkcwVUYj/zf6aL?=
 =?us-ascii?Q?Uk55Ek/UNnvOSvdvMwmR0uFXPnqrlLXNUaHHL8aC8d8ET+wSxP4G58OYMUkm?=
 =?us-ascii?Q?dBnsPBZ8Lmidww3abGmNuZUGqDGFlx4aump9KyRS7TJFZ9Ex+HhkW8ELRZnr?=
 =?us-ascii?Q?BUBAr1DWqYVTu+W0Lp5o2iO3fa/Q6lidhsGJ/ooRspa8E7DEiKTQs/wF0ahj?=
 =?us-ascii?Q?d/WrYk7gO8xaCLr8p4pHiSJ+uwDF+MC2X+2NoXZvUVCOtE4ACVDl+FFMIdIk?=
 =?us-ascii?Q?L8+4rb/QIBZKEkXwKttCHEiq8EbCWOjJvHqKJSxgE18w1oKOOJmnxhqgoSUc?=
 =?us-ascii?Q?4oVGlJpG4yyhckcSl0yyTBRdnRjNA0LbxiGy21o8BJ53M2EdUKV2+WgNln7t?=
 =?us-ascii?Q?fX4JPuuv+MLiutUSMXK9VYXfekrymVIzA4gZJ4fDjodTtiZ3lAda1OcKvubL?=
 =?us-ascii?Q?sXgqwTIn+dO6AehQoel8DPNyWlZzj+C8q93HGLXEwTRjPSSqs3dWJ8D3kvaE?=
 =?us-ascii?Q?31X7HxneSo2GxuRkWSevMibSWvcBEiiyojYcYkJyvHWC269z/mENOGhBZdxT?=
 =?us-ascii?Q?0kzQb1iXEgF8dfHVuZyoqlY42SGWPabH2jLvoc9qd6NQS5QcMapokMnXAGlk?=
 =?us-ascii?Q?xL7d7uxk7cAutJwnfVxEKFVFWI6qpNCBEgVB9BG1j4dTm48BYw2qQEr8r3cs?=
 =?us-ascii?Q?GcAArjtSXyrkeuBEIqMELPtfY6aupUkyoORu9BsGkD2Y7JUt5LhgPaqM2CR1?=
 =?us-ascii?Q?uxnhtGCTJO/rq+fFyO6zfsfeBMMRkWgc0UNio0DIPMUC3sztSttcAvxLn6y9?=
 =?us-ascii?Q?dpO8bcE6npcG570qEpR3HA5TVrVE0BakLmWPmGUcnIMwwJaRtAGdPJOYGpKI?=
 =?us-ascii?Q?scaYSiHfiDU7ioQo7XkkRNmqlQpg4hNp7mTyTjFvefTc5qJ6KCnCCiGZZ8Py?=
 =?us-ascii?Q?Lh1MdXs8tzv1LN8HTtyaWpNCWj2xBzPDqVX5qOh/lwsXWaYZ6fJCPNrkOpgo?=
 =?us-ascii?Q?sHIhJM/tcRVYGEpIjl2I1sgBA4pmEmmXodlRORltDXqVHQEJTQbs8a9YG2mj?=
 =?us-ascii?Q?Y4W/2w6e6+WeqpGAvwQ5aisiHR4aOtQWhTnafinr0Y2hT3TfMDyUJUHaNiSm?=
 =?us-ascii?Q?9MbcASRb4RDCZlBz1VhFk9Le9FYeAUKezhUT1WKZlpQ9ANyt8PAq+lp0oaIh?=
 =?us-ascii?Q?TQvGWL/wukWc91id+hvChpvnJVociF+3dPCjvRmc5vSrz2v0JKpe5NIzcp2Z?=
 =?us-ascii?Q?p4czGyIMje3tR+lAFpRvhW1LMwV4k2lA5Ij+ey2fDqxC879lnbsZzRViZ5Mf?=
 =?us-ascii?Q?n10xYx4kopRZEGpp02rxwZj0yYF1eQyFCd9/1hsNOQ7M3io4ANgL0E6JJ+sK?=
 =?us-ascii?Q?p8mukQ6Hvs5S6JpVfShZKVfebYwm6fMadkJO5eJWE3o+fvugchz3+QABaeS3?=
 =?us-ascii?Q?VNdQO2Bc1VdJ4xnr8ZhEnYl0uRO9WywToixGzi2gvHPt/oYkBfMyR8ZL3g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 01:38:55.0482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d761670d-8be8-4949-c626-08dde50a7c26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6217

CXL virtual hierarchy (VH) RAS handling for CXL Port devices will be added
soon. This requires a notification mechanism for the AER driver to share
the AER interrupt with the CXL driver. The notification will be used as an
indication for the CXL drivers to handle and log the CXL RAS errors.

Note, 'CXL protocol error' terminology will refer to CXL VH and not
CXL RCH errors unless specifically noted going forward.

Introduce a new file in the AER driver to handle the CXL protocol errors
named pci/pcie/cxl_aer.c.

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

---
Changes in v10->v11:
- Move RCH implementation to cxl_march.c and RCH declarations to pci/pci.h. (Terry)
- Introduce 'struct cxl_proto_err_kfifo' containing semaphore, fifo,
and work struct. (Dan)
- Remove embedded struct from cxl_proto_err_work (Dan)
- Make 'struct work_struct *cxl_proto_err_work' definition static (Jonathan)
- Add check for NULL cxl_proto_err_kfifo to determine if CXL driver is
not registered for workqueue. (Dan)
---
 drivers/pci/pci.h          |   4 ++
 drivers/pci/pcie/Makefile  |   1 +
 drivers/pci/pcie/aer.c     |  50 ++--------------
 drivers/pci/pcie/cxl_aer.c | 120 +++++++++++++++++++++++++++++++++++++
 include/linux/aer.h        |  21 +++++++
 5 files changed, 150 insertions(+), 46 deletions(-)
 create mode 100644 drivers/pci/pcie/cxl_aer.c

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 417a088d815f..cfa75903dd3f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1179,10 +1179,14 @@ static inline void cxl_rch_enable_rcec(struct pci_dev *rcec) { }
 void pci_aer_unmask_internal_errors(struct pci_dev *dev);
 bool cxl_error_is_native(struct pci_dev *dev);
 bool is_internal_error(struct aer_err_info *info);
+bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info);
+void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info);
 #else
 static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
 static inline bool cxl_error_is_native(struct pci_dev *dev) { return false; }
 static inline bool is_internal_error(struct aer_err_info *info) { return false; }
+static inline bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info) { return false; }
+static inline void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info) { }
 #endif
 
 #endif /* DRIVERS_PCI_H */
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index 07c299dbcdd7..bfe5bb5a3c89 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o bwctrl.o
 obj-y				+= aspm.o
 obj-$(CONFIG_PCIEAER)		+= aer.o err.o tlp.o
 obj-$(CONFIG_CXL_RCH_RAS)	+= rch_aer.o
+obj-$(CONFIG_CXL_RAS)		+= cxl_aer.o
 obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
 obj-$(CONFIG_PCIE_PME)		+= pme.o
 obj-$(CONFIG_PCIE_DPC)		+= dpc.o
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index ed1de9256898..627d89ccea9c 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1092,51 +1092,6 @@ static bool find_source_device(struct pci_dev *parent,
 	return true;
 }
 
-#ifdef CONFIG_CXL_RAS
-
-/**
- * pci_aer_unmask_internal_errors - unmask internal errors
- * @dev: pointer to the pci_dev data structure
- *
- * Unmask internal errors in the Uncorrectable and Correctable Error
- * Mask registers.
- *
- * Note: AER must be enabled and supported by the device which must be
- * checked in advance, e.g. with pcie_aer_is_native().
- */
-void pci_aer_unmask_internal_errors(struct pci_dev *dev)
-{
-	int aer = dev->aer_cap;
-	u32 mask;
-
-	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &mask);
-	mask &= ~PCI_ERR_UNC_INTN;
-	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, mask);
-
-	pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK, &mask);
-	mask &= ~PCI_ERR_COR_INTERNAL;
-	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
-}
-EXPORT_SYMBOL_NS_GPL(pci_aer_unmask_internal_errors, "CXL");
-
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
@@ -1173,7 +1128,10 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
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
 
diff --git a/drivers/pci/pcie/cxl_aer.c b/drivers/pci/pcie/cxl_aer.c
new file mode 100644
index 000000000000..74e6d2d04ab6
--- /dev/null
+++ b/drivers/pci/pcie/cxl_aer.c
@@ -0,0 +1,120 @@
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
+/**
+ * pci_aer_unmask_internal_errors - unmask internal errors
+ * @dev: pointer to the pci_dev data structure
+ *
+ * Unmask internal errors in the Uncorrectable and Correctable Error
+ * Mask registers.
+ *
+ * Note: AER must be enabled and supported by the device which must be
+ * checked in advance, e.g. with pcie_aer_is_native().
+ */
+void pci_aer_unmask_internal_errors(struct pci_dev *dev)
+{
+	int aer = dev->aer_cap;
+	u32 mask;
+
+	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &mask);
+	mask &= ~PCI_ERR_UNC_INTN;
+	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, mask);
+
+	pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK, &mask);
+	mask &= ~PCI_ERR_COR_INTERNAL;
+	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
+}
+EXPORT_SYMBOL_NS_GPL(pci_aer_unmask_internal_errors, "CXL");
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
+		dev_warn_once(&pdev->dev, "CXL driver is not registered for kfifo");
+		return;
+	}
+
+	if (!kfifo_put(&cxl_proto_err_kfifo.fifo, wd)) {
+		dev_err_ratelimited(&pdev->dev, "CXL kfifo overflow\n");
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
index 02940be66324..f8eb32805957 100644
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
@@ -64,6 +75,16 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
 #endif
 
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
2.51.0.rc2.21.ge5ab6b3e5a


