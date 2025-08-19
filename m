Return-Path: <linux-pci+bounces-34315-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E17B2CA70
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 19:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8C8E7A2145
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 17:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BE4302CB9;
	Tue, 19 Aug 2025 17:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K1xux7em"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1031F8733;
	Tue, 19 Aug 2025 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755624161; cv=fail; b=osdfAecj53W7cf6Z+/XJNbFCShKgn2jhvUJ+f9l7W7Tz4iUJbL/2xt2KfdfYLXOXxBnB6JJZMdTzEkbHvrVC9i5gEU4OMf8Td1jsTBiHauZB3Mnv2pKSEKfXH8871wi5RyrtZceaCJSN19wvL/2HixTO3AvMtsDCh0hfhn4Fx94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755624161; c=relaxed/simple;
	bh=gYWaPTS4YdSg0wP8oMIFzHhyVqz0GtylpFIaOeR3h88=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twDbJmJJegB1ChWV2K01JFnc8pFjyCp3LmVpCB3GRuxJnNbQD8of+mU+Q1oHL0onBlzuCLShlKX02YH29719/F32MTOy60pS614lPeA8uwCZCcnPsucmcGMkahCbwpluBki0bEAdRJ0PetfbTsxomhAMTM7x+JhhIAwLg2KfEZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K1xux7em; arc=fail smtp.client-ip=40.107.236.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eu6949MSJmIEEDkP9qwY64DEf13t6MFD/mhXDJ2j51Z7KfSqClgy2QokedllU5jNXYyMILxQzqMoL3emN2atj5qE+E/xsBRved52fxJisfVPPW4WH+jnrvhgxQBkWNPsPR6DH1JU7h0tbcC5R9pSdCCXeYOFgJdL46cPfeixRbeP4tt6VhoYS5XAuz6mImMLNgC5EQxIYzno0SfrxCagFXyH+XcTDtwHlz+66UYSgX6BJvHOCD/WcLKK0WdsKHj9fxVDzeegtxjaDvLwVHGxjWEnZs27AHqU+QzyjkvrZjTdzQ3J2Oso5XeOlO7uvnHpSR/sM4Z1fnF2zOOGcThs5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ys1gH2e5j8xiZRvGCwTNRL2yYA1Sfu6NnXvCiYNcMQ4=;
 b=JyUASeB7okbhaJquVZB4+3ngCTrx4U8Fafm9xYhD7twGyt0vfxjQr/ZjthngJztLWDZBkGHVcjU3lVvCVRoJxkqnFGX1yiudhWJVpdTJFgT4M9HgrzcGjqVUj711zuNDcSb/grQ1/HIijgTWc9xGrZVUm1K9bQo9ts3U076OoLm+eVB8OKM59vbHDbr2ID64wkePQlBgiI12kTN1hgS2biBR+ICH3hGl5uSaI28vnMTciR8xPio8F3q59ULFAwN98tjfmygdAR1Yh9BsfqYdWswCVk41iqWzvX0V6iAgN+yI2b/tkfCu1aYW/CyIHT/j6YK8hFoaL6KaQa+0w1cNAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ys1gH2e5j8xiZRvGCwTNRL2yYA1Sfu6NnXvCiYNcMQ4=;
 b=K1xux7emZOHeeE+GMUaqhIWbe2GvN2szzxVYGeNJRINCQbW6nAZjM9f1UWlcxl7RsFLhn16FzJigmRNquwp5xB6+BsdAnOx10ZhsZhpM8o0AsAZmjKij9oEgbNLbHxQJyPDaatCorXO8V6ufw2Br/4w1Ix4CQ5YeIXto++L804cfaiaQMuU3iJyoKynq3/RL1VlNy8bfAGxpQMjJ7NPH8cjiQIfDOwbc+c+VeelMyYTgdP1zmTzyoudJmIMKD8ZFp8S//9qzsnYFGTX7LS273L1wdZHVJB+N3EgBnsa7A4kugZlCC2o7NJHQne037ITFXD1CDqaZok2YRGRFNmwZ4Q==
Received: from BN0PR03CA0033.namprd03.prod.outlook.com (2603:10b6:408:e7::8)
 by SA5PPF530AE3851.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 17:22:35 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:e7:cafe::75) by BN0PR03CA0033.outlook.office365.com
 (2603:10b6:408:e7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.20 via Frontend Transport; Tue,
 19 Aug 2025 17:22:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 17:22:34 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 19 Aug
 2025 10:22:23 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 19 Aug 2025 10:22:23 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 19 Aug 2025 10:22:21 -0700
Date: Tue, 19 Aug 2025 10:22:20 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <bhelgaas@google.com>,
	<will@kernel.org>, <robin.clark@oss.qualcomm.com>, <yong.wu@mediatek.com>,
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
Subject: Re: [PATCH v3 3/5] iommu: Add iommu_get_domain_for_dev_locked()
 helper
Message-ID: <aKSyzI9Xz3J0nhfk@Asurada-Nvidia>
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <a69557026b7e2353bae67104bbe6a88f0682305e.1754952762.git.nicolinc@nvidia.com>
 <20250818143949.GO802098@nvidia.com>
 <aKNhIr08fK+xIYcg@Asurada-Nvidia>
 <20250818234241.GF802098@nvidia.com>
 <aKQG9/skig6F8LdQ@Asurada-Nvidia>
 <20250819125249.GG802098@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250819125249.GG802098@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|SA5PPF530AE3851:EE_
X-MS-Office365-Filtering-Correlation-Id: 585e9789-a4a4-47ac-9913-08dddf44fcdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JSV2/NcBFWPYEo3I8e3g0fijZi57fj+q4pWrCPKY+6Sc60z3T4oZyX1K+v4t?=
 =?us-ascii?Q?T10oDq9RsMlVIx1iJlCMK+VGlTQIdaa0Pmn7IVHPspk2Oc3PQ1KpOXOEUbs9?=
 =?us-ascii?Q?Jutlqp44pHbjnTMAcOaII38J80ax9pzt2E+saO+wmnheimml7comXRN4To67?=
 =?us-ascii?Q?tBzhwgpfPgV5T9FBMJxMpXVHMzEpnrKpWsP5kJwYXd3gYb+8YBFeXfesK/zV?=
 =?us-ascii?Q?ENMLgcwGFkXJa9jGhmbRcpc8Wnmefys71rqF3xWN4SjV7EQ+zCVh0oBhakHv?=
 =?us-ascii?Q?0ogaL/tF52RcUnKhZbZmOGgws3qx9BNA0qkUAjNfw4PdamznVnWZkFOnqsd5?=
 =?us-ascii?Q?YqCWASFHd4PdX9j1pCJwo2TuXohFWxO+Y91swJPoLNlxrPvD4LiKMubsvHqN?=
 =?us-ascii?Q?X4JP3xTUbiJy2Uz+ZDn8yp2jJ2o11SCt0GLw20EJVy6bO2zVdTJzRlHduDoA?=
 =?us-ascii?Q?pPimEX/KLk3gNmGDeB/Ry6Ftz03brssXuunW+AoKr1ArThh6z9Uc1foDTCYx?=
 =?us-ascii?Q?f7ffwrPLATaE2oi6uXNTy55bfepAzG/L+JwLpRtpAWD5yxMMQUg1TWro981a?=
 =?us-ascii?Q?m0jGwjYd0IW1jz2YuL5i3YgshoOn6uqp8GS2neGPwnX10+c5Dl/72Lf2yYyP?=
 =?us-ascii?Q?eSse8pS35fUqLfl1uuXlQ7bNBtKerpip8+5YILhx8cQFWer8emXZnAPhWlgr?=
 =?us-ascii?Q?G3JfyUoUGQWN0C6mOlBfBOVAlPKkFP9ykgA3YaNt+yt5JPNcajY13EUNIKop?=
 =?us-ascii?Q?aXrqDhjrAzaMbhV4oAeo+OB9Ym1B60JgLsNNlx+K7loSNafVRzJnh8HVJH3L?=
 =?us-ascii?Q?Ma4a42FyoeMrN0dMFKoE0FHeymT5D4JgrtBJo4UkZCYcwJylY+uKqDiFzN5P?=
 =?us-ascii?Q?Th6ets1H/5YfGX6zqbWYPvs6NBvHLAhGHuW34yVlXyKRqkyuLl/pQjLSiedY?=
 =?us-ascii?Q?lxno4WB6h4aIX7jCYU6WTaqW7CxxrxE8baFETZGrZ6MPkoHoRcW4FLpPUnKR?=
 =?us-ascii?Q?zzxIJQ0Gh5rIeld+a1ZepZtB7IavC/tAqYVU7OKaI8qjfPBOnCzDM18DZX/q?=
 =?us-ascii?Q?91elMigZZ3+EIIyfYTZ/o/s8E+xlzo8ONvyEuU+4TEfjWKH4BvC5FHmB0ycs?=
 =?us-ascii?Q?i2KTZR/3jEBIf0RWZt20WO+ot9QXwAkaXJOgR6ANLDRJmDPRUnGMA2vH+lZ6?=
 =?us-ascii?Q?LFU6DC1jOSzf2nfJcmZ8X7w+TZKrUg4ZZElbA5rz+9hEL6kEJmDriFFilqO6?=
 =?us-ascii?Q?XMYDnFfxorwUlOKc0Mu8J9EUb5ozx3FI64mL1quzix85olBvxWrEKngJ7cfu?=
 =?us-ascii?Q?YHlYAS0nvbeDa8W9DHyMWbJ1MGJmrDiKh0knr/FSvtc0v2h9oc8OjpkUDNXO?=
 =?us-ascii?Q?boPRn99oOW0jRMgcMvBjUcivYRS5OtY2wR42ytBYoaAy2Y5bN4aIQFVQhWA8?=
 =?us-ascii?Q?N4up/mJsZDJk/TdTIS0pE5FHNiWT4iCjZAz/CyNo+UzUg0U14KrURpdtgyjg?=
 =?us-ascii?Q?pkH/wRSSnv9GU9uduuUPJOx0ceRZ2X56yVGB?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 17:22:34.7852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 585e9789-a4a4-47ac-9913-08dddf44fcdd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF530AE3851

On Tue, Aug 19, 2025 at 09:52:49AM -0300, Jason Gunthorpe wrote:
> On Mon, Aug 18, 2025 at 10:09:11PM -0700, Nicolin Chen wrote:
> > Yes, I've thought about that. The concern is that some other place
> > someday may want to use iommu_get_domain_for_dev() in similar cases
> > but would find that it doesn't work. So it would have to duplicate
> > the domain pointer in its "master" structure.
> > 
> > Overall, having a _locked version feels cleaner to me.
> 
> We probably need the locked version, but it just shouldn't be called very
> much..

OK. Let's have one patch upgrading the attach_dev to pass in the
old domain pointer (aligning with the SVA version of attach_dev),
and another patch adding the _locked version that then will have
very limited callers.

> > > With sensible internal locking
> > 
> > Hmm, I feel this iommu_get_translation_mode() is somewhat the same
> > as the current iommu_get_domain_for_dev(). It would just return the
> > group->domain->type v.s. group->domain, right?
> > 
> > This doesn't have any UAF concern though.
> 
> Yes, no UAF concern is the point

I see.

> > > So that is another bunch. Not sure what will be left after.
> > 
> > I recall that some of the drivers manages their own domains, e.g.
> >     drivers/gpu/drm/tegra/drm.c
> > 
> > So, they would want more out of the domain pointer than just type.
> 
> This looks like it wants an 'is currently attached' operation

That's certainly one of the wide use cases. And I think we could
have an IOMMU_DOMAIN_NONE to fit that into the type helper.

Yet, I also see some other cases that cannot be helped with the
type function. Just listing a few:

1) domain matching (and type)
drivers/gpu/drm/tegra/drm.c:965:        if (domain && domain->type != IOMMU_DOMAIN_IDENTITY &&
drivers/gpu/drm/tegra/drm.c:966:            domain != tegra->domain)
drivers/gpu/drm/tegra/drm.c-967-                return 0;

2) page size
drivers/gpu/drm/arm/malidp_planes.c:307:	mmu_dom = iommu_get_domain_for_dev(mp->base.dev->dev);
drivers/gpu/drm/arm/malidp_planes.c-308-	if (mmu_dom)
drivers/gpu/drm/arm/malidp_planes.c-309-		return mmu_dom->pgsize_bitmap;

3) iommu_iova_to_phys
drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2597:	dom = iommu_get_domain_for_dev(adev->dev);
drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c-2598-
drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c-2599-	while (size) {
drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c-2600-		phys_addr_t addr = *pos & PAGE_MASK;
drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c-2601-		loff_t off = *pos & ~PAGE_MASK;
drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c-2602-		size_t bytes = PAGE_SIZE - off;
drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c-2603-		unsigned long pfn;
drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c-2604-		struct page *p;
drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c-2605-		void *ptr;
drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c-2606-
drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c-2607-		bytes = min(bytes, size);
drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c-2608-
drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2609:		addr = dom ? iommu_iova_to_phys(dom, addr) : addr;

4) map/unmap
drivers/net/ipa/ipa_mem.c:465:  domain = iommu_get_domain_for_dev(dev);
drivers/net/ipa/ipa_mem.c-466-  if (!domain) {
drivers/net/ipa/ipa_mem.c-467-          dev_err(dev, "no IOMMU domain found for IMEM\n");
drivers/net/ipa/ipa_mem.c-468-          return -EINVAL;
drivers/net/ipa/ipa_mem.c-469-  }
drivers/net/ipa/ipa_mem.c-470-
drivers/net/ipa/ipa_mem.c-471-  /* Align the address down and the size up to page boundaries */
drivers/net/ipa/ipa_mem.c-472-  phys = addr & PAGE_MASK;
drivers/net/ipa/ipa_mem.c-473-  size = PAGE_ALIGN(size + addr - phys);
drivers/net/ipa/ipa_mem.c-474-  iova = phys;    /* We just want a direct mapping */
drivers/net/ipa/ipa_mem.c-475-
drivers/net/ipa/ipa_mem.c-476-  ret = iommu_map(domain, iova, phys, size, IOMMU_READ | IOMMU_WRITE,
...
drivers/net/ipa/ipa_mem.c:495:  domain = iommu_get_domain_for_dev(dev);
drivers/net/ipa/ipa_mem.c-496-  if (domain) {
drivers/net/ipa/ipa_mem.c-497-          size_t size;
drivers/net/ipa/ipa_mem.c-498-
drivers/net/ipa/ipa_mem.c-499-          size = iommu_unmap(domain, ipa->imem_iova, ipa->imem_size);


We could probably invent something for case 1-3. But for case 4,
it feels that iommu_get_domain_for_dev() is the only helper..

Thanks
Nicolin

