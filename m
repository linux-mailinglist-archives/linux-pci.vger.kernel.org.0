Return-Path: <linux-pci+bounces-24815-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E521A72880
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 02:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 190A4188F0C8
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 01:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7211531E1;
	Thu, 27 Mar 2025 01:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aiUxsdx0"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCF11A08DB;
	Thu, 27 Mar 2025 01:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743040220; cv=fail; b=QViXWUN6RFoNLvPhw3Si+J21VVGmDZJOIai4vSnZ7oRTwhlhbVxXehQEF8DQCxDJChmho00HQaX0gPyXBEJ509kQrIFoNZYyPpO1NDB+ClECTK0/PMyUupWdFAmr7S9uh8yR9jZ3Rlyb0v/stdI7MjWM1/S8aAaJitTWPg9kMdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743040220; c=relaxed/simple;
	bh=3k0sA1XrRBCTtjz7qcYJXdvlLeroL0F5Y4nw09WrZC4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hEEk0fNp1PqswiacJgjc4tfnljXenbHeno6jWtXCnZKCFbkMn+oIxDO9VWJzG9LL/9B8296fk9RRkmymH9TvCKLS6LFvEFw4SPdo1TuRdWkZDo3wFipGmbwTzO3eXa3nsBEbI+7eRsxPIec8nems4fTB5VrZqFCmTUgQBSXSG7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aiUxsdx0; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S/HlF6fRz2c284LJ3qy+nsRSmk1ptCc/w14ng6vHJ7Cv87/9i0K/KTv/6Q4Yf0gERKFTwwYGqfXU/GYJgtXYApZqgwHNLrGUnITgQA/uYiafH5w+Qi15X1ZBzrJs3G83f2XiETgLQrxN1TZcFwIeskPjgroz5ZDKD8sBgVE2gPPzj42mDLbGnS8N1dQBzJp/kiWLI54rIuQqmCcu/dG6KEx5kYXPkMsc4AbUHSV2JQhMQSAF8MrjJRqTkCT384L9NcXoEn2Z1fKs+JxvJk7oGUR7Vi432r74s8vCuflpRptmNhvxL0IGkA0ImXYD2E9m1ZjHrG88JL7btzAnwkZogQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1UhMaoTbL81h8kvBAE8ojSWBsM18f0yfeJPfXdSKRc=;
 b=wcNdEov0Fb8mwnmvXi80mM4c8ZMZC19zPemggyt6UCRFmlNNojDuGyR1VNyT7cg8oSuayo3cotDipHS8RY3eSXhM7PNseS5dvv8GXE1yDVKmpCCpBZ0vk73ntpvzWNTF3yOWs9W/x00F0hY8MJ6axJCCK0VhWp1GjKjjCcI+7wQdAXEp8iWsUUELBt+OyqQct+4bPEQ6aZrxeVNg3N+p/y7dd0BdEf2LOiFH25gE5oh6u6Vri9gpmoVHIDG5G9SeIlBvgL1SW9rGN19CfWGM4h8/p/o77aerbTFZKHUpb1ahlxivZpYonXmalzni1QA+Lej2H4z5kSvpgSZL1+AB9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1UhMaoTbL81h8kvBAE8ojSWBsM18f0yfeJPfXdSKRc=;
 b=aiUxsdx0BDm9q7ocsyGGUE4tyC4hoTo25MrdHDc9fiKNqAJltYO7y0RF/wZTUzZwkUBh49SwB3EpC7NKxa1hy65WlPUZXhVXI/ufV3fkZUEu/MHxJb72K5ZBf/j13I7a2pGjwhsqZ1UE2DTLeQ5wsxA35zYjlXUoch9jbTr8a38=
Received: from BN9PR03CA0250.namprd03.prod.outlook.com (2603:10b6:408:ff::15)
 by CY1PR12MB9673.namprd12.prod.outlook.com (2603:10b6:930:104::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 01:50:16 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:408:ff:cafe::3) by BN9PR03CA0250.outlook.office365.com
 (2603:10b6:408:ff::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Thu,
 27 Mar 2025 01:50:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 27 Mar 2025 01:50:15 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 20:50:14 -0500
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
Subject: [PATCH v8 15/16] CXL/PCI: Enable CXL protocol errors during CXL Port probe
Date: Wed, 26 Mar 2025 20:47:16 -0500
Message-ID: <20250327014717.2988633-16-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|CY1PR12MB9673:EE_
X-MS-Office365-Filtering-Correlation-Id: ce55ee71-bd25-41e9-da3c-08dd6cd1b876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k/f3Bem4HoKKmE6i2k3LiE31lTsXfCfbUNMvRbh3vGfpHLh1f6jiLkaGv3Wf?=
 =?us-ascii?Q?7dIbPlpiMNAR/hU+B3iVMPf9nsfK2Q51txn7japSbzFDVBCOn+CWDXaC8mpQ?=
 =?us-ascii?Q?6FAm8qQXb9evgm3EdTq4Dr/2sWZp4ad2Fdmtes4b9E/S+EG8Nqzt3twYnW1L?=
 =?us-ascii?Q?X/Sl2xgDwf5v6Anrz5LUsShrrAR5RbJnPCR0sjMGsBTYt/2XE8kbvhikZTY5?=
 =?us-ascii?Q?vpiCqT63gWACKvOqnepZ/1dVvmEMRVIx2rjKksbrapN+UhSSkgcQEm4cdlxW?=
 =?us-ascii?Q?frJVma09K8luwDkIN5CPDJSKojI0WfN4ybLOhSq3f2JICXOP51YXj1d3T4GA?=
 =?us-ascii?Q?CLjQBp4Np6j3k+spiTQlfo/7hKYiRGCg7OEpXxttU5dIDReg10tbHBS5xACH?=
 =?us-ascii?Q?yQ4fdsKiam5C6/UnXrcgbrK94G/OjAE77Q0JbAPy1kFofeSUQmicKd/PsN5L?=
 =?us-ascii?Q?RPlvTXgUEM7iImmfF02S4KljfYrQgsfgBHWu4GJK+02V5/kWHau+hs+KQea5?=
 =?us-ascii?Q?dBIrWbFD2u0nCsP+oti1of7HvMz4BLUjzOusAXbd4E/wKLlZMsjYqVpaJpqS?=
 =?us-ascii?Q?hfE/vdTngqt+4sh5WLCkxsD6rpdwU4Fdj20Ghhx4dlpTq1yUh+oChBPzW9B9?=
 =?us-ascii?Q?A5Wf13LPlCG+tHPa0O4dn2ZwNYjErZAYIg+Ftxa0hmwfUtSM+ZoMbgnBDPsl?=
 =?us-ascii?Q?aU1YIh9eTld+rEVY7UhIYFKy2no+ELPXoJvd3/awP8vjazOaDIulon0EyOmz?=
 =?us-ascii?Q?GnTMXGD75qVW4h40qBI8BJFcgpA5DtolF2wxfHw05gpwYoLAoUE9tyjy2niX?=
 =?us-ascii?Q?fmyum8lGDOVikqz3IXPnaZKQZ6TblLlZE7sPHhVvCyolXl+o217XC9FaGS3z?=
 =?us-ascii?Q?HTvpZFOEC9MWDg//4dcW6Y8k8EkLdIo3nGrY9UiPiLCgqtw5eApwxJEr4w8V?=
 =?us-ascii?Q?NlK7pSfgpTr3dXVLic2+h/hQ/WzglasXEigIqGu5JuypSOcp0JYxthB6BmtB?=
 =?us-ascii?Q?jxyx8fen0QBI3BDvfN3571/YOjUnPqrRksFte1hDQqAy8jlcNEFqaAji+3lQ?=
 =?us-ascii?Q?91ghD1PeLLNhAYl+AlGY42c9ZdegokpIpBZzw91prlXM80SVuFb44lQa9l9U?=
 =?us-ascii?Q?LBYMkJjM4MMbx8EnoPyPMarCxjGdoedYc6BnT3N/jAu1/mSobyzlYv596nh3?=
 =?us-ascii?Q?EoGLTX2pfo3e6a/0ee0NB+1mH3j1P7y625q1vTRnz1nI1iS5qXe+9p2jza5k?=
 =?us-ascii?Q?S4Yer2mhfdDgvfIkMYsa97YVFXb9Sd3aWXTxNbBqByYu3Yfg4j/l3xoJhF/w?=
 =?us-ascii?Q?ObJRd7qfpiNZnHZnIP3sZZZx7hUvIfeNtdG6TG7lkjLX7fWA4m4rroGsT+UB?=
 =?us-ascii?Q?DCdbl+oShFGVbfx3ShSdVBTSkplpP9lYcLgWstcJjwtQ9uQo6aXDCJ/n4xDQ?=
 =?us-ascii?Q?/6IvSnkM2FNUHe8yco4FdKQVH5bH8X+1iy9PoLrOtOIojBi2+QtrA2fZKsUJ?=
 =?us-ascii?Q?JI4CeCEztg73NAnSgC2J9oeBuH941xyh9jU9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 01:50:15.4771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce55ee71-bd25-41e9-da3c-08dd6cd1b876
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9673

CXL protocol errors are not enabled for all CXL devices at boot. These
must be enabled inorder to process CXL protocol errors.

Export the AER service driver's pci_aer_unmask_internal_errors().

Introduce cxl_enable_port_errors() to call pci_aer_unmask_internal_errors().
pci_aer_unmask_internal_errors() expects the pdev->aer_cap is initialized.
But, dev->aer_cap is not initialized for CXL Upstream Switch Ports and CXL
Downstream Switch Ports. Initialize the dev->aer_cap if necessary. Enable AER
correctable internal errors and uncorrectable internal errors for all CXL
devices.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/cxl.h      |  2 ++
 drivers/cxl/port.c     | 22 ++++++++++++++++++++++
 drivers/pci/pcie/aer.c |  3 ++-
 include/linux/aer.h    |  1 +
 4 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index c1adf8a3cb9e..473267c19cd0 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -769,9 +769,11 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 #ifdef CONFIG_PCIEAER_CXL
 void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport);
 void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
+void cxl_enable_prot_errors(struct device *dev);
 #else
 static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
 						struct device *host) { }
+static inline void cxl_enable_prot_errors(struct device *dev) { }
 #endif
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 8e2b70e73582..bb7a0526e609 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -83,6 +83,24 @@ static void cxl_assign_error_handlers(struct device *_dev,
 	pdrv->err_handler = handlers;
 }
 
+void cxl_enable_prot_errors(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct device *pci_dev __free(put_device) = get_device(&pdev->dev);
+
+	if (!pci_dev)
+		return;
+
+	if (!pdev->aer_cap) {
+		pdev->aer_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
+		if (!pdev->aer_cap)
+			return;
+	}
+
+	pci_aer_unmask_internal_errors(pdev);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_enable_prot_errors, "CXL");
+
 static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
 {
 	resource_size_t aer_phys;
@@ -147,6 +165,7 @@ static void cxl_uport_init_ras_reporting(struct cxl_port *port,
 	}
 
 	cxl_assign_error_handlers(&port->dev, &cxl_port_error_handlers);
+	cxl_enable_prot_errors(port->uport_dev);
 }
 
 /**
@@ -177,6 +196,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
 	}
 
 	cxl_assign_error_handlers(dport->dport_dev, &cxl_port_error_handlers);
+	cxl_enable_prot_errors(dport->dport_dev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
 
@@ -201,6 +221,7 @@ static void cxl_endpoint_port_init_ras(struct cxl_port *port)
 	struct cxl_port *parent_port __free(put_cxl_port) =
 		cxl_mem_find_port(cxlmd, &dport);
 	struct device *cxlmd_dev __free(put_device) = &cxlmd->dev;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 
 	if (!dport || !dev_is_pci(dport->dport_dev)) {
 		dev_err(&port->dev, "CXL port topology not found\n");
@@ -210,6 +231,7 @@ static void cxl_endpoint_port_init_ras(struct cxl_port *port)
 	cxl_dport_init_ras_reporting(dport, cxlmd_dev);
 
 	cxl_assign_error_handlers(cxlmd_dev, &cxl_ep_error_handlers);
+	cxl_enable_prot_errors(cxlds->dev);
 }
 
 #else
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 763ec6aa1a9a..d3068f5cc767 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -962,7 +962,7 @@ static bool find_source_device(struct pci_dev *parent,
  * Note: AER must be enabled and supported by the device which must be
  * checked in advance, e.g. with pcie_aer_is_native().
  */
-static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
+void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 {
 	int aer = dev->aer_cap;
 	u32 mask;
@@ -975,6 +975,7 @@ static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 	mask &= ~PCI_ERR_COR_INTERNAL;
 	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
 }
+EXPORT_SYMBOL_NS_GPL(pci_aer_unmask_internal_errors, "CXL");
 
 static bool is_cxl_mem_dev(struct pci_dev *dev)
 {
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 8f815f34d447..a65fe324fad2 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -100,5 +100,6 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 int cper_severity_to_aer(int cper_severity);
 void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
 		       int severity, struct aer_capability_regs *aer_regs);
+void pci_aer_unmask_internal_errors(struct pci_dev *dev);
 #endif //_AER_H_
 
-- 
2.34.1


