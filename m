Return-Path: <linux-pci+bounces-21196-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A59A31553
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 20:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FFC07A3586
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 19:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6DD265CDD;
	Tue, 11 Feb 2025 19:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Wf9SgQxm"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1328A264610;
	Tue, 11 Feb 2025 19:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301952; cv=fail; b=tun2Jcs6JyG2QBCaqmLaWOUBMj+PW/9lVfAhSGTvwVCur2Qumr6aa8To7r+DSzrSsmXo2HdIBYwTRtQrTdXNJSYQdUlgUA+TNCghWtSGEJcRw9cQoFeZXtmImPQKpU7EEOJKYnSthDHJPQQv8SfwU1ED6B7qWdX7q531ehHrHr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301952; c=relaxed/simple;
	bh=3XIhvjON4XR0FI4MHHEin49mn/BO6Sc/RiBUFq4Ilqw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sP/KQ7anzsaDdZLiZkhMj7FSDhySAvHZHALcoKF0FcV/QVKCQJoj+/TvWGcPfxBVw7wG9YWku+3l1lkFz5RIfTm+enExRQ524kqfE6TqMmPhybDBKV+kAnG5iSwqGFAktzAu7yLK5tTOZl6HDmss9Qhawv+bT9b241yLfL6obT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Wf9SgQxm; arc=fail smtp.client-ip=40.107.93.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nz7RduH9ZSa2CCrbB2MiLbtEHS4+Y/y3AZGPM18nBTyoA8dQI4dMQ+tZaXM8AoAOjkSd6jd9FZcfcFdF1paYSI9LDcg3ZpCVMf/5wJv7QQyiwuLAEwQWUFkvAyhZMfiFVwDp2Z9y7g7wQjaPea1J3D89Z+LNF5toRrr258+0HUiJmbg9qmwUJKvMLabyVHSyGmWomsP7Zlqkv/WKm8ul4OlsVp4gXI+jdOUjrQQBS+6aNQaioiKpPS97SEhNpHPSc3/K8dTLp8i16CmzFPISSkAWmstxSaj8yIHepnfxZz9VeKlxDKRwI/+6SAUzWbMKNhMHYNMf/AOoAyBveyId9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7+mLT84vAr8qzYauP+ydKlX8aq19/rIoVsgMdLxc/g=;
 b=wmQYifrXw0GUA9svsQOcaPyr7ZNQHvhVZF1d4HswVmIcOK5YzA7ms4A+/B3k91FlyG/HjwuUpSVfYWSDNl6MwY4ACrxmE7Lpr/KjwOC5UxKaz+rPxesmJGY6FQv3dCKGrgPnEBM8vYTiQ3GMSBcFEKrLsO+gX4UFhaCCQBEUYl1BPb5wZKkpcZtEzzSnGJBr5xTHL5HpSa7VqlFYwdsTKK+TTHPsUv+Iobwt3Q399jWcTEnYoAssltaTxdU3uRfiGbl90ahPVPt4bNMru999zi+iuCc6Ad33YMs+SRCsXdLLgi3QPLD4FPAMhcJPXKdKvlYH2Dokbw6JYshLH3J8SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7+mLT84vAr8qzYauP+ydKlX8aq19/rIoVsgMdLxc/g=;
 b=Wf9SgQxmVGUY+jj3HrSj5OEUyrLINqqHSLMUgarRXk8DdQ+crtMP9TI7xFxYaczCtTn3ukrfuWm5G8Tsv8QgWmHz5z7tJ4Envn4TxJ01Hf9mrZYB2L/fmnt6PFgGNWCG4HhAs/y5QssI/Z5Ifj8AaeQUvMfPTNyngUiIoYgT4wE=
Received: from MW4PR04CA0244.namprd04.prod.outlook.com (2603:10b6:303:88::9)
 by SA1PR12MB8841.namprd12.prod.outlook.com (2603:10b6:806:376::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.17; Tue, 11 Feb
 2025 19:25:47 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:303:88:cafe::fa) by MW4PR04CA0244.outlook.office365.com
 (2603:10b6:303:88::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 19:25:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 19:25:46 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 13:25:45 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<ming.li@zohomail.com>, <PradeepVineshReddy.Kodamati@amd.com>
Subject: [PATCH v7 05/17] PCI/AER: Add CXL PCIe Port correctable error support in AER service driver
Date: Tue, 11 Feb 2025 13:24:32 -0600
Message-ID: <20250211192444.2292833-6-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211192444.2292833-1-terry.bowman@amd.com>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|SA1PR12MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: 043a93d3-b081-4e2b-a178-08dd4ad1e2d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yUthq4pTQI3+ubJaeA/rIyehAm+G+2FOFpmfrmZyk4FicttkOvQDPHlrnYqq?=
 =?us-ascii?Q?e/ziFR7lCSgNTmbPrTIB+akQiHkS1YFiou6vjI2U4miejW2FXzPAe61uzbZY?=
 =?us-ascii?Q?ZGsYFfsU65XfP9ObJxZ0vHgtkw2nYyjHwCR/J6equFpdLIUSp+Qx/4wNOI4U?=
 =?us-ascii?Q?rbozZ4JoHbGC+ltsjCJ10Mt+vOcE2VkibJJluTrWaTWtwnzTPWIq2d4MPYai?=
 =?us-ascii?Q?u1/L1ImnhLvQV/09dl1KxFIJhGYgTmWtCGbwnVXoiA/6bj/+bptZEr+MndHc?=
 =?us-ascii?Q?mxnP6uJFsKdihxwKtp5LakzEVyo0J7l33WCBNxSm6b++zgErVivzyoVzshiO?=
 =?us-ascii?Q?/vltAzsxJDUfjhAtUN+pFgwh/hSstXWhrXLV/MNz8l+sUPDW3GIkkj65inE2?=
 =?us-ascii?Q?SuFZePvwXI41BoP4H8dD9n3dplNwa/aLMciOaR+DIeRQ65UaHisnkN1l2P5i?=
 =?us-ascii?Q?GC5/uVgJBZJ7YjIIOhwk39ez0GhKyjNgv5dKxsaegtLV0B4efbMFcrhlFdvk?=
 =?us-ascii?Q?Hpk8sX2mt3izZSi7DoHe0PbUGWXmOOjuPrqFIL2j9wvHpOt5n5nfFfussIhD?=
 =?us-ascii?Q?fCD/qxvVVHvolYgXF846CXubBCIUYY3JQHNCPFgYIpaPw0fAQ4pmO4C8yXpv?=
 =?us-ascii?Q?K6IENx4T2aYU21ZA6h0PTqfqfMGBrqEGll5QAQ/LOK0MmPYGV9GfWTGMmE4+?=
 =?us-ascii?Q?8e6M2eP/OlB+AeeEanI7bDxaTx+jYztj+wTXfVyR061HZ0ojz72erYt1bcls?=
 =?us-ascii?Q?g2D1jZuWeIptwoI9Y++xia5IW+04L19P+3TkyXO+3yNcMEzzdMxg/s6nd9dc?=
 =?us-ascii?Q?iRDqgsXl82aHNe13g+qNRhRXrkk2E1C8AdENNHBye6LiKWSOrcOes1nGr6yy?=
 =?us-ascii?Q?Dj5Nqq9YLsuGXwvA44BPy8yAmE5idZ0RLWPxn7tjJDZdl155Sdw7foExDOEC?=
 =?us-ascii?Q?YroLA71ynCAml0GhaTftFPJif/obbqGotxzGx0tBRJITgwTDm65uG0Z1/QVn?=
 =?us-ascii?Q?uA8MtABi6L4ymhfgMJnZbU2HPxfbxUn5/3oJP7LtUNKVExQyaM1yKuT0FgXc?=
 =?us-ascii?Q?7pAWgwpa9C/Gk8iZYApjV1gHza3szDZUVCS1nsUvAVJCi3A4LqzxJDOLdTkY?=
 =?us-ascii?Q?ooBnSIJp+EPDgu0q1PBtjEi3BaHOcyVG3GnDVBg2j6c1aD8KUPhNsc/E6XGP?=
 =?us-ascii?Q?rtnCDuj5CB41ndizCrczLiwt0uS0DbtDSjPjDlLS1tYDQ4Lbb7l7H33a4nbr?=
 =?us-ascii?Q?WIHT1g6MltTg0k8DOu2gfWL4VwwzHv9lHxrEHjfcSIwtnHLO639t+KwvsJWd?=
 =?us-ascii?Q?6q72qxBUldTjqdKn2NGQVpJ1cnk5aH1bEndTt1GymyE3L2ohj1yJzgFRkGM3?=
 =?us-ascii?Q?IjxNZl6gbwCwDNnYr4hdBTHhw2b0M4t74M3RUmedhVQ+4wVQGsQv1XIlyLPe?=
 =?us-ascii?Q?v4Z4RtEuTQwZu8qsYSjuwvB66vkc2HCRLqyiDLeaieIz6J21I2XhgsZ+nZQU?=
 =?us-ascii?Q?0r5lAIYMJezTA6vXWn3cYgboqlXtNpw/f5+e?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 19:25:46.8078
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 043a93d3-b081-4e2b-a178-08dd4ad1e2d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8841

The AER service driver supports handling Downstream Port Protocol Errors in
Restricted CXL host (RCH) mode also known as CXL1.1. It needs the same
functionality for CXL PCIe Ports operating in Virtual Hierarchy (VH)
mode.[1]

CXL and PCIe Protocol Error handling have different requirements that
necessitate a separate handling path. The AER service driver may try to
recover PCIe uncorrectable non-fatal errors (UCE). The same recovery is not
suitable for CXL PCIe Port devices because of potential for system memory
corruption. Instead, CXL Protocol Error handling must use a kernel panic
in the case of a fatal or non-fatal UCE. The AER driver's PCIe Protocol
Error handling does not panic the kernel in response to a UCE.

Introduce a separate path for CXL Protocol Error handling in the AER
service driver. This will allow CXL Protocol Errors to use CXL specific
handling instead of PCIe handling. Add the CXL specific changes without
affecting or adding functionality in the PCIe handling.

Make this update alongside the existing Downstream Port RCH error handling
logic, extending support to CXL PCIe Ports in VH mode.

Remove is_internal_error(). is_internal_error() was used to determine if
an AER error was a CXL error. Instead, now rely on pcie_is_cxl_port() to
indicate the error is a CXL error.

The uncorrectable error (UCE) handling will be added in a future patch.

[1] CXL 3.1 Spec, 12.2.2 CXL Root Ports, Downstream Switch Ports, and
Upstream Switch Ports

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/pci/pcie/aer.c | 47 ++++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index f99a1c6fb274..34ec0958afff 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -989,14 +989,6 @@ static bool cxl_error_is_native(struct pci_dev *dev)
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
@@ -1033,9 +1025,23 @@ static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 	 * RCH's downstream port. Check and handle them in the CXL.mem
 	 * device driver.
 	 */
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
@@ -1053,9 +1059,13 @@ static bool handles_cxl_errors(struct pci_dev *dev)
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
@@ -1073,6 +1083,10 @@ static void cxl_enable_internal_errors(struct pci_dev *dev)
 static inline void cxl_enable_internal_errors(struct pci_dev *dev) { }
 static inline void cxl_handle_error(struct pci_dev *dev,
 				    struct aer_err_info *info) { }
+static bool handles_cxl_errors(struct pci_dev *dev)
+{
+	return false;
+}
 #endif
 
 /**
@@ -1110,8 +1124,11 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 
 static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 {
-	cxl_handle_error(dev, info);
-	pci_aer_handle_error(dev, info);
+	if (handles_cxl_errors(dev))
+		cxl_handle_error(dev, info);
+	else
+		pci_aer_handle_error(dev, info);
+
 	pci_dev_put(dev);
 }
 
-- 
2.34.1


