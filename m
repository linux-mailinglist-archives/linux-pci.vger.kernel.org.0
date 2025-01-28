Return-Path: <linux-pci+bounces-20425-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F70A20386
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 05:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35922165751
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 04:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD69718CBEC;
	Tue, 28 Jan 2025 04:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EQnrCH56"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B56D4C8E;
	Tue, 28 Jan 2025 04:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738039402; cv=fail; b=KeLMjISvdYMcpKH4dnODPJRRnf6+LI0MPP8NyFFhDsGvsYNtQkq6owWMkgbLdajNTEgIqUJqE7am+71NCuaZKyknBmNkZJ+x3ZNrBLmmJTI2p2gzuNnkg1h4P/2f5GHkqybWk6hmuBWOwaGTbDtnCaWSRGCcgtW27vkc1QivDmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738039402; c=relaxed/simple;
	bh=G693D4N9EWQ5KQYfxfsA23J/bNfwUQEXXpQHODVOINI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mr3iRSUtopfeiVVwZLkHbWSAeL1cXrgI9BaBqPMNvoCbsy9Z0Au13OnqXYlyOgcFm1oyVHL69SMsGTKuEXaFANfE64i4lXRmQTFosAYK3nM7EcqAsjJy9r/6uI3jxLwKSrgoDd/+A00zccDRFjjHYS4mA9dl/TEc44xCdeIoTFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EQnrCH56; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kE3Hsh2mMIc0FU4oBM4IFkbPpeAzRJklqe8ck6ESvrnoVHjNvnJ2MvPjK0WpwMpLq8ysCqDo9+sBJZ5RGcjvYalpFtEu8spqJV9P/RAR5whxWbXAMiO/YNcJf/bYj68fylIQrYxmaMTfMepzNz1TiTLWHiXJzT1QOruU0OJopIpGcWBtWnvOWVmyqw4DmsdwzFc3By0EhWFL9KXz3T7KA9U261qctTgh2U6f1DW56tyge/pzJDWJGuugpp7Arv59ftxi5rHm0Tdd6H2QYqMmxTzMT0GUCpAGHVxtcuOLBNLKpDyqW7LZsVVgfvlZKgUe56v8HFIRMxkqSEhwPRpiLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlBg49z7l8fBwmSNDBtNaWV8AaaqEBudpaABjgnAJro=;
 b=N42OwSBIxbY6WczBiCo879zSOuSbuXvNG+NO09yj0wq0R2QtGyyc0/rcgg21CxinP0btezs3aSoXpt9Sh5L8USlW73VfVoFE+KAW3tYdXZ5MSzWmPjXQoh8zcbW8tpjbXtZqETDMeNGbrtg1IscduDDYPvkXtfEheV7a7B/yq7gNsB5Gsjv1trqWjm83HusVRkQOPJsZLIBYukq4ZhMHh0tMfX5SaxkhpuOHf40ADb0AyIZJml6phiWPUFre+ErczDoL34kYp5qo7nbWFDg1F6HRnQLepyMkGNWA1faAPxSCA+q1JPORTdNOyhGh0882dE2R8UoHG94NBhrQrxCTNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlBg49z7l8fBwmSNDBtNaWV8AaaqEBudpaABjgnAJro=;
 b=EQnrCH56GLWIKh3hvH/JOjXF1PEbg7JreeQdEEcrHLhP6ztlODc+xF6ih+zjMP9CJrYoJJ9pFQarCNj0hKDSca2NovwC+ALjUbAv1MaoBLXf+TKMIOogZ8ObeCK3/Hmr6fxkz1VXSGaRSNYLuGwcOkLZ/XIZBGeURl1pMCz6oD8WhR8xZ4fzCqlCteijt011J8Dt/3+1LlvH64uwZHfWQNfwxBmZwPnHSBiwwQoaf1zts0u08NgwX15jYj1Uwo39pvMpxtCbIapFi5YnzLJFVeU/VI5xaAGxMc3J5XoPGrQ0sNwV2bZbqLRfwQHeudEG4VKDy+6Kcjq7DsN69NzsXw==
Received: from CH5P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::23)
 by MW6PR12MB8899.namprd12.prod.outlook.com (2603:10b6:303:248::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Tue, 28 Jan
 2025 04:43:17 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::e2) by CH5P222CA0016.outlook.office365.com
 (2603:10b6:610:1ee::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.23 via Frontend Transport; Tue,
 28 Jan 2025 04:43:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Tue, 28 Jan 2025 04:43:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 27 Jan
 2025 20:43:02 -0800
Received: from vidyas-server.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 27 Jan 2025 20:42:57 -0800
From: Vidya Sagar <vidyas@nvidia.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <bhelgaas@google.com>,
	<quic_schintav@quicinc.com>, <johan+linaro@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <kthota@nvidia.com>,
	<mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V1] PCI: tegra194: Add support for PCIe RC & EP in Tegra234 Platforms
Date: Tue, 28 Jan 2025 10:12:44 +0530
Message-ID: <20250128044244.2766334-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|MW6PR12MB8899:EE_
X-MS-Office365-Filtering-Correlation-Id: fd0a145f-d70b-4966-bfbe-08dd3f5647ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9rypzWbIbL0hsManjsF/VA9RrPfxfUAJDCd7thRK7FQGWnmbESU1onTcOgaO?=
 =?us-ascii?Q?QSAMNSD2Ir/Pk8t8PzU6XHbeUaSB7h070ure6779fCvUGdz0gzDsRZwRApXp?=
 =?us-ascii?Q?8gjZUZHFQ46in/km3dvYYOLGvQLtg4pvGUYvv6cHTuIDcxFmYaJrpYW79qLu?=
 =?us-ascii?Q?UJ2KqgoxsAuOT9CBnfEYcYhpq9QFprXAnhjxrHTVmNBI6konpU5vylQtt/JR?=
 =?us-ascii?Q?fhfinWsb9AIKw2newq/0XSK/oAEJYt9X6T+PRiPWlo1WdBNMOaVQo7GQcGOz?=
 =?us-ascii?Q?sRNtsfdmckXTIraELGRqy0gO838gr/Hj2XXoWIqfYK45/XRUMruerC/mFbnc?=
 =?us-ascii?Q?dk3k3jeCtOMlGXzfHwzTrcUFo7bOq3hAhYAI1Q0S9Grhi+KJfw3DtK/eE+k0?=
 =?us-ascii?Q?YNGU1bgVbF2UE7aNOUjU/JrDsd0WaVXYBr6SjPVZcutkaPDshMGIrUmql9Nj?=
 =?us-ascii?Q?V0p0CV9pVfJ17n/+Atn0RMIf/oEc57YKxYC2ax41FJL4HabTYg1WBZwy3Vxn?=
 =?us-ascii?Q?xzXy2DmZgu72BtzgDV1vk0we/g4qLLvTVkt9xvaWYYvazoVME/yqlooBGyw8?=
 =?us-ascii?Q?MbTSNSV0UeMPWNHXSfysYa0Jtoubo6m+mwB6Ruo6NqqiXqKjepDxD6OOp+yx?=
 =?us-ascii?Q?1TBjuS1togFTPBzexuTF5LCuq0c+uMtzhT4FPErMZ8nkA2Vw59W2wEd+SgXI?=
 =?us-ascii?Q?evBk/bT/UUhT7iANSAnQL5+99P3Aj7Cc2K9numKZ1APpBIvk+NwJiqiq0d+e?=
 =?us-ascii?Q?KSMGlBYu+XPV+fvYcbl1xnif4fXgtNCK22slOiPCkMQ0+aqDzrZF/BtLtvup?=
 =?us-ascii?Q?wN1kALzOL3Op2s1oadx0sZA3llVNqhBWxFfgnMxWCehnyUdHWx6XxhmNx9Kw?=
 =?us-ascii?Q?ZxtXcDw4QJcsz1S5lRcfBf9ZsU+9JZxy3gd/gBAWoTdDhqnQh5Y5+G8ijkuM?=
 =?us-ascii?Q?Nxu9DNA+1zoI/AdDNRPx135LrUdXkNSm3q3WZRQAbse61UVgvCu7yWzcOyj2?=
 =?us-ascii?Q?pSAM8JZEWPJSE8aoZiK8MSMpc26dtjfhr9i2T6ETUwly/DVaqAfmuVulhaJL?=
 =?us-ascii?Q?EM4a9GzacO0EH0R0HuLtB1N0YHJxuc/4M2KkRDN8AKprqgPctICg5P8qvkty?=
 =?us-ascii?Q?O1afozj3HlcRnLZQrhU7qIGIFxeOyX5F3F+aMvLCLEA1evWuyNqB+S23tzjl?=
 =?us-ascii?Q?Qqh7KMWlUO5XGGUOYwx/YeQ2AruY3ry94a9hVF9Dwppefl48fFZKLIrwJPhl?=
 =?us-ascii?Q?Nj2eDvbiP9OdGKTiyB0kG7raZybbmU9a8P/O0gMJabnE9eRtt9am3dzbGDhx?=
 =?us-ascii?Q?xDJNfou27wcaCdlKJLsf/2l6Gf3t0dUf45UU/sr1y0e9dxSzNRw5dcICdNIZ?=
 =?us-ascii?Q?rTEkjfmv0pw1oG3yuXX+cuMwgWR2xp6nu+1LXoP7oMmWBSmBuf+fv2l/wsPF?=
 =?us-ascii?Q?5aQwcogBq0iXWwJER2wALHt3YfEzawIJy/YjpYXw8ZWKAGDCGnND2gjgJSBN?=
 =?us-ascii?Q?iCQg7D+NPX5sIVE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 04:43:16.2440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd0a145f-d70b-4966-bfbe-08dd3f5647ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8899

Add PCIe RC & EP support for Tegra234 Platforms.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/controller/dwc/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index b6d6778b0698..6dd232cf8064 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -205,7 +205,7 @@ config PCIE_TEGRA194
 
 config PCIE_TEGRA194_HOST
 	tristate "NVIDIA Tegra194 (and later) PCIe controller (host mode)"
-	depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
+	depends on ARCH_TEGRA_194_SOC || ARCH_TEGRA_234_SOC || COMPILE_TEST
 	depends on PCI_MSI
 	select PCIE_DW_HOST
 	select PHY_TEGRA194_P2U
@@ -220,7 +220,7 @@ config PCIE_TEGRA194_HOST
 
 config PCIE_TEGRA194_EP
 	tristate "NVIDIA Tegra194 (and later) PCIe controller (endpoint mode)"
-	depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
+	depends on ARCH_TEGRA_194_SOC || ARCH_TEGRA_234_SOC || COMPILE_TEST
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
 	select PHY_TEGRA194_P2U
-- 
2.25.1


