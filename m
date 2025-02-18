Return-Path: <linux-pci+bounces-21685-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42240A392A2
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 06:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B37B188F337
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 05:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336BC190661;
	Tue, 18 Feb 2025 05:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C5HhPCt/"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F85910E5;
	Tue, 18 Feb 2025 05:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739856656; cv=fail; b=ltRukMfOZlAhUVFe79TCOPBMFC/ouMo7bWix/8CWs5Xu9EVyjqkj7dCVxovZadr6wOwpoGJDK21QrwDWIbjfauLAeQFKwu3+AN2FpMaFtXV4CYpteJ49jX1UnH/fkxAABkMZ+vPR7BvxSjAvf/uLzhTz6XJ9PLBRqmsJyvU4sj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739856656; c=relaxed/simple;
	bh=sWVLcByvdv1zgCmR6JhQuUi3/1+aDic5vEE5I7Js81k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rpRDcUZ8C/b0+xDyABFblbOnzdZsuTBK/nS6mV9KnSqAcuuz3hykoO/rJBMp17tggnk0MdlUWYbUgCNopgHXECdRUoTXrBHWXJDEgCCiapB1a6L6hPWaPdM9bQ40cEfMwsi1v4sT61dOsgJtmku40BLeQckLakvSoXvHxOCGcMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C5HhPCt/; arc=fail smtp.client-ip=40.107.236.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kFAw16yqNc26fX9FZI9nmH0lRkyNPVrM7rYzFZiej7/mAPdZyiEL9pzJbtCZ7pP46VQef7aaqQ+Ujpm+65C7b+Xuc6v0ErPUDzIaQzZdYCR3Tca9P/f2Xp/TpZuuzLxI8pboiOa1+boPBhvaM7FAr5ZtfGOhoMvJyl6cSKtA/y4QEjvmNb+T0cLpo2FDZH22dIfNbUvSfqw+pnW9ZBSxOEM93ZzvDYjmTbmPJ6gJPUApARx7MojEue70N/YPwwF2qFPFuRExVnRy9GQWvqb7D3b4KdQNNFl5XAI1RuUPN9hiAolozyN1l5JAJgxc1fy/ixqK1dJ3qGQwSBtA1E4phQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/E+wLam1fjJu+Ryf6lIYEDROYbIJAQn9hfFwNTora/Q=;
 b=d6U53lMWYesTZP8dvBb73n3HBNyMmejAdu12/5iJLfDFiFZTZ3ShdTnZxmAB222uYJKLQPOUwcLyYyGC6nUvBhR7RPC20+S1F118Bqd610DW5AS/GMNnGxYRKCLQlKaW5ZT8ZkEkg9ssaoCr1QiQl9ouvOSUDBm5rQhZifGCUt56nqDliWu+s3OAg5yah6Rrd0L8kPJzCA/ELq/4yl3d5rLkZWWyyfCHHdilN2N1/oVFAMqWqdXWzVWW+WHsvF43BlTQTdqqlHgWx6oCYdTZjZp6ZotyQGEL0ZIhxn4wDCh3sz7N7N8RQr+IfzitsX5k6P/SsAUP9SjsFgo7Xw7YnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/E+wLam1fjJu+Ryf6lIYEDROYbIJAQn9hfFwNTora/Q=;
 b=C5HhPCt/miIo49BjFj76Tm9F8rNNv9d7y7T3hVJfaJ4YGW2Op5YBSU4nB6R05LX89a2THdSZdNYuxo+E5I+sxBJXSzFOaY8dpn0hF1zYmkDm1s8/ywEyosP+51OepUjoEypsMgMW501uZOzBguIfcV9mum48ZOZS8GP9zOSwu8I=
Received: from SJ0PR03CA0382.namprd03.prod.outlook.com (2603:10b6:a03:3a1::27)
 by SJ0PR12MB6781.namprd12.prod.outlook.com (2603:10b6:a03:44b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Tue, 18 Feb
 2025 05:30:51 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::67) by SJ0PR03CA0382.outlook.office365.com
 (2603:10b6:a03:3a1::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.17 via Frontend Transport; Tue,
 18 Feb 2025 05:30:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 05:30:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Feb
 2025 23:30:49 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 17 Feb 2025 23:30:46 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <jingoohan1@gmail.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v12 1/3] dt-bindings: PCI: dwc: Add AMD Versal2 mdb slcr support
Date: Tue, 18 Feb 2025 11:00:37 +0530
Message-ID: <20250218053039.714208-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218053039.714208-1-thippeswamy.havalige@amd.com>
References: <20250218053039.714208-1-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: thippeswamy.havalige@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|SJ0PR12MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ca9eb96-741c-4826-ace2-08dd4fdd682c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?803LQ9ivTbdVUOSmoPny9Or7GeSRns2epn0g0bNYiivbCw5qp0JHt6PxhJat?=
 =?us-ascii?Q?Gc5zqlIk+0y3HyukZrsmexI/4RcBz2vk0j74W0EmaHcsbXTWYummomH3kkXh?=
 =?us-ascii?Q?iuhxksIfJBqTrtzYiimRw1ZaanEl4S//b61V3VozeMlb4TJ8/9tJNy5DQPUN?=
 =?us-ascii?Q?NbixqxTXzqL8xZ4dZa0NW83ofkcXD8v4XUfZzTaZ4W11V81QfMfmVaP5jEyz?=
 =?us-ascii?Q?pwYyDJRRUEUCqVXp5M1nZADaogRm4fyLCKCXpyyDlC1ftjYyNgLBLvcq2rUe?=
 =?us-ascii?Q?qhp2hCom/4PD+kQo85FJARLkR34KstOLbnyMNc79iF2X5gCDKqBmG7QHszVs?=
 =?us-ascii?Q?TxdAlZ2gK4HTWpRjUtEWvWFydPyx6BXAk1tkXj5qhzXask4094q2v4IO6ZrB?=
 =?us-ascii?Q?VybMmjM5Fddyy2PxXXZzY1Va5mNStmkfK5WyYPRJd+cev18HJVxkPzjuTm+b?=
 =?us-ascii?Q?RUyVIteb+WKXinvjYVQahG463doDJqm8KSH+uLG6LQ0xLkuX7khfcKBeDjsd?=
 =?us-ascii?Q?5QzeEYn5e/woFRhejUX0jTbKQrZ79KeD4hV/bbwfXngwHu2JpjT2BDJYYWBy?=
 =?us-ascii?Q?5xC2qjdWjLNZRpL1RjHbYuXRccvngp36vnzqPdboftwj6iTMkNCo8c9qnU8z?=
 =?us-ascii?Q?zEaT7SkGRyI/MDn8fVkJHgmWFTeFwWi05kylfGFd09Afhpmybnga1vtMldHN?=
 =?us-ascii?Q?xWgSM/R+MCjinuRMTG8PMBzioKxNMTbBcPHuIDuu5jl8/YcdcCMhmcTH6qfF?=
 =?us-ascii?Q?Q5D4D75/rXU2o4yfpuKiPfN0VFzeC7vdxLpurtGBbHpUVCBT1ytTE9/H5riH?=
 =?us-ascii?Q?J/HkMO4HsgC67urF70kpLESb2RSursH6RRnT7alYkeaZxVVmuHbsLtez3vNv?=
 =?us-ascii?Q?KWtZnuiXW+9AMYNELr/aX8I0E4X6wVBZMR/aEZrsIn9PaEtlps9vGAo3RYES?=
 =?us-ascii?Q?M7VU9kOT/GbBtTr2S3Tlr43cXaNautPkuDOrWwnKMaTg7ULPB+kI5wqF77wL?=
 =?us-ascii?Q?sPLrf7liUyoYPMUX2OGLxjPyNfo6vABIYT3e5D7NL1LG+6UG4c9X2A5T5h7r?=
 =?us-ascii?Q?b4ARXnlOQtmJf9YJh+DjOOPNT8wYHUw1Ambg59ISpYlIhbp8dUVZthzJ5jm2?=
 =?us-ascii?Q?yFesVpmeHRnNlATrNh4AmCTnTTszUjpI+GXUfvu7ueA/ZKqOF02IV6pPAHEn?=
 =?us-ascii?Q?3qKhrugW90s1+J2PuNdhDFcSRZgZj1Mscnl1QkTpO8ymW++xl6Ae+TbyazMI?=
 =?us-ascii?Q?Myh7H22iFu06z2vvF4X8CDMRNXb2MaqapZ+504yjzM0AVKlfMhGoVexouJhE?=
 =?us-ascii?Q?JQCc37/6BafyL5Tk1Ab/+9VPNfksyWMFJgkcn6XkbMviUiC1qAYFJhM8oUwP?=
 =?us-ascii?Q?OMMp1UyEPJTpF4Rh7IcMlLNTUqfCqTblzYbJwgdb+XSedN0gBvpXu1ZJOQuv?=
 =?us-ascii?Q?ZfjY5M96z4zroU4jFrm5OBWIyTlL9UNx2dO2q/CCdm3Hv01px6xMellT6cgY?=
 =?us-ascii?Q?oPGRlZua6RfUfMc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 05:30:50.9041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca9eb96-741c-4826-ace2-08dd4fdd682c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6781

Add support for mdb slcr aperture that is only supported for AMD Versal2
devices.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Changes in v3:
-------------
- Introduced below changes in dwc yaml schema.
Changes in v5:
-------------
- Modify mdb_pcie_slcr as constant.
Changes in v6:
-------------
-Modify slcr constant
Changes in v11:
-None
---
 Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index 205326fb2d75..fdecfe6ad5f1 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -113,6 +113,8 @@ properties:
               enum: [ smu, mpu ]
             - description: Tegra234 aperture
               enum: [ ecam ]
+            - description: AMD MDB PCIe slcr region
+              const: slcr
     allOf:
       - contains:
           const: dbi
-- 
2.43.0


