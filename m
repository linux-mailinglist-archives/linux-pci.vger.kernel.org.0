Return-Path: <linux-pci+bounces-24808-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DE8A7286A
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 02:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D34A117CA54
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 01:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E881146A66;
	Thu, 27 Mar 2025 01:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ppLN3OI4"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D98E145FE8;
	Thu, 27 Mar 2025 01:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743040144; cv=fail; b=j7626C824xtI4oEPOXU6HC8MZ8CZZHJdcVxxXujFymzYea3JcHA09o3xEgDRTClzE46GVWh4NALRDCVCeb69OI7J9/E2JreR2GCjSWohuOSunUpyoc/3fgxs3VzXDEcqR9efKEBDCle/8nFMw/gDIKn8iBAVx+XHVeaTYL8GZ6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743040144; c=relaxed/simple;
	bh=bSEUIdqsyB747ePPRvkFgaQ7VOiO4shF5t5E6i8IKLY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gV+hhkCt1zAPpFSjL0o81Wjf2lQDQZJr7XI578l6zF1ciesXynuJEszbnyhbWDGG65xLOs2y4dJwWnlRVbyBxCv4sdageSFZm55WWJxDdJ0Y00PzByha7mDdv7ej9lsTPJVsA3KSPwM29XWD+BAAxOd4NJj2NkrkXBbH7dFAsIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ppLN3OI4; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXmUq1bZJc3sS5sTzkCFjlrbn0Al/o/obNxzFA0LN17oPlTvR6nvQjRjHPGccuoidLpLDn57KB15XY8lhWdkwrmMKOA4u2vB6JUiJkqqeE6sXZUoW1ozc6PVujgZceDOC0BCsz9efFa0TZCapvigUgDnQ0KtaB+79IhElnfj5dncIcb4GuMA0Outykh41hfvAtJy+OrCY18/t2GDhhggbocsNuiqGRWYSJRuRKIIhSN9qugCuGyXvwonk9+U+B5ZevR5Ngne0gsT4WWxfx1Y2soVoWUQvzI7mqJkfCDZYhTkwrj/YHrldwiyl1Mq011Ba4mrNN6Ypz9u6IyYrTowQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCdaIMK0zvBHMQ/KWNARZqDvqzGFnL4ri8TgCcrn5rY=;
 b=tgBu+aAVwYer+20rO9J4H1M2d4mKpks9OO2HvBZBtuoUmpUtQXNBIUMVt6SZip0XdcdIcsOoWeWwqy3NclN15ac/S+jw2klGmYBD4QlAiHZumGQ7Gxv9OjMWHa+hjuiVn3Zp3KLx2EKZFLJ6O33b2JXlTkwWq5xh6SAt68ey/U7o9q0zN01GgozSpvvPFMPsHyoRZriKr7e1rqsy6htH33wPgpJQZRduGbHoe4BA6V51cSiWNg5qX688dIcLQiZnVrGbk+2VdoghwLbk5OfmLBi/QlPi9Ey90LF3849V2JUu8pxokAtEP4nI0iO6C6Vw7xZ0i2+K05maeDQvY/PAOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCdaIMK0zvBHMQ/KWNARZqDvqzGFnL4ri8TgCcrn5rY=;
 b=ppLN3OI4TWSPysjsf4qfTxPDQ2gsxyLvT0num1Fk6CFxRSeCg0fBG9N4soZvK0XBhHGFPZJ1nFZvI9UdspPdrFiNXUfUrGIa3PVn+74+Moe2Z9S+KnUplWdD0yM/wR4uItENPvnABzFFp8y8/YEwkSngDSxPx8grKPuiFRsPjAQ=
Received: from BN9PR03CA0269.namprd03.prod.outlook.com (2603:10b6:408:ff::34)
 by SJ2PR12MB9162.namprd12.prod.outlook.com (2603:10b6:a03:555::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Thu, 27 Mar
 2025 01:48:56 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:408:ff:cafe::c0) by BN9PR03CA0269.outlook.office365.com
 (2603:10b6:408:ff::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Thu,
 27 Mar 2025 01:48:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 27 Mar 2025 01:48:55 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 20:48:54 -0500
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
Subject: [PATCH v8 08/16] cxl/pci: Map CXL Endpoint Port and CXL Switch Port RAS registers
Date: Wed, 26 Mar 2025 20:47:09 -0500
Message-ID: <20250327014717.2988633-9-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|SJ2PR12MB9162:EE_
X-MS-Office365-Filtering-Correlation-Id: f79d6f01-2975-4e7a-d089-08dd6cd188e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aIsaTqafNg42mjgK+TCZWsSRN8JrxaySzW+26ZKay0Idsl5LjFEgwG9pQ70K?=
 =?us-ascii?Q?TjZ2p5ZZcjswnHVyR+ZQqHqvbatREgrhy5FOmtuBst/Lh+DDpuLj9rcQxPXD?=
 =?us-ascii?Q?NM6fRukhi3TmbJaunucEx96vq35m6SkqufDESo+OVt19biw86ZSGa9IpnUUm?=
 =?us-ascii?Q?dsF7s7NhmI0QzDJcQIJ2U7Jwp6Um2Z7uJNaF87A1+nnYeYNvoTS8/SAvzST3?=
 =?us-ascii?Q?/5s2Jar8hJNApnXcr2nuOB6Pj5a1x96vuS4Hmjp7wikQtkCyn5+UJ2VhpVMD?=
 =?us-ascii?Q?2P6eBBzl2G8F3ZeNqPd2nVBoJXGaPEJZ7ZnguChP3uLM/zAqlc0vwV0ZbNxL?=
 =?us-ascii?Q?XhR/2gBkDAhgMJ3a5EwcHv0Po32A5Q3Nl7IuTCp9dg96PFY8c5VnOtIgW9ZW?=
 =?us-ascii?Q?n8VBuCF9bemte4e3U8KMNCINvffn07qzUMDxCRm92mK9dy10GUvibsCwIVMy?=
 =?us-ascii?Q?JsttsT6ScGLWY0vYfoEZU97RR1jb1P/I3CcGptGONVrNZSi1owuTuj6aqoDh?=
 =?us-ascii?Q?Wzaz5lTtbRrcbUPIabhDvK4crG3jKOjqSIp8w0TkRHiH2jnLrOcBzLLL7bC2?=
 =?us-ascii?Q?piyV/BFDojK12m3dj6Z+qjCh3EW0a9BiV1GP2ayxZsgrBbt+VK9QMoAxwtPM?=
 =?us-ascii?Q?3DhjcOHukgnuhQgNbIe0V+y9M1DJh2R7IwdcsZhlRD+wF/oVtjBodYNai70P?=
 =?us-ascii?Q?RFBUD8CLdOWoKCISjrRnNDmeBsuyc4K6B7kCX2uQN20Lj9w3Q3BsuSe4fAkU?=
 =?us-ascii?Q?UnG3GiwEinFJ6t4tSvbIzwJBgIj51LEFQ58ALJANQWgcQ2BKM6DqU+8HD82B?=
 =?us-ascii?Q?K/zbyl/x1f0XavM5PN2De5PxK2KMK+boxtMadJGHipsFMTh+hAwnKj08CODK?=
 =?us-ascii?Q?SSBq/BQemmGb/rC/TfWrmANI0lUuqG+CO7s4b1Fe2S0Avp8gnwSPjxkaD/Ok?=
 =?us-ascii?Q?OeEO8UlEurgromyRUFHLP1tdcNP8ad7eH10kEtFxg5TRkXi32UUgAl+susci?=
 =?us-ascii?Q?Sz5jYNTT/xvT+B/WT60s8UtRijOv+iQGmXXfMRYJcgmu4BLzDIiVLnaPAtK1?=
 =?us-ascii?Q?KubF5hYyKT6zAxtKlj5VR5iCmM9mO/O6C8HminyTGm2V7lMMk7/4WAB4q7Fb?=
 =?us-ascii?Q?8JXUuH48XJCCBTj5azYaog6g80b44xO/4EsCVrDf7hISXvAIugJ7TCB5pz7q?=
 =?us-ascii?Q?lQf4P6IsdfVZb76ffF42SKsSb7WUSm6LdYbUEzaM1vGYmzrf3y+AHHHBPqkB?=
 =?us-ascii?Q?NwUvcMoRbTB1eTQl6anHkhCe2j32YOHXyoB1FVcDL7X8XbK3T1Bs66c+nHJl?=
 =?us-ascii?Q?LzpH/WqFTLnXrTcDzex50DIhFw4oav9thEpsaNBJz38yG/VfIgeA/7fHNJNQ?=
 =?us-ascii?Q?2//Hx3SvXItWhwsNS+UrS7ckblq6Qu98LgIAWbSOIaY0JOriCYEwTadty24z?=
 =?us-ascii?Q?R49Wpq7Sp1rU8SrX+59Umrv2BiuvrdnhQHnxCTsKwK+oeVdYsJOt6nUKRIki?=
 =?us-ascii?Q?xjEEydTCKNEZ/rsKQ4jSgfTYGvm3Blz9k6Hh?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 01:48:55.6802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f79d6f01-2975-4e7a-d089-08dd6cd188e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9162

CXL Endpoint (EP) Ports may include Root Ports (RP) or Downstream Switch
Ports (DSP). CXL RPs and DSPs contain RAS registers that require memory
mapping to enable RAS logging. This initialization is currently missing and
must be added for CXL RPs and DSPs.

Update cxl_dport_init_ras_reporting() to support RP and DSP RAS mapping.
Add alongside the existing Restricted CXL Host Downstream Port RAS mapping.

Update cxl_endpoint_port_probe() to invoke cxl_dport_init_ras_reporting().
This will initiate the RAS mapping for CXL RPs and DSPs when each CXL EP is
created and added to the EP port.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/cxl.h  |  2 ++
 drivers/cxl/mem.c  |  3 ++-
 drivers/cxl/port.c | 56 +++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b2b55083886a..0d05d5449f97 100644
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
@@ -613,6 +614,7 @@ struct cxl_port {
 	struct cxl_dport *parent_dport;
 	struct ida decoder_ida;
 	struct cxl_register_map reg_map;
+	struct cxl_component_regs uport_regs;
 	int nr_dports;
 	int hdm_end;
 	int commit_end;
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 9675243bd05b..29dc4a624b15 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -166,7 +166,8 @@ static int cxl_mem_probe(struct device *dev)
 	else
 		endpoint_parent = &parent_port->dev;
 
-	cxl_dport_init_ras_reporting(dport, dev);
+	if (dport->rch)
+		cxl_dport_init_ras_reporting(dport, dev);
 
 	scoped_guard(device, endpoint_parent) {
 		if (!endpoint_parent->driver) {
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index d5ea8b04400b..1b8dc161428f 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -111,6 +111,17 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
 	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
 }
 
+static void cxl_uport_init_ras_reporting(struct cxl_port *port,
+					 struct device *host)
+{
+	struct cxl_register_map *map = &port->reg_map;
+
+	map->host = host;
+	if (cxl_map_component_regs(map, &port->uport_regs,
+				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
+		dev_dbg(&port->dev, "Failed to map RAS capability\n");
+}
+
 /**
  * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
  * @dport: the cxl_dport that needs to be initialized
@@ -119,7 +130,6 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
 void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
 {
 	dport->reg_map.host = host;
-	cxl_dport_map_ras(dport);
 
 	if (dport->rch) {
 		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport->dport_dev);
@@ -127,12 +137,52 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
 		if (!host_bridge->native_aer)
 			return;
 
+		cxl_dport_map_ras(dport);
 		cxl_dport_map_rch_aer(dport);
 		cxl_disable_rch_root_ints(dport);
+		return;
 	}
+
+	if (cxl_map_component_regs(&dport->reg_map, &dport->regs.component,
+				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
+		dev_dbg(dport->dport_dev, "Failed to map RAS capability\n");
+
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
 
+static void cxl_switch_port_init_ras(struct cxl_port *port)
+{
+	struct device *dev __free(put_device) = get_device(&port->dev);
+
+	if (is_cxl_root(to_cxl_port(port->dev.parent)))
+		return;
+
+	/* Check for parent DSP */
+	if (port->parent_dport)
+		cxl_dport_init_ras_reporting(port->parent_dport, dev);
+
+	cxl_uport_init_ras_reporting(port, dev);
+}
+
+static void cxl_endpoint_port_init_ras(struct cxl_port *port)
+{
+	struct cxl_dport *dport;
+	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
+	struct cxl_port *parent_port __free(put_cxl_port) =
+		cxl_mem_find_port(cxlmd, &dport);
+	struct device *cxlmd_dev __free(put_device) = &cxlmd->dev;
+
+	if (!dport || !dev_is_pci(dport->dport_dev)) {
+		dev_err(&port->dev, "CXL port topology not found\n");
+		return;
+	}
+
+	cxl_dport_init_ras_reporting(dport, cxlmd_dev);
+}
+
+#else
+static void cxl_endpoint_port_init_ras(struct cxl_port *port) { }
+static void cxl_switch_port_init_ras(struct cxl_port *port) { }
 #endif /* CONFIG_PCIEAER_CXL */
 
 static int cxl_switch_port_probe(struct cxl_port *port)
@@ -149,6 +199,8 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 
 	cxl_switch_parse_cdat(port);
 
+	cxl_switch_port_init_ras(port);
+
 	cxlhdm = devm_cxl_setup_hdm(port, NULL);
 	if (!IS_ERR(cxlhdm))
 		return devm_cxl_enumerate_decoders(cxlhdm, NULL);
@@ -204,6 +256,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	if (rc)
 		return rc;
 
+	cxl_endpoint_port_init_ras(port);
+
 	/*
 	 * This can't fail in practice as CXL root exit unregisters all
 	 * descendant ports and that in turn synchronizes with cxl_port_probe()
-- 
2.34.1


