Return-Path: <linux-pci+bounces-34237-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DACB2B881
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 07:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 864CF562056
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 05:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFAA25A631;
	Tue, 19 Aug 2025 05:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IgZ+dRf/"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AF51A294;
	Tue, 19 Aug 2025 05:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755580167; cv=fail; b=jxTxrKleqF8wNbQdk2h+GG+uXTby1XOn91VP7suN9jiAP/GpmgIAtxTgBep7QBcX1GOAN4+Ne5hdC1Dy/L4iAyMOcbfy0FnbzOyx/u3B4LjyxQJuNcO0NmRaf2uxz7WsUx2VYceyU2cTqSyzk7soLNp0T3jRrEg+PouEzDSRgvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755580167; c=relaxed/simple;
	bh=GQJR78MDU0UKOJIwh2RAUKcYc2r3Hb4kTBP+aix/CEw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgblsT6iQVL1KAXAodFGfGL+E6uX2sO47e132RsYb4mJeLjubfCtQSTpMNzGqDsFyqnfENrZS2tUj2pifI9D4OhE4P0qvC0gnCPGsppYqNN8+3wTQZdluCjxhINkzYJjD4Tfm65Q8odNgxsFd2P2IWZ4lIeHkFynijJD+A5C0u0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IgZ+dRf/; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BqrtZTFWbv5xzqjvKfWHyXlhmLAWgalUw4vSmV0tS7QCjdFppnaSkJKQ5G4Mj+RNb2oKBcAn+mmra/NiwDyrzqRMzdkyslWPIDhLtY3EUtJfTJBf5CYD0bO7cP5XURcG/ZKLXCvMv1Kmw0X7yY/KkmV60dximIpaZmrkXVfg2mSoHiDX7xBqv/LWpteuQXZgHiC1Hm8VQGuesjBnPhrkO5R+bTbAnTyQXikKIWCS1pEj0LeMJrX5oceIE3ouXoc8Qd2RrhBVPGH1oH/ATOhIbL4KMhL0AGGxTEEljw0cVU3bnF/fltegjsJWuIpV16hAaozDS8Re0wctPAFfI9eBgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXCNfbWjCF/BfcQHtOUaxxpKBtyS5DcvGg3uFoFC/5w=;
 b=hEnpfmMTxB1cmuo2NenuTE0lomeKgfp4kiV7WA/VBlt0xr96Rj7aZ8d9b5TRy/lhaB5O6E1Smh7DLFuYyjsFsfp+3IpQVYK/TGEtbY9MQgHMbrKrzuXK5+96ZeaLMf9iAsKfncXNsTkkBAATarAiXx/gJeuxZc3HsjwFDMCHaWaoNQN0a7wtZQWxFjp2ZM+bsDx4gYCtnwwtbx1u62f5wWRSpNaYDMG9E0/hvVtU+A3Q5XYopZeN/Ook6rqJqmcNh/B7o4JA+lgyJkmte00pgGP+E4VFYKg8UTszc7u/+dOoz6aW9O0SxvyWJEQ3TGSW6cm9cpckS18Uc9TbEGLLSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXCNfbWjCF/BfcQHtOUaxxpKBtyS5DcvGg3uFoFC/5w=;
 b=IgZ+dRf/GPbG1UwR+OjAzJwVT319h1Sj3TsB27jdu/DpdI000krJopK3batxwDY3mztTvDxeEvKlMRWySwGXNM3GabqK9HEH3DrxcZmXVJ8U56QF+GWfiE6pJmiM88JVtMBC3RlJo0UO1Jf3Gz/gwawN0pZvqN/DpzA8QO4hZfvxu1aixJPhrwUkqCd73HoKAXkv7k6FWoqYs1Eaq/2qsDzS7akJNMB23HiSdrmQiJ4260ntZov4+iQr0/MzD3mVB0E7Haeci+rwAzIeRCMzQFgLoOCwYEbBbXkrEed/fbc27RiTuKMb7qBaqSV3qEQgf6m8HwH2R6wkRK/+pGW5OQ==
Received: from BL0PR02CA0137.namprd02.prod.outlook.com (2603:10b6:208:35::42)
 by DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 19 Aug
 2025 05:09:22 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:208:35:cafe::40) by BL0PR02CA0137.outlook.office365.com
 (2603:10b6:208:35::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.24 via Frontend Transport; Tue,
 19 Aug 2025 05:09:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 05:09:22 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 18 Aug
 2025 22:09:14 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 18 Aug 2025 22:09:14 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 18 Aug 2025 22:09:13 -0700
Date: Mon, 18 Aug 2025 22:09:11 -0700
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
Message-ID: <aKQG9/skig6F8LdQ@Asurada-Nvidia>
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <a69557026b7e2353bae67104bbe6a88f0682305e.1754952762.git.nicolinc@nvidia.com>
 <20250818143949.GO802098@nvidia.com>
 <aKNhIr08fK+xIYcg@Asurada-Nvidia>
 <20250818234241.GF802098@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250818234241.GF802098@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|DS0PR12MB6486:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a329ab8-bf74-4abc-7c46-08dddede8f4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/KoUkVY/xfblW/QGfS3GEXu1t4mpzkBAZUG/OwlawZgCEARhi7Icjf0k8vIy?=
 =?us-ascii?Q?lCDMKBwK0vGQvSWhuFjPAhDFo0B86WKqF73svTI7OvdXuBH0b69hBu6pkZCu?=
 =?us-ascii?Q?TlmiOn6+DruG7EMEoTBGUNJke+H/uN4EzQpB8VmkIPRS/vddzyUrpv3+ZZ1m?=
 =?us-ascii?Q?8EnM3oR+31V0WiUeYBU2FBRvhmvoiSRqpibAsojTPemKJkdiY9eNtJcGy3b4?=
 =?us-ascii?Q?NrwZflbJizXVFZQdm4xKa/6Hv6lTKFfTm3a5I8sweBUM4s3fVcy4EMeRtkYE?=
 =?us-ascii?Q?iDwufwyEAlsfmVZdpgw2fAy/OhB/EzDF5Kh6qT6E96wt5ucdHJRNhyaPQgy9?=
 =?us-ascii?Q?9sczAEUdqCwQnLTPkDzGTu2lUJTyPbNhu7L9ElDDU0gwIruOwsPfd0b2YckT?=
 =?us-ascii?Q?CxShsvOo1+O91d2CiS9WZm8kcKZFgs6gw6W3GjJuLblfogoCR5g/aHVXWDCK?=
 =?us-ascii?Q?sDyFB+AjPA/3H+R3yzpop1026780u38cTlbDhnb1jxT+12aOAzhV8KF2SnwN?=
 =?us-ascii?Q?e69BbOlIZt+8xonW4pDNMdCuqzFtrBRKUfJDgDCnozprHBL6cvifpbBkhpjd?=
 =?us-ascii?Q?4IxyjAybFF43vwtV3Un0ikhOz70aibiY1iaRlJK8NteSbVXcwb7iXn0FjBqR?=
 =?us-ascii?Q?1LTS569K9fzDpYXHb5nn6jpOajIXsu82P3X/CiXpxJ8k8Pdmxm2WTSPdnGoG?=
 =?us-ascii?Q?imfzRNZRY5JUA09NXdauPDe6FB8S0f2fTphzJ0936MaNml8k7fgHqTKXR7aO?=
 =?us-ascii?Q?HTd9SMoPJ8qMezfbowakj4D1D9elx4Uzs8FWrZ2T24OFuB3u5wi0ZTU1qJm5?=
 =?us-ascii?Q?UYwCevJ0OhP6r1ZdMQdNhBy2Pe27u98f2BjYjiGi+wyf2voE2gYTXzBwxSnq?=
 =?us-ascii?Q?s6e1neN2yC3ebl5hVYDFx1s76LvvAWCRBWZ1RvimEzxT1hEOh5i9AQTbH1a2?=
 =?us-ascii?Q?R6OITM2Y2SP7souzhehi0661O5bsBrnSDiGNDJB+cLM5Dh+uJLvZAnME58Bv?=
 =?us-ascii?Q?KszxVD6XM3/pzpHWJY/nsZGCXG/6U9uaJmwRRPHblN6CaoX7SlO6Bk2j7eiP?=
 =?us-ascii?Q?1riDBIRoMwLZrjfcm2vkcIdLH6bXgIXPee/MJYIwf5PDVuHH/1ZOXNxcvpws?=
 =?us-ascii?Q?nEYcTYDrqEldO3yDofIQd5NiHLvX06qpZWzNkq/4/6Cm1434Dgbby9qJa8C4?=
 =?us-ascii?Q?IR3ol82dXfzys0A15Xweb92rkyI++O0OXo0iBlzxPbKp4jfdCfRwLQTyovz3?=
 =?us-ascii?Q?CQvzGTdsiqNPAf1e17Z93s1u5y2WIwT5Pns27k2NEaMXc7K+iRzgEzPG4MlS?=
 =?us-ascii?Q?RZEJ3S87LeW0ptDEDAamwbEPu0wvu7cGpEYIEL63zkwIdOTU36LrpU+RpYgA?=
 =?us-ascii?Q?Bh1GHfBsKujrWRRD9ZfBqM4k/BnJhmG46AcIJruYuq5fuZq6Ou2YIRchWXqa?=
 =?us-ascii?Q?g7YfTSLM+KFy4C7KvVi9A/ErUzINSF6NURnza3TuXL0TZIelncnDqe4erEpw?=
 =?us-ascii?Q?XkqcCp8XpaG3CjRao7c/ZRRDV1ywcHK3L1yM?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 05:09:22.2948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a329ab8-bf74-4abc-7c46-08dddede8f4e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6486

On Mon, Aug 18, 2025 at 08:42:41PM -0300, Jason Gunthorpe wrote:
> On Mon, Aug 18, 2025 at 10:22:52AM -0700, Nicolin Chen wrote:
> > > Because this is a very common pattern in drivers.
> > > 
> > > Once that is done we can see what calls to iommu_get_domain_for_dev()
> > > are even left,
> > 
> > ... I found that in SMMUv3 driver, iommu_get_domain_for_dev() is
> > used to get the RID domain for an SVA domain:
> >     arm_smmu_set_pasid()
> >     arm_smmu_blocking_set_dev_pasid()
> > 
> > These two are already given an "old" (SVA) domain pointer, FWIW.
> > 
> > So, we may change to passing in the old domain as you suggested,
> > yet we still have to fix the iommu_get_domain_for_dev() in order
> > to reflect the RID domain correctly for the driver that calls it
> > (or even potentially) in some group->mutex locked context where
> > the RID domain might not be naturally passed in.
> 
> It could probably be avoided by keeping track of more information in
> the master, but also it is not so bad to use a _locked version here.

Yes, I've thought about that. The concern is that some other place
someday may want to use iommu_get_domain_for_dev() in similar cases
but would find that it doesn't work. So it would have to duplicate
the domain pointer in its "master" structure.

Overall, having a _locked version feels cleaner to me.

> > > arguably we should be trying to eliminate this badly
> > > locked thing...
> > 
> > Any suggestion?
> 
> Bit by bit.. I counted 58 by grep
> 
> Changing attach will get rid of alot of them
> 
> Then there is stuff like this:
> 
>         domain = iommu_get_domain_for_dev(emu->card->dev);
>         if (!domain || domain->type == IOMMU_DOMAIN_IDENTITY)
>                 return;
> 
> Which should be more like 
>    if (iommu_get_translation_mode(dev) == IDENTITY)
>
> With sensible internal locking

Hmm, I feel this iommu_get_translation_mode() is somewhat the same
as the current iommu_get_domain_for_dev(). It would just return the
group->domain->type v.s. group->domain, right?

This doesn't have any UAF concern though.

> So that is another bunch. Not sure what will be left after.

I recall that some of the drivers manages their own domains, e.g.
    drivers/gpu/drm/tegra/drm.c

So, they would want more out of the domain pointer than just type.

> Not saying to do all that here, just prefer we move toward that direction.

Yea.. I also think it's a bit difficult to justify the changes in
the non-iommu callers, since they are not affected by any patch in
this series.

Thanks
Nicolin

