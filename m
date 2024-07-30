Return-Path: <linux-pci+bounces-11024-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BAB941365
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 15:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BB5B1C23464
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 13:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEDC1A0711;
	Tue, 30 Jul 2024 13:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kWGGR0w3"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24751A0701;
	Tue, 30 Jul 2024 13:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722346998; cv=fail; b=OdqBE/LjnFZRlf/zrD3Lyb6MBCvYoCdY68yWj3UXOKNQd+bZvoNEIhyBR+f6Rbr1znia344AWQBHenf8vZdQbyDA9SLCWViPgrieQogDvT6dYgStfGS6effWJaij36CuJPTTGAQHB39pI9DfEYxAjPFUqlsqnln3iu6HCdAjox4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722346998; c=relaxed/simple;
	bh=qybGQFr1UKNIupMsu8BpZlUdlzfFwObfXn7H0SvuUaQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XqGqCI83SRRnE/LxJ3aM2zGK6/9E6/XUqgxrCfOmAW7F55T5O6+HMxHBPf9sPst4/1f8Vhk2qWSt2d480+ZJkI+AzO+OfPvQGuRqi99fk7SurarHjgWMX83TZyNIdLGwXZtSxWfUnjhNMqdbGu8TIunZaRrDQV+W6R5RGzqTxyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kWGGR0w3; arc=fail smtp.client-ip=40.107.223.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TwIv3cmyxkGmIJLa4T0Zgq0RlRFcEa71GH6Mk/zrqe1/KH6irJmoBxxshMtl2Rw3BpxWk642PuHY0jnM7QmSPsyO5/b2vZvVQY3WW1lWJQKGgH/1VEy/IGuHZAWM9tD96Uw2d95aukQ09Fy7xRFaeM45yFFDQxhlNRTmpzHwpp7kI22XCat89pCRY3XrN6/DRXmCRAsbCitozAGP9Uzredo7diijEiA4A+01+VInRpGrbKhn6ytudCJJJBBZP6GZT+8wKnNVcLXdXrUWfRpF7tn+Peiw5s7t9stmTidNeYNLcZZzeEBIQRb50dKEDdqJowdNtZKqSYAqonyRNSRMQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WQpwKIvHW6wayVCw/qLhhu7kmhoWJw/g5uYXuogiCk=;
 b=Sum6rVBFZS1AgBJscj+o57JOyN2BvZUY9ARCOaph/+zHgneqg+K8Vd7SIIrCr2QICS96FI2WHA/fWNi8bA6jH3UAKC+Apt20tkxPXyqXoYG2z3YUa1qiUaNWhTNJUXDX6ny7Hic9vUMOMkZPK2ZO62+HyLJt66EgsNcCKArFSmVPa6OYuzoCk/G4WEfzK+SvQ7qiQNoYLRNyd1oHMFb9+gyjb5WHjvcN8q2PKI/V5wKwuEwvxLTy2cj2cMHxNeRvm0qm+p1698k5crP3Amm4BqNsAyKgxzGQVs0jiNDAOFBPVEz1UErPQW+uZk9n/nvcvYLA3L5RKTH4d/NlK7KAoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WQpwKIvHW6wayVCw/qLhhu7kmhoWJw/g5uYXuogiCk=;
 b=kWGGR0w3MJEreypWwoEgkvTWRdTu830Nda0MlP/YAgYUKuzsDg1UNXJGm2a/qfDDWp+tFq4FRGKZ2+B1O6np0ZCdeQJU1UlPHniwyi93SGE2LqgIgbFP8L1YhmtuL40XRkdtYeB/iK+YWz8ysNoS5TtcxiQgX1pjp9Fm+82vKBvcdjwmnMh3pzeG/tErc3ZMs5bCkJNk2zIGZeDaUyIT1cWhmmvCARPkom714EHO6nzoKQQOvb0faF33SsUXHhrCIVdy2lZp5d5GS+E9nYuc7ULSDBc9ovHG7G9k1mNIjY9Ez5iNM2LcmJbnQ0y84dkf40RJxKRy9ipBhRRytjCq0Q==
Received: from BN9PR03CA0765.namprd03.prod.outlook.com (2603:10b6:408:13a::20)
 by SA1PR12MB8698.namprd12.prod.outlook.com (2603:10b6:806:38b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Tue, 30 Jul
 2024 13:43:14 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:13a:cafe::82) by BN9PR03CA0765.outlook.office365.com
 (2603:10b6:408:13a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 13:43:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 13:43:13 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Jul
 2024 06:42:58 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Jul
 2024 06:42:57 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 30 Jul
 2024 06:42:51 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, John Stultz
	<jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, "Anna-Maria
 Behnsen" <anna-maria@linutronix.de>, Frederic Weisbecker
	<frederic@kernel.org>, <linux-kernel@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, Carolina Jubran
	<cjubran@nvidia.com>, Bar Shapira <bshapira@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V3 2/3] net/mlx5: Add support for enabling PTM PCI capability
Date: Tue, 30 Jul 2024 16:40:53 +0300
Message-ID: <20240730134055.1835261-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240730134055.1835261-1-tariqt@nvidia.com>
References: <20240730134055.1835261-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|SA1PR12MB8698:EE_
X-MS-Office365-Filtering-Correlation-Id: e8ffa870-c863-416b-9ca5-08dcb09d8f08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xsel0lcwgrL7icyLyHUtQDU/1p/zFy8UZJvtuPFdin6SjHQSOllVzP2mLy1G?=
 =?us-ascii?Q?E2SF5OWw3pB/6c446WMvch1YBFVJSdZlGgMLBMpV0dxvnis8DNhTCu6xFG/4?=
 =?us-ascii?Q?2SjlmqpLS1tYRO3QNcdxWNQxLxJj66RZA/2aaCGqSZYziv0KSKcA5F/8TPnC?=
 =?us-ascii?Q?UxY6EZj+/izJ5EqBYC2M+BAamqoBzGBk1NsncpahEiRv2PHfb20zqizciKjR?=
 =?us-ascii?Q?+MUZnqzz20d+fBuHrbsuJYI5QIuY5ReEzF/b6oQQzXgY1WEq3sSzAamm7Dx5?=
 =?us-ascii?Q?bQiT6gc+5O70pFYFHZDsvrwonXi18JcD0Wo2cgI67zReJ1EvikQQPfapdyeA?=
 =?us-ascii?Q?4oofEgXU9N0DO5xSUUPXQtwGonN/U3o++0QaYGAzUPzz/KiSLJcS3Tb3Qk6b?=
 =?us-ascii?Q?4xCGHQTkp/Nio+BTmPFkEiITSsAwmK5GgWnQlcQp3K8oZ+LA9CcHbX+yDbp1?=
 =?us-ascii?Q?C3YsTW41Phiw1evETbbds6SkbE9yFAzMV91qiOYFiNptMYyrec7SErdzgA1T?=
 =?us-ascii?Q?YW+Y4JOQsizpJftQepaaDkDnd/mPq5tbbugSUOyID7hGzpZVG2/f4Mr4C8D3?=
 =?us-ascii?Q?QM+8k6KCEvoHFOrONiiYsUvpslEDggM+W5Y33+CV2jpeIjs2zZC2Mle5HAcg?=
 =?us-ascii?Q?BnUn9gdZs4TNRYriI2hHDFH0gzxKGy3Sgvdx5/HDeuN4auLkgg17vQOSp2XI?=
 =?us-ascii?Q?CUZMw8H7ErqWehSeRHeo6KB3os55TSGtFpqFNawziD9HCr4h0ne6B7Z/RZSz?=
 =?us-ascii?Q?nChLkE1bS9wItGLoixt3fZVo7HTdzagzZSQSwlmBUI30qQW9iMSrkE+pBC0V?=
 =?us-ascii?Q?9jIltL8ee2YbaFFiRHRDrsm6BSRASBQuAhA48qDZhguuyiOMOqurZ1rjqLDc?=
 =?us-ascii?Q?idtqrazdaDSPA/FyC9OmJXQbdHfQLGfvw4aiSNwHKDw5zZEt09olMPYVKNqh?=
 =?us-ascii?Q?Xdgc+Hk3pELHrbRBUyOmguGwYaVvhiVURrwiFHI//v7FX9XCbx9/iRCANkz9?=
 =?us-ascii?Q?S2ennYOP4N8re0jOe8VS2LRha3pLgkN8wlBhHMefG1whuDZKrz0SgfbxtTI0?=
 =?us-ascii?Q?NXwVEwG+2jLH2cGfui2c2uqeyN2/1VYpVfdhpPxLCAD01lQ66Mjw59NR/zT+?=
 =?us-ascii?Q?gZ7BKv59SU1/JGH4WVn7AN9Lh/1q3aci4UkcHm+ZYaaTZVwM94Zt68IZoq/X?=
 =?us-ascii?Q?YL852bFdDulKpZkrxFxoqcY65/xfYAH+fknLZMcqvFRuAellSW5xShXlhqA1?=
 =?us-ascii?Q?AL7OeR6CPQZeVFEveeMhvNzADfKbKQQxBjtvWN5dMFuk9qwnNpEp8UsdOuDs?=
 =?us-ascii?Q?XVK28u1JryDXlHNNMyigzLG98S7S/8pUpzS4EnAdhGftek3RZQkQs8onIgMo?=
 =?us-ascii?Q?KffNPy3Gs6qs3dM1XPLK3AcGE1lyIcECY68jNZsB4I1s1w5wettLofcnGBgc?=
 =?us-ascii?Q?tRlIPqujexDUkGmZlgYADpDN8B9MJK8m?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 13:43:13.3796
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ffa870-c863-416b-9ca5-08dcb09d8f08
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8698

From: Carolina Jubran <cjubran@nvidia.com>

Since the kernel doesn't support enabling Precision Time Measurement
for an endpoint device, enable the PTM PCI capability in the driver.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 527da58c7953..780078bd5b8c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -923,6 +923,11 @@ static int mlx5_pci_init(struct mlx5_core_dev *dev, struct pci_dev *pdev,
 	}
 
 	mlx5_pci_vsc_init(dev);
+
+	err = pci_enable_ptm(pdev, NULL);
+	if (err)
+		mlx5_core_info(dev, "PTM is not supported by PCIe\n");
+
 	return 0;
 
 err_clr_master:
@@ -939,6 +944,7 @@ static void mlx5_pci_close(struct mlx5_core_dev *dev)
 	 * before removing the pci bars
 	 */
 	mlx5_drain_health_wq(dev);
+	pci_disable_ptm(dev->pdev);
 	iounmap(dev->iseg);
 	release_bar(dev->pdev);
 	mlx5_pci_disable_device(dev);
-- 
2.44.0


