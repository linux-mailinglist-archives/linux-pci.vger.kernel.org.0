Return-Path: <linux-pci+bounces-16707-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0909C7DF7
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 22:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5A5FB29423
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 21:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F5518C02B;
	Wed, 13 Nov 2024 21:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nTPJWWmY"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4ED17DFE9;
	Wed, 13 Nov 2024 21:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731534982; cv=fail; b=qdJ/VVOAvYfElpwi+CDHOTIywiWLFCVz3zy83HKk29l3FCHr5rlE7hwefqDbJ+DQ2VwJ6pWCQWjS0RkFvPvVRcmiTnNT2l/jwZiLSEZdrqofpnP5L+CfJEhzhiZdKQU7zh5iPjMH1vWAqOM177UdfcobG5xEr6MEu9Liw0iUzOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731534982; c=relaxed/simple;
	bh=gHwMViiuJv+gSAokVz0DLiY4n3M/XWV5X/9tBTXvmuE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sr5Bg0/VvipPb5EIHs57K7NjxC176R9+rTZeJqVRgnhryPxT9jWHYP6JZnLi8LRW7Mqzrkm+XGS560NP1ROWefEgQe6YZWuBdskLKV5HkBYIyF5tbcCxNqRG5JaRWtr9e0EuDRC07wPi+g5ztUp/hg339vlVxwyrAJPA4nEcl1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nTPJWWmY; arc=fail smtp.client-ip=40.107.92.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFrn/oUSLkN+pJL4fLbjJB62bEcU4xi5tqSgQmxLpXQTv3MnmAo/K+0YrwFNaTtF2qe3UGkkCrsIIc5qWGGO/mGi8gxFT9aBh0Ty7klxne/eEJNy4UeogDk7Lp5xyDwC2S6q1lwDXo1lrcyqDyFNNBykkaeVm2Luq6U2CAWAJCLJCY0jhiFy1k1eIP/GaPcORz0RyC8ek6P6NnruHvVTzbQbYDOjxDXHRzoCA1sLKZmNsXshRqIxQamAT06MBn3ossp70zJfGjMgo+2e928c5PmOqjS5tRg2TkPDIeE5+PStMgLHAV3CbTw7+64lm2JLUGQViYMxTjwzgmetu7vNDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1llUpPaucmEMfPyGI77Sv8O9WKWROD5ZY+zEYWKzxI=;
 b=iZCp2ijLqBu9jTe90DEQDzjKECKrsAEZCaaVaIKTyYgrtCSvffEedyi7ato09EJFpb5PJDZAeTxwdTRyxlPPxbQJHH9BFVvvPdJNJYQ+VuUKwqDlG/4k+hhW+3oPQdoUWCVV4Rk0M5alKz+r/6KMPfcr79uiOX2xhVHxQxW90RZvvvcHvFMjlCOVrblXANUE4f3EgH7+ZuF/CPqXVIyEi7L5oBIv7nZQXQ7D1mFBZTDLHcC2d54uWAQgyV1uRfkpcEIRo25JHbLpptNuQB2/edYgL61GFjNbs1rMm/OKU+5gjf41bynsTRJSjV14ioADhyt5kx3F1i+6yrNdenafyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1llUpPaucmEMfPyGI77Sv8O9WKWROD5ZY+zEYWKzxI=;
 b=nTPJWWmYLFohBL+BtzSS5aTnwzi361tj3ZOrKxTlIKX6JuXDJLmULNyxerkl/rJewZJEkoiU9IvZSZGJZFO2uXNq5q+DAoaniIj2haJv/XTPvN5GxRHXCKxd0AYJCQt3Iyan6vUCPhs5wKPxyPnVcr505SegPpfMceDgld4KtCo=
Received: from DM6PR04CA0016.namprd04.prod.outlook.com (2603:10b6:5:334::21)
 by LV2PR12MB5872.namprd12.prod.outlook.com (2603:10b6:408:173::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 21:56:17 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:5:334:cafe::ce) by DM6PR04CA0016.outlook.office365.com
 (2603:10b6:5:334::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Wed, 13 Nov 2024 21:56:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 21:56:16 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 15:56:15 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <ming4.li@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>
Subject: [PATCH v3 09/15] cxl/pci: Map CXL PCIe upstream switch port RAS registers
Date: Wed, 13 Nov 2024 15:54:23 -0600
Message-ID: <20241113215429.3177981-10-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|LV2PR12MB5872:EE_
X-MS-Office365-Filtering-Correlation-Id: 463637be-0005-4912-b595-08dd042dfffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?waDyWZi1s9p4NqfgdZTP1xSFHgI46sNBMvxEN90T5+CbtBS6SztSXd/ob8tp?=
 =?us-ascii?Q?NCiPfvfNpSJEzCbcg6pDq3rxTAvZtU5aE+WUanatjgPFamteR1Vwg9CPaEcH?=
 =?us-ascii?Q?qQ6QFYDqEXd//gqT5kRGS+rOfY6O/xfrfiPTDCvE9W/Ic3dVe0uDsRAGIlrK?=
 =?us-ascii?Q?B+Rm/MRAw9Uaw1xFKGvA+JlR3oKjasKLbktk8qPSEXuR0Fa4Cxt3JQMRRkpr?=
 =?us-ascii?Q?nq+tO5eqtTMU+sTlzpPll7niuhN5Qcw6cxOkj8hC02sGpw6Zxip6PJMvP/Wm?=
 =?us-ascii?Q?Uy1YVgGHJXuv1JLZNNvmfbJcDvpa5rrIZ2XKKsLTZwzwyRhGFhgUycU7VKSk?=
 =?us-ascii?Q?9V3Xg0LtLFRgqxQ5GE3a/XQNmnV0DKjLMpw2jeGomEfmDDjiguuRgB4acSgG?=
 =?us-ascii?Q?3gIeu7hGR3hf6/PHV7quybL2qtjepDfjzuXmOWe89I6S2ydFMvq8bnY5eJCE?=
 =?us-ascii?Q?sd3ptmSnrwq6HGGMmtSbKtZ1bh8QCEvg1f/MGBUFqhz9boqTNp8YVBYiVRNc?=
 =?us-ascii?Q?zwqwDk4WXZ2Cu7yWFGjC1FYl5VtI/Jq2DO/cfmETdmDNhOEH+uOiVwyZOJvT?=
 =?us-ascii?Q?AsB334EezXD5mVWO/Woav0bHX5+MvW+jfebiNy0x0zbSebYrC2Xnrjw7uhLJ?=
 =?us-ascii?Q?jtANqR0C9Jvp3akXxQJJ+4sGOmhsMaodyEJiVCi/3IatFOWC7TDQllv+0JK/?=
 =?us-ascii?Q?ukqlmZNV9iMhFiVWVHt6AsRsJlk+zARErenbc3BtibMZMY9jganHpR5f6gvg?=
 =?us-ascii?Q?jW0RasX1qZqEOqJ/6hwFT0zzNM15np22QcrCjqaV8QpcyKHr6vzgjgATSnVu?=
 =?us-ascii?Q?NhUXJhml67jS0puEzEKuNKF+ndVkmUXyd5DGDHtRik8FabVLk8jvI2XQvpYH?=
 =?us-ascii?Q?j+EsOTZuct5yYXdClPCROAB0MDkmKStFbnLdLaf9nKLmpJRuOcyJVTLhpQtH?=
 =?us-ascii?Q?1XCzwB40GwhE2n++BedJSY+FWGkQGzaL5C9Q7ddbtrl0r9nh0RRPdvmPXx8N?=
 =?us-ascii?Q?nRAIRC/lGLtT1XGbkO9R08kK0mK4CM8elyp+Na/0+ZYqBMgTmj9Q6ILbbgdA?=
 =?us-ascii?Q?DWIWi7b7X9KUdSYC1U5YIEWtM2rzvrap9MKaliqBXbK73C5o0uh11DGZ9cnQ?=
 =?us-ascii?Q?oVJKsPVm+ZvQMATMQY+29cHG4/4C7jDAr9f7zeyNxQ8doTVEzIkZquAJ1N13?=
 =?us-ascii?Q?eZQpj3itpZhHRZkYw0WDnD70F8ovzRBS8+Mi4dyn1ttHRFPdcmDvqmYwXiD6?=
 =?us-ascii?Q?E8Qzc3lSAyzVbN9NU4i6ycej788mXrvYer1jXl18SsnqwmLUbIYmGpap/y6H?=
 =?us-ascii?Q?gUu1LG50h5Ue5cOa4PeGQ9xaCatNbA3wUwTWDVJAlRk+8aXwD7eHjv3udXbc?=
 =?us-ascii?Q?7arX3jliJGCDKYK47UGoRz4NL2kYkH3EM1GSNC7FbDL7uGRa48NCSg6uDQcU?=
 =?us-ascii?Q?3hQyzRgYwRo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 21:56:16.9238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 463637be-0005-4912-b595-08dd042dfffc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5872

Add logic to map CXL PCIe upstream switch port (USP) RAS registers.

Introduce 'struct cxl_regs' member into 'struct cxl_port' to cache a
pointer to the upstream port's mapped RAS registers.

Also, introduce cxl_uport_init_ras_reporting() to perform the USP RAS
register mapping. This is similar to the existing
cxl_dport_init_ras_reporting() but for USP devices.

The upstream port may have multiple downstream endpoints. Before
mapping AER registers check if the registers are already mapped.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c | 15 +++++++++++++++
 drivers/cxl/cxl.h      |  4 ++++
 drivers/cxl/mem.c      |  8 ++++++++
 3 files changed, 27 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 1c6761278579..a9f891e9de8a 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -773,6 +773,21 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
 	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
 }
 
+void cxl_uport_init_ras_reporting(struct cxl_port *port)
+{
+	/* uport may have more than 1 downstream EP. Check if already mapped. */
+	if (port->uport_regs.ras)
+		return;
+
+	port->reg_map.host = &port->dev;
+	if (cxl_map_component_regs(&port->reg_map, &port->uport_regs,
+				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
+		dev_err(&port->dev, "Failed to map RAS capability.\n");
+		return;
+	}
+}
+EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, CXL);
+
 /**
  * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
  * @dport: the cxl_dport that needs to be initialized
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 51acca3415b4..0cf8d2cfcd8b 100644
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
@@ -764,8 +766,10 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 
 #ifdef CONFIG_PCIEAER_CXL
 void cxl_dport_init_ras_reporting(struct cxl_dport *dport);
+void cxl_uport_init_ras_reporting(struct cxl_port *port);
 #else
 static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport) { }
+static inline void cxl_uport_init_ras_reporting(struct cxl_port *port) { }
 #endif
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 090f0b74526f..160d0b3c3c28 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -60,6 +60,7 @@ static bool dev_is_cxl_pci(struct device *dev, u32 pcie_type)
 static void cxl_init_ep_ports_aer(struct cxl_ep *ep)
 {
 	struct cxl_dport *dport = ep->dport;
+	struct cxl_port *port = ep->next;
 
 	if (dport) {
 		struct device *dport_dev = dport->dport_dev;
@@ -68,6 +69,13 @@ static void cxl_init_ep_ports_aer(struct cxl_ep *ep)
 		    dev_is_cxl_pci(dport_dev, PCI_EXP_TYPE_ROOT_PORT))
 			cxl_dport_init_ras_reporting(dport);
 	}
+
+	if (port) {
+		struct device *uport_dev = port->uport_dev;
+
+		if (dev_is_cxl_pci(uport_dev, PCI_EXP_TYPE_UPSTREAM))
+			cxl_uport_init_ras_reporting(port);
+	}
 }
 
 static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
-- 
2.34.1


