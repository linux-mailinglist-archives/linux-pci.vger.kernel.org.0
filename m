Return-Path: <linux-pci+bounces-20994-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2B5A2D228
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 01:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90E971631C7
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 00:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1219229A2;
	Sat,  8 Feb 2025 00:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b2Bydk1A"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8E3DDAB;
	Sat,  8 Feb 2025 00:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738974630; cv=fail; b=j1jpwaeqwXJrnvHIOZjST5ej5qUpBOt+Cy19D+qXfc0ods3nswAJQHtT40bNQJTimZZXbrZ6sgXW5D13hiEWvVYhKHUlCLsPPAOkVDPsHYYJ5VtYE/ivc3xh0Xv3vDx3pFlCPcXAexxAyAmYz118+8CfAgMJDK4on5PLN3G0LUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738974630; c=relaxed/simple;
	bh=gDzQyVZD9S0WeSv2ByDFryhWteexIGm01jhKt5nh+QU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f/NW29oDdmmnWo2h68Vhsn3qDNeJg7savj+kuXz/Ni0XSJlnd9d8VgAcr8JAqQjSbndmScEdjXf/3dFa9jBZIyHuNM/dXT03CM3sTGx+S4VAM9fH+umUYj/BaX5fimG47FffJIA1QwHzEyJQ4/IIGQ5QmKKBrE0/XP5KwvmFwRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b2Bydk1A; arc=fail smtp.client-ip=40.107.212.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O14RMQ+Y1mrqsqVngOcw10vAyHEtGRCuBmOnvFrir8O+CHbb3gVp9ISeAQKK2kzkqwjk3FmpwuWd29SXB1su76qzPlWoos7+lK4U2ppyatfWs1Just+KN3ZcWRMalCl+poH0ecDZYniM4LAbZJtzwZw4T9v9NElL/a8y5WkxUvXw2LKbHIN6Oaci7iz1AiuKu/CWoRZ3P1yTt2tcc5cyexRWZp6Yfyw5HPDHUNSXeMBQD2efpvWsJFGDc+8+yUWsrkEb13RRhK6bBXIcxh+znMP7PWc3y7Gke13PP9wcy2dQDV4zt2FWJLAahsTpeHCr1DNELRndmRUpiFVfsN4i2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CiQ0rzXkTRvbk1XXyXh8I31TQPoSDgA0LUO+KThfmfc=;
 b=Sy02TqKOqe8+wvlP0fPD5nAaK84elmvFxZnqBuI4qMxsFnXxHryv/TXf3fToMJahySOOpYSc8qv4Kegbo6cao/0diEMRPlT0Z6bMOyFtzIx+jDM4aaxYJKlH8NyuHGJ/HlJNKk4DXd0f+U8Wg30ZpOx2mBXaMwkOFXcIxx/A9ioXrYczV+Rq1hNRtablE1XlsjMD73ArfxQJIEzd9tSxV+hxFyK7BtYxWEqh3qLmv6Lv2zOqlnYCSwKDxSFs8ulNZyW1IQ0yl04FTeoDojP63VFhooJoQq3f9SnGzqplE79qiu+ioDatYvQXdBXe+ONgpT7/HTgXRRs7f0cFlC0YVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiQ0rzXkTRvbk1XXyXh8I31TQPoSDgA0LUO+KThfmfc=;
 b=b2Bydk1Arhl7VGNHaUXFX1fXCPkYTLJ4xCCv6B2CUY+HcK2hVLZdSZiNc8CEGBwJUzsEH834QvSHr33U0iybacE4emHmkYKJ3a1Kq5u5QNBiJLkkEU2h+qwZU/3AS2MHGfZh3LikmF5KU3fZejSRATljUqAmJa46gBKx5c20xR8=
Received: from SJ0PR03CA0287.namprd03.prod.outlook.com (2603:10b6:a03:39e::22)
 by BY5PR12MB4129.namprd12.prod.outlook.com (2603:10b6:a03:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Sat, 8 Feb
 2025 00:30:21 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::28) by SJ0PR03CA0287.outlook.office365.com
 (2603:10b6:a03:39e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Sat,
 8 Feb 2025 00:30:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Sat, 8 Feb 2025 00:30:21 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 18:30:20 -0600
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
Subject: [PATCH v6 03/17] CXL/PCI: Introduce PCIe helper functions pcie_is_cxl() and pcie_is_cxl_port()
Date: Fri, 7 Feb 2025 18:29:27 -0600
Message-ID: <20250208002941.4135321-4-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250208002941.4135321-1-terry.bowman@amd.com>
References: <20250208002941.4135321-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|BY5PR12MB4129:EE_
X-MS-Office365-Filtering-Correlation-Id: 52ecf16d-729a-4235-754f-08dd47d7c5bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YXzs9LdD6Tel8IDZBhg6oZ3d2s6Dxd8osgvykx5YgtXAoxOta8+eiA3HV7y6?=
 =?us-ascii?Q?dHyL8zw8/oU16bSBKN3ZRCinDf+U+F5RWdx6cnK8z3hRDZrXN6jKbAJNhx9B?=
 =?us-ascii?Q?/VfdUmwpH+z1B5w9airczMbmEVzUA9zePOSid0/BTTEl6ursgDnzK+1r6GsX?=
 =?us-ascii?Q?ROr/rpwWdgzC/tkuECQ3L8n9tC8O/nqhClLyCynxhNfGOea2cc2suPCPKDZE?=
 =?us-ascii?Q?AuZstmyac+/QWqon7stYaA5VldxQfTLt3ZJZVpwxGdhDP79ijRWzoyL6hOh2?=
 =?us-ascii?Q?lRawgPnNzAZAb7qarKylaoIL4EYSYR6PMm884UH2G5keIp4NS8Gjzxp/mMuJ?=
 =?us-ascii?Q?s7oV9J2ESbIPMio1meahKuteBSh6Sd5R52zzgQzZxtjDwDP1K/OJozk4CN0C?=
 =?us-ascii?Q?CYUgfPxaH8AcDl5SQ/tIVUpjNZJqdRQFtSqcmnNS0PaRpCjTkhMvEzRX0xIV?=
 =?us-ascii?Q?AREH8+YMfhIqnL5dH6fQUgs+w2YJ8WdEmzgwtcTXb5rWVDYeVkLHcVySq3Fr?=
 =?us-ascii?Q?g3Vhn8BZk0PKPr6zY8s8qUcg2XeXLGgu/f2Iw3G7ISwnd+Ik+9Gge5bCn6o5?=
 =?us-ascii?Q?JZrR+nE7KQfmxsJqdJBV35fqZerjUQs7fn793vr3pm5q/Cf9wVaz+APY3Y4h?=
 =?us-ascii?Q?XqAv23Ip8tSisZJyI1dcWMNYCFWoD//Qdhj+oTsBCC3C6DS+50Am6EyhpHwO?=
 =?us-ascii?Q?ypfROze0X3LuiwzGjruukAr+X8pX7ZVl9yowq0vMOW8WocsXqbkWf/NlJgjP?=
 =?us-ascii?Q?g0hSC3UbA1ps7POKWGMEYaJ5jRb/0NaOUc1JgkHOedn7zY94872M6D4IE1kk?=
 =?us-ascii?Q?l5yOJmK3NxlaZ+JZtQbIdTA8eRKIbu5zS8EFTO7lnhDTemTXPhDg1n+9NyUm?=
 =?us-ascii?Q?srCTPHND0ioYgeElsfeV3LI0KqrBVCQ1WnTk6adJgnb6O+GAJWrblL7onTYJ?=
 =?us-ascii?Q?MsuOH8Ee8l7x0P9oKzoTfjfxtX4jbri7S/Jwjkr//R+05QCSnO4Z4e1NURnt?=
 =?us-ascii?Q?RVvtRtUTyI8I1Nl+lvTYVY72u7/Fe6r52jx+xGmoTdnsqWwi/D72tOZ04qqa?=
 =?us-ascii?Q?bqanM2JHrYf2NLCXv2ZfFVkmwHRBYMQGdp0IMfs5sEMmHFKuM6bJN/9skNtV?=
 =?us-ascii?Q?KClt69Vp38agggIB4eSiubOGAVscl9/ikkbVqy7MPB37R6WVRTlXrhNM3ZNV?=
 =?us-ascii?Q?ao1DHyh8DBc6/9+q1lDM0vi+7XsfDFNV4yuWQ3JCLQxblVUxls9ohJONmtjU?=
 =?us-ascii?Q?7eO7fucWZnhIjeJcEL08KeJ0kyYVc0LAUUHzm9/Z/pMN3YSGPB2FK+1Zx8wf?=
 =?us-ascii?Q?dJ0PxrCxOKypp1S8/mIMKTZERqohm0QVyGJSTp7Y8JkS3LY9vdBXCCJpRP9W?=
 =?us-ascii?Q?o0vGeY+tOVlhNbIkowxp4FM1rLQhipQR4JnJR9Wva4LqSmiIKWsMWAgCm75Z?=
 =?us-ascii?Q?tAasGQ/5QtzW2tykKfeqKOUYlDPUv3A1I6bVW7QPZnVjJ/wjFT/2xXmsI8ps?=
 =?us-ascii?Q?hRzvsImBeUwNy8k=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 00:30:21.5919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ecf16d-729a-4235-754f-08dd47d7c5bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4129

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
 include/linux/pci.h           |  5 +++++
 include/uapi/linux/pci_regs.h |  3 ++-
 4 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 869d204a70a3..a2d8b41dd043 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5032,6 +5032,19 @@ static u16 cxl_port_dvsec(struct pci_dev *dev)
 					 PCI_DVSEC_CXL_PORT);
 }
 
+inline bool pcie_is_cxl(struct pci_dev *pci_dev)
+{
+	return pci_dev->is_cxl;
+}
+
+bool pcie_is_cxl_port(struct pci_dev *dev)
+{
+	if (!pcie_is_cxl(dev))
+		return false;
+
+	return (cxl_port_dvsec(dev) > 0);
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
index 1d62e785ae1f..82a0401c58d3 100644
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
@@ -741,6 +742,10 @@ static inline bool pci_is_vga(struct pci_dev *pdev)
 	return false;
 }
 
+bool pcie_is_cxl(struct pci_dev *pci_dev);
+
+bool pcie_is_cxl_port(struct pci_dev *dev);
+
 #define for_each_pci_bridge(dev, bus)				\
 	list_for_each_entry(dev, &bus->devices, bus_list)	\
 		if (!pci_is_bridge(dev)) {} else
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 3445c4970e4d..dbc0f23d8c82 100644
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


