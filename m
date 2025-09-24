Return-Path: <linux-pci+bounces-36895-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F41FB9BC1D
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 21:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51A9F3B404E
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 19:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F71223770A;
	Wed, 24 Sep 2025 19:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fMGTUwuV"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013066.outbound.protection.outlook.com [40.93.201.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69341DF755;
	Wed, 24 Sep 2025 19:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758743385; cv=fail; b=piCAV1uL+yJ3/8jV5xVOvmZ5rRImG3r1omVqA931RSiXpqHyfAYtEapvCg3MvzJ39QlEg6JVaErQy6aMBq1Ee6MwNWOyhe0YpCD+nF2LmKWkbuV5Ef0ZvriPdZaes+eEjK1nAzT+nopTTca4va/y4GWEAbMTBA+Bn9pIC8lSonk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758743385; c=relaxed/simple;
	bh=AWzS9I6MbG6K4gq+ToxH2G9Hg30pwWb4zctWqLgU0YQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmVrDGr0v8Quk5TuBjuni/qsSOwNvSqnuvZRLtG5mjW7C09l64//L9ipFfz8xq7MPY0CjYHK1S5W0s6xgc9f5BtH05eJUNebYf3vqA6DIRaBbff3fvPRtGsszyDC4kcA146mBqXhdxuZqKfE2reWRgtd5MpqDbtv/G3ke0iDI5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fMGTUwuV; arc=fail smtp.client-ip=40.93.201.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QP74wjyMpG7CyoQVWPXy57k69ABlVI4FVrW/OFVvV3BLO95/kKVCe0BkfxAAYVndNrZ7K23XYOq5OyoFyN31c061qkIjla+/BvQlzu8EgYIz7j0iP7FbyewVyBHOPMd0+C2FWEpS8DesWP0iz+cI5NX8yOw2kRxLQim9erD7Yl+150drCPomXHh583xueFl/DArh8SEiq4xgEuDO2oRZke51jVQ+kLFaSlGEPyMJNQ7hjsukegQ/12rmTh+EBdxk/Iqk9qykUgaf4VRgnolAu05wtBNms/cbK0m1o9TB1/JqDrmNYZXhJKpun46NuvfmYUao5+Fx/eOyjnpeZk12XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekVtrLWsRZLj/GYerixv4vut0tchd9bN6RaTKZCS6Po=;
 b=xpFq5Kf1dRq//5H6Ab/YcNWhH6VFKQX6Qik2egh7rUaQlGf629GVCM4VNzAhuqjBncGYmu3KjsNG/CFnvxjhrZEv8HQuxz1JfndZ+uWsLoh3zmwnLrbD4CPkQP/XReRKDa/dIfIUW3wjqjvO+y2BvmfGlUUFuJJK1qocbQxqY/rvab6sAnY+PJMn9XKk/beAT9T4Go5B+v9p6+xJ9tn33VxGcncb9GTyfPo5JBC2Ihd8hz5wlSwSKgKiOdBYTY8//KVTA+mRwfudN0oxEC2t+TEob36D7GvbVU+6gmZShM2NGmM1OzTOlVO0cq3WCmkMl+6k5cbvWv6nuaZTm3/NBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=csie.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekVtrLWsRZLj/GYerixv4vut0tchd9bN6RaTKZCS6Po=;
 b=fMGTUwuVhqyUOaA3LfrM3+y7fa1CFcs2F/wW2dXb4DE+204nbDoa5r5l42SS9oq2mM6N8bENMtN4HSHAr7P7Ff4ByV5rhaOllacw6SCgzuyxWoynH2Q8tTkKktQqaovb3lyXI8P9peXUb9R4UvuYGvnyxv87N8EiIquT4BWonVKzi/RUaPXbqgj91M0H9KCHBFG5oppEhTBmYirapqgQC+YK3ywJXR2Jnmqj8Tj/SqTbfgFrBEBuj23Q0ZMOIGbO06C+f/RGKgaY/St9X+BCyVO2CVxxeReOZ21THQGZZ1Csm6+AEF0ZnTldk38cLJxa2upXH15xXqOARoGUHbrRyA==
Received: from MN2PR04CA0029.namprd04.prod.outlook.com (2603:10b6:208:d4::42)
 by SN7PR12MB6742.namprd12.prod.outlook.com (2603:10b6:806:26e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 19:49:35 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:208:d4:cafe::cf) by MN2PR04CA0029.outlook.office365.com
 (2603:10b6:208:d4::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Wed,
 24 Sep 2025 19:49:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 19:49:34 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Wed, 24 Sep
 2025 12:49:19 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 24 Sep
 2025 12:49:19 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 24 Sep 2025 12:49:15 -0700
Date: Wed, 24 Sep 2025 12:49:14 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <joro@8bytes.org>, <bhelgaas@google.com>, <suravee.suthikulpanit@amd.com>,
	<will@kernel.org>, <robin.murphy@arm.com>, <sven@kernel.org>, <j@jannau.net>,
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
Subject: Re: [PATCH v4 5/7] iommu: Add iommu_get_domain_for_dev_locked()
 helper
Message-ID: <aNRLOsomtHNumaSY@Asurada-Nvidia>
References: <cover.1756682135.git.nicolinc@nvidia.com>
 <c9daeafb9046bed9e915fdafe20fe28a8c427d29.1756682135.git.nicolinc@nvidia.com>
 <20250924191055.GJ2617119@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250924191055.GJ2617119@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|SN7PR12MB6742:EE_
X-MS-Office365-Filtering-Correlation-Id: 53345ca9-0bca-475c-21c4-08ddfba37cdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2VvThKy+Z0dKW+vZ3SCGnO1B0cWZ57HA6LzpcQUizmOexU4qFkdZk5B5mTjk?=
 =?us-ascii?Q?rPc1tSTgpGGrInmMwxQY3LqzfGOFS5Ai5iWHhO8YewdiRbgnV//c8UJewvO2?=
 =?us-ascii?Q?hvSxdUjfPgorCNdu+G1XtPtuKo08b2NcrLyKBHtYNrjC8sfvG9qzDy9wTXPW?=
 =?us-ascii?Q?9zZ++lHMvsUjKwhdYwC9P4MQzzQasWvnUr6tZpESX7Ait/gbg2Lrb8JMjy5g?=
 =?us-ascii?Q?x+MgyYZzRKp2lPfxqc6dN2pRN9d3iUi7XMaaPdvt04ZjIyCfJKs3AaaMdxrg?=
 =?us-ascii?Q?o+EPd6+2eYOBzYZq0zcYfVGfc54K/NW/oCol2/PYpKV9grM7EkG4GRsIxGr/?=
 =?us-ascii?Q?8Z9SfwQ/prUUQ4l8M3goSSnFVncgDDerSiH2XwKBL+PIC9svSUySD7UsTI1r?=
 =?us-ascii?Q?pgexKKRydRUbWmvtqD5iO7NANzvTJojWMsip1ipQaNr/jFSmguD8Co54raB6?=
 =?us-ascii?Q?JA5mvOd158KIDt74X6UkkeWnwFnTjUhoX/Ua8O0X39ggDbMB9PuB6h3olq+O?=
 =?us-ascii?Q?o6YIkTTfxdMK+GX7AIxK/9YR4S7eTloBtV38YFU209eQzu0BNvJT9WjgWYAq?=
 =?us-ascii?Q?PubLbX1+fHl/SYOoQSMxd/zdwyx4GWSyTNmMYCGdIjXjJnrAIxG+Db1j7PwU?=
 =?us-ascii?Q?atOEElXj7vzDOwYHWKcjCd6BAv4yxsdgFH0S8Ako+k8x5tWvZMAfS6MAEuYf?=
 =?us-ascii?Q?XhXBPiecBm/50kf3l8gc1XAkufghvZ0a7GpeIkDZSrhNbZF6jJDXlvtZWoRH?=
 =?us-ascii?Q?6bsppMc6w51VMO49GNuazC7HKgmk0380uF+GJ4qft6iPdEdJMjPpxWQAF2k8?=
 =?us-ascii?Q?x5rrdAyj71Ym7zMoJh1oTyGUTV4qdlyMidSZLF9blOyNRhst9fSxoD1amr81?=
 =?us-ascii?Q?CoeqGXORPSULbUctv9DPfY9rrvAzXGymdKx2pe9Rt0sjhZAl7jam7K1TO/LI?=
 =?us-ascii?Q?i5DDcBIuAzMOtGj31uZeoXuFb+jC3RRMzLdsxwlRppEVFOPGr7J4cIPVmydt?=
 =?us-ascii?Q?z79LCWO9ZBXS/49WB7eDNocHBnc7S/5s931fPf8pT6iU0j+U08Izb83SQXeS?=
 =?us-ascii?Q?knunoyAApldtOA/ETOKXTCnh3R7jotUU4HvF4RvEJckdhii/cb3nRKs0EAM6?=
 =?us-ascii?Q?8VgAmIGFd4vB2GDyvAfVYGetZgd6KMj3Ht+nPkL/dk925xZsmD9nCG+Kws2c?=
 =?us-ascii?Q?4iWzR8YA4//EQhyjQ3j32T9EMu1FdAyJeTbaOnf/Gmkm8/ObR2VMtHUoNOgQ?=
 =?us-ascii?Q?rpepsxyICGQtqYjxaMy0nqkd/aXn/QRmfiQYcvljbs72YP+itr5ZXFQgj4EF?=
 =?us-ascii?Q?5LhCRAHzULHM3aGU73sjS9la69QXMp4uvd15aJC2aJbvkIPPYaDVXUsyMDoX?=
 =?us-ascii?Q?3wrANC9uHCIank9+AcOUqBae4eqKIS38Ky6CnB8AwXYZ3horYuewL0YKOHpb?=
 =?us-ascii?Q?HJeXA7J7g3+Hl59GeeeNbfOlzxHO9oSB+T18Y108KNW9NHRPRAHgArCDM8Lt?=
 =?us-ascii?Q?Ez+j1u0qzjY7GBzmzAixmxabnG0kj5LAorGV?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 19:49:34.8043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53345ca9-0bca-475c-21c4-08ddfba37cdc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6742

On Wed, Sep 24, 2025 at 04:10:55PM -0300, Jason Gunthorpe wrote:
> On Sun, Aug 31, 2025 at 04:31:57PM -0700, Nicolin Chen wrote:
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index ea2ef53bd4fef..99680cdb57265 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -2097,7 +2097,7 @@ EXPORT_SYMBOL_GPL(dma_iova_destroy);
> >  
> >  void iommu_setup_dma_ops(struct device *dev)
> >  {
> > -	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> > +	struct iommu_domain *domain = iommu_get_domain_for_dev_locked(dev);
> 
> Lets have another patch to tidy this. This function can only be called on
> the default_domain. We can trivally pass it in. In all three cases the
> default domain was just attached to the device.

Will replace with your patch.

> > +/* Caller must be a general/external function that isn't an IOMMU callback */
> >  struct iommu_domain *iommu_get_domain_for_dev(struct device *dev)
> 
> Maybe a kdoc?
> 
> /**
>  * iommu_get_domain_for_dev() - Return the DMA API domain pointer
>  * @dev - Device to query
>  *
>  * This function can be called within a driver bound to dev. The returned
>  * pointer is valid for the lifetime of the bound driver.
>  *
>  * It should not be called by drivers with driver_managed_dma = true.
>  */
> struct iommu_domain *iommu_get_domain_for_dev(struct device *dev)

Will add this.

> I really wanted to say this should just always return the
> default_domain, but it looks like host1x_client_iommu_detach() is the
> only place outside the iommu drivers that would be unhappy with that.

I suppose any external user that allocates/attaches a domain has a
risk of potentially using this helper, in which case group->domain
may not be default_domain?

Thanks
Nicolin

