Return-Path: <linux-pci+bounces-35205-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBDBB3D5DF
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 01:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34B41178047
	for <lists+linux-pci@lfdr.de>; Sun, 31 Aug 2025 23:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D9F2773C7;
	Sun, 31 Aug 2025 23:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UaulSTRf"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87085277037;
	Sun, 31 Aug 2025 23:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756683177; cv=fail; b=MQVbvvyXzB+QZnqibpFeMFy1wsAOBk6sAW/8ZspYIp/GiszdOpFXSCXQgqShtu7HPGRPviw1vpSCxq36KQLWa09F0hAiz3QTDlZPjaEuwqJvjQ6FajpJD2d4dJ0JLRGvIifSyEo4/PbDhth+ySFcPWTNV9htbAkqdwQ04tvqlEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756683177; c=relaxed/simple;
	bh=83ta9xj8m9WPHeUls1AQSdS7lGIjuYJA9Wgyo4Njxq8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QSADAQiv5QMvWHcfM9IG4qDIHJ257kYWmQr214W7oLdThweLGnG5TT1CJzoVpxQTPen5ykYJP2JbpF7zYVxim5L4l7vKyCKO/41cUZ0/7Ir6ZGSyQIU/+g19hWRLkt/W7ERBGWYzMPBQS+I+KO30TqIehMMp8ujWa0jk6crRbm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UaulSTRf; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RSZqUc7YqfpvOp6skixN+gGPnZF4hI1aKLYFLy1i98EiDQ5gxCwrdMygBhPwvW5+mrPbtCh8Ui9aLB06noS6s413K8lM/Ngu2hYcAXwWzqtdked72KOCXca0+9CM03AVCwQeVIHJYoKN60v1nxbV6XIpFaYuT2YmygKG8vbYEbzpXPlhEStGuOeS03OQa5EAeB2hzVo3cyRU+8ie6TSus7ci7D8xuKuAIg+WzbLSKmhLrqmQZfGJpy09u/Myzlstny/x/VkfO7fmF0Q9GLBq7YCZ2vyNjjfv3Sd8fkYkZnmachY8ezYc56tOMUG8QHO3N+pFEF0YMFBd+eDu3ya4IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8r5EdWbzpnmh3fw+iP4isRqY/R2qYq5XCyfI56FOvIQ=;
 b=k3JFHLFkZpNT0TrEYtK6hvluj7fQ/9o5gKiyLrh1V9yJa8gtRccL8xZL94MBFsRLwLhnhCFoLupYPQYDPFW9vg6wJ9kzfL8mYyklt10h0TdgmGLpwwygIgtnLqoXP30jpMOBKYjIuP9NcwvClK9BpL1QVFFegCfHOpA0vcbLNTWuJ05CIi/U8Pb0ZVrtGMdQZ48DLwWYXaFRmkDDyEC0wRzOEs8JJ3ZlfaFh9sPwNyya+1+RTUbQqxA0SX8sJHES1564zqihOaYBb8AERjhtM6t3DmmL9InYKQYWPGvshhcZ5ef34BqrjFnA16QtzovaO9ZoQmhjHT1Ybk+ZRjNtog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8r5EdWbzpnmh3fw+iP4isRqY/R2qYq5XCyfI56FOvIQ=;
 b=UaulSTRfTi+Qy+kIi+2cHvvyGYGEyDxViG8rSTFhmnfx2urnznMNdl7XG58QNBUn5x2ouCKQjeKn6DGG6spgguFdp4rds5EjE2oxmFHD0SGElcThEEPXZLGiBzq/weh/En+XUa8KsiiBd/ZBHhTy00H0dFtklJAqP6vsvsiyKYjc2lVqbxHpvcohTsxsQ3ziqRGGB+mMY0bMXEyM+zfq8oZhJ3yAQk7kmfvTXddU3M2YgUWCdmQfup+frxK8ynugJe/FLBds0VodRc6evF2hbFLHx7lWhdXwFWy33MWa+Z1vsA0NencsQELMJEHo9EFUYm5e2uSDOuZz0qj3Im72xw==
Received: from PH7PR17CA0048.namprd17.prod.outlook.com (2603:10b6:510:323::11)
 by SA0PR12MB4495.namprd12.prod.outlook.com (2603:10b6:806:70::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.26; Sun, 31 Aug
 2025 23:32:51 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:510:323:cafe::e3) by PH7PR17CA0048.outlook.office365.com
 (2603:10b6:510:323::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.26 via Frontend Transport; Sun,
 31 Aug 2025 23:32:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Sun, 31 Aug 2025 23:32:51 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 31 Aug
 2025 16:32:33 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 31 Aug
 2025 16:32:32 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 31 Aug 2025 16:32:28 -0700
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
Subject: [PATCH v4 3/7] iommu: Pass in gdev to __iommu_device_set_domain
Date: Sun, 31 Aug 2025 16:31:55 -0700
Message-ID: <24ed472debf8c57d3cef6582400c7636e080ed28.1756682135.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|SA0PR12MB4495:EE_
X-MS-Office365-Filtering-Correlation-Id: d765abd1-b268-4fa8-4d9f-08dde8e6b3e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r7BEKp7vZDjmf89wjYU0LPtBIJorKjXuFfwJQxdOq4/SZquiZitLdehFPjBd?=
 =?us-ascii?Q?g8BvY5gXMntKgFsR5ij/IvQvKxGk7UTTFmgcd75PfAttdv42aIGUqIcLHor7?=
 =?us-ascii?Q?YKXwJ+uBGI22miHh9PyQwsB2kFVhLdeGEaQD3GFTh85MAtHudyHXRTSKJ3tn?=
 =?us-ascii?Q?Hy6Uo0OGBIxMokgK1qzr+0hDfxF9VOtF1CKeOX42l1eFPM4glpFWCdZTK0Vr?=
 =?us-ascii?Q?xIxzKZaOpZhgPzSCgaMbyDclkAp1f1Q7aPndFFfx3b5rksH24JkIKDXtdeT9?=
 =?us-ascii?Q?5BzG28Tp78Ns3QiUyPv+yuTc2gxc/FnfY80TsoCYQij9jbl7OfjM/E9Dipmg?=
 =?us-ascii?Q?mZN2A9btk46WuhGJJvdE6YG2tMUOqDw7vJokIr2P6Z5Ew9ZtEe/yri3aaIvR?=
 =?us-ascii?Q?ApKSeB4mg87rroJFtsoRm8wDwdjOCMO74EJYJhHR/2JNDwoRvvvnHhOa7lb1?=
 =?us-ascii?Q?Wr/IhGoUTMH70Xx0dVCXxyNPjro1XhOrmUJpsWkDbDGVSZA1EDfQfLaRjK90?=
 =?us-ascii?Q?dnFJGiWd3dAGM63sTEflE+XMqPADHvqs5uH5ZlQWog81NQw7yjj/ooI/KYXn?=
 =?us-ascii?Q?mUAGwiNB0sPYqMMno3BVB32q40MpMRP94UmGJkydgIp4XLEiRxilqpWO/H7I?=
 =?us-ascii?Q?VQGf+2O8/QJFhEMLQxFcSvsdEII/dtFjA2SX/7WuW1bjo8X24mMf8elhUe3V?=
 =?us-ascii?Q?+A80MwCnQ79QxL/hX5CLJ+wK3df7uHGnJM0v0hFGd9uWimJjHktlLxj7F6Qx?=
 =?us-ascii?Q?yNvcSnKK1s5D4nPKwFiTKa0h3ilkwInEtnA1qEcHLrQbzf2m6VFfIMbJoZ5B?=
 =?us-ascii?Q?08Uw+V8F5GC1Yvn8b4QBndui5WYZBO7kH+Sca0rzlTeXY4IY2SVLBtgAEmPm?=
 =?us-ascii?Q?8aQgWVnBxgRtbf5g8r01WXPBx20vKposc+7oPPHopIlcYSY5Q7241HPiqwrK?=
 =?us-ascii?Q?uBSo8wvFhO9dPqjuyOEHVOZX6j1ZvZczqJp4CdfKqnoTTUvUPW7pGoUL2sOV?=
 =?us-ascii?Q?kZlWLQfCOEFCPszGGked5prIvJqY6wrVNZwJGUqVaWwSOkQFB/jJ0AzJb+hb?=
 =?us-ascii?Q?MKOzadZrz//HP+1R+HWF8EncnYOsdft5u5f66wC5HINigccpsUdniNfOW1F8?=
 =?us-ascii?Q?NZ/SRNkuG5tcuBVqfUu4cRTO/Lzt3qPQua1M2JCSCu4h/XxY6/VyjhutPmJW?=
 =?us-ascii?Q?KmwhEkb4psqWAsuWWAZLPrT0xJ47TcwHPidKJl69KPZ42ZAXxojXF1e18Aji?=
 =?us-ascii?Q?W0VXa/3+aAVH9rJanXyYZnzT18BSPGvjpDqvgFA5JyN0otg1iyjPcwJGOI/e?=
 =?us-ascii?Q?PK4Yn3PRQMYfnjYrUutni8VP4S5xxVXePcER50MEChNhnzKCkCHU9+GNb4/p?=
 =?us-ascii?Q?O9PzG9wA/s6pQrVEpQ3p33pV2pIfW4RBzfBODF2mLZvhg5UWqHJNd4UnVyYS?=
 =?us-ascii?Q?AjKxe1v5MvKTC69OkSYZcZfQM7u1u3T9fuxZvrC+BC137nhvU6Hj7R2lYZn5?=
 =?us-ascii?Q?thfuqfUZ7c6zIdKHw9D4Ofq/nys4GA/xbm//?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 23:32:51.3537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d765abd1-b268-4fa8-4d9f-08dde8e6b3e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4495

The device under the reset will be attached to a blocked domain, while not
updating the group->domain pointer. So there needs to be a per-device flag
to indicate the reset state, for other iommu core functions to check so as
not to shift the attached domain during the reset state.

The regular device pointer can't store any private iommu flag. So the flag
has to be in the gdev structure.

Pass in the gdev pointer instead to the functions that will check that per
device flag.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 1e0116bce0762..e6a66dacce1b8 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -112,7 +112,7 @@ enum {
 };
 
 static int __iommu_device_set_domain(struct iommu_group *group,
-				     struct device *dev,
+				     struct group_device *gdev,
 				     struct iommu_domain *new_domain,
 				     unsigned int flags);
 static int __iommu_group_set_domain_internal(struct iommu_group *group,
@@ -602,7 +602,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	if (group->default_domain)
 		iommu_create_device_direct_mappings(group->default_domain, dev);
 	if (group->domain) {
-		ret = __iommu_device_set_domain(group, dev, group->domain, 0);
+		ret = __iommu_device_set_domain(group, gdev, group->domain, 0);
 		if (ret)
 			goto err_remove_gdev;
 	} else if (!group->default_domain && !group_list) {
@@ -2263,10 +2263,11 @@ int iommu_attach_group(struct iommu_domain *domain, struct iommu_group *group)
 EXPORT_SYMBOL_GPL(iommu_attach_group);
 
 static int __iommu_device_set_domain(struct iommu_group *group,
-				     struct device *dev,
+				     struct group_device *gdev,
 				     struct iommu_domain *new_domain,
 				     unsigned int flags)
 {
+	struct device *dev = gdev->dev;
 	int ret;
 
 	/*
@@ -2346,8 +2347,7 @@ static int __iommu_group_set_domain_internal(struct iommu_group *group,
 	 */
 	result = 0;
 	for_each_group_device(group, gdev) {
-		ret = __iommu_device_set_domain(group, gdev->dev, new_domain,
-						flags);
+		ret = __iommu_device_set_domain(group, gdev, new_domain, flags);
 		if (ret) {
 			result = ret;
 			/*
@@ -2379,7 +2379,7 @@ static int __iommu_group_set_domain_internal(struct iommu_group *group,
 		 */
 		if (group->domain)
 			WARN_ON(__iommu_device_set_domain(
-				group, gdev->dev, group->domain,
+				group, gdev, group->domain,
 				IOMMU_SET_DOMAIN_MUST_SUCCEED));
 		if (gdev == last_gdev)
 			break;
-- 
2.43.0


