Return-Path: <linux-pci+bounces-26069-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4981BA91599
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 09:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5CAA17EFC0
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 07:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC43B221546;
	Thu, 17 Apr 2025 07:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gcJQ6I5e"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2053.outbound.protection.outlook.com [40.107.102.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4579220686;
	Thu, 17 Apr 2025 07:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744876008; cv=fail; b=WhYOzg40LsFqmJnlLqiqjGF1tvTc9mUKRqUVkyg4qX/4S8qw/9WV9dwDlF0R1MA5TxbA6EuxU1ghzOzPtybKSd+axpETa3FOkpN1tKB5QMQWFX4vp3cBlt94ekI9rL2l8hr62c6Frdoz3ou0uLhAF2xACe7JjKUx1XfPbOSAke8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744876008; c=relaxed/simple;
	bh=XFAvcQjHAjffUxbYWzHwAHCDhxf1MFt8QBZuao7pZi8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FwRzpzBsvMjSKRQcnzHwv5MFDB9UIYb7k7l7hnAuJ9myPAnmLGGQPQdJTeck3vIClGTYeuGpqFZdpLYPwK0R8pf2WTC2/9sZct2oyNi58w5jK4BP5gZ8UCNv5YqkQOMcFllB3k8+ARP9mba7RAO/MNmioFpSQZgRZcYJ8vEm0NU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gcJQ6I5e; arc=fail smtp.client-ip=40.107.102.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFPxVCjGv/YhdmVUHbb0XDEwgcEAp3SzNJIOiNak05mrrj6He50F9MD2Pra8P93/VVghFTBG/9OL3XSITQTGXkUvyc3PC9j7JoSokwW3ua6ANu+DBJSN3XdRUgoY2SLtt53rIc1poQdAGDG1SeRkEB1+T6c1C0g6YDVYq+fniRuSf6VawacMW8bwKeZ7AGj24OXXPkNYsmuP9n9lQ1kCU17q8gZngHoxXxYTNlPXMoWpK85IqPR0+6IYlO3HsGG6G0XDsXCZ8JcVtdoufe4/LuK7A2yoEHqAlahh8hiq9yf7eXy5JOe/CuGMo7RDX4pRyEs4OFR7guSKXTQAY74Y7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g19H/RJlH1MKG3GoGpvstGuzqIyMGPaVWadQJdPGb4g=;
 b=VsrEet1tqmiaOC+tuNz9RjKtnm7D2AYiC23Q9srZct6PQe26qJqBr+ViXMreT7YqbdQs3cjXMqclqCNEHIMgBrTE1/2j+ZKrIQ12yV3UqciQ3g+7+2lWKbTGKXrau6Tp2j/6DBlujxuyX6Acc3wG7EQu6CF60+5iTbu5E+9JQm7SiHHLISRnbwLHbqhndzk7DMW5fUVpT6Y98lXIXrGhm6QPsw4K9ymPPbi0yah6waB1jlBu40tV8fN7N3JG01112iUPutXIu6HMA9FyCgb5tGL0vLcGS4XVGdSusxNt72k85G4V9KN9dvHxdm9d4rwv8XNPNQhEQNLm4kyQ8UHkQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g19H/RJlH1MKG3GoGpvstGuzqIyMGPaVWadQJdPGb4g=;
 b=gcJQ6I5e0F/+4VLM3xEJbq9qoxMSv/ZXLjzQ5ZOUOv1U9Zrxy74cA6z1NVAxIfmHNYORZLElaPP1M4l9aJ5n3m8HZJxv5POl0/mGuuLDGFpkmV1gt+gNyI6S2jszuZ7H32dMF30GSvFGjCw+E7ZCri6chVfT+qKFD8gaj70MsxoBfsw8bIfytfIsIq37XouSc8s6cnwFblHigHkT1HJNaXSQzZsCIkjaGiMAHHvCcj50bLxlXnQOToWK09gBbAm3TVS8bmZbXPjY6BjKbUcsaIAqvoEmXtAEKBE3rZ659g08YTFqPuFH2uZkwujFiNeOq4BzHNsTjCpTLomW9Gaiug==
Received: from CH0PR13CA0001.namprd13.prod.outlook.com (2603:10b6:610:b1::6)
 by SJ2PR12MB8183.namprd12.prod.outlook.com (2603:10b6:a03:4f4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Thu, 17 Apr
 2025 07:46:42 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::ce) by CH0PR13CA0001.outlook.office365.com
 (2603:10b6:610:b1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.18 via Frontend Transport; Thu,
 17 Apr 2025 07:46:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 07:46:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Apr
 2025 00:46:26 -0700
Received: from vidyas-server.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 17 Apr 2025 00:46:22 -0700
From: Vidya Sagar <vidyas@nvidia.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <bhelgaas@google.com>,
	<cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <kthota@nvidia.com>,
	<mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V3] PCI: dwc: tegra194: Broaden architecture dependency
Date: Thu, 17 Apr 2025 13:16:07 +0530
Message-ID: <20250417074607.2281010-1-vidyas@nvidia.com>
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
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|SJ2PR12MB8183:EE_
X-MS-Office365-Filtering-Correlation-Id: 27599348-a414-427e-3ae4-08dd7d83feb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VkR8doBT7Sjgz0K5iNPjVE1Sd9cxec5xlcQdehvYa7F3PDuZMNTg9108hXHU?=
 =?us-ascii?Q?f9n41NgtbSJWo+gUwDU6mymvKq4OY4b0qfFoltMqF1aAZvuqoEnDcID18fvY?=
 =?us-ascii?Q?hnav8ZUcEALqHK5ZdIopSmcRg+IAtGGAGZOX/asIj2Unq9gG46ghzos/F+jS?=
 =?us-ascii?Q?RDn7P+hE1gVvod05Kr35UcB9hAarAfoR/5o7SqX7KwL0vs6WqQMfniVidFl+?=
 =?us-ascii?Q?gvOi9EUeABahJ4SOew7pV+1z5Y4qqhADdthcdz6ZX2SbVSwM0BhdpSLBUgmf?=
 =?us-ascii?Q?yLp/XGKmJo/h1Ps2nUU4FmouUBM8elYEEGBFa4psK95S0HIDLinUyCXfC0da?=
 =?us-ascii?Q?zcOY5tnAk0e4+0cL38pTni0wHU6my5u60FTU4gNteYpXtqtGVm5tMdeS1+pz?=
 =?us-ascii?Q?4erHKG5dKqrrrFsrVgitxF01xClPOpdj2bhlEooAIscWMDiBRPa6lSFGIh45?=
 =?us-ascii?Q?Cxkdh4PmJXN88quXlWC/L52cvNpHPJuqTRuSndbUd8f01nuE6HmlmFChXW2h?=
 =?us-ascii?Q?7y2vB6etlSChzZvCJSe2kscQPKZ4rtgMIp+L+OG5tkimQkU/UTa0BDbtx8K4?=
 =?us-ascii?Q?apB4PrXvDRJpKhCZMuaiqy5Zww4kH+5kk6IUIC+udpU7QYdUOlFT2D70eYM3?=
 =?us-ascii?Q?JfhPQEIrhDLvnxxK7fhpFg3mybgjF5RczfS/SYoyxVlLSgioJBiYJq2GGPrQ?=
 =?us-ascii?Q?yVQb1I9A8jnDH9+CtiTfLQ6ETXdeqkCVW9QQSkdIYm1MGTnA7Z6Qy0D347oa?=
 =?us-ascii?Q?HT9GRRHgiKEKyZV645d+s0tJZb2RI/aMvf+JrkId5fVIkB+9sAeJgfF5kDb1?=
 =?us-ascii?Q?BFPYKT06w0UVzV/yDCWX75ZXPNQwKrZPx91L8xC+7bkQsO6NcVkvUdCB61RH?=
 =?us-ascii?Q?BKYSTgJKOiXQP6C6XJWdQ6iYN8wy2Gv/gfXqHQ4cZqwVJMB/3obgSnV87OcU?=
 =?us-ascii?Q?vXVrCRNUjR2R+Hf28FIkcv7sZqTklNK83uXpJXyfDkckc/2yf7pGt5NvhmFP?=
 =?us-ascii?Q?0RsHdFJWn6XDeTMTr2RBn36Y7dKicZCNEcnnwBEImXp6JWLChCis5RcN2fEO?=
 =?us-ascii?Q?6UYBGdlZi0ooNS56dLjN0SHaNqX+XBK9W9nQ8Wa6PsY2jtTeCFlAQixWQGZu?=
 =?us-ascii?Q?fDKFcvwjzw16Gj1R+I6W4XoS3BEWk6fOZl88PCdulVZZnrVOy2Txwk2uPK4V?=
 =?us-ascii?Q?9/K3unGqydE0a6oonASDhw4OzOg4/qao0QgvoHBaC2V/O9BJqvTJ6FvEyuDS?=
 =?us-ascii?Q?edY35Bfjy09+s/pHXYVzgyH+y19JTZO3QQECQSxEWjcx7DMpzDxvx/YRdzlM?=
 =?us-ascii?Q?vA8B1reunQ2MUW0ZmHCfnYSwPGNeuDRmEPTaYkXLenCVK//DpayW80yrChtb?=
 =?us-ascii?Q?19POt/eLJD9qKdagvB1UDZo4V8CRso/2nZZk36o5lTAuUbl0ouhOaSsxP0yW?=
 =?us-ascii?Q?usi+0ezXUpPc9yPkPoQ5IMufKL7fsjBZO1054tHp1QGtpp/YP2eQoaviIxi1?=
 =?us-ascii?Q?axwVtKbfW0kPBo0k/Z5jiSfVNbYfIRdkOSIVTWOrhrNLjzMwPG0kYWPkUg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 07:46:42.2666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27599348-a414-427e-3ae4-08dd7d83feb6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8183

Replace ARCH_TEGRA_194_SOC dependency with a more generic ARCH_TEGRA
check, allowing the PCIe controller to be built on Tegra platforms
beyond Tegra194. Additionally, ensure compatibility by requiring
ARM64 or COMPILE_TEST.

Link: https://patchwork.kernel.org/project/linux-pci/patch/20250128044244.2766334-1-vidyas@nvidia.com/
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
v3:
* Addressed warning from kernel test robot

v2:
* Addressed review comments from Niklas Cassel and Manivannan Sadhasivam

 drivers/pci/controller/dwc/Kconfig | 4 ++--
 drivers/phy/tegra/Kconfig          | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

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
diff --git a/drivers/phy/tegra/Kconfig b/drivers/phy/tegra/Kconfig
index f30cfb42b210..342fb736da4b 100644
--- a/drivers/phy/tegra/Kconfig
+++ b/drivers/phy/tegra/Kconfig
@@ -13,7 +13,7 @@ config PHY_TEGRA_XUSB
 
 config PHY_TEGRA194_P2U
 	tristate "NVIDIA Tegra194 PIPE2UPHY PHY driver"
-	depends on ARCH_TEGRA_194_SOC || ARCH_TEGRA_234_SOC || COMPILE_TEST
+	depends on ARCH_TEGRA || COMPILE_TEST
 	select GENERIC_PHY
 	help
 	  Enable this to support the P2U (PIPE to UPHY) that is part of Tegra 19x
-- 
2.25.1


