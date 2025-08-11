Return-Path: <linux-pci+bounces-33803-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C623B218DC
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 01:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E17914281CD
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 23:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A302E2F03;
	Mon, 11 Aug 2025 23:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bYwF5PTq"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073262DBF5E;
	Mon, 11 Aug 2025 23:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754953243; cv=fail; b=cQ2pXGQfk25Utj55cu1w8WFpKZb/Mh+p9Ch/NEbGmrzglSEr2SCfMabt8XUnH3lPaLJ4j8bDrviBxqx0a41l0rAuzpkIzGqlevBiHHWmEYLdmF3e8DnU+F13cUT0WBwdH4NXKZuivriX+Ww+2SbKl6javT52iybysM+DfI+4bBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754953243; c=relaxed/simple;
	bh=HCi5bYcdOvcuzoFgBFPLc6JDerw4Ofs3giF/UTt9Bng=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OevVPRlXBgcYiI1QOnUzRhRudInhVjbFRe5ziwhP9CHtYhm/0pHPZZKjdWv3zkbrGHIvTwPHZztnqSZl4Kx1S43GZZ7BWSSW7JiDSWXDMXfYoChuCh8mG1lSXpMVGMv0nL572Opn/HcY/ZwRZ+mG7hXdOzfmaFgSiI2/dG8TkrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bYwF5PTq; arc=fail smtp.client-ip=40.107.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PalOr7oTp9YzfY2AfoDWnMqj2OYvxR0MEasHvqVrbE3hIDzya7T9qso9K+ceePLzARWaLSkCQrjrzyn3m6pgc350lA3dx2lOCFoXhLnnEEzuh3Dyl51ebf9WRcwkMsCayg6P9041joPWFgOIISSrr8ztEvNmbOJB1sJMO4ra3gcAYi3oy2cW47Ph+Y75tN4GyL9HirCyj98A3/6xS2pf8ftJU4aKkKiemdc4OUrkP//lJqyDMiCqC1CrjambrYeyNAdd7mGpc9wwhaB4sduem6wE52CGzidccoL18zbXewA4fjSRk+lbUmqVhWJOar9pYEOk1HFd3cSCratEgrYtDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xvIRnzoRWvKDDGNPGC61Omj4+C3URY5mGthprH0ODY=;
 b=XD5qYlOElPgby1gwwsnUI9a07XNfNIT82pJVoFlx2oHcev1oAEtmKbZsHFJ1JYypA13iuk8ymrITWvpl4MFDkW9DTAcPUlKPrEciGiSWdCu+icIIUUaxStrM13MFnuUu1pInIYb5+yT2UTCKKs9NqWmYyXcFlrlMUiHh5KMSGxr+ugbqVoPM5au6gO2SyLbByEtF2E6lF3GGVx5M3hrVMJtlOzwO1Pg1G4kJSnN5KvSHjce14IoV1m9wlDNIM3msbUqrvRXIEQ9LTsweb+1onmKAM8lJuKxY8YGtbHG9QlX/uBqb9cO3E7345Yq7i5s6LdBebST1U0RortZGA3hkPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xvIRnzoRWvKDDGNPGC61Omj4+C3URY5mGthprH0ODY=;
 b=bYwF5PTqISswhPK8dcu9srk2Xnbq0nLs/EZcKNiDSFZj3OvWxpEGL/wnafd5jHHeCOCKP9xJ6GNm1QH0pt2uRwgPj9EpjLWJROz2r2Z0hahcrSGN5ADhbXpq+Z0s+hCL04jyBr0vYXhVeQ9fTEYNfnxWq0RElef5tpWyLHe7LHnSX9lALQ96hseokmhpgofbmKAfhHoNwowSOpOpJvlsBV+Mst+8so+VgaTJi+O4l0/5cjg+YiQDlIagDwdD0Oyun7av3WWNrN7D/sp75AxSHfvCpBcUtTWpRagukfigJ9Bt6yZhLJNz3n5ypbDKV/FiZA8OCiMjb+mxgL/hGaIiEw==
Received: from BN9PR03CA0172.namprd03.prod.outlook.com (2603:10b6:408:f4::27)
 by CH8PR12MB9744.namprd12.prod.outlook.com (2603:10b6:610:27a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Mon, 11 Aug
 2025 23:00:29 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:408:f4:cafe::20) by BN9PR03CA0172.outlook.office365.com
 (2603:10b6:408:f4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.21 via Frontend Transport; Mon,
 11 Aug 2025 23:00:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 23:00:28 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 11 Aug
 2025 16:00:08 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 11 Aug
 2025 16:00:07 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 11 Aug 2025 16:00:06 -0700
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
Subject: [PATCH v3 2/5] iommu: Pass in gdev to __iommu_device_set_domain
Date: Mon, 11 Aug 2025 15:59:09 -0700
Message-ID: <b07a15780fd5a8c688f1ae6285438a112a9b9478.1754952762.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|CH8PR12MB9744:EE_
X-MS-Office365-Filtering-Correlation-Id: 29edf4d8-f3f0-437b-bc7a-08ddd92addb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/XydIOAe9DrCLIhcUHFa2uiZhAi7UeaZWNQgGZ9rHcwD1/J9+u0neCzOqDZo?=
 =?us-ascii?Q?uAebtkAgKWlzREz3V9aMu4vPz8Xj0K942LK/sxvaHuHR9wIu8hIvSRYESBEp?=
 =?us-ascii?Q?SqrsuM6EPzsnCqSUGkRZSYczwPCww2x3YdcGw4C8u5E/9L/sVJrbXrgs9+an?=
 =?us-ascii?Q?jmTFY2b5nSZgIvL0zNrwJXiJ/ieVoCSEHM4n4w8KrUY9y2NMblRpnj4QcOZT?=
 =?us-ascii?Q?UCj9VY4xArtKYkQZFDJ28uzUnLlXAfa2M4GAkqXomZCrsnmmZ8zun5u0eJIJ?=
 =?us-ascii?Q?FGXQCX4UIMdZi70n5ks6Xbvue90gkKsZuYzaBiXTZCFTeKsK1IZHF4S2TCV2?=
 =?us-ascii?Q?aekQL/T+lRoink6eLNTqoasrAEvZz1Bm27IWOXeQ4Z93vHR5epSBVBWnNJTi?=
 =?us-ascii?Q?TgnIGYEQCfqpLtAvrloq9LwydURwFRJntnRZHME0hnLMiwz67pKvDso+GAq8?=
 =?us-ascii?Q?jGD57XNjgTxM5iakXry3mfj/vBVlAF8Z0V1hmU9tBIzKz+bANvlIandxrnDy?=
 =?us-ascii?Q?iR5FQgnFqnr0KHOJ+XUFNKKqJs2CvoBBR1rylJzsAdTE1cvrKN0s/MVdafSa?=
 =?us-ascii?Q?vaieU5exjd25RDeRfnwQPUp187oC0NyrGWya/rTPrO+Q048u5DhhLi9b6HRF?=
 =?us-ascii?Q?ag41zVsH2hH8trvGHqGiosqDJ46kyRWXcQxGUI3R4RvgdMCtAVDzStdGXHmN?=
 =?us-ascii?Q?/tbiHjAphFmGrPJRuKwBuYZuMePu3FvtKEIJP9SGuUq8izrrUG3hq3iR5p/7?=
 =?us-ascii?Q?bERdr3IJbexga3I4/EEUDxDaVeULhLkuKcZF6A94G1wD1qfV8e6SAAXRB+M1?=
 =?us-ascii?Q?sHKrX9wzOXTXuV+HgizSnLVwjiS1hAG/S1/iY8dG8GcBdmdMHtYWun817QbY?=
 =?us-ascii?Q?8aEuPvF1iOX6xk6lsRtiZuX+IteR/1HxUYvpsc9HKBk0r+/Qr3Qokdk7I3H1?=
 =?us-ascii?Q?+5s6Y+pfuYuxAo55gDmOuS29LVivnnPg/NHiaozxrECvka0L/EBH/lI2gJQV?=
 =?us-ascii?Q?dwjnWOvTKk7Kv9A0byKpZkNZLxyzgkl2lJnLMaTB/nrXcxhjlpyeGTE0kq28?=
 =?us-ascii?Q?8CILI7FyMs9OKQn5LbFKzvTs7oApjBqGt/TaepG6TgOrvGyUKSq6RUsHQrV3?=
 =?us-ascii?Q?IP0tUQuJvWqmxttJWtuG8Ewd+4TkrVfwqn+/M5RzLCfpV8lRuQ3oCV/DdTlY?=
 =?us-ascii?Q?m6CvGbmGbo6yMOgRsw5YsqH9M17Hk3lCvmlN5GXtzekbNo/wrxBrTVL/4X5x?=
 =?us-ascii?Q?k98ju0FAns7GiX46Fb1zL3u4G07JLJuxxbj6nX5VSZGisnAajNW5i15yerUS?=
 =?us-ascii?Q?5H9GMmIRQOdX2nhJu//wvXQUq/T1kQrBuzh1NIIIDKQFdJLHIreBuXB1Sqzy?=
 =?us-ascii?Q?giB3DHMu/3UeF6uZaOLDJkb//LSwFl8NqzhelgcnBq+C9763h6EK0yq7zSMC?=
 =?us-ascii?Q?LSwmgfVVCClKOgPX8wvHbksCUaEjPwjU/BJmzmDvA1gWcVN+cZvoFKiCS23E?=
 =?us-ascii?Q?Lr2y4+Jk8mYch5UKhh3g/uYrLyO4raZ48hHg?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 23:00:28.6413
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29edf4d8-f3f0-437b-bc7a-08ddd92addb8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9744

The device under the reset will be attached to a blocked domain, while not
updating the group->domain pointer. So there needs to be a per-device flag
to indicate the reset state, for other iommu core functions to check so as
not to shift the attached domain during the reset state.

The regular device pointer can't store any private any private iommu flag.
So, the flag has to be in the gdev structure.

Pass in the gdev pointer instead to the functions that will check that per
device flag.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
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


