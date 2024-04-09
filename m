Return-Path: <linux-pci+bounces-5960-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA8589E137
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 19:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091DE1F254D8
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 17:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2ED155A33;
	Tue,  9 Apr 2024 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DS/GYcgL"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2096.outbound.protection.outlook.com [40.107.223.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6C8155387;
	Tue,  9 Apr 2024 17:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712682764; cv=fail; b=c7UStKf0Y7YuxEHQhw6QLVHd67aH7GX2YaXacVs+5GeQdU13ytYGL05cUgbDjKSGiNX+I17WvMmjwx5hLYHSq0s4skFuwYFCdGI4AsoKqezkH5HWYh5RgR7SapsKoOKH7jlBNtk3LdS8OjQLU+JIaZcMUyJIs1/RdRCK4v0cPiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712682764; c=relaxed/simple;
	bh=a3jQR4p3eKLAojy6kKNY+jzHdnuQmaeovFZ4BSmyMVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eWO2d3XRo9jKEgGnzTTmAxGzGasK4/7d6ix5mBXY1gPvtVmRIskoaBCf0Gww/Usurd4QMP433UpiVKUrKFR+DUu3O9dA55jWYYe07w87RSbzCvXHeyhX3gxZ5ruAOz87wzW9EH3Gn6uC06JYGdDXC2ToyxwjS/hJj+jeoMPpMds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DS/GYcgL; arc=fail smtp.client-ip=40.107.223.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqtqhL5GlEiaRZyZEjMIly1ocycR5tExtSw41uTxARqmXOEF47y0Mvp/+xmJgmimoawXqANHTHOLbShksi7J0Lpn6Q1yt/5+bY9Zk7NyjENLejPzQNqNC5AZkr9Q0AipgosDPYI5sAG0WAS4BhRm9Opm8t1ci4NT4GHsnO1CkUojo/8PyZ+RB0vzwvd3Ebz1MILfKGHqvTnLYVA07gylVx2gJwW8zCLHccaFpbP9zprQZW3QRAihI8FtkQ2vYosbDSSEpzcsFZHHyhrAkPqV1MFZBlylChyGX8M7ytVP60ia/9+9l+p3EuqUczMmAccRx3KTzjvUvxR5r2to6JhiWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l667UAFEyg4/N8e+I2SDs5GFnJ4fVw+K7VgNBcOZx+M=;
 b=Aab2inKg5/RVkN1TSs4ov7UTzzP+pfNk77o4DVpbVilcob/KHsQXSFs5oxqt01hF4qp86iC0L+Nb4OMA6/9bwEHZ7WDhC77JIWrks3X2HeCUw/mGZK5h2vj/+OcAr0NYWO8azLAcv1rCPw80/XMbbMOMd8477hGDAKF2TpSNrbmtg2RSKj/gjhaPOlDHTm23PVkDfk0hki5QJxcs6U/huTIQ6+8pdrEiWCgwqMbPcIbT+WD+Rhgy2pNj9GM/Z1SSbu575rXCNIrjk2YGjhZVceF1lj3M3BTmglNT8dyfPJpELMtV0jB6gsfHzhSOEtYqZqVpatLbTTubf8PY3mwHwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l667UAFEyg4/N8e+I2SDs5GFnJ4fVw+K7VgNBcOZx+M=;
 b=DS/GYcgLG507HAD13tqDkq7n8KFddfyR8UcA4UY+Qv20vQMjwPou4HnajUPKMP5ptUSZa49albnAuMBy82BXlh0FqxQjMC6fTHlk3OELEUrRx0qc6grgdMfRkWbeWqslokAENDpu3JCd+iBuRgoTUYzQTcXuMu3erPktMMVRj/XZ0AeNEFVGcA+m2fipkpNWxybmjAo4EAk/DUsHs0qta2jFzfrc86JPRfbZx8MBxjjVEUOPeGW9PI/IIxZDZMjjQ2ahBs+g+HFIvDO00uLgiRzJj8PwgPnpzzSnMdj+7o3iYUEEAtVZ+xtLeOxpZ/qZ5ir4qdWCyr6Y15Co4P71pA==
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH7PR12MB7356.namprd12.prod.outlook.com (2603:10b6:510:20f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 17:12:37 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.053; Tue, 9 Apr 2024
 17:12:37 +0000
Date: Tue, 9 Apr 2024 14:12:35 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Leon Romanovsky <leon@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net,
	pabeni@redhat.com
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <20240409171235.GZ5383@nvidia.com>
References: <20240404193817.500523aa@kernel.org>
 <CAKgT0UdAz1mb48kFEngY5sCvHwYM2vYtEK81VceKj-xo6roFyA@mail.gmail.com>
 <20240408061846.GA8764@unreal>
 <CAKgT0UcE5cOKO4JgR-PBstP3e9r02+NyG3YrNQe8p2_25Xpf8g@mail.gmail.com>
 <20240408184102.GA4195@unreal>
 <CAKgT0UcLWEP5GOqFEDeyGFpJre+g2_AbmBOSXJsoXZuCprGH0Q@mail.gmail.com>
 <20240409081856.GC4195@unreal>
 <CAKgT0UewAZSqU6JF4-cPf7hZM41n_QMuiF_K8SY8hyoROQLgfQ@mail.gmail.com>
 <20240409153932.GY5383@nvidia.com>
 <CAKgT0UeSNxbq3JYe8oNaoWYWSn9+vd1c+AfjvUsietUtS09r0g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UeSNxbq3JYe8oNaoWYWSn9+vd1c+AfjvUsietUtS09r0g@mail.gmail.com>
X-ClientProxiedBy: BL1P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::26) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH7PR12MB7356:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qEmVtir4HXuT1Qzcyhi6rIaGqnjIKUnlAaWmvVkBb4Na43UwYDFlhG54oATv2vMGifLSYGh+EJWcbYuU5/NHHhZHkklkKMrSYsFtKk+5psuafl5iDjjWNNWwbjCmf2nPRCBipyGyK9j1G7IK2/mtOlAiLUi+69qZPgBeNMHBjqrHMc5hp1Qv84irIRDaphNfxXsNLy3FJxOseQJXHWUMA2cgc1IhEK0cPQtVuOaA2k9w4GY6hTm7BDBFyulwdwieTy1kGLIhMpf7KK15gBkb36fo/Ri/nDrv30czkzBtZE7+imzGkTxHb4jaAnh4Llg/RXp/rfwthZltkGTTE5Y985Qi6znYGgwA/f/Cv+xROPtH4nUZvCkK/f+ueqH+Lw9oNSbGDjM9n0ENlhOHOOhBuwsHV2WeyY13Of37uwB91NlQRJKZHJxuwb5kfnF2SqG95EOs7Saz4+EjKuQhzJibXvjRu4RNsM2RqGvXk9cooG0uVwaDgYAwhZfGLRqZinlDxxOWJ/KxnLGvNzlFTeQPPN4rqn8LQ5qHjXftD3sz5j0AyJpU2Nqopq85MyLjrxFDxDKADfBE/ePyOIAbZ4zGzCiPmxjY9jynS+RN8K4hlo2NDBKcmXu2SEyzCckctUWnhylo02PXfW2fBHLTj/3w08UkL8WERiUMZkeTretB+EE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/vzW6ipAIXNRJbztW6a5MrNB9MSDo4FTqPrZeqQVm4gUR8Zdoprs//nif2K+?=
 =?us-ascii?Q?TJFl3bJuc47hXu9s6yuApA8GBwbtxGl98KGSyt/IgEU5HfTvCI7IO3mJP+8c?=
 =?us-ascii?Q?0cCynBQKKhNwcAJwngmpXrquOX+9km7TwFbFjXu6p+eDtZb3YlZKutZzKXNk?=
 =?us-ascii?Q?dtflOU2H0QMvbrs0lNpiMoBfWXtwH42R8ymYCQQ01p/Y66inBp66+K9WOSsQ?=
 =?us-ascii?Q?WUeqMixb1AkZeCTt8qPLXe6W6VzWeKJ7jUuhqrm+LiD5gC6Ib/jYRZ3372LU?=
 =?us-ascii?Q?sMqhpCA0M3MJIzzpJofQxjwcWbvRr/DfPN+PR5b5wduqKCmS6hFNVSsyUlXY?=
 =?us-ascii?Q?hVhz2YkLdJWmLmYrzHmpIceIjFPgNbuwG7saQdRDjfi4HscgyA2Pknjc9Hoq?=
 =?us-ascii?Q?EBnmGCRcoiopmBykpSEO9JPeD8AdszDHCmxM/een8YVFQGhpQFHw2juSnTl8?=
 =?us-ascii?Q?CFE5JuYeQqE9fg89Fy1GdVhJiX+KV/qK4bwbMady4W57vncB/N3PaNh9it9l?=
 =?us-ascii?Q?Lsbg+uThGoXTnpnleLpqrhzV4W9SukREzH0lbjpXRiE7bLsFs8FTdP7rtCHX?=
 =?us-ascii?Q?iwTOauEL6GbtZH+0zMgvXWYaXfK90cv3F49PbsJmC3voQ9+aNOgV11puGIcj?=
 =?us-ascii?Q?mSLe9mzUos5yOv7WtCeH3QAg/zbEp6L6YOrPVv1m6sVyjUUxzOjIUsK/yztS?=
 =?us-ascii?Q?Ad/VmTBZh3DdSamLFCOI5wv1tQza4HJq8cecZC8qRj7Uhvnykz0zdkGBqJbZ?=
 =?us-ascii?Q?JGoql6/MGOMxpQD2jrT6IkaSqWz5oWDvm5d/gZ6zdHhKcWC8l4ESW2oiI2Zj?=
 =?us-ascii?Q?wBWH0mbj2EMGCeOWgRqunQtmCPMdnz61WRz3KSYWGpwXLcDhYVnkNlapfC4v?=
 =?us-ascii?Q?CQMY0e1wqtusCJJN5Wp+XK43jt0Nb5v+VaP1kef/GY4N/dNwc4lLi7nc930c?=
 =?us-ascii?Q?r5jcWpl3qhwLQNJ+hvSiCKhmlhJTSu/VzRQ21+HYTvqegdklZI7W69iBXnzf?=
 =?us-ascii?Q?dJgR2tortYL2v7V0NHat5TB24/BNoQrg+VtyFVCXfspWVCUAST2kJ1h3COIO?=
 =?us-ascii?Q?h9GxAIxnizXdPnHz9aV6BR7iKdB4dAboK5Idta6ucKEofQIqv+HXIgVyfuls?=
 =?us-ascii?Q?2R0D1YFJmHP+lthBIPW6UE2VCvGdiNKftNgckBPwpKbylGjf5O3mdssbAJYJ?=
 =?us-ascii?Q?WVU5WmRhdnxtR+9P9IwrqpxjduaznMbtBq/AUylKSKhu/qdTyBF1yLxBAwr5?=
 =?us-ascii?Q?GT4sbZAReRXsZiO9p4Y02YCkobfZtIZ0oGWhgBJCyZPDZKoluis4VLSSOFnv?=
 =?us-ascii?Q?VwXSZau8PM95zBUd1Gq6M7fCazdGh5MxSk35tWiuGmzs5rxvvkO/VewQcyqM?=
 =?us-ascii?Q?5gau36Ij2BIrvLUcyL5cgU3IZwgfqedx4rxxvHCR/zfNOuD1qAXdMnGY21Yj?=
 =?us-ascii?Q?Gbzv9uvfjEM/uJP1PjebtCPSLUGmdmUW+aLXqjocc4P9XtV7122awveROMOH?=
 =?us-ascii?Q?cUfQGOgZAOW9nh04H+GLcCy+QCYsnPjwgwv5GiEzgc/XD8ID/BOwH62+fuFc?=
 =?us-ascii?Q?hXBP66uwu/lahqo8xOpS/NJoFQLI+yeNZof+geP2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2901cf3d-edaa-47fd-e7e3-08dc58b84110
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 17:12:37.0196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vg1e4LlNCc4vNLTR5kjqhvspIG0Zt8YtNH4jEYRLQT3gThPYC2mtC7svdBtUAZfB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7356

On Tue, Apr 09, 2024 at 09:31:06AM -0700, Alexander Duyck wrote:

> > expectation is generally things like:
> >
> >  - The bug is fixed immediately because the issue is obvious to the
> >    author
> >  - Iteration and rapid progress is seen toward enlightening the author
> >  - The patch is reverted, often rapidly, try again later with a good
> >    patch
> 
> When working on a development branch that shouldn't be the
> expectation. I suspect that is why the revert was pushed back on
> initially. The developer wanted a chance to try to debug and resolve
> the issue with root cause.

Even mm-unstable drops patches on a hair trigger, as an example.

You can't have an orderly development process if your development tree
is broken in your CI.. Personally I'm grateful for the people who test
linux-next (or the various constituent sub trees), it really helps.

> Well much of it has to do with the fact that this is supposed to be a
> community. Generally I help you, you help me and together we both make
> progress. So within the community people tend to build up what we
> could call karma. Generally I think some of the messages sent seemed
> to make it come across that the Mellanox/Nvidia folks felt it "wasn't
> their problem" so they elicited a bit of frustration from the other
> maintainers and built up some negative karma.

How could it be NVIDIA folks problem? They are not experts in TCP and
can't debug it. The engineer running the CI systems did what he was
asked by Eric from what I can tell.

> phenomenon where if we even brushed against block of upstream code
> that wasn't being well maintained we would be asked to fix it up and
> address existing issues before we could upstream any patches.

Well, Intel has it's own karma problems in the kernel community. :(

> > In my view the vendor/!vendor distinction is really toxic and should
> > stop.
> 
> I agree. However that was essentially what started all this when Jiri
> pointed out that we weren't selling the NIC to anyone else. That made
> this all about vendor vs !vendor, 

That is not how I would sum up Jiri's position.

By my read he is saying that contributing code to the kernel that only
Meta can actually use is purely extractive. It is not about vendor or
!vendor, it is taking-free-forwardporting or not. You have argued,
and I would agree, that there is a grey scale between
extractive/collaborative - but I also agree with Jiri that fbnic is
undeniably far toward the extractive side.

If being extractive is a problem in this case or not is another
question, but I would say Jiri's objection is definitely not about
selling or vendor vs !vendor.

Jason

