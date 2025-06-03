Return-Path: <linux-pci+bounces-28893-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFD9ACCBFD
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 19:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D9F716B459
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 17:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26E01A4F12;
	Tue,  3 Jun 2025 17:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SjRltPtJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2051.outbound.protection.outlook.com [40.107.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B747E23A98D;
	Tue,  3 Jun 2025 17:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748971451; cv=fail; b=b/07AXGutmkVNu+qH/gkd+eZRNGFAsazhTVfHZuaBUtHpayw/9j3FuOEICzr4v6UySHXxgjPZDt8AjVvJjxZHsETuutQZhdyMuld3rXNf1QqYq5trvxtbSY3zRJyOu1++k9/P3Lvvzz/pyjF9peCb3nrpuOF0Xy3YScNw1qv/Wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748971451; c=relaxed/simple;
	bh=DTi8BN2RcdSPDVnQjsXHYJh56+yfWKOisZO3GoIvyP8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nU4n/2dEcGPwRNtPTE4dtIJFEKmMm3bay5tUvgZxKJhbbs4u7Jm3R66cNNj9d3+7c72lfn0Y8/ZVOpbqyLBVMfA6YtBNVL8c9l8e2FHsrbCLoCUcTqvS3twl8qTE4XNSijZOKnzigXHcWtX3b0XEf1E5ZHIMnVcfR4Xcqw4thzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SjRltPtJ; arc=fail smtp.client-ip=40.107.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WyiYgEEAEYU2ZYysEnCWBJWvO2GfR88r1CkxP0ddt7C+1AIHHA6nsI09Q//no7U5/KpjsPeRH97d22nM24EMOYbbILTJ+SRCFR0Dnm5rhDCyPv3kFQi98qsClWyf1tlCizQHFEXjVqwBU1qOVdx8v0nn8fySiNym7yqMuqhltRRZ/ZYd3vq9MOkNTRL0SJeFevQMHfwQwsi/XxU3LmIkMBcH9jVEFj1i0WOKcDLxuwhTWFkod0R6tHln5I/NOl9aqNX7ksYz6H1Wuy95n2wxl3t2z1OvbCs9qdsB8EonAhOozE6Y5YuJzwWvHZ5dSnWXAO0CHGPQfC7XfmFihGqUUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0dNDMGZ66tEG/1Zn+kDI5ynK/ToIm9FmzANk8jJ8NM=;
 b=vkQF6wEpMBRhsozn1FPdCUfEb8mBR4YfaXRitgqKAZFXl8kxQYW47i4etlAiauf4oBQGtNm3xsVsLF9B7undJ+3PaZ5ogv5V9wjg2HaQRFO3FpTLpewD+UAMeiU63xvBhOH+uISlpYWs7mssG8gfigqBogbQ4Ym0lxd/pZWAmjgAQNV5HYXqOXJdIUnHI1HOAHLvJmqpehXqzZxCgM6HP/6/CXqUN7MNgTcoJGYo/T60pWWOBuQq3EKfHEJ103vDeP45dDIY2uaHxapDiGaGiMhOp0F+rpYN5NM+qYAL1c1QjEdwdPQ1O8dm1cfik6VNVqCsJwkfADP9DrjGMUXJpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0dNDMGZ66tEG/1Zn+kDI5ynK/ToIm9FmzANk8jJ8NM=;
 b=SjRltPtJCg7VlblkSGHPMANEIjKOEwV+Pi9y8XYl8S9N8rcHmw2Go/wUAptbHorEVhu6KlawtZeqpDCUZdofo9dqDe+XkZ2g/EOtBRToycLoRqjwAKn+3rOnkWqc5DWmjKMCUz5p1OcOwuazYbsNtUqOfp0BoWg/I2YirAfHLx0=
Received: from MN0PR04CA0019.namprd04.prod.outlook.com (2603:10b6:208:52d::33)
 by DS7PR12MB6166.namprd12.prod.outlook.com (2603:10b6:8:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Tue, 3 Jun
 2025 17:24:05 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:52d:cafe::da) by MN0PR04CA0019.outlook.office365.com
 (2603:10b6:208:52d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.19 via Frontend Transport; Tue,
 3 Jun 2025 17:24:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 17:24:05 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 12:24:03 -0500
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
Subject: [PATCH v9 07/16] cxl/pci: Map CXL Endpoint Port and CXL Switch Port RAS registers
Date: Tue, 3 Jun 2025 12:22:30 -0500
Message-ID: <20250603172239.159260-8-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|DS7PR12MB6166:EE_
X-MS-Office365-Filtering-Correlation-Id: c87e5898-cf3e-4455-6a87-08dda2c370d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ySDII6nQoUPJe1NKnFruc3R3nXNbxpkUIkGP55l8gKcvbxjhAGTa58KVRkxX?=
 =?us-ascii?Q?cXeSrT9qWAOu55hH2U4sOZih2Sk03LwvGEGP7vhILuH1H8dX6VY6xKgvMV1K?=
 =?us-ascii?Q?o+4MChL6BH2ZyLqK8APyq4WmgaZvGnJcmZXzCTADTMb9tvIB2kZmKSzNP9kb?=
 =?us-ascii?Q?VVQve8HPxXMEx+RLVx/9+CbYZJ8Q54hWrsfJpiHo8AUtskv7hS+aX8es/q6q?=
 =?us-ascii?Q?ziw1A+Cxrj9Yu7sB7PpVeguolLX0H9BWTyCxWXmsPvtQzoQito6WfDvSm6kG?=
 =?us-ascii?Q?OvjHSn+g97RNY6lCn4Q9As4ql7b8xCbTVojiWYOqE+3us7VjzGpyQTLNQ/9Z?=
 =?us-ascii?Q?XIAGZII/+mfcjdooAODAbZdjlGHzgIuu2QffOfL9CH7NUbhnow9d+sbh3H7T?=
 =?us-ascii?Q?DU5AYSR8vnM3no1JPshC+doBj7u4L8QBZ+JEWPJ3BBl880pgHvr6v+lH4Kj9?=
 =?us-ascii?Q?BJ9tlnXBJv/2zWfTL2U7m+Vgi5FTIanXnRBMyUAibEkxN3EazGDbqfYi+aHC?=
 =?us-ascii?Q?3i7rIjrFk7sAe5xaTddWvH2CtB2LrRbUspwIDgBJvp71csNXZEhQbqWHYagP?=
 =?us-ascii?Q?U4jkaaZcAPSxVza2Tp6XZ4kq8C/n6Q5goU4t3lVpWnioW95Nhwnf3Cx3UGmp?=
 =?us-ascii?Q?m94GO7tvDXlJVXTdcNLMoQHF4l1XF0qRx6bxoT650i3pXOaQxalbJNTLwy+9?=
 =?us-ascii?Q?/hBTKWJOvoC1VP4/CJLcdEXGM6GMxNG1YSu6+pzZx+bPfrLpol6QIfIFg3nP?=
 =?us-ascii?Q?vtGeRgMV9Jj+6s0ZIAzMK6s9hWoyG+NWCgH5JyEhMMVM08kGFju9S/eE9/nX?=
 =?us-ascii?Q?VDpkKjir0cnJ1bGNK/KrTT5p/3Y2dyqHKhmmasSxxDSR5OX7ung4gv0RE9Vj?=
 =?us-ascii?Q?nyQXyWRNfkJJLndswaHhJ3xKNOIYfgE+pX67ojcldQzJfIAlk/sx9dwKXDPf?=
 =?us-ascii?Q?EXu/KQNE4w5yZ9y19QzdZqj0wn0NX5Sji0VSJozT3pr40/hQMi+wdOPogIfo?=
 =?us-ascii?Q?fJuz2tExZb42d7k/w4fLv8sfqYAXIzabm5H2XT636L4HIg2LVcOmRtO9NTPe?=
 =?us-ascii?Q?GE7rzfjc7sdrTohrYhJsXtuMwpqvpiBXoQv9HksL84P18LmiqQ+c5MAYte7t?=
 =?us-ascii?Q?5QP1FZpdGgEffMz8agKi9tVVlD2b11B2AB5gmuvK8KkZs+JlBvcn3PM/yI7w?=
 =?us-ascii?Q?n6C79X0JpCHnRpa45DhdmK6hG8x+KZizlF18KJTtalyfC+DNv4lbvzRXaIku?=
 =?us-ascii?Q?iY+UofRAtxDTyvFX/iDN47oeKB3rL+o4nH/A4Y+adMAuCZ0McXHVRmxbrcE9?=
 =?us-ascii?Q?yVgltfrEAZGosihiZHIgIAk87iOpw/bn+0j61dorcFTafbN4BbM7gzfPXYfE?=
 =?us-ascii?Q?5Pvd2OtPLsfiCKNl/2Zvtb4/w0P8s2FHhkhY7JwZ7VCLAMWbr5eYyTOfe99J?=
 =?us-ascii?Q?f5eQJGpGsVRz7rT9vKVj8WZSqnhL1b+XAfJurmbGmWM0Tz1EoR0fIHLW8e9u?=
 =?us-ascii?Q?BMqtFD7s6jCXRgWkx6Sa8hQd2IHzzaYbSh6tFm6slDL7dTCQjX2xHk08VQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 17:24:05.1044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c87e5898-cf3e-4455-6a87-08dda2c370d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6166

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
 drivers/cxl/port.c | 55 +++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 0dc43bfba76a..73be66ef36a2 100644
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
index 7b61f09347a5..0f7c4010ba58 100644
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
@@ -127,12 +137,51 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
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
+
+	if (!dport || !dev_is_pci(dport->dport_dev)) {
+		dev_err(&port->dev, "CXL port topology not found\n");
+		return;
+	}
+
+	cxl_dport_init_ras_reporting(dport, &cxlmd->dev);
+}
+
+#else
+static void cxl_endpoint_port_init_ras(struct cxl_port *port) { }
+static void cxl_switch_port_init_ras(struct cxl_port *port) { }
 #endif /* CONFIG_PCIEAER_CXL */
 
 static int cxl_switch_port_probe(struct cxl_port *port)
@@ -149,6 +198,8 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 
 	cxl_switch_parse_cdat(port);
 
+	cxl_switch_port_init_ras(port);
+
 	cxlhdm = devm_cxl_setup_hdm(port, NULL);
 	if (!IS_ERR(cxlhdm))
 		return devm_cxl_enumerate_decoders(cxlhdm, NULL);
@@ -203,6 +254,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	if (rc)
 		return rc;
 
+	cxl_endpoint_port_init_ras(port);
+
 	/*
 	 * Now that all endpoint decoders are successfully enumerated, try to
 	 * assemble regions from committed decoders
-- 
2.34.1


