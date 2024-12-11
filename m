Return-Path: <linux-pci+bounces-18194-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C349EDBD4
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 00:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7C01281A3F
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 23:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375D11DC74A;
	Wed, 11 Dec 2024 23:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ee2WM9sH"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5784E1F2C42;
	Wed, 11 Dec 2024 23:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733960438; cv=fail; b=OY7TIicR+X8VvQyMb4RzyqeWL0KCoOhq5Hk5ft95IZ3DosIKGdLtOcHeC5+y6rj4AR4BmfsH6aIc3b4ng8QVYAKd5nH7yjyxRWSoXUkyKgijV5zP6q8IO4whC17VHFbrD6J8HXmAPGg3Sa3bZjtC3JT45aKLoZCq8z1okV6Vfio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733960438; c=relaxed/simple;
	bh=uSrmHLRSxdHrjGSJAZAl04ChwG9kd92Li16IGVCmWcg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yl7yNsGP9TXzPKXwX2msiepThyrPJBO7K3n18z22k9TONDBVLbV+fqOkMRsEYnT9kJpl9Wmd1Gu94pdMGl6rG7K306BYfVfP+W0EA74dJWjkgKtI2t4uvPnGmiOVtvpO3B+Gn39q1Xln2ndve3l7b5Ry6tv4V6dNMaIiz9jqy+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ee2WM9sH; arc=fail smtp.client-ip=40.107.102.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZum3G0JGDLV78MyCfNF0D0FGOOcRUE74twfHzzTegyC6UrogH4JdFinnDYiihyFUBBUAx/cHVkBvZkQ5tMCwmNuhc0CuxZlNpPSePA7MP4B1VGl/rxQHo1FWUi91EzADZ5DRUPEcsjIuC3LdP5m3KAIQESobbEvImIPOahxEjMGIdTSn/Yqh2szMbqKsRbUvIg4AEQTg/k+sTBj9EXwEBGUyY1uo3LmyjhbsjvRhKuoXCXjbe2Ga5xbT1sbJjdtf0zKznZM5WRwBCFt25R05zErt6s+ppLTtufoMDjtoyFF77AeiEXZed8IPSphWGhaKjmYpcl9BHKVw6OOjaw90Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUOKviXyM0eWW7tqIyf/Iomz3+pPyDTqFmrrSIqRpe8=;
 b=uAR6WmLd/Q3HEYcgHyrEUkHeMQxF82Z9/PVKNah3T8liQjP2Q9bcRNmX9f7slNtorlxubCdqfkDkjpRaLe+JpuSfsZPUBnIwz0jSpXU7lBxNiQQFiSbCApPJMn6gy8XgjeXoE5kpJ+kPGN/Ky4l4xZ6HBLfLy9sDhmMReqpjX+/ocJVnIn3e8ZeEOWa6dkDZ8Z1W44VUNjQ/YAKsUcC3ENWjPc6oyUtxzclueVnFYxt051OpxgGQ7pvwy3kixbOdbbXHBTEvo7IIMqW//0sx/GPVFERogXuEUTplGMg68S+1jnboEYdBiI2lZnE/NfIUGfC5qlj3tBFe3wGjVpd0cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUOKviXyM0eWW7tqIyf/Iomz3+pPyDTqFmrrSIqRpe8=;
 b=Ee2WM9sHRd4ZVjYsxuxG4+M+kWt7+hgT0ctrbzhKLh0YnmABHvS+/mMHGfzgDTi3x06sMh4BxKCP/VGR3aQzPKzQJsr+fLrRgKiWaX/J+rxQT7EApjbLiYNo6eU3ICiMYnbHYIx2ngtQOQS4Vo9WG1ZWLqTHzzGrshZwZ4oBkm0=
Received: from BN1PR10CA0018.namprd10.prod.outlook.com (2603:10b6:408:e0::23)
 by PH0PR12MB7012.namprd12.prod.outlook.com (2603:10b6:510:21c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 23:40:31 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:e0:cafe::d6) by BN1PR10CA0018.outlook.office365.com
 (2603:10b6:408:e0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.14 via Frontend Transport; Wed,
 11 Dec 2024 23:40:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 23:40:30 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 17:40:29 -0600
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
Subject: [PATCH v4 02/15] PCI/AER: Rename AER driver's interfaces to also indicate CXL PCIe Port support
Date: Wed, 11 Dec 2024 17:39:49 -0600
Message-ID: <20241211234002.3728674-3-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|PH0PR12MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: fd267213-320f-4e58-e782-08dd1a3d32fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sXsjmK1MzP3FY1RfxL9Gn32eklxQUUn0GZNq/FjB3fONGaoof0z4CwypFyG7?=
 =?us-ascii?Q?rWZwLh4APKBQYevZc6C6oBEBzMWusvGz9v/z76TupJk2keZTBU4eTdMSrZ67?=
 =?us-ascii?Q?sqSpOIz1zk6zNA0R9Eyfo7E3I0oFGOHerj6/S79m42qRN+Y9ISnNaXiKb6fp?=
 =?us-ascii?Q?vKqv28HX1ZIHEqUhGm4uhJdctBEVYnerYZ5Mvk+kzLTooe6IAxqAhDZp3wjI?=
 =?us-ascii?Q?9Tii9W5YheyiZhC/PXWkafHiGyDu+MC0mG5u4QmjfzC6+wXCV5/vBQTO8cy5?=
 =?us-ascii?Q?NgBXKNUvnCupEtpA1ezY8RlId0SIUM2j4EPz3Jsd1cB/HlksRfRKRAy9F4Gx?=
 =?us-ascii?Q?hRM0zzoTZu33PrtJjDYIuchMazA83gVFENwqv4ATaSmlIyrhn8BVtoHd2+af?=
 =?us-ascii?Q?JudT3sRiUDS230tJuhIFiUV9Gwm0d8eC8cOX54GNoU4Dwc0yIY0IF/6PvaP6?=
 =?us-ascii?Q?O4pCZsQPlaM/HFIWwxnwaSVdeYjdT3bqwreuHUfalOCS53DDvck/X5OwJFyY?=
 =?us-ascii?Q?FCoybt+ZC7bh+iZII5wQbXG2FE6FQaDdFxy7iqmoo6S7UfZZci3isJJoAXtr?=
 =?us-ascii?Q?xTwBuS3wYl/HMd3zzkLeJgi16MWuIjU+aft4XsrX3KWMk1wBaTKuTGFiU99j?=
 =?us-ascii?Q?xQWULQFTIICFpUySlqQeRTbg7HpjEfd9X1SRQ5yoWugk2nR1p/45iZF8zwwq?=
 =?us-ascii?Q?bmfjSAbIF6nVXrU06TJ7vkL2B0/7oQX3uLKDpzzEeuEPIe5yolPd6VkolJ68?=
 =?us-ascii?Q?pBFVoxtbPJQflh/oQvdKvT4THeoonAlqbje1VJJgiu6njHJ42eiKADIMQ6TM?=
 =?us-ascii?Q?E9u0RSnUe0Y6r5iOksX+oTwXbFtXVShIKIW9pyc9oHviDCzv5Va59mVsbu5V?=
 =?us-ascii?Q?vhLicK/jba7LaM4c4apej5kpNmiMFXa/rmjv144+Oq1Zi8cdULBm2QIDcPUb?=
 =?us-ascii?Q?wNxreycMRMsfLk9QlToQWXix8dtgCLkcOoAb44tyyBAe+WNnFCkuAmiJDB/N?=
 =?us-ascii?Q?9r2F4RJQmzuwoJ/Zg3SZJ4F9L8U512wIWlNvPbh4HR9qTCMo8U/EJHtXcwnf?=
 =?us-ascii?Q?fZRuS5NHsgcmD3pzvHmBYxSX7jhuS1eDq3/CrZP/TNNrCFeCL//ZBduGVNjq?=
 =?us-ascii?Q?aXLf6R1fzkLh2B/gnWtMQdPoJh6mXr4iBtMwNJK6HgHs3ATZn+sfstb2feR4?=
 =?us-ascii?Q?6L0NzKlKCB0DyrbPie3R6f7289pRZhbLKw53nTr7x8JQbFWXxaxRwUPytYbX?=
 =?us-ascii?Q?jT3Mj9IWQjRUhpUegCpeKucF9Z0bswELS6uSxnvtysaFpNVRkjY3YOQtHnam?=
 =?us-ascii?Q?i7Q2cdwRkJzQl1kJz8IBV5oOyj6kee8oxCUyMgGAfqheznZ2WWt5Zzv6Q5mQ?=
 =?us-ascii?Q?OF0e5+nykeNEwCoKtZj+j/4omNJJ7fpYZC1GtWgZ454xQK0hmX1e62BzNOiw?=
 =?us-ascii?Q?NbTGbhTzu331XWye6Lm8/qHFT2QM60rx6ujWoXFdopf5FyoZhw0YMA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 23:40:30.6550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd267213-320f-4e58-e782-08dd1a3d32fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7012

The AER service driver already includes support for CXL restricted host
(RCH) Downstream Port error handling. The current implementation is based
on CXL1.1 using a root complex event collector.

Rename function interfaces and parameters where necessary to include
virtual hierarchy (VH) mode CXL PCIe Port error handling alongside the RCH
handling.[1] The CXL PCIe Port error handling will be added in a future
patch.

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
index 13b8586924ea..fe6edf26279e 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1029,7 +1029,7 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 	return 0;
 }
 
-static void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
+static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 {
 	/*
 	 * Internal errors of an RCEC indicate an AER error in an
@@ -1052,30 +1052,30 @@ static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
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
@@ -1113,7 +1113,7 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 
 static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 {
-	cxl_rch_handle_error(dev, info);
+	cxl_handle_error(dev, info);
 	pci_aer_handle_error(dev, info);
 	pci_dev_put(dev);
 }
@@ -1491,7 +1491,7 @@ static int aer_probe(struct pcie_device *dev)
 		return status;
 	}
 
-	cxl_rch_enable_rcec(port);
+	cxl_enable_internal_errors(port);
 	aer_enable_rootport(rpc);
 	pci_info(port, "enabled with IRQ %d\n", dev->irq);
 	return 0;
-- 
2.34.1


