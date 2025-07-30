Return-Path: <linux-pci+bounces-33213-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90745B1688B
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 23:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C92AD1AA6160
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 21:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0B022068F;
	Wed, 30 Jul 2025 21:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oz5XunmK"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B38F13D246;
	Wed, 30 Jul 2025 21:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753912180; cv=fail; b=dUbRGn+19m9ehatgw1H6L4vrJZ0Uo9KP6682CWBGq4ckzFSnFSn/Y8EZUB5s/MaWjvPORQng22C4o8S0npgC/QbxpqbWLMgbG2Y8A3WI6JBazz/Ec9QyvdSf7K+SCJXS/RUBql3DEvb0ttMxj4pWO+O1FRE4d3wO6DLYV8Wu4zU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753912180; c=relaxed/simple;
	bh=cycz3WFJleO2KU6rQ/e8orvZw18R4MMFnBypl933eyE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z/aa6uBIVlhMFhwHgQJgOZkDsWW0G5B2Nko3fvjTO+1zGHmAsFLHQtxXcLmiZ2NrtvJmBs86zC1u6jcbi0WZMJ/l6TlDXOzWiDEcUdCDrwN6VwYt6lzh9zb3rH+cwbF86YbCeMfEd+Zv9wxGboGEtdpj374FvQaTOxppUr7Xqow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oz5XunmK; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adMMJOSGNNTraXksg2p+kdzD/KcGrtcvXKrBMglsv2eQwCUkZh20ED6CzoT4zk9HkBPtP18V/FVnvCHe40LhesJIbHgqcU8rc5arMlpJKkJ8Z/DveIYM3aWmefknOJdaE2a5+nJKZ4MQtjsACAiOO5o+WPTD/Lm7Ye49A04M/j7us6h6MjfvPoVL2bWzTZJ5j5guv5BVvQskVthxmOhitrY0Rh9rGaCUTY/8fKR7ucUIFznUVbBnB5V9i+UbmLAyhgjcA6RIwch49fBlSKG5bUxhF2+GBzdxQ9S2N9wVnzAjmtOQOr8qPSM84tW8bEr+I21pPi2dMdeJ2nDamNpzeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyQA4x308WC0lKpGdgUV+ZTXFjtc/C3vobwpGXL03bk=;
 b=fnK6pvibVCBTfo+eEn/hYpGtoFTbIg2Qvg8NanOw0DF3WZy3dP+yGYwkLFr4+Q97bgbIoHJXdyfKJvBVeQ7vGUekM6krxHr27EMyHi/4PqUJC3k1xJiYE4f5SThLLwWRoaICGgILx6QMXB+9JXM2CFmEvBUdxOdgq9RJ/s2tPFAeVEnE9QI28rg+ly76ziwPfEoKq3cxGWipmV0wmtuGiKORwNy9ylABXKnsJLnjjj7n6ars8gGHJRaWucUzRJt6gB8hn+GLTxdqRN6ZkSstDb0Dvuzr2Ur+KG7/bDlnE+FNEyXs6GVsFWh5nKIcTx/Njxx+mgHIWC+2H6R+C04u+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyQA4x308WC0lKpGdgUV+ZTXFjtc/C3vobwpGXL03bk=;
 b=oz5XunmKcj+VCLwu6AkH8cRKJgqeB94yH9QARDcPOyPZGyJ78to/fb0+oJG8I5Qh1t0YjuSLhtKcN7ecg4BfypdR7gJA8Zz34k0x40e6ovxXNCQ6lkR8mZQoTSPhwpwoWB7N4rb+hxWxgT0VgpWkeBjeM3BY53Jlbm5U2YYioaA=
Received: from BN0PR04CA0156.namprd04.prod.outlook.com (2603:10b6:408:eb::11)
 by DM4PR12MB6232.namprd12.prod.outlook.com (2603:10b6:8:a5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.11; Wed, 30 Jul 2025 21:49:36 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:eb:cafe::9a) by BN0PR04CA0156.outlook.office365.com
 (2603:10b6:408:eb::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.24 via Frontend Transport; Wed,
 30 Jul 2025 21:49:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 21:49:35 +0000
Received: from SCS-L-bcheatha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 16:49:35 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
CC: Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [PATCH 09/16] cxl/core: Prevent onlining CXL memory behind isolated ports
Date: Wed, 30 Jul 2025 16:47:11 -0500
Message-ID: <20250730214718.10679-10-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250730214718.10679-1-Benjamin.Cheatham@amd.com>
References: <20250730214718.10679-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|DM4PR12MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: c318cc92-bec0-45c1-f8c4-08ddcfb2f9df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mY4eDOpCoIXhE7AwsBDic6CCp3Ny1xU3zpg9yf+LKQlBsLWckQYQeUW96lFH?=
 =?us-ascii?Q?DGebShnSZVV97a7ZkTpRtTSqhsT54+HD4B7Qx15kU/n8q8N1QpIOh4Jslsim?=
 =?us-ascii?Q?m7Zsi+ax8wOdBQW9YhVyIYJTMW6n3wFYZ5PMzFLKhb2JoX+YnOjz+q5h6pdY?=
 =?us-ascii?Q?GlVYYldlavaaDB/misrUllUZuuG6Jkve5BkSux7s2nKXYU8xUu60MOzmEyz6?=
 =?us-ascii?Q?gQX9Q8hD1v7WH841BNQLDqtHRc3WTlXJtsOPXbETwHqRDAMxMMwwSQPWuHy4?=
 =?us-ascii?Q?r2ElTou+fKUNKTELeT5a4NYC8wUKpFNjRFGgUtMcdtN4vw80dWRq9MXKKR5O?=
 =?us-ascii?Q?x1YvEO7k+3W0kOhP4DUgkyQ/JrUsF67DvFZN3j8nPx5hfUuG3Wqy2fj9EWFG?=
 =?us-ascii?Q?5mcxkmX+rInxUhZVgZ5rkmVykAwEz2wfLPYn09FcY/825dNgs6LDrGL8Zla/?=
 =?us-ascii?Q?3G/1vRE89kENkfcDYC1mZ3s8hZ2+Dblai+VtC/D/7WEqT9HGWBl5JX32+KOf?=
 =?us-ascii?Q?9ycim9RYFcyM9lVA3+zUQTTl/Lwv67HyVuiLMI/Y1cmD7fX6iBdjVwAPgOsT?=
 =?us-ascii?Q?n4Fqfm3SANQgErwRC0D0MfiG6cGaK6Si8REHJ/HRsdCmg/JwrP273MN25yia?=
 =?us-ascii?Q?6EhaYLcEMA+oNjFWSwTP23n+TkUr7Amx69eYlvUDPYKaXe6pw558UdUxt1U+?=
 =?us-ascii?Q?4+FyLsP+zxPjufxMipW4EGoJA3Cf0grRcn/Uc7Biln5nndH3j8NH/0ahLjMl?=
 =?us-ascii?Q?8sxXfMzAaDT6sW8IOH4WgRIJ2SyNzrn6OK3ljk07/GpNadIQPenbrP+GREao?=
 =?us-ascii?Q?qsDZGE67XtwcPS8Kwn5R36PzbByh1mci4iqxC63iCyVXLap7PeVuZQuxx+6J?=
 =?us-ascii?Q?9l97giYjaEkRDpnWzIhBq0iJPj17OdJoTgZqwNjCOXLrSunB1iebKcrq1eVQ?=
 =?us-ascii?Q?A4Vv92rKvt3f/7cAZTwup2jqrDMvsba4OM8XWAsIRdYkXQQdWYgEWxjZORjQ?=
 =?us-ascii?Q?M8iIoiwNr9bkDxyQHlOwY/m+96h2uvhV4vblkVvsQDapxZ6tINHETzkOB4cU?=
 =?us-ascii?Q?EZQUmaeyfMBAZReoHcyPhob4DUFBaK01ETpx6BUmjf6e9xIdIsmbP8nMNkHK?=
 =?us-ascii?Q?AyXWMmJYHI+i9H+71PNRVCkV4jMjspX3OB2TKHdRWpnTSyWg74nlyibhjyLA?=
 =?us-ascii?Q?Qojs+FWLPaSfgBVPt8och7paXFEYdff8lqYXrMHV8JOedDH+ETBkPeG5ssIf?=
 =?us-ascii?Q?5Yrst7e4Enc0XNwk7M4mF6Yw79y7w6Uw5c9TJFvizAPLlvRq6i/EqughyXr5?=
 =?us-ascii?Q?+NSdT51S9p8t+O4TJFo4lj2UsEnxuciAVyCIqgAi1ZnAv7+FLwtTRVV8dnax?=
 =?us-ascii?Q?S4UUqwpJau4aREH2meiw2Cq0N9K/JdgJJQgVvwvk8FZALdt36XeQ4P6V5pre?=
 =?us-ascii?Q?lKBQFtibBgJHIXnvWkEo2ZxNKewMwFyt/0MPCakMTYAJ7XPu19CrhdPocJXx?=
 =?us-ascii?Q?3P/zKMvq+HkToFqD8y5Ml7ymMA4HmH+YZdN2?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 21:49:35.9366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c318cc92-bec0-45c1-f8c4-08ddcfb2f9df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6232

The host will not be able to access the CXL memory on devices
enabled/added below an isolated CXL downstream port. Add a check during
cxl_mem probe to prevent adding devices below an isolated port. Also add
a check to prevent CXL region creation below an isolated port for
previously disabled devices below the port.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/core/port.c   | 28 ++++++++++++++++++++++++++++
 drivers/cxl/core/region.c |  3 +++
 drivers/cxl/cxl.h         |  2 ++
 3 files changed, 33 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 90588bf927e0..c9e7bfc082d5 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -869,6 +869,13 @@ static int cxl_port_add(struct cxl_port *port,
 		 */
 		port->reg_map = cxlds->reg_map;
 		port->reg_map.host = &port->dev;
+
+		if (cxl_endpoint_port_isolated(port)) {
+			dev_err(&port->dev,
+				"port is under isolated CXL dport\n");
+			return -EBUSY;
+		}
+
 		cxlmd->endpoint = port;
 	} else if (parent_dport) {
 		rc = dev_set_name(dev, "port%d", port->id);
@@ -1174,6 +1181,27 @@ static void cxl_dport_unlink(void *data)
 	sysfs_remove_link(&port->dev.kobj, link_name);
 }
 
+bool cxl_endpoint_port_isolated(struct cxl_port *ep)
+{
+	struct cxl_dport *iter;
+	u32 status;
+
+	for (iter = ep->parent_dport;
+	     iter && iter->port && !is_cxl_root(iter->port);
+	     iter = iter->port->parent_dport) {
+		if (!iter->regs.isolation)
+			continue;
+
+		status = readl(iter->regs.isolation +
+			       CXL_ISOLATION_STATUS_OFFSET);
+		if (!(status & CXL_ISOLATION_STATUS_OFFSET))
+			return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_endpoint_port_isolated, "CXL");
+
 struct isolation_intr_data {
 	struct cxl_dport *dport;
 	struct cxl_port *port;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b94fda6f2e4c..db9ff3b683aa 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3407,6 +3407,9 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	int rc, part = READ_ONCE(cxled->part);
 	struct cxl_region *cxlr;
 
+	if (cxl_endpoint_port_isolated(cxlmd->endpoint))
+		return ERR_PTR(-EBUSY);
+
 	do {
 		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
 				       atomic_read(&cxlrd->region_id));
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 62b3ed188949..8da1e40ab4e7 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -838,6 +838,8 @@ pci_ers_result_t cxl_error_detected(struct device *dev);
 void cxl_port_cor_error_detected(struct device *dev);
 pci_ers_result_t cxl_port_error_detected(struct device *dev);
 
+bool cxl_endpoint_port_isolated(struct cxl_port *port);
+
 /**
  * struct cxl_endpoint_dvsec_info - Cached DVSEC info
  * @mem_enabled: cached value of mem_enabled in the DVSEC at init time
-- 
2.34.1


