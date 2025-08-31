Return-Path: <linux-pci+bounces-35207-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0657B3D5EE
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 01:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61B81178112
	for <lists+linux-pci@lfdr.de>; Sun, 31 Aug 2025 23:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05BC278E63;
	Sun, 31 Aug 2025 23:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qHvrl2Eo"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5202270EDF;
	Sun, 31 Aug 2025 23:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756683189; cv=fail; b=t0lLVdwUKYcrziYZ2hpR75ZgpPI9jcMbfs26mbtv9Mtu0bd3HWT6JSuyjCLwFSse0ieQR5pbGn3BOGRShyU/ft812Ig1hZHHWTHOrIrWHiwiIIazJoMPBG78OM7qeU8VgJFV49G3ZkuiJ/rh4cwAZyVPtiUIQyFl901CjOpe9/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756683189; c=relaxed/simple;
	bh=spKs9lB5UZmvDxLWOT0ld3dY7fAYboJd1wHPG0Wq/xY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l+97gIBHrcW81M4YU3Z98ah05Tu1SmV1OpxexxeTqxNiLPQb8Gs0rqanBspHvqNTVu3y0zzFeXgdPyWR+uAlHhCuHUlWmSjGl5zTssa0GxLQizzAbd0aBwTaqsNLBkqTBtjV0AKhyqCWgbBy7S0aNL/5vDhT/l5/sT/Kx6+4yK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qHvrl2Eo; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TvDILzlxb5CTUsRVWb9lVoYt4DiHIje9gro6glNlxLIdotFs9b3TJVJ1vAIk9N2BDJpb11ztKFaEnZM+TpBf9tJMLSefpLfQ99oUoUNgydTMxMKt1Hyz2pySfvt22awClV3mKh31KwCbWRekMxkvR3oZei7WpA6BpRZZ0BtBVw/zFElVjL9AIevbzq25QlWl9PDK8jhDEMZF53IQaxtG2MDaZwcDrqnzq+Mv6r7tyu9ZyN+l8ac2OzZOqU/BuckvR4fBsJqUPRha7D5wAFXXu0KXhgR2zGxGeylUxYFxa4j+gNtxIPpkfAR9iqX2iDAn4uLRgVzAnAHH9lBMzCa7Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/aI4b7yzFWOkKzRJhP6UXSZl0AMe6oNZNZzBkdLTLI=;
 b=S14xx2sWVQTJOim0uQrNKrbISz4pmaZTAnRi9kDZBKvCmpUKJO9zpIq0gIfA/L2JRq5WqlRYWxEl17Re9jpHFWcfp++rd+dE0j3bqcbv6n+KPjXFseJYLA/FFAI3wdOzSfqTX9MruF9/ucWkDa9zVZG7sUrurBAONKhtlc2R7Z9uG5T5jTsjTWbP7VGg4L9IqWkSpcvkPC1W5cziUh/cXZGbhbjpYd0ZiR2wY0LL8fWHFZIDA1hQTrmGwErLL8vyVMkb0u/ipTjAHZqTGDjj909hHdpNXiStuF10HSGGoRj4sO8xWJ+puB3ymLqpgdE/nCkDratjJirBVNsd/659HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/aI4b7yzFWOkKzRJhP6UXSZl0AMe6oNZNZzBkdLTLI=;
 b=qHvrl2EoAz08fGgY8cuUNN71vlZUyYd9ZTkev1Cg46RP9Hnab7KkoveRaCjKpX+x7hiEYxzoDm6JNtlBBTpGS9/+Ug+nSytUlTAlZsYf06fVRU2OkEG+Q0QwftpBgzpIi50OCuJzZ0VlfMDnQfnDsSmcIABXUqLPGjR6pdJoxYD27jwmUBATTBOGm1zmzC2kB3qboL8ij2SZEQdbA8wDOPx5tkeZbwHzQfN0/geeAa27hPVpN4fooypT+/1POgPuC0wShgttNAoUO8bc+xxRlK9xhLRlcZW/Mv/rHSwB3rDm6c29MceGTdQq8+ixLFPBGQyZ86UFXxjpo7qw2CgvNg==
Received: from MN2PR16CA0041.namprd16.prod.outlook.com (2603:10b6:208:234::10)
 by DS0PR12MB7680.namprd12.prod.outlook.com (2603:10b6:8:11c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Sun, 31 Aug
 2025 23:32:58 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:234:cafe::7b) by MN2PR16CA0041.outlook.office365.com
 (2603:10b6:208:234::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.26 via Frontend Transport; Sun,
 31 Aug 2025 23:32:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Sun, 31 Aug 2025 23:32:56 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 31 Aug
 2025 16:32:37 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 31 Aug
 2025 16:32:36 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 31 Aug 2025 16:32:32 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, <jgg@nvidia.com>, <bhelgaas@google.com>
CC: <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <sven@kernel.org>, <j@jannau.net>,
	<alyssa@rosenzweig.io>, <neal@gompa.dev>, <robin.clark@oss.qualcomm.com>,
	<m.szyprowski@samsung.com>, <krzk@kernel.org>, <alim.akhtar@samsung.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<yong.wu@mediatek.com>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <tjeznach@rivosinc.com>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<alex@ghiti.fr>, <heiko@sntech.de>, <schnelle@linux.ibm.com>,
	<mjrosato@linux.ibm.com>, <gerald.schaefer@linux.ibm.com>,
	<orsonzhai@gmail.com>, <baolin.wang@linux.alibaba.com>,
	<zhang.lyra@gmail.com>, <wens@csie.org>, <jernej.skrabec@gmail.com>,
	<samuel@sholland.org>, <jean-philippe@linaro.org>, <rafael@kernel.org>,
	<lenb@kernel.org>, <yi.l.liu@intel.com>, <cwabbott0@gmail.com>,
	<quic_pbrahma@quicinc.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <asahi@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-samsung-soc@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>, <linux-rockchip@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, <linux-sunxi@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>, <virtualization@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<patches@lists.linux.dev>, <vsethi@nvidia.com>, <helgaas@kernel.org>,
	<etzhao1900@gmail.com>
Subject: [PATCH v4 4/7] iommu: Pass in old domain to attach_dev callback functions
Date: Sun, 31 Aug 2025 16:31:56 -0700
Message-ID: <19570f350d15528e13447168b7dcd95795afdbf3.1756682135.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756682135.git.nicolinc@nvidia.com>
References: <cover.1756682135.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|DS0PR12MB7680:EE_
X-MS-Office365-Filtering-Correlation-Id: 9134af2d-de0e-4934-14be-08dde8e6b6b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L644wAf5uXYq3+ZdbjBK4NjCKiG9j8h/1EPngdU4A21bdOTSmAO7Yi768WAp?=
 =?us-ascii?Q?rC0R/AK8J6AWcDE/LBLCDp0/e8NnTY9P2fU+ZoB+nlB7wg2L/OrFEMbn/Nbn?=
 =?us-ascii?Q?VQ4RV6T7wqeakQnZMWlrpsurTERieKCmj51CP3e/5uO25+RiqhGcrdKTBsuE?=
 =?us-ascii?Q?4qDh+DrsO8+sypY6fJQ4yJZUEYLDuCxF7Ds2vqWzdIzNOp1y+5FTp0bUGMvR?=
 =?us-ascii?Q?IZe4bvK/ngavscoL1/frDlF98RYzsDP93gOUHqMzxLe3B1Q3uO8fOX1ZqIMi?=
 =?us-ascii?Q?tDLo4e1nMNTZlR6M8tWpLMkV08ZRU2Ld1s6d+WyxVsbjqi1Frz2qR7aZH4xd?=
 =?us-ascii?Q?pBMjPg0+0lLcho/PSN4V5gpuQqE0HGoeEDx+S6xpqq++Coz470xY9Wxh0BKU?=
 =?us-ascii?Q?8O8wyj8i0bw5+I8b42CH8/aLarhnMp8ecGSkoBWlTsRfBwEknoesHz16d2oN?=
 =?us-ascii?Q?TplbM41fl/tnJn420zQCHzd2yi5lcvP4rSJiPPpdswQ1cEcBKAKhR8hnCNQp?=
 =?us-ascii?Q?pC6NsdYGrN1mE0HwRmd57yyzsk44i+RgIeGVhqYlhcSR/Aab0h36cX4+jeH1?=
 =?us-ascii?Q?YwhbHYhOI/e2cBQw2Slau4ccppBPkj+BewPwftQVdZ6lGYqAdd/SxYibAq1F?=
 =?us-ascii?Q?VOA5P2xw+UVe8pgb6dtXSHsPeAFqhgSOq1u3TJJLR84Ld+u2K0ZxcMA6rKkX?=
 =?us-ascii?Q?nUYSKAr07yvdmjYJTG/TEiANs5nN1fRKPJhpJxE0cCCD8OR1CzpuglgPA72O?=
 =?us-ascii?Q?6rFeYb2rY1qcVQJopoC2VYmDuJ0s+j4GB/suvjiSUNm9fr6ugMvdQA0+Iuuz?=
 =?us-ascii?Q?6TVdorXV+hBZqTP1q6MEY/eislO3tRNwCLwtSlNJbYXZA69Mp/pvn4alSFmg?=
 =?us-ascii?Q?E88xFSQqFCKDOMIZhh1WJ2tEzd2WAybYrr7ob0pC4Jp5kl+lVLHBa6YY/dIr?=
 =?us-ascii?Q?fF/0zA+r5n8MIZde31An7xMZJOrEszJyymtH4wr3hdYBEdpqT/y4C6AFFyNp?=
 =?us-ascii?Q?oE2eYKmRuOrhHrX3DJls8erjKxKl2p/0vvMsjfz/LDuruOGqqeVtscPQcwYm?=
 =?us-ascii?Q?wpsiPc/Eq4DN+wa/lnZ3754plBy6eMwHhKCrVJXq/4kXowNTZmYrVfs+LEAZ?=
 =?us-ascii?Q?7AY1eIJiYCU7HlT/clu9t0cJTzBtr8/RkNGrtAmTiTn1pvKUYWkYULcUiIBL?=
 =?us-ascii?Q?yOXAM14o5L5RchU2MiCuZp7MKyokbt26Cw5j5gaUsFKsx6mRfW1y+MvB2ZQZ?=
 =?us-ascii?Q?aTKjSJT9kOf376WS84c8Uv6LIA6OiebkiCPoY5jKm3xp8K95iYEfpgznNCKI?=
 =?us-ascii?Q?Yt63VJSuliFocD8pSeYF0mbeFxvT/RI8PWcB1xv9mzUA/fZAfM7ZyxnuGEfs?=
 =?us-ascii?Q?VUAOB1+FuS9idvdtQPQrzNKsTjW17vf4jck6vqsZAz1M0c4QR8kdgqBW9b5A?=
 =?us-ascii?Q?95Yr506FJnubNzLltK3+aPYcW/tTOpMfvYJDZdtlOwmgJNuciDgB/GQyICm4?=
 =?us-ascii?Q?bfNYJ6nOypqxs/THjUnGoZw8iDfk0BRORmwp?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 23:32:56.0246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9134af2d-de0e-4934-14be-08dde8e6b6b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7680

The IOMMU core attaches each device to a default domain on probe(). Then,
every new "attach" operation has a fundamental meaning of two-fold:
 - detach from its currently attached (old) domain
 - attach to a given new domain

Modern IOMMU drivers following this pattern usually want to clean up the
things related to the old domain, so they call iommu_get_domain_for_dev()
to fetch the old domain.

Pass in the old domain pointer from the core to drivers, aligning with the
set_dev_pasid op that passes in already.

Ensure all low-level attach fcuntions in the core can forward the correct
old domain pointer. Thus, rework those functions as well.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h                         |  3 +-
 drivers/iommu/amd/iommu.c                     | 11 ++++---
 drivers/iommu/apple-dart.c                    |  9 +++--
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  5 +--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 33 ++++++++++++-------
 drivers/iommu/arm/arm-smmu/arm-smmu.c         |  9 +++--
 drivers/iommu/arm/arm-smmu/qcom_iommu.c       | 11 ++++---
 drivers/iommu/exynos-iommu.c                  |  6 ++--
 drivers/iommu/fsl_pamu_domain.c               | 12 +++----
 drivers/iommu/intel/iommu.c                   | 10 ++++--
 drivers/iommu/intel/nested.c                  |  2 +-
 drivers/iommu/iommu.c                         | 26 +++++++++------
 drivers/iommu/iommufd/selftest.c              |  2 +-
 drivers/iommu/ipmmu-vmsa.c                    | 10 +++---
 drivers/iommu/msm_iommu.c                     |  8 ++---
 drivers/iommu/mtk_iommu.c                     |  8 ++---
 drivers/iommu/mtk_iommu_v1.c                  |  7 ++--
 drivers/iommu/omap-iommu.c                    | 12 +++----
 drivers/iommu/riscv/iommu.c                   |  9 +++--
 drivers/iommu/rockchip-iommu.c                | 20 ++++++++---
 drivers/iommu/s390-iommu.c                    |  9 +++--
 drivers/iommu/sprd-iommu.c                    |  3 +-
 drivers/iommu/sun50i-iommu.c                  |  8 +++--
 drivers/iommu/tegra-smmu.c                    | 10 +++---
 drivers/iommu/virtio-iommu.c                  |  6 ++--
 25 files changed, 152 insertions(+), 97 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c30d12e16473d..801b2bd9e8d49 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -751,7 +751,8 @@ struct iommu_ops {
  * @free: Release the domain after use.
  */
 struct iommu_domain_ops {
-	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
+	int (*attach_dev)(struct iommu_domain *domain, struct device *dev,
+			  struct iommu_domain *old);
 	int (*set_dev_pasid)(struct iommu_domain *domain, struct device *dev,
 			     ioasid_t pasid, struct iommu_domain *old);
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index eb348c63a8d09..8a18a3bfa5a2d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -69,8 +69,8 @@ int amd_iommu_max_glx_val = -1;
  */
 DEFINE_IDA(pdom_ids);
 
-static int amd_iommu_attach_device(struct iommu_domain *dom,
-				   struct device *dev);
+static int amd_iommu_attach_device(struct iommu_domain *dom, struct device *dev,
+				   struct iommu_domain *old);
 
 static void set_dte_entry(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data);
@@ -2634,7 +2634,8 @@ void amd_iommu_domain_free(struct iommu_domain *dom)
 }
 
 static int blocked_domain_attach_device(struct iommu_domain *domain,
-					struct device *dev)
+					struct device *dev,
+					struct iommu_domain *old)
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 
@@ -2692,8 +2693,8 @@ static struct iommu_domain release_domain = {
 	}
 };
 
-static int amd_iommu_attach_device(struct iommu_domain *dom,
-				   struct device *dev)
+static int amd_iommu_attach_device(struct iommu_domain *dom, struct device *dev,
+				   struct iommu_domain *old)
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	struct protection_domain *domain = to_pdomain(dom);
diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 190f28d766151..88648e051e783 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -660,7 +660,8 @@ static int apple_dart_domain_add_streams(struct apple_dart_domain *domain,
 }
 
 static int apple_dart_attach_dev_paging(struct iommu_domain *domain,
-					struct device *dev)
+					struct device *dev,
+					struct iommu_domain *old)
 {
 	int ret, i;
 	struct apple_dart_stream_map *stream_map;
@@ -681,7 +682,8 @@ static int apple_dart_attach_dev_paging(struct iommu_domain *domain,
 }
 
 static int apple_dart_attach_dev_identity(struct iommu_domain *domain,
-					  struct device *dev)
+					  struct device *dev,
+					  struct iommu_domain *old)
 {
 	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
 	struct apple_dart_stream_map *stream_map;
@@ -705,7 +707,8 @@ static struct iommu_domain apple_dart_identity_domain = {
 };
 
 static int apple_dart_attach_dev_blocked(struct iommu_domain *domain,
-					 struct device *dev)
+					 struct device *dev,
+					 struct iommu_domain *old)
 {
 	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
 	struct apple_dart_stream_map *stream_map;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 8cd8929bbfdf8..313201a616991 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -138,14 +138,15 @@ void arm_smmu_master_clear_vmaster(struct arm_smmu_master *master)
 }
 
 static int arm_smmu_attach_dev_nested(struct iommu_domain *domain,
-				      struct device *dev)
+				      struct device *dev,
+				      struct iommu_domain *old_domain)
 {
 	struct arm_smmu_nested_domain *nested_domain =
 		to_smmu_nested_domain(domain);
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct arm_smmu_attach_state state = {
 		.master = master,
-		.old_domain = iommu_get_domain_for_dev(dev),
+		.old_domain = old_domain,
 		.ssid = IOMMU_NO_PASID,
 	};
 	struct arm_smmu_ste ste;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 1a21d1a2dd454..de02eeb524c15 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3002,7 +3002,8 @@ void arm_smmu_attach_commit(struct arm_smmu_attach_state *state)
 	arm_smmu_remove_master_domain(master, state->old_domain, state->ssid);
 }
 
-static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
+static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev,
+			       struct iommu_domain *old_domain)
 {
 	int ret = 0;
 	struct arm_smmu_ste target;
@@ -3010,7 +3011,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_attach_state state = {
-		.old_domain = iommu_get_domain_for_dev(dev),
+		.old_domain = old_domain,
 		.ssid = IOMMU_NO_PASID,
 	};
 	struct arm_smmu_master *master;
@@ -3186,7 +3187,7 @@ static int arm_smmu_blocking_set_dev_pasid(struct iommu_domain *new_domain,
 
 	/*
 	 * When the last user of the CD table goes away downgrade the STE back
-	 * to a non-cd_table one.
+	 * to a non-cd_table one, by re-attaching its sid_domain.
 	 */
 	if (!arm_smmu_ssids_in_use(&master->cd_table)) {
 		struct iommu_domain *sid_domain =
@@ -3194,12 +3195,14 @@ static int arm_smmu_blocking_set_dev_pasid(struct iommu_domain *new_domain,
 
 		if (sid_domain->type == IOMMU_DOMAIN_IDENTITY ||
 		    sid_domain->type == IOMMU_DOMAIN_BLOCKED)
-			sid_domain->ops->attach_dev(sid_domain, dev);
+			sid_domain->ops->attach_dev(sid_domain, dev,
+						    sid_domain);
 	}
 	return 0;
 }
 
 static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
+				    struct iommu_domain *old_domain,
 				    struct device *dev,
 				    struct arm_smmu_ste *ste,
 				    unsigned int s1dss)
@@ -3207,7 +3210,7 @@ static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct arm_smmu_attach_state state = {
 		.master = master,
-		.old_domain = iommu_get_domain_for_dev(dev),
+		.old_domain = old_domain,
 		.ssid = IOMMU_NO_PASID,
 	};
 
@@ -3248,14 +3251,16 @@ static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
 }
 
 static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
-					struct device *dev)
+					struct device *dev,
+					struct iommu_domain *old_domain)
 {
 	struct arm_smmu_ste ste;
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 
 	arm_smmu_master_clear_vmaster(master);
 	arm_smmu_make_bypass_ste(master->smmu, &ste);
-	arm_smmu_attach_dev_ste(domain, dev, &ste, STRTAB_STE_1_S1DSS_BYPASS);
+	arm_smmu_attach_dev_ste(domain, old_domain, dev, &ste,
+				STRTAB_STE_1_S1DSS_BYPASS);
 	return 0;
 }
 
@@ -3269,14 +3274,15 @@ static struct iommu_domain arm_smmu_identity_domain = {
 };
 
 static int arm_smmu_attach_dev_blocked(struct iommu_domain *domain,
-					struct device *dev)
+				       struct device *dev,
+				       struct iommu_domain *old_domain)
 {
 	struct arm_smmu_ste ste;
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 
 	arm_smmu_master_clear_vmaster(master);
 	arm_smmu_make_abort_ste(&ste);
-	arm_smmu_attach_dev_ste(domain, dev, &ste,
+	arm_smmu_attach_dev_ste(domain, old_domain, dev, &ste,
 				STRTAB_STE_1_S1DSS_TERMINATE);
 	return 0;
 }
@@ -3292,7 +3298,8 @@ static struct iommu_domain arm_smmu_blocked_domain = {
 };
 
 static int arm_smmu_attach_dev_release(struct iommu_domain *domain,
-				       struct device *dev)
+				       struct device *dev,
+				       struct iommu_domain *old_domain)
 {
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 
@@ -3300,9 +3307,11 @@ static int arm_smmu_attach_dev_release(struct iommu_domain *domain,
 
 	/* Put the STE back to what arm_smmu_init_strtab() sets */
 	if (dev->iommu->require_direct)
-		arm_smmu_attach_dev_identity(&arm_smmu_identity_domain, dev);
+		arm_smmu_attach_dev_identity(&arm_smmu_identity_domain, dev,
+					     old_domain);
 	else
-		arm_smmu_attach_dev_blocked(&arm_smmu_blocked_domain, dev);
+		arm_smmu_attach_dev_blocked(&arm_smmu_blocked_domain, dev,
+					    old_domain);
 
 	return 0;
 }
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 4ced4b5bee4df..5e690cf85ec96 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1165,7 +1165,8 @@ static void arm_smmu_master_install_s2crs(struct arm_smmu_master_cfg *cfg,
 	}
 }
 
-static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
+static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev,
+			       struct iommu_domain *old)
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
@@ -1234,7 +1235,8 @@ static int arm_smmu_attach_dev_type(struct device *dev,
 }
 
 static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
-					struct device *dev)
+					struct device *dev,
+					struct iommu_domain *old)
 {
 	return arm_smmu_attach_dev_type(dev, S2CR_TYPE_BYPASS);
 }
@@ -1249,7 +1251,8 @@ static struct iommu_domain arm_smmu_identity_domain = {
 };
 
 static int arm_smmu_attach_dev_blocked(struct iommu_domain *domain,
-				       struct device *dev)
+				       struct device *dev,
+				       struct iommu_domain *old)
 {
 	return arm_smmu_attach_dev_type(dev, S2CR_TYPE_FAULT);
 }
diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index c5be95e560317..9222a4a48bb33 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -359,7 +359,8 @@ static void qcom_iommu_domain_free(struct iommu_domain *domain)
 	kfree(qcom_domain);
 }
 
-static int qcom_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
+static int qcom_iommu_attach_dev(struct iommu_domain *domain,
+				 struct device *dev, struct iommu_domain *old)
 {
 	struct qcom_iommu_dev *qcom_iommu = dev_iommu_priv_get(dev);
 	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
@@ -388,18 +389,18 @@ static int qcom_iommu_attach_dev(struct iommu_domain *domain, struct device *dev
 }
 
 static int qcom_iommu_identity_attach(struct iommu_domain *identity_domain,
-				      struct device *dev)
+				      struct device *dev,
+				      struct iommu_domain *old)
 {
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 	struct qcom_iommu_domain *qcom_domain;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct qcom_iommu_dev *qcom_iommu = dev_iommu_priv_get(dev);
 	unsigned int i;
 
-	if (domain == identity_domain || !domain)
+	if (old == identity_domain || !old)
 		return 0;
 
-	qcom_domain = to_qcom_iommu_domain(domain);
+	qcom_domain = to_qcom_iommu_domain(old);
 	if (WARN_ON(!qcom_domain->iommu))
 		return -EINVAL;
 
diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index b6edd178fe25e..b30d2bb87fa96 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -984,7 +984,8 @@ static void exynos_iommu_domain_free(struct iommu_domain *iommu_domain)
 }
 
 static int exynos_iommu_identity_attach(struct iommu_domain *identity_domain,
-					struct device *dev)
+					struct device *dev,
+					struct iommu_domain *old)
 {
 	struct exynos_iommu_owner *owner = dev_iommu_priv_get(dev);
 	struct exynos_iommu_domain *domain;
@@ -1035,7 +1036,8 @@ static struct iommu_domain exynos_identity_domain = {
 };
 
 static int exynos_iommu_attach_device(struct iommu_domain *iommu_domain,
-				   struct device *dev)
+				      struct device *dev,
+				      struct iommu_domain *old)
 {
 	struct exynos_iommu_domain *domain = to_exynos_domain(iommu_domain);
 	struct exynos_iommu_owner *owner = dev_iommu_priv_get(dev);
diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 5f08523f97cb9..9664ef9840d2c 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -238,7 +238,7 @@ static int update_domain_stash(struct fsl_dma_domain *dma_domain, u32 val)
 }
 
 static int fsl_pamu_attach_device(struct iommu_domain *domain,
-				  struct device *dev)
+				  struct device *dev, struct iommu_domain *old)
 {
 	struct fsl_dma_domain *dma_domain = to_fsl_dma_domain(domain);
 	unsigned long flags;
@@ -298,9 +298,9 @@ static int fsl_pamu_attach_device(struct iommu_domain *domain,
  * switches to what looks like BLOCKING.
  */
 static int fsl_pamu_platform_attach(struct iommu_domain *platform_domain,
-				    struct device *dev)
+				    struct device *dev,
+				    struct iommu_domain *old)
 {
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 	struct fsl_dma_domain *dma_domain;
 	const u32 *prop;
 	int len;
@@ -311,11 +311,11 @@ static int fsl_pamu_platform_attach(struct iommu_domain *platform_domain,
 	 * Hack to keep things working as they always have, only leaving an
 	 * UNMANAGED domain makes it BLOCKING.
 	 */
-	if (domain == platform_domain || !domain ||
-	    domain->type != IOMMU_DOMAIN_UNMANAGED)
+	if (old == platform_domain || !old ||
+	    old->type != IOMMU_DOMAIN_UNMANAGED)
 		return 0;
 
-	dma_domain = to_fsl_dma_domain(domain);
+	dma_domain = to_fsl_dma_domain(old);
 
 	/*
 	 * Use LIODN of the PCI controller while detaching a
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9c3ab9d9f69a3..e9fbe9f6cc6cd 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3225,7 +3225,8 @@ void device_block_translation(struct device *dev)
 }
 
 static int blocking_domain_attach_dev(struct iommu_domain *domain,
-				      struct device *dev)
+				      struct device *dev,
+				      struct iommu_domain *old)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 
@@ -3532,7 +3533,8 @@ int paging_domain_compatible(struct iommu_domain *domain, struct device *dev)
 }
 
 static int intel_iommu_attach_device(struct iommu_domain *domain,
-				     struct device *dev)
+				     struct device *dev,
+				     struct iommu_domain *old)
 {
 	int ret;
 
@@ -4396,7 +4398,9 @@ static int device_setup_pass_through(struct device *dev)
 				      context_setup_pass_through_cb, dev);
 }
 
-static int identity_domain_attach_dev(struct iommu_domain *domain, struct device *dev)
+static int identity_domain_attach_dev(struct iommu_domain *domain,
+				      struct device *dev,
+				      struct iommu_domain *old)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index 1b6ad9c900a5a..760d7aa2ade84 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -19,7 +19,7 @@
 #include "pasid.h"
 
 static int intel_nested_attach_dev(struct iommu_domain *domain,
-				   struct device *dev)
+				   struct device *dev, struct iommu_domain *old)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e6a66dacce1b8..ef3fd7bd1b553 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -100,7 +100,7 @@ static int iommu_bus_notifier(struct notifier_block *nb,
 			      unsigned long action, void *data);
 static void iommu_release_device(struct device *dev);
 static int __iommu_attach_device(struct iommu_domain *domain,
-				 struct device *dev);
+				 struct device *dev, struct iommu_domain *old);
 static int __iommu_attach_group(struct iommu_domain *domain,
 				struct iommu_group *group);
 static struct iommu_domain *__iommu_paging_domain_alloc_flags(struct device *dev,
@@ -114,6 +114,7 @@ enum {
 static int __iommu_device_set_domain(struct iommu_group *group,
 				     struct group_device *gdev,
 				     struct iommu_domain *new_domain,
+				     struct iommu_domain *old_domain,
 				     unsigned int flags);
 static int __iommu_group_set_domain_internal(struct iommu_group *group,
 					     struct iommu_domain *new_domain,
@@ -517,7 +518,8 @@ static void iommu_deinit_device(struct device *dev)
 	 * should still avoid touching any hardware configuration either.
 	 */
 	if (!dev->iommu->attach_deferred && ops->release_domain)
-		ops->release_domain->ops->attach_dev(ops->release_domain, dev);
+		ops->release_domain->ops->attach_dev(ops->release_domain, dev,
+						     group->domain);
 
 	if (ops->release_device)
 		ops->release_device(dev);
@@ -602,7 +604,8 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	if (group->default_domain)
 		iommu_create_device_direct_mappings(group->default_domain, dev);
 	if (group->domain) {
-		ret = __iommu_device_set_domain(group, gdev, group->domain, 0);
+		ret = __iommu_device_set_domain(group, gdev, group->domain,
+						NULL, 0);
 		if (ret)
 			goto err_remove_gdev;
 	} else if (!group->default_domain && !group_list) {
@@ -2089,14 +2092,14 @@ static void __iommu_group_set_core_domain(struct iommu_group *group)
 }
 
 static int __iommu_attach_device(struct iommu_domain *domain,
-				 struct device *dev)
+				 struct device *dev, struct iommu_domain *old)
 {
 	int ret;
 
 	if (unlikely(domain->ops->attach_dev == NULL))
 		return -ENODEV;
 
-	ret = domain->ops->attach_dev(domain, dev);
+	ret = domain->ops->attach_dev(domain, dev, old);
 	if (ret)
 		return ret;
 	dev->iommu->attach_deferred = 0;
@@ -2154,7 +2157,7 @@ int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 
 	guard(mutex)(&dev->iommu_group->mutex);
 
-	return __iommu_attach_device(domain, dev);
+	return __iommu_attach_device(domain, dev, NULL);
 }
 
 void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
@@ -2265,6 +2268,7 @@ EXPORT_SYMBOL_GPL(iommu_attach_group);
 static int __iommu_device_set_domain(struct iommu_group *group,
 				     struct group_device *gdev,
 				     struct iommu_domain *new_domain,
+				     struct iommu_domain *old_domain,
 				     unsigned int flags)
 {
 	struct device *dev = gdev->dev;
@@ -2291,7 +2295,7 @@ static int __iommu_device_set_domain(struct iommu_group *group,
 		dev->iommu->attach_deferred = 0;
 	}
 
-	ret = __iommu_attach_device(new_domain, dev);
+	ret = __iommu_attach_device(new_domain, dev, old_domain);
 	if (ret) {
 		/*
 		 * If we have a blocking domain then try to attach that in hopes
@@ -2301,7 +2305,8 @@ static int __iommu_device_set_domain(struct iommu_group *group,
 		if ((flags & IOMMU_SET_DOMAIN_MUST_SUCCEED) &&
 		    group->blocking_domain &&
 		    group->blocking_domain != new_domain)
-			__iommu_attach_device(group->blocking_domain, dev);
+			__iommu_attach_device(group->blocking_domain, dev,
+					      old_domain);
 		return ret;
 	}
 	return 0;
@@ -2347,7 +2352,8 @@ static int __iommu_group_set_domain_internal(struct iommu_group *group,
 	 */
 	result = 0;
 	for_each_group_device(group, gdev) {
-		ret = __iommu_device_set_domain(group, gdev, new_domain, flags);
+		ret = __iommu_device_set_domain(group, gdev, new_domain,
+						group->domain, flags);
 		if (ret) {
 			result = ret;
 			/*
@@ -2379,7 +2385,7 @@ static int __iommu_group_set_domain_internal(struct iommu_group *group,
 		 */
 		if (group->domain)
 			WARN_ON(__iommu_device_set_domain(
-				group, gdev, group->domain,
+				group, gdev, group->domain, new_domain,
 				IOMMU_SET_DOMAIN_MUST_SUCCEED));
 		if (gdev == last_gdev)
 			break;
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 61686603c7693..fa4359bb15e84 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -216,7 +216,7 @@ static inline struct selftest_obj *to_selftest_obj(struct iommufd_object *obj)
 }
 
 static int mock_domain_nop_attach(struct iommu_domain *domain,
-				  struct device *dev)
+				  struct device *dev, struct iommu_domain *old)
 {
 	struct mock_dev *mdev = to_mock_dev(dev);
 	struct mock_viommu *new_viommu = NULL;
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index ffa892f657140..6667ecc331f01 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -590,7 +590,7 @@ static void ipmmu_domain_free(struct iommu_domain *io_domain)
 }
 
 static int ipmmu_attach_device(struct iommu_domain *io_domain,
-			       struct device *dev)
+			       struct device *dev, struct iommu_domain *old)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
@@ -637,17 +637,17 @@ static int ipmmu_attach_device(struct iommu_domain *io_domain,
 }
 
 static int ipmmu_iommu_identity_attach(struct iommu_domain *identity_domain,
-				       struct device *dev)
+				       struct device *dev,
+				       struct iommu_domain *old)
 {
-	struct iommu_domain *io_domain = iommu_get_domain_for_dev(dev);
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct ipmmu_vmsa_domain *domain;
 	unsigned int i;
 
-	if (io_domain == identity_domain || !io_domain)
+	if (old == identity_domain || !old)
 		return 0;
 
-	domain = to_vmsa_domain(io_domain);
+	domain = to_vmsa_domain(old);
 	for (i = 0; i < fwspec->num_ids; ++i)
 		ipmmu_utlb_disable(domain, fwspec->ids[i]);
 
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 43a61ba021a51..2629fbd0606d3 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -441,19 +441,19 @@ static int msm_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 }
 
 static int msm_iommu_identity_attach(struct iommu_domain *identity_domain,
-				     struct device *dev)
+				     struct device *dev,
+				     struct iommu_domain *old)
 {
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 	struct msm_priv *priv;
 	unsigned long flags;
 	struct msm_iommu_dev *iommu;
 	struct msm_iommu_ctx_dev *master;
 	int ret = 0;
 
-	if (domain == identity_domain || !domain)
+	if (old == identity_domain || !old)
 		return 0;
 
-	priv = to_msm_priv(domain);
+	priv = to_msm_priv(old);
 	free_io_pgtable_ops(priv->iop);
 
 	spin_lock_irqsave(&msm_iommu_lock, flags);
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 0e0285348d2b8..9747ef1644138 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -705,7 +705,7 @@ static void mtk_iommu_domain_free(struct iommu_domain *domain)
 }
 
 static int mtk_iommu_attach_device(struct iommu_domain *domain,
-				   struct device *dev)
+				   struct device *dev, struct iommu_domain *old)
 {
 	struct mtk_iommu_data *data = dev_iommu_priv_get(dev), *frstdata;
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
@@ -773,12 +773,12 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 }
 
 static int mtk_iommu_identity_attach(struct iommu_domain *identity_domain,
-				     struct device *dev)
+				     struct device *dev,
+				     struct iommu_domain *old)
 {
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
 
-	if (domain == identity_domain || !domain)
+	if (old == identity_domain || !old)
 		return 0;
 
 	mtk_iommu_config(data, dev, false, 0);
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 10cc0b1197e80..3b45650263ac3 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -303,7 +303,9 @@ static void mtk_iommu_v1_domain_free(struct iommu_domain *domain)
 	kfree(to_mtk_domain(domain));
 }
 
-static int mtk_iommu_v1_attach_device(struct iommu_domain *domain, struct device *dev)
+static int mtk_iommu_v1_attach_device(struct iommu_domain *domain,
+				      struct device *dev,
+				      struct iommu_domain *old)
 {
 	struct mtk_iommu_v1_data *data = dev_iommu_priv_get(dev);
 	struct mtk_iommu_v1_domain *dom = to_mtk_domain(domain);
@@ -329,7 +331,8 @@ static int mtk_iommu_v1_attach_device(struct iommu_domain *domain, struct device
 }
 
 static int mtk_iommu_v1_identity_attach(struct iommu_domain *identity_domain,
-					struct device *dev)
+					struct device *dev,
+					struct iommu_domain *old)
 {
 	struct mtk_iommu_v1_data *data = dev_iommu_priv_get(dev);
 
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 6fb93927bdb98..a38f69debac09 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1431,8 +1431,8 @@ static void omap_iommu_detach_fini(struct omap_iommu_domain *odomain)
 	odomain->iommus = NULL;
 }
 
-static int
-omap_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
+static int omap_iommu_attach_dev(struct iommu_domain *domain,
+				 struct device *dev, struct iommu_domain *old)
 {
 	struct omap_iommu_arch_data *arch_data = dev_iommu_priv_get(dev);
 	struct omap_iommu_domain *omap_domain = to_omap_domain(domain);
@@ -1536,15 +1536,15 @@ static void _omap_iommu_detach_dev(struct omap_iommu_domain *omap_domain,
 }
 
 static int omap_iommu_identity_attach(struct iommu_domain *identity_domain,
-				      struct device *dev)
+				      struct device *dev,
+				      struct iommu_domain *old)
 {
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 	struct omap_iommu_domain *omap_domain;
 
-	if (domain == identity_domain || !domain)
+	if (old == identity_domain || !old)
 		return 0;
 
-	omap_domain = to_omap_domain(domain);
+	omap_domain = to_omap_domain(old);
 	spin_lock(&omap_domain->lock);
 	_omap_iommu_detach_dev(omap_domain, dev);
 	spin_unlock(&omap_domain->lock);
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 2d0d31ba28860..9c58413ad641e 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1319,7 +1319,8 @@ static bool riscv_iommu_pt_supported(struct riscv_iommu_device *iommu, int pgd_m
 }
 
 static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
-					    struct device *dev)
+					    struct device *dev,
+					    struct iommu_domain *old)
 {
 	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
@@ -1424,7 +1425,8 @@ static struct iommu_domain *riscv_iommu_alloc_paging_domain(struct device *dev)
 }
 
 static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
-					      struct device *dev)
+					      struct device *dev,
+					      struct iommu_domain *old)
 {
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
@@ -1445,7 +1447,8 @@ static struct iommu_domain riscv_iommu_blocking_domain = {
 };
 
 static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
-					      struct device *dev)
+					      struct device *dev,
+					      struct iommu_domain *old)
 {
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 0861dd469bd86..85f3667e797c3 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -960,7 +960,8 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
 }
 
 static int rk_iommu_identity_attach(struct iommu_domain *identity_domain,
-				    struct device *dev)
+				    struct device *dev,
+				    struct iommu_domain *old)
 {
 	struct rk_iommu *iommu;
 	struct rk_iommu_domain *rk_domain;
@@ -1005,7 +1006,7 @@ static struct iommu_domain rk_identity_domain = {
 };
 
 static int rk_iommu_attach_device(struct iommu_domain *domain,
-		struct device *dev)
+				  struct device *dev, struct iommu_domain *old)
 {
 	struct rk_iommu *iommu;
 	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
@@ -1026,7 +1027,7 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 	if (iommu->domain == domain)
 		return 0;
 
-	ret = rk_iommu_identity_attach(&rk_identity_domain, dev);
+	ret = rk_iommu_identity_attach(&rk_identity_domain, dev, old);
 	if (ret)
 		return ret;
 
@@ -1041,8 +1042,17 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 		return 0;
 
 	ret = rk_iommu_enable(iommu);
-	if (ret)
-		WARN_ON(rk_iommu_identity_attach(&rk_identity_domain, dev));
+	if (ret) {
+		/*
+		 * Note rk_iommu_identity_attach() might fail before physically
+		 * attaching the dev to iommu->domain, in which case the actual
+		 * old domain for this revert should be rk_identity_domain v.s.
+		 * iommu->domain. Since rk_iommu_identity_attach() does not care
+		 * about the old domain argument for now, this is not a problem.
+		 */
+		WARN_ON(rk_iommu_identity_attach(&rk_identity_domain, dev,
+						 iommu->domain));
+	}
 
 	pm_runtime_put(iommu->dev);
 
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 9c80d61deb2c0..f2f58bb21720b 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -653,7 +653,8 @@ int zpci_iommu_register_ioat(struct zpci_dev *zdev, u8 *status)
 }
 
 static int blocking_domain_attach_device(struct iommu_domain *domain,
-					 struct device *dev)
+					 struct device *dev,
+					 struct iommu_domain *old)
 {
 	struct zpci_dev *zdev = to_zpci_dev(dev);
 	struct s390_domain *s390_domain;
@@ -677,7 +678,8 @@ static int blocking_domain_attach_device(struct iommu_domain *domain,
 }
 
 static int s390_iommu_attach_device(struct iommu_domain *domain,
-				    struct device *dev)
+				    struct device *dev,
+				    struct iommu_domain *old)
 {
 	struct s390_domain *s390_domain = to_s390_domain(domain);
 	struct zpci_dev *zdev = to_zpci_dev(dev);
@@ -1113,7 +1115,8 @@ static int __init s390_iommu_init(void)
 subsys_initcall(s390_iommu_init);
 
 static int s390_attach_dev_identity(struct iommu_domain *domain,
-				    struct device *dev)
+				    struct device *dev,
+				    struct iommu_domain *old)
 {
 	struct zpci_dev *zdev = to_zpci_dev(dev);
 	u8 status;
diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index c7ca1d8a0b153..555d4505c747a 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -247,7 +247,8 @@ static void sprd_iommu_domain_free(struct iommu_domain *domain)
 }
 
 static int sprd_iommu_attach_device(struct iommu_domain *domain,
-				    struct device *dev)
+				    struct device *dev,
+				    struct iommu_domain *old)
 {
 	struct sprd_iommu_device *sdev = dev_iommu_priv_get(dev);
 	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index de10b569d9a94..d3b190be18b5a 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -771,7 +771,8 @@ static void sun50i_iommu_detach_domain(struct sun50i_iommu *iommu,
 }
 
 static int sun50i_iommu_identity_attach(struct iommu_domain *identity_domain,
-					struct device *dev)
+					struct device *dev,
+					struct iommu_domain *old)
 {
 	struct sun50i_iommu *iommu = dev_iommu_priv_get(dev);
 	struct sun50i_iommu_domain *sun50i_domain;
@@ -797,7 +798,8 @@ static struct iommu_domain sun50i_iommu_identity_domain = {
 };
 
 static int sun50i_iommu_attach_device(struct iommu_domain *domain,
-				      struct device *dev)
+				      struct device *dev,
+				      struct iommu_domain *old)
 {
 	struct sun50i_iommu_domain *sun50i_domain = to_sun50i_domain(domain);
 	struct sun50i_iommu *iommu;
@@ -813,7 +815,7 @@ static int sun50i_iommu_attach_device(struct iommu_domain *domain,
 	if (iommu->domain == domain)
 		return 0;
 
-	sun50i_iommu_identity_attach(&sun50i_iommu_identity_domain, dev);
+	sun50i_iommu_identity_attach(&sun50i_iommu_identity_domain, dev, old);
 
 	sun50i_iommu_attach_domain(iommu, sun50i_domain);
 
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 36cdd5fbab077..336e0a3ff41fb 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -490,7 +490,7 @@ static void tegra_smmu_as_unprepare(struct tegra_smmu *smmu,
 }
 
 static int tegra_smmu_attach_dev(struct iommu_domain *domain,
-				 struct device *dev)
+				 struct device *dev, struct iommu_domain *old)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct tegra_smmu *smmu = dev_iommu_priv_get(dev);
@@ -524,9 +524,9 @@ static int tegra_smmu_attach_dev(struct iommu_domain *domain,
 }
 
 static int tegra_smmu_identity_attach(struct iommu_domain *identity_domain,
-				      struct device *dev)
+				      struct device *dev,
+				      struct iommu_domain *old)
 {
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct tegra_smmu_as *as;
 	struct tegra_smmu *smmu;
@@ -535,10 +535,10 @@ static int tegra_smmu_identity_attach(struct iommu_domain *identity_domain,
 	if (!fwspec)
 		return -ENODEV;
 
-	if (domain == identity_domain || !domain)
+	if (old == identity_domain || !old)
 		return 0;
 
-	as = to_smmu_as(domain);
+	as = to_smmu_as(old);
 	smmu = as->smmu;
 	for (index = 0; index < fwspec->num_ids; index++) {
 		tegra_smmu_disable(smmu, fwspec->ids[index], as->id);
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 532db1de201ba..bd1af8a77005f 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -730,7 +730,8 @@ static struct iommu_domain *viommu_domain_alloc_identity(struct device *dev)
 	return domain;
 }
 
-static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
+static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev,
+			     struct iommu_domain *old)
 {
 	int ret = 0;
 	struct virtio_iommu_req_attach req;
@@ -781,7 +782,8 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 }
 
 static int viommu_attach_identity_domain(struct iommu_domain *domain,
-					 struct device *dev)
+					 struct device *dev,
+					 struct iommu_domain *old)
 {
 	int ret = 0;
 	struct virtio_iommu_req_attach req;
-- 
2.43.0


