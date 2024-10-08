Return-Path: <linux-pci+bounces-14014-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAA09959F7
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 00:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DEF61C21DF7
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 22:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6BE21644D;
	Tue,  8 Oct 2024 22:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jUw5JxKF"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2086.outbound.protection.outlook.com [40.107.96.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D53215039;
	Tue,  8 Oct 2024 22:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728425929; cv=fail; b=tbmhJ/8U2Pc66r4Ac1NqSl0ialPEjtv+h8FiExqNykA/cGm9HVcr57IRLhtw1XSbX8QJ7Veu4iSwZg+Yb90wS71XlYPcmRPEtEbposjq27OlnpR+hLdkWf/wB3ONunu9YjnEemIu69jbZgebA/GN+WYQkv4ZQlymdxOIO7DhO48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728425929; c=relaxed/simple;
	bh=FO3SwhHWq8DD2fjZrIXlGQzQqK+orFXfoHefumruETw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BCzY6BsqglUF7FjILesrNcARNQhUCXYQE1v408xbnP8dFgvjMPPNkiZiHVTrBeid+x2tzzA2kQ8R2zXRleboQfQpigKTDebqLBRlEyHK+JvGvCMv67M4d7LWmxB3A62V+uavDo5pKSMVeocYvhwS5y6uy3rvGDayneUP+hyIlh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jUw5JxKF; arc=fail smtp.client-ip=40.107.96.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFXmRxHenhQ4XJeSkW4Z71ElZFYX16k5L+NYkYpvPlGsONQ0xEXfu0blqXQoiTz+U9ZDWluWGKBg7gMOjpxHgCLgLws8zAxMRfEYcoy3No5Ddw7+3uuS+cUIEzhQXwex4FFjRJivcXKmud1iI6uGQLGHRojuKTj0lVPrfuZFp+MGqVxJ3e7kJGFIQz0VOt+XCs3ymQ1IzfpyTlu0J/TEhL7sNe+jVGbsxiwFT0SakljBhP+YE3svkbARgyQoRTTeCXBX3GpF6HWgMPOiF+D3X4OS3F8roK90WLoeylVxwFn3LZTsRunqsAHws7Nle8BbZ/HZVxW76oyu6xC0yTivSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wfs9/9pGlrUYcE94dso+MM24VISuqUkE3p3AVyJ/aA=;
 b=OIzF/6xoHcR5yu+HYWsoYpNumysj3ziYlOMC2NC7RuksOhKUtGmx11zG5eltLsZYucQmFBZ6UiLKWiST+wBc/0UEBtldg9178RrTW+26uC98PEqKwLMir/I0tBMWnOcQjkU4v9LHpwnFIiyV4gBU56oN1WQZABiOLj1K7LUg2SPCQKx4cTTOKOHNGumrjoZ3y6wUdFCzd+IJ83LHm+3xRsWqdW23t/5cWUmCPnyyQHvCul2+zBsqUrWRlMImcgdu0HQXGw4wTprOaQf0D6xyblIl9B5iZbEE1Qngx4CUMnkd3rrGrrfbMRcHCizLlskL730V8vvG7chOLR5V08sG6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wfs9/9pGlrUYcE94dso+MM24VISuqUkE3p3AVyJ/aA=;
 b=jUw5JxKFJLHbDL/HgwmmeG5ruZS5yjzvt8+ZlQJYY26wP5ezZKwaWqzP4/9/lJjzKzw7t72CvzjilJ4gFHzD98ta202U8sEnSDMMWyZhDjZVJtZB5oO3euszHcgA6jR9TcNz9IPWj2NBd9yJ6fmURfZrq+DIQ4v1zPVcLRtRSy8=
Received: from BL0PR0102CA0066.prod.exchangelabs.com (2603:10b6:208:25::43) by
 PH7PR12MB6860.namprd12.prod.outlook.com (2603:10b6:510:1b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24; Tue, 8 Oct
 2024 22:18:44 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:208:25:cafe::d4) by BL0PR0102CA0066.outlook.office365.com
 (2603:10b6:208:25::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Tue, 8 Oct 2024 22:18:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 22:18:43 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 17:18:42 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <smita.koralahallichannabasappa@amd.com>,
	<terry.bowman@amd.com>
Subject: [PATCH 09/15] cxl/pci: Map CXL PCIe downstream port RAS registers
Date: Tue, 8 Oct 2024 17:16:51 -0500
Message-ID: <20241008221657.1130181-10-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008221657.1130181-1-terry.bowman@amd.com>
References: <20241008221657.1130181-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|PH7PR12MB6860:EE_
X-MS-Office365-Filtering-Correlation-Id: 004e4685-5204-4c26-6379-08dce7e72bd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fb33BIcssvSNssrpz7cXCP8qlAtXKXaJobKFdezBNMY5UAeQvWqZY90zysCe?=
 =?us-ascii?Q?mctO1Zh0NenKbF6/tYz/2W5tOl9dzgrRWXv1BO5g77v7IPcEYFdULsLXZtP+?=
 =?us-ascii?Q?F6JOeZkIR8ghs1cNhQ22fDixOWF+NOdvfS4LZ27QeQswKgC5eZeZ8DhKDhay?=
 =?us-ascii?Q?Q6JBO4FKqaEAHtjcljUAW4zoaELVTsnFuKJHJbfXjnsyxix/jevpmaTU9FMf?=
 =?us-ascii?Q?cpCYM4DmkfUB+ewhopIssOmIHd5MB0iZVurfmH8weqMQsUAspNBxchjmyNXy?=
 =?us-ascii?Q?v//6GQSQACR5oQ9eLmkG6/82enBgNE7HV8M3jqe+22e183jbWAw4ijaLvxg+?=
 =?us-ascii?Q?us0dpnExbHnfco/qbmV1vkwM1hsGD5hbvhzIGtNLSUsUNGqwso33eMgpMSoO?=
 =?us-ascii?Q?KtV1KMguhZpX5sMGkdRRZ3/6e4n896BJmFOFGtbtI5sCqPv3qMdQ3mBmgHt7?=
 =?us-ascii?Q?EsMJz6BJFtNd/Tdq9mhljSB5y1GkNqMjHFqxoAQn/QsSbXt7PlXMXhCrMaOo?=
 =?us-ascii?Q?N3GDJyl2bDd2ObUpaU91rKGe3TAqpUae+24JjvuLEA1S5L2x81zthGSMv6fX?=
 =?us-ascii?Q?Od3rYugRZVgQztY3GMKbXiHsyvo4oPmdVp1UKdd6s/BM9fYdqU2ZSs3qzA/3?=
 =?us-ascii?Q?koQO4F5Xr1yhykdOVetOjPDk/vnE8VByiNVnBvgZkrd9NxPoBoGauJ0eQApa?=
 =?us-ascii?Q?0ZqgUp1Go6N7zXMKIlGVvMPq+XN5uKWZ+i1a2r6WBmxJAF+d1egiV/xsKzAH?=
 =?us-ascii?Q?bUX4MtqanmvNibP3hYc0Oxy85MzLg5aWYz+23aazbMQVB5ob5cyD0VXIwI3y?=
 =?us-ascii?Q?GC6tdoEVsSTIJ3AvxOwUAjrCK9wR1gSsd2jYTZKyZr3tivKQ6eBmhqLGj4g/?=
 =?us-ascii?Q?MBRyjoS/AmmY4oFJpN8uJp+j1A7Fk9TxDnm9iwuRRLshZxPlNE11EWqlTVo6?=
 =?us-ascii?Q?w4DdDgd2VdaU6cX82ULayY2QvM8hl4oqhLX4zgwEgrCIUjt9q2jI8PpLD1y1?=
 =?us-ascii?Q?27qjEpAyVXK0jrpMdzP3hD7ikAdeW+xMlUHX+p5y72LVHMp+xWmk4FhqC+5b?=
 =?us-ascii?Q?uBQtfutRz5fOF3qYcti1/cjpmpjjuIkwC5zVhQB6nD+UZeAZ1nlGz1mIozZF?=
 =?us-ascii?Q?12qrEP25Nsoa6agXJ72vU+RJqlb8jq8DAqSLJ0dTnFyD1ihiP35Io7X32WZl?=
 =?us-ascii?Q?3uXd4ysF8Iju9dmNK9gRAsyg9ATmGQFMlS3BA5LdgaYBE+KJTgH2y7YHuT/Y?=
 =?us-ascii?Q?XCleH/w9Wevj2HjngN1/6ufOYorSC26bJzglj4MS8ExyGOWLOHJlpvKp4YHp?=
 =?us-ascii?Q?lVbusuU0M55dE2tFfqVMvREg2UilMrNFNWTbPeMkrWIQrlJw6VlMHNVtf2VG?=
 =?us-ascii?Q?iTrq4p6JgEdmBGJyG0kdHBuLnR2e?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 22:18:43.8271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 004e4685-5204-4c26-6379-08dce7e72bd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6860

RAS registers are not mapped for CXL root ports, CXL downstream switch
ports, or CXL upstream switch ports. To prepare for future RAS logging
and handling, the driver needs updating to map PCIe port RAS registers.

Refactor and rename cxl_setup_parent_dport() to be cxl_init_ep_ports_aer().
Update the function such that it will iterate an endpoint's dports to map
the RAS registers.

Rename cxl_dport_map_regs() to be cxl_dport_init_aer(). The new
function name is a more accurate description of the function's work.

This update should also include checking for previously mapped registers
within the topology, particularly with CXL switches. Endpoints under a
CXL switch may share a common downstream and upstream port, ensure that
the registers are only mapped once.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c | 37 ++++++++++++++++---------------------
 drivers/cxl/cxl.h      |  7 ++++---
 drivers/cxl/mem.c      | 27 +++++++++++++++++++++++++--
 3 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 51132a575b27..6f7bcdb389bf 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -787,21 +787,6 @@ static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
 	dport->regs.dport_aer = dport_aer;
 }
 
-static void cxl_dport_map_regs(struct cxl_dport *dport)
-{
-	struct cxl_register_map *map = &dport->reg_map;
-	struct device *dev = dport->dport_dev;
-
-	if (!map->component_map.ras.valid)
-		dev_dbg(dev, "RAS registers not found\n");
-	else if (cxl_map_component_regs(map, &dport->regs.component,
-					BIT(CXL_CM_CAP_CAP_ID_RAS)))
-		dev_dbg(dev, "Failed to map RAS capability.\n");
-
-	if (dport->rch)
-		cxl_dport_map_rch_aer(dport);
-}
-
 static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
 {
 	void __iomem *aer_base = dport->regs.dport_aer;
@@ -831,7 +816,7 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
 	}
 }
 
-void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
+void cxl_dport_init_aer(struct cxl_dport *dport)
 {
 	struct device *dport_dev = dport->dport_dev;
 
@@ -840,15 +825,25 @@ void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
 
 		if (host_bridge->native_aer)
 			dport->rcrb.aer_cap = cxl_rcrb_to_aer(dport_dev, dport->rcrb.base);
+
+		cxl_dport_map_rch_aer(dport);
+		cxl_disable_rch_root_ints(dport);
 	}
 
-	dport->reg_map.host = host;
-	cxl_dport_map_regs(dport);
+	/* dport may have more than 1 downstream EP. Check if already mapped. */
+	if (dport->regs.ras) {
+		dev_warn(dport_dev, "RAS is already mapped\n");
+		return;
+	}
 
-	if (dport->rch)
-		cxl_disable_rch_root_ints(dport);
+	dport->reg_map.host = dport_dev;
+	if (cxl_map_component_regs(&dport->reg_map, &dport->regs.component,
+				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
+		dev_err(dport_dev, "Failed to map RAS capability.\n");
+		return;
+	}
 }
-EXPORT_SYMBOL_NS_GPL(cxl_setup_parent_dport, CXL);
+EXPORT_SYMBOL_NS_GPL(cxl_dport_init_aer, CXL);
 
 static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
 					  struct cxl_dport *dport)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 9afb407d438f..cb9e05e2912b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -592,6 +592,7 @@ struct cxl_dax_region {
  * @parent_dport: dport that points to this port in the parent
  * @decoder_ida: allocator for decoder ids
  * @reg_map: component and ras register mapping parameters
+ * @uport_regs: mapped component registers
  * @nr_dports: number of entries in @dports
  * @hdm_end: track last allocated HDM decoder instance for allocation ordering
  * @commit_end: cursor to track highest committed decoder for commit ordering
@@ -612,6 +613,7 @@ struct cxl_port {
 	struct cxl_dport *parent_dport;
 	struct ida decoder_ida;
 	struct cxl_register_map reg_map;
+	struct cxl_component_regs uport_regs;
 	int nr_dports;
 	int hdm_end;
 	int commit_end;
@@ -761,10 +763,9 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 					 resource_size_t rcrb);
 
 #ifdef CONFIG_PCIEAER_CXL
-void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport);
+void cxl_dport_init_aer(struct cxl_dport *dport);
 #else
-static inline void cxl_setup_parent_dport(struct device *host,
-					  struct cxl_dport *dport) { }
+static inline void cxl_dport_init_aer(struct cxl_dport *dport) { }
 #endif
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 7de232eaeb17..b7204f010785 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -45,6 +45,30 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
 	return 0;
 }
 
+static bool dev_is_cxl_pci(struct device *dev, u32 pcie_type)
+{
+	struct pci_dev *pdev;
+
+	if (!dev_is_pci(dev))
+		return false;
+
+	pdev = to_pci_dev(dev);
+	if (pci_pcie_type(pdev) != pcie_type)
+		return false;
+
+	return pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					 CXL_DVSEC_REG_LOCATOR);
+}
+
+static void cxl_init_ep_ports_aer(struct cxl_ep *ep)
+{
+	struct cxl_dport *dport = ep->dport;
+
+	if (dev_is_cxl_pci(dport->dport_dev, PCI_EXP_TYPE_DOWNSTREAM) ||
+	    dev_is_cxl_pci(dport->dport_dev, PCI_EXP_TYPE_ROOT_PORT))
+		cxl_dport_init_aer(dport);
+}
+
 static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 				 struct cxl_dport *parent_dport)
 {
@@ -62,6 +86,7 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 
 		ep = cxl_ep_load(iter, cxlmd);
 		ep->next = down;
+		cxl_init_ep_ports_aer(ep);
 	}
 
 	/* Note: endpoint port component registers are derived from @cxlds */
@@ -166,8 +191,6 @@ static int cxl_mem_probe(struct device *dev)
 	else
 		endpoint_parent = &parent_port->dev;
 
-	cxl_setup_parent_dport(dev, dport);
-
 	device_lock(endpoint_parent);
 	if (!endpoint_parent->driver) {
 		dev_err(dev, "CXL port topology %s not enabled\n",
-- 
2.34.1


