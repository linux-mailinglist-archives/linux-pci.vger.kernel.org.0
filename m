Return-Path: <linux-pci+bounces-44802-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5608AD20CD4
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2657F30393E4
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CE02F39D7;
	Wed, 14 Jan 2026 18:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fLZUis/D"
X-Original-To: linux-pci@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010027.outbound.protection.outlook.com [52.101.46.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D4D335546;
	Wed, 14 Jan 2026 18:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768414985; cv=fail; b=Nf22N1FyQbQm0PMoTfH6I/i+ycluOUsT9UHhtyhiaozdOOJb0R0llDK7Z4ibVBOwgRAlaYh3PUwjpreOwcqCzjGMTXHjs8hgNgRNWEmx2iILEDjvT+itwayB3fsHnbq9bVJTfpEkkwZSj0/Cw78HAlr/kLJYqOvZSS6yW9YBJqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768414985; c=relaxed/simple;
	bh=zdvn1EmjK9vF7Zwm4ljL0YRgqzbOnGvoQSEPMsZ7+L0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WoylrdaGMF0VGCRpxe8O4MV/x35vmLSqwjKSEZ79KbhvPEq728pZnnrhkdQL06as5SC3fA43lvKTPkiP3SznVwCV3oV5zwDGh13IrRPd5HWZydtF2/NHaOLO94ohNDroxMWOYqCn67zC4ZepW6qemopty5eGS/Q8KtspEmbQDNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fLZUis/D; arc=fail smtp.client-ip=52.101.46.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFygHUHvJPivTAz9w2ZT7/ONVDUK/EutcmCfYDk6fh3xKDeiWVrf6NlUxSekh6mzuPA5MMFAT3e/EiQgrkX/xH8JWLFQeIVAsoGUkA0f95qJtQA3Oh3EQ/VbIcby3W+7t4ZsUD/ppo7rhYb4IBsJEc90YZhX/wEYsLd+mOjewl5xS1iCfr7i2gNwBCs55QF0QDMpU7FGTi4KcdWjQRQQ+j/EfVVyYyjg5kPCiE9Ifehp2s2Hsv/7fv7eF0hxGc0103lkm5ln6k4P3zZvaf3mG7bmrJmT9FLbt/eAhsgQ24x6kCndt8DafYJtDuGPCTLpTOUGmVCOhVcU0scnvepFkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5NyNyMxWINlkCDdal5uYsB42snl4FWcjJ6+0zp0F2k=;
 b=vA0tUOHSx3NlQ6jH03tnBP7pa+Ag0Q9mwAgoGdqXhdm2zOCzEY6ePtzjlsI5vepq0qVRq4dldNHg9oW0dBi0HDWTvm82Nt/3DywFUaNnDveuQxNWwQhUOKItDlQobD8K8USMCG1Ot8l8C7rQFcuIsCiw0MNRjNCWr7duc/FaqJ7gOe8JoG/KeQeEvRET+RsrSpSaS0nL0AAEsRXtZfEHbxamtXp/0iQZFpoL7l7L90tr4ISvONz0CXWpqW16jnHvh0/BU+p3KZuRUJ99n8LLvUTHTk8fB24nKOELR9wanZUm1DeidDQxNIc+mPNNKnYKiUypegnrzLFOWIp+boNOIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5NyNyMxWINlkCDdal5uYsB42snl4FWcjJ6+0zp0F2k=;
 b=fLZUis/DV6EgNVFof5+qCiSon248oDoeLt48QyplXV8ZAnrREks2DrSu8unSeVWwQLdYAuMeyqjAL91q/62ZahxlRVjzT5vmP8l+U+ktNTUDrbyhjmEZEgV+lCYkNrUPr+6+WBCbyzXwsIDBbgXclSVFCpG6vaPuoFVTEn79mGk=
Received: from PH7PR17CA0053.namprd17.prod.outlook.com (2603:10b6:510:325::8)
 by MN0PR12MB6245.namprd12.prod.outlook.com (2603:10b6:208:3c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 18:22:59 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::30) by PH7PR17CA0053.outlook.office365.com
 (2603:10b6:510:325::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Wed,
 14 Jan 2026 18:22:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 18:22:58 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 12:22:56 -0600
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
Subject: [PATCH v14 09/34] PCI/AER: Export pci_aer_unmask_internal_errors()
Date: Wed, 14 Jan 2026 12:20:30 -0600
Message-ID: <20260114182055.46029-10-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|MN0PR12MB6245:EE_
X-MS-Office365-Filtering-Correlation-Id: bf67362b-3d66-49fc-18e3-08de5399f1c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZGOAYElBwybmeG9z9jJYGkkKfpnmlsDnbdDWDTj4Ne7vEEEv72O9QyL3jJ+g?=
 =?us-ascii?Q?/B89KK7AYz3sGqCc24cRUqYMdz+SumieBxpSCKepsgU/tW4jFI7RCm28OxX9?=
 =?us-ascii?Q?s9phmJr+hrdnqvhMSIez+cBK/BY/icW/WFTynMj1nu8QtP2zjDocpkvPzehO?=
 =?us-ascii?Q?y2zdTMrY6ssW3Yy1KnMXO1UxAH3MIllbxEJqhrELCIRFfCdcgpFU3GKNe5e3?=
 =?us-ascii?Q?F0+Ulun4051wOLzoEAdrWy+8MtYDsn3fM6T78R9bYsxVWcZzsfxkHaURggxN?=
 =?us-ascii?Q?91tnrphXF+B3k788myfV1wM3eGPCyKJrwS8yfdE9lwP3X+Y8cOogw0GkWbvF?=
 =?us-ascii?Q?1sgP/Iyi5TXluKOl5/qdpR2ecdebJMo71nzgU2sM+Z3pRJwLVoXTQYW5yYkP?=
 =?us-ascii?Q?JCkKYJqUP9k5tpnXeF8g5ynzI2CvP0SuOr7INf0XWA2QeILM3XJWOcq7u2Ur?=
 =?us-ascii?Q?uUTHofxc1bdRdbBE3S8qVeA0V6X2+lyLn8auQtaCTKPcA1N/Q/cmOggPh5iw?=
 =?us-ascii?Q?LjEI/B7M4ZFEL51GA9gjgl6xElJmjfoleY586il2InQKWUTrjOzDmkQHkd9F?=
 =?us-ascii?Q?8biSrqbizJSvw/qZIu76EqTLmS3wg5Ex5PurGPCHsDFxVaKATFOtxOn3+BiF?=
 =?us-ascii?Q?qt4trmaEQh4LjAoYlJlHlmKZ4maR++7dV9ENDOa1Jl/Vc1Hzhh+8p4WH0X7y?=
 =?us-ascii?Q?WlsS0VG2Rvy5i2zZuZokHUsI0uR+2hlKgvRKBD498IdIwonEWk7k3FHpaTV8?=
 =?us-ascii?Q?eOxYijIqYZ1qEk70/V8ugA+wolH4hAZe0tl+/xWObZiulqIGJgVVsScHeh0D?=
 =?us-ascii?Q?7GiBBBAKMuT2IU655I6ZeV17riecJIE+Smhcvj+Wj3DVgDJ3MIVZeyB8e7yx?=
 =?us-ascii?Q?IJSbep1OpHQ7g7IBGwYjbEaa/+Wk5Cnc3JA5i2i6Z3KNNnEH7tjmCAy/lLRo?=
 =?us-ascii?Q?6E+Txc3GW8pZjBP6j2XpnB3ly+kmbgXqMV9fjwBoYILcB4jRZm+DY7wKAJEI?=
 =?us-ascii?Q?AzRO/vOSbYbzwsj8HbCQV8+27FfzEzPA4bAfMtbPSTSur3hgJRquPJPPC6El?=
 =?us-ascii?Q?sWhzqmHC42gfWz5T7c5oAESkflPdcopaF1+Ph5ghKUCJ7/It4lCDzPJYZc2h?=
 =?us-ascii?Q?QHnsqO42zHi0aRVqncIb5eeserN09o9RDSCMfn6LIGdyGoXuuwxgkuMphVW5?=
 =?us-ascii?Q?5F2JGkwXjRSWkQemR5Re8DJPznAHdnXQ0Iw6ph0VDzb7ANj5GNavcBW1J5fx?=
 =?us-ascii?Q?LHov8A+ZhCClnkZ9zIMNEtegOAaeZ3Lb2C+QJ/dPX5Crf0kc2X487Z8ifZAM?=
 =?us-ascii?Q?ik+2y0wrgW9HQsWQfAD7Zbohh5vRomGTzd1jJl9D5dqz4OCSpuZ8nuuZkDjJ?=
 =?us-ascii?Q?Laf0qyJk+oRwUngZzcSonkgEmBu4H2CYj5FkznJxDLvY/w5g/ksrUC8debeI?=
 =?us-ascii?Q?e3kAwLW9LOkhbZuO7Fcs+pQzo/RZaVGh8GgqGZvPgwDsY7agcIORlgQQy/I8?=
 =?us-ascii?Q?VbNLrBw39xwmzsi09Z+QtL05OLzSdx301OHyDBUvyx/sHPb5oMTuGQJSoyre?=
 =?us-ascii?Q?Zjq1fdW1ms70tkDYFyHEVrxCLwuudmJrtLWlHVgzosExroESg0JiBkKlvjnw?=
 =?us-ascii?Q?zuZU9mFbJ4TME46XsK3X+OeZ2h8cOz53lUSg7E5HqiU+DWBrtaOMMKR/pBpE?=
 =?us-ascii?Q?LCV74fQ67RCJqulB/ibbc/ZDnq0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:22:58.3571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf67362b-3d66-49fc-18e3-08de5399f1c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6245

Internal PCIe errors are not enabled by default during initialization. This
creates a problem for CXL drivers, which rely on PCIe Correctable and
Uncorrectable Internal Errors to receive CXL protocol error notifications.

Export pci_aer_unmask_internal_errors() so CXL and other drivers can
enable internal PCIe errors.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v13->v14:
- New commit. Bjorn requested separating out and adding immediatetly
before being used. This is called from cxl_rch_enable_rcec() in
following patch.
---
 drivers/pci/pcie/aer.c | 6 +++---
 include/linux/aer.h    | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index c99ba2a1159c..63658e691aa2 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1120,8 +1120,6 @@ static bool find_source_device(struct pci_dev *parent,
 	return true;
 }
 
-#ifdef CONFIG_PCIEAER_CXL
-
 /**
  * pci_aer_unmask_internal_errors - unmask internal errors
  * @dev: pointer to the pci_dev data structure
@@ -1132,7 +1130,7 @@ static bool find_source_device(struct pci_dev *parent,
  * Note: AER must be enabled and supported by the device which must be
  * checked in advance, e.g. with pcie_aer_is_native().
  */
-static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
+void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 {
 	int aer = dev->aer_cap;
 	u32 mask;
@@ -1145,7 +1143,9 @@ static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 	mask &= ~PCI_ERR_COR_INTERNAL;
 	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
 }
+EXPORT_SYMBOL_GPL(pci_aer_unmask_internal_errors);
 
+#ifdef CONFIG_PCIEAER_CXL
 static bool is_cxl_mem_dev(struct pci_dev *dev)
 {
 	/*
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 02940be66324..df0f5c382286 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -56,12 +56,14 @@ struct aer_capability_regs {
 #if defined(CONFIG_PCIEAER)
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
 int pcie_aer_is_native(struct pci_dev *dev);
+void pci_aer_unmask_internal_errors(struct pci_dev *dev);
 #else
 static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 {
 	return -EINVAL;
 }
 static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
+static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
 #endif
 
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
-- 
2.34.1


