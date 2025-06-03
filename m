Return-Path: <linux-pci+bounces-28892-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E86CDACCC02
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 19:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D8461898035
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 17:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6B11DDC1B;
	Tue,  3 Jun 2025 17:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IFXGR1Ri"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F23F1B4257;
	Tue,  3 Jun 2025 17:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748971438; cv=fail; b=UWzhW+V6By9hlfoJBWrjJIgjzGXsYmYCz18WEEasrf1jFsO/ZXxSG2qsMiaKI8frt2wgCQ40UDdHyh6AYgtePIocQb/98Wg/oFrIPJjVz5Kx9p+QCY6v4k6pg0tQlqVF7THvzxxpsUAUxSRxZrhmbDls+CV1VPDaFSMaV8l8gYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748971438; c=relaxed/simple;
	bh=4sWd0sMGsq9kevAC9Nw+JNtj6zs9ANYjC/48o4Hxtuo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nrs8DpxsmE+TJe9LdcSdnwt0G3ULAasCH6x7QZuyjO60AKjj35YHupp3MhrC4v6hZp0jqVWyLtYPVHvMDrqYc9iAwufIy98gNoTrJNo4DMTQ1TyS6PIfTe/Uim0ZBo20oWCha3f2UuNKTz3wpRIS5kh/koIsBY85eIQtFQkVTtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IFXGR1Ri; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhmeqFkfu2Oze24N8wIE0tiZMiMxmvY1/acSPxMFbRrmMzKhEniq/xks0jo1sBr+BhvJoljrikI2TFY4xkqy/OBl7peI4Q1JzMY26Vv1xPnxduw1iPlAAZ0bAubXeUr/pUl9bscinEck0mw9tinxm3tO9fo2Cbw9RD0WEZwy8su/ElkOofQg/IrDC1gULlQKTJVIvVwyDTOBTlXli/0nnl8PCMn+gvDjpEjY73M4BJ+T7owSA7Xvfom76uQCIxmiYrRYYzdZ7cvIgncziRQ3l5AhO/biIDvht6GYxSelLqZJ+ZVKovMEqQXFIvz7N9Npb+bRE6hiLqJ5mlTjmAoSLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBUcnkR7LMC1p1rZBDikoNyRdbgodK+3yeh6mzx1ebA=;
 b=DPq+kNbASrnMVO4Itum9n652JlBPWwfm43H90M5kF8C8dWZvf+SoRJJ4sCkqdKb8UpWcKwx2H1sxeYJvy33DYA6oInP0E44jAO7nlIYLDy1mlNzBzu4dfkxytiTQyQ1R+cjo77ZJavaEbn/3smY0hEFIJEYEeUzYbSIZBoSg7qmApVUD4kCTOsyDPlNMg1nHGa+Tx316J7MUsEd1YxPsnQURoY9/e66LDBW/2B6ziWjBzGCcjD5W+1wk4IUwmlLyLUazzICpc/KyH1nJB4m8HrOQx4hgZo7Y3SZkSljmZjqWoyAHkNGMZ3hew6STzKIpSWAzFycSYTrHbDNYSXcHbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBUcnkR7LMC1p1rZBDikoNyRdbgodK+3yeh6mzx1ebA=;
 b=IFXGR1RiP1bKalFVzYs6F10r8gfPpnCyhVcLEpYP+/MKraUEf72NrQ8NBzFuuUqAfE3OiuEP6pEu+57GVPk0ZNkyPtVdTXBn3zRkvRWfRHNfFNvbRYMDuelLF2DIwrEG4VS9PHCcbhcjtYS3FpzTlNJHTa1cn3CHjkC/h6UGuXc=
Received: from BLAPR03CA0092.namprd03.prod.outlook.com (2603:10b6:208:32a::7)
 by BL1PR12MB5970.namprd12.prod.outlook.com (2603:10b6:208:399::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 17:23:53 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:32a:cafe::8c) by BLAPR03CA0092.outlook.office365.com
 (2603:10b6:208:32a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.20 via Frontend Transport; Tue,
 3 Jun 2025 17:23:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 17:23:53 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 12:23:52 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <PradeepVineshReddy.Kodamati@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <bhelgaas@google.com>,
	<bp@alien8.de>, <ming.li@zohomail.com>, <shiju.jose@huawei.com>,
	<dan.carpenter@linaro.org>, <Smita.KoralahalliChannabasappa@amd.com>,
	<kobayashi.da-06@fujitsu.com>, <terry.bowman@amd.com>, <yanfei.xu@intel.com>,
	<rrichter@amd.com>, <peterz@infradead.org>, <colyli@suse.de>,
	<uaisheng.ye@intel.com>, <fabio.m.de.francesco@linux.intel.com>,
	<ilpo.jarvinen@linux.intel.com>, <yazen.ghannam@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v9 06/16] cxl/pci: Move RAS initialization to cxl_port driver
Date: Tue, 3 Jun 2025 12:22:29 -0500
Message-ID: <20250603172239.159260-7-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250603172239.159260-1-terry.bowman@amd.com>
References: <20250603172239.159260-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|BL1PR12MB5970:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f25760b-71bd-4a46-6fc9-08dda2c369ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lulRIWxG7XuHpu92J0wqUe+KsanNHsQtOL7Q5r9vB1QCo9pyGfccdUm8lRc/?=
 =?us-ascii?Q?WSzQuwyvT7clrzJ7Qqjpu7S1rxQXP1SOBZZTV9m6akoBlUzFN5UqQMJwg2mH?=
 =?us-ascii?Q?edJ5GQ7ybaAZ0Y/2eds88RXpYV7VZW3n1ZjQbhwYRXjpv1qjmEWBDxYRMRf3?=
 =?us-ascii?Q?n+cZFxiAhk4L8Iyuwy+DOSoSelpSUOKhNvwrEM+9ZCEkYycxe22NY4Y624v5?=
 =?us-ascii?Q?IGdQ9BSDg71k6aBglaQqtmJ7VAhw4A8FXOxIPVSqMophOG+iZzylLNUVbiJa?=
 =?us-ascii?Q?e8M2wWR1GXzNIhrD2gHEp6Ez5qZRr6mbtljyYKeLS8HIpNBf9q2h5MyaALVQ?=
 =?us-ascii?Q?ZrhL9WWQBTyc1bLIyGRnroxBbEWNWqcyveDhMIIqWLudUDnL6rCjQsD2WSfY?=
 =?us-ascii?Q?o+Bb+d+mx84Eg0xMgQ0+YUSNj6p8X6cKTcO6sheIfDURE6jgIDOCYrRCpJoX?=
 =?us-ascii?Q?LkEj5P9bZMYDyWKJ5LPFOGDvDnb1ZU8ebnDH3KVzFQYqEhTMumymHQRWtfrr?=
 =?us-ascii?Q?Au20k+pJb2Wmu38vBWFp4eEcVLgzY5criUEtqMaW3VD6iSCam2AZCdeYkgze?=
 =?us-ascii?Q?4pob82ze2Dj3ZNE6Zsxyb3vAXMjWrGapAyZKFUQyamcu5xqE5Ect1v0dy5JX?=
 =?us-ascii?Q?FWnt6PjxdcWwH5B1aORHzeQXPxiTMfc+2GgCJj+xpcHYsu2XpC4aMr27rS64?=
 =?us-ascii?Q?TaXo9qcadILt0Nvx0D2C7Y3SWaVd6ETkmFsjefWW4l6yGLrm3ryeImJ5/k4P?=
 =?us-ascii?Q?/iUb2SUT8HHh4ZU0ZLCPvucL8/71Y0uAGpktkp3jc7yRo7d7/0zGZBYMVh4x?=
 =?us-ascii?Q?dQbnJX5roQnwFvtil8J43w0ouqAoqfPwYEaLIEu7NBjBWvWw/pSlmnkfd2Td?=
 =?us-ascii?Q?BGv8cgVmIwxHvlYRpgMGEH7zus6mnp4eJ/dJ2KVzJoIuQjPn43KWvm4LD0Vj?=
 =?us-ascii?Q?Bem4D/UEpWZ982WZzO1ilK0kJPW92pJbXF4Xdegb8XoGx+ImwnCcR0TeXEFP?=
 =?us-ascii?Q?xWAeiglUqnD36y+bRrv4bMCLkrxxKnVqlKfi+VR0/hSJHwqlqmhRzZPP1Cfp?=
 =?us-ascii?Q?FOcl/fBnbW7bTRT/Xe6tcktIn/YmUPrfvyk0knxny2YRMMKfcbUVaNd8rYFP?=
 =?us-ascii?Q?+FhMPhX3lxe6HWrAPciiCydST/NMu24yyuVuOxlyLhYCHjJy5JqDJcKjz2Gb?=
 =?us-ascii?Q?j/YVXMJA+jU41m5IVsYjH23wAAFfcVvxXuvtGJV3tk1L53bSdQhMq/Yd6crz?=
 =?us-ascii?Q?zW05KxeG2ndcoUvYWntJo4B0QoRu0nJNUw2UDAtZZ5gvOJkOb6+3leUBnHNl?=
 =?us-ascii?Q?hurbhIhndt1Wx2thsjQZncSCsk2RzqTyS8LtSKDEvSyZbuskziP2MbyFozT4?=
 =?us-ascii?Q?E2bnMXXB7+ztNppdP9CnpA5evV067xBfE6QY9GnulQNvQ/tfj4no4i8LZ412?=
 =?us-ascii?Q?w3JbdxUR8e+kCi29nn5H4f07TfpN2el4B6ObV+oy1MWXqJwtEBIhcijM6Rpp?=
 =?us-ascii?Q?SnP9IYTZwqZT1F56YGYQERDRjZgDgIhOQwL7A2v9OlHZKzXPjkdoTKIvgA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 17:23:53.5650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f25760b-71bd-4a46-6fc9-08dda2c369ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5970

The cxl_port driver is intended to manage CXL Endpoint Ports and CXL Switch
Ports. Move existing RAS initialization to the cxl_port driver.

Restricted CXL Host (RCH) Downstream Port RAS initialization currently
resides in cxl/core/pci.c. The PCI source file is not otherwise associated
with CXL Port management.

Additional CXL Port RAS initialization will be added in future patches to
support a CXL Port device's CXL errors.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c  | 73 --------------------------------------
 drivers/cxl/core/regs.c |  2 ++
 drivers/cxl/cxl.h       |  6 ++++
 drivers/cxl/port.c      | 78 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 86 insertions(+), 73 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index b50551601c2e..317cd0a91ffe 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -748,79 +748,6 @@ static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
 
 #ifdef CONFIG_PCIEAER_CXL
 
-static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
-{
-	resource_size_t aer_phys;
-	struct device *host;
-	u16 aer_cap;
-
-	aer_cap = cxl_rcrb_to_aer(dport->dport_dev, dport->rcrb.base);
-	if (aer_cap) {
-		host = dport->reg_map.host;
-		aer_phys = aer_cap + dport->rcrb.base;
-		dport->regs.dport_aer = devm_cxl_iomap_block(host, aer_phys,
-						sizeof(struct aer_capability_regs));
-	}
-}
-
-static void cxl_dport_map_ras(struct cxl_dport *dport)
-{
-	struct cxl_register_map *map = &dport->reg_map;
-	struct device *dev = dport->dport_dev;
-
-	if (!map->component_map.ras.valid)
-		dev_dbg(dev, "RAS registers not found\n");
-	else if (cxl_map_component_regs(map, &dport->regs.component,
-					BIT(CXL_CM_CAP_CAP_ID_RAS)))
-		dev_dbg(dev, "Failed to map RAS capability.\n");
-}
-
-static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
-{
-	void __iomem *aer_base = dport->regs.dport_aer;
-	u32 aer_cmd_mask, aer_cmd;
-
-	if (!aer_base)
-		return;
-
-	/*
-	 * Disable RCH root port command interrupts.
-	 * CXL 3.0 12.2.1.1 - RCH Downstream Port-detected Errors
-	 *
-	 * This sequence may not be necessary. CXL spec states disabling
-	 * the root cmd register's interrupts is required. But, PCI spec
-	 * shows these are disabled by default on reset.
-	 */
-	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
-			PCI_ERR_ROOT_CMD_NONFATAL_EN |
-			PCI_ERR_ROOT_CMD_FATAL_EN);
-	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
-	aer_cmd &= ~aer_cmd_mask;
-	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
-}
-
-/**
- * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
- * @dport: the cxl_dport that needs to be initialized
- * @host: host device for devm operations
- */
-void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
-{
-	dport->reg_map.host = host;
-	cxl_dport_map_ras(dport);
-
-	if (dport->rch) {
-		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport->dport_dev);
-
-		if (!host_bridge->native_aer)
-			return;
-
-		cxl_dport_map_rch_aer(dport);
-		cxl_disable_rch_root_ints(dport);
-	}
-}
-EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
-
 static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
 					  struct cxl_dport *dport)
 {
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 5ca7b0eed568..b8e767a9571c 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -199,6 +199,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 
 	return ret_val;
 }
+EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, "CXL");
 
 int cxl_map_component_regs(const struct cxl_register_map *map,
 			   struct cxl_component_regs *regs,
@@ -517,6 +518,7 @@ u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb)
 
 	return offset;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_rcrb_to_aer, "CXL");
 
 static resource_size_t cxl_rcrb_to_linkcap(struct device *dev, struct cxl_dport *dport)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ba08b77b65da..0dc43bfba76a 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -313,6 +313,12 @@ int cxl_setup_regs(struct cxl_register_map *map);
 struct cxl_dport;
 resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 					   struct cxl_dport *dport);
+
+u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb);
+
+void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
+				   resource_size_t length);
+
 int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 
 #define CXL_RESOURCE_NONE ((resource_size_t) -1)
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index fe4b593331da..7b61f09347a5 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -6,6 +6,7 @@
 
 #include "cxlmem.h"
 #include "cxlpci.h"
+#include "cxl.h"
 
 /**
  * DOC: cxl port
@@ -57,6 +58,83 @@ static int discover_region(struct device *dev, void *unused)
 	return 0;
 }
 
+#ifdef CONFIG_PCIEAER_CXL
+
+static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
+{
+	resource_size_t aer_phys;
+	struct device *host;
+	u16 aer_cap;
+
+	aer_cap = cxl_rcrb_to_aer(dport->dport_dev, dport->rcrb.base);
+	if (aer_cap) {
+		host = dport->reg_map.host;
+		aer_phys = aer_cap + dport->rcrb.base;
+		dport->regs.dport_aer = devm_cxl_iomap_block(host, aer_phys,
+						sizeof(struct aer_capability_regs));
+	}
+}
+
+static void cxl_dport_map_ras(struct cxl_dport *dport)
+{
+	struct cxl_register_map *map = &dport->reg_map;
+	struct device *dev = dport->dport_dev;
+
+	if (!map->component_map.ras.valid)
+		dev_dbg(dev, "RAS registers not found\n");
+	else if (cxl_map_component_regs(map, &dport->regs.component,
+					BIT(CXL_CM_CAP_CAP_ID_RAS)))
+		dev_dbg(dev, "Failed to map RAS capability.\n");
+}
+
+static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
+{
+	void __iomem *aer_base = dport->regs.dport_aer;
+	u32 aer_cmd_mask, aer_cmd;
+
+	if (!aer_base)
+		return;
+
+	/*
+	 * Disable RCH root port command interrupts.
+	 * CXL 3.0 12.2.1.1 - RCH Downstream Port-detected Errors
+	 *
+	 * This sequence may not be necessary. CXL spec states disabling
+	 * the root cmd register's interrupts is required. But, PCI spec
+	 * shows these are disabled by default on reset.
+	 */
+	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
+			PCI_ERR_ROOT_CMD_NONFATAL_EN |
+			PCI_ERR_ROOT_CMD_FATAL_EN);
+	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
+	aer_cmd &= ~aer_cmd_mask;
+	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
+}
+
+/**
+ * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
+ * @dport: the cxl_dport that needs to be initialized
+ * @host: host device for devm operations
+ */
+void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
+{
+	dport->reg_map.host = host;
+	cxl_dport_map_ras(dport);
+
+	if (dport->rch) {
+		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport->dport_dev);
+
+		if (!host_bridge->native_aer)
+			return;
+
+		cxl_dport_map_rch_aer(dport);
+		cxl_disable_rch_root_ints(dport);
+	}
+}
+EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
+
+#endif /* CONFIG_PCIEAER_CXL */
+
 static int cxl_switch_port_probe(struct cxl_port *port)
 {
 	struct cxl_hdm *cxlhdm;
-- 
2.34.1


