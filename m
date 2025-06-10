Return-Path: <linux-pci+bounces-29367-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3CEAD43FD
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 22:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59F99188604A
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 20:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59375264A86;
	Tue, 10 Jun 2025 20:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ah0WXVeK"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929AC4685;
	Tue, 10 Jun 2025 20:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749587830; cv=fail; b=j4r0c1zwtJdMVnupR568dOOdATrp3G7TPOnNChFRBpKA4BWyGpGULwB+MYLzTT3O6ui2Q5mCdvhaw8eHcZQz16/z30/B5x4GEFwok5z1blkReAJzT5hGFXBkRRGSB1qz2G1uLizCNpSvLn1FqL2S+ld0gMHOCzJCcJvCQgWWzDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749587830; c=relaxed/simple;
	bh=Tiq1hn5oQLaR69Kn0sf9R6gsxuVak252Lfe6fD9tigY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUmiqysc34aMTdF3e4c+xOEWj1be1p0RwDXnF9dk2c/KrUhzJv4hhOmqTJfzcrHFW+NRa6miIIvz3LLn0tJb6H4AmxO5nrcsrmEAauHGPL//HWG6fgkWG7qrAwSbxCalxATohEUrgo6cjOPB5Jq+k0S8zLA+5tUjbOPncl6bmaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ah0WXVeK; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EU5h3GRE4szujPcIuydE+2aQzlBzOY55pptpk01xzRow8Top921fWfP5POSkh5JcwiIPtrtzqoTNjCnYhh+Bysk485y/O2BbU0yAoMwI1wgZWbhCoRe6Ahuy5n9r+PVVPqYwA3iyQ/jVmEAVYXctsCW53iU+Y02KTENRML1APVdCRuBAsnTa0AeoDgBtMFhxlUrOQ2WnNJVeuZT/6GbOmtAAePWF1OHYcSpz1kiKPNPSaN0NcVtBpfT9k6PKdpw9bTNaVd8v2cw78xtFK64U05Rp16t7GNbHyl8snbX+T/1MOOoqtfHew8/00++ujr6PwkSbi76G38PpRaLAf4grgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4w8Z+Jv7CIsLTpEl49KnuOAAf83vtyqH+72psaJbeZA=;
 b=oOGRSJMGSG33+Hys+BnDxUVxoLRwGxZgwyPVUAInJMS0+ADdrp4/Q3qlIVm9M6tHHmc83GIWBdQuJJ9YTbEC46MbaqkP5Ixd2wtvyKfX7SxKSyOKdvzxP3PMYhIGeDMWZApUcHwLwH5GquPZN47zP1ZD91mtjnOMchddgkCWt5oYCdsv6UCu4tlQzX5V3EkOBxHEvYktXf9qf43b7jAAguEkJFeGL7VNBh7MNlwSykdxUeOYhgXipe25z2vDkiUwCXutT6frDKoqHf7wq3E18z6iuU7bLKneC27M158zpR8RRrT6mlb2O0kvZZIk3msL5pxpsUywKR01Yv6db4g7jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4w8Z+Jv7CIsLTpEl49KnuOAAf83vtyqH+72psaJbeZA=;
 b=ah0WXVeKJtGAaNuMDavsWpRusswbC1hjhyHyUif/Br+jyfWyIysVs+z+hl0YlpBh3KxtwPP6oYQHRbDKLIw1DuJ5bmK1eri8DisVrRthL2hzHePe4f6ltw0pCW10KxnIEBeYVQc0VM3jQ1ifiBMRzysBvxJoylnJ4INus+ifPSBoSFWK5UcGvxipZlZgExX4vUjikUg7boO5hVSZkHC4nz/ZEinTzfyq9oTvWk5W8U45O+12Ou5kizWVzli49ZHhWhXkeErEtK0EhpYVZr76jiv7MXM+IEcRVXgEkn7BqprcsocN2bcO75cq+RhX76sMFxbcmoKAPAys2ZhhUUHQrw==
Received: from SJ0PR03CA0075.namprd03.prod.outlook.com (2603:10b6:a03:331::20)
 by SN7PR12MB8791.namprd12.prod.outlook.com (2603:10b6:806:32a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 10 Jun
 2025 20:37:03 +0000
Received: from BY1PEPF0001AE1B.namprd04.prod.outlook.com
 (2603:10b6:a03:331:cafe::31) by SJ0PR03CA0075.outlook.office365.com
 (2603:10b6:a03:331::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 10 Jun 2025 20:37:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BY1PEPF0001AE1B.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 20:37:03 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Jun
 2025 13:36:49 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 10 Jun 2025 13:36:49 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 10 Jun 2025 13:36:47 -0700
Date: Tue, 10 Jun 2025 13:36:45 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
	<bhelgaas@google.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<patches@lists.linux.dev>, <pjaroszynski@nvidia.com>, <vsethi@nvidia.com>
Subject: Re: [PATCH RFC v1 0/2] iommu&pci: Disable ATS during FLR resets
Message-ID: <aEiXXYdhyeqcNiHX@nvidia.com>
References: <cover.1749494161.git.nicolinc@nvidia.com>
 <40f1971d-640a-44b4-b798-d1a5844063e2@arm.com>
 <20250610163045.GI543171@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250610163045.GI543171@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1B:EE_|SN7PR12MB8791:EE_
X-MS-Office365-Filtering-Correlation-Id: d1f8c3ca-90cd-463a-df24-08dda85e8ec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kh3o2r6bvxUtP5tKmOcQRUSvsb8Li8RxBEEUAD88uWscPoA1IkmPVkhlRT/2?=
 =?us-ascii?Q?GTkhtajF7utsjKM2QXJAtXUpD/Zx4pv9y/PQIZPIm5olFeU9soloE2W+1QBi?=
 =?us-ascii?Q?mBkwqxwz7Qk3oGWx983t26T/VFxOqsLNZad+r+Z7pJid7UkZTrYYf1kHDeO3?=
 =?us-ascii?Q?ViBnrFk4wthmf/QnjuFuCewc3ptfg9LBfJzVTjrytQ4LFudCl5hTdsdPl0o/?=
 =?us-ascii?Q?9jy2JKX4GdmYuhx7RneXV35gyw5+JibIYpbhazDAzaD2aaJ3AMeBNF/kTZRf?=
 =?us-ascii?Q?tzWFMsbz3JCZU3f/6ODMGYbGrn6DleGwxG9Y5pQUE8z9maZheQgi7ZCjhNq3?=
 =?us-ascii?Q?RnvRSJT2yyKJCtXHKJO1tH8OGbn9ULN23pynJ0NdcxZW+pT1L5b92c6BNtUl?=
 =?us-ascii?Q?Rc9W7/RglAkyW+2yVENGVsZG7RzIsiOiXjSqBidtvb+nfnGCKTEUK0FQj3Nm?=
 =?us-ascii?Q?VbcZZpyHcdQ4KujDvCEsdWjGLj0i4fPy6FvblaXzByTm6+mYctHzc46FnrKu?=
 =?us-ascii?Q?cI1Gt9yLtWz1rkSuT8fpoYakg6W+Aa7Ne/YQAV7RYfrVY8vn+AYMm29hayhr?=
 =?us-ascii?Q?70yIzJWAl/E+Uzwr1FqbGlKYQtsPut3cvvvBB0aB09O4YhPTGfwTLYkbHNik?=
 =?us-ascii?Q?Q4qno5s0gZIjEDWGyl/z2UCrV5Sg7NiRhWgeqB57C8Ds8zkVib2gUlHs8bno?=
 =?us-ascii?Q?HS4IZnil3P/EbvIcruZ7/WFZtShNS5NglcBJRJJf/EBTy94tC941fin/9p7j?=
 =?us-ascii?Q?JTq81KAFJgbgrpCGO7ekVrzsNk8mehWv/glfWOYAtGKVutlhhbm/ibqBGaHA?=
 =?us-ascii?Q?mW4r7YhVF6hdMCP3aKRREc5kYoXyl3zNbU+g43SlqcyJnbHFV9oyFGOtQS1W?=
 =?us-ascii?Q?fKMYSIJqwn+jaueHT2HQDDp/BEZSXL0CBIQkpJPXUgqkl6VyRlBfrFpJCAhB?=
 =?us-ascii?Q?sZHE4WGQSCc/HGiTqbrvgcw/2LTj8etl3FCOTPNIKx+1TcdxX4UdkNtCwCu7?=
 =?us-ascii?Q?OyHAJpKBe43rGqFkhQBk0xM1Mb73cqD28g3SCsdveOzHq2PGWInhusdep9v0?=
 =?us-ascii?Q?mW3mBiDDE99SWuA9OQJpyarQuaJ+VfwfLQcUnj1fljtIu+WHdTkLaQIWWj3T?=
 =?us-ascii?Q?1VqyhsosdY9o1YkawG7ukszakBPjaFM0OKhjc1UEJbi++MlxqGyLf1yKpUcT?=
 =?us-ascii?Q?gVNkL4RqB7cD28I4p/K6rpL8h+Fb2nEb05yugrtSUeEDX8dTW7I7Ljq6NiLd?=
 =?us-ascii?Q?m+ElJAy1x6wehfL9UCpVgmW4sKCvDWJdxYsZf2pyF2SJTYeussoEdxkdiuwO?=
 =?us-ascii?Q?Up3dEdmT7SAIBqjvtE/1RpLb2GVYQpJi1AwZxaregqzz+gd3Zv8Kmlpr/ixy?=
 =?us-ascii?Q?Fbp+MgxVuMkvR4qFvo8r4fwJE10YVbm8qol6/+abXh1T1ZTFJRBrVqsM4eVv?=
 =?us-ascii?Q?LVfnSQM4ZPM7WpRHJ2WLpvdn6PygBXwp3Nd5+Er+dovT49J01ucG7SZZHXKI?=
 =?us-ascii?Q?RTKlwDNdJ+CQnkXn1EFY8dPh1qxHacpGQnFi?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 20:37:03.1689
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f8c3ca-90cd-463a-df24-08dda85e8ec5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8791

On Tue, Jun 10, 2025 at 01:30:45PM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 10, 2025 at 04:37:58PM +0100, Robin Murphy wrote:
> > On 2025-06-09 7:45 pm, Nicolin Chen wrote:
> > > Hi all,
> > > 
> > > Per PCIe r6.3, sec 10.3.1 IMPLEMENTATION NOTE, software should disable ATS
> > > before initiating a Function Level Reset, and then ensure no invalidation
> > > requests being issued to a device when its ATS capability is disabled.
> > 
> > Not really - what it says is that software should not expect to receive
> > invalidate completions from a function which is in the process of being
> > reset or powered off, and if software doesn't want to be confused by that
> > then it should take care to wait for completion or timeout of all
> > outstanding requests, and avoid issuing new requests, before initiating such
> > a reset or power transition.
> 
> The commit message can be more precise, but I agree with the
> conclusion that the right direction for Linux is to disable and block
> ATS, instead of trying to ignore completion time out events, or trying
> to block page table mutations. Ie do what the implementation note
> says..
> 
> Maybe:
> 
> PCIe permits a device to ignore ATS invalidation TLPs while it is
> processing FLR. This creates a problem visible to the OS where ATS
> invalidation commands will time out. For instance a SVA domain will
> have no coordination with a FLR event and can racily issue ATC
> invalidations into a resetting device.
> 
> The OS should do something to mitigate this as we do not want
> production systems to be reporting critical ATS failures, especially
> in a hypervisor environment. Broadly the OS could arrange to ignore
> the timeout, block page table mutations to prevent invalidations, or
> disable and block ATS.
> 
> The PCIe spec in sec 10.3.1 IMPLEMENTATION NOTE recommends to disable
> and block ATS, and we already have iommu driver support to implement
> something like this. Implement this approach in the iommu core.
> 
> Provide a callback from the PCI subsystem that will enclose the FLR
> and have the iommu core temporarily change all the domain attachments
> into BLOCKED. When attaching a BLOCKED domain IOMMU drivers should
> fence any incoming ATS queries, synchronously stop issuing new ATS
> invalidations, and synchronously wait for all ATS invalidations to
> complete. This will avoid any ATS invaliation time outs.
> 
> IOMMU drivers may also disable ATS in PCI config space, but it is not
> required to solve the completion timeout problem. The PCI FLR logic
> will put all the iommu owned config space bits back before completing.
> 
> During this period holding the group mutex will not allow new domains
> to be attached to prevent any new ATS invalidations.

Will pick this writing.

> > I guess I can see how messing with the domain attachment
> > underneath the rest of the group manages to prevent new invalidate requests
> > from group->domain being issued to the given function, but it's pretty
> > horrid - leaving the mutex blocked might be just about tolerable for an FLR
> > that's supposed to take no longer than 100ms, but what if we do want to do
> > this for suspend/resume as well?
> 
> I don't view this a problem for FLR, we can hold a mutex for a long
> time. It principally delays domain changes which are kind of nonsense
> to be doing concurrently with FLR in the first place..
> 
> However, for suspend, we probably want to leave a marker in the group

IIUIC, the thing for suspend/resume is that it would result in a
long hold of the mutex, which can be a problem?

> that the group is force-blocked and all domain attach/detach logic
> will only update the group tracking structures and not call into the
> iommu driver. When the resume happens the core will set the current
> group domain list to the iommu driver. No need for a long lived lock
> this way.

Yea, what we don't want is driver re-enabling ATS. So, bypassing
it at the core level should work. Then, iommu_dev_reset_prepare
and iommu_dev_reset_done will only mutex the flag.

Thanks
Nicolin

