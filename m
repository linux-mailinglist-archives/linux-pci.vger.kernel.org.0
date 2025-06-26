Return-Path: <linux-pci+bounces-30857-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F12AEA9D9
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 00:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 264E57B681B
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 22:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7183276037;
	Thu, 26 Jun 2025 22:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="veJfSIk7"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D710D20487E;
	Thu, 26 Jun 2025 22:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750977885; cv=fail; b=c7l7dgf9ghpsgdb3ByluRYm9b+x7K2XdD9z/xlunVTY04aCqlNzdLyGy7NrYMffPrlihdQqsuFuTsS/2wFrIqo2r5vKPr4evcMMlh952qc3wmevSK4UuZVaqM1oudxaEUftR9NzTOritKUN9dTYOwSrJfz2ZCdyeKUCkRzWYmVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750977885; c=relaxed/simple;
	bh=WxMSrdED2etYhjDwAzSHO77AUwuO2rrUf1UwNVsw7Tg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qJPjwk9d3nKeaER/MmRnbC6QcLgGA8/V1naD/NDSnjbDXUaDIpv4F3IbnQa0pDzPDFxxdrtLCWjuURdw6OcftVSF6r1n0cSCL8HoRCtgV71dlOHU2TooqW3jIwqkfjLfO10U/S8B7V71dYOLdtAF+tQUhSdMFsYGDJ89hqfgqWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=veJfSIk7; arc=fail smtp.client-ip=40.107.212.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fUAwav4eTeC8hagTqzBv3sUfXPk7xBR4c6rIs4Tl1pyMvlEY24KbDlWh0n41rPqOrxhlt7/Ai/pfzuH2DkGkYWstHuHP9CpMeQBU+RqOE9SIPv4VG4CyGTPc5DwWt6mwLPh88SQNgT4KW09RQxYsiA8Y+ZU0oHCkR4BvaM8L+HaTebHZQoHIDHWaUCgbHwxOFmklVOf93Uu3/Ebm8j3rArOoq3nLSL+WHJmgtw3x6hxIqFd+ZGWH12HIdfkKVonTfWuSEdINmdFWuOg7gOBnKxyntjtlL2x7MjjKalTIrEOwZhrp9qVOV0Ac/xY1oER0YJtZ5yvpI/FObM2l7phhvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRhfWMKISiIfaNqgc/1T2w3jO7CuT6pi+ZcRwxxq0Qc=;
 b=OurZ1IGnDnrmsGgkk8yz+ceTnY4lgK4PvVR4NRgzKaAStEalbJKZFxBZt/jxgMSZS+QBaTHmzWj50RG40UQytfQw+D+c0voPVj9CTj5sqXffgBybiRUuixI5mN/UPqSMuzGlO+PKrXfj+URYF86io+W8MzuGYnvlO2RoTj1OKxCwC5ClEX64tFTxvEGuOi3zO9qKPJP5+IOpyo3lFM8rVsQ+h9ahWRZ4jUg4adrMMRP/LiaCkQ2dqTzaiE8Ghr4ajOXFUHpOFwbVfGjJKiRkS3Ls152VbQwtnpBSDXUrBIU+TVbqZUUGI25JTyB6IdAUZMWzmATwu7ej7lLGklIwZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRhfWMKISiIfaNqgc/1T2w3jO7CuT6pi+ZcRwxxq0Qc=;
 b=veJfSIk7bPCTArLdV8ZO1vo6RTn1QiKUXV7C75Ivgx22V6AujQ1LfO0W0KbS5WdltdMcig38EVCB51EDXAxOMQd8qdm9mtBO2LqZN5O+zfivOn8mRfvQaPtih+FOqtCE2i3hE0Ug/TQQWhD5RNYrneSV2sjNaCy6E1cmvgCURBs=
Received: from CH5P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::28)
 by MW4PR12MB6729.namprd12.prod.outlook.com (2603:10b6:303:1ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Thu, 26 Jun
 2025 22:44:39 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::92) by CH5P222CA0010.outlook.office365.com
 (2603:10b6:610:1ee::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.20 via Frontend Transport; Thu,
 26 Jun 2025 22:44:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 22:44:39 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 17:44:38 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v10 09/17] cxl/pci: Map CXL Endpoint Port and CXL Switch Port RAS registers
Date: Thu, 26 Jun 2025 17:42:44 -0500
Message-ID: <20250626224252.1415009-10-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250626224252.1415009-1-terry.bowman@amd.com>
References: <20250626224252.1415009-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|MW4PR12MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a3e746-104b-4717-b696-08ddb50308c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zaii6CIqwY4PoCW1YPwgvoxXxP8RrG1EoXWM+rPaumJ3VqFEIGBvjUo7zZPi?=
 =?us-ascii?Q?EFOv9Vyl0iWSp0nGUR4p/RG8LD2F/NCdWNoTH9u9cqWxQGfLG098HbcCbGZT?=
 =?us-ascii?Q?XgnydZYz6GrKaXXJrgK5kC6g3S2PXn6msn+QmLmaTzoDyDuJCsLGE718tUVI?=
 =?us-ascii?Q?KmDoTrOIM/ay+XSh4EIbyWQxXkvmNXTpQA5lMDY8ywJNHMMECltO1mnVVIoR?=
 =?us-ascii?Q?wYcry98PBPJkXD+mX5yn848UKniXCMRtiuUZinuzuoQw3L57DEQuGGuXIqer?=
 =?us-ascii?Q?AUcveY6IfLjYyGVfDy14lHKoQ76B3Gn4b4idUz0rk/2DyDcZXLHqIxxlT69H?=
 =?us-ascii?Q?YcGvmMroy9gvfgMFm0bSOMxrshCupHORyOuCRCtRqtGXWWkTaA0R6g/unvV4?=
 =?us-ascii?Q?C7uUIvy3e9ZMcUSkniEf+adkZ1MVKUA3S6JSiWVgeyub7Gh8+lzqzY5XjhYy?=
 =?us-ascii?Q?LkIbcTWRrLLnMzaEY4/a63ytSBjsFW14p4fKfejMlpMQ4nMRtH5QZDIgFt+l?=
 =?us-ascii?Q?Xh5L7UaK0AIyXw2xX5Cmlr6aDPCnMhfHBWNQNo/ecCoMtM33t9zJ0eqT1V8G?=
 =?us-ascii?Q?EiQ0YPS4GclD6QQBNPri+i6sLgzrt8yJ6xt8YX+gxBiE8PuxRERE1eUhBFro?=
 =?us-ascii?Q?/BCZVHptO62K1fq6y7tCJfCxI56chYafv+HuSTsHdJWkIFi/Zb5lsp5ylMYD?=
 =?us-ascii?Q?EqN7ARidmnfT59EJZrTyItHUW37fXoR519SUKZIWTxUHdQfxq74heHLgW47k?=
 =?us-ascii?Q?u0uFV5YVN9nKgHPvM650WJ613KTdIRdcRWUWOhsIJxFy80BEJYC7FgW4MB6w?=
 =?us-ascii?Q?AMaCV+9JXRVspmzq7dsnc1MhbxMYlDvT1JZqBpBU8R8jVgOB3vzulECStpmL?=
 =?us-ascii?Q?33bHagN8zVOi5bbZ6FLheuet6/gQYmENQSUdW3a7GEl9oSPWG3Q/ATQ6kFff?=
 =?us-ascii?Q?GquZqtYcEQauJ/XLI3at4w+tEzU48IpwPkEFMkaT8VtXn3KSLPnLG2agDxgV?=
 =?us-ascii?Q?YR4uJQ+imuGANcu5eKHHx24HjrBEEfsZxSQ18JoqcoqpB4PayT1c+y2EQNxx?=
 =?us-ascii?Q?jOEYzFW/u0pA0PFHITj664SOCamZcQDkOXZoJz2UUPiK6CuiW7JsT2uGzlG1?=
 =?us-ascii?Q?DjIy+d4FKKQ2EFdv7jmJ3HngSsBHsuHlb58qNVDnLxZ7bEb+Zak91XJ1e1AO?=
 =?us-ascii?Q?vX9DpQ8kxNlUeH4kfqqjz2TzL3DX6K0mlX7Do5M6YVrmID7vEZ1WIBWwYnj2?=
 =?us-ascii?Q?yzfDzc9DMpBJoFEvt9Xqg5La7bsuAz36wNj6qeWlS8T8gNyOqjiFKRoDkWri?=
 =?us-ascii?Q?9+ym/BjJtABoysCAU8w1J9G6fGmERdhEKw4LsHww1rhRlVJYrc/pz66LpDRe?=
 =?us-ascii?Q?w+efn2lpRJkEeKJkgW5ZRez4C0PpvflbpurLzwl5dtBdp2KP48i6eIZEWF3T?=
 =?us-ascii?Q?OujVHLn44AYAbm2JwpIA70p7w4ESM7sXrFG2Jhi5mcgdBvYYlsUFy2t9v13d?=
 =?us-ascii?Q?uWWHDDkSEYsOToivOUi/4D0kQu5B69y/zI/WouCZbkMDthPKW96aL5oiEA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 22:44:39.2558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a3e746-104b-4717-b696-08ddb50308c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6729

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
 drivers/cxl/port.c | 58 +++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index c57c160f3e5e..d696d419bd5a 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -590,6 +590,7 @@ struct cxl_dax_region {
  * @parent_dport: dport that points to this port in the parent
  * @decoder_ida: allocator for decoder ids
  * @reg_map: component and ras register mapping parameters
+ * @uport_regs: mapped component registers
  * @nr_dports: number of entries in @dports
  * @hdm_end: track last allocated HDM decoder instance for allocation ordering
  * @commit_end: cursor to track highest committed decoder for commit ordering
@@ -610,6 +611,7 @@ struct cxl_port {
 	struct cxl_dport *parent_dport;
 	struct ida decoder_ida;
 	struct cxl_register_map reg_map;
+	struct cxl_component_regs uport_regs;
 	int nr_dports;
 	int hdm_end;
 	int commit_end;
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 6e6777b7bafb..d2155f45240d 100644
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
index 021f35145c65..b52f82925891 100644
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
@@ -127,12 +137,54 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
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
+	if (is_cxl_root(to_cxl_port(port->dev.parent)))
+		return;
+
+	/* May have upstream DSP or RP */
+	if (port->parent_dport && dev_is_pci(port->parent_dport->dport_dev)) {
+		struct pci_dev *pdev = to_pci_dev(port->parent_dport->dport_dev);
+
+		if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
+		    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM))
+			cxl_dport_init_ras_reporting(port->parent_dport, &port->dev);
+	}
+
+	cxl_uport_init_ras_reporting(port, &port->dev);
+}
+
+static void cxl_endpoint_port_init_ras(struct cxl_port *port)
+{
+	struct cxl_dport *dport;
+	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
+	struct cxl_port *parent_port __free(put_cxl_port) =
+		cxl_mem_find_port(cxlmd, &dport);
+
+	if (!dport || !dev_is_pci(dport->dport_dev)) {
+		dev_err(&port->dev, "CXL port topology not found\n");
+		return;
+	}
+
+	cxl_dport_init_ras_reporting(dport, cxlmd->cxlds->dev);
+}
+
+#else
+static void cxl_endpoint_port_init_ras(struct cxl_port *port) { }
+static void cxl_switch_port_init_ras(struct cxl_port *port) { }
 #endif /* CONFIG_PCIEAER_CXL */
 
 static int cxl_switch_port_probe(struct cxl_port *port)
@@ -149,6 +201,8 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 
 	cxl_switch_parse_cdat(port);
 
+	cxl_switch_port_init_ras(port);
+
 	cxlhdm = devm_cxl_setup_hdm(port, NULL);
 	if (!IS_ERR(cxlhdm))
 		return devm_cxl_enumerate_decoders(cxlhdm, NULL);
@@ -203,6 +257,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	if (rc)
 		return rc;
 
+	cxl_endpoint_port_init_ras(port);
+
 	/*
 	 * Now that all endpoint decoders are successfully enumerated, try to
 	 * assemble regions from committed decoders
-- 
2.34.1


