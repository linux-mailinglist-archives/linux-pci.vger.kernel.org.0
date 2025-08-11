Return-Path: <linux-pci+bounces-33802-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8DEB218E7
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 01:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934A91A25485
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 23:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A8E23B63F;
	Mon, 11 Aug 2025 23:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k2FcaZR+"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2040.outbound.protection.outlook.com [40.107.212.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0775B265CA0;
	Mon, 11 Aug 2025 23:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754953237; cv=fail; b=cGnO6sg6Ilyf+ArdPuJpwoRMb5z3k+7qGXl+UQZ7Afwd/FY6qU2/MjkeupHcmWc6lBWMXIx2lJiNmsdorzi6kBHYSkXAnjAynpuBEYVRGGMDSLSNICJXru6V0t3k1e+I5NIl1tSevg8vDQA7CGwDwVDPDFtWWH8fMRsTc9xh3Pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754953237; c=relaxed/simple;
	bh=CmtLdj1pn68H6DnkYeqE4TbROmWU2UiObDqKp1xECX8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hA+hNn7yZDKq2HTX/BDBVe7fKCERhgma47uWApiiSJg98OsPlMXC3Y2Pdg5npWdNuPn/XCqExqusv90Dua3qo5Hv2j8mHr1vjU4pHTSz377mQOC4KnHVucg8aM67SDTG7iUNqUuU5goLQaLJGKhTOxuxkAsc16+S0ILm7cd85V4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k2FcaZR+; arc=fail smtp.client-ip=40.107.212.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8vMVvj2BqBoNrLba2Xj//WPEv++bmi1qN0mko5yn4+tQSO/JU0v70pTx9P3cMWKyU8eitlFNyqpND9E2p5RwqxbbzKxRt+s9C3GXnG7fuceCvPdBVroycdA6PW86YOdhZvzjh/Q5OvAC+8PjdUnHUrXqhjbXsJWtFyJT8t46UHMG6JiFlkdhYB0ynbtzKshttjR7ZRdobsy5vGovzfmaoIIEX82D8KfPsHUe9CJbUTJs/vdwGY1yvjDiJUzAr7s+q7MXns8jE3PnQgMD3xWRJO4EG5c4HvtINhtaUQyqPvGVBpSENFzXzcOgYrPEOQin8cg/xdVP+NwxEeO6UB0fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05PLUJB3jqqPfOnGR0XkCsEyFxN/wPbieSmJbErEGMo=;
 b=eQLr1nN/CnQ8aHa5FhMQTjPMckU6avsIMKcAizG4lYZi9U8QUyF+ngxW8lWubceEpWprM2kdBToFGHfCX/yZxf0VN97FGq8ul+i4gWgu+VKUByz5tdk72aOZG4b95pOgSQ1+O2Mw7QOpZQEBDlXd6mYwBQAHIF8/R8x6Nre5dP3cTkvwaaLT5OYdUIfHAdpdhzgUQImWXaBSewBPU8wgEUZEjxl959r7H/1b0CyXpIr+2/ThFZSoOjjbc4mZk3gdONCEotNlLf+7IfTLQ+izJlEU6vpdanrTGDbdKRDNQhzliK69rz2UxqqY1bIJLfqGDNhC00wRgjmuWDqW8C2tMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05PLUJB3jqqPfOnGR0XkCsEyFxN/wPbieSmJbErEGMo=;
 b=k2FcaZR+7SPE0A1KqoZUogZ6SLSaH22TxcbzV1NWcNMI3wRlmWjLBk/ozCrd1yJ7U7RKiy2JQxfY1z1ldZ7nVfxWOw9u/KufKhfvKfoR0lmkH1CZ3euo9ppm5zTt0Gi4MlqgQEnYiD6Y78OTitN6IvKs0qkD7xBXWqZrg9SoCzGh4JT550YPcsLdaE+hBi6yxPWILQJ7fEjTVRKLcvTkTjEx2cpMcAKjG/HjqEg58nigHG+3dEoTguFc3GGXupbsyjY398ksX3f/rjBzb0c+19AXmEWF6UoONJddjxckANcKjy0zLqQxiYKuZ7bF0lVupsjGlq1XJHqSd3oiNmJW1g==
Received: from BN8PR07CA0009.namprd07.prod.outlook.com (2603:10b6:408:ac::22)
 by DS0PR12MB8343.namprd12.prod.outlook.com (2603:10b6:8:fd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.21; Mon, 11 Aug 2025 23:00:32 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:408:ac:cafe::88) by BN8PR07CA0009.outlook.office365.com
 (2603:10b6:408:ac::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.21 via Frontend Transport; Mon,
 11 Aug 2025 23:00:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 23:00:31 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 11 Aug
 2025 16:00:10 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 11 Aug
 2025 16:00:09 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 11 Aug 2025 16:00:08 -0700
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
Subject: [PATCH v3 3/5] iommu: Add iommu_get_domain_for_dev_locked() helper
Date: Mon, 11 Aug 2025 15:59:10 -0700
Message-ID: <a69557026b7e2353bae67104bbe6a88f0682305e.1754952762.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1754952762.git.nicolinc@nvidia.com>
References: <cover.1754952762.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|DS0PR12MB8343:EE_
X-MS-Office365-Filtering-Correlation-Id: 8029d43c-7ba1-4f5e-022c-08ddd92adf6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CV1m/WBfpUEtQINfoUMj03AtII85qVynzUZSnuQdUNDkENvIWq14YjnX8BOG?=
 =?us-ascii?Q?4k+yShaeeapHjcY9pPAhpMXFn9HdQT+xVqacyOnux5uFIW/gXfna0oq9CIWq?=
 =?us-ascii?Q?nG2/h2RAvanqGQB6jxT4L8WDjyzGR3pfDOFJeq5V24t2bkbsJzC/CG7t0gUw?=
 =?us-ascii?Q?QJ3g6f1EOvlCR7gvqefWAWjQ7CqOyx8w4AsLbvTeODGpVjKQxLFXOHyvKKJH?=
 =?us-ascii?Q?YWyNqrE9CVJ0v8MnMwTbnbZQlu5v0Y3BcKIGSevmhQaJme+Zku3CF1eavoTK?=
 =?us-ascii?Q?E+O6pUNDWTEZrGBqRyKWeY/djwLqMr3eaZKWSKhBYhk5t7LxiyzQtEV6RSGD?=
 =?us-ascii?Q?bNhbKB+W6UhjvwM5JTvjXg/rARZP+M0LJMJNlvnTU4qhjpvea9lqUPdFXSjv?=
 =?us-ascii?Q?h/KYJD4txGME5kTSzvjLYyfkckQp9Abl6t92EKh7fJt1MlDz9R2TgeQ4xeRy?=
 =?us-ascii?Q?vryKJJNZ0Ond7s21CWPh+K25qAPApfLJlqJ3Jm/k3/HfU6JX876xGgoMcdfL?=
 =?us-ascii?Q?57o3hIuo+qtzIwDNOPVK/By5EdAh/ShWlTVokVK03mw3jUFB8kjwFJC9Db8W?=
 =?us-ascii?Q?RGWBZyNfPZtwJNWoTvGeOSFiPUmD5UGoDt62S0YoOcAH6YZni9Hg6K+yMG81?=
 =?us-ascii?Q?KYymCtVXoWjRPA+0WXA8EiutlVjRg4N5YvSbsxOCYJC/UYlvjfCfuWYRAZ0I?=
 =?us-ascii?Q?TwP8fpe46fsma4gbT02B4R+S5hFTBt/qX+a46VB8vD0H/unkkt1JO29Vbnb8?=
 =?us-ascii?Q?PAATFKHk7dD7wUhlxO24/Ay3V//g8QaK09fFhdQ4JZiWsN1rAOsiNSPrG8FU?=
 =?us-ascii?Q?IFfkbkwGwzac4IzOzrbRp+8UyiPS7KohRgIgNt+nvcWbOokJZrpEQus4iLI/?=
 =?us-ascii?Q?THfozVIwbr+pNOEu0vlbmphRBLoxqEh0Ufg0qyfdTQfmLS1enswzO9l0/RrI?=
 =?us-ascii?Q?bEmfIUuuuIrmcRnFgBb5E3hnJB5sY28wVoxbieE2BObP3PVKbMTk4NPQ2+R3?=
 =?us-ascii?Q?QFP3Nnw0iEzpuIbmUIYu5DFkWipYSLMiFB3/bFSVTP0yo40hKUTxmjqZxWrP?=
 =?us-ascii?Q?fw10IPhZaPSEjMT5WPFjVEJE3Zz+FoDdoX1UXunEX7EDbMeRPxGgZwNIW8Fg?=
 =?us-ascii?Q?W1xpNYB+VrsBRjXVuL3BoA5oN88n8v9+vACfVqFvxVfS9+wu1wqexGiyc9tH?=
 =?us-ascii?Q?4oyCyILp56PPqDZeHuEmuued296OVRu4U4nD7DSGpwHi4BL1qQFdr0Ox1Wxh?=
 =?us-ascii?Q?1qrZzlK/SHUQd8TXhJ8ciwf9mHwVJ7yNNdMu/zWfJv3GlDUjI7b+bqRf5u4B?=
 =?us-ascii?Q?MQ505bJ30C9WuaiIdeTAPn1474Fy8BpI1zLL9a22Mrcf3lRQgb562kZVyuuT?=
 =?us-ascii?Q?QUg3J28mSySUHoUqN18w1xe0LwYaTa2HbjVTKVYE1gHSsSyniGSBGmgJjCtz?=
 =?us-ascii?Q?PFlGI8i6b9PQID9OCv1e+mfLrAPML22YYI9zE0RoPis+6DMDJsp6m3IYWuMq?=
 =?us-ascii?Q?hx4Di0eszDl9Wyn61bc88YvwsKEdOhskjtHt?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 23:00:31.4906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8029d43c-7ba1-4f5e-022c-08ddd92adf6c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8343

There is a need to attach a PCI device that's under a reset to temporally
the blocked domain (i.e. detach it from its previously attached domain),
and then to reattach it back to its previous domain (i.e. detach it from
the blocked domain) after reset.

During the reset stage, there can be races from other attach/detachment.
To solve this, a per-gdev reset flag will be introduced so that all the
attach functions will bypass the driver-level attach_dev callbacks, but
only update the group->domain pointer. The reset recovery procedure will
attach directly to the cached pointer so things will be back to normal.

On the other hand, the iommu_get_domain_for_dev() API always returns the
group->domain pointer, and several IOMMMU drivers call this API in their
attach_dev callback functions to get the currently attached domain for a
device, which will be broken for the recovery case mentioned above:
 1. core asks the driver to attach dev from blocked to group->domain
 2. driver attaches dev from group->domain to group->domain

So, iommu_get_domain_for_dev() should check the gdev flag and return the
blocked domain if the flag is set. But the caller of this API could hold
the group->mutex already or not, making it difficult to add the lock.

Introduce a new iommu_get_domain_for_dev_locked() helper to be used by
those drivers in a context that is already under the protection of the
group->mutex, e.g. those attach_dev callback functions. And roll out the
new helper to all the existing IOMMU drivers.

Add a lockdep_assert_not_held to the existing iommu_get_domain_for_dev()
to note that it would be only used outside the group->mutex.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h                              |  1 +
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c    |  2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        |  9 +++++----
 drivers/iommu/arm/arm-smmu/qcom_iommu.c            |  2 +-
 drivers/iommu/dma-iommu.c                          |  2 +-
 drivers/iommu/fsl_pamu_domain.c                    |  2 +-
 drivers/iommu/iommu.c                              | 14 ++++++++++++++
 drivers/iommu/ipmmu-vmsa.c                         |  2 +-
 drivers/iommu/msm_iommu.c                          |  2 +-
 drivers/iommu/mtk_iommu.c                          |  2 +-
 drivers/iommu/omap-iommu.c                         |  2 +-
 drivers/iommu/tegra-smmu.c                         |  2 +-
 12 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c30d12e16473d..61b17883cb0cb 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -909,6 +909,7 @@ extern int iommu_attach_device(struct iommu_domain *domain,
 extern void iommu_detach_device(struct iommu_domain *domain,
 				struct device *dev);
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
+struct iommu_domain *iommu_get_domain_for_dev_locked(struct device *dev);
 extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		     phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 8cd8929bbfdf8..6d44c97d430b4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -145,7 +145,7 @@ static int arm_smmu_attach_dev_nested(struct iommu_domain *domain,
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct arm_smmu_attach_state state = {
 		.master = master,
-		.old_domain = iommu_get_domain_for_dev(dev),
+		.old_domain = iommu_get_domain_for_dev_locked(dev),
 		.ssid = IOMMU_NO_PASID,
 	};
 	struct arm_smmu_ste ste;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5968043ac8023..3efe51ae37edb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3010,7 +3010,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_attach_state state = {
-		.old_domain = iommu_get_domain_for_dev(dev),
+		.old_domain = iommu_get_domain_for_dev_locked(dev),
 		.ssid = IOMMU_NO_PASID,
 	};
 	struct arm_smmu_master *master;
@@ -3124,7 +3124,8 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
 		       struct arm_smmu_domain *smmu_domain, ioasid_t pasid,
 		       struct arm_smmu_cd *cd, struct iommu_domain *old)
 {
-	struct iommu_domain *sid_domain = iommu_get_domain_for_dev(master->dev);
+	struct iommu_domain *sid_domain =
+		iommu_get_domain_for_dev_locked(master->dev);
 	struct arm_smmu_attach_state state = {
 		.master = master,
 		.ssid = pasid,
@@ -3190,7 +3191,7 @@ static int arm_smmu_blocking_set_dev_pasid(struct iommu_domain *new_domain,
 	 */
 	if (!arm_smmu_ssids_in_use(&master->cd_table)) {
 		struct iommu_domain *sid_domain =
-			iommu_get_domain_for_dev(master->dev);
+			iommu_get_domain_for_dev_locked(master->dev);
 
 		if (sid_domain->type == IOMMU_DOMAIN_IDENTITY ||
 		    sid_domain->type == IOMMU_DOMAIN_BLOCKED)
@@ -3207,7 +3208,7 @@ static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct arm_smmu_attach_state state = {
 		.master = master,
-		.old_domain = iommu_get_domain_for_dev(dev),
+		.old_domain = iommu_get_domain_for_dev_locked(dev),
 		.ssid = IOMMU_NO_PASID,
 	};
 
diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index c5be95e560317..c82fbcd28cdde 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -390,7 +390,7 @@ static int qcom_iommu_attach_dev(struct iommu_domain *domain, struct device *dev
 static int qcom_iommu_identity_attach(struct iommu_domain *identity_domain,
 				      struct device *dev)
 {
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	struct iommu_domain *domain = iommu_get_domain_for_dev_locked(dev);
 	struct qcom_iommu_domain *qcom_domain;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct qcom_iommu_dev *qcom_iommu = dev_iommu_priv_get(dev);
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
diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 5f08523f97cb9..2b7395c5884ea 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -300,7 +300,7 @@ static int fsl_pamu_attach_device(struct iommu_domain *domain,
 static int fsl_pamu_platform_attach(struct iommu_domain *platform_domain,
 				    struct device *dev)
 {
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	struct iommu_domain *domain = iommu_get_domain_for_dev_locked(dev);
 	struct fsl_dma_domain *dma_domain;
 	const u32 *prop;
 	int len;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e6a66dacce1b8..8c277cc8e9750 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2176,6 +2176,7 @@ void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_detach_device);
 
+/* Caller can be any general/external function that isn't an IOMMU callback */
 struct iommu_domain *iommu_get_domain_for_dev(struct device *dev)
 {
 	/* Caller must be a probed driver on dev */
@@ -2184,10 +2185,23 @@ struct iommu_domain *iommu_get_domain_for_dev(struct device *dev)
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
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index ffa892f657140..7e8de6e1bf78b 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -639,7 +639,7 @@ static int ipmmu_attach_device(struct iommu_domain *io_domain,
 static int ipmmu_iommu_identity_attach(struct iommu_domain *identity_domain,
 				       struct device *dev)
 {
-	struct iommu_domain *io_domain = iommu_get_domain_for_dev(dev);
+	struct iommu_domain *io_domain = iommu_get_domain_for_dev_locked(dev);
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct ipmmu_vmsa_domain *domain;
 	unsigned int i;
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 43a61ba021a51..58cc08c8ede8b 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -443,7 +443,7 @@ static int msm_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 static int msm_iommu_identity_attach(struct iommu_domain *identity_domain,
 				     struct device *dev)
 {
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	struct iommu_domain *domain = iommu_get_domain_for_dev_locked(dev);
 	struct msm_priv *priv;
 	unsigned long flags;
 	struct msm_iommu_dev *iommu;
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 0e0285348d2b8..31b29bcfc7569 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -775,7 +775,7 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 static int mtk_iommu_identity_attach(struct iommu_domain *identity_domain,
 				     struct device *dev)
 {
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	struct iommu_domain *domain = iommu_get_domain_for_dev_locked(dev);
 	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
 
 	if (domain == identity_domain || !domain)
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 6fb93927bdb98..881fa5d243a15 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1538,7 +1538,7 @@ static void _omap_iommu_detach_dev(struct omap_iommu_domain *omap_domain,
 static int omap_iommu_identity_attach(struct iommu_domain *identity_domain,
 				      struct device *dev)
 {
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	struct iommu_domain *domain = iommu_get_domain_for_dev_locked(dev);
 	struct omap_iommu_domain *omap_domain;
 
 	if (domain == identity_domain || !domain)
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 36cdd5fbab077..fdec0439bd683 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -526,7 +526,7 @@ static int tegra_smmu_attach_dev(struct iommu_domain *domain,
 static int tegra_smmu_identity_attach(struct iommu_domain *identity_domain,
 				      struct device *dev)
 {
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	struct iommu_domain *domain = iommu_get_domain_for_dev_locked(dev);
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct tegra_smmu_as *as;
 	struct tegra_smmu *smmu;
-- 
2.43.0


