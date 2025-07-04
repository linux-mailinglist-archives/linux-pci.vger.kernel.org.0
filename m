Return-Path: <linux-pci+bounces-31533-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E907AF96AE
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 17:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F2947BB3D8
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 15:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6F714D29B;
	Fri,  4 Jul 2025 15:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ubt7omgA"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5854C230BF8;
	Fri,  4 Jul 2025 15:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751642627; cv=fail; b=NaJ5WGzhpif0J3UFHHC/6QGT73MJ7IOMcBZnWzuUMonF+W4eT886iGVi8bxUBH27OAxv6bkv4a65Ua/QnwPjnWlKCX0eTMjLFfyuLIpnwxyOSJQCcGmDy/Fqx1YGBwLeiEyEBVW+wmrZSQ37kD36VTl9KuODQGUIb+OyN1oFbj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751642627; c=relaxed/simple;
	bh=l7PDF2OfEadYAEOH35BkM+o/dul1gnrdSgFHoVR4Ib4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MDyYLJ6Q2nUzaemHmrLZuTpRncKF0XX/ICulfrQGlG6xePu4RsLUYBMwlYQ2GG40eNI7fgEuf1e+A6jHT+uExr3GOYnAPD/S32iVgdseHa5mmvfdjMLlprinFbDzGARrKadOljTA+PVKX+T84bYmWi7ytn8dzbttGw0h5o8K1u8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ubt7omgA; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQGAbZmWVM3Btg0e3uq/V2vMmrPtnZ6ST2pG4yFQX3PG4i+vmfOk+1Ucp3lIguizaaORA0PkcdYYTbn1Jzm4J3ogUZt43EcEh0Xz/RA8pE8+cwOkHXgeia8PJ3/+lAYaRx0/sEJoQRNRH6TlbeLzwbSD9NavjIJG5wdAeuiRWg3DFRFWcfdOuWaFZFNsPPlGWfZ8YNut4Inaw9Te4mzgmmSe47PjkOvaqRhbTdV61eaDHCFBYhC+6bM0fZ1drqoQ6fhuX7Dn1IfwA0iM6U6u7Cz021ToXD3zcwSTXddWPPDhQX/6Nbsc98vcw2DwFVyfrXnSQWniurUynXNSvaq3kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klw83IxpQzusyTiH0PDU9nXlOMhsg8Ia2QyOyHMsU/I=;
 b=CsdXpiwxPZXjjbTLKLfpFvalTyPEfJ6dDDLKnwXAdF+Vd/p8YiaeKiIg/ddBE2uI7ZA3pqpY7Pu7VTO9qVhAoB6qnog8+h62d1b3khs5mlMpsNmq3NNAlcWYx0NtMVotvZbANqxSm7MPdEWXLTFS1htFKYFD5jVEfv4GSx9LHg/Z8pVEpGhmy5YS9BvjHIpwP+0HdM840vn491CPhDyV23BvlNhkKpxII8246WXnxiIezXElYwQ75UNeQjyt5xB0/S9YM54plfKPC3ve7GC2GpgP1Wso1RVgicAo4ePo2lr/oGc+E1rZnUPUjfafIgPR6a4yrJsQPpIrT/iWrHcerg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klw83IxpQzusyTiH0PDU9nXlOMhsg8Ia2QyOyHMsU/I=;
 b=Ubt7omgAZNn1twqAJDRLecv4XXHOlaQiyDe8WZlZqtsZtgmy9iX5aUt7//UbPS8e/+d/sfo/Oy/C9ffmCGXalNSlj6gRo8IN27eMAp0WX974FB6x5pwPJcYZ6b4AxLOXvuzvpRIqpmWJkzLIA5OMeO5v1/3yav/M9NuHnYPhPndGqLyyL1xosXGQasR3NBBX0fB4Ds3BSHqBpK84GjXwB6bbFe+PxhBBm20zu8DTvSV7mVLT1V0fRz283/m7z2NBLplNn4m6vG6PBWuCYSGKxsk5Fg6IPy7ZhtXGZrk8vONhKvR/FbIzPHhxr9iZTv8S3Qq9t9TbjFeehsed2G/khA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH8PR12MB7205.namprd12.prod.outlook.com (2603:10b6:510:227::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Fri, 4 Jul
 2025 15:23:40 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8880.030; Fri, 4 Jul 2025
 15:23:40 +0000
Date: Fri, 4 Jul 2025 12:23:39 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	patches@lists.linux.dev, pjaroszynski@nvidia.com, vsethi@nvidia.com,
	helgaas@kernel.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH RFC v2 2/4] iommu: Pass in gdev to
 __iommu_device_set_domain
Message-ID: <20250704152339.GM1410929@nvidia.com>
References: <cover.1751096303.git.nicolinc@nvidia.com>
 <46a1c0e7d07722c542084be9611f2fdf770c3a1d.1751096303.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46a1c0e7d07722c542084be9611f2fdf770c3a1d.1751096303.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR11CA0020.namprd11.prod.outlook.com
 (2603:10b6:208:23b::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH8PR12MB7205:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e90a4e-0248-4fd9-71e6-08ddbb0ec136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hje1JTRw93s8+FgA6hdIbgOpfpF04K/2o5z6J1CGr6QfyJ5hajkUF/yoIPdB?=
 =?us-ascii?Q?ga234bjZVIivUlrNjbWLMHL/PiiPk+ECzQccKsPf4cMmR6niPio+IrfMQ7P7?=
 =?us-ascii?Q?gYGHnuX/091w3Fc6GUCvOpfThyg8qIax2TrE67gN5veMYDmInzYYKZ+CETlD?=
 =?us-ascii?Q?FWiw/icNaiKS+0duuBaDQnURE1WR6G9YrxhMFfBQn7ixUhBg6ymdsEJPVIxq?=
 =?us-ascii?Q?A7RO9gyb+fyWm084vaLpRGePxDS2Dkgk+TKurdMpXKe2yAJjoJGIHsU4I3yN?=
 =?us-ascii?Q?8s36kUs7bG5TDnzFGtNBUJQFmvVgMb60L9jWhkqEupGEwgMlvszR7y/O9dY+?=
 =?us-ascii?Q?KUNCex04SXTXi+5YlXKs7omunqxiPS6psBkNZNcKC06T6YG8a2Uzm9ZGCeQq?=
 =?us-ascii?Q?uH4FxeBMjlbVvv2xqUmYrQrudU09Tn9Pe6zjbiR+Fc2Hu3VeimrlXMfKvPFq?=
 =?us-ascii?Q?G4n0NCYOw5znKnd8PWN7j8A61um2qwZN31WI+IG3I+VtkQjapFwqOPlEscM3?=
 =?us-ascii?Q?yE8XK0oJESfjIBtHnXzDeSQJ1J7IvgalgDjn2I4F0WGhnbnnGII+FN/2Xxti?=
 =?us-ascii?Q?CeM0fW25ivtHOICjJjqaU7RFauR1ts+jEcVCy4nGrLAaTrBAIyGRX4zhwvC1?=
 =?us-ascii?Q?r1jQMsDxItXPPtTOa3i2oLd8XTt5lwLFrMyrahf7R1fnhQ2kv7f/ZebrGnJ5?=
 =?us-ascii?Q?ee7o8inr5Plo1U8RY6+/elxNGWKN8lgMcGDvbRqMHNKjhTqa5dyEdxHd8ktC?=
 =?us-ascii?Q?BravpgoQZa9NHnlJVNqv16bfj4deU2DCNYRLW1FyxrVpy/6Fs+4WOT9sLUso?=
 =?us-ascii?Q?IOFdjmC+R0L3Q8kkdCOhU8QadNOC9V/1WMb4TLSGBhDck2BvCxY/bBXu2Kq7?=
 =?us-ascii?Q?gedoHF5jUMi7Ii12NA5ndApy12F+moyy4ejxQafTm2qXvRVq+Z5fmcdFLNU/?=
 =?us-ascii?Q?wMlyci1X4D6dUQ2uip0LxwgnTW4HKZO1a0u6c0cRXwG6iVopOyuedWSNqQ1r?=
 =?us-ascii?Q?a6rwZXjlO5rChHl86GSERk6Jl9La1WVWFoQKJsqiLg9JcHK50nYpVpaT2sRl?=
 =?us-ascii?Q?4UEVx4jWNvIuiJ9dbGlni9HJ1Zo7PnCSAx+MrzQBcakbEnlocTSHjMpYfZVg?=
 =?us-ascii?Q?VI1lp3hDgFeJRMNhr+cj1ZeXYfRNZZgKU1ExKprsIhAzQhYhWSGXtku4chiU?=
 =?us-ascii?Q?NFErxTaORRBe8RFoKyo4bJ2WLOhSACnyqdzCjMu4P3bhcxANJr1bes4cTf5P?=
 =?us-ascii?Q?C0v+8pTaNyr1fBn3Vhigsgtkwrb2TbWwFYy9YVdvlTPUPXDc474u5cenH0Js?=
 =?us-ascii?Q?KZP06xuP+uWvg4/r+dTfywPjzz/FJPHSuqoaJsf5/J8t46HEeSE4asMr2RBN?=
 =?us-ascii?Q?tgpcEoJdC821wmKLnpRCqdbObcRDH2MUA1yPsYGIdCy1DnPFlQYxVB+rXNBP?=
 =?us-ascii?Q?uGY9KgqszMc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?79eZfIgFIpkCozU60AT3Na4yjhkGeNkdK9sQSAqolhEC2ThOtoHO8xC8hhzH?=
 =?us-ascii?Q?J2ixXuSIvrwDTSBfynZPKTiCgXWYsVr0j/JZlAl8IqyakA0C40OYtnd5/cUN?=
 =?us-ascii?Q?4kDoxaAyGk2pea/cq9WDTfhS1ojJRy95S4f8YjozrgGT6yMqB6tIvqOKlEPn?=
 =?us-ascii?Q?p0UhbGmJxXcqT/YY9YVHFjJOJcFBWfnHsbWayzkF35gWb89yyltTugYdG1NS?=
 =?us-ascii?Q?veqx1nzmFU541cZd1XJdnzIu2t75rWXzGTg+rs5VTMO97JWLAbGLi0aFAbbo?=
 =?us-ascii?Q?+dWYP9spTbPVcLBsy9uBtSirPPGgHjNroSbEaBOj0ViElH3KMF0AHLj5EGFq?=
 =?us-ascii?Q?8AR301d/7IsqsL410NOeFsHNyWfStVylVi7RsSpHbj8QyDGxJvBQJ89arPNc?=
 =?us-ascii?Q?SpJ6NqqnE+ba6aZQNQ3HfwBjV/1dyn8m3uwX1Lftij5dvxnImgZKkEtK7158?=
 =?us-ascii?Q?iDNfysyVRrEudhn8btKvJ2fEbzSgiNg4iLymtZyszVw+WxZjwWdf1eT+n3v9?=
 =?us-ascii?Q?lmgBpiUcuDh+oF0dblHYImoj1IwcnjTkbd2jrsYpZYyf9+d/SctDHuuhffe1?=
 =?us-ascii?Q?HpLrDY/JZk+WlemKbEZTUVACnjNeyY3Y/9Tq6mgspILwNMDv7w01T3M5NSYg?=
 =?us-ascii?Q?PDWtuMVeEjl/DFijNt9hUFFLmx7t/xqreZgIRLqzquxbvqyAojxlNzmQlvr1?=
 =?us-ascii?Q?VFJAMI0jXvtFGixhsfa0ziAndaF3Mv7HhspaYCRbYF0gLvccWemQ2i5piBAe?=
 =?us-ascii?Q?0OUeBPAimd3cqnYwm362/Ye4g6ku3Aav4mYJR8lGVAUcUk5w8O4eXktMT50v?=
 =?us-ascii?Q?mP0dJz+cxSU4CyREqyz1g5AUqxQg/bgJ5rA6rQQ/X5RxsA38POrx6ZOCHe3k?=
 =?us-ascii?Q?Bg+rypnMWhqNv5nkXxS6iic6/2lNgvppp0s8A9VxN69InqYlFKr29+FwWAxy?=
 =?us-ascii?Q?fErHlSNX1ZSPyTG9qaPtxsl6PslrrWsNzoVeh9/z2a2OOqzWn/kSDjhFUF8z?=
 =?us-ascii?Q?MbSHV007NX4J4fu0EuuQ5PERaGNig3OB/Bdwk8EX9wXldchiEkBctNYfpxRm?=
 =?us-ascii?Q?mIx3gx4GnBfjSEwQJyYU6RhKq5VWi3Awn7rhOZSym149Om09yPYSA1VsFNh/?=
 =?us-ascii?Q?fgjlLxs5jSeDqJZeGAf55dFVy0FztgdvXAYiPeDRAmeu7Lk/ldd0F+tMAVwK?=
 =?us-ascii?Q?ZQNhPFBPtP/7XdYCF/rrgd86ntebHEZvk4hpftgv/Z36IAUMSICqhTnqqyxI?=
 =?us-ascii?Q?3TGhbe5RjQrM8bvtCJUpbukYzGLt/CcLof0CKBnEEJqKtyx8EWsqjeEF7i/8?=
 =?us-ascii?Q?CW0skEGhohEXBbbgZsfwrGVoeeh5VHdffmnJSdzkHV0szLdgFgRUjbJbFMrf?=
 =?us-ascii?Q?RfBTNt5VXh2I4RbPQzdAVBkVVp0wmrNrOemXKvs7NIwEJ9AumPODApgt1xJS?=
 =?us-ascii?Q?/WNuCXqgW37dnrHwLlyodLfBAq2J81/aEdzrECtKYm26scVi5trcyDy2/10r?=
 =?us-ascii?Q?Gk1DoI05vsdz+n99lR1rdO1m6R9jORomqHVvPA8NmtVkbydDLwQk/mSKNQav?=
 =?us-ascii?Q?+841Bt9Z11sFx9sjz+9lICMn/2/lnHve1BnrVrjn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e90a4e-0248-4fd9-71e6-08ddbb0ec136
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 15:23:40.6146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6TSqmA6mNmLC17+dq+fhaab4tT9SN3aKDXx6sPOMyvwsZqecLsL+BcjD5HCRe4tY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7205

On Sat, Jun 28, 2025 at 12:42:40AM -0700, Nicolin Chen wrote:
> This will need to check a per gdev property, since the dev pointer cannot
> store any private iommu flag for the iommu code to use. Thus, pass in the
> gdev pointer instead.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommu.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

