Return-Path: <linux-pci+bounces-16706-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 386AE9C7DF5
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 22:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90326B290DC
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 21:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD5518C019;
	Wed, 13 Nov 2024 21:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k6XSyKay"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B1A18BC1C;
	Wed, 13 Nov 2024 21:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731534970; cv=fail; b=SAUXkx1e7qdG6myPS2Ks9ZsfLWO9e1ByHaP7ukpIKm7Z8Ev88r8u/eTmk5KygGbv9qTCldY+u27TEeuI9VaWR2uogyP7Bb+DJ0juqKlu4pq+RKDZlyBdJP6+RwLylfVqUVIi1qEMKv/wEIe4e5FTEDA2GFDocqOIwg8HfX9FyZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731534970; c=relaxed/simple;
	bh=A9MsTB3/RKJEp7BGq7LE/dxX48/us6hacCs8ccVpXoU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lQIg3otgrcs/uXBrbwL/TVDJkSzyFWiu+Pj0n2D0lTtVk3NpEmRiiIaIo6MbzIB4TuH5EyYKwnHbvgxzSYxc5XOAPbhowC62pvEIUqIK/k8xVi8uCeN3QElgn8Gm9ygGcSFmI5CVYfW8EVBVc0yxdiuG41BsrgipYc2G0j2w3xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k6XSyKay; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CfPS8pXmKLKk+iE19wKk1NZD3qlJndk1oGkpbWdDlCz7sHnOStUl4xv+2zVdBTLLq9oSV1dEvCWC/PeWFzTpWmi3CbHLJzj8UzSe1Hes9xI9NXTP3qv5CH7UzKcn1XngqzYzhHu1CyHvS+X4tWINW65/NcwKJFi3x3RdrUEU4B+hExvsBlIA1+kjzTZ1NSqr2j9w+sROoEJj4Uzr2KtAItsWkBeGUoR3hWQVNzzhKpDBmbkgr+ybRWR4zGLfaHoNlkBmRYzRNgaw0xueovCV7d2ktMNKLUAEK3XSJ3IGSFEc3XixolNDF8AbaQ41lBmIqRdsAhz+SoJ3KEwMzWIAYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8m9LqcmlcZycehemOXIjBK5ZuYnVpb0H7lwiIP7O4NY=;
 b=Axyzf5mYSLp+6sBWiAQeBieY3JT2PTqA9sAyKzH6UnOcTs7Vdm6xEGUGO7Q6Llp/1fvVG75zL6ubGsTI2qA6xER6NqwKlT5A6/4sOWST3s2wpFfakj83bJeJ42PtKKmQx08otuMsvpy0IyX7guoF8pv312oQwgQQAA2Dly1bMVY9W3ue7iFfJR8L1StT3ywjEsfwTB1D74WzOsYNLb2zJwP87vTIUh2PE63bNelPb6/UGTnOjGoCRyFcvIfaWrmv3uX/ASMSfdgcQ0zxLzrRlUJ94Os9h4onnzdJhNKGykHWm/hXqD4ZwF64pQhL9AAQSm9SNWRMEln4gwj1t2Omow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8m9LqcmlcZycehemOXIjBK5ZuYnVpb0H7lwiIP7O4NY=;
 b=k6XSyKayowWsul0xsmgkUxqxa1O0uPpQjNzyuZpPSEwh3CLpZ1UmfbuPlIsB7xNJ7T+/PIIxMJLjgfD989D5mOWsxzUYe0HS6u0ZjvLeG8CGGIjVWLPj4ncG3ThUouh4Bpb+9GGQ6ZuJO5NWd2fqcSx18kSC3E2j3gxltUoX1is=
Received: from DS7PR06CA0026.namprd06.prod.outlook.com (2603:10b6:8:54::16) by
 DM4PR12MB5890.namprd12.prod.outlook.com (2603:10b6:8:66::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.18; Wed, 13 Nov 2024 21:56:06 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:8:54:cafe::42) by DS7PR06CA0026.outlook.office365.com
 (2603:10b6:8:54::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Wed, 13 Nov 2024 21:56:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 21:56:05 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 15:56:04 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <ming4.li@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>
Subject: [PATCH v3 08/15] cxl/pci: Map CXL PCIe root port and downstream switch port RAS registers
Date: Wed, 13 Nov 2024 15:54:22 -0600
Message-ID: <20241113215429.3177981-9-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113215429.3177981-1-terry.bowman@amd.com>
References: <20241113215429.3177981-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|DM4PR12MB5890:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a4b6527-5135-4ea1-b622-08dd042df955
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W7yDl2UVDFliucrbz/IpqQ+NECvcDd8XwC41dexLAmZH4mSPPpq2FoTeiuN8?=
 =?us-ascii?Q?iHOO+KeD3Y5vw641D1ffwUPm8S5Jzzo9fHAW7qQfntYQRNxrOeeAc2txSC4S?=
 =?us-ascii?Q?RxLPw0ygRyRPkHMDU2VLLwgM4168EJgCA00yGUcmz43JBdAn/ECfXNgkX6Pq?=
 =?us-ascii?Q?iA19+a1zhU7asGdEzBogSw/I8HY8ocXalnT0DQDWAjeGlmtU5vEo8G8Q5XyJ?=
 =?us-ascii?Q?ckgl2aFHpo+WrOihk4lnuWQy5rCCAbXASNnldgwdVDJW8IPZo15wV09aq3tG?=
 =?us-ascii?Q?14JKxL4dwlRXdrp5PXRm5YHC4SD8ZyJ9tIPOD73MhCSbwz3Q8PIphmU9OVeg?=
 =?us-ascii?Q?5965S0bvy6KfeX6V29W9fvHXSF5Tb/Ewzvvi+eIPTJLDG2uDgMEYqhH/Qp+X?=
 =?us-ascii?Q?HdxnRC8WvCPADXfuOo5LLsRfgUrTdo16COStad04m5ynP8wLeZRGifgk4nD1?=
 =?us-ascii?Q?EIKaHNqWVCON47SkIeL7GaNO51NSdQxxohPtYLNPYU+Qrh0r+XSSCmUCY7EI?=
 =?us-ascii?Q?8VKzYSmEKL3bgBMcwjXcCkLBqPGIhqouYinILG3CvLxSSr5sFTZ+qipyL/EE?=
 =?us-ascii?Q?L/kQPTHoWZMQA840+CfG+4R/V7FQpkXQlrjVz+SB/IsmWVP2qARoh8zvpocS?=
 =?us-ascii?Q?pBPDo6JIFUEKt793eGFo4OvY6oK25F5yLOhKXGa2PIWUo46uQa+h8d8PRyEs?=
 =?us-ascii?Q?fuO5tnVvKD0Z0iwaVD6XFZI8qvsSm4vSg4poB72yDa2GuFI19qPKx+43wYXm?=
 =?us-ascii?Q?R2JzZ8wPkzz6w5UCjTf922U1qqhDmUcdIdJ8Z1HzAC/dZpuGtMXbx14YeKIF?=
 =?us-ascii?Q?5BqM7hf+1M8n7tZf2tNjK4aNFJ5hvHl2oRlUZl7G95M49X9Bd/2LdIiNttyS?=
 =?us-ascii?Q?lyi9pJck0h2T4XYZvWsTKzEIuDG5T070B5W31IHlRbBC+cfd4xZ4UfzwYe/w?=
 =?us-ascii?Q?v82A8dYVLFMK9+sih8qPVOUvq8NY6hJEEiAIM7EDiN0sF5qKJrYRe9Fzft8I?=
 =?us-ascii?Q?Y8Pa8MgJ3Qt00merHLSf61DbzF90RLkusUfaUmuNBs92DXioFiDrjeHSOU2P?=
 =?us-ascii?Q?lUvR9rvOC32tiU6v6Mq/lmMf1YjksJDo1yXCSMP+eAVNZ+s3Z4P4AmpxGUW/?=
 =?us-ascii?Q?Bj8wa3Vf8E3cocbK0+LQSMBKB8c6JdFhhMxGq7IGGVijTVF3IOMiYDOUuhKQ?=
 =?us-ascii?Q?rzF2IbgVylk4a2s9mTkcDRtCFoMq878CIOv2yrDVoqR/vhn2x/WrIgGeY8n1?=
 =?us-ascii?Q?TQYROz8FZjqi2o6/MD21RzN1Jd913UEQkwusTlOdsMcbi7SBo2jNUDqDPo8C?=
 =?us-ascii?Q?4VRuJ3+x4Y0KssH/aXiHY5IoKdpwldyjrNLCI40f14fJSZGRCQdKbawOoHMz?=
 =?us-ascii?Q?rWv2meA234OqDeXtxBbghhPbUHsyxKxlKGwjqSXHUSd2i//cUEdbtLwHOlNu?=
 =?us-ascii?Q?dVk9INz5fKQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 21:56:05.8099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4b6527-5135-4ea1-b622-08dd042df955
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5890

The CXL mem driver (cxl_mem) currently maps and caches a pointer to RAS
registers for the endpoint's root port. The same needs to be done for
each of the CXL downstream switch ports and CXL root ports found between
the endpoint and CXL host bridge.

Introduce cxl_init_ep_ports_aer() to be called for each port in the
sub-topology between the endpoint and the CXL host bridge. This function
will determine if there are CXL downstream switch ports or CXL root ports
associated with this port. The same check will be added in the future for
upstream switch ports.

Move the RAS register map logic from cxl_dport_map_ras() into
cxl_dport_init_ras_reporting(). This eliminates the need for the helper
function, cxl_dport_map_ras().

cxl_init_ep_ports_aer() calls cxl_dport_init_ras_reporting() to map
the RAS registers for CXL downstream switch ports and CXL root ports.

cxl_dport_init_ras_reporting() must check for previously mapped registers
before mapping. This is necessary because endpoints under a CXL switch
may share CXL downstream switch ports or CXL root ports. Ensure the port
registers are only mapped once.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c | 36 +++++++++++++++---------------------
 drivers/cxl/cxl.h      |  6 ++----
 drivers/cxl/mem.c      | 28 ++++++++++++++++++++++++++--
 3 files changed, 43 insertions(+), 27 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 5b46bc46aaa9..1c6761278579 100644
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
@@ -790,20 +778,26 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
  * @dport: the cxl_dport that needs to be initialized
  * @host: host device for devm operations
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
 
+	if (dport->rch && host_bridge->native_aer) {
 		cxl_dport_map_rch_aer(dport);
 		cxl_disable_rch_root_ints(dport);
 	}
+
+	/* dport may have more than 1 downstream EP. Check if already mapped. */
+	if (dport->regs.ras)
+		return;
+
+	dport->reg_map.host = dport_dev;
+	if (cxl_map_component_regs(&dport->reg_map, &dport->regs.component,
+				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
+		dev_err(dport_dev, "Failed to map RAS capability.\n");
+		return;
+	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, CXL);
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 5406e3ab3d4a..51acca3415b4 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -763,11 +763,9 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
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
index a9fd5cd5a0d2..090f0b74526f 100644
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
@@ -62,6 +87,7 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 
 		ep = cxl_ep_load(iter, cxlmd);
 		ep->next = down;
+		cxl_init_ep_ports_aer(ep);
 	}
 
 	/* Note: endpoint port component registers are derived from @cxlds */
@@ -166,8 +192,6 @@ static int cxl_mem_probe(struct device *dev)
 	else
 		endpoint_parent = &parent_port->dev;
 
-	cxl_dport_init_ras_reporting(dport, dev);
-
 	scoped_guard(device, endpoint_parent) {
 		if (!endpoint_parent->driver) {
 			dev_err(dev, "CXL port topology %s not enabled\n",
-- 
2.34.1


