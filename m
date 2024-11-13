Return-Path: <linux-pci+bounces-16700-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A93E99C7DE9
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 22:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 387151F23E8B
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 21:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DE518C01A;
	Wed, 13 Nov 2024 21:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Da6GeI5w"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8D91632FD;
	Wed, 13 Nov 2024 21:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731534906; cv=fail; b=A4yPIkjh+7c9sNSa2nEK0cFOH7qu5wGOJ9sQpCa8h2RDVofqbGncrlCylnVv8Tw/NSV5NrURzuNnkvNVFZG5SuATEbf5TACj7N/8zX/aQ5NstJJArg3h461Di3AfdPhEKNt8FWNSI9p26NihFHNg8pc9bQGH4z94iySk45ICWck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731534906; c=relaxed/simple;
	bh=bKuvOAawmDJ2Xu+qCBccPRqWmZZbZhcVgir49OH8+4k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fwofgFrH8wCzkGLAntp7909z0bepSaM4s332sh7eRNd5xz9wmNmSeaRz0E0+Wp4sTypA+fO4FqWQBL+5GFBcYlBDXmrK3PeIQHj2T3w1T4PjlwsgYnIgRxfArT2CquNoEbvoCQ50fmfMp/FQ9yJ7Jpui+ETHuH5SW5mAk3/zpL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Da6GeI5w; arc=fail smtp.client-ip=40.107.237.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L7XNuH5ktvUqfKQbe/0eLsO9LmhCV7wqGuJ/sg+Js0DCplz4ox7Af9gF/4dN0C6+jCO0zRCAHbcsx4MZVdstX5Ey7qO1ueFAQj0TnpIxX6nzfRDU+/9qWOBOynHUQgU/GtJl7Ea8qWUzDhR2OvJ7cuz5cRm/4j+i7qkW5OE5Juhn/YElP3Mzn/JfeiJmrs8p5qk6k2m89cKli5NB1gpDLIFdFkJRViY1ORJQjpiVSwEyGlkl+Z5bEEj44z9WJL0XWdUGQbThJRjjR3i+YmrU7LUD4JoEaEGmpi28OH0w4NnUTurohVUP3RSf50kjcFF5ITvqPUBuuS6FjdRcV+gEBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3auHL7f/x2NpniRRjkJRPcWmCkxrPzcuqXY1iCY0Us=;
 b=rh5dFOpVIxirSoZJVDMBLQuSyetw+tbjCO6eKjX/6Hekp9NXianJDSKMyuxcM/T/M1jMTczcOOkK9raNEmpevRvDCHqGWNStAGDZVEqpRGiKPWS4QsEnuIU/6iOFo0xbHXJtzNmJ3Cm4YDycKKrumnosRcpeE+v1UMoaJhkZuao9ul1/Oko5A9yC9r8S7RNNDxSBoIjz/SrzCqqQixkHQo/0xckpOyrknYf6DgUFDeW2zOhHTvMxU+/fRPCiEqrdo7heC26GClbV0EjiUURTLIhTNRr5R6yA7REGCiHlvllpwtTyZNfx8WkiGWB8wxzVMFanRKCJjVex/Xpm7QrNDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3auHL7f/x2NpniRRjkJRPcWmCkxrPzcuqXY1iCY0Us=;
 b=Da6GeI5w1Ght/mBTglO2LAV88OSxBf9H6qFMNtBGMEAdvWr0KvxfqSA49EQlZPLX1FF7t1ASCBYzLtEhS1tO+jxE2ywW1WzxCJ/t5VpwJXv0BUWRud1GbHiNDBySK+yQrSjhRaah+xfsxCGyuux82G0fmiQTsf1lDP9KxWcZ0zA=
Received: from CH5PR04CA0019.namprd04.prod.outlook.com (2603:10b6:610:1f4::8)
 by IA0PR12MB8350.namprd12.prod.outlook.com (2603:10b6:208:40d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16; Wed, 13 Nov
 2024 21:54:59 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::42) by CH5PR04CA0019.outlook.office365.com
 (2603:10b6:610:1f4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Wed, 13 Nov 2024 21:54:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 21:54:59 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 15:54:57 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <ming4.li@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>
Subject: [PATCH v3 02/15] PCI/AER: Rename AER driver's interfaces to also indicate CXL PCIe port support
Date: Wed, 13 Nov 2024 15:54:16 -0600
Message-ID: <20241113215429.3177981-3-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113215429.3177981-1-terry.bowman@amd.com>
References: <20241113215429.3177981-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|IA0PR12MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ae6873c-eeb5-4031-f0fd-08dd042dd1c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+WV5TL8dvVeeGMgyyBZyPuiYRKM4HK2Kt6iS420VoVjgK9NiJmZwB9kXt+Ct?=
 =?us-ascii?Q?rAhRZHZQMKKkcnDpUlpVxSLaL0kRDHkqB9nKge/vetZ9/Ukom2UK0NRqRpo7?=
 =?us-ascii?Q?K8wsR1/Ixu6kWua4L+saNPWLgv0gRsNnZJo1mNqVAmkd5UOQvY/5QwkLbbRv?=
 =?us-ascii?Q?0764JxiwGTeVMARIxRbTFAu+dXS/+Lfzr4m2972bJPSY5fGRwkyvGKb7e9aa?=
 =?us-ascii?Q?uEwrO84romwWdubIIh33f1mnREEJCL7gTKjXPnYbC2wUlfIrxW4ByYFpREQ/?=
 =?us-ascii?Q?0THzz2/5DA7XvXLlA9M3geeXVoEyHBDZ3fIESH9gvKBSHISspglV2F4oJOIq?=
 =?us-ascii?Q?T/PfoRrsFJBaAaoR1lhM6w058OU2BnkDmnikAoZ0D47k71AnpxvuMs3l0jQC?=
 =?us-ascii?Q?QT0ZB5+6yEBLUQFgQ39MpvrzH1Omrhhu2Sfo1tf+ZMK0n4obxQ6eGdXmZzzg?=
 =?us-ascii?Q?3bERduoYSSRVQHXqWZXt2bl4to1R/Sye22H7ghjYPVuAZOdzenv/dj9JHsPu?=
 =?us-ascii?Q?hsjG9hbzE5dQjBTA4czNF6V3fTvDghwwJBH9GCHmm8bHbJe0mgvr06GPaHlN?=
 =?us-ascii?Q?WLAzB3rJJHO/tYpOSE7uuI4FxtOiaOKOqeUZ1OQ2cUiYdQUIkRXwX/cCPNPe?=
 =?us-ascii?Q?yud26rMf3Njos9s1nEw3zXCuKRJbP1B2E7v8clf7h5a5jyTHYBvVcRseQzPv?=
 =?us-ascii?Q?wyUGK1TnAHZtV/RtGrGx0JGZd/pYCDoMAeRChj+3m1fC1l9WQF404szJ7uNn?=
 =?us-ascii?Q?AU1GLcKodGp1rsVVcNiGueh1wnQtHk0AT7hzT7VfdFoIlekWy4UBJlS5opYa?=
 =?us-ascii?Q?jB7VMEPGQxlg82DPyNoGqNqvqt49xbYcC5DBY+NtfyUxceFOKOhI+myD1fLo?=
 =?us-ascii?Q?rWNj74eclFGQjmxg8i2H7Feszxk9MIj3PlzbgWc58CiCu/fHFSvk+LZeupOl?=
 =?us-ascii?Q?2q77skdpVd323bOQRHy6/L1u9TjAMdL+c/am2RSzBdtMvJpFkXZ9QxSo1ul7?=
 =?us-ascii?Q?+4bRC0ECaTQLBG0NvPXMGNaYD2l7Gm6xKjjVVKuByZxynvS4nj7zcsLfEA+t?=
 =?us-ascii?Q?MaxTki56NYXbWJAFezTtkTbD/SQpUQZ34hfDkWByLjef3hweuqwSvcGhEiZI?=
 =?us-ascii?Q?QyHF/eMZRG2v/5VwlyBUtLz90Mni1kjKiCKzR3+pfAObnAaCpB0uj7SgEndF?=
 =?us-ascii?Q?h+r1OdCRWkWoR/PIC7mMHArlEEWjmZhclYaAoL7vJyfEMH46+wLJ8BPryXFF?=
 =?us-ascii?Q?OT8j/xVsg73H7AzAdH1v47GsDgz3q6f8f4l2uHgw8+BYA7nnzW/V+jzeXwPO?=
 =?us-ascii?Q?5PcHaG6XAwKOAnXovhpPSTjKH9JwjFdaFTEpwJ/fhICczqSe0HH4qbhxytF4?=
 =?us-ascii?Q?ien0dgjp5DAFoiWaNR4SQ2yh2KhElHa0cG186FZtlQxFhuGrOIamMe/d/F/3?=
 =?us-ascii?Q?YurZ7goWBU0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 21:54:59.2828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae6873c-eeb5-4031-f0fd-08dd042dd1c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8350

The AER service driver already includes support for CXL restricted host
(RCH) downstream port error handling. The current implementation is based
on CXL1.1 using a root complex event collector.

Rename function interfaces and parameters where necessary to include
virtual hierarchy (VH) mode CXL PCIe port error handling alongside the RCH
handling.[1] The CXL PCIe port error handling will be added in a future
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


