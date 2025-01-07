Return-Path: <linux-pci+bounces-19427-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EBDA042C7
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 15:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F3633A1C3C
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 14:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0445E1F2C4D;
	Tue,  7 Jan 2025 14:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CYh/h+NJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09221F131C;
	Tue,  7 Jan 2025 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736260767; cv=fail; b=XJvvKcSj/Au3E2QfJcYG7jzrrYz58j4q+dvKcSaMVcNi3iJBuNtuNAFEEpgvE15e2uzReTbewMGWQkCw/wCjA3hPb2t+uyTgkVCZmtz89YMloIJldqmKwDvvoAKpQTM0ywYO+Lkx9lfPiaHGZ2x8o6ID61sHqsqU8L7Q0FxrQyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736260767; c=relaxed/simple;
	bh=C2AdWoJk5uzWddWAuiAVifyj6Xme11Q1t+/tYLF7IJU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fHHatnrkSE207adUNgFsOoNk0xu+VQXhoHLXzlQGUc9HN/MH8fqNM1yeWaDq+tvzPdmJUfIgto/PXipzpEjBh8LFPaylIh7jlTO8hBkeISrmdTckNGsWdpWvZ1T+kuMOE+hB19DNlpdQ0NCoBNVwwEeJ8JB5OJjiVoy8wsOc/tY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CYh/h+NJ; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gDhRhp6osTufWPT3mdtcjuh1wG9St6gWNpHQYqv3sxCgVDMGDw3DIYe2Bx1PcIFcl5HJqfCrfVmsFhoxwe4j1OL9BYp4MDLKKgY38nQlZkPLAieeC2II9Qaa5voImjmUsuwMDpda+sN63s6xahdicVpr148+bk9rjbo/1HVfrgfR+VWsZgi+u+K5bFh2iKxnDc3u9aCbXFtuRscIS/DIGOuQTs4X890XxyFREGsCxDhyjvsUhkS3/1atrk8DN6k0q1e+B6LA8vxYnq5IIe3CoC5qnlP1vF7qAKeNlTBqGJSZx7cg3G32y1kixaU8rCNh96apCGYYbJjKo9Jx0L9CDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BeEkIVOtV+g+vxMMrO8Qt1dd+Q9JI0flzdXs/yiF0E=;
 b=hyQo7MLd8oZwjM1e9SgvEsMfMVe8CGzJygW1Ubku7V1u0ikPppEc22zB3yr9CDi39h+ObALw2x1yAVjOWBroGD8rT4j9lMgB/PDPtB6LRMTTKCFUWj4s40NuekdLD7sy8+CYNMC9seXei9xb3shrlOOTGwmlVre0BVb6pPcOf8BaMRm9+VwKzzJ6tfQ0RGqqmc5F06+SEhHpZDb7hMSPdkBNGafgZZnzZviQIZ+AyXB0h8ChXjkVVVTiTMHJrFc8pTb6DixI7k2/NcfiNWt5C9T+RSN7aJZfVKGTAdP0AX40PpW3HFcC3RZYe2WBwzLno1/Pl9YY6ZG0wqoXPcZO3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BeEkIVOtV+g+vxMMrO8Qt1dd+Q9JI0flzdXs/yiF0E=;
 b=CYh/h+NJ2PcabD21WwABKNZo6coNwOkdAWG50BcvFGVKa+umK9mlPG0bOzhyXr3cF30XUW/mGQMmaCjXJZBQGqTagbP1xpLtcnqquRR4m2ylJQjv0a7Iin9ksbU2zkTgEEsYIfMtUWWSJS8V/oyLCOBN25FuzeMiOy9kkDZWa+s=
Received: from BLAPR03CA0047.namprd03.prod.outlook.com (2603:10b6:208:32d::22)
 by SA1PR12MB5658.namprd12.prod.outlook.com (2603:10b6:806:235::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 14:39:21 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:208:32d:cafe::98) by BLAPR03CA0047.outlook.office365.com
 (2603:10b6:208:32d::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 14:39:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.0 via Frontend Transport; Tue, 7 Jan 2025 14:39:21 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:39:19 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<ming.li@zohomail.com>, <PradeepVineshReddy.Kodamati@amd.com>,
	<alucerop@amd.com>
Subject: [PATCH v5 02/16] PCI/AER: Rename AER driver's interfaces to also indicate CXL PCIe Port support
Date: Tue, 7 Jan 2025 08:38:38 -0600
Message-ID: <20250107143852.3692571-3-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107143852.3692571-1-terry.bowman@amd.com>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|SA1PR12MB5658:EE_
X-MS-Office365-Filtering-Correlation-Id: ecf81551-72ae-4aa4-7b33-08dd2f2912bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TEvhWCoN8h6h1PPTtfLf4zkxns7lxLK/8i6Rxc/ZdLnckYeKhur3xfZMrtZP?=
 =?us-ascii?Q?OdncLv39kjfrfVeGl+40ej7GZPUxk3zWVwOCMftCSvzCHs/YGQcmP8RBbBRH?=
 =?us-ascii?Q?lKIq3NwAoiTn0x5X7zE4z1IlRrdw9MOothd3IXBCSYMaFWdONrTJhNtmfQcO?=
 =?us-ascii?Q?WjD14/4vaVXPxNOj/NrAeqmhxkh8YIhr2IL8HMJaogpz3ygyT/EPwWDxwziK?=
 =?us-ascii?Q?quOlviPL6bX3di2i2sPT6WzaEC4eIEbpcEUtlye/0466Vjurn6b0lfmJ2WD9?=
 =?us-ascii?Q?cPhAoAn0SSqgidKigCsHWTDmgkR6kzVTWpbxXleGSqKmIiEFy9pvoe8v4ukN?=
 =?us-ascii?Q?+Pu3PmVQYCcy/V+Qor2U1NsbCXrOW4HqwKuS9w5DCVShZuYP4ywZ8lRJI7lh?=
 =?us-ascii?Q?vkgz+1iDU1ghye59Tbmf4je9GQtIk7N6pa4MtUPuiuwgzoxIaHeXOpeo0sY+?=
 =?us-ascii?Q?5OlS3A/Fjvi34621Moh+sUlmqLSOnU1nYm17J0BRJBJITEOLGQ2lub1ybus6?=
 =?us-ascii?Q?mDj7caMII7kAKNGMtKGPqAKZtHw+mKYEaqHaA/GkdtrzQN5LCGVivk8Gugd5?=
 =?us-ascii?Q?3LzN0M6uvoLw5b50ETevepl6r+/8X07bf/lMweDIrixNJPeiJep+G8AA3Mem?=
 =?us-ascii?Q?NsAGyDnih6M8EWLkX80DLF/utnoqs6gVzfefbTKvIufhwgf1nHWRVn8GMAeo?=
 =?us-ascii?Q?UgZ4+6/0TzZadRSb7NLWUlcREfL7Au/lDvLLHGp1HZKkHC4yyIzFqiNGQVN+?=
 =?us-ascii?Q?rJdyRaHWgyrhRuf3s0o0kAjo/MTSKpTIThgmHq7heBrzk19m1UfOAhhuma3i?=
 =?us-ascii?Q?k9LQsfp0HmV2r8oHC8UWKngo/4rSUQN5nQ+buvvLUgM2WLKG+XQ8qLhrcuSz?=
 =?us-ascii?Q?Vh1Cf1GB7CR4kgiXjWgUD2AkRe88rsNU4NEBQ4STDAglW3sEWwLXQR7soR+X?=
 =?us-ascii?Q?VHvYWrmXImlCK3OYNnc86Pq0GMpkOzUhzCtocfYPKTPngryw4AQq7jauujcN?=
 =?us-ascii?Q?6oMFvL4awgupB/9tt0DiXB/dRu077El3cGIciAejXy/F8NE8hXNTGfJ4+1bU?=
 =?us-ascii?Q?bSAr88GNM3me0+DbVeQe4PE1xl+xpeVRQd0yAf15T4no3C3YIK2mx6B7MGa4?=
 =?us-ascii?Q?LtEO6iWrBMvGCQxulbsDD4V72g+kA8g/Q+vrqiP2WfhZXdpbMzQX5r04LnuI?=
 =?us-ascii?Q?er3pNJT5st3tTauXYDVDe1HXxFaKoKn8poDO33D6kLj+r5ToZ9yhruHIXz0G?=
 =?us-ascii?Q?LXhiW4Opa8Py4u+339CVwAOsdg783NqAOXMnkFZ1UunYsa4UdYrAG7ro0PJS?=
 =?us-ascii?Q?TNKaBYfsFH7e+CLHkDOs9YDhjbHDahggEk09u4nf0USnYXEX0IhlIRpVuEeI?=
 =?us-ascii?Q?k+eha4ZceR1iMb6VIRlvRhlfpOlasSgXu0IdTNKyj5QKhr1HBwJdMDKfll46?=
 =?us-ascii?Q?5haGyrkZU/RMbBCMpe+834ot5BWqO9c4CKPW+9HXfyoeWywenQmIDujZOBox?=
 =?us-ascii?Q?W7J/xwOLSNnr7IJu2XvDQZZ7UbuklHlkIg3M?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:39:21.0400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf81551-72ae-4aa4-7b33-08dd2f2912bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5658

The AER service driver already includes support for Restricted CXL host
(RCH) Downstream Port Protocol Error handling. The current implementation
is based on CXL1.1 using a Root Complex Event Collector.

Rename function interfaces and parameters where necessary to include
virtual hierarchy (VH) mode CXL PCIe Port error handling alongside the RCH
handling.[1] The CXL PCIe Port Protocol Error handling support will be
added in a future patch.

Limit changes to renaming variable and function names. No functional
changes are added.

[1] CXL 3.1 Spec, 9.12.2 CXL Virtual Hierarchy

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
---
 drivers/pci/pcie/aer.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 34ce9f834d0c..0e2478f4fca2 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1030,7 +1030,7 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 	return 0;
 }
 
-static void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
+static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 {
 	/*
 	 * Internal errors of an RCEC indicate an AER error in an
@@ -1053,30 +1053,30 @@ static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
 	return *handles_cxl;
 }
 
-static bool handles_cxl_errors(struct pci_dev *rcec)
+static bool handles_cxl_errors(struct pci_dev *dev)
 {
 	bool handles_cxl = false;
 
-	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
-	    pcie_aer_is_native(rcec))
-		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
+	    pcie_aer_is_native(dev))
+		pcie_walk_rcec(dev, handles_cxl_error_iter, &handles_cxl);
 
 	return handles_cxl;
 }
 
-static void cxl_rch_enable_rcec(struct pci_dev *rcec)
+static void cxl_enable_internal_errors(struct pci_dev *dev)
 {
-	if (!handles_cxl_errors(rcec))
+	if (!handles_cxl_errors(dev))
 		return;
 
-	pci_aer_unmask_internal_errors(rcec);
-	pci_info(rcec, "CXL: Internal errors unmasked");
+	pci_aer_unmask_internal_errors(dev);
+	pci_info(dev, "CXL: Internal errors unmasked");
 }
 
 #else
-static inline void cxl_rch_enable_rcec(struct pci_dev *dev) { }
-static inline void cxl_rch_handle_error(struct pci_dev *dev,
-					struct aer_err_info *info) { }
+static inline void cxl_enable_internal_errors(struct pci_dev *dev) { }
+static inline void cxl_handle_error(struct pci_dev *dev,
+				    struct aer_err_info *info) { }
 #endif
 
 /**
@@ -1114,7 +1114,7 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 
 static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 {
-	cxl_rch_handle_error(dev, info);
+	cxl_handle_error(dev, info);
 	pci_aer_handle_error(dev, info);
 	pci_dev_put(dev);
 }
@@ -1494,7 +1494,7 @@ static int aer_probe(struct pcie_device *dev)
 		return status;
 	}
 
-	cxl_rch_enable_rcec(port);
+	cxl_enable_internal_errors(port);
 	aer_enable_rootport(rpc);
 	pci_info(port, "enabled with IRQ %d\n", dev->irq);
 	return 0;
-- 
2.34.1


