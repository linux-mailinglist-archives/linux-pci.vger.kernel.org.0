Return-Path: <linux-pci+bounces-24801-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F7AA72845
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 02:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8189189D65D
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 01:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AC217A302;
	Thu, 27 Mar 2025 01:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Dh1FS3Gz"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A663B169AE6;
	Thu, 27 Mar 2025 01:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743040062; cv=fail; b=PjzOFU5tuGl0RBGG6XPpEp9Dp8W1uh/WhElav0Twt/esoNkGMhdP1vp0Qt8xB576ANBjx2VsO94HlDTX/Y4tc9/TA5gkVvEO0ODS7Gr8Ko4yperPvJwZCYC4XapKpvE20xruB4hpXcpVhyY5lybhNI6FNn6H/T1YdhuBlMR2FQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743040062; c=relaxed/simple;
	bh=N7QditvkKZ0vgfJsq02Vy0Vo4tQLeoqVN2iJGdt+sjY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t33GdfUABvPDBHtqi2N9fm7y8BNWNAwnV6KzcyEvXmY+W0mTPzoOVzjBFXrYJCOgPHqn6HlJTKQ+VV6zqonpAM83HhjiFa8hIzwW22A4XSLQTDTyQHby6VPis3dPfijDr3aBqz8wVF42OSZqiXu+MwsqdDXo40zDKmh0TjNEfyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Dh1FS3Gz; arc=fail smtp.client-ip=40.107.244.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sIjsPTLHAgq4itbBtXGJkPAZmFJdCMRjifUp7pp6hmxoQwIsBLKrH1eBRUh5EWBbN4METVJtuUMbqEItNPgakKGVwwIzHW752a4E4puuxfrDwpvAwPBaJQW3BLCYOhAiItGNybWnwFvNw1oyLbX2RrX5vusHUjICFz3NZuwuyDdgif7GvoqsOQdUNk8qGxit4bIhBHrsnzAGpHBS+bV8yKagoDRtft8s7CjF+Jo1fUiTzkhr6JWV8Ai/RfeAkiFR3FpurrzleDBXU19XgEK+ExJXdxqSX1/66EhTeiU4DoSVLjzUTDF5DaPKU9A5FwECkUPO+vSeFM9CVMj4GpRL5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88PTImvXJu0Nh+jE/jX2UbJN5DaUdt3mwrlHRQcMWSQ=;
 b=MtNmWXFUtCsDi5YYktSZqxwViTONRAGY6UtdniTCn4g4mHdrsyBIcJAOjcqO4w/PLupCm2vDWEScrbilRv3PEEs2bsGcGqv4RUu/LWV4QjeNPqMU4t/xFAON5Th7bFR8pF1GyN9l2E7wkump9/ILCBRZrvFNXiDJOztCK4XL+9YGhkGJkpvIsU1GWJNS8lkwH8tYZ/rqaLPZyV2KKuCKLbDjYu9Tj3ff7jYXnA/vbY0gPh7qh0DSztWVadMoQnkJJ/5Knqz5hc5EZnqBosvnRSkdmKBbBIfcBFkngRz5qAdfBGDqAVNxRtVSfW0jWexnNKiyrMFsO3gfmuT9zkvPfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88PTImvXJu0Nh+jE/jX2UbJN5DaUdt3mwrlHRQcMWSQ=;
 b=Dh1FS3GzBqgRtjftc7NNcNw7akgtNd3JrwHrc8xyGcY5d1xBIjHGoiO4YlCLo3PYv0BVBdEuQYuLqB+6VZOza3IJm9/2tw47axNiJ6WBraK6arvQSbwmpnjVRK/zCwRdOGUACgbKmQmjEKXgL0x59aCEqbkdrjOKodAtaCETzVw=
Received: from MN2PR05CA0009.namprd05.prod.outlook.com (2603:10b6:208:c0::22)
 by MW4PR12MB7264.namprd12.prod.outlook.com (2603:10b6:303:22e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 01:47:36 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::93) by MN2PR05CA0009.outlook.office365.com
 (2603:10b6:208:c0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.27 via Frontend Transport; Thu,
 27 Mar 2025 01:47:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 27 Mar 2025 01:47:35 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 20:47:34 -0500
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
Subject: [PATCH v8 01/16] PCI/CXL: Introduce PCIe helper function pcie_is_cxl()
Date: Wed, 26 Mar 2025 20:47:02 -0500
Message-ID: <20250327014717.2988633-2-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250327014717.2988633-1-terry.bowman@amd.com>
References: <20250327014717.2988633-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|MW4PR12MB7264:EE_
X-MS-Office365-Filtering-Correlation-Id: 5370a4dc-19f1-49b5-385a-08dd6cd15941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ujPsz5zOIgeADq8J+wr/PtOoh+5WnFqzGi+VwLbFPbj6wMg4twG1bxfmog76?=
 =?us-ascii?Q?e0zFvXCjXJYh9N6HXG5fdu9n3evPswk2fTE55bLEImfO7G9fz1wUuDQIWsnA?=
 =?us-ascii?Q?5o/bEkD51+G1+UFEZb0fnELrJCrmHrurar811vSEbkz4vQYVXbA2mH8L8nBX?=
 =?us-ascii?Q?+eJF3Gjd83C5p6yrSFl3cZWCs7xYZ0nGpdmxd0obl50qVSTitqnas/mnZ8dp?=
 =?us-ascii?Q?PG60PNRnqvw1nCbeUvCuzOg4wR5rG5TnQvYE7SUKI7ciyE+YetaLD3d+dlht?=
 =?us-ascii?Q?AucO8ebJB62ksG/v56nNQqcoSKFQcCCUDxsnxvk1qUYKI9LzTkQjzezSuHCD?=
 =?us-ascii?Q?TCEt24F+aWXv95lRawnH2WYIHcw/bF8QN9AhwMraw0WJ87mY6hQLWgNqSSJx?=
 =?us-ascii?Q?VOzH2cWy806mJLbQt4SaOr5nPKzon425YykqTkMbCWap9umE1GGuUv3Mp1N2?=
 =?us-ascii?Q?OSc0sdJLp54ielYlX5Qtbs1R/IGB79pK+uGXrVBko7dTT7QcY7Q4IguDln6c?=
 =?us-ascii?Q?mZ9U8t5K8tQee2brybMKxSjDgkC40wxcK8G2PECJRXf/rQeOscSCyxtPWn6X?=
 =?us-ascii?Q?N1f7CCq7lN8WYVXl69b6l59dZOWJKDS7P+eflGZRTOz2m5kLb2qejlSnK6bF?=
 =?us-ascii?Q?TlfkcQMQ3ROlNvAhVpQ5JO85Mulnmij7/6KuW7joAzasmDw8dgvzhLgyafey?=
 =?us-ascii?Q?bsTFzs1dHh4+wdX0/Kod7kSQDg8tHDzl2ek+V5mt7FRfg1YBLHvbz/RioFJN?=
 =?us-ascii?Q?/W3b74+3r17kv3QFSc9LzAsNR00/9xX/VJ/4hRW9jsqEdKr6JOZvnM40u1AN?=
 =?us-ascii?Q?pY+CtlGu8CK/aM1nHYKbN/KPCPrqudVJYZTrrNOaJY73raw7KRjUVuP8odAc?=
 =?us-ascii?Q?3pDu4g5rycfm8hxTu516++ZBWmzTPaY4bVCzPZpNbqTksDXwtAhaB1X8K/2e?=
 =?us-ascii?Q?/Is7j9P1FdtBlmwcumk9PXyeBIpvHdBMoGch86k0F5evRQqh2nBbz35pnQgX?=
 =?us-ascii?Q?3lu2y4p7G0G+t8TtonZTvC0yiCmlpv/GZQQIpEORQMrK/EXFRL8UjHZLOOQ1?=
 =?us-ascii?Q?kRD3O5JhYrGCDnxmT6X50Mq7AotAkXesnLjDAEbkwKs4rd8blyPBKoBKSpFH?=
 =?us-ascii?Q?n4ul7x4HAPcH4t8rcG+frNcE+gGK4sgutnpzjOHeTVLoNOeEhl0j/ugGK2qH?=
 =?us-ascii?Q?iyK/OvMJ8ePyYymmWvg8rE8tb2VIQbJKJfDfITneTlbrZjRfYb05QabRQGM0?=
 =?us-ascii?Q?Cwv1UZNIa3Ql0MKjOIAHCu7wiYQJsw4ctSFLHtuEwOtP8plET9pQ2BfMNGxG?=
 =?us-ascii?Q?vxdEmUcV/+MEMm9+csjxrCFoS4o4cWRGD9BILfLkZfbcwKtQo0f3ZLlyhAWw?=
 =?us-ascii?Q?qKZxh776yC8H60qAnFqhpknNcHzR8vmd+rbLdkaHJ0Yo+npnIdYXyp5dZ8+k?=
 =?us-ascii?Q?9v2VVODPsNzzScrCuwtuXR9qxzbNAk9tVDPf7R335ohdv9yUYYGqry9DXxoo?=
 =?us-ascii?Q?ewJNtynP60hTedK74CiMluK3omHleimWTe+2?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 01:47:35.7577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5370a4dc-19f1-49b5-385a-08dd6cd15941
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7264

CXL and AER drivers need the ability to identify CXL devices.

Add set_pcie_cxl() with logic checking for CXL Flexbus DVSEC presence. The
CXL Flexbus DVSEC presence is used because it is required for all the CXL
PCIe devices.[1]

Add boolean 'struct pci_dev::is_cxl' with the purpose to cache the CXL
Flexbus presence.

Add function pcie_is_cxl() to return 'struct pci_dev::is_cxl'.

[1] CXL 3.1 Spec, 8.1.1 PCIe Designated Vendor-Specific Extended
    Capability (DVSEC) ID Assignment, Table 8-2

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/pci/pci.c             |  5 +++++
 drivers/pci/probe.c           | 10 ++++++++++
 include/linux/pci.h           |  3 +++
 include/uapi/linux/pci_regs.h |  8 +++++++-
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 869d204a70a3..a1d75f40017e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5032,6 +5032,11 @@ static u16 cxl_port_dvsec(struct pci_dev *dev)
 					 PCI_DVSEC_CXL_PORT);
 }
 
+inline bool pcie_is_cxl(struct pci_dev *pci_dev)
+{
+	return pci_dev->is_cxl;
+}
+
 static bool cxl_sbr_masked(struct pci_dev *dev)
 {
 	u16 dvsec, reg;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b6536ed599c3..7737b9ce7a83 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1676,6 +1676,14 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
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
 	struct pci_dev *parent = pci_upstream_bridge(dev);
@@ -2006,6 +2014,8 @@ int pci_setup_device(struct pci_dev *dev)
 	/* Need to have dev->cfg_size ready */
 	set_pcie_thunderbolt(dev);
 
+	set_pcie_cxl(dev);
+
 	set_pcie_untrusted(dev);
 
 	if (pci_is_pcie(dev))
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 47b31ad724fa..af83230bef1a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -452,6 +452,7 @@ struct pci_dev {
 	unsigned int	is_hotplug_bridge:1;
 	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
 	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
+	unsigned int	is_cxl:1;               /* Compute Express Link (CXL) */
 	/*
 	 * Devices marked being untrusted are the ones that can potentially
 	 * execute DMA attacks and similar. They are typically connected
@@ -741,6 +742,8 @@ static inline bool pci_is_vga(struct pci_dev *pdev)
 	return false;
 }
 
+bool pcie_is_cxl(struct pci_dev *pci_dev);
+
 #define for_each_pci_bridge(dev, bus)				\
 	list_for_each_entry(dev, &bus->devices, bus_list)	\
 		if (!pci_is_bridge(dev)) {} else
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 3445c4970e4d..7ccb3b2fcc38 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1208,9 +1208,15 @@
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
 
-/* Compute Express Link (CXL r3.1, sec 8.1.5) */
+/* Compute Express Link (CXL r3.1, sec 8.1)
+ *
+ * Note that CXL DVSEC id 3 and 7 to be ignored when the CXL link state
+ * is "disconnected" (CXL r3.1, sec 9.12.3). Re-enumerate these
+ * registers on downstream link-up events.
+ */
 #define PCI_DVSEC_CXL_PORT				3
 #define PCI_DVSEC_CXL_PORT_CTL				0x0c
 #define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
+#define PCI_DVSEC_CXL_FLEXBUS				7
 
 #endif /* LINUX_PCI_REGS_H */
-- 
2.34.1


