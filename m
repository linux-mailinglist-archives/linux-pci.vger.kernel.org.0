Return-Path: <linux-pci+bounces-34460-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC01B2FD2E
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 16:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717F03B51E2
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 14:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC90223323;
	Thu, 21 Aug 2025 14:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mqh4ESGA"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3641D61AA;
	Thu, 21 Aug 2025 14:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755787343; cv=fail; b=V4Wx6ysSdGM5xBtjMzRNfeCsn2glLr3sKMOZcaxg1DEbiAzEn1mF4IGfE9f/pWMkVL9haF0oR4FU9So7GgFsecwBSqSQeZwZZewU+GmeVfsRb8YC3BsIbMz32wjd+sDVLPf3jwtIxGA2cgG/kusEnbm4mmOIWuSBMgy8cyfdwpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755787343; c=relaxed/simple;
	bh=y9NmVn1OWcApj+idY+decteNg98M9N3gzfmybc0PHbk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6tiHxOAU8uuRAgIc7eLgMTkT0xeWLAVDqLaZ7siBK9FFMpsk1O74aHoO9ME/HWQNTRfqhqvnHL8FHLVFNBpqP2AhLMlHcJe3+lRoZMANs56b0sqjGaI/CzgFjn5a4Kv1LLBStlx9Ro4d6S5tc0NtANUR8jfWTJYDjCa5TZyLBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mqh4ESGA; arc=fail smtp.client-ip=40.107.223.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bbLoP72d5dVEbPJWC97t4vG2bWevjCf9Tqj/Of+rO+FLCNYoQvTdnUHciQWocmGo8cucdxgghuMzS+FlDHkkpasuwi26FZecfSNDaBDqLjGGWPUhlRLSv6XzW7MaMwq28mhEp0sJU+8JffuKdfeasllQlxaKuvF7A5o+TEiUyZvBDgirGeoZfSe50spKw6ZNfB0YyvkS4Gg2vslfY+4B9nz026H+Srw+6p0pSGfEXJPwwoSP+GQUTBVATL7ycEsN9wV4iusjBf2PyZJhDMRiNXDIF4d8u9NFmU7ODXbGuASM5+35cdJOZ1wjrS1U3DCYnn+vcWHtpNUJjwxJVNJLtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auVWryte4g8XND3xM/ONIltfPW2/39ShYHPEJL2knZM=;
 b=NBuXHv1szg8wRJ0M++f2nx7uZwkVAU5GSWYsY8Xfhd/aHcHuCMrvhueCzndWtBAlpE+zMY+ugA9NxY+KzUwiQRIDRnrdPLcU37yUwA+hNsWQtYO1pU/afsIRhSauLAtSXnMM4gBDQN4x/xwzAM3LkL2Zanztp38IPIzK2/RuRZzI2WmbSXtB2V08loM5qVBFNkH5YlLzOwSerC0FnvRpTVICR3mcuy7syuHcTMoGlzZ/rd+sMmu4AlW3yJ9q3eq4/KWjR3yO5b7MDE0gpdC5GYr+WnWwxVqYWXqgpbc/CDDRHYILb7PumA0c/WoHDFB1tc/rlBheE2enni6Pvu0g5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=temperror action=none header.from=nvidia.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auVWryte4g8XND3xM/ONIltfPW2/39ShYHPEJL2knZM=;
 b=mqh4ESGAx2WycR7YPy/YX37NlPtSq8HaUQoeds67ZxT5zSqbHlm+I0DsAT3+uMZ7+kgYVTpRRPkWayB07w/eV3pxHirp6gxckxj9kZa2vzM+xpt+hy03QlXcXKIvHQOhxtHwcou97mMQAtLvYH1HsSFFNcn/Q7+psDWnKXStpJOs7lw/Dt5ssTTpqdnX05+DAn3cwxLs0YDMKdJUcJCFO5o/eJD1UsO6dQDDjXTImA06eri8aN3X7GA2LiVlnwp68loooZs9IkEh3aktnzxSxMP+4GcPYMvu/ihGc14vhi3G40rLqrPMRP6VPrEdeqRfA8mUmJLtk/6s/BxXWqXPng==
Received: from SN7P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::35)
 by SJ2PR12MB9087.namprd12.prod.outlook.com (2603:10b6:a03:562::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 14:42:18 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:123:cafe::c6) by SN7P220CA0030.outlook.office365.com
 (2603:10b6:806:123::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Thu,
 21 Aug 2025 14:42:18 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=nvidia.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nvidia.com: DNS Timeout)
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 14:42:16 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 21 Aug
 2025 07:41:57 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 21 Aug 2025 07:41:56 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 21 Aug 2025 07:41:55 -0700
Date: Thu, 21 Aug 2025 07:41:54 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.clark@oss.qualcomm.com" <robin.clark@oss.qualcomm.com>,
	"yong.wu@mediatek.com" <yong.wu@mediatek.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "thierry.reding@gmail.com"
	<thierry.reding@gmail.com>, "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "Jaroszynski, Piotr" <pjaroszynski@nvidia.com>,
	"Sethi, Vikram" <vsethi@nvidia.com>, "helgaas@kernel.org"
	<helgaas@kernel.org>, "etzhao1900@gmail.com" <etzhao1900@gmail.com>
Subject: Re: [PATCH v3 3/5] iommu: Add iommu_get_domain_for_dev_locked()
 helper
Message-ID: <aKcwMtPJuFfVA8TF@Asurada-Nvidia>
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <a69557026b7e2353bae67104bbe6a88f0682305e.1754952762.git.nicolinc@nvidia.com>
 <BN9PR11MB52769ACDFED7201CE282FE3C8C34A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aJ+AP18ucw3Jb6QO@Asurada-Nvidia>
 <BN9PR11MB5276CCC219B8456DAF289AD78C32A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276CCC219B8456DAF289AD78C32A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|SJ2PR12MB9087:EE_
X-MS-Office365-Filtering-Correlation-Id: c534d123-5500-4b07-6d4a-08dde0c0ece7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dsp5ul4z2sfLqnK/rr1myxKGMZySUfNG+anE8Y1xUTivRPzxcC1uNsovqc/h?=
 =?us-ascii?Q?8r04w16Zl+cLvQh3geZ9I3kZF1AZRuvtdAyj47u9XW9JlZS8LZsJCAM0JEjk?=
 =?us-ascii?Q?kR3M1rtLd06oaHML49+NhZDJ8SyWIntfnt3/cPKpk43H5c6ioUKqYKZufQJK?=
 =?us-ascii?Q?7MjtaKB8Hgl6t0scYYj1ZLWj3FTIbNOndnR6tebCEQvaA7HcH3k1Fpn1WOgM?=
 =?us-ascii?Q?8hmj0p/COyuErErjzuV61e5Zwk1dwFCrJV9nPiZ7V3D+ma1VB+1Axj1QFlUG?=
 =?us-ascii?Q?bAdDszFzEH8TtQx4L2BQc0HXFDu8E6HDTU8kM6PyTkMZmHw3Btg61vtEFoDr?=
 =?us-ascii?Q?RyRxrmAb3x0Y/nRlUjTUtASeGBz8RblR5li7WKoyEXG1S024ngIPSXHRUwz5?=
 =?us-ascii?Q?c0Tui9cWFqCl/YeIw7zLQWKxSTXGW2SCCUWGBqbMjQYeYvBn/DcRX3HB6SV8?=
 =?us-ascii?Q?mee8soRX8PvzFcp8wzkJBgfNmJoMVl7VKGOR5vZgyfxNNtmzVo63qGwW5ojt?=
 =?us-ascii?Q?ZhTGnZpZFNb1y1F/o5GjuJphKBC/lp7f7ZXxSj1TewfZiDzuG0DAxWl6Fkzx?=
 =?us-ascii?Q?KO3jBIVD48JMe3TOzdVm6EkEX8lQe7zYAleA5JLjiZSlU4yVKl05+xaCAPJ1?=
 =?us-ascii?Q?cFSqYmge/qQyLwO0RunDJyl7bDkB+2E8ru5yy9giQm/UG0JyjQ9OYRQF7Ro5?=
 =?us-ascii?Q?izMqWVvzM2ay621smuvjaTY1mlvkl6NUV1qBPE7UIUK5Rgu77rRNs2TkumCe?=
 =?us-ascii?Q?BuPABQof9ttpwCChdWvY+PF+4d5oqdqnJQMlwUhn8+jaKmdLybqZe8e5D9Ml?=
 =?us-ascii?Q?JWFby6UA98vabSv1x4PP+7jsKzSP1wN2JhgmoGYqkSUXZFJZOXNJHMsyVzSV?=
 =?us-ascii?Q?loyCaP28tHZdtEoBqcPVIK+nNe+VTSNMnzqF3+uHPcanY0Fz2F5Ojf1pfJIp?=
 =?us-ascii?Q?dSQy+W8uPAFdduLnRfZNgwlEYT4qC7kTPWDuGGj1VAl1tUP9dYWP5UFXXuV0?=
 =?us-ascii?Q?wytnxaV/i1Jw8UwMIoXRzZUNCkZe4sdUh9e3niW2NGcaYh1pxAq6NfEVM2BV?=
 =?us-ascii?Q?tX61uPI483zhzL7pb1D+B1F1YWm0GnKu6kptY9blRwlDuDRu0+yOY77+I0wN?=
 =?us-ascii?Q?X2zhfjYp+7ed3qQ9wQabi7ID/FBTlH3DIG2qlJe5kH7184Va1oj9lITP0lCO?=
 =?us-ascii?Q?WD8VVW7j9Ep6GkeYBdSicFtoK7/+zkYs2YXIHlMjmHIzy8I0WRQ+PuPIp7Vf?=
 =?us-ascii?Q?LN2LQ1J+8A7LW+xQab+q+d7YG2zrDeMFPzrucAd3FGbVobsqH9vYcIHMRzoo?=
 =?us-ascii?Q?gUygDsuKhczmJFl/IeW4+64hfEgCqNXhxXl910/XMI4aJkUmTxvIPviuZTPb?=
 =?us-ascii?Q?5EMOVjOYnfcjHpjvsFLC0zI87DSVbwECKnOk7hBWRo0MYm4mRVT94bmLoMBW?=
 =?us-ascii?Q?q8ACckA1jhUtWQYAnOSDNciVOuwssTDPnpFaxCK6rY1ZaWLK5rknLpqkosF5?=
 =?us-ascii?Q?2t8MBqOkEBw0Sme0Kh0bY7MontSqiDFUblKY?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 14:42:16.8076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c534d123-5500-4b07-6d4a-08dde0c0ece7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9087

On Thu, Aug 21, 2025 at 08:07:01AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Saturday, August 16, 2025 2:45 AM
> > 
> > On Fri, Aug 15, 2025 at 08:55:28AM +0000, Tian, Kevin wrote:
> > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > Sent: Tuesday, August 12, 2025 6:59 AM
> > > > So, iommu_get_domain_for_dev() should check the gdev flag and return
> > the
> > > > blocked domain if the flag is set. But the caller of this API could hold
> > > > the group->mutex already or not, making it difficult to add the lock.
> > > >
> > > > Introduce a new iommu_get_domain_for_dev_locked() helper to be used
> > by
> > > > those drivers in a context that is already under the protection of the
> > > > group->mutex, e.g. those attach_dev callback functions. And roll out the
> > > > new helper to all the existing IOMMU drivers.
> > >
> > > iommu_get_domain_for_dev() is also called outside of attach_dev
> > > callback functions, e.g. malidp_get_pgsize_bitmap(). and the returned
> > > info according to the attached domain might be saved in static
> > > structures, e.g.:
> > >
> > > 	ms->mmu_prefetch_pgsize = malidp_get_pgsize_bitmap(mp);
> > >
> > > would that cause weird issues when blocking domain is returned
> > > though one may not expect reset to happen at that point?
> > 
> > We aren't changing the iommu_get_domain_for_dev(). So, it should
> > be used exclusively for functions that are outside group->mutex,
> > like this one, i.e. they should still get the group->domain v.s.
> > the blocked domain.
> > 
> 
> Usually the difference between func() and func_locked() is only about
> whether the caller holds a lock. If they mean to return different
> domains, may need better naming (though I don't have a good option
> now)...

Yea, naming is tricky here :)

Perhaps it could follow a different pattern:
    iommu_dev_get_domain_for_driver(struct device *dev);

With a simple note highlighting to be used by IOMMU drivers in the
iommu callback functions like attach_dev.

Nicolin

