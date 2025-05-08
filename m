Return-Path: <linux-pci+bounces-27416-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51298AAF2C7
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 07:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39FF93A7FD9
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 05:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C50D205AC1;
	Thu,  8 May 2025 05:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SWrV6wYZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5BD2A1D8;
	Thu,  8 May 2025 05:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746681603; cv=fail; b=o2dCMAwi0gbJJ9wR4nDtlcr1iEJZtrxgYwis9By88b4JppynmJIObzE7N5Pr6waZ3jE/PCvAnjsLvmdKC6OZnQJiYEYv6aLXSUljfI1Yb+vJZ5VQP0mmhjAJOucb5DFgjWOjbkiUbSX9EC6Mi8BhB7D43XXpr3RZkaSlPQsW7p0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746681603; c=relaxed/simple;
	bh=f+j8pvIK40u5apY1MgtHoIOuKmgv5NmbmgFWPnpuJdM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a2FDbRC+QuefIf8Faf++oD3vl/pPXhYnO1HhsnbQVO4cVBOSq1iYQBSZ173Lc1U3kWwiJnRYIGPX+H8qfrDE1VfUX9RyzitAfx7onLccgEkyPcSmn6wU4jQwAInT5NcohpIePwm1mJVNvI0aOC3zgd/8j0Weaafq6FGAcOEVfZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SWrV6wYZ; arc=fail smtp.client-ip=40.107.220.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5oohjsh5Utu3UhcCon532fyT0PLQfuMti/2nHRKl5CfnL7DEqfiYIM93prkE+4YBO6LNfR9AOzQ2UzewMwAUn2ZURml78qO7//RvZhZT/l17kly8vaXm5004DLq0fj1j4OIqEksVMvmMcNKUc5y/xC+TbRan1hRW0rwQJ0MwWBzLkSDb9eQWHqvvHYDvUoxZd3eDB2IjehCvaKXauKW+1zPUKsX5nLP8mifkUEPkMKgo5szR2F9GIDsGj4poMDXqwsUIxzEy9tt5kvmayesB5Ce0k9PaPHmtlVTv3UA5e1n7xgqCuX8BXW6gFnOmekErfer05pXlmY7vTNdRiaCDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfnhYz4MaxOJNOdh2EhwnzlefMrN5zTvfJ+jd6fEALs=;
 b=cw4jJNIcBdf8Ott6fVywiq0qnA8glnmj0cGLzzXIRshRv2q8k7pIKWfD2t4OAXIpddBlY+DKsZJxISCZgu2mM4L2xc5Y9U3PvN1KJNi2TAQ0vQ1B+yIJnzb4gFZWOfHkWen55Il1A/8nWJWer6QhCYGsNUj6rqbMON9UGkiX1C1a3i1AmaNHyi2PaFe/C5sRjeAIROpz6PFJx2T7+9EcaClXl2+BWYL0TWyzrRhTr6ln5rL7Jg6pNRu7m5Qz0oWNEjijY5mDP90n2dbkXA6f2Asmo4dakw2DFyJM7rDx6uOCByqK+APNZIDMujCD0b9N6qH1p2ub3S3ERT7YcnuCew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfnhYz4MaxOJNOdh2EhwnzlefMrN5zTvfJ+jd6fEALs=;
 b=SWrV6wYZdmaWC2MfrJumK7uo83q1cuFSX1mwDVd4RDs1bZrz8NsbwsXB7IMdeWUbxtp1/dcft4ARePkvAF8BKcyabijQ9Hq2kcej/ifLYEOxpAEiJoR23A8YVgQlZZuYqmHYzcZKwt6lDi+AtielEyZzmmbj+wxVaTwBjOIPlsYE+r/yi6qwSS4AbNMcujgoHumjzB9CqLJKepi3aGa6/U4rkon64+RjeN+NGhaaR76F64qW9rZmagD+aNo+1hjZpreeVgWg2JskkjQcP7Ak/Uu5O43ioCQ5XyqRp4VC0UN44bJFBD7Ibn+/66Uqmu6oJ2BsDqf9Fn7PUJJzXmWjOQ==
Received: from SJ0PR13CA0011.namprd13.prod.outlook.com (2603:10b6:a03:2c0::16)
 by SJ0PR12MB6968.namprd12.prod.outlook.com (2603:10b6:a03:47b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Thu, 8 May
 2025 05:19:54 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::94) by SJ0PR13CA0011.outlook.office365.com
 (2603:10b6:a03:2c0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.19 via Frontend Transport; Thu,
 8 May 2025 05:19:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 05:19:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 May 2025
 22:19:49 -0700
Received: from vidyas-server.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 22:19:37 -0700
From: Vidya Sagar <vidyas@nvidia.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <bhelgaas@google.com>,
	<cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <kthota@nvidia.com>,
	<mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V4] PCI: dwc: tegra194: Broaden architecture dependency
Date: Thu, 8 May 2025 10:49:22 +0530
Message-ID: <20250508051922.4134041-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250417074607.2281010-1-vidyas@nvidia.com>
References: <20250417074607.2281010-1-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|SJ0PR12MB6968:EE_
X-MS-Office365-Filtering-Correlation-Id: 21ceaf70-1774-4f02-342c-08dd8deff723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mZLQrvXPWdnyMVYsxd6szjtorzWAm64Q5tiHP7+Iwce254OTnPbQEQHHHhZ1?=
 =?us-ascii?Q?k0JqM1CNcWzBrjUy2s9L0CCCP9wQSO7iWyWXEuSNKGWIPCdJDr+pR6IthpqQ?=
 =?us-ascii?Q?6do2M3b2gGuHUPKVQDRrOdIxX9fYJHPr8G25mTkphTZtoJdL8hrqdIZ+7KP2?=
 =?us-ascii?Q?izhYaZ95E4FAkJOVd1Aws+/nbcZEIzrX4lS1jROPhC1S+++Ouhhxg7x78Quz?=
 =?us-ascii?Q?RCDuoHgY1DN7i+3mVaxiY7343DcJmbGTdwrB/ZcUBMVAIN8D6G3xUyF7XyNx?=
 =?us-ascii?Q?7pwqJWlzduHUlSi+xTda9pyh4nIJAiuQZlVHJ0jimTMsC8ySrxB+x1I4vzNt?=
 =?us-ascii?Q?Frxv5xkanu+7TeuFyscHg6gOxPP38ZFkp+kU34dRRDwRRpc5PGWJIEddF6+3?=
 =?us-ascii?Q?Z78IAKuV4qRBJ4aXa5bUoCb0GYedyRCd5L7VGgjxc0RqDR0/1F7uYqnINXgs?=
 =?us-ascii?Q?micfo1FVcR7dSw5+xepF+i2+i8tMyWsEl/x0giL7pPiJXGWTcb5fzBKx8QvG?=
 =?us-ascii?Q?lK4C2oP2Kg6l2oDKcCZ6ls3Qygl7xhNbW5dcM6TSUdY7JUz/j5TVrJ/ceUp1?=
 =?us-ascii?Q?p/4cOzX8zmygif5Afk1m86Wo/2iNb5bGDtZpT3I3K6BzvKEcXCJgLSDyYhuo?=
 =?us-ascii?Q?5nx9I1NcW+YvLkTU7qMrV9p/BPMW5Az0QAImnWu+DzC1hC3aioNrWVuNtTAQ?=
 =?us-ascii?Q?SRGTNKX9bM/lreDqVfgDSTx9ipLPOouP9EuT42Rgm27nmylKrnCF8mH22C6e?=
 =?us-ascii?Q?Bdu1TYDGRmPNzgy3HmQth/b9mQx94b0MaoFAqRsCTquHm6NDxPv7KELhCQcZ?=
 =?us-ascii?Q?pDa1GhQcpnhDyY0F0oA3L/7of9PKsbC6m1owzf+aUBkxnz26vQBrGw5utuGL?=
 =?us-ascii?Q?RJj/bHlhX0d2pyRrzS3BPkzyItf6FO9XpK5yDLfjn6Fd4alNN65x443lw52W?=
 =?us-ascii?Q?KKFgI4w5yFCfeU3RM1DvMAv98amvit3awA/pJ64y9c/KuX/IQYo9MAFFcs44?=
 =?us-ascii?Q?m35x26kYXLnmeTlG+p6nETDgZvat3VPS7vOrSdzX8z8bYgYk8IQOA2knKyEO?=
 =?us-ascii?Q?fEr8OzH2VXI3IIvEJvsy4738Or60S/aspgxGduXRxN1Hi+mgcIRhMlpMoLqT?=
 =?us-ascii?Q?QfWYdEQUjdSuo5zP59ymjPNX4CLtF677pPoN0UUBA5x/Zfc5JTadGBTvGon7?=
 =?us-ascii?Q?j3SPnKFwtDBGzaBzPm/4pYVT0YyiCouigbBck8rjPENkz49vPxBeo/S2rsLy?=
 =?us-ascii?Q?fMvgeqFSNa8g535tgtwk8LaZVxyxGhNb4H2YmzOvQHyVTrq5wvPaLyLQPl4a?=
 =?us-ascii?Q?tlMC/JzPPWBhVAC0B8JZi2mPFxsiFnARsDt11NyOiiH7TRexxuv/KQpHT/8H?=
 =?us-ascii?Q?1noYqjsrRHq5JDk5FnxnQ0sLsSN8sX5RizJF07AoOpHwBIp6WvmDDu3PDrss?=
 =?us-ascii?Q?C2Svq8OBHZW0FjQBlULHIuOxQJbuPAOZFrUCS6d00gOLGBuJv/Rk7WwpissD?=
 =?us-ascii?Q?+uY7Qfmyr4jldsIXuAQi1pCS+aQhSGr1mIr4B718zxaHD2xH2yWLuhLAmA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 05:19:53.8207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ceaf70-1774-4f02-342c-08dd8deff723
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6968

Replace ARCH_TEGRA_194_SOC dependency with a more generic ARCH_TEGRA
check for the Tegra194 PCIe controller, allowing it to be built on
Tegra platforms beyond Tegra194. Additionally, ensure compatibility
by requiring ARM64 or COMPILE_TEST.

Link: https://patchwork.kernel.org/project/linux-pci/patch/20250128044244.2766334-1-vidyas@nvidia.com/
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
v4:
* Split the Tegra194 driver and phy driver changes

v3:
* Addressed warning from kernel test robot

v2:
* Addressed review comments from Niklas Cassel and Manivannan Sadhasivam

 drivers/pci/controller/dwc/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index d9f0386396ed..815b6e0d6a0c 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -226,7 +226,7 @@ config PCIE_TEGRA194
 
 config PCIE_TEGRA194_HOST
 	tristate "NVIDIA Tegra194 (and later) PCIe controller (host mode)"
-	depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
+	depends on ARCH_TEGRA && (ARM64 || COMPILE_TEST)
 	depends on PCI_MSI
 	select PCIE_DW_HOST
 	select PHY_TEGRA194_P2U
@@ -241,7 +241,7 @@ config PCIE_TEGRA194_HOST
 
 config PCIE_TEGRA194_EP
 	tristate "NVIDIA Tegra194 (and later) PCIe controller (endpoint mode)"
-	depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
+	depends on ARCH_TEGRA && (ARM64 || COMPILE_TEST)
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
 	select PHY_TEGRA194_P2U
-- 
2.25.1


