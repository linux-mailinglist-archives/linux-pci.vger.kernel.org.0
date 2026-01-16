Return-Path: <linux-pci+bounces-45009-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E59BD29ABB
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 02:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBD5530456A9
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 01:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F392E325738;
	Fri, 16 Jan 2026 01:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IVo15poc"
X-Original-To: linux-pci@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012017.outbound.protection.outlook.com [52.101.48.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650022586C8;
	Fri, 16 Jan 2026 01:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768527760; cv=fail; b=rSQkXsKn1TAH7RXKtmw27qCB9mfviMQIWM003PprRGlRDiiwRbXA9PTcx0aJNSPUPOBDzZ0HakTi/RgujwIEKIFs/KnZlVCSI8fCO2bQlnA6H/fYnupmTkUmqR8+AUFsSSJn8nFLaS9/JKXhHk4mclNCy8KuvkcofrzeK1FY8Oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768527760; c=relaxed/simple;
	bh=L43s7QhQYD6lrQCP1Hk1NzM3AGpbJbO3825OIwzeiMM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IuqaVt6oFEsx+9slwnfxueqAxR2KLpiC3U5J4uquSvP7rLfUPfgs6zxmtOuCTKQcjvGrkgnYFhA3um9shDBTszAlGsKY+LidNDjk45ND8Kon9LpspOpmvaLFMcvtvfN8x+au0+/wRm+dHASwtEq2eXRAANVZ89sffz/qiJZlyn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IVo15poc; arc=fail smtp.client-ip=52.101.48.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yoPerktRr7cvhLVghtNsqkEsvGbXTSzq9p+xPiBlwJtVC/+Ovh3mWT+wKCIMZHeAhblh3eH+4oS8VO1lzc5yXY/c76wtsCSP+hgLxOZcnXR6B0dbKR3yTKA7CswNaquN7qCcdnN1vkGIPB1i4kFAI7Lw0yEJUzTWEfiQr6MW7r/cth+DgY5MdvvpLoSmQfT0Qc0q2r2D/FEcCdpS54fY1kkKCU12MceF/1LRHTrODFivy7sWe9wJ+6QRp8wQr7iftE3vPG2ZtNNCwr4x7zDY4AIh2vJu939Ap6lq1XN8D9+bjqMluTdX/Fhju7pbWK49cs6RqcNjZ/8ZDMIIo0Tluw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENVT7drrnuQShFASkug4mMyPkHPzh6r2RnC7KuEB7Ag=;
 b=psDQvQayBj3FQOfWYrdmsL1q+Iym3QMmCUq2/gwnrovYRpBzbqp/uSvThiMXqG2vdBDgLGzuYyN1w+4fow7vIMZMCC3GXOBznhqAjZeSRWOxg27eROB8WvdtWzoidKpXy2uDomWoupu4UDyM+OrinFzRRtElwJnggwEKUwJzxHHFxereDrHW5hNajnX1bg55RTDr/lC2lCStw9mknbsWDYx3TnAKUjdin/a2crdC3R90zJL125GVPHakXOVshNiSqKRw/UX3Tpw2ylvdKf5Rq4EhhYu5tbC21AAcIluTfiXDfCz/ev60Wrntug2JK6vDIk/PgaFFkmgnqfhu9D4faQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENVT7drrnuQShFASkug4mMyPkHPzh6r2RnC7KuEB7Ag=;
 b=IVo15pocmN4HYnKCY9jHjhPimuuwbS9qOwXe9OoNrHCXcehhsiYynAQkHpJnieqDdIArT4Q0xKGtWCY158G9p6HAsN2Q1jCo5A8OUvfrJ2ZdBo+jvXpNiqDeR1iZNDMbx/0lFHEvWG6YIOtrNPl8qOJd9xh0e3BoVCi3+dgAc1BMt6C5eg51bLuuXkfeWmLqjNBeN7Ny1qKBbBjxmjWMnRPglr7Yy4CIeWw8MisXVbdK2twVMP65VuLkaai37AAxcXq5HUwjvFApws1NRxwf08zBLWbbcxrgDm3YWBX9eunr2uI0mHIqui4cnK/9jlcqCggQrCXYUm9MtVVZ4A0Hgw==
Received: from MN0PR02CA0025.namprd02.prod.outlook.com (2603:10b6:208:530::17)
 by LV5PR12MB9825.namprd12.prod.outlook.com (2603:10b6:408:2ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Fri, 16 Jan
 2026 01:42:28 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:530:cafe::de) by MN0PR02CA0025.outlook.office365.com
 (2603:10b6:208:530::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Fri,
 16 Jan 2026 01:42:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 01:42:28 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 17:42:11 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 17:42:11 -0800
Received: from build-smadhavan-jammy-20251112.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Thu, 15 Jan 2026 17:42:10 -0800
From: <smadhavan@nvidia.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <ming.li@zohomail.com>,
	<rrichter@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<huaisheng.ye@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <smadhavan@nvidia.com>, <vaslot@nvidia.com>, <vsethi@nvidia.com>,
	<sdonthineni@nvidia.com>, <vidyas@nvidia.com>, <mochs@nvidia.com>,
	<jsequeira@nvidia.com>
Subject: [PATCH v3 10/10] cxl: add HDM decoder and IDE save/restore
Date: Fri, 16 Jan 2026 01:41:46 +0000
Message-ID: <20260116014146.2149236-11-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260116014146.2149236-1-smadhavan@nvidia.com>
References: <20260116014146.2149236-1-smadhavan@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|LV5PR12MB9825:EE_
X-MS-Office365-Filtering-Correlation-Id: 1704d8ce-a52b-47fa-9320-08de54a081f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DDk2rwoybgDOqZt3fOS3L7g4ApCZJs+EbSxdAc0+Cgsyc8YxZjPSjjckxLdy?=
 =?us-ascii?Q?MrwP6iibfo4k4xZbHd1TgqjjMZhGsG2vENhLEIjs/gKqvnhsfhtd4CU7p01S?=
 =?us-ascii?Q?6CSlYwQuaTYiW6wc9rXag06PL93NVLQtuZo5137iIofof8mLy5Tr2tRE/pBn?=
 =?us-ascii?Q?PPplSCC22BNz5Y1+E4ghqt0ZEk933lh/2O1vvj5i8eyJVQ4Ib4OtDrMiYqtq?=
 =?us-ascii?Q?WMpxRM7k7g4BFkZDonJeepXeaSt+ycCRhS2zz0WRXvHZgWVBkGvTA8S+jquW?=
 =?us-ascii?Q?E6eBe9cl96xCOMPUBQuFIlIRg0r8bYj22iIvalIWw7zrq5hkQCi0X2rwqdZJ?=
 =?us-ascii?Q?suPdy+BhT47AEL3hI3JQOZRjiUdyHPgBgbgmBOCQ3MirXtJUE4Dm5G/gflXE?=
 =?us-ascii?Q?w3M3s5lanm6jN8nPOGNbUpKv1tRo6X/kyDpmzHZYQ3FDZYrhmQV8AhjDHLvI?=
 =?us-ascii?Q?oHY2vW5N3N2i4fi9m9/J35wyEaP2PzApyRiPVOF+rRNUHvi1q/zXbhtC3CXz?=
 =?us-ascii?Q?KqMBk73flwobGQsbGOIScIcr6IGPLpxepDj+rOZ9rng7U7nnxZBRQoW5qnuR?=
 =?us-ascii?Q?Wi45WmoBCApzF0iDQeGrjhIxCrLBMriMpoqDjX4sCyAyj2UTu0kdLBJrLqnN?=
 =?us-ascii?Q?8cFR7Zvj87VbshwbOcRf5KH0UTYVoDCtp7tBW1P0FBrdYUEgQBe4UD0SwStk?=
 =?us-ascii?Q?iOqodrTle58RJAJL8ioXJOUtgKQez4T2wJuL06Egd+rU+rINLU2XMg/wCiTU?=
 =?us-ascii?Q?qZXtpDZs8UjIpIJXnxJAJpUv7c72UGKbc42QrB3lMqbDSkEzeES8oCOrGgaS?=
 =?us-ascii?Q?wrCfy8ou+c3zWCtHBnBOOCPDzAnUsT3bvKbIRSAD05GTZFQWwCyUVWaDPVOS?=
 =?us-ascii?Q?rfnnttrZYyPVZ3lVI4VKnf2LIid/vQ0OzpFvUn8TqYO7aJzYGdEgd8+GD50M?=
 =?us-ascii?Q?VDwci1pvJHJY1jF6+y27UMzUIg+loHiFCBZQz2NZMjgZ1X4CmDO63PPZ4ADc?=
 =?us-ascii?Q?3vMbDDnm9n/oA05Joh49XUX/5TDcPMGf4Liw671oO7TrpBvsvcMkcuweRgQI?=
 =?us-ascii?Q?FBAP7c9BwbkYAdmlwkkXTs2Pwy/58/vnFx0w10rDCtifRFAvHqfSxgbIAMr8?=
 =?us-ascii?Q?bQTHRHPRhDHoAxzRPakvHy6woipOEa+YLIqbtHqVqWp2zJZOyZZ3cN8KD43I?=
 =?us-ascii?Q?D0V1Z5WJtJbVlrTj8N61i1hl5pEjnlWaYHaqUYTQlc9VcgxdMJgwxNSiJjce?=
 =?us-ascii?Q?mq6unwIb0Zb4xYmFv5ln7TL4D9blX5e9Lv3hQGNpU+h9ttWLPFckvXpXjr1x?=
 =?us-ascii?Q?O0JxEYbrxc1b+IOavpdchmmMXW36atUsPYy2rzDR7ziNxYxnFQZ0O4Qnw/0p?=
 =?us-ascii?Q?N2ypTFV9bBOdavbPac00dMJuY3OwNZEe3nNuSg0MbV3ZEV21pQ44zTodic7S?=
 =?us-ascii?Q?fHdc/hIKCClFw3FWn+elUKxpqkp0oj87oPP0mvlBS7pUWhbY1UHVLhb5ZHV/?=
 =?us-ascii?Q?UHGfFctpgpQGNp4Os5N+m0EF+Wvqb5CTVAB82mCv8rDx2Di5hVdKBw+KKB5C?=
 =?us-ascii?Q?SgE4mF4FgZbx2Ybu8IWsovkYFvWgFNoQASH59qCt+SMyLLHt/POVIrD6Iy9X?=
 =?us-ascii?Q?g4VD5AeJaqC2n1IQnBIEVvf52//naiSQ1K0DoUoAAM+KPkVhbm91Zp9mFNlR?=
 =?us-ascii?Q?h1c3vU1iTei1520AaqVmkDyi99M=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 01:42:28.3144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1704d8ce-a52b-47fa-9320-08de54a081f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9825

From: Srirangan Madhavan <smadhavan@nvidia.com>

Extend state save/restore to HDM decoder and IDE registers for Type 2
devices. The HDM/IDE blocks are located via the component register map,
then preserved across reset to retain decoder configuration and IDE
policy. This avoids losing HDM/IDE programming when cxl_reset is issued.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/regs.c |   7 ++
 drivers/cxl/cxl.h       |   4 ++
 drivers/cxl/pci.c       | 153 ++++++++++++++++++++++++++++++++++++++--
 include/cxl/pci.h       |  43 +++++++++++
 4 files changed, 201 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index ecdb22ae6952..76d6869d82ea 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -93,6 +93,12 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			length = CXL_RAS_CAPABILITY_LENGTH;
 			rmap = &map->ras;
 			break;
+		case CXL_CM_CAP_CAP_ID_IDE:
+			dev_dbg(dev, "found IDE capability (0x%x)\n",
+				offset);
+			length = CXL_IDE_CAPABILITY_LENGTH;
+			rmap = &map->ide;
+			break;
 		default:
 			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
 				offset);
@@ -212,6 +218,7 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
 	} mapinfo[] = {
 		{ &map->component_map.hdm_decoder, &regs->hdm_decoder },
 		{ &map->component_map.ras, &regs->ras },
+		{ &map->component_map.ide, &regs->ide },
 	};
 	int i;

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ba17fa86d249..a7a6b79755b3 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -39,8 +39,10 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
 #define CXL_CM_CAP_PTR_MASK GENMASK(31, 20)

 #define   CXL_CM_CAP_CAP_ID_RAS 0x2
+#define   CXL_CM_CAP_CAP_ID_IDE 0x4
 #define   CXL_CM_CAP_CAP_ID_HDM 0x5
 #define   CXL_CM_CAP_CAP_HDM_VERSION 1
+#define   CXL_IDE_CAPABILITY_LENGTH 0x20

 /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
 #define CXL_HDM_DECODER_CAP_OFFSET 0x0
@@ -214,6 +216,7 @@ struct cxl_regs {
 	struct_group_tagged(cxl_component_regs, component,
 		void __iomem *hdm_decoder;
 		void __iomem *ras;
+		void __iomem *ide;
 	);
 	/*
 	 * Common set of CXL Device register block base pointers
@@ -256,6 +259,7 @@ struct cxl_reg_map {
 struct cxl_component_reg_map {
 	struct cxl_reg_map hdm_decoder;
 	struct cxl_reg_map ras;
+	struct cxl_reg_map ide;
 };

 struct cxl_device_reg_map {
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 9a9fab60f1e8..f00bb542a7ee 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -963,7 +963,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		dev_dbg(&pdev->dev, "RAS registers not found\n");

 	rc = cxl_map_component_regs(&cxlds->reg_map, &cxlds->regs.component,
-				    BIT(CXL_CM_CAP_CAP_ID_RAS));
+				    BIT(CXL_CM_CAP_CAP_ID_RAS) |
+				    BIT(CXL_CM_CAP_CAP_ID_IDE));
 	if (rc)
 		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");

@@ -1210,18 +1211,126 @@ static int cxl_restore_dvsec_state(struct pci_dev *pdev,
 	return rc;
 }

+/*
+ * CXL HDM Decoder register save/restore
+ */
+static int cxl_save_hdm_state(struct cxl_dev_state *cxlds,
+			      struct cxl_type2_saved_state *state)
+{
+	void __iomem *hdm = cxlds->regs.hdm_decoder;
+	u32 cap, ctrl;
+	int i, count;
+
+	if (!hdm)
+		return 0;
+
+	cap = readl(hdm + CXL_HDM_DECODER_CAP_OFFSET);
+	count = cap & CXL_HDM_DECODER_COUNT_MASK;
+	count = min(count, CXL_MAX_DECODERS);
+
+	state->hdm_decoder_count = count;
+	state->hdm_global_ctrl = readl(hdm + CXL_HDM_DECODER_GLOBAL_CTRL_OFFSET);
+
+	for (i = 0; i < count; i++) {
+		struct cxl_hdm_decoder_state *d = &state->decoders[i];
+		u32 base_low, base_high, size_low, size_high;
+		u32 dpa_skip_low, dpa_skip_high;
+
+		base_low = readl(hdm + CXL_HDM_DECODER_BASE_LOW(i));
+		base_high = readl(hdm + CXL_HDM_DECODER_BASE_HIGH(i));
+		size_low = readl(hdm + CXL_HDM_DECODER_SIZE_LOW(i));
+		size_high = readl(hdm + CXL_HDM_DECODER_SIZE_HIGH(i));
+		ctrl = readl(hdm + CXL_HDM_DECODER_CTRL(i));
+		dpa_skip_low = readl(hdm + CXL_HDM_DECODER_DPA_SKIP_LOW(i));
+		dpa_skip_high = readl(hdm + CXL_HDM_DECODER_DPA_SKIP_HIGH(i));
+
+		d->base = ((u64)base_high << 32) | base_low;
+		d->size = ((u64)size_high << 32) | size_low;
+		d->ctrl = ctrl;
+		d->dpa_skip = ((u64)dpa_skip_high << 32) | dpa_skip_low;
+		d->enabled = !!(ctrl & CXL_HDM_DECODER_ENABLE);
+	}
+
+	return 0;
+}
+
+static int cxl_restore_hdm_state(struct cxl_dev_state *cxlds,
+				 const struct cxl_type2_saved_state *state)
+{
+	void __iomem *hdm = cxlds->regs.hdm_decoder;
+	int i;
+
+	if (!hdm || state->hdm_decoder_count == 0)
+		return 0;
+
+	writel(state->hdm_global_ctrl, hdm + CXL_HDM_DECODER_GLOBAL_CTRL_OFFSET);
+
+	for (i = 0; i < state->hdm_decoder_count; i++) {
+		const struct cxl_hdm_decoder_state *d = &state->decoders[i];
+
+		writel((u32)d->base, hdm + CXL_HDM_DECODER_BASE_LOW(i));
+		writel((u32)(d->base >> 32), hdm + CXL_HDM_DECODER_BASE_HIGH(i));
+		writel((u32)d->size, hdm + CXL_HDM_DECODER_SIZE_LOW(i));
+		writel((u32)(d->size >> 32), hdm + CXL_HDM_DECODER_SIZE_HIGH(i));
+		writel(d->ctrl, hdm + CXL_HDM_DECODER_CTRL(i));
+		writel((u32)d->dpa_skip, hdm + CXL_HDM_DECODER_DPA_SKIP_LOW(i));
+		writel((u32)(d->dpa_skip >> 32), hdm + CXL_HDM_DECODER_DPA_SKIP_HIGH(i));
+	}
+
+	return 0;
+}
+
+/*
+ * CXL IDE register save/restore
+ */
+static int cxl_save_ide_state(struct cxl_dev_state *cxlds,
+			      struct cxl_type2_saved_state *state)
+{
+	void __iomem *ide = cxlds->regs.ide;
+	u32 cap;
+
+	if (!ide)
+		return 0;
+
+	cap = readl(ide + CXL_IDE_CAP_OFFSET);
+	if (!(cap & CXL_IDE_CAP_CAPABLE))
+		return 0;
+
+	state->ide_cap = cap;
+	state->ide_ctrl = readl(ide + CXL_IDE_CTRL_OFFSET);
+	state->ide_key_refresh_time = readl(ide + CXL_IDE_KEY_REFRESH_TIME_CTRL_OFFSET);
+	state->ide_truncation_delay = readl(ide + CXL_IDE_TRUNCATION_DELAY_CTRL_OFFSET);
+
+	return 0;
+}
+
+static int cxl_restore_ide_state(struct cxl_dev_state *cxlds,
+				 const struct cxl_type2_saved_state *state)
+{
+	void __iomem *ide = cxlds->regs.ide;
+
+	if (!ide || !(state->ide_cap & CXL_IDE_CAP_CAPABLE))
+		return 0;
+
+	writel(state->ide_ctrl, ide + CXL_IDE_CTRL_OFFSET);
+	writel(state->ide_key_refresh_time, ide + CXL_IDE_KEY_REFRESH_TIME_CTRL_OFFSET);
+	writel(state->ide_truncation_delay, ide + CXL_IDE_TRUNCATION_DELAY_CTRL_OFFSET);
+
+	return 0;
+}
+
 /**
  * cxl_config_save_state - Save CXL configuration state
  * @pdev: PCI device
  * @state: Structure to store saved state
  *
- * Saves CXL DVSEC state before reset.
+ * Saves CXL DVSEC, HDM decoder, and IDE state before reset.
  */
 int cxl_config_save_state(struct pci_dev *pdev,
 			  struct cxl_type2_saved_state *state)
 {
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-	int dvsec;
+	int rc, dvsec;

 	if (!cxlds || !state)
 		return -EINVAL;
@@ -1232,7 +1341,23 @@ int cxl_config_save_state(struct pci_dev *pdev,
 	if (!dvsec)
 		return -ENODEV;

-	return cxl_save_dvsec_state(pdev, state, dvsec);
+	rc = cxl_save_dvsec_state(pdev, state, dvsec);
+	if (rc)
+		return rc;
+
+	if (cxlds->regs.hdm_decoder) {
+		rc = cxl_save_hdm_state(cxlds, state);
+		if (rc)
+			pci_warn(pdev, "Failed to save HDM state: %d\n", rc);
+	}
+
+	if (cxlds->regs.ide) {
+		rc = cxl_save_ide_state(cxlds, state);
+		if (rc)
+			pci_warn(pdev, "Failed to save IDE state: %d\n", rc);
+	}
+
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_config_save_state, "CXL");

@@ -1241,7 +1366,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_config_save_state, "CXL");
  * @pdev: PCI device
  * @state: Previously saved state
  *
- * Restores CXL DVSEC state after reset.
+ * Restores CXL DVSEC, HDM decoder, and IDE state after reset.
  */
 int cxl_config_restore_state(struct pci_dev *pdev,
 			     const struct cxl_type2_saved_state *state)
@@ -1264,7 +1389,23 @@ int cxl_config_restore_state(struct pci_dev *pdev,

 	config_locked = !!(lock_reg & CXL_DVSEC_LOCK_CONFIG_LOCK);

-	return cxl_restore_dvsec_state(pdev, state, dvsec, config_locked);
+	rc = cxl_restore_dvsec_state(pdev, state, dvsec, config_locked);
+	if (rc)
+		return rc;
+
+	if (cxlds->regs.hdm_decoder && state->hdm_decoder_count > 0) {
+		rc = cxl_restore_hdm_state(cxlds, state);
+		if (rc)
+			pci_warn(pdev, "Failed to restore HDM state: %d\n", rc);
+	}
+
+	if (cxlds->regs.ide && (state->ide_cap & CXL_IDE_CAP_CAPABLE)) {
+		rc = cxl_restore_ide_state(cxlds, state);
+		if (rc)
+			pci_warn(pdev, "Failed to restore IDE state: %d\n", rc);
+	}
+
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_config_restore_state, "CXL");

diff --git a/include/cxl/pci.h b/include/cxl/pci.h
index 2c629ded73cc..9f2a9ad10d75 100644
--- a/include/cxl/pci.h
+++ b/include/cxl/pci.h
@@ -4,11 +4,33 @@
 #ifndef __CXL_ACCEL_PCI_H
 #define __CXL_ACCEL_PCI_H

+/* HDM Decoder state for save/restore */
+struct cxl_hdm_decoder_state {
+	u64 base;
+	u64 size;
+	u32 ctrl;
+	u64 dpa_skip;
+	bool enabled;
+};
+
+#define CXL_MAX_DECODERS 10
+
 /* CXL Type 2 device state for save/restore across reset */
 struct cxl_type2_saved_state {
 	/* DVSEC registers */
 	u16 dvsec_ctrl;
 	u16 dvsec_ctrl2;
+
+	/* HDM Decoder registers */
+	u32 hdm_decoder_count;
+	u32 hdm_global_ctrl;
+	struct cxl_hdm_decoder_state decoders[CXL_MAX_DECODERS];
+
+	/* IDE registers */
+	u32 ide_cap;
+	u32 ide_ctrl;
+	u32 ide_key_refresh_time;
+	u32 ide_truncation_delay;
 };

 int cxl_config_save_state(struct pci_dev *pdev,
@@ -58,6 +80,27 @@ int cxl_config_restore_state(struct pci_dev *pdev,

 #define CXL_DVSEC_RANGE_MAX		2

+/* CXL HDM Decoder Capability Structure (Section 8.2.4.20) */
+#define CXL_HDM_DECODER_CAP_OFFSET		0x0
+#define   CXL_HDM_DECODER_COUNT_MASK		GENMASK(3, 0)
+#define CXL_HDM_DECODER_GLOBAL_CTRL_OFFSET	0x4
+#define   CXL_HDM_DECODER_ENABLE		BIT(1)
+/* CXL HDM Decoder n registers (Offset 20h*n + base) */
+#define CXL_HDM_DECODER_BASE_LOW(n)		(0x10 + ((n) * 0x20))
+#define CXL_HDM_DECODER_BASE_HIGH(n)		(0x14 + ((n) * 0x20))
+#define CXL_HDM_DECODER_SIZE_LOW(n)		(0x18 + ((n) * 0x20))
+#define CXL_HDM_DECODER_SIZE_HIGH(n)		(0x1C + ((n) * 0x20))
+#define CXL_HDM_DECODER_CTRL(n)			(0x20 + ((n) * 0x20))
+#define CXL_HDM_DECODER_DPA_SKIP_LOW(n)		(0x24 + ((n) * 0x20))
+#define CXL_HDM_DECODER_DPA_SKIP_HIGH(n)	(0x28 + ((n) * 0x20))
+
+/* CXL IDE Capability Structure (Section 8.2.4.22) */
+#define CXL_IDE_CAP_OFFSET			0x00
+#define   CXL_IDE_CAP_CAPABLE			BIT(0)
+#define CXL_IDE_CTRL_OFFSET			0x04
+#define CXL_IDE_KEY_REFRESH_TIME_CTRL_OFFSET	0x18
+#define CXL_IDE_TRUNCATION_DELAY_CTRL_OFFSET	0x1C
+
 /* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
 #define CXL_DVSEC_FUNCTION_MAP					2

--
2.34.1


