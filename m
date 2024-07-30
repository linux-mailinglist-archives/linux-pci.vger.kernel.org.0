Return-Path: <linux-pci+bounces-11023-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00921941362
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 15:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 240431C23414
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 13:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6674919FA66;
	Tue, 30 Jul 2024 13:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lzoRDuYY"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD4E173;
	Tue, 30 Jul 2024 13:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722346994; cv=fail; b=MAnJGgPXyXIGJ4nTaj04ULJFb15/SG6zngy3cqZ+Rik0ZN6G3JFoZmBYEDoJNUAW7FxLUs7vTC8nBAZcn2/fKROsVL8A60PX2UbfSKUBjH3l6yrvtGOyyffV9akl3v1zaBbWQhreArVYpXOa0PP7424SNGAkJQ7UDyJ8QvGtuso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722346994; c=relaxed/simple;
	bh=H2augp1Huvj/Y1BX0bNzfcdcdVJDSMWoILAO4w3eEH0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jnhdxhg63cZbx0I5ivBJEQcg2bMx+kriLr6RApNQyCYYpvyqo5B0Hjh8AXlDzzKUvASW53c5Jigik/WLkGkoN9kdWBOomtBi4naKf5AYymItKf9P9qhLEiECbJFeHb7QhNhMeKT7527yLYgSG6bhqupAHfZWlt8JlblwQq2i8Yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lzoRDuYY; arc=fail smtp.client-ip=40.107.102.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SUuFO96oJQLLnF8quIJrcmZoO0UUBsjX4DPMcCgokvbij+dhMig7GvkqJuIu1jWwCpPL1ILAKsSGKypd6WzNlYW5Cz/GQ1OQJF4dtq462pwjJs4wzzVpAaOkLuX4shHLlDvZvvHCHq5K39vCytNlx23X2MQ72c/ObB2SEKxohd3ZSPSvgbC1vfi83DAOTyoLH2J3dY4qApLYqQtw1GcLmhcgtIOHb+kz8Uc1wJ9VZbjWujy4wAGNA6EgoLgUAimIO01SdOEdsiK1ETF0m+F6bqwLayPQjOzS960zQxKki+7f2FByS19X/6nxtP2fUmtWqB5dKJfXV/iNvopPgVZElA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vAAx1k/K2zivLcCZzbvuAAodhI4212vpbZOU7tqad8=;
 b=D2EKCq8X/OFf0W23dAo0gxZHob7hXl4Ny4i2gqxphr+AKX1CiSfl2kyHOVzs+MxlPfggi/hzZl+9bw0StaElzZO1eDJl/NeOXocTLoM1vQ7Z92n81hN1MQO8BV+KQ5GaZv/mc6AnrZzPpwgCZS/OXQEiBLDCzN5t+2dDGQPnaNbAgSf17m4Y81qEwC+4A3o7NOW2px9UQZsfQ1ETFnaaLV07nynP+Mli/ZJoQvkXK8AuRfwDvzob3ib5RUByQET2CLoPcIer+kzA1iXdDLOSpoyywCxe4HE9tr+I2He3BYHktRa9S3wQz5pv7tNJJFE4pOpgz1SG2W3/x4iuOE2M9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vAAx1k/K2zivLcCZzbvuAAodhI4212vpbZOU7tqad8=;
 b=lzoRDuYYenpIyu34pbRGrp/GJpQkicSOgCPMi8N4aEqWwtSxvn2MOVeaTj3kJptteKmjo3IrbwU08lwuX9q6b/cXSY21yKn2gmKmknAmenhdcF9grkEYpsGtPKjO9iFRdmu/ttmKaba6wRPVSJ7hAkaCPRG4SeML5wQYMSXCMxErsctZwC/lO0Vp1BmWZaFWj88HaYGbLEnQKemmZjo04TnsJfwPhE3a+dtYGkizmXPhqD/YfkJ0TcaN2kW3LR2IIdXEYTKt1WB9hY5S6e9WZMaLoDCpwUe9qF2Q1IkHm/0A7+vhl5xERLPfDAvsnsWuj3uPgnbFA259yFu5wuP50w==
Received: from BN8PR03CA0017.namprd03.prod.outlook.com (2603:10b6:408:94::30)
 by SJ2PR12MB8133.namprd12.prod.outlook.com (2603:10b6:a03:4af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 13:43:09 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:94:cafe::74) by BN8PR03CA0017.outlook.office365.com
 (2603:10b6:408:94::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 13:43:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 13:43:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Jul
 2024 06:42:51 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Jul
 2024 06:42:51 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 30 Jul
 2024 06:42:45 -0700
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
Subject: [PATCH net-next V3 1/3] net/mlx5: Add support for MTPTM and MTCTR registers
Date: Tue, 30 Jul 2024 16:40:52 +0300
Message-ID: <20240730134055.1835261-2-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|SJ2PR12MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: c200e9ab-ed22-4540-0435-08dcb09d8c19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/PzYTmE4nebYJJ8BRezdYHcdUs0wudZK1A2vZErZOUA/9inNF0Yehf4FJ8ch?=
 =?us-ascii?Q?n/zNHnerT/BhQ6ffSZubnc6Fup4TowIoaNM7oJn1yMeOt/2926swWZK5VzsK?=
 =?us-ascii?Q?SBZgf94dAIhmUl3+4rmsv8imfo1d8/fDpZ/1YWCfjqN4/T4006aTAcc5U9sL?=
 =?us-ascii?Q?P9fJXFOvqbIFsAa8TC482vtW4pLdGLEZIG3yLtfZCZkb9A/QBcspq1cVyhaT?=
 =?us-ascii?Q?pl/RN8nJFDmh+TMlB7odj3L1Cd64xKmRp7lt8UXy21TnrMNinp7gbwpdM6xC?=
 =?us-ascii?Q?gmaRM5RFL48vZVOsSSxeIjgQG+Yk4GmS6cY9r9XR88rbwqpxIZcta09CZX6R?=
 =?us-ascii?Q?mMJr69+M2qRFA0e/f6Ix2/U9lXrgEAXOl9qJVBI/V4PzdvovmB0bLCmDGBkf?=
 =?us-ascii?Q?SWYzODDJpDnRoliV60LlfPKaydzgR73xlq9C1n3T5kse+hN1PQtyERB4BGHE?=
 =?us-ascii?Q?SYqqITLE4yrnAkC7Luf/wObPIZe/XxI1dhk5ILOfnYtBOWonHMxg3fvEaXUV?=
 =?us-ascii?Q?OQSOs7z/NbCAylCbkSOIrdj8nU+Ki6xjg3a3Og8sNeJHmIvRtCNhVV7vl9fU?=
 =?us-ascii?Q?eV2m5vhhvtnafrjIRW9UhA1XYyzbYzqUvjLbtnf4nfo8iv1zuJdXIu2x3s6g?=
 =?us-ascii?Q?U6EJa/MW+MbxzkMZ3FsonRNb1z+M74aCBK0Yq9snENdeIRP87cy4LhSzPrEE?=
 =?us-ascii?Q?eCg2cHIxpIkHObGNnzyAaclp1s07V3zKkjJ1pR4oQBZ2Z095adguvej/jZRH?=
 =?us-ascii?Q?s6q7bUueZ7GwToCJHU8Ub1QEM3kn8QQNqsjse6WzdX8bTgd8fxDxJ5SE2rIv?=
 =?us-ascii?Q?/S5+ux8Ke/faX4ESAmp4JYO3CyRzDISG9R5Gt7/49CFR9MJSlxUvd6PNEvrx?=
 =?us-ascii?Q?WfkMH1PYsCRMjYorvyaSZcgOqcA5d5iIWmzh05HQHTTXGT5Bn1U2FZIJRokj?=
 =?us-ascii?Q?WEhjLvTbJ6WKV0u1H4MwpYXR927f8GY+icQcCjVsUngQofc5QZa9erKw2hZw?=
 =?us-ascii?Q?ZdLy4wMWMBBZ38lffwz1D9ffPNrPj1IDyLGcf9tXoYBPOg+rkos8Un+FMYRu?=
 =?us-ascii?Q?zFfD/5qXBZ8rCcD7Y6s0+sU2jJmPJM2pngVIBeA7IpymkoSUEdFfia/oXhQP?=
 =?us-ascii?Q?hNspt87YdLRh46mcBfTquhsvkYIXXZ3o9c+NHaeR3Rn6WGnQHZi55AqGd8DX?=
 =?us-ascii?Q?H8/7eOLcjPrZUY3yJtiE9/IvsqfK9J4Z9fkfdJSckRamVbj/9bGv4IFGXCJm?=
 =?us-ascii?Q?Sznz7RXOaG7RwrPd8FO4GP9Q/BSLXRH0/qBHznB2dgaefYOG6i+MsjHKuAEq?=
 =?us-ascii?Q?GYMNZG4DXf4uJ5Cyc8OMGa8wgK8jCx1I45s/EDhEsV6CAWPgNLfEzFgUvsPs?=
 =?us-ascii?Q?wh8Xy7Y96xWo+8PC3KH3mkv3d1bYgyOZ6Dx0W5Xd619nEnM+4/2ZpfPTiHuT?=
 =?us-ascii?Q?bnlUOj39SLoaurQC8d1MIVjZRGyAJBlT?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 13:43:08.5321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c200e9ab-ed22-4540-0435-08dcb09d8c19
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8133

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

Make Management Precision Time Measurement (MTPTM) register and Management
Cross Timestamp (MTCTR) register usable in mlx5 driver.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fw.c |  1 +
 include/linux/mlx5/device.h                  |  7 +++-
 include/linux/mlx5/driver.h                  |  2 +
 include/linux/mlx5/mlx5_ifc.h                | 43 ++++++++++++++++++++
 4 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw.c b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
index b61b7d966114..76ad46bf477d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
@@ -224,6 +224,7 @@ int mlx5_query_hca_caps(struct mlx5_core_dev *dev)
 	if (MLX5_CAP_GEN(dev, mcam_reg)) {
 		mlx5_get_mcam_access_reg_group(dev, MLX5_MCAM_REGS_FIRST_128);
 		mlx5_get_mcam_access_reg_group(dev, MLX5_MCAM_REGS_0x9100_0x917F);
+		mlx5_get_mcam_access_reg_group(dev, MLX5_MCAM_REGS_0x9180_0x91FF);
 	}
 
 	if (MLX5_CAP_GEN(dev, qcam_reg))
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index ba875a619b97..a94bc9e3af96 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -1243,7 +1243,8 @@ enum mlx5_pcam_feature_groups {
 enum mlx5_mcam_reg_groups {
 	MLX5_MCAM_REGS_FIRST_128                    = 0x0,
 	MLX5_MCAM_REGS_0x9100_0x917F                = 0x2,
-	MLX5_MCAM_REGS_NUM                          = 0x3,
+	MLX5_MCAM_REGS_0x9180_0x91FF                = 0x3,
+	MLX5_MCAM_REGS_NUM                          = 0x4,
 };
 
 enum mlx5_mcam_feature_groups {
@@ -1392,6 +1393,10 @@ enum mlx5_qcam_feature_groups {
 	MLX5_GET(mcam_reg, (mdev)->caps.mcam[MLX5_MCAM_REGS_0x9100_0x917F], \
 		 mng_access_reg_cap_mask.access_regs2.reg)
 
+#define MLX5_CAP_MCAM_REG3(mdev, reg) \
+	MLX5_GET(mcam_reg, (mdev)->caps.mcam[MLX5_MCAM_REGS_0x9180_0x91FF], \
+		 mng_access_reg_cap_mask.access_regs3.reg)
+
 #define MLX5_CAP_MCAM_FEATURE(mdev, fld) \
 	MLX5_GET(mcam_reg, (mdev)->caps.mcam, mng_feature_cap_mask.enhanced_features.fld)
 
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index a96438ded15f..9f42834f57c5 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -159,6 +159,8 @@ enum {
 	MLX5_REG_MSECQ		 = 0x9155,
 	MLX5_REG_MSEES		 = 0x9156,
 	MLX5_REG_MIRC		 = 0x9162,
+	MLX5_REG_MTPTM		 = 0x9180,
+	MLX5_REG_MTCTR		 = 0x9181,
 	MLX5_REG_SBCAM		 = 0xB01F,
 	MLX5_REG_RESOURCE_DUMP   = 0xC000,
 	MLX5_REG_DTOR            = 0xC00E,
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index cab228cf51c6..234ad6f16e92 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -10401,6 +10401,18 @@ struct mlx5_ifc_mcam_access_reg_bits2 {
 	u8         regs_31_to_0[0x20];
 };
 
+struct mlx5_ifc_mcam_access_reg_bits3 {
+	u8         regs_127_to_96[0x20];
+
+	u8         regs_95_to_64[0x20];
+
+	u8         regs_63_to_32[0x20];
+
+	u8         regs_31_to_2[0x1e];
+	u8         mtctr[0x1];
+	u8         mtptm[0x1];
+};
+
 struct mlx5_ifc_mcam_reg_bits {
 	u8         reserved_at_0[0x8];
 	u8         feature_group[0x8];
@@ -10413,6 +10425,7 @@ struct mlx5_ifc_mcam_reg_bits {
 		struct mlx5_ifc_mcam_access_reg_bits access_regs;
 		struct mlx5_ifc_mcam_access_reg_bits1 access_regs1;
 		struct mlx5_ifc_mcam_access_reg_bits2 access_regs2;
+		struct mlx5_ifc_mcam_access_reg_bits3 access_regs3;
 		u8         reserved_at_0[0x80];
 	} mng_access_reg_cap_mask;
 
@@ -11166,6 +11179,34 @@ struct mlx5_ifc_mtmp_reg_bits {
 	u8         sensor_name_lo[0x20];
 };
 
+struct mlx5_ifc_mtptm_reg_bits {
+	u8         reserved_at_0[0x10];
+	u8         psta[0x1];
+	u8         reserved_at_11[0xf];
+
+	u8         reserved_at_20[0x60];
+};
+
+enum {
+	MLX5_MTCTR_REQUEST_NOP = 0x0,
+	MLX5_MTCTR_REQUEST_PTM_ROOT_CLOCK = 0x1,
+	MLX5_MTCTR_REQUEST_FREE_RUNNING_COUNTER = 0x2,
+	MLX5_MTCTR_REQUEST_REAL_TIME_CLOCK = 0x3,
+};
+
+struct mlx5_ifc_mtctr_reg_bits {
+	u8         first_clock_timestamp_request[0x8];
+	u8         second_clock_timestamp_request[0x8];
+	u8         reserved_at_10[0x10];
+
+	u8         first_clock_valid[0x1];
+	u8         second_clock_valid[0x1];
+	u8         reserved_at_22[0x1e];
+
+	u8         first_clock_timestamp[0x40];
+	u8         second_clock_timestamp[0x40];
+};
+
 union mlx5_ifc_ports_control_registers_document_bits {
 	struct mlx5_ifc_bufferx_reg_bits bufferx_reg;
 	struct mlx5_ifc_eth_2819_cntrs_grp_data_layout_bits eth_2819_cntrs_grp_data_layout;
@@ -11230,6 +11271,8 @@ union mlx5_ifc_ports_control_registers_document_bits {
 	struct mlx5_ifc_mrtc_reg_bits mrtc_reg;
 	struct mlx5_ifc_mtcap_reg_bits mtcap_reg;
 	struct mlx5_ifc_mtmp_reg_bits mtmp_reg;
+	struct mlx5_ifc_mtptm_reg_bits mtptm_reg;
+	struct mlx5_ifc_mtctr_reg_bits mtctr_reg;
 	u8         reserved_at_0[0x60e0];
 };
 
-- 
2.44.0


