Return-Path: <linux-pci+bounces-15354-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 823D39B114E
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 23:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00BA01F28087
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 21:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7017416088F;
	Fri, 25 Oct 2024 21:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k+ipOPNJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EFC17DFEC;
	Fri, 25 Oct 2024 21:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729890230; cv=fail; b=rzcazdqU5uflyK08XaI8pzfdPVnHiH4d76RVkXsvKai1C/oyupVph44i7iVl/sRUQzL4cnammrP9rBq2Avo9XW0zKm9ow/DlLnzBzeeKZQcgO5/y6ddQ/XFLXClKp7CGMm8mLzlQXx+sc2b2qBJqMxnA1SUuJ9D1DTDZ/XguMCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729890230; c=relaxed/simple;
	bh=6SmHFiEnGJpwhleO/GSxIknsXKe7BSXr2Jq4Y1MbXwA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OCePNH/zaRXKOvhBhS1RMoVMnpfZ8l5tWfIi9ArhmcmPH7sRYedXCMZQlVlLxJUifjyD9xkegBA0gxwGFAj4OabJjMakouL9sdu3UCXiNyBC7n7Ry2UmQeqp017F/5KQEB6oUtgSiUxpqWEW258yby/VUamQHrKSk5hHRJzbySQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k+ipOPNJ; arc=fail smtp.client-ip=40.107.93.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSFQ/Z1G1yb+GESLd9ozEMITd5QQl9jZ8uGlGvhUsU/unGeVyTKPmgCnrtu89gZSTqf8tseiwKTh5TDKGnxnsUzKj64noK9Q3ETpiwaBzonjES0PtVoYoeUrR2CT6qP0+SduTunszWYyWLNdMSI1C+Vn1Kj1XYXPa3HV28V1dqQZnpveD06XU18Wtd5l/jCdkWml+9w0P75GL6vE1He3mKg9SZH+qWDemSq9PutAy19lSYeD8Bnq1yG02143uFwTSpdN9S+mxZAcIVSoZ9S7Ya6ibcHl8kEI4PYgBjpRW0YCxKnEa0aEqDWgJ/8aSTNOhYBzh2wA3PnWQXYiqFRHkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDMr4++BpJAskl3YHWn3w1d3P7iZuJBTX0LiUw21bYw=;
 b=URyV9IKW4op0ua4G4w9Mp3078sUXDcmfcpqCm/FM54tVzPj/n93hrFh3Jj8l4ivP3nNDrP09TaiXju9444e3VimHKOx2pgn5cLvuNm8eGYO5X9+drHE4qT73ldkOJLGpz7btB3y+xO8up6KUZXA/P5gSDKN4378tfFkNZVSWvDOWzvJLGszbkh3PhhO/nQSvtRAMmo+Tn7MEPOJ0+5gW00fAzMFzNnpESjGr2+h2nY/nsUmQ1YsLcBZloYBoUqeIvPXLyrGZmMZ8+knlVWerlbK48HRzTa/JVs3jRTlWmV4U2/kWUmLB2eJyM/0t9+hJIsI8MXWxy7zC/2Ss52vqDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDMr4++BpJAskl3YHWn3w1d3P7iZuJBTX0LiUw21bYw=;
 b=k+ipOPNJy8MunjTx5QePsnHSNkinzwflM049ztcTZBWtq550bDo89is3f6Ul7uD2b+1zrgHcQpaYbzy+sHVZtTO9h9f2gddM8neDNvN9j3K5RBWt7zjUc8kqiS3t7DrD6hDIA0GMRVBLNxrXQCzjFwuIRottkoWiAqzUS56XakQ=
Received: from MW4PR04CA0192.namprd04.prod.outlook.com (2603:10b6:303:86::17)
 by SJ2PR12MB9087.namprd12.prod.outlook.com (2603:10b6:a03:562::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 21:03:45 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:86:cafe::2d) by MW4PR04CA0192.outlook.office365.com
 (2603:10b6:303:86::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18 via Frontend
 Transport; Fri, 25 Oct 2024 21:03:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.0 via Frontend Transport; Fri, 25 Oct 2024 21:03:44 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Oct
 2024 16:03:43 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v2 03/14] cxl/pci: Introduce helper functions pcie_is_cxl() and pcie_is_cxl_port()
Date: Fri, 25 Oct 2024 16:02:54 -0500
Message-ID: <20241025210305.27499-4-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025210305.27499-1-terry.bowman@amd.com>
References: <20241025210305.27499-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|SJ2PR12MB9087:EE_
X-MS-Office365-Filtering-Correlation-Id: 57500060-5194-4f1d-92be-08dcf538835e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7eFhs5wpHCv0V1Iqr9r95T9QtIaKCj+wB1W7m0lM5KGAAklFGRFBGNUvbEPS?=
 =?us-ascii?Q?SkWrWyVJmDrX8+4BvKwAmQwMxejYmwegtzKiq8YL6Trd0PlXpteIa0t4N8J0?=
 =?us-ascii?Q?Rcr+fMJVK0pZ2Fues6TCS3a2R7L7fx6sZ5KfPQq3PjQ5MZmB2LsVmp8Dp0K+?=
 =?us-ascii?Q?YjHuzloJnN5umvV5KsbCLBwGjTTMdrS3an5Lqjn/ITUVr896QY6RRzVmH6YS?=
 =?us-ascii?Q?Lqub86I564fttmIenL6Um1WLU6dyw6PRuXbIo5rv4cIDk8eChtX5e0DAixd7?=
 =?us-ascii?Q?j3SLK+BZWQiyIwLfxxcRPPMK5QD0uSW4dVsaTuZ4IGZXWJLtBIxnYM0cN9PJ?=
 =?us-ascii?Q?1dr0/c5cTiLrXAeF/dAO1S3igejjBYZ+lXqx0ctiTPWCEfD0vi2bnMTsUN32?=
 =?us-ascii?Q?hG0HvQn63fZHSuNlLDF6M4kuaazwgfeIShvjPqLDb8P0B0tHsn1u21P6lZ3C?=
 =?us-ascii?Q?NDy7Gj6k0aEijOsNqACfu+lJgSeBsX/8bWZaivjibBqQt9Bqgy8AKRq5h3sE?=
 =?us-ascii?Q?M89ABx8+rFIJMOHjSnp5pmlpNvEe1R7/+uZb3SLo8zQuN//tVwlrZdR7l4WC?=
 =?us-ascii?Q?qOrgsu7zyYatC/23MNo0a3Yc/bU5jVWp4wSIqzoTdLD5+wi3f591Xvu9QcX8?=
 =?us-ascii?Q?DKHcjazoJcLLgHNpxsPAOhlyQekrhNhL/jMubI9rswvh+qX4FYHhAhsJUfJw?=
 =?us-ascii?Q?j6kOr6lvsaEGbUmQ0Fykl3TrqOLA/0Vt9o+ugdhZwLNUqAeQqzkzpkvX/hnG?=
 =?us-ascii?Q?a+pyStibRit+cAP6ZozW5l+vaqEUB2ftSACDCYcl9Bd2xhOgWh/JaEdczjwY?=
 =?us-ascii?Q?gZSyEhfJq+4PLphw/JNAXOKf5G8mbRZ3AJSY/AGDuAv5R5xTxZw6V4otUFBh?=
 =?us-ascii?Q?VEU5jQ+XVqVA9JVQfQ8pz7nouYGpx32BONGqHXLs0glAiG+mL7b/K2S72YQP?=
 =?us-ascii?Q?OWApOQeS+kbZJEoit4mOpEaDGI/w8eKCivBxwIjcDK/JMloItc6pXhR6ajg1?=
 =?us-ascii?Q?anf8I8c95G7pimfYvBNxfFf1lXhYOE3ZwAsIfyBEjOgbkjEGH1zh5eyKJzrn?=
 =?us-ascii?Q?4YtbLgfqYP9n6OgCtJEbmxDJfH5T9+wwoMrnzjVjC9D6V+PsDpCUkTX7Ggm8?=
 =?us-ascii?Q?OfxFcOpCP1HvLAt55bcvkqA6W34E/2zXGkXFkbvLtnXPANu5ON5VvTyDdZM7?=
 =?us-ascii?Q?tkUMhCoL616dihOEFI0Zn1S8ZAEApyrfN+8D8Samko9FQOkpLB0InQrDvioZ?=
 =?us-ascii?Q?9QuPye5la5zKxxFhON7ERuFkeE3UxWzMvBtPE/2ecJgav0JMw1J/LRN1/jzm?=
 =?us-ascii?Q?+HJUoWpoQFxS9jaDRkicsGicj5ESadxcSbUjlWicQulreaH7nXaR/t304U7/?=
 =?us-ascii?Q?NoiFKzBiWxmsgvStFtS3/9FpISXX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 21:03:44.8879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57500060-5194-4f1d-92be-08dcf538835e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9087

CXL and AER drivers need the ability to identify CXL devices and CXL port
devices.

First, add set_pcie_cxl() with logic checking for CXL Flexbus DVSEC
presence. The CXL Flexbus DVSEC presence is used because it is required
for all the CXL PCIe devices.[1]

Add boolean 'struct pci_dev::is_cxl' with the purpose to cache the CXL
Flexbus presence.

Add pcie_is_cxl() as a macro to return 'struct pci_dev::is_cxl',

Add pcie_is_cxl_port() to check if a device is a CXL root port, CXL
upstream switch port, or CXL downstream switch port. Also, verify the
CXL extensions DVSEC for port is present.[1]

[1] CXL 3.1 Spec, 8.1.1 PCIe Designated Vendor-Specific Extended
    Capability (DVSEC) ID Assignment, Table 8-2

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/pci/pci.c             | 14 ++++++++++++++
 drivers/pci/probe.c           | 10 ++++++++++
 include/linux/pci.h           |  4 ++++
 include/uapi/linux/pci_regs.h |  3 ++-
 4 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7d85c04fbba2..c1b243aec61c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5034,6 +5034,20 @@ static u16 cxl_port_dvsec(struct pci_dev *dev)
 					 PCI_DVSEC_CXL_PORT);
 }
 
+bool pcie_is_cxl_port(struct pci_dev *dev)
+{
+	if (!pcie_is_cxl(dev))
+		return false;
+
+	if ((pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
+	    (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM) &&
+	    (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM))
+		return false;
+
+	return cxl_port_dvsec(dev);
+}
+EXPORT_SYMBOL_GPL(pcie_is_cxl_port);
+
 static bool cxl_sbr_masked(struct pci_dev *dev)
 {
 	u16 dvsec, reg;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4f68414c3086..9324eb345f11 100644
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
index 106ac83e3a7b..d3b1af9fb273 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -443,6 +443,7 @@ struct pci_dev {
 	unsigned int	is_hotplug_bridge:1;
 	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
 	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
+	unsigned int	is_cxl:1;               /* CXL alternate protocol */
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


