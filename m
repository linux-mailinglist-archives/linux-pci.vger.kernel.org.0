Return-Path: <linux-pci+bounces-19433-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A224A042DB
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 15:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A62911621E1
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 14:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51C31F37A8;
	Tue,  7 Jan 2025 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XyaKNJmu"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2064.outbound.protection.outlook.com [40.107.95.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDCD1F2C25;
	Tue,  7 Jan 2025 14:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736260883; cv=fail; b=HSDlF+Gf7cgGtaUSGLSCkYJ4eW3BnMnWYVL/xSNpLF33MqLEDB41fbeJGI9uUyLlwjTGrDRv4kzxxrfe8I6AfEzjErw4ETw56J5GLP/sg1UIfazDD9P3EP5ohkFCXbLkRgn+YvMCzrUdeT9XNP24hSyDCinCv8eR5gbUH936O0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736260883; c=relaxed/simple;
	bh=KUO1Y+0bOKx1WQ7TPvYiXKGKeVcDDXP+q9GK8Dvv0rw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YF5rrAsJevrXVfTl1Bv+Gxr3FvKQGLX8J8C6vy1CxnmUQrK0tfzxyF2GkAXAiOdoeoUDT1Xo/1k6nSyFtZGNOx11vJtRkn1diwtK85df+IrgQOZquCRJYMFreMh7CPQLoBwxSWRbbvOYI38Ll/LZPhkLgu/fcJsILpVpsyivtJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XyaKNJmu; arc=fail smtp.client-ip=40.107.95.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wwJRuhsoioQZpGYvq+QWwfXJrlR6pK7eyXe68k0ySRH9fBs6vZNIVRURyKGIRhiGNqfBXR0yX894DQsJ1m3XArjOAh+b5zbjeRRgvbtsmKydA1p4qSTbnMvvRGhhf+3Cg7rm2nQoHqSLxoJ2/EFsQRH+LCuzXLhWVSnv3PsMJu9kl3st2LDO0hSdDcZI4Wt4V4QEq6/aTCrXqSio7DT+VvahAyi6uo5DG0PG13sLuhExyRIC+MHxU13ff4RYLiKff2+VD9qTGFrSxiWsXhaKdSyB40Z1TaU2afYOWGOBrDIhnyxfH//9EoHK2fF3pAkso8LMFNzi+pypi5eOYLE9hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6r2BdicOal2Wc8l0MbXfGm8NhRzkSnb7ED1npmBclII=;
 b=jUPfMkrzvOl798EJNorsL+9jD86G1McfKxg4S5DOW5+K++w8B8pTpJIEwLI1E3PaSnsLmHLSDjuboRMHtaPkrug6rDoGQ9PQRtb2513IkrzMI9AQ4gtFxRP839AqpX+/IZ6HedFXMv9sPzUNGsDrMARA6I9tYGv6qYNnqQZxcAbU/SLVhh5WRzIv0MO+NLTnffgyrBk3xn1LUHMCwyive8ZwoDkhdlOHGpS88f+ckd1Cwtb8GJ1S8zv+Zz8fhrVXX/0PdhlmHExOLaPNO+dtyusV0XCwQznCyF2GpcK+d7JNvPAWTYZ9Bsqhz/K27srgM88T9KaFenI/0XCB2qHclQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6r2BdicOal2Wc8l0MbXfGm8NhRzkSnb7ED1npmBclII=;
 b=XyaKNJmuzajdEXGpmSxXnGo8Ymqkx1D5HsM13jJM+iqo/yRH1Q4UsX0e9m9lfAQVC8gLXZzZXeRla79E7y4/azHMo+AYRlbu3V3GqYGCDuAsU+uKZtVkNwr0A5Ib+CSWx1byP5013YVuf7+KcDKRiSZLL/QnOwrwiz7ocrNHVng=
Received: from SJ0PR13CA0073.namprd13.prod.outlook.com (2603:10b6:a03:2c4::18)
 by DM4PR12MB9072.namprd12.prod.outlook.com (2603:10b6:8:be::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.17; Tue, 7 Jan 2025 14:41:16 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::c2) by SJ0PR13CA0073.outlook.office365.com
 (2603:10b6:a03:2c4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 14:41:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:41:16 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:40:37 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<ming.li@zohomail.com>, <PradeepVineshReddy.Kodamati@amd.com>,
	<alucerop@amd.com>
Subject: [PATCH v5 09/16] cxl/pci: Map CXL PCIe Upstream Switch Port RAS registers
Date: Tue, 7 Jan 2025 08:38:45 -0600
Message-ID: <20250107143852.3692571-10-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107143852.3692571-1-terry.bowman@amd.com>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|DM4PR12MB9072:EE_
X-MS-Office365-Filtering-Correlation-Id: b644caf3-0dd0-4b6a-3ebf-08dd2f2957a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?suVUnGlaskXdZdM3/Uz3QT5TAzZkTVgrGQpx5wOAgPhBuUQV9vftCQu/EWJJ?=
 =?us-ascii?Q?ItJ8iYZlA+kkV23fUrw3ut5LwHiS0k1YiOANAngSoLJ0N/fagmZbzB9IhN2d?=
 =?us-ascii?Q?Z3mHzI9MWjs07WhuiaznLSWCcXLIynnoBgzt7PfDFQIKcVxzftxMsDyAetAZ?=
 =?us-ascii?Q?g86q9xEaWLCObfwm6X1FgzSGt6UjtRtnLmPrvRxXccdzqIy+5cEY3NkrFa4Q?=
 =?us-ascii?Q?ENXVUfB9Lq4c9/fbshkTOSVTSs3371zXVsmYkIbfepdONO5yHQ2IKgBtPqbs?=
 =?us-ascii?Q?fAel6NFiVmwwfJcQHbLfONPlQLBKgM8iG8/XrN+f8N1nFv7rawU8bYMiixP/?=
 =?us-ascii?Q?bw/JBg9SE3feyBGMgfrfVdZMZwKQpWqscyDj6aMBMMoINM+aNgBvmdbCJgY8?=
 =?us-ascii?Q?R4iea10tf+WLFD+X5hmAVWGGByPGST59ckTSqNGNwauPnW4RHI4ueLyou6yg?=
 =?us-ascii?Q?0ciguTdLI58Mn8PnHBZhCepdJLDRKIiJ14HCAjk1pKq256cxiNVRyzzLO4/Z?=
 =?us-ascii?Q?jWhTJMPwuEEc+Fqcy7ek5LAh4GELkx8K6XXsh+svdHfa4aeCEnCXx5y6RWgc?=
 =?us-ascii?Q?fkGRlNo0MaRURdKtPcaqFcXYSrY+qlygmQTQGC9ooRWAdkyuyDF2QOdBnnBE?=
 =?us-ascii?Q?j1f2r5qONjhk0rt1E7DmJthNUag6qqGEYhwVT4JYfkIVaE4Cd6odJwIs5gH7?=
 =?us-ascii?Q?qeUJhq6ZKy1zHKM3JS7oPdL71ooXVFDhE5XS3DzX9h3eGnBCiHxeWrvG6K5N?=
 =?us-ascii?Q?n/5V2g5xEnW2JL64xufNL8ELtAI+6NjSvodWbgY7YOPazQGs5ZmE6PVQ4cxD?=
 =?us-ascii?Q?Vqa/8FU2Bpy53M7k2SQOAtc3EIvP6jOJ5Dr5TR+4FMhf+E9W2IQIzohP4EcI?=
 =?us-ascii?Q?vM38HX3R5oXsO6ehpcdwbVZTUHdt6RMaZR/3Gra/46UjBkDWolEPtHVZliol?=
 =?us-ascii?Q?pU1gLSnvWemmCc7mgAvA642Za2cUyCTzQ5HfXBGV0qsHb3/3miQTiuWNsXUi?=
 =?us-ascii?Q?O0w48hPPiB87btvY9VN5c7ZFtjF6xlDhli4PT3mSsqGoiRRkuw2pj7OBV5B8?=
 =?us-ascii?Q?w1dK2/2sw8mv38z4xU1OylVFdNTGK5hzP+vtV8dakjF2e+cu7Vpjf3+W5cLk?=
 =?us-ascii?Q?N85b1pnU0aywpL1RO/uraGUctEQKHxX60aTe2GZxbdSUX8gTwSEo2cmXisvr?=
 =?us-ascii?Q?jr5oy8+YFcOJV8+ioUSp+lTRteQpyK9OPnJAf5cW4W94y2SIZsXSJ9KrYElY?=
 =?us-ascii?Q?+oevgMCthnV3fuCpo8b+gOi8L62YCWP59uFGOhMRGow2wWgffCCcz9tgfx0M?=
 =?us-ascii?Q?4uShlXLLXot5eneYmIukQn/YFBx3HqQ9JRX/u/P0PL9BEwOYKyNKT8uMygUB?=
 =?us-ascii?Q?mlHnctwkf/9MjKQzM1K14SXoIbv2cf5x+UTdknSalJheI77HGluhHJve8Nd9?=
 =?us-ascii?Q?TCcFTsJ+7Epad/6X2eilc186KB62INyq/PCP34OhYFgwqQQ666jZLSN/uW5B?=
 =?us-ascii?Q?slK0LIvBRbHqNduny3hh2Wq27+NjVOc+XBYq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:41:16.5618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b644caf3-0dd0-4b6a-3ebf-08dd2f2957a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9072

Add logic to map CXL PCIe Upstream Switch Port (USP) RAS registers.

Introduce 'struct cxl_regs' member into 'struct cxl_port' to cache a
pointer to the CXL Upstream Port's mapped RAS registers.

Also, introduce cxl_uport_init_ras_reporting() to perform the USP RAS
register mapping. This is similar to the existing
cxl_dport_init_ras_reporting() but for USP devices.

The USP may have multiple downstream endpoints. Before mapping AER
registers check if the registers are already mapped.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c | 15 +++++++++++++++
 drivers/cxl/cxl.h      |  4 ++++
 drivers/cxl/mem.c      |  8 ++++++++
 3 files changed, 27 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 1af2d0a14f5d..97e6a15bea88 100644
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
+EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, "CXL");
+
 /**
  * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
  * @dport: the cxl_dport that needs to be initialized
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 727429dfdaed..c51735fe75d6 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -601,6 +601,7 @@ struct cxl_dax_region {
  * @parent_dport: dport that points to this port in the parent
  * @decoder_ida: allocator for decoder ids
  * @reg_map: component and ras register mapping parameters
+ * @uport_regs: mapped component registers
  * @nr_dports: number of entries in @dports
  * @hdm_end: track last allocated HDM decoder instance for allocation ordering
  * @commit_end: cursor to track highest committed decoder for commit ordering
@@ -621,6 +622,7 @@ struct cxl_port {
 	struct cxl_dport *parent_dport;
 	struct ida decoder_ida;
 	struct cxl_register_map reg_map;
+	struct cxl_component_regs uport_regs;
 	int nr_dports;
 	int hdm_end;
 	int commit_end;
@@ -773,8 +775,10 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 
 #ifdef CONFIG_PCIEAER_CXL
 void cxl_dport_init_ras_reporting(struct cxl_dport *dport);
+void cxl_uport_init_ras_reporting(struct cxl_port *port);
 #else
 static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport) { }
+static inline void cxl_uport_init_ras_reporting(struct cxl_port *port) { }
 #endif
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index dd39f4565be2..97dbca765f4d 100644
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


