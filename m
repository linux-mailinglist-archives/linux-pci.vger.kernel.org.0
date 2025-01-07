Return-Path: <linux-pci+bounces-19428-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDA8A042CB
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 15:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A17027A1325
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 14:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FD31F2371;
	Tue,  7 Jan 2025 14:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f+UxhxK+"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832451F37C7;
	Tue,  7 Jan 2025 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736260778; cv=fail; b=mYp/L2bNF2/di71zdAo8VY5XJMq2uwb1KnoM7ql5ZDyT/V5QjCEIT+rv86ModCjVQyGPyERm9ZNE0sb2adMTuD7ULHD6fIzFCvRBkOF7lXfqhgXOQqHhittE9Nb4ULpan/wChjJ3LFs4/X02dyaD89w07xG5DTBfZ4rjBn/E7dA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736260778; c=relaxed/simple;
	bh=Jsq/N83ZW18RNDmCfrRlOHvc2CEhmPd882ur8nSpgKM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RvbPuhwnLO+FuJR3NIo8CL2U/cC0mUDho9ioP1k8a/Fg1fW2w0KnF+hSXSkD7XqltmMOjHtSjX5sDH8LAGAd7eQ2VRGS3M8/vRqnTQjjoiNy8Xk/JV9c5bv1fqkK5dPyUT97cXpXvfnZt79Hs8eMWDx2wi2xaH449k7gILORZDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f+UxhxK+; arc=fail smtp.client-ip=40.107.236.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gx4yYI2BaqAPC/ePP5OBLQWUSUofkCP6oopq86KoViPY7WkN9KfYY9NA93cQdcR/mkl9X0uwB58IE0OuG3l0D9H3yjjrMueZoHDgT5kyTKLm6Yv48H1ldFkYWsE+B6nd2sYN2EAK3dQi++uB7EUtwy1ZkiZwAkRTzcmn5hAC8XHYBew9tPXtxaLTP8Znfsp/+ilopvnCu79iq77gC0b2MdUb29/d6N/WigRX8HVVCOVli/2NZuAAkVk3bsxmzuxZaj016WHBIQmZNvxYFK8YoiQWuchlxMn3odqXEotHQKrnfqzelBir/kDosvkhAzq+2BrePomLpc9EtfQsSkV7wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbzUeDVueJF/xfu9PNRLGA3QKURbqZMptaooX6/h4D0=;
 b=yTf98q/6Lw/3YxTALIqNNdMbxtNlyUYIS9uR/P+3V2L4t48wGkyt/0XlDGMsAB35NnBZ0f7F9jppNdNffQ7eikKH6FLfZsB+iED4EUnErAIBadQPDkgePZ4+sHZffBnMO0N/RBx8sZhOL1CFzo2dSHGLxfl661YJpJjwZNApViShrgPguvNEdTFU+2E20kGA1ODc2U8j7HFtlLfIjVtLLS+fl7zz+M5qG+xwkE5CgAbPBxFdBK48lSD33kgzQwMEXc7alTCPGANatCS4VjHlGItvZ90Rk0oGVvfykqShSJMlL2ThK7D3BNoVxhop56Gu5fCDBBgn51Bw5Z/kQfCO6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbzUeDVueJF/xfu9PNRLGA3QKURbqZMptaooX6/h4D0=;
 b=f+UxhxK+FpkIr0zBqwthdXrco+5JC14hdmHdggbw/5Ne+njnHtRYWSzHJbVbzsyGUs3DnCi1+RjwHvY+nIpQKbmIxYW5rU3G2SrGww54Oz4DIpxpXCVQDmC+cmadd6SelsB1iTn9v3lXAANAPjMN0A0ghoanJ8o6uHkxa2dbowA=
Received: from MN2PR18CA0003.namprd18.prod.outlook.com (2603:10b6:208:23c::8)
 by PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 14:39:32 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:208:23c:cafe::d3) by MN2PR18CA0003.outlook.office365.com
 (2603:10b6:208:23c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 14:39:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.0 via Frontend Transport; Tue, 7 Jan 2025 14:39:31 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:39:30 -0600
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
Subject: [PATCH v5 03/16] CXL/PCI: Introduce PCIe helper functions pcie_is_cxl() and pcie_is_cxl_port()
Date: Tue, 7 Jan 2025 08:38:39 -0600
Message-ID: <20250107143852.3692571-4-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|PH7PR12MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d31f2f6-1f3f-419e-c63e-08dd2f291931
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UKwbjBkwxRKmFL8WlKejMZmfTGOqmT01b8iiGnnjpFfGP9EwU5JOyGZKHgs/?=
 =?us-ascii?Q?IODA7bTXUciKRTdM/J6moEZTbTR0/XwThvDDCqb+7vkubA9Si/7NTdHE42eL?=
 =?us-ascii?Q?BvPdeBuCK8YyAbhBEbcAoUWGRYASdgWOF1inhorLX6i3AcsmrStfzxlcsQYl?=
 =?us-ascii?Q?ZzCQN3yP6lqqN1KsDw7jzesooI/andq/pqZWflJp2vTY+09siaXVnTeUE+Zg?=
 =?us-ascii?Q?ZWlyf9hOxh3kFzFLwbvUqqI5wtIS2p1f5LUMM0QLE0o28dTiqlFFmYT4jTeA?=
 =?us-ascii?Q?Ru0MMhIFe85uhNDRZrmN001Wq4o3aeWdvY5Q2mb/TW5qATW4jblC66hvKdUR?=
 =?us-ascii?Q?mLTZX4y8iRT/pOa/JXi1zZIHOkI6dOV5HL1z2z2WsDgJ1YKacTwK0jQaUBNd?=
 =?us-ascii?Q?ate80uY9Qou4x2rra7owywQkVErCcy+EElwpiWlnZtFzPqvUc7Dk2YoZokvd?=
 =?us-ascii?Q?nEz7iUyW0ASL/qmuSHwN+f/2p09v/GECQU42QGTisCPO/ibozQAPzA9Ix64/?=
 =?us-ascii?Q?pAUQUTZuy+kiFcPYcZhYL9ynbpzecDLHzQRbxSU9yFDFDp9re2syjk3YJyOu?=
 =?us-ascii?Q?6EZZZEvp7gttjLaK5oYRCvo4y2Syy4AmUuy49YifkV8HYJQgFZeu+ma7EpLi?=
 =?us-ascii?Q?btb6mUb4nPizytqG/AL+EUuHiKvmijjqsWrmrokxLzC3O12A8Tjw0HfN/84I?=
 =?us-ascii?Q?dYeezunbz/O0orZdrYhsKI9We9tRk+VGfmImesnmg+JNf3FdQn/XkjzD9Lw1?=
 =?us-ascii?Q?DJHkvj5JRXC9i0ADgdxzn+peGPMKH87C7AC123njvPkhYIf3kciZKBQSx0BG?=
 =?us-ascii?Q?qyPvg8f+Fzu5zYFa3oh6QGM7sXqOof9kCBg1bF3y/38Gvzap0+Yfr+JHzlce?=
 =?us-ascii?Q?vF2Ea+lsSuew3F6hZyjPfOmTj4vYoo2+nfo+qxVhWNhY0k8hTonk2Avzced5?=
 =?us-ascii?Q?E+jg4pn/evt2913ACC/RLzxcC2qq+YI7jQ2UtYYfjqZmGGQBKJieblj0QLdf?=
 =?us-ascii?Q?Jd+J6TQIygHzXdFy/MyF5856TfRYrBwTLL9NuFjQD4ic5IWe5VKZAilVtDqm?=
 =?us-ascii?Q?DgtFv5ZdVVSujGZ/v0ORfNNsbQU1r2/k2yQt2TTg3K92uFWfgw/uVX8T5fjN?=
 =?us-ascii?Q?LtUfndEGPTZG2nA+Mi/87OLRoYzcdhEuYVQoj01YSU9hSX2INTmB9+y/mm6v?=
 =?us-ascii?Q?wjrsj8Xx9wdDecEW1p516p/KqSAJDdaxLp3MipgyCZTJXVEDRH9WU50Qup01?=
 =?us-ascii?Q?JQmGfAN40OmxRibdoiDOqa/qwcH9xUoCv+vRiXWU/1lHs0Z1LpsPo6OAMuc2?=
 =?us-ascii?Q?O64AH0vV6smskmY7m0Kmyav6mO+WNLyeow/zNeehoE4G7a7V5WYVbDcq78sd?=
 =?us-ascii?Q?WfrS+3zLDNWGkbLNQviqMOVu6715saIfrhyUu02o9GoDMFoPZlteQFqL736x?=
 =?us-ascii?Q?MhILsw+q7oXxSvyo3DivGe6K2MXTexFU8QmtY6EmpaIeHE/+aHLxARDlBi+a?=
 =?us-ascii?Q?LIDjNz/Q93f8Zg4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:39:31.8710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d31f2f6-1f3f-419e-c63e-08dd2f291931
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7914

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
CXL Extensions DVSEC for Ports is present.[1]

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
index 661f98c6c63a..9319c62e3488 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5036,10 +5036,23 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
 
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
index 2e81ab0f5a25..ee40a1e2ec75 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1633,6 +1633,14 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
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
@@ -1963,6 +1971,8 @@ int pci_setup_device(struct pci_dev *dev)
 	/* Need to have dev->cfg_size ready */
 	set_pcie_thunderbolt(dev);
 
+	set_pcie_cxl(dev);
+
 	set_pcie_untrusted(dev);
 
 	if (pci_is_pcie(dev))
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e2e36f11205c..08350302b3e9 100644
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
@@ -739,6 +740,9 @@ static inline bool pci_is_vga(struct pci_dev *pdev)
 	return false;
 }
 
+#define pcie_is_cxl(dev) (dev->is_cxl)
+bool pcie_is_cxl_port(struct pci_dev *dev);
+
 #define for_each_pci_bridge(dev, bus)				\
 	list_for_each_entry(dev, &bus->devices, bus_list)	\
 		if (!pci_is_bridge(dev)) {} else
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 1601c7ed5fab..4251af090742 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1208,9 +1208,10 @@
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


