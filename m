Return-Path: <linux-pci+bounces-16701-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A919C7DEB
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 22:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C771B27A72
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 21:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D14818BC2F;
	Wed, 13 Nov 2024 21:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N5R4YSmX"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC7E1632FD;
	Wed, 13 Nov 2024 21:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731534917; cv=fail; b=txdMc7CxYZBJcK5UDXfPnUMdzVELnVHGFmRg9i6HYljVWSOgBbV2GMlOV0zzTZtJebPdNBRPResLvin+c59BW40go/pry0OJDMS0T8LvWBa/QRgWfLVBPPLgieKvl7nx0qbVQvcGWoS75Jwh8In3FcAVNLFYA04xvImoB96GK+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731534917; c=relaxed/simple;
	bh=xMVNCxun8SDMQHaOC25VkMD7W2uLrsswWmV/REF8Uog=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jnFlhvtx1ZXqVy8AKDlyWQNV5r3zyTewoHdObeQCIyJ3PEMXkU8GQ6aZRRg/0rMVm5FM17i2TZETMFoYx/8q6nr3MlxtjrRG1XdIcRbNNT33Zr5OP3qmRlf/V+9s9KBrSlF+itRaBddgDyB6kEb/QJQCht751t/jwIeGC+XHK3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N5R4YSmX; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/qmJ45xZAChcVW5Tq/mpopdeiX99b1uX6lxQGn8Fsj058cL8PULiPk5Md6tAqU10qrRZ40U05mYAa/RGSGG5R203vv23B/VKCXCQSLmj16w2130nZyWKbFfAk49+4Uly869ZmWiaWHaEUiGt7W1ydTzJ2BXQ7+BAMJ0DNQrroBscGfuKI7E498Z9qBXiyCBasUGyl+z1tivDgUgX17aUPGJR9jeJ1irkeLi5+w77pCyghQt8YRti+RNV5OHGcaXvQ/CI1QLE+Fs7NJLp/nkDTUMLhcUF16nAcEtipwwntDCTOr0drLiygMFuFkwRqG+v0oJ7NsrjwmgMdJ+X5ikUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3Sr9astsoL7iHL5RZUWz9HG/vENwVW0PHuk6DOuJAE=;
 b=JBXcSAsY2mZzq1joEEP5+pnIjSDumLfdFkW3oZET3KiO3YrrJ8PQ8QXACyGLDY1avzJkwLJgsjxdz5/Qo5h2QpDuPms6gIqEkKY6wsvz7n/Wy6n/o8NxHpjOvmg18WJzmyt5PRGZyHrmQ2XS9wypq+hPuV4gQ8O4KMAkbaqbeAttpVQT93j7qHDfz1SEopKjZpOwg3Vb7d6d2nlx+YPof+4RZulfHr0jQzn0OW+58wsQlstZKV/ZBkInu8kfoNMrKUpNilpyYOQO/EbvLNH2O06J8b3dcTmTJ87Da8hAPzZQwgaJuy98V0Zb3AFuQ2CGo1nk/iZo/yTnLnpkj1tD9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3Sr9astsoL7iHL5RZUWz9HG/vENwVW0PHuk6DOuJAE=;
 b=N5R4YSmXRZMbs2ipfw3fSjl8ZFNc7ysjFkC/786q6lLkYi9ufnNmZwzxfx+IxqGtAuegrnF2SNKlcCoKHS8UyEEcrThwcXMQrwfZjSet9UwUqyXp5Mixb2Jsv5Ext/mUw/cWols+TRmirfzgi0DIyq2yLWtjsbSw4fuYjwEWzzU=
Received: from DS7PR07CA0015.namprd07.prod.outlook.com (2603:10b6:5:3af::26)
 by DS7PR12MB9527.namprd12.prod.outlook.com (2603:10b6:8:251::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 21:55:11 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:3af:cafe::47) by DS7PR07CA0015.outlook.office365.com
 (2603:10b6:5:3af::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Wed, 13 Nov 2024 21:55:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 21:55:11 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 15:55:08 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <ming4.li@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>
Subject: [PATCH v3 03/15] cxl/pci: Introduce PCIe helper functions pcie_is_cxl() and pcie_is_cxl_port()
Date: Wed, 13 Nov 2024 15:54:17 -0600
Message-ID: <20241113215429.3177981-4-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|DS7PR12MB9527:EE_
X-MS-Office365-Filtering-Correlation-Id: f36138de-c8d0-4ec4-29f9-08dd042dd8c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dyFoHTgmSF80dKjZm0yA1rpiO8hS+ofa7SULPcxRRZaqSHU5NjSOhrx8bIMS?=
 =?us-ascii?Q?jsDpGEfVK1GuWgBP5gTG0kZPaVjDp8hd56KxlkI6XWfJxUOnOoiyONave0qe?=
 =?us-ascii?Q?1WWgUA4Ozh82MFY7jsT8/0DLzcxwfc9hJz8y01ceGREDtEX91b8VMHLdANhT?=
 =?us-ascii?Q?0aunx6DzVZXPsxesjtEhyWAI65rL0xg2H43Mlgft1rn8piK6oLNDcP/CbWtr?=
 =?us-ascii?Q?CnG+GqF/kGvKGPqrc9q06VjKv0nvJIdhhF+JFNNJ8MSIA34YMmo6sZMYnOPc?=
 =?us-ascii?Q?KFw03DadWMrvtyZaKsCFdsAlIzd/HeR2gg+Nbr0tf5AtuSBJ53aYusBqkNBq?=
 =?us-ascii?Q?AFbgMqa0PKcrL5MqetnK8jmmWmTKZiCfOL/8IvOmWRR3YqHc4WMPYYYn0hbM?=
 =?us-ascii?Q?LhdBYkj+/+BuUwflOLJN+TZwZDnNPtWsAi/0uawJDzzqnU4vKzaWjZVJ6wuI?=
 =?us-ascii?Q?BxlpKKBibStZPi1igbAmBvHrKjQVMf3xuAiYO2bb1GuQb5B7fuGNGiJpGsXD?=
 =?us-ascii?Q?MB1uFPIhDcYROM0hhBPPuFf5d1qgEb7obrlbhGkI/US3Rn0iPF7B2NafPPRp?=
 =?us-ascii?Q?OUlj5oalfGX56Bxz7uZXkyL0zEovQFq7eJMwCdECiGpDEuLYK/3SC7v/s3xC?=
 =?us-ascii?Q?xbErpQXYTNcEINLYXII/8MlhHk5fdiV6y9vweKZ0/GIirU9pxhd2x0vym713?=
 =?us-ascii?Q?JUj3HLJLIvjs2hzjSzk2PUtMv6haBvdN62z9NEb+3jIXQHc0w7zLZCH2YL+E?=
 =?us-ascii?Q?hV3FBpg1WOAJqsTDBkN4QEK5adAewzM+Kd3NvRjk25Ab/9hcnv/EJXo0ZJyI?=
 =?us-ascii?Q?a6c069VN6B7OS+IM+ofyUPvUg5i1r9OdksP+6I7JacHAsMh97HzhYIu8NUO8?=
 =?us-ascii?Q?9dNrBw3bqm8YQpeMPDqog97CPlXeXDn4uQ2VGSLVqQ2AQC//VSu7UX0+Jpz+?=
 =?us-ascii?Q?Sf55WVO9LsTJK/yzxRmOJFqA57KZL6y4fwWRMTsrE282u5kB6fsegMnHgcLM?=
 =?us-ascii?Q?ijejwcr7BoypqmUQlK4wqoKpSOVoC5QmCxtDpGURxU9w/XD5S9sHinH26bTS?=
 =?us-ascii?Q?4zzcOr2ZT7nnYXsS2mBRj4x1ZAjzPz34SvwXYejw11mi5CUODqJb5UbcHNAm?=
 =?us-ascii?Q?tKzkqqTZEgtt/TK0KMwDTDmSrM6ukTWzj2H7cIhmOXId4y20tdvqupQTVhX4?=
 =?us-ascii?Q?JWTpumAjg207IPyKPldVPsV1FA1eX+KlNmpBeTKnATwN9EFoTy0Ln5oCioPZ?=
 =?us-ascii?Q?zDaDSSw9A3OwmWlCc5+sYy/nVj5Zn18ls6HgHueQnW1hNF8akhA067R8+Ykg?=
 =?us-ascii?Q?o2Ze2r7LVtVMGaj7lAEBPEyLaiQCWvXzDYyL/tObg6RE6uaDuM4IEJ0mHVNB?=
 =?us-ascii?Q?P2eAfxq3gwUDdISGGSVxyY0GHK3Rmr0tU2DQLatB1yTrX1c2yJYc7TCxKeUE?=
 =?us-ascii?Q?WVOV+bnzXv8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 21:55:11.0792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f36138de-c8d0-4ec4-29f9-08dd042dd8c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9527

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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
---
 drivers/pci/pci.c             | 14 ++++++++++++++
 drivers/pci/probe.c           | 10 ++++++++++
 include/linux/pci.h           |  4 ++++
 include/uapi/linux/pci_regs.h |  3 ++-
 4 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 225a6cd2e9ca..6db6c171df54 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5038,6 +5038,20 @@ static u16 cxl_port_dvsec(struct pci_dev *dev)
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


