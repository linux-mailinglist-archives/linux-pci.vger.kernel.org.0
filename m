Return-Path: <linux-pci+bounces-25637-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 987E7A84D71
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 21:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFE153A4554
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 19:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7061EE02F;
	Thu, 10 Apr 2025 19:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BvYb5FCX"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F010A1AAA1E;
	Thu, 10 Apr 2025 19:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744314391; cv=fail; b=mE6V8a+hkNq9NFHs/hmtcMpc9vwl94g6FnMbT++T2Liux9xTk20TL2iCKOZVdxMs/cpyiQXArOMsxznQF4MJe9Hr09sRc7RAoHlX7Tqtl8zntFPtmoGN326OUj/qUSHDGbhs1VfIRkxyRxFdpwBdFGALbqJBQgWNt/6oDEw4uyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744314391; c=relaxed/simple;
	bh=okuHlgdGqvyAccGuP9TuXDJbq1DuGN2GJY8esIIjcxQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qg7QLPD28tgvfDhdeX5UBu5r1JNjR53qB34yxJG8q0BA2fTeHTRpZ1L3HH+9cR0WZxGI03aLS/Ap9HF7g/ppSpUVx4Tg/rmb/wQOz+sutauTngdqiQLSlBogNFTbmXoMXExCnvhApfvdxmFjIz7UXOIRBTUDDMqt2d3q22MHcrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BvYb5FCX; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F3EFV8OkRoiC30io4RpjX6u3NfNYNswsZ495MYBqfZnqdNRGMztqnJBIp2l/gkuGQPsAB3y+BxqQ3D4+BBn+3CmrNqxpfavO4aMryO6/o4clxN86QEaJ/TvjRYDdWpjpGNU3/Jli0bUZy39QpHpdo+IIWEzsiGqbbbRK3g4r+ahrdIk9bgBvke6bqmEGWKKs2O8yQa9g+sc2iPyqb6ts+6y9bAWpQoXPFx17xOlpHVAIifcB3TnuPM+ykjUARRlEzhqsRrZpH5raYMLQRyMLgm7+srGZpCUIYSwMYdPt3cZZh34uFkZeh6lYVnZOujYeFBE1gjV+RCxGRZorQWnKhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AB69JFk1i49b86kBWGo23ofimFm3uaNqDWsNz0pBNxg=;
 b=thdMbjobrSQcp9g1rO/LwO5wEU+ICFTAwLFEteNcKjM5uqJ91oU918kXQvUhfkjniB5n/+Fp0U5ZjTAIPPq8t/oluIW9eN3AioAufi95i52M3b8x3XwBhXDwWPPAPMTgtrJ8xl2mYcSMEoRKZ1YNwzQkzuCTTkdf3Tst/N13cMeNiQ9ZcqkqRU3br63BjPPsCmNu9/7yoo6NNAfdoAvdBd5tR/gwmwX3h1Drs7FqRN2xiwE1/Ma2NCnq2Bbpg3AmRvp1MPjXsRzySVH5QlXMZ4Ssi5vmExtLiSjYd5E3Hw7ks0NOZeJt8bhSbekvLP8CIecNYmFQyzfUvl4881dMlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AB69JFk1i49b86kBWGo23ofimFm3uaNqDWsNz0pBNxg=;
 b=BvYb5FCXWpWr0aA/mMIEQzB49QqTcwX5zl3CMAr4BZ7MueEG1LSnHxZtUSXkPYdEg1qbs4XyL4DyttrgEDj9DFjDrFmzEr8VjJRxIUxJ1UwBSpZ1Fw0eXumcl+q2gVDnw4piDxRNgrHw+dHnDyMcJxbcbzvEsIBSEj4MNh7ktQ9sk7oRHi9TKgy7mWA6Inrug71n95qC9Mksj+7Ck/PUsm8D6lm6gRH6nxDBHVdaIHbonMLHutPky8/n2u18gtbABqbtXOmsnutctMmuFEnBKc8nxkJVY2eFfZTI1FBVwC1gi/VTN+JWCYpXz2JgCu0UOI2RhHOr+ga3M0yMREMtmw==
Received: from BYAPR21CA0010.namprd21.prod.outlook.com (2603:10b6:a03:114::20)
 by DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Thu, 10 Apr
 2025 19:46:25 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::a9) by BYAPR21CA0010.outlook.office365.com
 (2603:10b6:a03:114::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.10 via Frontend Transport; Thu,
 10 Apr 2025 19:46:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 19:46:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Apr
 2025 12:46:10 -0700
Received: from vidyas-server.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 12:46:06 -0700
From: Vidya Sagar <vidyas@nvidia.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <bhelgaas@google.com>,
	<cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <kthota@nvidia.com>,
	<mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V2] PCI: dwc: tegra194: Broaden architecture dependency
Date: Fri, 11 Apr 2025 01:15:52 +0530
Message-ID: <20250410194552.944818-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250128044244.2766334-1-vidyas@nvidia.com>
References: <20250128044244.2766334-1-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|DM6PR12MB4435:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d0a935b-31e1-4aed-a9a7-08dd78686077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YT3zq607+K+sJD497JX/NrNFAAaoV572K29tS+3JRofioyFLhK94/DKRNTiD?=
 =?us-ascii?Q?dsXLGANJf9ve9zpJt97MPORSA736WmiZ79y9ocWdCewqITeEKjbsDkWDk6Xb?=
 =?us-ascii?Q?RU03e9NmzQbmiGdzK+cAlueWR6OmKnE4ZPLuUNdLGeA4vIcHtY5QbOKlqKNA?=
 =?us-ascii?Q?URfmAk8+WBwFNSwIfL1DpiaLFT3WSouKjK+zf17VCRTdIcEK6iE96yZyDbu5?=
 =?us-ascii?Q?arrBriq7/V2BZKFFbtRe7bEhf4cdy4FY6VZB1ZE5eBHutVReon7LlWxDk0c8?=
 =?us-ascii?Q?V2TtWhOBHcvQ1vuiQj6lZg2SNKNtiaBXmRmJIjvZNxLvLD7ZeoPn2HBfXLs9?=
 =?us-ascii?Q?OScASBqHIiOmgjvgY608bLUiABwVxAMHJ91Bn+l7Kvoxb1dF9vXeT1lk1Ohe?=
 =?us-ascii?Q?oH5535Z+XYCAWZU+dahrBt26bpApQ3WVlJvIqIWE6qlh3wYb8kjkaIr846jB?=
 =?us-ascii?Q?BgzL7XDEymaTBMBIbDn3UryVHT9daWAg9t5B1oSQeCGsWQgCb+dhyO6jyCW7?=
 =?us-ascii?Q?6VYACo83h1vgEf0CAThUfq9J0gez1+bosY8/GcSbMj9MOrPBBwnvpPsUonBP?=
 =?us-ascii?Q?qtLqatHjbRrSKTL+bDvxh55FhOeAhL4+6na2epyUb28LOiIRyS3CF7aY9DLp?=
 =?us-ascii?Q?EZLCHCZpThE9RQNdX50uouqfbyyLfBKMRoAW3mA1P9yZ7nch8N7hMN2mJKRQ?=
 =?us-ascii?Q?zoxZPzOMcDz8xQGZpmmQabJrll7I5hW23RhFKajaWEpPiEPvpe6K3XCaGh/6?=
 =?us-ascii?Q?XfkTis9k2c3q1OrgQMq6B6AKtmVCsyJt8Ri36Pm5svB9UX5ckarXFhDfiBhj?=
 =?us-ascii?Q?MCsmtR2xkN1ohnxbOK2kRt9veZvmwtaoNh9tqkjc9vky//M9S2TkACMDkTSg?=
 =?us-ascii?Q?5omZxx6ODBQT+6PQAqNfSLE9U1D5ddJBQv25SIJF0/Uie+fhHprfnVsEtmzL?=
 =?us-ascii?Q?pCacL+fTW7IiTq0X5UVhwHr+SM28bSCwcXFXNyW1+vi+jT44FHFN83hQ6kI9?=
 =?us-ascii?Q?ItQasTf2dYFTVwb7JZKNRP2+c94t376iJCRwiku1tESUKeejKnSHeyp/5S66?=
 =?us-ascii?Q?h2Mgaiufq1GFqEQpcjyD8OTe7YLRWE3OV82bEFFJ9W0BCzkhw4C83YTesXS2?=
 =?us-ascii?Q?ltZZp9DgIHizzyguuXb7dxKxrJ90Z9Ax9jIn/IabfjJM8bdeWxWJWH1Vg0bV?=
 =?us-ascii?Q?OZqxmik6gaJ+LuciFCgE9+ZZ/TPP/YOd/tWS+veF8mAa2TI66NvuZxHAZu+M?=
 =?us-ascii?Q?FLjHwcEvYfn7dZSiBtGW4MJLP0i1c+Uu8u62azIQo9BoXgkENdzwBJN4eyPz?=
 =?us-ascii?Q?RnKKs4XPDm+3HV/lzgJAzVXq2C/qcQt5aRhaAEAZwW6q1st9/PUQSvokdWlr?=
 =?us-ascii?Q?8bBsLmhFT6kRgdWusOPZvPfWfNroz/BKxgmAkaXtm1hi5IJLfQbI+irrkibY?=
 =?us-ascii?Q?mjcYK/nXDnXpxK6KSix7yVQSMA1/yO54fTUtTkzIVKI8WPLKgf9IiF0d6MkP?=
 =?us-ascii?Q?Bh/phANUbsrOXMKJ6H8X52WkreuSoSZCdCV4aJYBfJFcrcPxTXzf7Wh2jw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 19:46:24.5927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0a935b-31e1-4aed-a9a7-08dd78686077
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435

Replace ARCH_TEGRA_194_SOC dependency with a more generic ARCH_TEGRA
check, allowing the PCIe controller to be built on Tegra platforms
beyond Tegra194. Additionally, ensure compatibility by requiring
ARM64 or COMPILE_TEST.

Link: https://patchwork.kernel.org/project/linux-pci/patch/20250128044244.2766334-1-vidyas@nvidia.com/
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
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


