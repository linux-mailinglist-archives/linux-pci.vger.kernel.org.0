Return-Path: <linux-pci+bounces-35206-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25921B3D5E8
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 01:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F243B95DE
	for <lists+linux-pci@lfdr.de>; Sun, 31 Aug 2025 23:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4D0277037;
	Sun, 31 Aug 2025 23:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qfxdWacj"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098A7257834;
	Sun, 31 Aug 2025 23:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756683185; cv=fail; b=cH1UTk6Bel3iAheur1XuI+uwWtBwXtcUzdSXE9Fefv/790CbeSkJuKMFEavElMlf7Sv8TufUXXQ1A5/9MVYcuXnkpzEi4qdxQDl0qiLCv7uBBpvQX4RKAq8kwCoR/+tIbZf2USPpDB8Lf4zvfbcFyPmML7Q+zuyzgS9ubrXtupk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756683185; c=relaxed/simple;
	bh=XLBEVyf9HmB4IlNa6tFyzmsSZPIWxKfB/B4mIGDrOqI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jz90fPKsk0HtxKcuzGcZriNF0fLJv0BvmCATmPTM6aHIqSgDPD3+QTVjNg06m1W6OUkb4qlDA0iDSsCHbMAqfQSr0D+aDcfr9Unnm+cN+hwK5wOY2WRx4QixgroW97I4B4JSaMA2/Zaa8QXl6RC8V3oOZr79puJ+9x8xyKnNo/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qfxdWacj; arc=fail smtp.client-ip=40.107.100.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y35Vw3g/34GfQuQA3XlT1LXtjrDcnrf4Ax5H68uEsVs69s9Yhp2qj1DW42BtbPxhZOM8ke1iVtISzh29r5u8uxB3ulFfsvwxdp4EBQ39pF5K7CjV2LBkYxQ+IsROBJ3ucbQblsPToSeaXbbyjdlzL6viiq3nXRl7kzMb/2t/PBBzlruA7gMJmkLvqGZM4wfhkGWw5yB1KGNcBGpkH2Z/hAs3D5V5CGNedjM/TZ2rQCJR0P5+0kguDSj8OldTPJnJ7PUow63iRX6Vre0vq5Z4LWcIhTIJEjbjhRY0y6aiIYhp3DjnJ9OMmVPsb698xPtmboykm4lFbMLqapuuzWCZUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSBSRq5jGNZAxRbZvVVRpLykqAMfoH8P1hSz4oPA3Ng=;
 b=cAUHUdhQaDirsHLUVFSTnkBBzwXdk0KuHNrmZxNwZWfJdFz7OI1Vs0FkPROo9rzyrNDI/SRdqFaLmtv1xYqWqfV8ePYX1k+3khFIhPPw2PJDyFU/Jfq9zThkaIJSDYGmJXr0PeQsmTpyA/9sE+jLpadEpJYTrQzaa1mozMKuM0FycymDv0L3ihuT0W4FCDZy2Px/ALfBUzu8DdvPMnvYe8iUjbzNiiTgJU7DvRsDWPLheOFPjTNObDI13s1gvSlIOkNpJPR1A/s8xGZCpxA6EQovg+4BRkCu41nFW4Hmjz8u9S/+uJHl6GY1DF6sgmrCWTPdRaZTYRKtQr3ol61ELg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSBSRq5jGNZAxRbZvVVRpLykqAMfoH8P1hSz4oPA3Ng=;
 b=qfxdWacjO+7JI3UaubasPiGoNBPl/CVU6oayULNeNcZcfEKGJAR4PgcNzXGjTocGhbwLpGQzuI69bBzZeOozIlrJ+Rsc3iIpxSB4QEvjIHiUTrmoGvkAVqsRIKSUH/mIEyLXtbLf6k7FQJQ9q2NsagdlCNWDU7WzWxyobB9VfhO3cWqYW+5VR0Gpblojn2ocfzgMxyDXtmgh5POrosxnQOIJWfn/C7v8M6xboCTC5aHOetonleWRM2nskwrKoGGel46HE04DLRqVU8fvmuqhUD1Ub4UK+RgTKoosId1PfY76LkJddrbkFYo3Bzymzx+wSqKKOuljhaQJf/MrNke5mQ==
Received: from BN9PR03CA0771.namprd03.prod.outlook.com (2603:10b6:408:13a::26)
 by SJ0PR12MB6686.namprd12.prod.outlook.com (2603:10b6:a03:479::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Sun, 31 Aug
 2025 23:32:57 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:408:13a:cafe::20) by BN9PR03CA0771.outlook.office365.com
 (2603:10b6:408:13a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.26 via Frontend Transport; Sun,
 31 Aug 2025 23:32:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Sun, 31 Aug 2025 23:32:56 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 31 Aug
 2025 16:32:41 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 31 Aug
 2025 16:32:41 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 31 Aug 2025 16:32:37 -0700
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
Subject: [PATCH v4 5/7] iommu: Add iommu_get_domain_for_dev_locked() helper
Date: Sun, 31 Aug 2025 16:31:57 -0700
Message-ID: <c9daeafb9046bed9e915fdafe20fe28a8c427d29.1756682135.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|SJ0PR12MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: 33e55966-cb35-4aef-6e87-08dde8e6b70c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6gJhwfQ8HIMS6hUlloYFaRUQiOvLaFwspJo3gR8HF58t+mkFzIM5s6ksyw/F?=
 =?us-ascii?Q?qiRDKkZvYjYoNJeODvNSHd8JVR+wuaTZXaQSgquwtOWxZxJ2QlAcm9xY8OZL?=
 =?us-ascii?Q?TXKfqJ52E1S/IxyPzyB/D8aGuVKbrZozoBPkO7XTsXKzoVSu93tWvSP4IYMf?=
 =?us-ascii?Q?T1s2iqaBcWleQtTb6yOGZJ15OoyeiAYjm2z1MONOgjdJGlVAwQRSxdZRvkRt?=
 =?us-ascii?Q?gnEx/DxvEQ5RusYPTMUU+shoJK8SsDQh6H6JjrPLvgwF99bk2BxunJs19A++?=
 =?us-ascii?Q?NTAFstACrfLx5kNp9tSvnonbPLPfOcj2fZ5dKb8M7YoJFismDZgpGcMKxqhB?=
 =?us-ascii?Q?H+0sVk60Bsf2VonXv1ZitvyiAepoLKDx1uqbG35rn9nqihML65jgmG4A53AB?=
 =?us-ascii?Q?Fe5b1d1grr0KJX1TTm+SpafCp7+Cbzfj6Ur6fJAWOwXnEpR+LWtnaCcRSe3Y?=
 =?us-ascii?Q?7aspuvzD5el7M76Kejxui+sSvcAQEroi6PdSdEAOTDiX94e+gsOS79kyewyx?=
 =?us-ascii?Q?XlCyHPq/vKe34dqDj16P0lh2KonrrtxTHDfmh9cXfLlVili8D3qFBjxcIjGb?=
 =?us-ascii?Q?0akb3Z7d3Q8hTda48gWzBsaekzG5A9EP0p2UzjSlFZHChhuyZIlEujYGFpLS?=
 =?us-ascii?Q?fplEMtIu5Hm+wt3FiUnG/PXim3iID0C+Gb1XAmB2tzr9qTAnrO31zK9sLHfH?=
 =?us-ascii?Q?SDuv98NeMcuCh1ugiIl1pYDP1vxSczrJqkIGOQMAxryZmTjmPkhOgvP7LV22?=
 =?us-ascii?Q?bgIQ1cRcpXHvfJI/8mMgPqNGuovTvnLDJOa07ApFZH5YvIIMjX/a1F75wDNI?=
 =?us-ascii?Q?ewq2L4z79gPBKNFwBWexJA7HCikEjjDTV9SOJi67T6z3iNsqYCN3NDI6tsXI?=
 =?us-ascii?Q?ohmkWD6ZVu4lcEoOuzMbVpIFbUJYvtnV/eFYNZe+mdtizTVoJkoPXFnM2UIi?=
 =?us-ascii?Q?qQFUH874qSgcP7k/TDVaizEe6r3FOSdQ0zFiDo6j35OsmuX+mWhkPeOX1Eue?=
 =?us-ascii?Q?jJ8ifIcYiXECRy51tpxeJJW4yr+pPnrgRmdmKhuC7N2HRQhZvOYkYD/Yng2l?=
 =?us-ascii?Q?oE5+ZOXu+ZhcLwyR7PUtCXd9PQcU0nChilHHruEqrdNGmhWxcaP0zeSZrjoL?=
 =?us-ascii?Q?XorCSQzuGY3XgNCabAx1dT52ta4M0b2YISnOKCaFjqbqOUG0bPJHWXe8yD8h?=
 =?us-ascii?Q?2ZcQ5yOll3Z2ylm28+qKZeYw4gzRez1wmdCfDflbV2w7t/p9wvPMfF90v9lK?=
 =?us-ascii?Q?vI90O3lLT4+yNcPgyyYexD7xsN85YYlfLI5X/gmzFuSlEmUtGsLpCIX7fPDy?=
 =?us-ascii?Q?6iokFUzoIAlwBGCfC/tGBKF0e4J5Eu+zgpslzVNqLS2qRYZ3THPU1EjhOj+J?=
 =?us-ascii?Q?g0IyoeVxAqz+8DQDm2WBNEsVC+7LCGYy30RjkboypdEehmV2VEgSJx/6ddQp?=
 =?us-ascii?Q?oxmj1HGVvGfU6UjLPhJu1uji4COt4UahLH73WD1XMB8Ueh1c8p03uldu4RQw?=
 =?us-ascii?Q?hgQWAnGnNQYXPossyriyE+cPjf68R2ZzWZD+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 23:32:56.6071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e55966-cb35-4aef-6e87-08dde8e6b70c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6686

There is a need to stage a PCI device that's under a reset to temporally
the blocked domain (i.e. detach it from its previously attached domain),
and then to reattach it back to its previous domain (i.e. detach it from
the blocked domain) after reset.

During the reset stage, there can be races from other attach/detachment.
To solve this, a per-gdev reset flag will be introduced so that all the
attach functions will reject any concurrent attach_dev callbacks.

So, iommu_get_domain_for_dev() function always returns the group->domain
that needs to be changed to the blocked domain by checking the per-gdev
flag, for which iommu_get_domain_for_dev() must hold the group->mutex.

On the other hand, caller like the SMMUv3 driver invoke it in one of its
set_dev_pasid functions where the group->mutex is held, while some other
callers like non-IOMMU drivers invoke it outside IOMMU callback functions
so the group->mutex is not held. Apparently, this makes it difficult to
add the lock to the existing iommu_get_domain_for_dev().

Introduce a new iommu_get_domain_for_dev_locked() helper to be used in a
a context that is already under the protection of the group->mutex.

Add a lockdep_assert_not_held to the existing iommu_get_domain_for_dev()
to note that it would be only used outside the group->mutex.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h                       |  1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  5 +++--
 drivers/iommu/dma-iommu.c                   |  2 +-
 drivers/iommu/iommu.c                       | 14 ++++++++++++++
 4 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 801b2bd9e8d49..6d6d068c3de48 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -910,6 +910,7 @@ extern int iommu_attach_device(struct iommu_domain *domain,
 extern void iommu_detach_device(struct iommu_domain *domain,
 				struct device *dev);
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
+struct iommu_domain *iommu_get_domain_for_dev_locked(struct device *dev);
 extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		     phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index de02eeb524c15..4a68bd121287a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3125,7 +3125,8 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
 		       struct arm_smmu_domain *smmu_domain, ioasid_t pasid,
 		       struct arm_smmu_cd *cd, struct iommu_domain *old)
 {
-	struct iommu_domain *sid_domain = iommu_get_domain_for_dev(master->dev);
+	struct iommu_domain *sid_domain =
+		iommu_get_domain_for_dev_locked(master->dev);
 	struct arm_smmu_attach_state state = {
 		.master = master,
 		.ssid = pasid,
@@ -3191,7 +3192,7 @@ static int arm_smmu_blocking_set_dev_pasid(struct iommu_domain *new_domain,
 	 */
 	if (!arm_smmu_ssids_in_use(&master->cd_table)) {
 		struct iommu_domain *sid_domain =
-			iommu_get_domain_for_dev(master->dev);
+			iommu_get_domain_for_dev_locked(master->dev);
 
 		if (sid_domain->type == IOMMU_DOMAIN_IDENTITY ||
 		    sid_domain->type == IOMMU_DOMAIN_BLOCKED)
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index ea2ef53bd4fef..99680cdb57265 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -2097,7 +2097,7 @@ EXPORT_SYMBOL_GPL(dma_iova_destroy);
 
 void iommu_setup_dma_ops(struct device *dev)
 {
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	struct iommu_domain *domain = iommu_get_domain_for_dev_locked(dev);
 
 	if (dev_is_pci(dev))
 		dev->iommu->pci_32bit_workaround = !iommu_dma_forcedac;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ef3fd7bd1b553..f08c177f30de8 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2179,6 +2179,7 @@ void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_detach_device);
 
+/* Caller must be a general/external function that isn't an IOMMU callback */
 struct iommu_domain *iommu_get_domain_for_dev(struct device *dev)
 {
 	/* Caller must be a probed driver on dev */
@@ -2187,10 +2188,23 @@ struct iommu_domain *iommu_get_domain_for_dev(struct device *dev)
 	if (!group)
 		return NULL;
 
+	lockdep_assert_not_held(&group->mutex);
+
 	return group->domain;
 }
 EXPORT_SYMBOL_GPL(iommu_get_domain_for_dev);
 
+/* Caller must be an IOMMU callback/internal function that holds group->mutex */
+struct iommu_domain *iommu_get_domain_for_dev_locked(struct device *dev)
+{
+	struct iommu_group *group = dev->iommu_group;
+
+	lockdep_assert_held(&group->mutex);
+
+	return group->domain;
+}
+EXPORT_SYMBOL_GPL(iommu_get_domain_for_dev_locked);
+
 /*
  * For IOMMU_DOMAIN_DMA implementations which already provide their own
  * guarantees that the group and its default domain are valid and correct.
-- 
2.43.0


