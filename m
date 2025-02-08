Return-Path: <linux-pci+bounces-20999-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACB3A2D232
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 01:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98F9F1883746
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 00:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D033D68;
	Sat,  8 Feb 2025 00:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tU2d17Sp"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B531DFCB;
	Sat,  8 Feb 2025 00:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738974673; cv=fail; b=p9ablxWCN9jww7hpk/INrFLVBnfHuXrPcIHiUX0q/w7vUfFVyYDJJjIGznmAg7OwFGoQvc5CE4NreAssl/x2Ngdztl1Olmq9xsIR8HPq460AhpgDaS1Um5GPMYBSe4DVx0hLzRbl3Z5oksYwa2J7D+YG4nRPK9uyDdyyDbvvIEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738974673; c=relaxed/simple;
	bh=4pVUeG/oSGxaphdPFByM2rsCmgvJBCVIzk+CFFG/nIs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eus8fJbkW+vPkrwe/i7h58Uy9JDD71a+RRYKv06XXnr3E1ESlC258hj+uAzRrLoHgST4UHaOkwE8kOBpMFjE7V+xtXozOuWRbYEQ7CaQ56N6fe4uPF7yj5TbD7evKO/F9bmxBg1ynGuCWpZfvPNLe4cWyvdN7edu7hdjp38Nre8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tU2d17Sp; arc=fail smtp.client-ip=40.107.92.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zKkJsWTmcpYXOPXQwO7FC+OD/C2CwJKp4WFN/DrzqhO3tKzdqsBObcZp5BkDthMhSifoiZsjlZyoykrrxWgKDzA1lFhaYGfr23CjwyFVbhISZnOQ5lZ3MTRCTtjaNoTyNgIbet0DcRSrfPQzrtEGv7b2lKdQKzDMkeqGC14JOMY/AAs9Rr1S5WcC3YrCcOldLmF+dcvARtWJ66ss1w2E2NzD2nS9EX+gNCMAt5hIyxMsU3ahlOq5XV8hCPV5iWp8HhoQhuSYoOue3FerDn3pPW0DYWg+o2Xa5Tg/fFaMVKB1XpNm1e3FUzr8hm6RdrezS/916BRl1fKdyeK5tSgzNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=723qY1Kt14GqUYCLQmMN+aoV/oer1AAUQ3SB3MFVeQM=;
 b=WQl5Yy9Qjd/puevjjpQGdpUkVU3k7UeyeNZzBOeMTFOiQvOvKXKFO46RPGm3TdB01wrfeEa5v6tdbs5BofyjiLckU3zbwaduMtwzM9NBtvAd3KsomhU3RePrAjM3tPNYb2YlcIO8o50e28RB1DrLeQynfBOlkGB99OMVBKar1ZCY/KrbtltL5/ugOxQKGxQTfQhl9NPucE119zUumHo/ieV/MnHDbmYIkEwb+oasOyxN9vu6jR2scpaTCl8qRiHj9Y+Xpc6prQYwSechpQN3vTTnlpy9TPRXnhsMN84eaYhtiGCVhvz8m41KsSrdazZlpJ8H/7K1XNu1VhcZY7vstA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=723qY1Kt14GqUYCLQmMN+aoV/oer1AAUQ3SB3MFVeQM=;
 b=tU2d17Sppe4+qrpuxL6KbTANoHcm8sS5VedYdfo3ysmG6/UrJcYTECqGO4VgH3elwaRULedqXR5zYEKdr5MTB8GYfeFeMZJNYUjdLzaI8xaqXAOO7kKSxjJVitSn0cxdgZX8XLcsSoDOOLx1AjdCKqlPaNProcpOyNcFuqe/HIs=
Received: from MW4PR04CA0319.namprd04.prod.outlook.com (2603:10b6:303:82::24)
 by SJ0PR12MB5612.namprd12.prod.outlook.com (2603:10b6:a03:427::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Sat, 8 Feb
 2025 00:31:06 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:303:82:cafe::66) by MW4PR04CA0319.outlook.office365.com
 (2603:10b6:303:82::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Sat,
 8 Feb 2025 00:31:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Sat, 8 Feb 2025 00:31:06 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 18:31:04 -0600
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
Subject: [PATCH v6 07/17] cxl/pci: Map CXL PCIe Root Port and Downstream Switch Port RAS registers
Date: Fri, 7 Feb 2025 18:29:31 -0600
Message-ID: <20250208002941.4135321-8-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250208002941.4135321-1-terry.bowman@amd.com>
References: <20250208002941.4135321-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|SJ0PR12MB5612:EE_
X-MS-Office365-Filtering-Correlation-Id: 301116ef-aa40-4388-5140-08dd47d7e06e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MztgLYsLJPzHqunNrcwJhxFtRyjv+2r/xXPjsJD8Qs4QnjmgDC2hBOAU0Cu2?=
 =?us-ascii?Q?/jVYtBqtiqhbCQmL5DE6IKproa2ZaH6deFX8naOGm7Cg+F+ytbYm8eoGV6h/?=
 =?us-ascii?Q?VWxyJkc3TKTSL9CXRXCoFiD30MF98n6C8MiwrOp/nYzjRur3PJLkif62KBMN?=
 =?us-ascii?Q?nRiDbIOZzgMBEAud3yhjwiKI51doH4uD1tr4MSsQicJpJg7furdrYgKuPyxn?=
 =?us-ascii?Q?n+YkATkAKtFiLOt9/6RE05f9z77pDjTAFOPykOcruhTeqjjoh87Fml8L6ZyQ?=
 =?us-ascii?Q?j9Sge6d2Whhn7mQB2OfMhTUOPuW6pntmyuLhwPdUh3CeEyTcirsYMZenYJKg?=
 =?us-ascii?Q?whcvOAi8uPMmtNNZiU+9qcwxvzPnpcArSwV2NTjQtpuFZ5qYbW5FCziyJbyC?=
 =?us-ascii?Q?Area8BWdxcAIGRK8QaAo2loVL73v6IyTNv4P3aMAxn1mJT/BlQNEj6zawSHC?=
 =?us-ascii?Q?xlPMQz185Z6hu3raTW3HfRYVk4ZyluVGg5baLTUI52vYcK6ga98HdRywcjzT?=
 =?us-ascii?Q?pO7HUYnt67orTiTwc+j9Ooi/jmj4tV9UV9NzEjyx9FL9+rav7cxPdvGykoQP?=
 =?us-ascii?Q?JL5IJEfEDXchaAqTvssjHeXUTxm1Oe+6z7w+xJUB6SesFfVTWEY/cAlbQChn?=
 =?us-ascii?Q?6UaO10JoE3gHaHnolbVvn9RCfE4lHMH6hY/dcUj4kf1PhzhTW3ui4pja/Fq1?=
 =?us-ascii?Q?/LdJm+3zz6UhfgH7mwrgM1vZG2MMAFZA1D4OjI9/2sNAJ5alk8+vQj5QOaKq?=
 =?us-ascii?Q?DzbuneZY1OEvPyVZI7w/bUoQxf6UwdkuevDwy6MZHq1Zzd1QKdZEoYLh4/Fx?=
 =?us-ascii?Q?vpTyK25g8rk6VbnXs2kro5wHWSCAtVXIniaq87c0mG/CPQbVESACsb2ANKyA?=
 =?us-ascii?Q?9hqaeqMzUebzoTWP7m/2Y2cMKwoyeR6ZZ1mr5m+IvgxZixY/jU518ZgGWBvt?=
 =?us-ascii?Q?IpWd8hKL1iTOvy8rdtKSlrZqe7FkxT/sjPcihjcCCJI5DGldaPzhSUugxh87?=
 =?us-ascii?Q?Yu7kZDNORmHnHjfpAb/fMTSuwemkjUGtgA6gE3Op/3b7ihIzIk85FGQlMy1j?=
 =?us-ascii?Q?j8CpZJseHFVegyu/FQT2SoHcX+eXpMdiaMKSw550kmq9W/+xj3/Tj5j1eJUV?=
 =?us-ascii?Q?jrS/2T9jj5ScVYki4GqMmuxecq702zAi59peGhLsMesELTbAlSw/4PQ5DkX0?=
 =?us-ascii?Q?thvz39YS+TdEqKZRDpU/C/kXztmHFnQsw4Uh80u0Qq4mNeCOlC99exk4l6xI?=
 =?us-ascii?Q?7bzRbW4txabHpdf4t9FsF9cnkL6SLFazLivn88WCCopNmzdooOQOugTPxxww?=
 =?us-ascii?Q?Kvzo/+mQ+m9uihNZEASjBt/Rphv+QxgldqrebIBSpWeEqsAif1pLMS+VnlQH?=
 =?us-ascii?Q?TokcvNJBoORFBRjaRS5ZmUOjXsz4t2FJ1DGF0z1DIue5WibwD6RFrzyRHyQd?=
 =?us-ascii?Q?Ydguwf5Htro/nU42+Ief4/IQH6u7vhdiYfK+TC506/J5C7RQCdnYY6P8KzEs?=
 =?us-ascii?Q?voTe0YH3rcdZnqLWcckagVKLnPJVwsk3nnvo?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 00:31:06.3626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 301116ef-aa40-4388-5140-08dd47d7e06e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5612

The CXL mem driver (cxl_mem) currently maps and caches a pointer to RAS
registers for the endpoint's Root Port. The same needs to be done for
each of the CXL Downstream Switch Ports and CXL Root Ports found between
the endpoint and CXL Host Bridge.

Introduce cxl_init_ep_ports_aer() to be called for each CXL Port in the
sub-topology between the endpoint and the CXL Host Bridge. This function
will determine if there are CXL Downstream Switch Ports or CXL Root Ports
associated with this Port. The same check will be added in the future for
upstream switch ports.

Move the RAS register map logic from cxl_dport_map_ras() into
cxl_dport_init_ras_reporting(). This eliminates the need for the helper
function, cxl_dport_map_ras().

cxl_init_ep_ports_aer() calls cxl_dport_init_ras_reporting() to map
the RAS registers for CXL Downstream Switch Ports and CXL Root Ports.

cxl_dport_init_ras_reporting() must check for previously mapped registers
before mapping. This is required because multiple Endpoints under a CXL
switch may share an upstream CXL Root Port, CXL Downstream Switch Port,
or CXL Downstream Switch Port. Ensure the RAS registers are only mapped
once.

Introduce a mutex for synchronizing accesses to the cached RAS mapping.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/pci.c | 42 ++++++++++++++++++++----------------------
 drivers/cxl/cxl.h      |  6 ++----
 drivers/cxl/mem.c      | 31 +++++++++++++++++++++++++++++--
 3 files changed, 51 insertions(+), 28 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index eda532f7440c..c142d7890bfa 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -24,6 +24,8 @@ static unsigned short media_ready_timeout = 60;
 module_param(media_ready_timeout, ushort, 0644);
 MODULE_PARM_DESC(media_ready_timeout, "seconds to wait for media ready");
 
+static DEFINE_MUTEX(ras_init_mutex);
+
 struct cxl_walk_context {
 	struct pci_bus *bus;
 	struct cxl_port *port;
@@ -755,18 +757,6 @@ static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
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
@@ -794,22 +784,30 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
 /**
  * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
  * @dport: the cxl_dport that needs to be initialized
- * @host: host device for devm operations
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
 
+	dport->reg_map.host = dport_dev;
+	if (dport->rch && host_bridge->native_aer) {
 		cxl_dport_map_rch_aer(dport);
 		cxl_disable_rch_root_ints(dport);
 	}
+
+	/* dport may have more than 1 downstream EP. Check if already mapped. */
+	mutex_lock(&ras_init_mutex);
+	if (dport->regs.ras) {
+		mutex_unlock(&ras_init_mutex);
+		return;
+	}
+
+	if (cxl_map_component_regs(&dport->reg_map, &dport->regs.component,
+				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
+		dev_err(dport_dev, "Failed to map RAS capability\n");
+	mutex_unlock(&ras_init_mutex);
+
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 6baec4ba9141..82d0a8555a11 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -754,11 +754,9 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
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
index 9675243bd05b..8c1144bbc058 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -45,6 +45,31 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
 	return 0;
 }
 
+static bool dev_is_cxl_pci(struct device *dev, u32 pcie_type)
+{
+	struct pci_dev *pdev;
+
+	if (!dev || !dev_is_pci(dev))
+		return false;
+
+	pdev = to_pci_dev(dev);
+
+	return (pci_pcie_type(pdev) == pcie_type);
+}
+
+static void cxl_init_ep_ports_aer(struct cxl_ep *ep)
+{
+	struct cxl_dport *dport = ep->dport;
+
+	if (dport) {
+		struct device *dport_dev = dport->dport_dev;
+
+		if (dev_is_cxl_pci(dport_dev, PCI_EXP_TYPE_DOWNSTREAM) ||
+		    dev_is_cxl_pci(dport_dev, PCI_EXP_TYPE_ROOT_PORT))
+			cxl_dport_init_ras_reporting(dport);
+	}
+}
+
 static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 				 struct cxl_dport *parent_dport)
 {
@@ -52,6 +77,9 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 	struct cxl_port *endpoint, *iter, *down;
 	int rc;
 
+	if (parent_dport->rch)
+		cxl_dport_init_ras_reporting(parent_dport);
+
 	/*
 	 * Now that the path to the root is established record all the
 	 * intervening ports in the chain.
@@ -62,6 +90,7 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 
 		ep = cxl_ep_load(iter, cxlmd);
 		ep->next = down;
+		cxl_init_ep_ports_aer(ep);
 	}
 
 	/* Note: endpoint port component registers are derived from @cxlds */
@@ -166,8 +195,6 @@ static int cxl_mem_probe(struct device *dev)
 	else
 		endpoint_parent = &parent_port->dev;
 
-	cxl_dport_init_ras_reporting(dport, dev);
-
 	scoped_guard(device, endpoint_parent) {
 		if (!endpoint_parent->driver) {
 			dev_err(dev, "CXL port topology %s not enabled\n",
-- 
2.34.1


