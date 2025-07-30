Return-Path: <linux-pci+bounces-33214-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51535B1688C
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 23:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8211016FDFB
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 21:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E138122331B;
	Wed, 30 Jul 2025 21:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IVPe1YeV"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543DE13D246;
	Wed, 30 Jul 2025 21:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753912197; cv=fail; b=PwOK3XNocIlkJDYjn8h9Ghp1HMbVSHt4Tu1LWLqSwEDZBuJ7sQs6GUQSXeEeD5Q5c5FjC/rdV3B8Wt043tv2lFE06b0HceMBgJJXe8nxztBD4VGW2kyodQyY+EZizR17g6mbJMD9SfKvTyqmF2chQAr/Ot2KZxj5krdATXX+mwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753912197; c=relaxed/simple;
	bh=L5ZdLu/C5xtPFWzaPPiNZ6kLzyMvB3nT7piFAdncdj0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=inyWaHmAoa9DzzGIZcj8nFC6o3b7RcEWFfhIxr6C+Tbx7T9X2X14B6ObUGaIzbIHUCzdEID4NrZTxleVuuV3aXnw/IO+BEMMT9E1OUPMeDDipEmrcQl05i9zXXO2LX6VClfz7ayeeXtCAxz0tw7qR5QdX1n9xgUh+y7rkmuE428=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IVPe1YeV; arc=fail smtp.client-ip=40.107.100.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dyPFvmGO5pmgcgRrFSen7Q4jPMWmjow97PntPx6Pj7katlIo33jRf6a8b2+R9aG7HW9ALfhsc/q1t8sBIH+SgoSQj5lXenSX24fEGbJ09TCeXQWr0zUKAQuNBhKHfDpq7yexsOI1s822I+D/DTTu+ja6UCON8Oa9svUdPA+Wl6loTlE7gi3HdjgYNk0UcoBtMCEYb2cFmxX4wFVlWwQs4PYF9lgHbRxItVs69gpSZMPvJSR7Sk/yaNTfZtb3gIcM92gVSTW3g6Tn5X67EbXjqDVBNIWN/0luAbQAG2WgJJxO1o/q+62kBDytYjj96L8FzJd2klsqMKBJTh61+BsCFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1pSbV6R4HWZxP9+syhmv0aVK/+HI7VmS64/duhR6SI=;
 b=J6PrQJhK1HSqz5aas5UonLSiyRxmQ8jO5OZxOvGPuwf93AXuMqrdFPhMYBVVzQCQ05o1ZLDDtRHon+XFPwwx5MmmLXoq9SWCAJBXWUmqiJ95gyGSNBiKlfTy8TWI6/Q8mCvawds1Wj3mtzyyp8jj7iCIdWRWVWRRiYRot8ZDD4+UzeNRpp6eoIvQ/JX5vwfXwzGFdf6RDWWX3HdadkvVFkU32RAX4Cclp2uAROzDcUQHQAySABmaLq4H8cPhXFLsxxIcVfnhEPAYH0yicRA54VtDGYXqiZLCtlHVghecoJPu9U9fa2+Gi1NK/oJEEA2V4ds/VfeT8yVm26ef363hhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1pSbV6R4HWZxP9+syhmv0aVK/+HI7VmS64/duhR6SI=;
 b=IVPe1YeVsMONwBZ5qNSclk2xAbcqUFsPGgkO/KudtXkh6ymgT/w+Oz+GSq5mSvUNz3lg1den6f2iEbavWukipbWbJhxblTmh2mrvuxCuI0q1mgEuQ3DNx+na8cIKU1vXoNDxOHFNnXzcy5AutmS7kScWu5/IaBftv0WaiYf5SjE=
Received: from BL1PR13CA0286.namprd13.prod.outlook.com (2603:10b6:208:2bc::21)
 by LV2PR12MB5749.namprd12.prod.outlook.com (2603:10b6:408:17f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Wed, 30 Jul
 2025 21:49:52 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:2bc:cafe::84) by BL1PR13CA0286.outlook.office365.com
 (2603:10b6:208:2bc::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Wed,
 30 Jul 2025 21:49:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 21:49:52 +0000
Received: from SCS-L-bcheatha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 16:49:51 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
CC: Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [PATCH 10/16] cxl/core: Enable CXL.mem timeout
Date: Wed, 30 Jul 2025 16:47:12 -0500
Message-ID: <20250730214718.10679-11-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|LV2PR12MB5749:EE_
X-MS-Office365-Filtering-Correlation-Id: 364e942c-410e-432e-a699-08ddcfb3038a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hMT8RytbuWTY90/xfnohT0g/Qz75IVh7v6zulYqevkA4Mfq2IFEqOP/uhUGX?=
 =?us-ascii?Q?2ZahAap8i/jioga9kVQRFyi8trnrJnOhM6XPFE8l38VWJVOSaXh6wcFlh0Hi?=
 =?us-ascii?Q?bKsqaqN9nHyReTrAAarW/0Hb8ByKx7iWtC9wbhebDFvJXADQrCbvW10XTt04?=
 =?us-ascii?Q?ETM7CRJR++bz6TAAKedINLKW4+akUmUsE4KlpfyeIcv68JdRCbWEINW2PzoS?=
 =?us-ascii?Q?YDkrEs5IQh5N7waSC1Y74tDDil//7v/O6M6CuVDv596li/78e0bdoE0GGNsK?=
 =?us-ascii?Q?SOOAHevvB7C51GHcUGvLRjQmQ9OM5VHbFJ9QR3LFeY62TQBq5XUxuRyWPHmF?=
 =?us-ascii?Q?ggOnBLCx+9AEb9mEXauHgygKJt0nWttG3Dxft27hbGsZEtOGrmR/lprv7f3C?=
 =?us-ascii?Q?qmej18X0scFk3T+tw2+hxPmkD+U/OJUky+9R8ZDeKElGLA2qF7+5u5qeXXf2?=
 =?us-ascii?Q?KXlY1Hg5nRvRlw/KUYyAmOLeMNL5XjPibANtzqAAve7IiTIVI8lzF+tFxwgg?=
 =?us-ascii?Q?QYAakTZj5WCAIKc2tVzD6NlIKUhr5oeQWAt+md5n6xgCtwVbWae583p7y9uL?=
 =?us-ascii?Q?UmCw93nTLGdHmipKo5ZfWpiVftjOH3yLmabB4qICD+cNUKjPmvN2GAoDx/Ey?=
 =?us-ascii?Q?d1s1SQV0L7ZrHd6vnXQkqnKNA/8Q5ZlhcZoPDaAD08a6BHv9yY5ForgnPyiW?=
 =?us-ascii?Q?hY9C6rdCGn9scchMWCJDdIdvrt57ucULPCrHYlvPyLnKQuzL2U3eJ2PYd5Vl?=
 =?us-ascii?Q?2LMZCh4bBi97MwoXfbvVr4DbzYR3l4PhZjd1WYytX4ixU/T1rVoz05weXKs3?=
 =?us-ascii?Q?4IVQDHYnFChuaABeA4vE+7WHNpYPEucp5ciHnU5L3KtiNenynqU6d+ujjMrJ?=
 =?us-ascii?Q?FZ179KcNqnj6PJ5MFK2L+KFsLrqvKl9h7UQ3AsyOoXMK82e9QlgOa8cmnINN?=
 =?us-ascii?Q?x+6VEBduMxwfr/9/b1e0gcnmwUd7tMImtsKyL6TAPfwoUmXhw2iafJdGVNFP?=
 =?us-ascii?Q?BJvM8qa0rufiKJXcN9jRWLFXGxyaEfoaBqWOWUeiMMTOUfTmCFuUQQT+NF+o?=
 =?us-ascii?Q?fQQJ22XXQFzqkkyLoHB5w3rkvACr5o2Ze0cq7SCAb4t9PJw7nFVAii37Vdkj?=
 =?us-ascii?Q?nn2qQf8dU6/cj3UxcgN1uiX2YdnK9m9TKnGwZ1LH6eLUH2g+UO+kodaLbGH2?=
 =?us-ascii?Q?h/lr86nwigTfG+R4qL0e9cH5I16b65gWNY2E2lOgtnJpb1ZrVMEdNgaburLa?=
 =?us-ascii?Q?K3BBaoCLCuyPYK6WpIfrtDy4it+7nWAHEUBgua5yxacXPITXMMqKiYzsF844?=
 =?us-ascii?Q?BIp/57YgS7Df0x29Uyv9k1fYhXXaGCJzfmqDLzvWRGtV+u/0RPeOujhOVbmj?=
 =?us-ascii?Q?Upn/Hu9wWRRCwSQOrwqs5YyLMTtHggGHd3eBhqJAEl41gaVnkRFfYIwZRe4k?=
 =?us-ascii?Q?Bwxz06fZ7aRoCJ+Cg687crsyx+HnWGtNi7x7+uLFKwKV9idb1TyitTHk7bPV?=
 =?us-ascii?Q?SiR5UrddkK/TGKLq1DuX2agOisuETUHI3aAI?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 21:49:52.1550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 364e942c-410e-432e-a699-08ddcfb3038a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5749

Add functions to enable and disable CXL.mem transaction timeout. Enable
timeout as part of CXL isolation set up.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/core/pci.c  | 22 ++++++++++++++++++++++
 drivers/cxl/core/port.c | 14 +++++++++-----
 drivers/cxl/cxl.h       |  4 ++++
 include/cxl/isolation.h |  5 +++++
 4 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 89fb6d3854e3..dd6c602d57d3 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1237,3 +1237,25 @@ int cxl_disable_isolation(struct cxl_dport *dport)
 	dev_dbg(dport->dport_dev, "Disabled CXL.mem isolation\n");
 	return 0;
 }
+
+void cxl_enable_timeout(struct cxl_dport *dport)
+{
+	u32 ctrl;
+
+	ctrl = readl(dport->regs.isolation + CXL_ISOLATION_CTRL_OFFSET);
+	ctrl |= CXL_ISOLATION_CTRL_MEM_TIME_ENABLE;
+	writel(ctrl, dport->regs.isolation + CXL_ISOLATION_CTRL_OFFSET);
+
+	dev_dbg(dport->dport_dev, "Enabled CXL.mem transaction timeout\n");
+}
+
+void cxl_disable_timeout(struct cxl_dport *dport)
+{
+	u32 ctrl;
+
+	ctrl = readl(dport->regs.isolation + CXL_ISOLATION_CTRL_OFFSET);
+	ctrl &= ~CXL_ISOLATION_CTRL_MEM_TIME_ENABLE;
+	writel(ctrl, dport->regs.isolation + CXL_ISOLATION_CTRL_OFFSET);
+
+	dev_dbg(dport->dport_dev, "Disabled CXL.mem transaction timeout\n");
+}
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index c9e7bfc082d5..6591e83e719c 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1312,15 +1312,15 @@ static int cxl_dport_setup_interrupts(struct device *host,
 }
 
 /**
- * cxl_dport_enable_isolation - Enable CXL Isolation for a CXL dport. This is
- * an optional capability only supported by PCIe Root Ports.
+ * cxl_dport_enable_timeout_isolation - Enable CXL Isolation for a CXL dport.
+ * This is an optional capability only supported by PCIe Root Ports.
  * @host: Host device for @dport
  * @dport: CXL-capable PCIe Root Port
  *
  * Returns 0 if capability unsupported, or when enabled.
  */
-static int cxl_dport_enable_isolation(struct device *host,
-				      struct cxl_dport *dport)
+static int cxl_dport_enable_timeout_isolation(struct device *host,
+					      struct cxl_dport *dport)
 {
 	u32 cap;
 	int rc;
@@ -1342,6 +1342,10 @@ static int cxl_dport_enable_isolation(struct device *host,
 		return rc == -ENXIO ? 0 : rc;
 
 	cxl_enable_isolation(dport);
+
+	if (!(cap & CXL_ISOLATION_CAP_MEM_TIME_SUPP))
+		cxl_enable_timeout(dport);
+
 	return 0;
 }
 
@@ -1408,7 +1412,7 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 			&component_reg_phys);
 
 	if (IS_ENABLED(CONFIG_CXL_ISOLATION)) {
-		rc = cxl_dport_enable_isolation(host, dport);
+		rc = cxl_dport_enable_timeout_isolation(host, dport);
 		if (rc)
 			return ERR_PTR(rc);
 	}
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 8da1e40ab4e7..7f9c6bd6e010 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -136,10 +136,14 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 
 /* CXL 3.2 8.2.4.24 CXL Timeout and Isolation Capability Structure */
 #define CXL_ISOLATION_CAPABILITY_OFFSET 0x0
+#define   CXL_ISOLATION_CAP_MEM_TIME_MASK GENMASK(3, 0)
+#define   CXL_ISOLATION_CAP_MEM_TIME_SUPP BIT(4)
 #define   CXL_ISOLATION_CAP_MEM_ISO_SUPP BIT(16)
 #define   CXL_ISOLATION_CAP_INTR_SUPP BIT(26)
 #define   CXL_ISOLATION_CAP_INTR_MASK GENMASK(31, 27)
 #define CXL_ISOLATION_CTRL_OFFSET 0x8
+#define   CXL_ISOLATION_CTRL_MEM_TIME_MASK GENMASK(3, 0)
+#define   CXL_ISOLATION_CTRL_MEM_TIME_ENABLE BIT(4)
 #define   CXL_ISOLATION_CTRL_MEM_ISO_ENABLE BIT(16)
 #define   CXL_ISOLATION_CTRL_MEM_INTR_ENABLE BIT(26)
 #define CXL_ISOLATION_STATUS_OFFSET 0xC
diff --git a/include/cxl/isolation.h b/include/cxl/isolation.h
index 3ad05ccc5e01..73282ac262a6 100644
--- a/include/cxl/isolation.h
+++ b/include/cxl/isolation.h
@@ -28,10 +28,15 @@ struct cxl_dport;
 #if IS_ENABLED(CONFIG_CXL_BUS)
 void cxl_enable_isolation(struct cxl_dport *dport);
 int cxl_disable_isolation(struct cxl_dport *dport);
+void cxl_enable_timeout(struct cxl_dport *dport);
+void cxl_disable_timeout(struct cxl_dport *dport);
+
 #else /* !CONFIG_CXL_BUS */
 static inline void cxl_enable_isolation(struct cxl_dport *dport) {}
 static inline int cxl_disable_isolation(struct cxl_dport *dport)
 { return -ENXIO; }
+static inline void cxl_enable_timeout(struct cxl_dport *dport) {}
+static inline void cxl_disable_timeout(struct cxl_dport *dport) {}
 #endif /* !CONFIG_CXL_BUS */
 
 #ifdef CONFIG_CXL_ISOLATION
-- 
2.34.1


