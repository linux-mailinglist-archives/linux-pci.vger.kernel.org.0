Return-Path: <linux-pci+bounces-33800-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65812B218D2
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 01:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65AFF1A22ECB
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 23:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C3A204C0C;
	Mon, 11 Aug 2025 23:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r+8Ut49f"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82DA227586;
	Mon, 11 Aug 2025 23:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754953228; cv=fail; b=PkYwfEOySb4Pxa+DJUBA3kplPoFoxedwtBV8X+da7OEB18UYr5N3x6N9hFUL9hgCgXdipLXlEQwIj3QHUwixFlY2dyJxZsIdnGl8mPbgC7JcM2ptKersvhsFx9pN6kjP82xihaX/wWs/jgJlwyR+Gx8mKczql/qVYtNz/YWfRDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754953228; c=relaxed/simple;
	bh=FjuAMDyLkFu9FIRu3qXEUlj9aJDOj2wuyJIl1GbSZBQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Oi+Lfd5OBZNS7VqUt1gi7fe16lPHKfYKDoVSR9EL6xv40UANQ8Y+tXx+V2J0Io5PLe/HjvvHO/CM6c4bmsvxBeGYgA6U8TbfoL55Z8YqSxasPWEEKGboP8tyvwflsCA5ptLWKQIpSCQy0hSWp327/9quZxSD1iNStDvYoJ1IrXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r+8Ut49f; arc=fail smtp.client-ip=40.107.220.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j41oAOiY5P3oM/kzVq6U3f9B7BIG0pBJYgT717C6wbLC4ifgdLlCoj/c11Qyv13PB9sDtBwRjdaM8KuRf+PvBDvq4+bSmKCppe1OdRtNa1i3N4UJ9kDbjmGtNH/MdvXi87OLEYd0WIskPMHFkyXTR2KUUCNKXY6hqrLfiNiOmvfpkbZf5a6DxwXMqToXFJYCXGpS+N0yLcSW+dFmatO0eRMdsVLF81Ua/vpBeZlifOlgMTnQ89vU4yU4D9I6uFZNvk15tCj/AOxqWPOerZKbXYx1ah0MBjtmmfAezSYyruByWWh+6J5ypAt+yhQd4mYgfJIUtS1IV9NOC0+ijIlvJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAwe8+dNaMELmcdQi4G85paLJefvggmjozBKCxM0pJM=;
 b=CoxMzq9npNisuiYN7TUmRVMoyym3fhAtLTFt4VTV13pbIXOwq9RKp3K5/x3+XdiaTtFr4EmhM0mjvE6/Z+pTO7UqEdElEJdzMeAMe6l/g1z7q/VqVtMaQTgiCcqUarJKXyOKJ535t0x1x9qWaZjAczMJmq85djMEbpTIk3DL5Psc86j/bDM5xNzxVCpcR6Jkc2Ht1LNE8GLnb1xesK94V+fE+wgXsnrQtJIAttG8wgcUHG3/KcQUwOU6+D//Zeq/DSim53i7IGHOvZPuTDy+rCjrCcAgnZYb97qk6Y+ffJziAghDRDiA4hFbOPK4jsIOzS+qcUWgrzadm9rMJutNIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAwe8+dNaMELmcdQi4G85paLJefvggmjozBKCxM0pJM=;
 b=r+8Ut49fYKURps5cVBTLC3TMHe9P084iBOTRsKahHJrncqO4HMRlqHR4PrgxYHRlNYtSHacnDP5luv6fiDgOWVym95il7KHY60rKa34MIKuRaJZFvyGXToE4kOrP6Nf9mdzIc0J2EbaOyiqAgepC5u7jw/t7AVexcKpHnTV8nfPDpUhVjmGVZY75P4H7s1teqqH8jx13HCNYwdbw/GDPw+zj+ys5yiNV7Rz4hRB2FeXlqJ8v/9x+/xaKtKIE5mtfYXTecyGvMo4jtm4uyfJ4M89WODXYV/ia3JbrVgn+Xdd3Ex1SEHpdLtmOisFnBXFEBg/hHis5xzPtr15x9/PShQ==
Received: from BN8PR07CA0033.namprd07.prod.outlook.com (2603:10b6:408:ac::46)
 by MW4PR12MB5668.namprd12.prod.outlook.com (2603:10b6:303:16b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Mon, 11 Aug
 2025 23:00:22 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:408:ac:cafe::ca) by BN8PR07CA0033.outlook.office365.com
 (2603:10b6:408:ac::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.21 via Frontend Transport; Mon,
 11 Aug 2025 23:00:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 23:00:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 11 Aug
 2025 16:00:04 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 11 Aug
 2025 16:00:03 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 11 Aug 2025 16:00:02 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <robin.murphy@arm.com>, <joro@8bytes.org>, <bhelgaas@google.com>,
	<jgg@nvidia.com>
CC: <will@kernel.org>, <robin.clark@oss.qualcomm.com>, <yong.wu@mediatek.com>,
	<matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <kevin.tian@intel.com>,
	<yi.l.liu@intel.com>, <baolu.lu@linux.intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<patches@lists.linux.dev>, <pjaroszynski@nvidia.com>, <vsethi@nvidia.com>,
	<helgaas@kernel.org>, <etzhao1900@gmail.com>
Subject: [PATCH v3 0/5] Disable ATS via iommu during PCI resets
Date: Mon, 11 Aug 2025 15:59:07 -0700
Message-ID: <cover.1754952762.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|MW4PR12MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f8ea4cf-29d7-40be-522a-08ddd92ad962
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pzEzXUFOtKGQTzg0K5HT9XQXN6lUJQC9VkBs7a7HgH10VsYVSuOGucrtmoA7?=
 =?us-ascii?Q?OzQmduWgiMGBCj0hj6VlqrsOXuB9Q8L60MMJX2xOVDrRThPSnTrGgLDxJ7D3?=
 =?us-ascii?Q?lQPjXV0Ckie4o9XOlK59h3O80jAxnTHFre0lftzL0M6iZVJzpr0m48633HiG?=
 =?us-ascii?Q?TAnUkJ3rIT3cgEu4ToIX1GPTqCLfYR57nivSf28+tItbsFFrpcEGc1941u58?=
 =?us-ascii?Q?aveKNEzM0ZFJP5a9fqWFg0FWq1woYg1dQH2ZAeHqJPAeGixy5efx/nxKczfT?=
 =?us-ascii?Q?/S9smgHxIPf+CPo7t1EEJfCz7zQHZFeFGZpIXcP1sSdPw9Np87DjbDi7Jb4G?=
 =?us-ascii?Q?QIn3SQ2tp2M7Qo9pApYWsgAbnrQIq5H9yHjNWKxm8riA0s9wf8A/A0DY5xOA?=
 =?us-ascii?Q?cE6ObHOsejfyv9HU96lhX1SMQZq+CQSYgp1v1tLQNli+xrHz2SGXKY8dlRQO?=
 =?us-ascii?Q?tZWnZX4LZetNjhUStaWWnQppwJSdoTO8W7dLZhPZRU7g7QSmm+ZBG1cbolQh?=
 =?us-ascii?Q?F9pQD+tLGisY2kmx21PjIktEu+eKBD9e4XCpWN6UlwrwVwN/AxHDQbD2bfyG?=
 =?us-ascii?Q?8S9vH82o25FT8rKn8et+0ypD8tajqXq33Y/c+7f0Cp+zJpgr/uxbObJWBQCh?=
 =?us-ascii?Q?ZjgLHWsjy5MpGviBuENRAPNcWYm9mmrortxqwOUBc1Xwp+6C/BawsChNeJS4?=
 =?us-ascii?Q?T5zP3YCak5+5sBrL2WOk/9UtOD1Hd0Xz8OnpZNTh/LlxWLI/8dl5vJkwiAey?=
 =?us-ascii?Q?L6Gkj4crNfTAdhiL1u5v7r0GttJXzCuHflIFwRVxybit4n7u3TJd+KnBFHLF?=
 =?us-ascii?Q?Ex/amY0L0P69GdM7zRvf2WarkKyMZhPLQ9RvFNUSizqvD5/90X9dhQkV4ZYd?=
 =?us-ascii?Q?KTOOTn4OYcoh2krH5uSgxr/n9HYsIIYsec7Q4dOwOyvGjw2cUo5XhM8im2K2?=
 =?us-ascii?Q?4FO8sETd3m/ctUQ2HT+k9RCNdf9bL9envSfpyyAtlT2Z9Zq25NKsivdubdRL?=
 =?us-ascii?Q?1bGy4xAsm9V2E/1tNA2Xy7yCB2XrJ2opIUNC5KL4wyfS/vyGxkUipTuuXoPF?=
 =?us-ascii?Q?mWi0gwkxuCR9/prsMZHtYHWwkLdvBt8XXajN/hvxUexgrM40w2lEHzOaGHjr?=
 =?us-ascii?Q?Yt+8eA44wtrkL2S92JKW8B/ahAsBn2vvJS67sCGHPSwTN8Fr7iGuu0c9J/nq?=
 =?us-ascii?Q?rbOFA/NEOfSe3BTs+pNGUzYuvJd4vj2hJHsdoWFWsLhsnbWLVVhC16YsrdIK?=
 =?us-ascii?Q?tim3taBa+PNw8Bd16qHLlBZ7XZ0vAk+xh0DalNJwMQZ5LwZwRVmSyNAxyeMW?=
 =?us-ascii?Q?yEv1fKnvxniwb0+HsR7uM915TP85IYLxlq8FtJsVKJ99SoKCUMDBVKY6LGLZ?=
 =?us-ascii?Q?8Rsyw1iszKkXtZX2MsGwEJQoYgZCSAYmissea+j8kLsmfBmlbfXqijDFF97J?=
 =?us-ascii?Q?ii9ZZdwLIQA/iKcEniZTgdvMfQtyonMHcidMt+1Cz3FOTWBH8ZWyECxFeHzM?=
 =?us-ascii?Q?6lPWRVwj4BttYKmffyxYhB4ArFjlElmuQfBWJkalOjW7wHz3ifpjdNeGLg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 23:00:21.3643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8ea4cf-29d7-40be-522a-08ddd92ad962
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5668

Hi all,

PCIe permits a device to ignore ATS invalidation TLPs, while processing a
reset. This creates a problem visible to the OS where an ATS invalidation
command will time out: e.g. an SVA domain will have no coordination with a
reset event and can racily issue ATS invalidations to a resetting device.

The OS should do something to mitigate this as we do not want production
systems to be reporting critical ATS failures, especially in a hypervisor
environment. Broadly, OS could arrange to ignore the timeouts, block page
table mutations to prevent invalidations, or disable and block ATS.

The PCIe spec in sec 10.3.1 IMPLEMENTATION NOTE recommends to disable and
block ATS before initiating a Function Level Reset. It also mentions that
other reset methods could have the same vulnerability as well.

Provide a callback from the PCI subsystem that will enclose the reset and
have the iommu core temporarily change domains to group->blocking_domain,
so IOMMU drivers would fence any incoming ATS queries, synchronously stop
issuing new ATS invalidations, and wait for existing ATS invalidations to
complete. Doing this can avoid any ATS invaliation timeouts.

When a device is resetting, any new domain attachment should be deferred,
until the reset is finished, to prevent ATS activity from being activated
between the two callback functions. Introduce a new pending_reset flag to
allow iommu core to cache the target domains in the SW level but bypass
the driver-level attachment. Later, iommu_dev_reset_done() will re-attach
these soft-attached domains via __iommu_attach_device/set_group_pasid().

Finally, apply these iommu_dev_reset_prepare/done() functions in the PCI
reset functions.

This is on Github:
https://github.com/nicolinc/iommufd/commits/iommu_dev_reset-v3

Changelog
v3
 * Add Reviewed-by from Jason
 * [iommu] Add a fast return in iommu_deferred_attach()
 * [iommu] Update kdocs, inline comments, and commit logs
 * [iommu] Use group->blocking_domain v.s. ops->blocked_domain
 * [iommu] Drop require_direct, iommu_group_get(), and xa_lock()
 * [iommu] Set the pending_reset flag after RID/PASID domain setups
 * [iommu] Do not bypass PASID domains when RID domain is already the
           blocking_domain
 * [iommu] Add iommu_get_domain_for_dev_locked to correctly return the
           blocking_domain
v2
 https://lore.kernel.org/all/cover.1751096303.git.nicolinc@nvidia.com/
 * [iommu] Update kdocs, inline comments, and commit logs
 * [iommu] Replace long-holding group->mutex with a pending_reset flag
 * [pci] Abort reset routines if iommu_dev_reset_prepare() fails
 * [pci] Apply the same vulnerability fix to other reset functions
v1
 https://lore.kernel.org/all/cover.1749494161.git.nicolinc@nvidia.com/

Thanks
Nicolin

Nicolin Chen (5):
  iommu: Lock group->mutex in iommu_deferred_attach
  iommu: Pass in gdev to __iommu_device_set_domain
  iommu: Add iommu_get_domain_for_dev_locked() helper
  iommu: Introduce iommu_dev_reset_prepare() and iommu_dev_reset_done()
  pci: Suspend iommu function prior to resetting a device

 include/linux/iommu.h                         |  13 ++
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |   2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   9 +-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c       |   2 +-
 drivers/iommu/dma-iommu.c                     |   2 +-
 drivers/iommu/fsl_pamu_domain.c               |   2 +-
 drivers/iommu/iommu.c                         | 205 +++++++++++++++++-
 drivers/iommu/ipmmu-vmsa.c                    |   2 +-
 drivers/iommu/msm_iommu.c                     |   2 +-
 drivers/iommu/mtk_iommu.c                     |   2 +-
 drivers/iommu/omap-iommu.c                    |   2 +-
 drivers/iommu/tegra-smmu.c                    |   2 +-
 drivers/pci/pci-acpi.c                        |  17 +-
 drivers/pci/pci.c                             |  68 +++++-
 drivers/pci/quirks.c                          |  23 +-
 15 files changed, 323 insertions(+), 30 deletions(-)

-- 
2.43.0


