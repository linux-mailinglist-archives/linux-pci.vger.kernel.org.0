Return-Path: <linux-pci+bounces-19435-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6A1A042E0
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 15:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2293A2BD1
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 14:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36FE1F3D43;
	Tue,  7 Jan 2025 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="31tjFcPe"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2040.outbound.protection.outlook.com [40.107.102.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EFD1F239A;
	Tue,  7 Jan 2025 14:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736260886; cv=fail; b=QyGF1BXEfzg1YJzLKMlRA/Nuw9aeWln75ZSdWUIFMBUSZOFM8dLQrK6sRwX6WZUmIi1CWqBMLcw352dwhwOxeU2fSKgiTBpjHi6lkzCgoOhVsghPJn7AsqPS3+T2+gl2ax7MOYZLF21qPXlV/vy3yqJ84r1Vg1IusEms6y+IwPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736260886; c=relaxed/simple;
	bh=H/MJicT0cwVZKUioSfeuW0cGugOJE/K4DFFBNIU2GRY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FMiFJi4obXkWvwyhhC8DsKYkLnt1GDKZlgX1Zy186JjjLTZeiT5pHFyh0eUrnlJyA28RwuBnWYy6X86mYxiqRocPlixtiDstdFbvecrC/vY5Z7c5X20ZROWPs8Tum3VcdvuGfVecJBh24R15q4R4YQp+j5gKUAgRwtZYt8Mz3Ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=31tjFcPe; arc=fail smtp.client-ip=40.107.102.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LdrGqZxQVvw2svOc+493tAeP8mBhP71wgHGj6CwppRiI1c6azSPYsRXuoYKZC0Ylnotrk+PuUXq83ghd7FaQBLd0DkdjHm+uKu/rrOQixAyag4JGc1JuXeIGCRrpSB7s60+7wqNxt4/+cZqYStmr2WK5UBBpjhl7Ed8Rci+3naHeaKtkmx56Mw+BZb3sqqZPQpgT64OK0E4LX7P0HeuSPT+OT04xJyaG0kPmzM6ktMExPv3Pc188QxFYqiKdR4USjUIHne9F9C8t7dGJV4ITsyuMp64pJC2r1c230zsQYQVSEo03gqc/Eh5DzEae8CPgpdwWWAZHkZZN0MydeQimzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p86PONq/4SKLFeV8U5PVcGC+J6GCWEv9luqoGAwp4w0=;
 b=Grjv9INojQJHFQ3jQkc0HkbI7AbApLoUGczTFEdlNbvkU/la63C/Y3ta/GqxDuVCsdQxCcNvW7eVuMumNmoKeF5pv9blKwwD9jVl1HWNeRtBi5uoifJJWprDhWDSKGw93Rjq2kYDX98f5XIlqXDD8jGXsoezvAdCzfTCiwNDz60dNPUtQX+lt00uRs7JIppGuHNN+N5rOyxvc/T4EVEngGloniq/xUBGKHaGOBxq7RlbX9B032lJ5dCsYJzE3u3Hn4DMgbtBj5G5Tl+yOmzSTKS/Fpj5zPokos2o4Fz4mZdld0JEZjJCDtYQX/DCvq76kS1tOvqYVxPda9Tnpv2gKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p86PONq/4SKLFeV8U5PVcGC+J6GCWEv9luqoGAwp4w0=;
 b=31tjFcPeKk1spDz7FGasGDhO/eg/pVpvdNDX95HtCqPGlEFssGMuW1osHI1r2cyegYZVnzVyb3hvwxxnVj3bMRvkbvmfSTrmF6NUmTi+uxYJePBhNg2qXKj3ZbwW/kFI0Vx19oVZ4dNRFq+9hLqI9v8tiJAAmSXskSvuFS3Aals=
Received: from SJ0PR13CA0080.namprd13.prod.outlook.com (2603:10b6:a03:2c4::25)
 by SA3PR12MB8812.namprd12.prod.outlook.com (2603:10b6:806:312::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 14:41:16 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::59) by SJ0PR13CA0080.outlook.office365.com
 (2603:10b6:a03:2c4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 14:41:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:41:15 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:40:26 -0600
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
Subject: [PATCH v5 08/16] cxl/pci: Map CXL PCIe Root Port and Downstream Switch Port RAS registers
Date: Tue, 7 Jan 2025 08:38:44 -0600
Message-ID: <20250107143852.3692571-9-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|SA3PR12MB8812:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e5838ed-78b7-4a42-a6db-08dd2f29572a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S1bQbDc2Eyqz1CtkViYw0Jkgw66XJoy9JUKv+uv0wq1+4SeKhmKEPSHNG7sA?=
 =?us-ascii?Q?h8tqIgkdrtk73j5ILrZZC2BkfDeNvbLoTfE2wtmtBe/tdDpKgY0Xs26DH/0t?=
 =?us-ascii?Q?wS5OEq0LEuM4jQG+TodiK57acZFM5ltkq+jxendlagCrr8V/N6Kmkwmol1Eh?=
 =?us-ascii?Q?KTiI1/5/smPwrni0S1PRVe5sek2oKyD/utMN5nnE9hlgvc4/Hq72hs/CdhBY?=
 =?us-ascii?Q?zgIs4LD8jSioHkr+QMY4/BhlmebrwPVyh6/JpUIi7hc1IIqqJDMzAfsKU4/j?=
 =?us-ascii?Q?BxfyH3B6m06grBFFLVoLDd9U1FqLnj1EoS3QMtOJ7Z2pRkDEyi7O0/jRv5o3?=
 =?us-ascii?Q?BRZcI9aT+vY0QAudQp5bc7wu0k7TwaqyJzJ6VurCinp7wbKl9i1qqoa0Dtft?=
 =?us-ascii?Q?LoMcZlov+DcTOcaQFJ90mZDAvsmyRMCSLqlorPvl7PLfAc4XAdSDPI7JhTIv?=
 =?us-ascii?Q?I2Nk2PW8+RY8M/ZTPvw5H0XrMZ2hFKYvAl8Bf+XUHdam2tZfcc0fbYXQWCeG?=
 =?us-ascii?Q?tqTs+W1zNLQoZrjTSfAr1iIc85O9l7oIL4Au888m5ly/XHWooLxOeZ+ey6d3?=
 =?us-ascii?Q?kqCdMYXJP/TiJ8Fl45snJ3Cclqbhji/3bUINOOQxaY5yCtqVJMSQJaWIdirq?=
 =?us-ascii?Q?557T+QNCbnxTabOUfLdknYpChieJxFbc9to//z/5+QkOqnB0gWcsRYmW2pMa?=
 =?us-ascii?Q?rgCzdRw/fWE69e0s46B6G6iffHydbC6pqm22c8WL+9loeaqZGKIdNUt0PSsd?=
 =?us-ascii?Q?p/jg62qrWv9Zc4dmBXAmitPigG9ujaOrslpsgFeu/thlAeRugQCOVTNm1MPZ?=
 =?us-ascii?Q?rPR4+YvPHbkbcfQvhVu0EaPXH/yqeLr8SqiyehAPA/0ZCBUUG+vPhSHXItj8?=
 =?us-ascii?Q?1KXnJIiJDU9v8M8cxEXPuTXU63E8cLr8QYJNTIAo9Buk69phetvP7395bQx2?=
 =?us-ascii?Q?30nvzhQOUtVBzUCpBcAVC8g39UbP6nZlITWPc5nOGRp3RBTIovVP9HN3h66o?=
 =?us-ascii?Q?iWK9Z8Le2DZrCJU0F/qK+JQDQOAwGljSVtoQm8cjk1FcckoJxOtnZvTmFRLP?=
 =?us-ascii?Q?k3yWy6+qUdnplzswW2kNQGO25PZb6TBWVRlgnZLrJAQGVRUm5lgCoi8j3+ga?=
 =?us-ascii?Q?TvRBYmVn0hL4UrfpfVRe+fCvrh4Ffb1Pul2w69dB0Q33cziEXhlfsXVrXwkJ?=
 =?us-ascii?Q?79w9hCh8jSKAszU85lGrpMfJCDrbq5Aky0aWCyWkG/631SktXwRcC+0zZeLR?=
 =?us-ascii?Q?jQfq22nnfLwQPNnrauC7gSJdPN4QhX5/SylJFZwRryM04fJxzYt9cAvbMVg+?=
 =?us-ascii?Q?oJDtQZklqrdTXi7AOG7VHV3xJpbqpptMW6f0vz1/1rh/npmTtRCXZNQU8+m4?=
 =?us-ascii?Q?mZl2PGCzImqkEqFt/TqyDzDFGNLzbfI272HuDEd2SFgirzE5CJMLn8OYzf0o?=
 =?us-ascii?Q?TO/5fdS81oth7EvLmZR3zy3hbfxSBxTT4bPGQq7rBbUYO6Hsu1skkvfsrZ0O?=
 =?us-ascii?Q?9TJGUAZhJBKBpIyHPhQl0rBiAy0+MppQJFRU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:41:15.8118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5838ed-78b7-4a42-a6db-08dd2f29572a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8812

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
before mapping. This is required because multiple endpoints under a CXL
switch may share an upstream CXL Root Port, CXL Downstream Switch Port,
or CXL Downstream Switch Port. Ensure the RAS registers are only mapped
once.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/pci.c | 37 +++++++++++++++----------------------
 drivers/cxl/cxl.h      |  6 ++----
 drivers/cxl/mem.c      | 31 +++++++++++++++++++++++++++++--
 3 files changed, 46 insertions(+), 28 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index b3aac9964e0d..1af2d0a14f5d 100644
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
@@ -788,22 +776,27 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
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
+	if (dport->regs.ras)
+		return;
+
+	if (cxl_map_component_regs(&dport->reg_map, &dport->regs.component,
+				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
+		dev_err(dport_dev, "Failed to map RAS capability.\n");
+		return;
+	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index fdac3ddb8635..727429dfdaed 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -772,11 +772,9 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
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
index 2f03a4d5606e..dd39f4565be2 100644
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


