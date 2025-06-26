Return-Path: <linux-pci+bounces-30850-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DABCDAEA9C8
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 00:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FD121C44065
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 22:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55B426B766;
	Thu, 26 Jun 2025 22:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k4QzCvvG"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2063.outbound.protection.outlook.com [40.107.212.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC80221DB9;
	Thu, 26 Jun 2025 22:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750977806; cv=fail; b=UcMoy+zDYTI+ijLxyQZDn8lMJ4a8Z+vO0ZMAx0wtePGjJ0kv5YMS5ImJm7h9r/PqC7OZFb9g9MoY3A19ga3vaANkwaRX+88R5/13Rrh4uzjun+RAPn5xQLrQV8Weau/rlG9QLU0dSzhTf2TwdrM4g4xb81p56zFdQPMXGPXxoFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750977806; c=relaxed/simple;
	bh=cvyA0tx8QiFDc0RhNF+E+fqDbbB2aokZDGC1+9Wjv74=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q77z/B7oRRU5Umny7B6pw7yfszADNGDqjUxbyMRcUum2ly9YIU7t+FqcVPZVD60M4qSdKsNXY1ECg93N5A27P5CPUfLR38RyV+gQnWsSU/lGI+CQiTV6ao+t58ore/CDkxEjYsmCwzAbvTdRgDBWvTg6rVYfMpqtd52+mqasyxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k4QzCvvG; arc=fail smtp.client-ip=40.107.212.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U2ih/eVbqAKy3JtS0KndtH2HQG2IcZTIyEwluL4lCQGeaySpdwT0iMGlvjFGJMV7BITD9M+g19rXM1iHGKtAjaK+l08ujWhpt/EV+k9VUgQXhOWyrnWeSMmho1Ca1Q/LE3eBsmIUpz2zKr6eLzb/heBIxoK/yDyZhDtjLxkLsTu4TbbdoUpgYQvoBiYet6jXXBufG9rrbVZlN56xp7V3I00LAFzt5TBis2vkDbym6QG29zF4UC1OcyLa2dGAB0p9jvXQyitCsIcDUYFCmZDkuguJUHa2I/9qPXnmUlT1NyakJiZzyzgDKCuU64OXrM+HD8u74bt+7UBgrT6pfN6bZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9KzhkB7tTylNfn/7l+htpVuDkxHUEj5WGaCnl3J2XM=;
 b=cS/l/dplwbuNXTFqEvP1a21DV4XCCDKeKA7ASbh9Yt+NQvVUBZdvbtk4MGDtTx8RI1Wu4PKal6q5JpV4RZIL93ZEfLHfKV+zndVlYZYZmnjBPhUAOv2X/GBUqcm8EuWDIdYg66jpYMpBl94fhcJW+UhGcL3KCwOLqoce//2Sb7fr11tuPyA9A0r1thDep2JRdm+dYZJsdudH1LVAluN+hpqzIskXnlKYB8tg6OfRhJ3X0SP0p7TnB4rNoL2PiMipdEN3FFasIJrJtSitm5D7XINCg63tZn8mIw8xwp+56XxQYZeE2dR58LbCaSJPGeRcFAVFDMiDMVjgHY6g2F04zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9KzhkB7tTylNfn/7l+htpVuDkxHUEj5WGaCnl3J2XM=;
 b=k4QzCvvGbstzXv+j0aszGe9PXAmS2QX2KHsu0t6WEdMNGdmheUS3Sci0AW75ZePnbTKea8ny8iR2riUbetKqkL0v4uTxcxb1gB/rORuKQsbX9lQ8v4OBkH+jxoP4Dg7XHtX2qYl8ctmfchpi0F0VxkhmM6RV+DL9ShQOmOXMQUg=
Received: from DM6PR10CA0001.namprd10.prod.outlook.com (2603:10b6:5:60::14) by
 DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.28; Thu, 26 Jun 2025 22:43:21 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:5:60:cafe::2) by DM6PR10CA0001.outlook.office365.com
 (2603:10b6:5:60::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Thu,
 26 Jun 2025 22:43:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 22:43:21 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 17:43:20 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v10 02/17] PCI/CXL: Add pcie_is_cxl()
Date: Thu, 26 Jun 2025 17:42:37 -0500
Message-ID: <20250626224252.1415009-3-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250626224252.1415009-1-terry.bowman@amd.com>
References: <20250626224252.1415009-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|DM6PR12MB4235:EE_
X-MS-Office365-Filtering-Correlation-Id: af92ab1b-2eda-4434-8253-08ddb502da59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mJwrxY+Sh6Mxp/6pqcekXQGMTJJ+lM5yZanSGGUcBoBbWKfT3oyT7fMFsYZ2?=
 =?us-ascii?Q?xnafe1lzsyCcSLcPM3Jz0T/04jwSq5hrtMfl+Zn2vwm/t5sCtKkuJRatQ0v2?=
 =?us-ascii?Q?UTmaXwcONf9tnO6973kA2jFzoV6zkaqhLKn+AcPEDinZGIvLqSFB2YG1aqrH?=
 =?us-ascii?Q?vWvJohHx3ajTB/gPj1nE209zq8m/zxp/cuZ/30dfcgRp3T0dhtkZqrAA0yLi?=
 =?us-ascii?Q?sIciMViitfLVROIkmOx9NA7IAa6+Id3xh8aNhjjKSxtI/uhGZ/SWAUn9lntz?=
 =?us-ascii?Q?sZU1locGs7y1iV2ib+iNZxpDV8ADmwkqpWLJcsrGUJyV0ioVpj+ZrCXkgKgh?=
 =?us-ascii?Q?FFojHuRB5BmgYVDZhkYUsxP0klRlZq1lJ2nklcWA7KPkdgXa5tI9jSz2nI2I?=
 =?us-ascii?Q?DzXx56q7dhIahyskqa9SuvFTmVfzpms74NBvS7+c3t3plNFqSpEEyTd3Lre7?=
 =?us-ascii?Q?Lzt7raDbN9ChMsHyd1JgjOFWAgq52Av+3hn4ZSJpKCRRzeOqaPhFXeNcAm5Z?=
 =?us-ascii?Q?EwqRypo9ee6heHMevm7AJZwJunkiuuW4saUTuLnHoMWDPJRNdLGJvU+Ka8l5?=
 =?us-ascii?Q?0Deb4o1bg8tirhdOxp7V6bTbj35C0faBeV5GGeGo9m64ukse02w+YEk2VNJq?=
 =?us-ascii?Q?6wXbcn8EOFclw29O2y3THZAHimCU4y2lTLdD3tSHvtx/YRPExLNuEKygPvfX?=
 =?us-ascii?Q?qCuylYDUjTNI/ZyHOvAKgOyPL9vNy6wNBkugPFuqV2T8R79TuVYfOz8irQen?=
 =?us-ascii?Q?2P221fNLaSs7nxdytrI1+H4GEsbxFZc3IA+ZlMVYXd2a0ksaaG01QKSMS5aw?=
 =?us-ascii?Q?r8xjEdL1wegZDbzHzwvHr5aif14pWEYKLxZugQjnW4YO92n/wAaTa4fyF0xL?=
 =?us-ascii?Q?jhhHLuvelHPbqtthf5iPFjwA5dExWX2WOz+xAzJpMGfMgCA0RsXLS9dl8WpG?=
 =?us-ascii?Q?aD5iWf4urPHgJs1ztCzB0hPbBnjlbgeambIG9asjws+UknAVbesWJlEzjLdW?=
 =?us-ascii?Q?vlx9ZKE5vOgDsTux/HYPpPrGveWMRnipGglTU1Ls+1zwTQOfsL+WTGXZSU8h?=
 =?us-ascii?Q?uA/W3uwTQTURYNvwHG4JkuE8LtDifpB8t4u7Kcn0/xFfDITtimPvRQJ1xSEe?=
 =?us-ascii?Q?lVXR0JQax+iAfzrX0Ln70pG4+CIlA1dFAvXSRm2XZ0S4HlM2YyDP6MIqnY/V?=
 =?us-ascii?Q?/3cSn4KJgpJS1tG3plGXU+HKjzzKqrjU3qfLT1x3nRZzx45ezTnFbSSiuRdK?=
 =?us-ascii?Q?ITwLYR8IUCP5klOmt7c22uk72eW1Oz609Bm3i0LPRSo2goYDbunHVPLjz+js?=
 =?us-ascii?Q?2TO7IlKJ23xsw6cSmzYSxDI/p5dgiDnANLl4MGdx8VN8ES+GcccF+iZK/NUQ?=
 =?us-ascii?Q?vQDRCZC05wUVPkB4ygaXNVnpDSb0CmalDH+ndEqthlv6HaTT1f0tWyCbWO9j?=
 =?us-ascii?Q?K18qsDwfri5/ps3TICRAychz1rbxu73PaR1anDDD86soQxJsYmLWNjfbAvDr?=
 =?us-ascii?Q?rGXJ2XkUASDdb5K/mdLsWk2dxa5iaz6rWPJxSK98fBXCCqv0kCstHogmmw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 22:43:21.3537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af92ab1b-2eda-4434-8253-08ddb502da59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4235

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
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/probe.c           | 10 ++++++++++
 include/linux/pci.h           |  6 ++++++
 include/uapi/linux/pci_regs.h |  8 +++++++-
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4b8693ec9e4c..5d3548648d5c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1691,6 +1691,14 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
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
@@ -2021,6 +2029,8 @@ int pci_setup_device(struct pci_dev *dev)
 	/* Need to have dev->cfg_size ready */
 	set_pcie_thunderbolt(dev);
 
+	set_pcie_cxl(dev);
+
 	set_pcie_untrusted(dev);
 
 	if (pci_is_pcie(dev))
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 05e68f35f392..79878243b681 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -453,6 +453,7 @@ struct pci_dev {
 	unsigned int	is_hotplug_bridge:1;
 	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
 	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
+	unsigned int	is_cxl:1;               /* Compute Express Link (CXL) */
 	/*
 	 * Devices marked being untrusted are the ones that can potentially
 	 * execute DMA attacks and similar. They are typically connected
@@ -744,6 +745,11 @@ static inline bool pci_is_vga(struct pci_dev *pdev)
 	return false;
 }
 
+static inline bool pcie_is_cxl(struct pci_dev *pci_dev)
+{
+	return pci_dev->is_cxl;
+}
+
 #define for_each_pci_bridge(dev, bus)				\
 	list_for_each_entry(dev, &bus->devices, bus_list)	\
 		if (!pci_is_bridge(dev)) {} else
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index a3a3e942dedf..fb9d77c69d5f 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1225,9 +1225,15 @@
 /* Deprecated old name, replaced with PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE */
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE
 
-/* Compute Express Link (CXL r3.1, sec 8.1.5) */
+/* Compute Express Link (CXL r3.2, sec 8.1)
+ *
+ * Note that CXL DVSEC id 3 and 7 to be ignored when the CXL link state
+ * is "disconnected" (CXL r3.2, sec 9.12.3). Re-enumerate these
+ * registers on downstream link-up events.
+ */
 #define PCI_DVSEC_CXL_PORT				3
 #define PCI_DVSEC_CXL_PORT_CTL				0x0c
 #define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
+#define PCI_DVSEC_CXL_FLEXBUS				7
 
 #endif /* LINUX_PCI_REGS_H */
-- 
2.34.1


