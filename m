Return-Path: <linux-pci+bounces-21198-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04997A31557
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 20:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8A0D7A3A87
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 19:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190312638BA;
	Tue, 11 Feb 2025 19:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MdSv8ikm"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAC1263893;
	Tue, 11 Feb 2025 19:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301978; cv=fail; b=A3crtlBeadyNYKIJBJeqfHRNDJ2Rmnaium4lHV1S7koGAq9ACRm5eD7n7nu1N7SY6qpiDdS2fX4HFwSDB/v85/G9exzMXi8DnBpbH/cOeZSWf98ioHN/M2vZ4cSZ6u8zZNqQ8EcCcoSaHif0qe5fESipmHp1BsbIfLEKNDsOQJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301978; c=relaxed/simple;
	bh=5L5KGW+AdQbqpLUB68q04OZCflKakMhhmZ2MyTgKOlI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EWQGjYht6viPUgEpxKxXPLGvQux6xae/3r2JheRn6r56lDh8EFw482SVAjgCqcrVTTMWYOlsZJa+smFpnLUn89XmYsRKbfe9oidq560z2IcwmuceZ3qH3QDVua0vRwfDfm22sDThM1aWR2I51zPS6NJFBynK9vjJkPdkF2fpsCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MdSv8ikm; arc=fail smtp.client-ip=40.107.237.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PYphtapxl7UGZTfnDO57VG11h6TQ80bDX7zqh4jDI79O8UhwtOOkAPWFyhgNvKSRXBKWYAm3jgLT00c2IL0rPU5SiQQcwtKmypUL7ZDBtK3mz3blGZfKdY3bSA4sFkMWgG1snYpggbe6ywE98EDlx7//KwhNIOVTj0SU/S5pCfxKjOAvMStgfCnMydlXMQbBBxhL1ikhLa6P+Q3ck0iw6GsXxRvzJmukulHakiwAzlndkNBmwY9z27XvRV0MGHex0VKy5gCvw06qfIMbVwu9Nuj82/uRXTasaOaOFpIqe9WM0MB1zPvkJy0LD4HziEHeQZPpnUhl7Adz79GnAvl31w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHMLKSKsL8S19NVWGSHU7tsnHRim28JcnCdJ+hQor04=;
 b=bxdnBcLkijdA9HpYK5+VFC9HW8jZPIGGu2zn0fYhgieHf0vTA4hshGJ7kB58qcmcOI7vWnSU4pEpEg4JIRvZw2ZKgK6FI2HWtj7O79KNKA0oUUv/uuI+X1fV010zfo70JHa9sPivn+m8XzW6Hkv8lGxSHFzFZ6xHE+bZfP1vxjtu3n7hOYuWQWGEQr6g5zyXHD7qa0ad3emDkM3D7qbukKrbmLSzUEvyz8OOuX56b/KLT0GpyGAsQRyhqSe6nBBcgBuzxRzNS8xBqp2rEpDtSNIif+LEU/EzSzCdkehxFxhHIEPrQTl+jQI7C6312GFKE0ZGaEBAzw9jDRFvG29UQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHMLKSKsL8S19NVWGSHU7tsnHRim28JcnCdJ+hQor04=;
 b=MdSv8ikm8JBoD6aTXc7tdrF6kXK8N0oUSF1bQV8Rf1WENpMl7VwRZR6Y2eCszuPQOTqeuCSDkHDAoiuo5AFe2mIBXkajyeCYdwE7a5oL+jOi8b7f972/ArD/fCpoclHhM5sukVPtVCuELcbcEDp7WkLBaGT/AMbU4oguRLwroqs=
Received: from SJ0PR13CA0219.namprd13.prod.outlook.com (2603:10b6:a03:2c1::14)
 by LV2PR12MB5824.namprd12.prod.outlook.com (2603:10b6:408:176::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 19:26:09 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::5e) by SJ0PR13CA0219.outlook.office365.com
 (2603:10b6:a03:2c1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.7 via Frontend Transport; Tue,
 11 Feb 2025 19:26:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 19:26:08 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 13:26:07 -0600
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
Subject: [PATCH v7 07/17] cxl/pci: Map CXL PCIe Root Port and Downstream Switch Port RAS registers
Date: Tue, 11 Feb 2025 13:24:34 -0600
Message-ID: <20250211192444.2292833-8-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211192444.2292833-1-terry.bowman@amd.com>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|LV2PR12MB5824:EE_
X-MS-Office365-Filtering-Correlation-Id: 062654a7-f03d-4634-b194-08dd4ad1efee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aIZNkUj7eVDNsRxemkilUIXbw3NNXPTUc8nLI2Hnbl7QoOnTo2rAzjY9B/yF?=
 =?us-ascii?Q?tLRVd+AcDpWyYJJ1QKCQ2mO176Qe1shQ+vPwkHnxlY7FpT/jnUNkRhIwGcQj?=
 =?us-ascii?Q?nn1iUWWixUo9BOhO/F9OcNfsh65K9hqKuyJcvJiPabsnNxgUl3k0qr5sbxtP?=
 =?us-ascii?Q?dbH065lXtPTdSn6ihVOwmynIoboMxBX3dJZ0SMWibkdz7Pwkm9h9WKgERoEG?=
 =?us-ascii?Q?8e0ZO9xxgDyhSmPq5ilXQKO6NFVe6gQHFwvOgVjrfZtNlPpwAdwfMkhoRydr?=
 =?us-ascii?Q?TSIEvrzDrx9t3/sGN0CL930k44mvS+WTQseaBLNtp09wS6/7QSogrRYHqWvQ?=
 =?us-ascii?Q?LxJHAsQt86I4rIn8b/ElQbSQ44IS4COT0F7t7smG7IdgvfZrifFbglHizHX8?=
 =?us-ascii?Q?B6gASunK7d9HpnU1xqYYDou71ClQPwagxrLTQuUxNchoOrpKKu6s2TCtAHR3?=
 =?us-ascii?Q?YFwXs68+rSLAQFa+JwiF9ArYL4JrclgBIOahzdt+T8Q45x7EYjUwcrxpQcQ5?=
 =?us-ascii?Q?TKEzw1zQgdf8IeEGZ8IxVPtC8k9TEP42QTGiMULGPtRoEBaym2fsz0f3n/E9?=
 =?us-ascii?Q?AGQsc/RFHkXisFzv5fCytfSieqofoMJ8V58gzSaaJyVv5DcIifan0kZFr4ng?=
 =?us-ascii?Q?ghWZyEb8wXKyoN7cnMvJ2vNdmXOSdXq4X0sTmaWWJFM2M5PShhX060fZ99Jr?=
 =?us-ascii?Q?4Byld9WPFdBJmZWgVW2tFTinRE1gIV0ck0x7WjCLQFLCHuhhfNB6cM9kvkJ4?=
 =?us-ascii?Q?fh84MAtPwVG9f0tdNgLWHEcO4owgElZqnyq6pu8BoN9JIarLqDBotqa51BUO?=
 =?us-ascii?Q?YzixA+phh5IfOvCuJdzYvC5K9pIOfX5zn00AEhvHRWPlEXVrRamYWWyExyUf?=
 =?us-ascii?Q?bvrWjgPi4JET4EKlGq8kLKFr2i7EhjBFjTjsteRhBZTI6n1jAA32yGHv/enp?=
 =?us-ascii?Q?YejZZE5Zx6uoyh0RHfLO4o3/tdlE4Bi4cw2WVc7qWIyYBO0ePQZtuQbugKA1?=
 =?us-ascii?Q?bxFS8+vL7wB1imJLr2gbaE/Sw5vuHE9gtzcmQnLhduvi8TpdV/rnwlJ415NJ?=
 =?us-ascii?Q?rWQlPzZxrCgmi+2Rpo0sU1K+oZKZZXZW8FGixlBmILulfXaTH1ciEvdWGlVH?=
 =?us-ascii?Q?iLIPIcFjvmmL/ZR3KywP4z+A6l4/jBrXXcZN2GHNRPpUjB8ejZy8moiGehh8?=
 =?us-ascii?Q?yWCJrpwQUqLezcQl3qPUm28lfuVqa+eqS4zxmYwM598Tc54U3dr4g53DB3qS?=
 =?us-ascii?Q?TWkQ/wdXgsjqks8LQZyk2dQzOuQ6ia5ZkuzJMuuV0ChRdnPTKtyzQIvFnluL?=
 =?us-ascii?Q?LCqwf2fIopGOLsijkw4qi0e0ibasEcirtCnrYfyhDSnj4UTRjYKDQJlkQJp4?=
 =?us-ascii?Q?xCmBtDTH1pE5qjOWtp0XUowrsfWsb6yfsplT6tLGwpuTozz4lCWnssf4HZFu?=
 =?us-ascii?Q?vriOEk44glFblUug1dNKten/st8ZxptZ+OwBCVFs2srmlJY9gCt24fVvuyrh?=
 =?us-ascii?Q?N2w74K3nwYLZBPHZnyCFoZSCZR6ZoIpZ6uCL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 19:26:08.8933
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 062654a7-f03d-4634-b194-08dd4ad1efee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5824

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
index a5c65f79db18..143c853a52c4 100644
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
@@ -749,18 +751,6 @@ static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
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
@@ -788,22 +778,30 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
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


