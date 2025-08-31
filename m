Return-Path: <linux-pci+bounces-35204-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6183CB3D5DD
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 01:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9DBE1898660
	for <lists+linux-pci@lfdr.de>; Sun, 31 Aug 2025 23:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B87276051;
	Sun, 31 Aug 2025 23:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m5mcKvxj"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52FD272E66;
	Sun, 31 Aug 2025 23:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756683171; cv=fail; b=U8fDw42EOs4EopPv/P448uqn1MhJ2/IEWV1eAMGu2eGfVbgXj1mZ84qlDN7CCn5rc5y/52xaMuywXFeiRZE3CLqrcSvQ5pL+AnlMSBp6akYSq6hXj+ruIFoLi9UeRIlKV5P4rBukqHQ13mL6K/7ZmG/ewAUj9KbkPdFLYMjpk2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756683171; c=relaxed/simple;
	bh=ZU4aAd/YjLc/j6TYx+FF+rTqQlFU1ZsNGMFL3+5AjgY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AsX/c5ub5Qv0YwCiZl8a6REL9KKFYe3rbOTTKP+m8ffchZaUmGGNr7l92iav533zfJTB+cs5417PwPsQd+apoJ6dw53NkTRipgcFsO4GzHZQpWR3n1m5OG3ztIQ5Mttfn3Lk19owMnfol+MJkpkwZgNhU6yTeC/YR45vvw+yT68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m5mcKvxj; arc=fail smtp.client-ip=40.107.237.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QtESnVE2yaIFH16vArqS6gnczit4lp1tsaNBSX/+fEjDzBgp4qpTVKJAIle/Jps621ymoy36jZ92M4kIiaFxAOtHN9GzYnmlDaTdTRjkBHV7CYhQZf4QieTErREmuWUDNq4R3h3+H+38OeESqVIgmezx2qxeXJjoJ2FJtXe9gEAoP0Uvypd1NSu0mwdCieZub9xkhumuHHwVnGWUw9CS/NgYLpCPJT+GaJUu4+PCf7JjYKEG0+3V5OVgus8JsfCGF/ZvMyn0OUs6fDS1a1b2vIDF/KA3Pmlkcq/CMhDK3HweRvOx6frPkyI3cqgpn+jHydD1Hky6giaAQpNHEy4o2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLthldXggp3+AYls+acQj8/XBDMDbNe4wa438UBBpDU=;
 b=g9UV4/6mrBeOacKpmHGpM0Y34G6kXte5hGk+ywt4ANPAdyYtSOPLoG+po3NkMYTrd+4I3yS35z+fesNyoI5wPRCu9t/LeATs+IzvSgslqL6Ipg8vAavWGAyt1hA2zSDSZ9W3DYM9vNGK5S7m9r6DmufI/27ExvNCdM3Am7w998C/SbLbBTEnfcaOmRDXz8dIqZxO1M5nW2y2l+Bq2sGsLaVuNcOKC4MwpbcCLJaOB5cwgVjNPI99Hu+SSv9pu7UDKj22BxIFvFG5LWiuy+pmsIfuRL8wdAzgNPqjgf0kqQUWvlhezCVMP3zbSl+DVz+hUs6ulxR3NhlpkxRMGiuGNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLthldXggp3+AYls+acQj8/XBDMDbNe4wa438UBBpDU=;
 b=m5mcKvxjP7h7N8me8GKxFKL5eQsCMxPw3nbpR2s08bXPrWyyWCGNzzNYOdAIbyPrITQIy84pANJcQVWDdaSssR1kIP7R5UfFgUMZwNTrHjtovJRM5FR6u22cGhCgHg7bse7NMmm/OyWYMmLeMbdiZsSmICtDJdcYOSSmeA16w/T8uFrYtExjVgNR0/hAxiuhdWXa1L5baaxugJbHhsiAq3rUeZLQQZAw2g/dK1g1jiGhHX6sKtPNxu/1R/5VFpd5P20WLUfSPA6yA57NvOjaCqPya3r877dUdhptJSTq3IK38Xin3Ra/+EYn4b7LBP/WRA7uIQWsPQnGKvuF5AUJwQ==
Received: from SJ0PR03CA0349.namprd03.prod.outlook.com (2603:10b6:a03:39c::24)
 by DS0PR12MB7746.namprd12.prod.outlook.com (2603:10b6:8:135::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Sun, 31 Aug
 2025 23:32:45 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::f8) by SJ0PR03CA0349.outlook.office365.com
 (2603:10b6:a03:39c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.26 via Frontend Transport; Sun,
 31 Aug 2025 23:32:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Sun, 31 Aug 2025 23:32:44 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 31 Aug
 2025 16:32:27 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 31 Aug
 2025 16:32:23 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 31 Aug 2025 16:32:19 -0700
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
Subject: [PATCH v4 1/7] iommu/arm-smmu-v3: Add release_domain to attach prior to release_dev()
Date: Sun, 31 Aug 2025 16:31:53 -0700
Message-ID: <c6bc114e438779129a891408af7d997bf6c28b5b.1756682135.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|DS0PR12MB7746:EE_
X-MS-Office365-Filtering-Correlation-Id: 881cf294-7bf2-4d66-6f38-08dde8e6aff1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bVzTaSdMStU/qCn09ERYjoJRbQHIcLq/Zgbh/iiFqxWoUouFvwrl/h/fI1xe?=
 =?us-ascii?Q?07gGA4S3a0k3SQ+KfzY3o/QvmkBAdlVLVCiNzHbQaDZgq9gvVlKoHQNbdqdU?=
 =?us-ascii?Q?+SLBTV3zbPdCSdxM5y9ab+uqVu7ehLUmzBnuK2LfS/yT7LTAcuEb63P+YWwN?=
 =?us-ascii?Q?Pk3pEWTa9Rc1br84TjCBa3NAo436TIqRyZvuM4+tt5vQ1O70duUCXirAznXe?=
 =?us-ascii?Q?sHoJP3lPitWsGf2JjdEpfe+8McgXKivi49hvQyAcM98onBcDEohOP9CA9F9R?=
 =?us-ascii?Q?uGJoB3gUYYcO/sE8KJfpv7Onl8Ain5XR8izyAGfutYkvtZqEiEt8VWc35lnB?=
 =?us-ascii?Q?6m85wJyjqLFUkz46sAu2fekef25mPsbXBimSxE2y7GYW+Iwp8FkjpuiDbD+k?=
 =?us-ascii?Q?kj2maZqYILCqYbhk34odJCAnp/phFivHXAM/CLoEIAXydJiQLm6zbffCrfpy?=
 =?us-ascii?Q?a7j5qtChhUyfo4i8+gsHZz8h2B9jwmrGr//FzI5cgJwI3DK+hj2CzhXlrVO7?=
 =?us-ascii?Q?Es2uuB6soqwv9xGPySv/FSseUq+e1LbBMaZSnNCrCWXJuvKcw07pkAhvkBog?=
 =?us-ascii?Q?qr3G8qg85Eg9axndPrtMKhVYIxIHT1J6hpjMzxyXZAEAXwg6visct/1l8tay?=
 =?us-ascii?Q?aGRKnzNVwIkEAvukec6F+GnNlmzCG/MacS8xX2a9kNiqjnkQ92vRtfA1WZlJ?=
 =?us-ascii?Q?OoKLsWvy52mVTWWXysR95oa09flja2ScyNFP0M5aJr82WBv2SqArrvlJo1bs?=
 =?us-ascii?Q?jM0VSrCSCn4fkoj2QUzBRWHxR8p02ksEuOgoB9RJ/jcfq4CYONYvQIPcEXDh?=
 =?us-ascii?Q?dvwuwS7FPXblJTHlM4zwU8c7uHkbtN8+EtCDK/u3zBpVZWU2Mz1Xh1yz17Mw?=
 =?us-ascii?Q?gAiH8n3V6ZHk2CqYYUfSwJWos/JAg38NPZsv481ylAvQN8f0K/r9jWheFCzB?=
 =?us-ascii?Q?X0YSLITYtb2b+HqnkNp3d4vUHklENF6uh/b8qry3z4lxvmC3cdqPWJE0J1s7?=
 =?us-ascii?Q?QMGWsi4Z3F2PIlc3gWV6J4U5stNLjw3hU1EddEbwcVxlHVig+rD0GmhgNOD4?=
 =?us-ascii?Q?fUFyt5G3nnewj5R/ofBD2eBqJ+Fe3Cc6wqBOnjLPV8LpHnd/9DclpfWizKB/?=
 =?us-ascii?Q?QtvWhDxW3qJmFlQkm9EXJfDzvYzMQfH1L7ol7s75R1WGlTHvdJfcL5i7Ulrc?=
 =?us-ascii?Q?dWyFOrZFiyHQ5Sh8FoEWg3AfGqf0Q6fuzD3HFTnN7IC1vCec2spQgBg8S0L1?=
 =?us-ascii?Q?tjdiBgEJbTgif4jOneUmHbCSlj5/CSdfgcuKSysmvvRxMc7bmJUwMDcRKswh?=
 =?us-ascii?Q?imyP47l7xpluP8GOK8FWNaOHQZx68WhleyHH5UgrD0w2WD5UvJc55Ov4zN07?=
 =?us-ascii?Q?QD3bFNv85i982gWVupUhMfV3VDF8f371TYqndsQYZVnYiNJNwr65wgdOzsvK?=
 =?us-ascii?Q?Vtke1MFcwttUPM4FYOUOnoZsFz8h4p/mqUyUk/7i+ufV+9PdXF2UHbNJNFRr?=
 =?us-ascii?Q?2RrAjw2OLBVP4tRUwEXw0aT7/kuXfVcNw6JF?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 23:32:44.7412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 881cf294-7bf2-4d66-6f38-08dde8e6aff1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7746

The iommu_get_domain_for_dev() helper will be reworked to check a per-gdv
flag, so it will need to hold the group->mutex. This will give trouble to
existing attach_dev callback functions that call the helper for currently
attached old domains, since group->mutex is already held in an attach_dev
context.

To address this, step one is to pass in the attached "old" domain pointer
to the attach_dev op, similar to set_dev_pasid op.

However, the release_dev op is tricky in the iommu core, because it could
be invoked when the group isn't allocated, i.e. no way of guarateeing the
group->mutex being held. Thus, it would not be able to do any attachment
in the release_dev callback function, arm_smmu_release_device() here.

Add a release_domain, moving the attach from arm_smmu_release_device() to
the iommu_deinit_device() in the core, so that arm_smmu_release_device()
will not need to worry about the group->mutex.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 34 ++++++++++++++++-----
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5968043ac8023..1a21d1a2dd454 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3291,6 +3291,31 @@ static struct iommu_domain arm_smmu_blocked_domain = {
 	.ops = &arm_smmu_blocked_ops,
 };
 
+static int arm_smmu_attach_dev_release(struct iommu_domain *domain,
+				       struct device *dev)
+{
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+
+	WARN_ON(master->iopf_refcount);
+
+	/* Put the STE back to what arm_smmu_init_strtab() sets */
+	if (dev->iommu->require_direct)
+		arm_smmu_attach_dev_identity(&arm_smmu_identity_domain, dev);
+	else
+		arm_smmu_attach_dev_blocked(&arm_smmu_blocked_domain, dev);
+
+	return 0;
+}
+
+static const struct iommu_domain_ops arm_smmu_release_ops = {
+	.attach_dev = arm_smmu_attach_dev_release,
+};
+
+static struct iommu_domain arm_smmu_release_domain = {
+	.type = IOMMU_DOMAIN_BLOCKED,
+	.ops = &arm_smmu_release_ops,
+};
+
 static struct iommu_domain *
 arm_smmu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 				   const struct iommu_user_data *user_data)
@@ -3580,14 +3605,6 @@ static void arm_smmu_release_device(struct device *dev)
 {
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 
-	WARN_ON(master->iopf_refcount);
-
-	/* Put the STE back to what arm_smmu_init_strtab() sets */
-	if (dev->iommu->require_direct)
-		arm_smmu_attach_dev_identity(&arm_smmu_identity_domain, dev);
-	else
-		arm_smmu_attach_dev_blocked(&arm_smmu_blocked_domain, dev);
-
 	arm_smmu_disable_pasid(master);
 	arm_smmu_remove_master(master);
 	if (arm_smmu_cdtab_allocated(&master->cd_table))
@@ -3678,6 +3695,7 @@ static int arm_smmu_def_domain_type(struct device *dev)
 static const struct iommu_ops arm_smmu_ops = {
 	.identity_domain	= &arm_smmu_identity_domain,
 	.blocked_domain		= &arm_smmu_blocked_domain,
+	.release_domain		= &arm_smmu_release_domain,
 	.capable		= arm_smmu_capable,
 	.hw_info		= arm_smmu_hw_info,
 	.domain_alloc_sva       = arm_smmu_sva_domain_alloc,
-- 
2.43.0


