Return-Path: <linux-pci+bounces-24807-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFECA72879
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 02:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A9178416A2
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 01:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527F77081F;
	Thu, 27 Mar 2025 01:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hU+TxITW"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504C613B5A0;
	Thu, 27 Mar 2025 01:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743040135; cv=fail; b=j/BxHXhTzfvJ4ZvukgivtYcJ6l+YGDd/AWUgS5UnECjaplMR+iLCu/c3PthGwGtu4/yEsqSbOWM+oTFscHODesHQuNJgRJlBXYF9r23SSxiVYzXhT8H0Ya7yDYivAhf3wShGFMayuhZEpppJCXjn0I94CfkmoShDHOSKncvHbkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743040135; c=relaxed/simple;
	bh=sqR5yahNyqmNJfiop7IPYm9UTRaFaYODMSuHzFECLaU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j7E9wvcTHRAHiOdFW9Vx2fFfjHEdxW7x51utLxhv7s/SM7SLJVW9VvQMdDz2k1pw9ttaFESbyNUzFQyH1WAPYWsFq50eG593Q2jbAatCt7ypab8T1ib7OuOgwzl8O9E3dSRLh6UFJ6dkQH2/QD5PD3gbaCZ8awniQkoqfIkhRgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hU+TxITW; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDouoolWRyWBTPorL+BZb0noaY/tpi/n/efZNtUa/P8nOQCv+rIePw21cThh9gz2THIc4X3WrHcQefiS2Gco8XfRvtTc0c5w76Km+kwTTzv9w5lZwjIkSxzETNFV8FxopxvvHQlmtrrD+0v5HkOFA7Lvg0CPF4zTyiVRqxLPQxgMAlLrcyqU7Zu+cLgAp77ArsLGFZKPJ7fVcBKbu9d4790/AIzpxdtWMgpm8EdiOtvjM+wPCJCfIpwJoMi03Y4KR8IUYTAOIGi421xA/6II28ftswd73VQJWOJ0BmoeMpVnhMb0CIlE/2wMq0r14dn/6TrDacIBbDNI8zXmof2lGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxZRgW4p4bQDvnFeIGlVFuNyT5lewFZIawA3zxvobVI=;
 b=D/en420PimeYiiVOASbfieCag9R0oK0jZgidps2D8qohFqJO31xPa1nG7b3RtJU3FTBLfyda8DfzLYTF0eVm9q7Ns0iI3HisUpUx3YmeD1FPTC/CyoNJ8/FhImiwJ4d0DoQjcjZsYYW9wkMghwSDbU+omUD9EMYbRtAGaRhjpNJ9X2vb3DghOLOxuHYll+NBwM6Rdd5XptdTrk0l+kyBM66KY6GRMlH9y8ITlaGW7pxom1dubinJ/5jjwfgwmL2V1auyWRLGwMNtWoz3/9oHNtYqXvZ3DrxeRWDfnhYvmEgOAbpVSnNtzheoBcVU3hvJXffcH9mMwJm/oSAnedcbbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxZRgW4p4bQDvnFeIGlVFuNyT5lewFZIawA3zxvobVI=;
 b=hU+TxITWPuihz4CTZqDdQZZIr6qFDQGEGCeazcBz5wjVQS1lSL26xKBffH/SPeH9RJuTorlrk5o85ZirhPCUCUGnfYjhWHO5ByX/SJ2m2mYP4eX7wNnQvrA6rNj+8h1zmgrZ3rhA2hs9yD5fn2zukhikqk1BOKZyN+GNevE9gWs=
Received: from BL1PR13CA0145.namprd13.prod.outlook.com (2603:10b6:208:2bb::30)
 by SJ5PPF0C60B25BF.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 01:48:45 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:2bb:cafe::4c) by BL1PR13CA0145.outlook.office365.com
 (2603:10b6:208:2bb::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Thu,
 27 Mar 2025 01:48:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 27 Mar 2025 01:48:44 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 20:48:43 -0500
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
Subject: [PATCH v8 07/16] cxl/pci: Move existing CXL RAS initialization to CXL's cxl_port driver
Date: Wed, 26 Mar 2025 20:47:08 -0500
Message-ID: <20250327014717.2988633-8-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|SJ5PPF0C60B25BF:EE_
X-MS-Office365-Filtering-Correlation-Id: b35d1f79-6987-4f9f-edd8-08dd6cd18227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ULo/SNJsIEJFNefoweXVXx3TJPDeX+rOD4ErMvDULO78Rtz04wDzGlxqCfZa?=
 =?us-ascii?Q?0tnVzuinwIJqUgL/v7LsrM5zRQRkD9b+XG5OBo9ntHqF97q/viNQdQw/ieG1?=
 =?us-ascii?Q?BGF0dP1uT+xn8YtxpPuUYovsJ66lFbgYy3/U2XAurSL2R0/4wnc6ydHLyR4W?=
 =?us-ascii?Q?IL9QF2sdSojp6ysO7/uDZx5lGdf4EZvqqApl+iYcbOF7w18XJJSKSOI4ZziV?=
 =?us-ascii?Q?F/sU9lHCrtH9QIeK3z/fjHvKtMAr24f+pPJ7FlzA0rwNHGapQWotT+Ib7ZIT?=
 =?us-ascii?Q?bRTPQ0bQtiXvhuTZZTrioBeWy6STLursmdSPCBl4yt5qzdw30qmHSM4QJhFq?=
 =?us-ascii?Q?uXFFcr3wPw7WIgsJEAgGMT2jcHATSNCNFSV6ChOWy49d+c3rzOX9FaXHiilL?=
 =?us-ascii?Q?UPCBccURPUF7MmeuWa/1ebQQJwQCLpXTEmFin5QiiwdBqhqVS01IwEnKvWJl?=
 =?us-ascii?Q?UznuZE6hx4Ym9psSVNfV+2K7XObnqOhF+Yqswxm3KssReQHMVvoRkLK/ME5W?=
 =?us-ascii?Q?PYbLl5QYRAHEV8+xeOJCk8yeB+dCWx1tBjikwojOtXBia4rnNlT+5jvFrbi+?=
 =?us-ascii?Q?TDBGSJeegsz12rfgd6g81uKwK9ot5YoxL/5VMz99QikprYRMv/jyunERxXj9?=
 =?us-ascii?Q?RuvHRe4l10zH1ltGvpKQXMLhgydgTxLrc9SS3g3iZoU63fgE9CaCNgpVQ5C4?=
 =?us-ascii?Q?P0M3/fGQ2dtFGfUo0pBsfW1sl4WdPY/ZnilfgVswwFHcFcjESZqbyglZwz3L?=
 =?us-ascii?Q?zmtVm+p6LUb9meGj8g6mH+XyI/c9lK6dTNeXViZTdDen9UvRWT+Q+9JtlB6j?=
 =?us-ascii?Q?ZjD++Nt3cAUGF/D431UvTiwX5DaYPvfUwlqRi9Js3xi3dDHn/P9nblTan/iA?=
 =?us-ascii?Q?ey1BAwwBykALZ2rPXK9xKhUNgcHk59Y1fs4lGfSWddB4xSqfw/iDU2tDNnW8?=
 =?us-ascii?Q?JK+ISP9IcUi0qmf788eRYnGmT6oBS827wmPfA7ckiOSJcjhRni4uE3kgNA56?=
 =?us-ascii?Q?ecU15EcRD2ykc4Hs4JBLwkrWgfvrtID5BJVLpYrFbgoSz4Gryj/WqxGKzFnU?=
 =?us-ascii?Q?0v2CrMCcJMLOoQ9kss1j6AHxNogy4easjKBNmHNuJdg48XTJ3Lt9c1Nrlmk5?=
 =?us-ascii?Q?GwfqkAHneoQ3BDNYkqxwjouHGpgWOTETZ6g6xssZUo4NcNkR0QDFsjcKmo0V?=
 =?us-ascii?Q?47A36SoG6dvhFsWPtGhqm/UTaQPh52649gn5vpW7XFiO6RBzoQmafHH1Ml14?=
 =?us-ascii?Q?jQBsX4lcWmYeoZD3ZZ29B/o+BVcuI8Wn33cEA2qFROokTwZzEmMDndUxE5U6?=
 =?us-ascii?Q?UuDWTI3i6LRkLT5gD3yAa+O7+OhV1gOnVAI2gRxApaz+3qFmBCEnyoAXP+nn?=
 =?us-ascii?Q?8/foUO4xSBCrPx6fLHCMOVr3huMQ+mk/FT1JpARPhPaEQ8GVXJP0iBh34O7C?=
 =?us-ascii?Q?MBfFqWAJS/4/zJCAfo2gapzkfvzyRNinSO181c903s6+a7OLDrVGw3KveS1z?=
 =?us-ascii?Q?WhZCIf2NtgbDXBmh2X+hfxRzXf3yQrEj+SEB?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 01:48:44.3629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b35d1f79-6987-4f9f-edd8-08dd6cd18227
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0C60B25BF

Restricted CXL Host (RCH) Downstream Port RAS initialization currently
resides in cxl/core/pci.c. The PCI source file is not otherwise associated
with CXL port management.

Additional CXL Port RAS initialization will be added in future patches to
support CXL Port devices' CXL errors.

Move existing RAS initialization to the cxl_port driver. The cxl_port
driver is intended to manage CXL Endpoint and CXL Switch Ports.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c  | 73 --------------------------------------
 drivers/cxl/core/regs.c |  2 ++
 drivers/cxl/cxl.h       |  6 ++++
 drivers/cxl/port.c      | 78 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 86 insertions(+), 73 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 96fecb799cbc..27ef3d55a6f1 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -734,79 +734,6 @@ static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
 
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
index 117c2e94c761..f3f85a753460 100644
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
index 73cddd2c921e..b2b55083886a 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -315,6 +315,12 @@ int cxl_setup_regs(struct cxl_register_map *map);
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
index d2bfd1ff5492..d5ea8b04400b 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -6,6 +6,7 @@
 
 #include "cxlmem.h"
 #include "cxlpci.h"
+#include "cxl.h"
 
 /**
  * DOC: cxl port
@@ -57,6 +58,83 @@ static int discover_region(struct device *dev, void *root)
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


