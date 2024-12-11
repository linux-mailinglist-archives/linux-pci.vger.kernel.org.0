Return-Path: <linux-pci+bounces-18197-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BB49EDBDA
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 00:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB8B216744C
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 23:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6C11F2C42;
	Wed, 11 Dec 2024 23:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2oBJ4hEN"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2051.outbound.protection.outlook.com [40.107.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DCF1C173C;
	Wed, 11 Dec 2024 23:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733960470; cv=fail; b=ImhnVivAbma7ZKilw71PqRH+qgyErh74iIXm1fzNlTj7oU6RXAZ3mjDWQEnLyVskWcQ3M47tAq6MkCK/bw7nNwme+H0xl2nA1kTk5yEC5tIWq7eBgtWFsxMK23zSiTIWbII4mbnjSgx/j4ehADqisV2uZijRodYXy1jIZXm2dN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733960470; c=relaxed/simple;
	bh=rkCgeRnhngSVlNm5OQKkMQdh0HaT9H0fn3si2Ifmkaw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bf4b/CFRhNF1exqPJ1PfFpQgmtAohgbF74wHk9C7pRIXHhMmBVzJIT5CXZ+qEirYKZi6LpQO2bUoqujtvgiJHPmIDbBakrP9x/Uc72FgU4cItfL4yhL4uey4KyJ2vq9uEwG7+RWaxKb6jkx48zE27Oo7+dIYYzoYn6tQQZicYX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2oBJ4hEN; arc=fail smtp.client-ip=40.107.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMOdTZaWER15Se+cfvHYXj2nC6d/VEAE62Q4saTwrHgCPYyH83bXYDpMffEnIwGTx2rzlFSEcoe5ZnZRxgfunEj6lQVwNN2KS0pI/BZXEXDU1TIsIw+hYgMlLJsY+TS/Jq9Rf3D9g5eLej5Auwb9N+mFzWS2q+zQ32B8jZ/YR/kC0WHWpBGdQn1BaAYn9PhscwKSkVbT483Nu80K3+QGJmXmYUrpzcK8zJA9u7Ip+tKMBAG5BKUvVOpnh2z7b0il/HdcM4kqunTObv2Oj0sybQA4ktMs0o2aWAeLIRQ79pYUSAObwIqKGtlLaeDCehHWBkZ9SgWWlC0EW+A49VkgIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crcsOxq9A60Azlh321bwmCr3DOIcG8bPM2grnLtn0xE=;
 b=wHdiH4C5W1wU5XVxSKN9vVZk6u3OtZVC92sE7Nks30ttGUDLb2eU/gDO92YmL0zuIPCe2TMgPtMHJlL38RKrMcr/6roBEDIO1peC1D1q/7gGF/wTZheoVKxphOQDe5LDYvOau/Hca67fYhOJLo3SF9Q24T1EfpEJ+8lfwZGT+jw9zkuYwUhsvrikRimiU6tl8tD8XU8+4lxtu7YrXlme5XZA6oPu0jGKY9n8IZh/lewejsaOCdGt7wJM0MgIxHbsxcVY8WB972dYnQJUtPcqv9pPjbqT/FFV3/Dgq3rv8nHw++fIEoCDmy9raP4Davc0QdQpzKsysxGfXXfXAFMpcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crcsOxq9A60Azlh321bwmCr3DOIcG8bPM2grnLtn0xE=;
 b=2oBJ4hENtgw0keNWbQSl+zWV/P8wJrwJBsm+jw0sALuuZWLCS/gogWce3daZlSSMcUzhSSp1WOp2tYAoFP9bgwCZd3XjYdjU9waklfz0eGAwgEQfyR5Ov3lhieIEuPbr2P0RLMIdWYTg8J++PjMVBdCFVN8AMuivgADLGiaKhGk=
Received: from BN1PR10CA0002.namprd10.prod.outlook.com (2603:10b6:408:e0::7)
 by MW3PR12MB4427.namprd12.prod.outlook.com (2603:10b6:303:52::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 23:41:04 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:e0:cafe::50) by BN1PR10CA0002.outlook.office365.com
 (2603:10b6:408:e0::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Wed,
 11 Dec 2024 23:41:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 23:41:04 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 17:41:03 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <ming4.li@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: [PATCH v4 05/15] PCI/AER: Add CXL PCIe Port correctable error support in AER service driver
Date: Wed, 11 Dec 2024 17:39:52 -0600
Message-ID: <20241211234002.3728674-6-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211234002.3728674-1-terry.bowman@amd.com>
References: <20241211234002.3728674-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|MW3PR12MB4427:EE_
X-MS-Office365-Filtering-Correlation-Id: f7f0b816-6113-4989-6277-08dd1a3d46f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/7wrMf+eTw2bAgzGBoZht1hm0+Cl4fsMOuiT53ouYI3aqII7vfkBKQ5/gJ7/?=
 =?us-ascii?Q?WNuW4BzEk+DBjyqYniz+clVjzlEppAHe8UHjVYyR2SIBpEpnKbagcFcAyH0M?=
 =?us-ascii?Q?c7PNBLTQ8jHy/He7xYcAdo7G03hQvmhGzzJL6gfroA/2fXv1Rt0+IlQWWazv?=
 =?us-ascii?Q?bwAcCsztbmtpKou/fyw/la0PQZKUcbX6XvVpIUkRlVfjz1MdITgv2/5O5lpI?=
 =?us-ascii?Q?hstXW9TElBPsjo2zrq2eVxay0ifkSZumOw0H3jCs0/yJXBzIRG2nK8CJ9pas?=
 =?us-ascii?Q?n2YJa+utxz2KT9vIAqw/0S6/sBjnowNYv393kx82qbhszgtMbFPHLaIgzobO?=
 =?us-ascii?Q?VCNbsTexXv8EnWX4J2TAEUYentYvrokfSNz2n9zWsynLCA3erFfD3nzl1feo?=
 =?us-ascii?Q?VneaBUHucDb9B3aWAlTYN4RjbZ4qTts5LYWG8w2C/Ong00wWOMMJydM1pNrl?=
 =?us-ascii?Q?PP4Www9ljmjSrgMqZEF15hoXtvonmb9tLAGNOg4o5Y37qk/rVMIJVs88VFA1?=
 =?us-ascii?Q?3SqsqVDomWRY5hQEzVZk0kzRGjUpvZGOb9E6eVECTjU3JkBIobVzO7BVEAlr?=
 =?us-ascii?Q?7SdPEcq/lHI02jJwBVRW1Z0wcG1/1ZAUErKwJ2koGG+DN1YyCSdPStAd90Tk?=
 =?us-ascii?Q?+vWL7d2NZjgbM6LDmQlHh16bpF5HYUwODCMgwmnV3JiRoqHxLuUbNHAabGsT?=
 =?us-ascii?Q?i9Jfv6t5DFHWXHS1b/L6Vemxl6whLQZSfYZdL9MFsKneVWkm3xvu41hRN1Z9?=
 =?us-ascii?Q?tfwWvJ7pr0VcOFIebvBkn3j6yz1mTIN0+Scho/WDoXVp+M4vX/osi2I7R8Bx?=
 =?us-ascii?Q?IBZyAN3fkk9o8SX271ju7TszDZxwnijl3KXNj/YKRWsBUoFF8F27FZqx8rM4?=
 =?us-ascii?Q?uzdAAyaE7mywM3sU4yVCF2qaUfzrbZdtfmoEj8Yo7qLO81mK2CUSWx5L8YFu?=
 =?us-ascii?Q?wZq7L0LsvsYaBCmNV+NJQAceMh01uWFwsAiPjNyO9+UkgEbnB4ph3bPrDfK+?=
 =?us-ascii?Q?CoDqznvADfRhlWLxfeWPOYwoYgCDuhLjgQW4mSywFrDT7x932tfJzcsCRM62?=
 =?us-ascii?Q?heveVwYOzB/pKPz3tINMDEptB5WYWwQbIPidWLCyqsrdpIVrvurhuhRc+fMN?=
 =?us-ascii?Q?r7Xc7p2iTOKGnQ+asQe8mPgvByVWjDOKtYDWjHK/iuKlNswaVkx7DYmrAH0b?=
 =?us-ascii?Q?z4Mnktg7tBPioBYBoUdOdb0myr4k0zUd2/P5KSCexKfs153oYIcvMHP/NI6z?=
 =?us-ascii?Q?NtCtyd5DXQ674E/X/z1fPucHYvlRcxvUHYmjpDgt10MDa4Qv864ghQ1gFM4p?=
 =?us-ascii?Q?v6ATEmEisAxbSTUTxbR6E/rRGfgz2OkcMB2mS4wrvQZnzzniyoHVjLjwNJjD?=
 =?us-ascii?Q?wD+rffFo3o8Dc6GLIx/lXWCI4Y5cDGDBS0Y+lho+eLgy/nZB3f69/4642gws?=
 =?us-ascii?Q?G44JLSFnj13pldMZ/uYavLtAuSMEa8Nm7gVQ1iw9+PWG73Yu+zgcmA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 23:41:04.1863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f0b816-6113-4989-6277-08dd1a3d46f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4427

The AER service driver supports handling Downstream Port protocol errors in
restricted CXL host (RCH) mode also known as CXL1.1. It needs the same
functionality for CXL PCIe Ports operating in virtual hierarchy (VH)
mode.[1]

CXL and PCIe protocol error handling have different requirements that
necessitate a separate handling path. The AER service driver may try to
recover PCIe uncorrectable non-fatal errors (UCE). The same recovery is not
suitable for CXL PCIe Port devices because of potential for system memory
corruption. Instead, CXL protocol error handling must use a kernel panic
in the case of a fatal or non-fatal UCE. The AER driver's PCIe error
handling does not panic the kernel in response to a UCE.

Introduce a separate path for CXL protocol error handling in the AER
service driver. This will allow CXL protocol errors to use CXL specific
handling instead of PCIe handling. Add the CXL specific changes without
affecting or adding functionality in the PCIe handling.

Make this update alongside the existing Downstream Port RCH error handling
logic, extending support to CXL PCIe Ports in VH mode.

is_internal_error() is currently limited by CONFIG_PCIEAER_CXL kernel
config. Update is_internal_error()'s function declaration such that it is
always available regardless if CONFIG_PCIEAER_CXL kernel config is enabled
or disabled.

The uncorrectable error (UCE) handling will be added in a future patch.

[1] CXL 3.1 Spec, 12.2.2 CXL Root Ports, Downstream Switch Ports, and
Upstream Switch Ports

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/pci/pcie/aer.c | 61 +++++++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 53e9a11f6c0f..d75886174969 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -941,8 +941,15 @@ static bool find_source_device(struct pci_dev *parent,
 	return true;
 }
 
-#ifdef CONFIG_PCIEAER_CXL
+static bool is_internal_error(struct aer_err_info *info)
+{
+	if (info->severity == AER_CORRECTABLE)
+		return info->status & PCI_ERR_COR_INTERNAL;
 
+	return info->status & PCI_ERR_UNC_INTN;
+}
+
+#ifdef CONFIG_PCIEAER_CXL
 /**
  * pci_aer_unmask_internal_errors - unmask internal errors
  * @dev: pointer to the pcie_dev data structure
@@ -994,14 +1001,6 @@ static bool cxl_error_is_native(struct pci_dev *dev)
 	return (pcie_ports_native || host->native_aer);
 }
 
-static bool is_internal_error(struct aer_err_info *info)
-{
-	if (info->severity == AER_CORRECTABLE)
-		return info->status & PCI_ERR_COR_INTERNAL;
-
-	return info->status & PCI_ERR_UNC_INTN;
-}
-
 static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 {
 	struct aer_err_info *info = (struct aer_err_info *)data;
@@ -1033,14 +1032,23 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 
 static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 {
-	/*
-	 * Internal errors of an RCEC indicate an AER error in an
-	 * RCH's downstream port. Check and handle them in the CXL.mem
-	 * device driver.
-	 */
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
-	    is_internal_error(info))
-		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
+		return pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
+
+	if (info->severity == AER_CORRECTABLE) {
+		struct pci_driver *pdrv = dev->driver;
+		int aer = dev->aer_cap;
+
+		if (aer)
+			pci_write_config_dword(dev, aer + PCI_ERR_COR_STATUS,
+					       info->status);
+
+		if (pdrv && pdrv->cxl_err_handler &&
+		    pdrv->cxl_err_handler->cor_error_detected)
+			pdrv->cxl_err_handler->cor_error_detected(dev);
+
+		pcie_clear_device_status(dev);
+	}
 }
 
 static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
@@ -1058,9 +1066,13 @@ static bool handles_cxl_errors(struct pci_dev *dev)
 {
 	bool handles_cxl = false;
 
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
-	    pcie_aer_is_native(dev))
+	if (!pcie_aer_is_native(dev))
+		return false;
+
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
 		pcie_walk_rcec(dev, handles_cxl_error_iter, &handles_cxl);
+	else
+		handles_cxl = pcie_is_cxl_port(dev);
 
 	return handles_cxl;
 }
@@ -1078,6 +1090,10 @@ static void cxl_enable_internal_errors(struct pci_dev *dev)
 static inline void cxl_enable_internal_errors(struct pci_dev *dev) { }
 static inline void cxl_handle_error(struct pci_dev *dev,
 				    struct aer_err_info *info) { }
+static bool handles_cxl_errors(struct pci_dev *dev)
+{
+	return false;
+}
 #endif
 
 /**
@@ -1115,8 +1131,11 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 
 static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 {
-	cxl_handle_error(dev, info);
-	pci_aer_handle_error(dev, info);
+	if (is_internal_error(info) && handles_cxl_errors(dev))
+		cxl_handle_error(dev, info);
+	else
+		pci_aer_handle_error(dev, info);
+
 	pci_dev_put(dev);
 }
 
-- 
2.34.1


