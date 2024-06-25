Return-Path: <linux-pci+bounces-9249-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E07A916E3F
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 18:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 374C21C20E3F
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 16:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24684173324;
	Tue, 25 Jun 2024 16:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ag6vMw7B"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784A313B2B0;
	Tue, 25 Jun 2024 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719333564; cv=fail; b=FV6DZZgAQqfv6mqJnYz6tsuwTpd006wGXowtzyuyT90/Bae83LgxldSB9foFigxUVVgYklB7DEyYNS0VErdALdtvJhpJPBESphmfdzYAFoSX9929v8qRSaj8Nd+sHnCc8nwDIgD8zSUlZsUxe8I7IImpaSXpD3G1cm4452XAat8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719333564; c=relaxed/simple;
	bh=/ua6GlBeh7cJJwmA7mKFml3ORbnQe4FAKeJAuceBPl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HfQMFMVZyXXkWQrRy/a2i0apW9LJcMA1Ooo9eKu5lw8cZjw2ezTWhhjky9OzDjANaKUVQMGu7bE0TaqIiAoMxqxsOy53g9/F15bNuNDKKP7mH9L3kOd8jKJpfkgit0cc8RSUNhpS5gL9lAlUARAKJAkab3Y3mbMkCTmbPb+FUi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ag6vMw7B; arc=fail smtp.client-ip=40.107.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U388pTKTglJ0IowEJ2Y0qinvmU6+N2e7UV8s9V6+grq6DSdoLtzWryK6gZAqRTErzTlJ35DQYCLWrECAH5FeEYNhyJGbaFqy833wFxNhykZxTap5WkXZz+7WMU66+PujHgHWz3MqFSMUUv7Ch3AOMlnEHo8NCN8nR7izPIRRjbbFhT2gfOUaYde6/BrUN9/KM0NOVZD+x3J0re34J3gOyGeJT6BuKCP1rSBWHs5rZeKxa5+D8Cx/4ulf9GW7kLi7RjdS7BWDY7j+OHOxBCT20v5i+YJkruljjcvGy5Q3vveeNTj8irnjQUva4ocw7LQ9tlTlOoWV6zCRJugl5xOpBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGEyb3ZfFRE8y5lfwQKLinwpimNtoPx5CR8/W+y8Mo4=;
 b=K6RbhuhOThEQK5lFg7vMn/Yv69uUSO8e6D7AaGLqlGnA7pQKs+3nQRgQIdFPOavDevL19k49B01YwIl8C46E+aV02Ic5eJsjkH69W7qF/Y4ZYf9q9o9+SKZSLrvulrTHqZHR+55m6WDFTuaHtTKfZAZQ2BuKt//TCbYQ5jznCfM4K1bD4sNQjH0nmGJeCTOlHXwrBAr5lH+VhSL0l+KlX/rV1ZJ/jR0Y2T0rJf08VzaPP116F37dzfZG5Kqx3feU1LTCBsf4i3/cl7MuqUFp4FIWpj3PAe16LnJGAmKvvsspSoDmzkQZVd0cQWJAeywIttd2rk/f4vo8Vl1sljWrzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGEyb3ZfFRE8y5lfwQKLinwpimNtoPx5CR8/W+y8Mo4=;
 b=Ag6vMw7BW+9th6EL5D36MlXUbuadzVAZu1wiQkYIJTEmRyjf56nb2k8xqnKSo9XuUrPPWIZV7eMFF9b9HX8OK0YjJh4tQ5Nu66Q7PE1pvIT8mKj5tjDyZz2i3kQJySHEd8hNj1k+HKdxiDroCxCMquOHyoSCVxulRCA9tvWCyATG4LZOgegFRYF0UWFcDzKfM9pDWPQarJ2lZM9iEHPKyFh1VDAS7HK7KdgHXL20kqdzW+3iip8rJ0m4cZ1cDWGxH5O/RqSJp8AE7x7WJ3JzCJFDI4vJ0HPjykNwCmoAcan42+N7emkxdWXQgfWwapEexOGYdxV0kAGF7Feqt/3snw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CY5PR12MB6228.namprd12.prod.outlook.com (2603:10b6:930:20::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Tue, 25 Jun
 2024 16:39:20 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%6]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 16:39:19 +0000
Date: Tue, 25 Jun 2024 13:39:18 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Vidya Sagar <vidyas@nvidia.com>, corbet@lwn.net, bhelgaas@google.com,
	galshalom@nvidia.com, leonro@nvidia.com, treding@nvidia.com,
	jonathanh@nvidia.com, mmoshrefjava@nvidia.com, shahafs@nvidia.com,
	vsethi@nvidia.com, sdonthineni@nvidia.com, jan@nvidia.com,
	tdave@nvidia.com, linux-doc@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4] PCI: Extend ACS configurability
Message-ID: <20240625163918.GC2494510@nvidia.com>
References: <20240523063528.199908-1-vidyas@nvidia.com>
 <20240625153150.159310-1-vidyas@nvidia.com>
 <ZnrvmGBw-Ss-oOO6@wunner.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnrvmGBw-Ss-oOO6@wunner.de>
X-ClientProxiedBy: BLAPR03CA0163.namprd03.prod.outlook.com
 (2603:10b6:208:32f::7) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CY5PR12MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ab8375b-b05a-4c54-c228-08dc95355c76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|1800799022|366014|376012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6umosI30ZwcXJLvJmrFEtS7oPSHt48MH8NCKFFyUhCbLf+f6on5/JLx/X16+?=
 =?us-ascii?Q?Xy5SiB+8UlQLTiT93wCn+OQyp3UuuEIiP2KvhfGbwQOk1cgC6UqBR6wxc2Dq?=
 =?us-ascii?Q?fp7+hTyKC8led5VjlYmZyamvCcFNZNJBUeknKG/3P6wjU17+nt2gC/6MVW3+?=
 =?us-ascii?Q?mLID0oyj1j5GG/kBESq6NznY8cuvgsATLZPGn6LsCzpTW/iRYMfe1xvNx34y?=
 =?us-ascii?Q?LbeY0fwuNUMCGo14Wm2I/XXz+eiBeADMugPWQi+2Ht6aAhyClB5B+YIlwXIG?=
 =?us-ascii?Q?xapb8R9AZODvlZIZFfofWaMMst1XAiud7HyR4Q1nlcEZpJSryAYd6TTmANg5?=
 =?us-ascii?Q?Uc/4IrDoaoFOUnh2PwUl3hr5eaOGLxn2wYlzwcEh9Vh0ojpffSwog6JT6Imz?=
 =?us-ascii?Q?mjgBAc7uB6kB2ZBKNOqbt8it/rjva1CK5arHXpLQrzVd/xStcsU950de4QoI?=
 =?us-ascii?Q?tuxwGAKxbu6Y278ysKG4wTV6d/BipRIuPFzUTMtYi3EN6yyQ8qI6rzuuLm92?=
 =?us-ascii?Q?fc+eotL4TnhvYOlnXG/l4sLJo4ALTdtsTd832S1oOqbMZyH1FwV1aYyS5H0w?=
 =?us-ascii?Q?nDLA0ajQ5zpcM4hWKaK6D17i0wlJcl0fCAsZEfiK8xrcHwZVo2cZz4rTxGyN?=
 =?us-ascii?Q?O3jghrWfYX5bcQ95pzPIknbYosBvb4/xtzTj32IoZhfKLK3qT1xCbXwQMxkc?=
 =?us-ascii?Q?adUthI/7ryqKl2eE/5wxb2w/nATgw80BnApaCuxMyhSSdDvVdgJ80cLStkyK?=
 =?us-ascii?Q?eKwF6Bu5tXXkv/pUHOF0PCkznFfOY/vkXmhNr1M1qYD2oA/nMrGdD4l4Wpvr?=
 =?us-ascii?Q?oo4ciCNbD87ZQ9tYs/5WixW/Dj7kyuJDa5RtDCAatlAAtQCJcYhy4exHFCUF?=
 =?us-ascii?Q?fBKwHAmMZ/gh4AIYbwAi3lplyoOvRM8JmOM9p76mA/VtdF8nL9gt2PWVrMsd?=
 =?us-ascii?Q?XH5vseUVdaeByOaIapkN4sm5TaRn4hDqsPnYw38luZfkRuyjlR/3zekVp1fS?=
 =?us-ascii?Q?/Vk0oveteT6bldB4fXMfkNKuzEf7ivQEvJZCiqS+ByqyhiAV4SX2eZZbjEX5?=
 =?us-ascii?Q?mG2Ov216kAXiHq+HmpSa7MwTfTqNTbdhxFqAjiPrdiG55/nRZxbihcGdlH25?=
 =?us-ascii?Q?G3UzUqRn9iHS0Kdq24eMizbVZYZ97jU/4/J1e4q99IxAz4CDqKq2aFsK5E/6?=
 =?us-ascii?Q?wJI+ffbtnt2LVn0OJ7Vp5CEvIlXcSGNkNgtLblxuFuUfsWUpiRD8AXYdeMpY?=
 =?us-ascii?Q?jVkrdPmzUkj/NeVFGlIL1C0/EKMsANf58HEt7aeDD9esMYW/bwe3mkPr9FZN?=
 =?us-ascii?Q?pOAgl2qpLwVWT0U4rdSuBmCU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(376012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?86O+4LRMZUwhDvGOfhHg40RmVPY5hQObxHp54qG3095q+9SfJJ4JYz1WPfcu?=
 =?us-ascii?Q?r3Fo/MLLvHQBmo5+Zo7pUyvy7F0XAhUfy3l80jHBByOGwDCLNvhFnHtuOURJ?=
 =?us-ascii?Q?doSrXW6mCJJM38U2+XAIyP5tMXxPARBGX7dOHvfhKTk7J8R1OB16Xua9pLCE?=
 =?us-ascii?Q?Fer6mJuMUKdgslFoy8Z4DClD1M5XfQY9k/ysYGJzY0f+DlgW46a70y4EjUma?=
 =?us-ascii?Q?K+B7++njmB+7kF+LIR9d3ChqeNgkhd0h3gFX34I8O/0MoUvLRKOnzSXumNVh?=
 =?us-ascii?Q?ZST+HGsxNFgyKd6+t5T9Cz8kI1ce235cSHH+9sgdWGZmuovlSkkYRxsvXTsz?=
 =?us-ascii?Q?IIfrc8smmZEhpa6eU9L1a1vxfjbHRAQA/w0cnajeYDyqV2sYrlQ2cEKZyWSL?=
 =?us-ascii?Q?9YL7li2gWbll0YCsp2ZS+xQ2jFHRaO0oevJtiR6GVTXWM6sY209qrCJj4bf8?=
 =?us-ascii?Q?6q/qxGS+dyPZSEiG9oxRppIdIq8zAgEj017WGTkY9VK+g1sGdoBpKExwKKIK?=
 =?us-ascii?Q?zWPiVcBJ2WJ0UQ/z8dwvZlo04hVsUP/qTtTVzPPcsraPorttd/sbqDyzxpmE?=
 =?us-ascii?Q?wOgT9GnO+pa67CQWh/DKnvyRCwMAxT7FUSaEASUqNQgsRIvRjVGKS1NSvmkE?=
 =?us-ascii?Q?r14WiDY1E5khLxQYz1BCaTHxT1ygMVES47QOO48PU7MoUMb8BydY64Bd1OFe?=
 =?us-ascii?Q?NkjVx6zX+vzGOxgF2wwlDXg1y/3g6Jzq/cYTgWcH17XAenhQMOB2aDzke8YG?=
 =?us-ascii?Q?LMfUNPaKvVIMvDsZ0tmkc7Eeop6v/wgPjuUIufjftoRll0bNawnrpsE5E9HX?=
 =?us-ascii?Q?lLudU9G5uSf2/MhYKpqb9dh7Tm7iuxSfYU2MNBgjsvAxjt8791TLUS+Y7TAK?=
 =?us-ascii?Q?xkxL8q1Mu/j8aMpGEGvwLXupracg7XUKLioF820ijwWYsi32GgtFxcz56mFV?=
 =?us-ascii?Q?xWvi+T/1sv0DYNXshYe/lK0XhLUmFTV9eFvDxB3yOHlva+G71qmgkoGE+D2b?=
 =?us-ascii?Q?qHUwj1KCUHDbxjU8mjwZWx7thXzPMJGpctyl6L/zOhCBVZuBP2t8+6D//nNC?=
 =?us-ascii?Q?H8HljEyQkVIajtyEdnW1QlxPOC0Qzqh3OOor450fK9j+r02ZkOLxU5A2GSXh?=
 =?us-ascii?Q?ohVjP6nPpNBHMZt47x1Lp0Lr/VFvekiHwdFkrOu8irFxbBc8fMeYsbGBDLhY?=
 =?us-ascii?Q?OfiaWynhuJJ3sohNitOvvJkHG4jJ0d3eCx8P9aA3drgiaLUdWv35DR2lbIdf?=
 =?us-ascii?Q?bDT0UswSHEK3c++r0PqM/vaHddRQGKsYsiY/WaysqBwhxLc5YBdzwiQftAMo?=
 =?us-ascii?Q?x0xaWYGArqRbg9ETtRZzOXstfPozG7KdnRex7fbj0ZaepOATbqSEy4p6eimg?=
 =?us-ascii?Q?2zhlLxzCAp9dLJJBCnIC/t2+35aDsuhV4c3e+yWOXdsiPKBESWedgD1jaRhV?=
 =?us-ascii?Q?F0fYpfF1QF+NCzlppWD2V1Vzg9koAMsp4ZXsJRNW/Rem+EkrQ7uwjDdxAKHv?=
 =?us-ascii?Q?4HtM2gUMRerHQBvTmmup1d59848MduusZS9i9SoXI0v1kdrst6IZodlvl4Sj?=
 =?us-ascii?Q?GArlvkus8rMixFq+NlHHfc+ZCIQx+WHr+4+Y89Ar?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab8375b-b05a-4c54-c228-08dc95355c76
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 16:39:19.8383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UTguniJi7/ru9DyKpX9Us45fMVA+xyqusEbF9fwthQcjieBpSQqRpdBv8VicPg9P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6228

On Tue, Jun 25, 2024 at 06:26:00PM +0200, Lukas Wunner wrote:
> On Tue, Jun 25, 2024 at 09:01:50PM +0530, Vidya Sagar wrote:
> > Add a kernel command-line option 'config_acs' to directly control all the
> > ACS bits for specific devices, which allows the operator to setup the
> > right level of isolation to achieve the desired P2P configuration.
> 
> An example wouldn't hurt, here and in kernel-parameters.txt.
> 
> 
> > ACS offers a range of security choices controlling how traffic is
> > allowed to go directly between two devices. Some popular choices:
> >   - Full prevention
> >   - Translated requests can be direct, with various options
> >   - Asymmetric direct traffic, A can reach B but not the reverse
> >   - All traffic can be direct
> > Along with some other less common ones for special topologies.
> 
> I'm wondering whether it would make more sense to let users choose
> between those "higher-level" options, instead of giving direct access
> to bits (and thus risking users to choose an incorrect setting).

It doesn't seem like the kernel has enough information to do that, or
at least describing enough information in the command line would be
more complex than this.

> Also, would it be possible to automatically change ACS settings
> when enabling or disabling P2PDMA?

No, as the commit said the ACS settings are required at early boot
before iommu_groups are formed. They cannot be changed dynamically
with today's kernel.

> The representation chosen here (as a command line option) seems
> questionable:
> 
> We're going to add more user-controllable options going forward.
> E.g., when introducing IDE, we'll have to let user space choose
> whether encryption should be enabled for certain PCIe devices.
> That's because encryption isn't for free, so can't be enabled
> opportunistically.  (The number of crypto engines on a CPU is
> limited and enabling encryption consumes energy.)

But that isn't part of ACS, so what is wrong with having ACS its own
configurable and other PCI functions can do what is appropriate for
them?

I do encourage people to avoid using the kernel command line. ACS is
forced into that because of the iommu_group issue.

> What about exposing such user configurable settings with sysctl?

I think sysctl is mostly deprecated in favour of sysfs.

An ide file in the sysfs to control the IDE stuff makes alot of sense
to me.

Jason

