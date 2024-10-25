Return-Path: <linux-pci+bounces-15360-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 468749B1165
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 23:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A473284556
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 21:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DF410A0E;
	Fri, 25 Oct 2024 21:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="neo0BIP5"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516AB21441D;
	Fri, 25 Oct 2024 21:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729890297; cv=fail; b=LrVIrgPT06yVt/ssU+yzW2Ioh2hII/GEi5Pv4DugQ/bPa+2fMiCxyTP6CGiOxRTIKD2nFq5p4V4Rl4QxWXU7iuTg9nR8OopWNgEnRgLpkw42qSQXHve1nzCQX+QxU3wIZAsYex+KfngBnWY5x+QNuZwCCFzATqOKK4IN8LDwe/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729890297; c=relaxed/simple;
	bh=4LW4XSc59CyRAG7ITnRUURg6U1X9Rt9TBKTTHj/9lxg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DQdL/WPRG1HZKI+V73sJLxSLlb3Ga6C/DMvkcsbnBXU9zdGlZulLKVwZ9QkPPaTXmo0DbK3KKHJ1vwLEZHjjiVPPSfKYtrqUJsX6hYAmWuFlQGyQ+2chVoWKl3mqeK+E9R7SyUOqkzPJPBPj9G8wKWiwuXLiKIjCjOfv+ExI2Kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=neo0BIP5; arc=fail smtp.client-ip=40.107.244.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4Dp1GAMJw++zkFX960srb0RDVRzuxqQh8UeXlmkob3i+LPwCaooNSkMId37AIgu0dNWHGRwl3tIo0+eQtiHf3EYpp6Q2KXKSmDD/F2d9soNmVG1/A6gHnWbce6p9yrnUsMCxVsSyxI0jxicgq20TO2nKFKFVU2l0VSFfIKUsIz3crHq3WUsu8NlviEJuI3rtUW3gaIU0dkqsmmgaGrHb13bY62YYBHVVO36f/Rfi/xMqVyfvFf3pFmxK/QFhkfRO/XIuNP+9eFg9CXyzYm0EEJG3OoXlr4/wBLkLJ78577jAQRRPrfvl81C/JGAiSqoIcFEg0yV9LyXfnipwuWxgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wljKaQXriCA88e08x5mQCbE2H+gNf+KG4Nu7K2vlc0g=;
 b=W6mQeRGWfQAUWdtdqYgGojMwed+1oYmmLojMudi5TkDX8Evby3ZuUqp7syRZK9lXllF3abaHzBAF8qzM4swC6PYXZDeO/yy8Ey5A+Zdiy3lwLux8PoPO6qjwXLPAiAmVfQ2XM1Th6p085cLB5hPHud6qR+eHpiqEc3+kO2tZim+ErnOA0WEchEHpn+MjLBxbho89VyGsW1YKvb2WduVusZhCdqj0mFnUYaEm80QdvbqJMS4ooqeHGWxg2N/bxf0CjK2NCTcZSUJYvXwRBt/cTCyQVuP5NliB1czg+puYTGGs3GZvMYt6eO7xcrp2A/4nJktsYR3EZEa3lmJWluOtzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wljKaQXriCA88e08x5mQCbE2H+gNf+KG4Nu7K2vlc0g=;
 b=neo0BIP5QrPyL81pI0MOAxIHctT3GKuGIeM1AcQZvQMGPJm8JX7k4HTW0fwPm8Szy7kjrCIaMbcNquNYnUgYhtMk61nGONtjvLTWW1FAKP1BBz+HvAg8PPcEvps1c5Ak9ArGynBm4CVdrYP0A9LcFwHcpwt05B2fd5Y+GAC/Pew=
Received: from MW4PR03CA0289.namprd03.prod.outlook.com (2603:10b6:303:b5::24)
 by DM4PR12MB6327.namprd12.prod.outlook.com (2603:10b6:8:a2::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.21; Fri, 25 Oct 2024 21:04:52 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:b5:cafe::20) by MW4PR03CA0289.outlook.office365.com
 (2603:10b6:303:b5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18 via Frontend
 Transport; Fri, 25 Oct 2024 21:04:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.0 via Frontend Transport; Fri, 25 Oct 2024 21:04:51 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Oct
 2024 16:04:49 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v2 09/14] cxl/pci: Map CXL PCIe root port and downstream switch port RAS registers
Date: Fri, 25 Oct 2024 16:03:00 -0500
Message-ID: <20241025210305.27499-10-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|DM4PR12MB6327:EE_
X-MS-Office365-Filtering-Correlation-Id: 571f49ff-d336-4644-2ed2-08dcf538ab0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WrjWeA/VCZiBF1S6Ju9/b2G0QfWufpqU0VbTetwHjLCtqepOzahL6oFpg2jB?=
 =?us-ascii?Q?pXEqTl0Dqb/4azs5EcheLebCnuIRPl7jGfWh1SRusUlsTpRPo96lZyq7s+am?=
 =?us-ascii?Q?RwlFGld/ea4ITMUoloMURybFZZsX8NRyTIYNB+Hey/crXvy59U3+HuZZpQSa?=
 =?us-ascii?Q?Phfd8ypE9t63iSKDS2pSYi3v5Qlm7FLJjINakYm0oVj4fdCgOJTtLh5xJaEC?=
 =?us-ascii?Q?q2ugJHlRh7u6AaYjxGF2W0+8bK1FVuXUxy3HSr5+damn0CGnFsjxRZ4Q/ugM?=
 =?us-ascii?Q?W4lFPZYo0uSOYxfAlOIcL4rijrqauQE8YNVnorbev/8aUNjPU6PnFDYFZsU4?=
 =?us-ascii?Q?cGJ/VltPnWpcbQ8huKJN1xQr/4d5reKsiLK7rNVP3fz627JRZ3wFoCZtmAXj?=
 =?us-ascii?Q?s6y9uIaFU1O0FZ017K/M6Mn0MbOFlJui0e4G4YXNJ6jRsJwc84P+j7YCWg2o?=
 =?us-ascii?Q?ylZJlgNGEMeXegoQH+fWZyrcLOGmnruj3RpnplupcDcNYJJV/9NZ3j9otqS6?=
 =?us-ascii?Q?2obPMXw/JU3/yAd1R5QqYpH6LyGVizf8fjLwgn0jpKa/qbWP92GuQURfOv9Y?=
 =?us-ascii?Q?pnxHUiONZdDwHrrpNWlwgnsKtFyrTPiANhxGr2FNSY8an8Z8oWymD01aMOay?=
 =?us-ascii?Q?7O2O5JskadQNWbSNgyZqd7EDUfjViROKHlF6jAJewJ+W1ZbIX32kgOvsHjM0?=
 =?us-ascii?Q?P5uXHCUSwLTmzxvs0QRga057AOVzSLEJ/OhD2YEP2qLcUsIRBdkL9Whp8Zjq?=
 =?us-ascii?Q?HFy9qQ7Rv7t6l9n8KnP/NN+PF0jVaBDi6/Ah1EwhLn0Ct2zvXi90rZvVtmpZ?=
 =?us-ascii?Q?LhLEXpWfTJxIVu3xzwyn34lqbZiPkF04lbCmCHubTdk0SkGLjzosxiydEXyT?=
 =?us-ascii?Q?ZnMsES/bldSUGaAyD0tZ50KJrInbnltSNfMeoaL/HJ8ziURS+65v6BV1dZMF?=
 =?us-ascii?Q?0DVsMfjqR9PLSwC9DGQCDC4LjqIeW2ENE/wqiQr4d5Fd3Y5N1O7hRv6oN+1F?=
 =?us-ascii?Q?CWjOUugNgkqNr/fZLL34h3EIGA+VfMZ3VeqoLoU9ulEgIdGY35BOE0WTsiF7?=
 =?us-ascii?Q?s4jsRRUm7leAH0ZTF8siFmaDZ1cmj77UU6deFDgFdNm/ZOeBuYXYNOQP13yo?=
 =?us-ascii?Q?ODIHVSilBJ7uWjL02lgTNm4lQcR7M2NNbj7tS2pExAXE7JPxa5X6jVGgGhbb?=
 =?us-ascii?Q?g+323zOpdF7oR1MvDMJuGZj4a4SuvIrgtDLZ0s/RRa+yHMJZHjkmBdaUJ2hu?=
 =?us-ascii?Q?zd8pixMKgSlYiWlvOCxQ4XfrXQW0IywKIpfjFjw6f/jA91eHSmrbwqeKS2hb?=
 =?us-ascii?Q?RJ0OYCnmS4/ikNZ538NEAx7x3RltqYUzmIGK5hDf/dLCCa9TgDNh1peNoaC7?=
 =?us-ascii?Q?tV3O6Lcx12gqOTo2KzHZufM/NiK5?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 21:04:51.4699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 571f49ff-d336-4644-2ed2-08dcf538ab0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6327

Map RAS registers for CXL PCIe root port and downstream RAS registers.

Refactor and rename cxl_setup_parent_dport() to be cxl_init_ep_ports_aer().
Update the function to iterate an endpoint's parent downstream switch
ports and parent root ports. It maps the RAS registers for each
CXL downstream switch port and CXL root port iterated.

Move the RAS register map logic from cxl_dport_map_regs() into
cxl_dport_init_ras_reporting(). This eliminates an unnecessary helper.
cxl_dport_map_regs() can be removed.

cxl_dport_init_ras_reporting() must check for previously mapped registers
within the topology, particularly with CXL switches. Endpoints under a
CXL switch may share parent ports or downstream ports, ensure the ports'
registers are only mapped once.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c | 38 +++++++++++++++++---------------------
 drivers/cxl/cxl.h      |  6 ++----
 drivers/cxl/mem.c      | 26 ++++++++++++++++++++++++--
 3 files changed, 43 insertions(+), 27 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 5b46bc46aaa9..0bb61e39cf8f 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -749,18 +749,6 @@ static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
 	}
 }
 
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
 static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
 {
 	void __iomem *aer_base = dport->regs.dport_aer;
@@ -790,20 +778,28 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
  * @dport: the cxl_dport that needs to be initialized
  * @host: host device for devm operations
  */
-void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
+void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
 {
-	dport->reg_map.host = host;
-	cxl_dport_map_ras(dport);
-
-	if (dport->rch) {
-		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport->dport_dev);
-
-		if (!host_bridge->native_aer)
-			return;
+	struct device *dport_dev = dport->dport_dev;
+	struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport_dev);
 
+	if (dport->rch && host_bridge->native_aer) {
 		cxl_dport_map_rch_aer(dport);
 		cxl_disable_rch_root_ints(dport);
 	}
+
+	/* dport may have more than 1 downstream EP. Check if already mapped. */
+	if (dport->regs.ras) {
+		dev_warn(dport_dev, "RAS is already mapped\n");
+		return;
+	}
+
+	dport->reg_map.host = dport_dev;
+	if (cxl_map_component_regs(&dport->reg_map, &dport->regs.component,
+				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
+		dev_err(dport_dev, "Failed to map RAS capability.\n");
+		return;
+	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, CXL);
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 0d8b810a51f0..787688e81602 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -762,11 +762,9 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 					 resource_size_t rcrb);
 
 #ifdef CONFIG_PCIEAER_CXL
-void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport);
-void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
+void cxl_dport_init_ras_reporting(struct cxl_dport *dport);
 #else
-static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
-						struct device *host) { }
+static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport) { }
 #endif
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index a9fd5cd5a0d2..240d54b22a8c 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -45,6 +45,29 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
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
+	if (!pcie_is_cxl_port(pdev))
+		return false;
+
+	return (pci_pcie_type(pdev) == pcie_type);
+}
+
+static void cxl_init_ep_ports_aer(struct cxl_ep *ep)
+{
+	struct cxl_dport *dport = ep->dport;
+
+	if (dev_is_cxl_pci(dport->dport_dev, PCI_EXP_TYPE_DOWNSTREAM) ||
+	    dev_is_cxl_pci(dport->dport_dev, PCI_EXP_TYPE_ROOT_PORT))
+		cxl_dport_init_ras_reporting(dport);
+}
+
 static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 				 struct cxl_dport *parent_dport)
 {
@@ -62,6 +85,7 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 
 		ep = cxl_ep_load(iter, cxlmd);
 		ep->next = down;
+		cxl_init_ep_ports_aer(ep);
 	}
 
 	/* Note: endpoint port component registers are derived from @cxlds */
@@ -166,8 +190,6 @@ static int cxl_mem_probe(struct device *dev)
 	else
 		endpoint_parent = &parent_port->dev;
 
-	cxl_dport_init_ras_reporting(dport, dev);
-
 	scoped_guard(device, endpoint_parent) {
 		if (!endpoint_parent->driver) {
 			dev_err(dev, "CXL port topology %s not enabled\n",
-- 
2.34.1


