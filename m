Return-Path: <linux-pci+bounces-24804-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCC2A72869
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 02:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCABA1B601BD
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 01:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CD61B4244;
	Thu, 27 Mar 2025 01:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mpYMhkc7"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81B71B3929;
	Thu, 27 Mar 2025 01:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743040095; cv=fail; b=oE/LHcSFcZmGdAmjCsN1FCSJOlCIEoN+af5ljTd0H5HHpIm1Yh/jSb5vGPKYrOzZXek78XghpqWaDj83h4S2UgX1XF0kF4Hsbfxlrou2ysjCigPOVyVYDXF70I9OG1+0MYXVvaG6WJETAyjvWmCZENREiYFuoIt2XsSn4PSb2S0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743040095; c=relaxed/simple;
	bh=AFdaFQHrS8tvNKjfSBTOp0dFvzggiERR0t4JLPXh/eE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NIxRwJc27VOky2P/fYXG7N7GQdALrSnKqd54ZoQebV1Bp7nlZ1AxmlHaYLWIAmq2HquprFW3P0h/zpBFB6L0nOuDlKSy5Hxz+Q1/Jt+XW8JWMqLmbou7rr9/QBD6okmdB7PbjrEyjHYzV+iPToRFWD/FAjEAlFGw1zTEuZIhaIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mpYMhkc7; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pLe/jYrztaxFmziE43ktNQExQn+2ayTWxJjYRfaObp0EEWKH7GC/8Re7U9NBbZZrwTaPfqk/iy04xw/X6h+blTgyBZIhKBYusiD+yFS0+2rKdtzNzJN7MC93jzTSA6lZ/yCH9psR+OiF7qsTLFA50/Hs2TWc+VWYkon5y0cgszUQEqeNxsOjLFTESU+ZCcNNlScjxcMaEJEHDoYeDwY7bOzC3Kd+Lx9GD8/4JdNk7lE6bY28u5z1mfr04I8hB+AgjwRYSSQD+O0jytDZPx9xjalHkpo4WSzSaGOXBNbYqdZOxLxzLABZPJObdg9+tkJIr2E/Wp+VtSADUdn+zuS+hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+FBXYXLUNXYNpWZxDXAdJ8CY3Gp66SNMtfpYpKTCbaA=;
 b=QdabNlXqI/lkBfPYRZJKcB72e7SEZIyTvej97+CNPtNO9zOe43p8iiT9kxjLpzuliROD3QttmMXrvsVc0lJUX4sdklQdtERKUpwHwnk/JveH29Aja95skboitDisvDYQmDCstJ3EA2O1YE32mSemC+SgAhSNYUCwLgHOhE5/Yw93DO11l2OmjoQiIF2GBkVkkLY6PF0fflT6dsLQ38YKxCaGaDXVbk/2zmeIRntlcTXTs/Yb9sd/DDEtGwvFOiYvH9rbr99jROjqDhIIvW13SUqcabM5gItx8+zo0KeegGyi263NopYDrnXrCxzIMfceZ6H8YgFuWWDLOWfFCRuTew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FBXYXLUNXYNpWZxDXAdJ8CY3Gp66SNMtfpYpKTCbaA=;
 b=mpYMhkc7Fg2A4dr1/R6P8KZgKQf4J6afalfD8+f1QW/wQgE6PTP4X/EzXg+IscmkQsr1eE4FMKZP/E01vOVoWK5+nrR5cQmQ1a9WKg6e4X8YV/MveCrzbRqJaB6ExQdNvFvfqgrS7R9DhR8u3z2JkI/UPsjnQ88K6zmDXA2gj6g=
Received: from BL0PR1501CA0013.namprd15.prod.outlook.com
 (2603:10b6:207:17::26) by IA1PR12MB8517.namprd12.prod.outlook.com
 (2603:10b6:208:449::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Thu, 27 Mar
 2025 01:48:10 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:207:17:cafe::3c) by BL0PR1501CA0013.outlook.office365.com
 (2603:10b6:207:17::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.31 via Frontend Transport; Thu,
 27 Mar 2025 01:48:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 27 Mar 2025 01:48:09 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 20:48:08 -0500
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
Subject: [PATCH v8 04/16] cxl/aer: AER service driver forwards CXL error to CXL driver
Date: Wed, 26 Mar 2025 20:47:05 -0500
Message-ID: <20250327014717.2988633-5-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250327014717.2988633-1-terry.bowman@amd.com>
References: <20250327014717.2988633-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|IA1PR12MB8517:EE_
X-MS-Office365-Filtering-Correlation-Id: e2a66f8f-e99f-4ed6-b1f0-08dd6cd16daa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qk05w4JlyR6wB4EoTaSxgbzruQb8dDhNAt/ajTYcrN80ghenDcgnoo8twWNM?=
 =?us-ascii?Q?wRUUqV8vnVIyYCVUE+DeVkRLI0DuaAB7CXk+Ol7uAKew/3WgPPioavVdgEym?=
 =?us-ascii?Q?YqEL79UAquWFWffCKnUbnNFz1QnRDrBDxHNcR8ZJaFUpMvBmfJeWPTAIHg3k?=
 =?us-ascii?Q?ur/BKopcCXsVc5CHrjWc9cShRESRieb8j0rXurUwzy6FagSOWD6NjgqKLkf3?=
 =?us-ascii?Q?LS/cwZ4YqI6d8ANnn+xVjChN8cuZdI4gVa585qkKGmt1JC3V81y0jognK8Ae?=
 =?us-ascii?Q?Sav1nawZR8dS60VWip61JlGC8E5aUu+yENtytDqNGaWERbcpL69iasK/oO/0?=
 =?us-ascii?Q?0w/lDjkkug8IfjFQzxAN0iiuL22WyEYRTIgFpnPmEet4d85gMlr97NdZRgur?=
 =?us-ascii?Q?1dB2D2hKbMsPa5gQJRIlYE+LAiCZK4l3vrCqjTieD5gpy0tL9NA7nFfGva+E?=
 =?us-ascii?Q?g/cgfhtvdv9eqwhipjtVNzX9wzvL3Jv24Ecz9k3mzVPaolOs6BLJMNmZVpo/?=
 =?us-ascii?Q?6He+o3RS00628Mgd0iU7C1Cg5CrseEsjEYFrNhbm3yShv6LZqM8EM+pLICJT?=
 =?us-ascii?Q?GpFSf+J+AxR96Q/s6yJK/oOCC2JwKuqsATiwPDrl54yfuKuXGO9s9M08tp6B?=
 =?us-ascii?Q?XLOfjutx8mToNCjd/l8Fp8L3Xviksiz7BAJmG5DUCMHZRrqySw9WohyQSG6/?=
 =?us-ascii?Q?l+JEXF2Da3VSW1kJ9uceXgqHWQgdNPmCqIZjV2GaWv0OW4kxh4ncLY3dnFtL?=
 =?us-ascii?Q?G/pVtBJRVSYRD8WpXwhfSlx4DScz9EZun/qhg22qzKyzXQuI5+kpMRc/65sx?=
 =?us-ascii?Q?BDLaG+dGYRJH9pPeOn08wnBEgGOpy2bH/o//3PcbeJuPnpbY+m/gSyeQrdrY?=
 =?us-ascii?Q?OjXz0H6ZAOkJOI3KJJ6aNffMeTOX84j3p66mdvUS1HzjQuxVQZQwXwOrQKG4?=
 =?us-ascii?Q?5tETn8HtDTJgNQA7vTryRXUCPQZFL1zpKlGA9RXa9PnS2vwG4LXzAsJ93mX+?=
 =?us-ascii?Q?0NNA8vbE6WWl7spFChTd24KU8p2/8Qv4ANzxp0tEUfKQttKNvHmNpLlcGEe3?=
 =?us-ascii?Q?IhrJAub9iK6CAhH9ToEA18a+ouoszeZMZa00/VN3oKiTQHN7mT36Q++B4nkn?=
 =?us-ascii?Q?4Q4i0LaXikndzWt6tJlAOHUjR4vpkozMtn+GJnrhuzeUGem5i20BY+B36WcC?=
 =?us-ascii?Q?kwd2uUTKhSzTCHFAEZTY/A0z5QDwudLNC4gBhCjUBaC29RRNVOU+QAMVl0zl?=
 =?us-ascii?Q?Hi4NIsb46WCgpyNgta6ElMTjWxBu1hBz12rGbcyYa+ji1/Kau7Qe2ZiyY8ej?=
 =?us-ascii?Q?ETml8TgdQSAgfcalebcCqS2wrds0HHMGqw5ZB+xDH46KdtKvSjGcLsi9u4La?=
 =?us-ascii?Q?xPgnn/6V8LbPgNvI+XUntHYCDKX/rJ8i3myNEWH8XhEDv0Bp0VZacyAnNJRC?=
 =?us-ascii?Q?Rabk0NcPuMLdkbGrLP5T/J252hbQKHtEAHO+VoOZk2LmiqQs4k8fc/8SvPLl?=
 =?us-ascii?Q?CpYkZ3J3ZB1OIhCl+EjdVYiGrYgPxPuUMLAR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 01:48:09.9877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a66f8f-e99f-4ed6-b1f0-08dd6cd16daa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8517

The AER service driver includes a CXL-specific kfifo, intended to forward
CXL errors to the CXL driver. However, the forwarding functionality is
currently unimplemented. Update the AER driver to enable error forwarding
to the CXL driver.

Modify the AER service driver's handle_error_source(), which is called from
process_aer_err_devices(), to distinguish between PCIe and CXL errors.

Rename and update is_internal_error() to is_cxl_error(). Ensuring it
checks both the 'struct aer_info::is_cxl' flag and the AER internal error
masks.

If the error is a standard PCIe error then continue calling pcie_aer_handle_error()
as done in the current AER driver.

If the error is a CXL-related error then forward it to the CXL driver for
handling using the kfifo mechanism.

Introduce a new function forward_cxl_error(), which constructs a CXL
protocol error context using cxl_create_prot_err_info(). This context is
then passed to the CXL driver via kfifo using a 'struct work_struct'.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/pci/pcie/aer.c | 61 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 55 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 46123b70f496..d1df751cfe4b 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1010,6 +1010,14 @@ static bool is_internal_error(struct aer_err_info *info)
 	return info->status & PCI_ERR_UNC_INTN;
 }
 
+static bool is_cxl_error(struct aer_err_info *info)
+{
+	if (!info || !info->is_cxl)
+		return false;
+
+	return is_internal_error(info);
+}
+
 static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 {
 	struct aer_err_info *info = (struct aer_err_info *)data;
@@ -1062,13 +1070,17 @@ static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
 	return *handles_cxl;
 }
 
-static bool handles_cxl_errors(struct pci_dev *rcec)
+static bool handles_cxl_errors(struct pci_dev *dev)
 {
 	bool handles_cxl = false;
 
-	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
-	    pcie_aer_is_native(rcec))
-		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
+	if (!pcie_aer_is_native(dev))
+		return false;
+
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
+		pcie_walk_rcec(dev, handles_cxl_error_iter, &handles_cxl);
+	else
+		handles_cxl = pcie_is_cxl(dev);
 
 	return handles_cxl;
 }
@@ -1082,10 +1094,44 @@ static void cxl_rch_enable_rcec(struct pci_dev *rcec)
 	pci_info(rcec, "CXL: Internal errors unmasked");
 }
 
+static void forward_cxl_error(struct pci_dev *_pdev, struct aer_err_info *info)
+{
+	int severity = info->severity;
+	struct cxl_prot_err_work_data wd;
+	struct cxl_prot_error_info *err_info = &wd.err_info;
+	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(_pdev);
+
+	if (!cxl_create_prot_err_info) {
+		pci_err(pdev, "Failed. CXL-AER interface not initialized.");
+		return;
+	}
+
+	if (cxl_create_prot_err_info(pdev, severity, err_info)) {
+		pci_err(pdev, "Failed to create CXL protocol error information");
+		return;
+	}
+
+	struct device *cxl_dev __free(put_device) = get_device(err_info->dev);
+
+	if (!kfifo_put(&cxl_prot_err_fifo, wd)) {
+		pr_err_ratelimited("CXL kfifo overflow\n");
+		return;
+	}
+
+	schedule_work(cxl_prot_err_work);
+}
+
 #else
 static inline void cxl_rch_enable_rcec(struct pci_dev *dev) { }
 static inline void cxl_rch_handle_error(struct pci_dev *dev,
 					struct aer_err_info *info) { }
+static inline void forward_cxl_error(struct pci_dev *dev,
+				    struct aer_err_info *info) { }
+static inline bool handles_cxl_errors(struct pci_dev *dev)
+{
+	return false;
+}
+static bool is_cxl_error(struct aer_err_info *info) { return 0; };
 #endif
 
 /**
@@ -1123,8 +1169,11 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 
 static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 {
-	cxl_rch_handle_error(dev, info);
-	pci_aer_handle_error(dev, info);
+	if (is_cxl_error(info))
+		forward_cxl_error(dev, info);
+	else
+		pci_aer_handle_error(dev, info);
+
 	pci_dev_put(dev);
 }
 
-- 
2.34.1


