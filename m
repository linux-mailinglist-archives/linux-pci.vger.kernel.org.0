Return-Path: <linux-pci+bounces-18207-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD439EDC2C
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 00:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1D91166C40
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 23:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71BA1F63CC;
	Wed, 11 Dec 2024 23:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4UZ9f0A3"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAC41F4E4A;
	Wed, 11 Dec 2024 23:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733960580; cv=fail; b=u4IQsTjjDGSSDrce84wfG+0zVoAVOQVs0PQ2F7PB0CZzICKHNAvFne9SzuW+Jyl1JE3ILO+D9pOTt5X8it+VmaE/CHDFYV2NJ/KlrafoU13eRBOU/v8yjCmgNuGkulm7mS6H2+WMhvv9zusACfX3LIT/Btan0BnfruXCTv6Udh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733960580; c=relaxed/simple;
	bh=uCaqCnoTPgDLOQvbOfPwbyeji4GQLKPQ0p+Miu4hq8g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X+GX+HFRbv/BqSGNcCY8n6lJTbOFLSXeM573CeCpIT1wu7DhR8lC6ne+t7MS8h7R3pEqX4qhr3FYSXmbRlqMSiA/PCNku/Et3R2hbMXDfztvc6zR/C9FtM2mDlpd9mSGC2ZCKGCiDVasU/zyAZ1rY+7NhASzHM3RcDn+n9kzZok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4UZ9f0A3; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WhxW9OZQZDrMUvOi0GE5yv9bOiT271o1V1V8TmmMhN7ioE8msw0Fklgq3p2ZUgKAJlKQ8FL4SlCTmuGgjc6GDTaMh7O7M6I9mf5pNTbjV+IMGddFuRTNNlQfBetOokKipo5iY9/Fy6fkUv62GzksobfcOlx6CP+vS7Yrk7gbeiaugc7xw2k/bcAMTlTzVEFYZdfHqEpCm9nBv0IZRwtM+pXoqxaGtJBFZVD0JCMqLv21r5XvMNB4pZ3exFtQGDCuPXrRJRYDc2wDvud9Z+MyPirLOG8PESNoTgSK5WRhiCG7zRsk1HPJJno4sPfPlft9n4vJHyQI60EFc8qhLgM3xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0z/PYTNRFHqOqUMGfAnfARnPvXwjXqdCcwMaFgItM6g=;
 b=sptfZ8GCqI3q0c6ejr8UHzZPrmZgCbq2ODonSKvdPuSmIchAlmKD/UC/zQS6npgQM0fEae0FDLS876aAtDb2bXC7xpA+hhaG/auB/gPMrfIEjQoLIN1HV5uW5Jv5TzbYUWXe6kKyvB6PFMJ4/foMN3kySwh+wonsNi2+3lDxN29WBGwZJR/XFnA2zQ+Xh/AWOSrtC1UL4+xVv1NiFoDmPmHtwIOd2mmDGLdYfMj6eJkbf1x+cOEfN3UQr6HZHe3ZJFDLCMyLUOCcdCz5vqMjUzFHy7V5upgii+hmcqUE7PYtSONtTKchQw1oq1c6egdUffkCn3+gqSJP1IYofXWjqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0z/PYTNRFHqOqUMGfAnfARnPvXwjXqdCcwMaFgItM6g=;
 b=4UZ9f0A31MOmUl0pARkzKWOSfQ5vmgDyLYwGsM9cBPcDW98rWEjGG+oTPc0Y223K0oLui6m2Q3M2FXCfkP8DqAEg3ewigswmqVMIL56OFkMNmwoAixjVynGCOXOyiDtuhP3eWqrwdp6j5vWBXAox9TAbWqH/2QljrGkhdceShWE=
Received: from BN9PR03CA0768.namprd03.prod.outlook.com (2603:10b6:408:13a::23)
 by SA1PR12MB8095.namprd12.prod.outlook.com (2603:10b6:806:33f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 23:42:55 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:13a:cafe::ed) by BN9PR03CA0768.outlook.office365.com
 (2603:10b6:408:13a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Wed,
 11 Dec 2024 23:42:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 23:42:54 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 17:42:53 -0600
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
Subject: [PATCH v4 15/15] PCI/AER: Enable internal errors for CXL Upstream and Downstream Switch Ports
Date: Wed, 11 Dec 2024 17:40:02 -0600
Message-ID: <20241211234002.3728674-16-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|SA1PR12MB8095:EE_
X-MS-Office365-Filtering-Correlation-Id: c8159116-3a61-493d-d2a1-08dd1a3d88da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Br6KFD+f319WNekm0CUOMALVPNEiw+2m4qD1B9JJEomu4/JyRNVa5DvoWmdZ?=
 =?us-ascii?Q?720JptDl65T5/9B8d1GodiCsBe4Ao5lNI6VM7/xCt3kuR8N/b71Uze7oCnzN?=
 =?us-ascii?Q?QhxK4D0hmbUZ8PVpccC/4q6c0QeZtYDPbtwClGUjkNXJ+n/dkwPUK+8q20a5?=
 =?us-ascii?Q?oc9BVx4o9VLO5ZlOD5of3qudDTnvk09SgoCYNlNTbFvMEy7H9xuRUiHGk3dA?=
 =?us-ascii?Q?toJJYwFfzghjqUp48+z5rDj7BbBap2/sdXF7CwWklytebGEqhf1bggsorOf+?=
 =?us-ascii?Q?On5XPgIiSiJtKOv/jetG9i1UM7YlQFptzuBpxEBeBCcEngKY0OmrCO1TFLiz?=
 =?us-ascii?Q?3ydZuBkJdRx/TAk0IFglcLVEmVeyoiYFpd6jQ9qy6s40vS5Bn1UMP1i6aHfk?=
 =?us-ascii?Q?zrjwMI+6R5Z4vQ+oY2deeNwKadd12A2C/6S0grigxEuq/YBOqcOT4Mo/F9zY?=
 =?us-ascii?Q?cP6HhFqHFLl/A8GLm9RDM8/LlKI95BJdv+H2wN6q8JFiAAi1ht69RRUga+iw?=
 =?us-ascii?Q?uEaq1YFE3y6dSoHAHOi5Fp0tj7U0BqD2vZ+Aw2Q23oJnh6gL2i1RokilFk5t?=
 =?us-ascii?Q?PEQAtoxmHRwBqNmrh2Dhp9s8TRgc037deDIFTq5mUrDbK598X6E4lqwmAhA3?=
 =?us-ascii?Q?Gp1m9kRewDJXF2UcnFO7KF2dOXrxLlQHBojRA4LZwOoJHf+YYm1TU4WB+FFi?=
 =?us-ascii?Q?HqT8CC9fuWIrV/aK+OKq3aMb2nAzF2BcGeZ8tT2r66R2tCNfB7YiQXNvFkrL?=
 =?us-ascii?Q?yAvG8wHGnMxFknONauRfd0QyUk01FYDkOW2t5U9OyJ8ibmgXrK/l+lh+AiZE?=
 =?us-ascii?Q?NsWV5LYooIiBpF8vApDspUmkLJZ0RSdLrGPOfNCWNAzn3uaWvcu9HJsC7JfM?=
 =?us-ascii?Q?PG2LTEFvcENdhg78y2eC3a/wQFV6sdQHUCfs8e0EMkQk7cQ2dsYgpdO1UGgP?=
 =?us-ascii?Q?OwkCRz7tkD55K2sL87EZujSiOzHlvhy0HNzUT4+DJ0oW7qYjDd4aBWWoatHD?=
 =?us-ascii?Q?xqaKayNJXEL2enx8pCBxmGP6pDSnWOe5iWDwNEd54WdAGMdrybCoDZuTZCat?=
 =?us-ascii?Q?k1vdcWAB7kWHpkTCxrSdwfQMVcZh9YTzNujkcA27RA/9unjEZyWtSPKAA0Ix?=
 =?us-ascii?Q?+g4Q810Pn0VOWd0FLO2hkQ1Dmt3HhBqQ16lodNDaVt0oBQUSmRzoAJIRnndM?=
 =?us-ascii?Q?y5+Ccljc0AIpBN+U0sDAB84xEcZ3RKjTSFDLRU9/g1fRg6cprYYgCfD0s5+w?=
 =?us-ascii?Q?HZBiOW7R4UzFP4jjgtdByfBI9VCDTsTz/eBu2k1MOEbiR+kWtD2wmJw5qP3y?=
 =?us-ascii?Q?4j8jvKaf1ZBIy54DUDLkL5AoR5E1zIBvzZxorja8R1WbdcysGTBcLrVbAigY?=
 =?us-ascii?Q?cbt17CSRj/20s52BvSCFqof8Eol2YpZJFiGOqgmnCfAfkFbRU2Sb/Jyo89oa?=
 =?us-ascii?Q?UBqjZM1OFyyJsizONuhK5mbFgWM+54fmrG3tnziafWODicaQ7mMhPw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 23:42:54.7222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8159116-3a61-493d-d2a1-08dd1a3d88da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8095

The AER service driver enables PCIe Uncorrectable Internal Errors (UIE) and
Correctable Internal errors (CIE) for CXL Root Ports and CXL RCEC's. The
UIE and CIE are used in reporting CXL Protocol Errors. The same UIE/CIE
enablement is needed for CXL PCIe Upstream and Downstream Ports inorder to
notify the associated Root Port and OS.[1]

Export the AER service driver's pci_aer_unmask_internal_errors() function
to CXL namespace.

Remove the function's dependency on the CONFIG_PCIEAER_CXL kernel config
because it is now an exported function.

Call pci_aer_unmask_internal_errors() during RAS initialization in:
cxl_uport_init_ras_reporting() and cxl_dport_init_ras_reporting().

[1] PCIe Base Spec r6.2-1.0, 6.2.3.2.2 Masking Individual Errors

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c | 2 ++
 drivers/pci/pcie/aer.c | 5 +++--
 include/linux/aer.h    | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 9734a4c55b29..740ac5d8809f 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -886,6 +886,7 @@ void cxl_uport_init_ras_reporting(struct cxl_port *port)
 
 	cxl_assign_port_error_handlers(pdev);
 	devm_add_action_or_reset(port->uport_dev, cxl_clear_port_error_handlers, pdev);
+	pci_aer_unmask_internal_errors(pdev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, CXL);
 
@@ -920,6 +921,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
 
 	cxl_assign_port_error_handlers(pdev);
 	devm_add_action_or_reset(dport_dev, cxl_clear_port_error_handlers, pdev);
+	pci_aer_unmask_internal_errors(pdev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, CXL);
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 861521872318..0fa1b1ed48c9 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -949,7 +949,6 @@ static bool is_internal_error(struct aer_err_info *info)
 	return info->status & PCI_ERR_UNC_INTN;
 }
 
-#ifdef CONFIG_PCIEAER_CXL
 /**
  * pci_aer_unmask_internal_errors - unmask internal errors
  * @dev: pointer to the pcie_dev data structure
@@ -960,7 +959,7 @@ static bool is_internal_error(struct aer_err_info *info)
  * Note: AER must be enabled and supported by the device which must be
  * checked in advance, e.g. with pcie_aer_is_native().
  */
-static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
+void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 {
 	int aer = dev->aer_cap;
 	u32 mask;
@@ -973,7 +972,9 @@ static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 	mask &= ~PCI_ERR_COR_INTERNAL;
 	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
 }
+EXPORT_SYMBOL_NS_GPL(pci_aer_unmask_internal_errors, CXL);
 
+#ifdef CONFIG_PCIEAER_CXL
 static bool is_cxl_mem_dev(struct pci_dev *dev)
 {
 	/*
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 4b97f38f3fcf..093293f9f12b 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -55,5 +55,6 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 int cper_severity_to_aer(int cper_severity);
 void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
 		       int severity, struct aer_capability_regs *aer_regs);
+void pci_aer_unmask_internal_errors(struct pci_dev *dev);
 #endif //_AER_H_
 
-- 
2.34.1


