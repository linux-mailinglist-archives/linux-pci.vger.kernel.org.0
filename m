Return-Path: <linux-pci+bounces-15353-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B74CB9B114C
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 23:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 216BBB2391A
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 21:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1A120A5D0;
	Fri, 25 Oct 2024 21:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BccFQ+Nw"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5412213151;
	Fri, 25 Oct 2024 21:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729890219; cv=fail; b=VR0N0uoX3VuLxF8BSfoqRhPx/8U/ROcHy+YFad+JdtB7Tfz43Eu/ePkJHVHKAOaYQLeglNVND/eXqAB9fZ1AQHt9h+VNnmuVUcEtI+lmwy7jOlcRj+DJyreNNQLOjoluGjeCmnOCrl+JZFJ6p8LBKnImi+8ugFXsPAkH91v0QW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729890219; c=relaxed/simple;
	bh=ZRjSPgJaRj8iM0kkHzcemktnD0wdGXJbBRFDp+JAWac=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UCMzevSbN0LR3kWJd3ZbJHI1DFrdEJr+1Kp7PBo2Bv/SHZVn4s4oQKjp7Z6LqFUQHl+9Oi79+SB5DwCljrn067n4/3ZzIuBqskH0IRJ5B5+stai5WEJFK3S4j5dNWwcIeD/JOrhcQJI2PfkYoIOZJ1Nb0lDL1zpY0LN1aJmOwME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BccFQ+Nw; arc=fail smtp.client-ip=40.107.243.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HiVR1Rw5zqZCp5L2OkaqSJeBQ/C1636EuahpJu04Mgpl4bap+xEAkTSO8llg6rbJQsvs4SQwLzytaE9ZEAC14tO9r6UjNlQJ6oF8QaLfJ5elANee+PiFXf0NC9JBO/qHpq71osTcrYtsjRk/jtLVkbaWSTBuMBPYsMTJl8QtTJU6MNFHg4GDnrZlMf0H5f982Be5vmHSi8uz2RU4e/GC65F+xA6nCYaueupR0jk6rKhYZy32io2k0JLR51KvlioZyRpz98ixYjfElQapHEjBhlfM/rBl2xlmY9SvqpxUmXQGXRF4Gv0aW63Kn2k5qKPcIERKhuthtqkB5E48FVBkvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f979xuoLj14M6SqZv/ifTTpYtrTRQNtZxsdcLjh7Pgc=;
 b=c4vNST/sxxTX4z1szsfVdzkAupfbIzA4zxMuR6Z5suVFclveS0cF8tpPTqJ8rCkhMHSr4605npnVey5XFU12U8NWWTinPu5ZaABzuQHPK2OXIN1b9Mjn2b8Q9ylvR++FuaHcidcbdevoAcBPfSNIM0QCNmP5b2IzLCget2AaZNJrFGzwtXb5k8X/LId5iq9DMhxpcGmbySUFbQXaReEqN8zHF/sspi4tRMs6i2rfC21Mn/JGrJXHNFEYMwNNsiVoZfv/R4LsSimzAKRIb+Osu2iecjnt7AQFi6qGFd3HNphZ5Blw+Z5gPENxBOGWvTP7+WxibNXa6D/wrA+aM3ywhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f979xuoLj14M6SqZv/ifTTpYtrTRQNtZxsdcLjh7Pgc=;
 b=BccFQ+Nw9WRl8AdnHy1PBQcAogGmeXS5on6mCTlajscaAbhCsf+a6bOUBkWbkNbWD/mMGeluuYw5P0uPBChxFVsyc2g4Bes2Khw49CxXj2eSP7UfgFp4lbZL/uPcAE5Vs3b4MZa2kwxqH/JzAVGGJ+qS/u/5QxrcqgkSaMRBI/k=
Received: from MW4P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::34)
 by IA0PR12MB7650.namprd12.prod.outlook.com (2603:10b6:208:436::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19; Fri, 25 Oct
 2024 21:03:34 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:80:cafe::8d) by MW4P223CA0029.outlook.office365.com
 (2603:10b6:303:80::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18 via Frontend
 Transport; Fri, 25 Oct 2024 21:03:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.0 via Frontend Transport; Fri, 25 Oct 2024 21:03:33 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Oct
 2024 16:03:32 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v2 02/14] PCI/AER: Rename AER driver's interfaces to also indicate CXL PCIe port support
Date: Fri, 25 Oct 2024 16:02:53 -0500
Message-ID: <20241025210305.27499-3-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025210305.27499-1-terry.bowman@amd.com>
References: <20241025210305.27499-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|IA0PR12MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b013aa2-16b4-4eed-e49b-08dcf5387cdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sC4UbLSEZ0+A2kbIcgZ+KGKhGncAi0E5Z5zIbLMTLOQKH33NhBmEJSDOhLih?=
 =?us-ascii?Q?VT96uQesz6VQIXcoDsV3kip26m8YyjnSjQgnBZePSExNginrMg3KECe10cXu?=
 =?us-ascii?Q?4XJNaI3WBuedg6A4nnt/3sJDgf3eOzMx0KYgYIJHYQH6wbQwvebA3c4p6/kz?=
 =?us-ascii?Q?PFGssseh1mmUXPo+R9LYZLasZ/iHLZe9QeYsg4Ktw57XpTC6L0LS0gLDBSiS?=
 =?us-ascii?Q?Mwb9g8S/yQZ6JvNQjWi237FjaZ+8F2DVwNfPdE96k+a0B0j0NTXTFYQO73RX?=
 =?us-ascii?Q?vUutLbPQ6JL0ILAwu0Q0E/K21tu0+W73rX06A70BRjq5yNnBI6eH7EF3qi3o?=
 =?us-ascii?Q?kLKn/5mY9zdjb9FcC3q6e3oK8R4PAxl0MfHYIfGEBUMao/8PC2NTV5NrkFZD?=
 =?us-ascii?Q?5OS46/F9U9SDroo1QKoq3LIsVOB6stx7k/s/JujqTB7Ux9AUBHCUEXNLq0Ol?=
 =?us-ascii?Q?Ouw2h/KH+RVE+7lQkPlmMKKYgWIyPDbArmsrgzo+DmlFEGoYqyEhbl2AjbHE?=
 =?us-ascii?Q?btfBehI7DlfZM0qwVhYLs539EBX57mDZWRtMs/8BbIgDtliKZXvaUtRhYzAW?=
 =?us-ascii?Q?aXg8Osyg4uOCx0eWsbc84zDPFGQhhqc3WHHnbmrN/Omy9u83/JRWhBICR2hM?=
 =?us-ascii?Q?AJvDGpGfZd0mqYMq6Xm3Yce12Yzu2E8JEQ0kby9BrMqwh377DtQjmX1s9TQe?=
 =?us-ascii?Q?Ex9QTedeK7q+9USpMlbSGuY4O6LQuMCk4or6MEdFwzTxqnm8qseUYdiVvceT?=
 =?us-ascii?Q?ZojXknpaRG+fiB4ZLW6NUhZzm4AHLoLawsX8Vdq+uJmd1h7/baMK/xjlthC2?=
 =?us-ascii?Q?reaOLrdw5+OaNdjg2Q79HgQaZRk8sR7QCQEqWwNghCzjc7EX0Psb5m27Vgcz?=
 =?us-ascii?Q?pYNIKjLCSric0pGwM0+SsmkSZNGlhUwopUguoc4P7h5cO7DdnLOxwuyXIGr2?=
 =?us-ascii?Q?aQtj6jCkTB5y7O/irQKMiq0cS7k5oqAW0WGxi71kdbuU08Ks5Ce2Ool2wN/r?=
 =?us-ascii?Q?u0XGe8O5ZhAy1x8kBPx5yqRCaz+POUI5k6dllunroDUpLsG4JAdSsNpM4oIo?=
 =?us-ascii?Q?Snlc2Di5Sok4qyyM16ztTym9Rll34t7JXBRRMx+pJK4rSYajpBMF7rZXfSof?=
 =?us-ascii?Q?PxyWZaxd5LC0xlogQBjlHFUSvyo4RzzHDFWt0Cdios9wBTP0EiOpweuPrKzc?=
 =?us-ascii?Q?WJ/JZxCfq1E+naDMpXnkGPXvj0421rFds2bFXWVAwBMI74WXMMJ68aXdU5m5?=
 =?us-ascii?Q?0oa6AoijOAVylhSKoVEtArslnHoB4da8qKVX7vW/dmtdPKb3PenRvXgsmoIP?=
 =?us-ascii?Q?l3hVVrcyZs0iiqtxumoDP+A4PICidm/XOYry4Afzq76k2OS1FdkYMLiUiLKz?=
 =?us-ascii?Q?gacgEIsvnGkHs/lNC+DlxAxI/+p5?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 21:03:33.9873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b013aa2-16b4-4eed-e49b-08dcf5387cdc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7650

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


