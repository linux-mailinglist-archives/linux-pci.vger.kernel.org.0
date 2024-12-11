Return-Path: <linux-pci+bounces-18195-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE6A9EDBD6
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 00:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9658518876E2
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 23:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72571F2C4D;
	Wed, 11 Dec 2024 23:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Dw8whzrW"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB32E1DC74A;
	Wed, 11 Dec 2024 23:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733960448; cv=fail; b=RBPU2+snTLNGSdAxKWdsuHXKgF/ZYr0fp+pR1blL5PjOox0jXe9C4o8/lhPeRYDgU1CoPvlFg7Ea0W82QF/9LwzqoBLzLL9cwFZ8/fWzZbDBq+m1dcW2+nTHwwUfXWu07s+NM8ak8tKpjeEFi6dkVDlwq/lAqzLbYYQ9B+V38f4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733960448; c=relaxed/simple;
	bh=wCxYOzVP1PG3xf7tbDQIOGXw2n0Ef06XmdVDUPR1m1U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rcxtE4tTGOHnb00j+ACYUlGDSHjaz/7v0axFIhTiky+MSiNg1Gsn8Glx5gHz5JzA36Hv1Wyzl2qhWpKPnXI43MW1MzCUHbBxJsqrHIPG6byVhFC4kRfubXEWyYiGTlYxRlS0Bosr+e8Hf0aowlYJwu/U2dMxRJeTIey0xghKDOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Dw8whzrW; arc=fail smtp.client-ip=40.107.92.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NFDj2SbvKHhbQ1bEjB81tyFcllv9VvUvn6DsP1hmhB9+LWi/D/+1uBvrkbtKnkp5T3sWEEt8kTp45UzbNwBm4F06PVZFO3e9tYafAPxyOXsx140hhxxshCEW90r7Zn7MDedu4ECm9T9IT6Eaimukf86NIBdjpJA3tkddHTenu8Cl9RnrYml1G+JsxrcT3O4+iZLNedStZ6aLosXSDMIGvKU6zawMzcyCQmWhrNkmzHvVj4blKKhaPnoanyAaMagq1ZTV95+5M0NK+SyQO2F51u4MSIM1zIBIpDD6YGYJe3JGe7Q1p4WXgQfigbmrWiAofyQQ7CmPXFwj2Yh3Rr3pDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSF6ubtvJ0BwYMnb83pdbsHf7idOSrdUjNdRSpz2IDY=;
 b=RIjiBs39YqjyY6bnFqpAibfZV7md7K5Xp4Ydnwtyd1UjLqkwb1WdjHr95ftXxtaFKZ6hWY/uzr6Ln47QX84t2iwWLkpw5S+gvTG1WzkwBP/wpmFvef1X8eFYd+z3GJ5K+IpziA4JgM237Fo8R6YZOvsQH08sgLkKfjQqKCest353ZXR0CEm62nY0bpdZl62PtGipvh70vaKAtd6czZYdHdm4fnkASMhoUkjrOm3NXN5wMLh8eny/Q0l3T+vDJp+RozeGpSPDI7l/5PWAvKHnSNfG7Vys6sN00jxylWyQiqPJkQa6Qxz80XucGsXVZgqTFGGMrAXJrC0W8aO44QDu1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSF6ubtvJ0BwYMnb83pdbsHf7idOSrdUjNdRSpz2IDY=;
 b=Dw8whzrWAtMlWMcYfKbIjD8g6jt5ASkmnINlOIIqZ236C+FJ0P0RH3iONIYuVihcrDZiZ50D3RsdCm+Fa0qlGqESI3uDDREbNKk8O/iOPvyPaEicTvHMp4iwWC6ig3abXrqnjtL0BI2Q7R5XpPGqKMOt3dgsaTGlidHFz4romnM=
Received: from BN1PR10CA0016.namprd10.prod.outlook.com (2603:10b6:408:e0::21)
 by SA1PR12MB7101.namprd12.prod.outlook.com (2603:10b6:806:29d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 23:40:42 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:e0:cafe::42) by BN1PR10CA0016.outlook.office365.com
 (2603:10b6:408:e0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Wed,
 11 Dec 2024 23:40:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 23:40:41 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 17:40:40 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <ming4.li@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: [PATCH v4 03/15] cxl/pci: Introduce PCIe helper functions pcie_is_cxl() and pcie_is_cxl_port()
Date: Wed, 11 Dec 2024 17:39:50 -0600
Message-ID: <20241211234002.3728674-4-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211234002.3728674-1-terry.bowman@amd.com>
References: <20241211234002.3728674-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|SA1PR12MB7101:EE_
X-MS-Office365-Filtering-Correlation-Id: d8d7ad88-60ac-454e-4b16-08dd1a3d39b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MgG7S2MKiH2cAhcyNkyanf2LClkEnu/MP2opOCkQvzi6ZWXktTeI4d9QF4YP?=
 =?us-ascii?Q?UhyzMCS2TinlBnxSUFShL3gD/jADWHj1f8ta4nS6y8oRcwDWIHvjE+t/+5w8?=
 =?us-ascii?Q?KFpe3v4328YJ6QzUdQXnaxvXCby7j3x/YA3E2GtL0iMnhTieb8dPazBsIRz+?=
 =?us-ascii?Q?yJWnwOTOaNCa9PjLMkQcKOOdw9pGNvSd07mfP3SkkVBoweBa4H/q2NcR5TBw?=
 =?us-ascii?Q?i/Yb1EabZ0kAiR1vOtyDpRHWZrcwID77R3u08L/c9EFwsL7TaG1+mvrQeQZQ?=
 =?us-ascii?Q?LRNKVo1+Xf0pUPwZHhqjIozLJr9huUxKu2QK4tkU2odMrVFr223OQ4v3KFvv?=
 =?us-ascii?Q?BrRZ3Nx+5CUVxcIVhIoV7e8P6fbupgeJgQbdPQ6W4DZO7aelEr5bkS9KeUou?=
 =?us-ascii?Q?VPxfvzLlcKlbTVCI9JLq/eYJV7tdxmwErZ017NlXQiHxRUW8ldC0jhAlyabY?=
 =?us-ascii?Q?H4o/XEJgI1mcCyfcpB7qx+Of8QUewQGCWqI8wnPQ1Z0d8Jc1NiLBzOVJ/zCu?=
 =?us-ascii?Q?NRSWJunLsnyYxTQkP6eh7wM+QKkxUpeRjl7bbhG2ID13+kTozb2AWK6o8j0b?=
 =?us-ascii?Q?2LcmnhFRhRxjekNB61deFhCVBGaBjeOdb32i2lNuPy10WRu0itcQSzfnqTq9?=
 =?us-ascii?Q?UlMZX1mFcetFiftN/PLXtGXm8TMCgYBv/ujyEHiJfCPGcOV1Amuejh2R8hkb?=
 =?us-ascii?Q?M703vFM0gQVv8ZTcutHNWp3SI1KR6PtFYVG5iAdStZg1NfIsdKSSC3MFsoTB?=
 =?us-ascii?Q?uc7JJ9fJ0D7dLelObykzd6U0xYKBwtM7Y2G8XV4CXWyS8uaKym4mcPi1buuG?=
 =?us-ascii?Q?YCqqZz4RZWBebf44Gu5+O2VkQeNnjrBSkdVA0rgwXwGGy5e+4mpqGwRFblYm?=
 =?us-ascii?Q?AIFcUuBADNliYUyR4J6hT680iGXxpGGL6/IpzqosU4xQksARUBg3BwB/zsCG?=
 =?us-ascii?Q?W816skRzRJjOxNOOv9tQHFJJX3DaGu0Y7yMLtpLhJgmYebA3zIMGm4OqRB4c?=
 =?us-ascii?Q?UshpMw5503WRem8h+POdfVIJ7YJJEpi1yFqHao7JGcb1qe15JVxiQbVPjHpv?=
 =?us-ascii?Q?i+AfQIJOzHjRGc8adVhrUE+ingDmH7Ykc58DJ9HGKPh+1/tO9nCH2g8eUpmF?=
 =?us-ascii?Q?iS3zEpGSW9mRc4g2mfS0nwd1dxL8h/B1AOmuFpo3oZWZMmPpD39V6hPWxG45?=
 =?us-ascii?Q?Gkn2VcC8jANILXeQ7KaCevVVQ1AlLtn2dr9GgQTz0Sz5baTkqkocGc+d+Wxj?=
 =?us-ascii?Q?lyp8jh/j7DL2ylLh++Nd+rWIRDM5iO5VRRGvLuWI/K8QwxZS0NJkBYo4ORCU?=
 =?us-ascii?Q?+uHH9k0bbKQGQboAhlXinytJCQZ9RROj0BChUIFhk7u8KmWfyaBLiUuaaFde?=
 =?us-ascii?Q?X6leOyW0cPhJJ4X361Fy8Hv1E8VAkzlUYX2lX+eHL5j2XNOq+7+bDfw2Qcoj?=
 =?us-ascii?Q?zYRyktq8wJnFG9nzVxjWVOjurvG+rlQDgArgKsarreJqmknmfaX45g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 23:40:41.9207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d7ad88-60ac-454e-4b16-08dd1a3d39b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7101

CXL and AER drivers need the ability to identify CXL devices and CXL port
devices.

First, add set_pcie_cxl() with logic checking for CXL Flexbus DVSEC
presence. The CXL Flexbus DVSEC presence is used because it is required
for all the CXL PCIe devices.[1]

Add boolean 'struct pci_dev::is_cxl' with the purpose to cache the CXL
Flexbus presence.

Add pcie_is_cxl() as a macro to return 'struct pci_dev::is_cxl'.

Add pcie_is_cxl_port() to check if a device is a CXL Root Port, CXL
Upstream Switch Port, or CXL Downstream Switch Port. Also, verify the
CXL extensions DVSEC for port is present.[1]

[1] CXL 3.1 Spec, 8.1.1 PCIe Designated Vendor-Specific Extended
    Capability (DVSEC) ID Assignment, Table 8-2

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
---
 drivers/pci/pci.c             | 13 +++++++++++++
 drivers/pci/probe.c           | 10 ++++++++++
 include/linux/pci.h           |  4 ++++
 include/uapi/linux/pci_regs.h |  3 ++-
 4 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 225a6cd2e9ca..c96c304bc799 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5034,10 +5034,23 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
 
 static u16 cxl_port_dvsec(struct pci_dev *dev)
 {
+	if (!pcie_is_cxl(dev))
+		return 0;
+
 	return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
 					 PCI_DVSEC_CXL_PORT);
 }
 
+bool pcie_is_cxl_port(struct pci_dev *dev)
+{
+	if ((pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
+	    (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM) &&
+	    (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM))
+		return false;
+
+	return cxl_port_dvsec(dev);
+}
+
 static bool cxl_sbr_masked(struct pci_dev *dev)
 {
 	u16 dvsec, reg;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index f1615805f5b0..277e3fc8e1a7 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1631,6 +1631,14 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
 		dev->is_thunderbolt = 1;
 }
 
+static void set_pcie_cxl(struct pci_dev *dev)
+{
+	u16 dvsec = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
+					      PCI_DVSEC_CXL_FLEXBUS);
+	if (dvsec)
+		dev->is_cxl = 1;
+}
+
 static void set_pcie_untrusted(struct pci_dev *dev)
 {
 	struct pci_dev *parent;
@@ -1945,6 +1953,8 @@ int pci_setup_device(struct pci_dev *dev)
 	/* Need to have dev->cfg_size ready */
 	set_pcie_thunderbolt(dev);
 
+	set_pcie_cxl(dev);
+
 	set_pcie_untrusted(dev);
 
 	/* "Unknown power state" */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f6a9dddfc9e9..33a9abecdaba 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -443,6 +443,7 @@ struct pci_dev {
 	unsigned int	is_hotplug_bridge:1;
 	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
 	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
+	unsigned int	is_cxl:1;               /* Compute Express Link (CXL) */
 	/*
 	 * Devices marked being untrusted are the ones that can potentially
 	 * execute DMA attacks and similar. They are typically connected
@@ -743,6 +744,9 @@ static inline bool pci_is_vga(struct pci_dev *pdev)
 	return false;
 }
 
+#define pcie_is_cxl(dev) (dev->is_cxl)
+bool pcie_is_cxl_port(struct pci_dev *dev);
+
 #define for_each_pci_bridge(dev, bus)				\
 	list_for_each_entry(dev, &bus->devices, bus_list)	\
 		if (!pci_is_bridge(dev)) {} else
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 12323b3334a9..5df6c74963c5 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1186,9 +1186,10 @@
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
 
-/* Compute Express Link (CXL r3.1, sec 8.1.5) */
+/* Compute Express Link (CXL r3.1, sec 8.1) */
 #define PCI_DVSEC_CXL_PORT				3
 #define PCI_DVSEC_CXL_PORT_CTL				0x0c
 #define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
+#define PCI_DVSEC_CXL_FLEXBUS				7
 
 #endif /* LINUX_PCI_REGS_H */
-- 
2.34.1


