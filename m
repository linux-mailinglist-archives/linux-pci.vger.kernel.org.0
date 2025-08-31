Return-Path: <linux-pci+bounces-35208-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56734B3D5F8
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 01:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16992178303
	for <lists+linux-pci@lfdr.de>; Sun, 31 Aug 2025 23:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB40D274B2A;
	Sun, 31 Aug 2025 23:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rri5+zJ/"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C83279351;
	Sun, 31 Aug 2025 23:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756683195; cv=fail; b=e/i2JOuHB5X4e/o2iQxMW+qRBB1XsCoy29mFopE0TRxufR6NCnoYQBlfX0w18KHuJb3cVJumi9wJ0ie3RVNy1XjrXoqCPaRDf8zEsdQckBGgCS5AXoabUVl3sdkPbyK138hjXAmVNoI9Dl3QIm3qtBi6y1uTcTR/W7H7cMS9gKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756683195; c=relaxed/simple;
	bh=/PbH6azi+ZlLOLTtSdG6EM0UCqTE4Z8kQuhPX2pssH0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rI0L3+EQjxdmAsw/YofmTNA+0vqZ3arkhq4engr9wemEgAqYxjDmsA8MfI6Z19LB+gpRgqKNDQT5UMNaURefpJSAj6ivEbhgmYWHOtigTqX+zV8I5qsixtoqlrfoq/EfQwpqgm6w3RzxqbVDp6+k9d2eJo8ipzrEf8gL4P3A5AE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rri5+zJ/; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMhvm74WV9OtXtDcz+VZTsid7acjxTfN1dug+zUBh+vktP5beqm95U3E3WFhjWd6USE2hs2FDnTMKl9ZNu99jIaQRljvOQBShuwa41Gt31UvilpBCeIpUgl5b+XdUoOegx3UnM+x7rRKY6ANlKytB0GnpcRMwOBiDWN7Q/HKOOqyr+I0PmWfuXu7UYdCgTs8Xr5Fd7M+nCcswOmMrCHDfarddz/mUY1GjDJ0PiuaJG5LhO4epZLozGTP5IKa5urezs3Ib61/bmJVQmZ9MTEaSBFSUDIfvzKtxleDIZm/mtRS6WAC/E0Dw9Pr01qeaf/lUtZj4SunCzs6b8iCYzIOGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHtVmei2QPyKqvT1UN7x5VSVzas3RncF2N/M/e6SA9s=;
 b=VNkqxeg1jBP3JWkawkHBwNIAb4eYYokOENjEHhMpoh92ii+bhQWpetYBAsBXNjRMQ/+9qDf3Og5X8YEeIb0N9aGg5xDrgZhl/fing0WMmB1wgi/WuCVby61grSrCFK054Q7Y+P2rqZ+aqS2FoLL0OVmMEEIE1KZ8Rdq4GRtwjpChuiLIqZyYeJQBBBF0oeXRTO0K1cXmdKtC9zPWYKr5ve6kDba2UGQtXYsDEJDtfnwjryIjA/UUGQDWy1x+OyIugW8spTGeDP2wDqN9ZnCaMD9sIFYYWkSGKSYEB88OJy1A5LfSZ/9j2GH4pR1Qra2BvmKIdOurWUrj1H2kvCEl5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHtVmei2QPyKqvT1UN7x5VSVzas3RncF2N/M/e6SA9s=;
 b=Rri5+zJ/7GyFSnc1dQlAFauxNWvvUw9NJ09Z18vDz35W063WbNhVK5DyEiVoLM6/TEc47s894mTdDtOaqnYxZctfK1VuvpsyKgIVqqGYsERJBHw+VXRtsOHkMJa2GhnzrjRmZHu8mRqwsZR/Wz0q/0Gev5D5ZYYtZYzApp999ps2UfJjKvttA4ItuzoaphV2rPFzl79fXP9jyX2UAM1aYrpBhT/Yo6DWePYuXOoma0AeF9greCyjh0shG7+m2qSn95fRPjOwWqDfn51w1G3rTQphKWB4bah40YLuinRP2pl284Al5Y2sIyoo2qdpSqaWt53ZaUHoTpX3xV64FTYT6A==
Received: from CH0PR04CA0103.namprd04.prod.outlook.com (2603:10b6:610:75::18)
 by DM4PR12MB7671.namprd12.prod.outlook.com (2603:10b6:8:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Sun, 31 Aug
 2025 23:33:05 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::5f) by CH0PR04CA0103.outlook.office365.com
 (2603:10b6:610:75::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.26 via Frontend Transport; Sun,
 31 Aug 2025 23:33:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Sun, 31 Aug 2025 23:33:04 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 31 Aug
 2025 16:32:46 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 31 Aug
 2025 16:32:45 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 31 Aug 2025 16:32:41 -0700
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
Subject: [PATCH v4 6/7] iommu: Introduce iommu_dev_reset_prepare() and iommu_dev_reset_done()
Date: Sun, 31 Aug 2025 16:31:58 -0700
Message-ID: <0f6021b500c74db33af8118210dd7a2b2fd31b3c.1756682135.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|DM4PR12MB7671:EE_
X-MS-Office365-Filtering-Correlation-Id: 5144388b-ffae-4cbd-b02b-08dde8e6bbff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qodEQecZJnPpLZV1ulg/q8uOrx7MdPWdK9kS3/23GOKMjTnowKaie4JOZWIJ?=
 =?us-ascii?Q?t6+clqhqg6ISz0FiIeuGyEAF+amPBt7TWUo5tMkv6A5sbzt4UEvK6Q6RWskW?=
 =?us-ascii?Q?J8y2DCZrRJvHB7FJaSTip9kbNXrTw4boM7s/5O3B/y6g9vRvoWdPrRperShU?=
 =?us-ascii?Q?oLh2XBM/iX1HfM7+3qUF0TBhvNz+W7oFp8JY2eNFiK2g+YPeN9LpFNdDzQho?=
 =?us-ascii?Q?hvbGK0iGQbDngnmsJLBmwU+1HlJ2K4Ae+BX/WJYS/zhL6WFuJ4FKDqgupf7d?=
 =?us-ascii?Q?a9t6jBNd3rQFE8TUrBN8eSEprKy10+XszBCfUriousS49jtNUOKRekyFt+tz?=
 =?us-ascii?Q?qO8oARgVBD9+Eq18pmEKguqOCZoukckBnU5BcKoYVf/H/6yReK5jSTPKIiVw?=
 =?us-ascii?Q?XGr2ONXhPOzjCMZ7Rkl735L0NFkn7T5g3Wi0kYnbAhDx8+MagaTGSgH1KgNn?=
 =?us-ascii?Q?znWZl3+qZbguoi0w6MSlE51ni0JNM/OTDPL3ka4Qnbg2hPtA0eebiKi9P37J?=
 =?us-ascii?Q?VK23UR+M54y+VusqnWrhM7pvmGbgl/LVDgZkS6BxDr///uyRIex1WeiqGCH0?=
 =?us-ascii?Q?1FyyfaKZJsR3wPepWEe6F6tOz7QW6mMhdTtP6QRFADbEEiApNFAzNW/9FCQA?=
 =?us-ascii?Q?JylqTU1ikN0tooj8G/d5GnmXLnZ2tPGfwjuifMY1br98njvsGQN1MQ9GrV5F?=
 =?us-ascii?Q?Q71QZSqwqJCaa3ENl2Yv5VKZAYU1suWkgSr4fl9Jp+WUi4xwtoSqIWhG8N/2?=
 =?us-ascii?Q?dWtP+WQ9W/JvM0LW1nnzaKKGD4S9B2jl0UOS+gANQWscphxQtZTnq1fdblKU?=
 =?us-ascii?Q?sWGUzGlFf1YQ50/92Q8QBYpyJGJj6TGibjlzyONYXWIIBGdKqXa16NWRSps/?=
 =?us-ascii?Q?rQ87/rqftOn/p/eLGrC4L8HxZyvqKG2R6qB0jaioyhJLobIgL0ZXaK3vmkWw?=
 =?us-ascii?Q?ynCFgzLwy5YfSQ7/tHdIbyZ5PUEAmEzjVc8zlb/gFq9MCsKwTJOKsmRHTae5?=
 =?us-ascii?Q?O8CQiCNgUEZjWovkUof1aLw4NMYd0ms28B293qqC8n5xyIvxE2CCB3/ks993?=
 =?us-ascii?Q?mOpBdHpR/IjZxWKgO4XTdrF4MEUu0ovFaF4Dskwe3CL2tCjPsozRQW0Byy5A?=
 =?us-ascii?Q?HZRJvHFNGUWgTjJkRBA3MAoQCwuL+H5d4SUHv7mM+HKh8swh4wJS/BdS9tni?=
 =?us-ascii?Q?9BefC4pnlLQlmOiTwls4aSo5viJCs7NWU6gHaZsDX5yagZVrFvr6WCUn17wv?=
 =?us-ascii?Q?eDwajQiGmLyy4cdObbR1thnurA/ACCu0Q4h6caE/v5VBs2VMWvO1JWRusihK?=
 =?us-ascii?Q?kIzI26R8DOLLUW8LgVJe5fSog410s0PMEtqkyE24JSn25hULb/37WiAeryAX?=
 =?us-ascii?Q?ep7/TpRfO9Eveug58k1kP91XXPtzU5Rol6ukp9spmxnDloRZVu4b+lN//BAl?=
 =?us-ascii?Q?WY0SP66AoS3D8T+hMRlBESUYxluYfWwFbaXi4uclOus8ARpvhOH7CI4+Kv/5?=
 =?us-ascii?Q?O3Qlou/IM7uwnzn39dKWiPyfNCGdHpsgYHpU?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 23:33:04.0533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5144388b-ffae-4cbd-b02b-08dde8e6bbff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7671

PCIe permits a device to ignore ATS invalidation TLPs, while processing a
reset. This creates a problem visible to the OS where an ATS invalidation
command will time out. E.g. an SVA domain will have no coordination with a
reset event and can racily issue ATS invalidations to a resetting device.

The OS should do something to mitigate this as we do not want production
systems to be reporting critical ATS failures, especially in a hypervisor
environment. Broadly, OS could arrange to ignore the timeouts, block page
table mutations to prevent invalidations, or disable and block ATS.

The PCIe spec in sec 10.3.1 IMPLEMENTATION NOTE recommends to disable and
block ATS before initiating a Function Level Reset. It also mentions that
other reset methods could have the same vulnerability as well.

Provide a callback from the PCI subsystem that will enclose the reset and
have the iommu core temporarily change all the attached domain to BLOCKED.
After attaching a BLOCKED domain, IOMMU hardware would fence any incoming
ATS queries. And IOMMU drivers should also synchronously stop issuing new
ATS invalidations and wait for all ATS invalidations to complete. This can
avoid any ATS invaliation timeouts.

However, if there is a domain attachment/replacement happening during an
ongoing reset, ATS routines may be re-activated between the two function
calls. So, introduce a new pending_reset flag in group_device, and reject
any concurrent attach_dev/set_dev_pasid call during a reset for a concern
of compatibility failure.

There are two corner cases that won't work:
1. Alias devices that share the same RID
   Blocking one device also blocks the other alias devices that might not
   want a reset. Given that it's very rare for an alias device to support
   ATS, simply skip the blocking routine.

2. SRIOV devices that its PF is resetting while its VF isn't.
   Both PF and VF should block RID and PASIDs. But, since VF is not aware
   of the reset, it is difficult to block it and reject concurrent attach
   calls, because it's not logically reasonable to reject a VF attachment
   due to a resetting PF unless the VF is resetting too. To address this,
   we won't be able to reject any concurrent attachment as simple as this
   patch does; instead we will need two new compatibility testing ops for
   attach_dev/set_dev_pasid to allowing caching a compatible attach. This
   itself, however, would be a big series. So, for now, skip the blocking
   routine for PF devices, and leave a note.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h |  12 +++
 drivers/iommu/iommu.c | 199 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 211 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 6d6d068c3de48..0d8e252929c89 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1169,6 +1169,9 @@ void dev_iommu_priv_set(struct device *dev, void *priv);
 extern struct mutex iommu_probe_device_lock;
 int iommu_probe_device(struct device *dev);
 
+int iommu_dev_reset_prepare(struct device *dev);
+void iommu_dev_reset_done(struct device *dev);
+
 int iommu_device_use_default_domain(struct device *dev);
 void iommu_device_unuse_default_domain(struct device *dev);
 
@@ -1453,6 +1456,15 @@ static inline int iommu_fwspec_add_ids(struct device *dev, u32 *ids,
 	return -ENODEV;
 }
 
+static inline int iommu_dev_reset_prepare(struct device *dev)
+{
+	return 0;
+}
+
+static inline void iommu_dev_reset_done(struct device *dev)
+{
+}
+
 static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
 {
 	return NULL;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f08c177f30de8..bcc239f3592f4 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -71,12 +71,29 @@ struct group_device {
 	struct list_head list;
 	struct device *dev;
 	char *name;
+	bool pending_reset : 1;
 };
 
 /* Iterate over each struct group_device in a struct iommu_group */
 #define for_each_group_device(group, pos) \
 	list_for_each_entry(pos, &(group)->devices, list)
 
+/* Callers must hold the dev->iommu_group->mutex */
+static struct group_device *device_to_group_device(struct device *dev)
+{
+	struct iommu_group *group = dev->iommu_group;
+	struct group_device *gdev;
+
+	lockdep_assert_held(&group->mutex);
+
+	/* gdev must be in the list */
+	for_each_group_device(group, gdev) {
+		if (gdev->dev == dev)
+			break;
+	}
+	return gdev;
+}
+
 struct iommu_group_attribute {
 	struct attribute attr;
 	ssize_t (*show)(struct iommu_group *group, char *buf);
@@ -2157,6 +2174,12 @@ int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 
 	guard(mutex)(&dev->iommu_group->mutex);
 
+	/*
+	 * There is a concurrent attach while the device is resetting. Defer it
+	 * until iommu_dev_reset_done() attaching the device to group->domain.
+	 */
+	if (device_to_group_device(dev)->pending_reset)
+		return -EBUSY;
 	return __iommu_attach_device(domain, dev, NULL);
 }
 
@@ -2201,6 +2224,16 @@ struct iommu_domain *iommu_get_domain_for_dev_locked(struct device *dev)
 
 	lockdep_assert_held(&group->mutex);
 
+	/*
+	 * Driver handles the low-level __iommu_attach_device(), including the
+	 * one invoked by iommu_dev_reset_done(), in which case the driver must
+	 * get the blocking domain over group->domain caching the one prior to
+	 * iommu_dev_reset_prepare(), so that it wouldn't end up with attaching
+	 * the device from group->domain (old) to group->domain (new).
+	 */
+	if (device_to_group_device(dev)->pending_reset)
+		return group->blocking_domain;
+
 	return group->domain;
 }
 EXPORT_SYMBOL_GPL(iommu_get_domain_for_dev_locked);
@@ -2309,6 +2342,13 @@ static int __iommu_device_set_domain(struct iommu_group *group,
 		dev->iommu->attach_deferred = 0;
 	}
 
+	/*
+	 * There is a concurrent attach while the device is resetting. Defer it
+	 * until iommu_dev_reset_done() attaching the device to group->domain.
+	 */
+	if (gdev->pending_reset)
+		return -EBUSY;
+
 	ret = __iommu_attach_device(new_domain, dev, old_domain);
 	if (ret) {
 		/*
@@ -3394,6 +3434,15 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
 	int ret;
 
 	for_each_group_device(group, device) {
+		/*
+		 * There is a concurrent attach while the device is resetting.
+		 * Defer it until iommu_dev_reset_done() attaching the device to
+		 * group->domain.
+		 */
+		if (device->pending_reset) {
+			ret = -EBUSY;
+			goto err_revert;
+		}
 		if (device->dev->iommu->max_pasids > 0) {
 			ret = domain->ops->set_dev_pasid(domain, device->dev,
 							 pasid, old);
@@ -3815,6 +3864,156 @@ int iommu_replace_group_handle(struct iommu_group *group,
 }
 EXPORT_SYMBOL_NS_GPL(iommu_replace_group_handle, "IOMMUFD_INTERNAL");
 
+/**
+ * iommu_dev_reset_prepare() - Block IOMMU to prepare for a device reset
+ * @dev: device that is going to enter a reset routine
+ *
+ * When certain device is entering a reset routine, it wants to block any IOMMU
+ * activity during the reset routine. This includes blocking any translation as
+ * well as cache invalidation too (especially the device cache).
+ *
+ * This function attaches all RID/PASID of the device's to IOMMU_DOMAIN_BLOCKED
+ * allowing any blocked-domain-supporting IOMMU driver to pause translation and
+ * cahce invalidation, but leaves the software domain pointers intact so later
+ * the iommu_dev_reset_done() can restore everything.
+ *
+ * Return: 0 on success or negative error code if the preparation failed.
+ *
+ * Caller must use iommu_dev_reset_prepare() and iommu_dev_reset_done() together
+ * before/after the core-level reset routine, to unclear the pending_reset flag.
+ *
+ * These two functions are designed to be used by PCI reset functions that would
+ * not invoke any racy iommu_release_device(), since PCI sysfs node gets removed
+ * before it notifies with a BUS_NOTIFY_REMOVED_DEVICE. When using them in other
+ * case, callers must ensure there will be no racy iommu_release_device() call,
+ * which otherwise would UAF the dev->iommu_group pointer.
+ */
+int iommu_dev_reset_prepare(struct device *dev)
+{
+	struct iommu_group *group = dev->iommu_group;
+	struct group_device *gdev;
+	unsigned long pasid;
+	void *entry;
+	int ret = 0;
+
+	if (!dev_has_iommu(dev))
+		return 0;
+
+	/*
+	 * FIXME resetting a PF will reset any VF in the hardware level, so this
+	 * should basically block both the PF and its VFs. On the other hand, VF
+	 * software might not go through a reset, so it can run into any regular
+	 * operation like invoking a concurrent attach_dev/set_dev_pasid call.
+	 *
+	 * Due to compatibility concern, any concurrent attach_dev/set_dev_pasid
+	 * is being rejected with -EBUSY. For a PF, this rejection is reasonable
+	 * and simple since a concurrent attachment would not be sane. For a VF,
+	 * however, it would be difficult to justify.
+	 *
+	 * One way to work this out is to have a new op running a compatibility
+	 * test for a concurrent attachment. Then, so long as it is compatible,
+	 * the attachment would be deferred to iommu_dev_reset_done(). Bypass PF
+	 * devices for now.
+	 */
+	if (dev_is_pci(dev) && pci_num_vf(to_pci_dev(dev)) > 0)
+		return 0;
+
+	guard(mutex)(&group->mutex);
+
+	/* We cannot block an RID that is shared with another device */
+	if (dev_is_pci(dev)) {
+		for_each_group_device(group, gdev) {
+			if (gdev->dev != dev && dev_is_pci(gdev->dev) &&
+			    pci_devs_are_dma_aliases(to_pci_dev(gdev->dev),
+						     to_pci_dev(dev)))
+				return 0;
+		}
+	}
+
+	ret = __iommu_group_alloc_blocking_domain(group);
+	if (ret)
+		return ret;
+
+	/* Stage RID domain at blocking_domain while retaining group->domain */
+	if (group->domain != group->blocking_domain) {
+		ret = __iommu_attach_device(group->blocking_domain, dev,
+					    group->domain);
+		if (ret)
+			return ret;
+	}
+
+	/*
+	 * Stage PASID domains at blocking_domain while retaining pasid_array.
+	 *
+	 * The pasid_array is mostly fenced by group->mutex, except one reader
+	 * in iommu_attach_handle_get(), so it's safe to read without xa_lock.
+	 */
+	xa_for_each_start(&group->pasid_array, pasid, entry, 1)
+		iommu_remove_dev_pasid(dev, pasid,
+				       pasid_array_entry_to_domain(entry));
+
+	device_to_group_device(dev)->pending_reset = true;
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_dev_reset_prepare);
+
+/**
+ * iommu_dev_reset_done() - Restore IOMMU after a device reset is finished
+ * @dev: device that has finished a reset routine
+ *
+ * When certain device has finished a reset routine, it wants to restore its
+ * IOMMU activity, including new translation as well as cache invalidation, by
+ * re-attaching all RID/PASID of the device's back to the domains retained in
+ * the core-level structure.
+ *
+ * Caller must pair it with a successfully returned iommu_dev_reset_prepare().
+ *
+ * Note that, although unlikely, there is a risk that re-attaching domains might
+ * fail due to some unexpected happening like OOM.
+ */
+void iommu_dev_reset_done(struct device *dev)
+{
+	struct iommu_group *group = dev->iommu_group;
+	struct group_device *gdev;
+	unsigned long pasid;
+	void *entry;
+
+	if (!dev_has_iommu(dev))
+		return;
+
+	guard(mutex)(&group->mutex);
+
+	gdev = device_to_group_device(dev);
+
+	/* iommu_dev_reset_prepare() was not successfully called */
+	if (WARN_ON(!group->blocking_domain))
+		return;
+
+	/* iommu_dev_reset_prepare() was bypassed for the device */
+	if (!gdev->pending_reset)
+		return;
+
+	/* Re-attach RID domain back to group->domain */
+	if (group->domain != group->blocking_domain) {
+		WARN_ON(__iommu_attach_device(group->domain, dev,
+					      group->blocking_domain));
+	}
+
+	/*
+	 * Re-attach PASID domains back to the domains retained in pasid_array.
+	 *
+	 * The pasid_array is mostly fenced by group->mutex, except one reader
+	 * in iommu_attach_handle_get(), so it's safe to read without xa_lock.
+	 */
+	xa_for_each_start(&group->pasid_array, pasid, entry, 1)
+		WARN_ON(__iommu_set_group_pasid(
+			pasid_array_entry_to_domain(entry), group, pasid,
+			group->blocking_domain));
+
+	gdev->pending_reset = false;
+}
+EXPORT_SYMBOL_GPL(iommu_dev_reset_done);
+
 #if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
 /**
  * iommu_dma_prepare_msi() - Map the MSI page in the IOMMU domain
-- 
2.43.0


