Return-Path: <linux-pci+bounces-5965-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2AB89E2C5
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 20:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE5091C23367
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 18:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4966B156F3E;
	Tue,  9 Apr 2024 18:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uOqTyhdQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2115.outbound.protection.outlook.com [40.107.220.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45D913E3E8;
	Tue,  9 Apr 2024 18:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712688904; cv=fail; b=l2A4b2PqSAaIUFl7OwrGsRrzqxH4mkZy8hxwGhfFS3EywS4P/C6gR+nKpmVOMsfDcu+5jMfOpCwaLhC/mKnr8uep76JEFjwgsSODQNxeWAoxj1jUNau1rFPX1zjLJRc0gahCd1j4nE2i55SGSmY4LRTwSnVbrLSxBuroSmoPI2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712688904; c=relaxed/simple;
	bh=3IQ3NmLf09l4Wo5kkUwFB/ljrEGBKL+//icErAHIGwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Blu/76Yh8+dTddIpFKOoQmJJHcGicibC4ycVnTbHmCc+RUiYJrIJJrLLL+EddRmBvecIR3iXmMNWn+O+bDnes08O5wsaeA9BuNd0bwEZ7PIHCqdbmWCMLLOlyqx+rq+8nV3Zwz4DTAo6iQzPZw+5wPnjzy/hGeF943dJCb1JN44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uOqTyhdQ; arc=fail smtp.client-ip=40.107.220.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tq5YWpR0KcyiW3wKqvOvVZMpcWZYCj+cEPgs0vn6cgRXkCPWQ40TZGRnCbaZF3aY91+hvxJVHXfxVTnZSVZytbnGlfUfkUz8ThxsG9hjBhs2HbFb7GgR77sXmaj0cTqLdQeVUkF0ye48LbvqcdOvZJ2wTz/HpVRiNelkjjznbmJtv2Qm70wTU1Uk/aATIykuZ0h+cRASNcdsrRRS4UhHNBHvyAkLq2kFFf5YWLBSKTP13LPaf0qWsVgfnIpsV8ErmKbIo6Ha2gYTPayO9cPrl4SarE0/TTsayWo16KwvR2iPg+n6DPPueKO+awgicViN1MTtzRiQ2MHaZzzfk8+VvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6WwmyyAzOXT6NWJ9v74fBiQ9GW/hIuLu19nFeWqJF0=;
 b=M48mkRf5VP+hCANcGILkEVJeqPJ5zOftrYdIuHNi0sH8BNOjSoa60Ifa8jccnsgGal6DP24ZP1OBlN25JqWh6VisOr2MvYw8fQGhnQZnIYSY17FTDKxdAGH82ryPonulO6i8hu7AhSDmyshBKToiphZkmLvW8wRU09eEaHesSC8aZJtRecJDWvzhP7D4PSW2UCLNSaCa6BEUVNxhFP/Zal4fhfft5S7ScR31IZCjIZirxan2xrO0IlHgoP7Pk9errD21giE+mwsyeXXL+yLqIvnD29+7De0h3eWTJShypLgboD60zrFQl3bn7kGUL5ZBbYQd53JTycHiz/OFa3GkRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6WwmyyAzOXT6NWJ9v74fBiQ9GW/hIuLu19nFeWqJF0=;
 b=uOqTyhdQl8g5h5pyjOe/mSsapePFl0NCAEUqDXkl0Lj1Vf2blacDgt7sfZGbxtnE+6uLO9r11onJV+Sie+xNVjSKFuih5HaszJ0YYSLRVN7lL84vkZKHWg5VzEKOmet+sRgM4zCL5Bt1WPfkdRU+Uv3Cl82GvQFg2qjzBQryNO8CZ7yNrs9o3z5RvuFVFVyZTRkQxRU2RnRV+Z2NlKyP+beHl7GtJ/JBSwOG2LJEQF/2PkeMuT2FmVLJuOgfZxw98H8Qzw1muSX40UcYL9fG0xQffT+GR5P5Ct+eYPwHxeWV8XwSnBqlcTE0mgwr6QRpH2phoq3DI8O194TtvspuXQ==
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CYYPR12MB8856.namprd12.prod.outlook.com (2603:10b6:930:c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Tue, 9 Apr
 2024 18:54:59 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.053; Tue, 9 Apr 2024
 18:54:58 +0000
Date: Tue, 9 Apr 2024 15:54:57 -0300
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
Message-ID: <20240409185457.GF5383@nvidia.com>
References: <20240408061846.GA8764@unreal>
 <CAKgT0UcE5cOKO4JgR-PBstP3e9r02+NyG3YrNQe8p2_25Xpf8g@mail.gmail.com>
 <20240408184102.GA4195@unreal>
 <CAKgT0UcLWEP5GOqFEDeyGFpJre+g2_AbmBOSXJsoXZuCprGH0Q@mail.gmail.com>
 <20240409081856.GC4195@unreal>
 <CAKgT0UewAZSqU6JF4-cPf7hZM41n_QMuiF_K8SY8hyoROQLgfQ@mail.gmail.com>
 <20240409153932.GY5383@nvidia.com>
 <CAKgT0UeSNxbq3JYe8oNaoWYWSn9+vd1c+AfjvUsietUtS09r0g@mail.gmail.com>
 <20240409171235.GZ5383@nvidia.com>
 <CAKgT0Ufc0Zx6-UwCNbwtEahdbCv=eVqJKoDuoQdz6QMD2tv-ww@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0Ufc0Zx6-UwCNbwtEahdbCv=eVqJKoDuoQdz6QMD2tv-ww@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0387.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::32) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CYYPR12MB8856:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P+m9gijaZqTgDTeod/FsQEuMdUQi7pkmEODobg025hBNyBC9EQvKa4fTGEIeOPZIKqcbRx5hwk9r2tq47l3gNqlyFM7v88FlnFHUYxtkM34QuXMTzQ9+A9Q9s1I2oX7wXrZvlCMSf+B4nNV7TjDJR2QwIsVl/kkrZm61fNrutzGdLllKs7tXrTt/4BXnBjxrFkqIeGGe+AEd1NCuju/NxWRB6ArwG+ASeRJzZDjdk4D5UWw6AiCSopUz2dfxC0/tFRzC3qQh5bNvZAlubCz71lCUz387GGfsN0M92infr5pUqxlqg8zBiGygs19HYlTMWgWLlWeUlkyCQS2osP/N4TyLqq8NMuP3RkZF3tQ7ISyAQrJYdQ7KG87Aev7oG90NokHf5mzQaiVPeqinhPKQUs+EHnA2UWaAPpK+Msiw5nHqsvCb/KGXzfN88zWutRu7mWxT2btSDQ3DUhSf/TFAyxtzqHerkOtPwWHfM9uNtqow8SmtiQl5gc9uo2P3h6W7xNqpUPjXQYvXKbHIHMIUonZyhp3MBbgYLBJOGknPeEjF8fOweBn7SyFn/UkoqAD8r+EGbP/PIh5wUwpeOo7jC1ICw8ZvM4tGejC4/7SMTi5+mzgHV+4W4RtIppb2q2DVQHuOOIbPWRelwfgM57CIYdWZFTnaj+vYv+9tTytk6Ls=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GYXFXUnTMTxbTyYr+MOFdU1VgSScGSNAAb8o8cU501SM4gzHx+VLc/VzaP7a?=
 =?us-ascii?Q?Ld9iItXUK09ph8lbZCGdfhMYZxqJNwuk/+IdSFYDHihmvHGhgCenSzb4fwPt?=
 =?us-ascii?Q?mMpVoX563blJwg2RxzL2Km5cynUOBP1sSD2v/M3pxpWDxg94R5Rqhwfvl3pD?=
 =?us-ascii?Q?uNMi/UzH+gtD9PR3hteieu17TsI/2an1mIXkPU5MZ/C6cMWH386RCaUJ8OPq?=
 =?us-ascii?Q?SSDEZC6pIoQbCyO7B3WRXdNSyF/wB+1VyHVvneEj0cgL3M1RWiRaN7rUagNp?=
 =?us-ascii?Q?VolLcZnCd3wftS0jBI6NfKJHEQVUYr1M+DhgEpOJv0BRm7S9+drg8KDwP9zS?=
 =?us-ascii?Q?FHW424hgO/8tFUUWAoCwOxqAADJgMXPp/Hkz6NmDEqny/MInnOt76T+F77cT?=
 =?us-ascii?Q?fnD+RGm2FXFU/wTtTVO+mdUIb924ilWS3c/v1Lc/JIGJK2zF/6Fun1FSbpTP?=
 =?us-ascii?Q?gClOyYHnMHcqYgyDiPw6euS37I2MYuBLxqkbi1j/ZQYSfEXptQajMX1X9RWj?=
 =?us-ascii?Q?k4jkWTNzAETfJ7H3qX3+iQ4DqSPg1hgox0zkiH/zf7ce/9oAe1xEX3hR5IHo?=
 =?us-ascii?Q?rIU9UmXBYqxUFlCFQNETWqrk+pflVLGwjuPXVhx7Wlk2tLw/QKqbXPcuMYCl?=
 =?us-ascii?Q?LE+CJAzb0Ka2QIk+QYC6Uue0z1zaqlRB9f9wIBD2YlKFIT/iZLN2GaDM8XIo?=
 =?us-ascii?Q?MSAdziQC4N/xC0xn8HNBLauycOjvqVdx5XshIdPDK85ngTmWvP6iljWSmGIS?=
 =?us-ascii?Q?SvvSF/RPWc9N3WqlR7kx0DTgLQZCYIjZPa76GBOIuD4bcLvLaVDHO7HdlYL2?=
 =?us-ascii?Q?kEHNzQ6ZO7jFZnpzlMFJTzgB4n0XjMUPCZeESZv0Ix30WobsWw+44WAS67LR?=
 =?us-ascii?Q?TBMTgYxKneSagxkgYMiMmYHUwi0XhwBlVPWsSNz4INDn2oBf5h4yhxP4Pb/f?=
 =?us-ascii?Q?2bjxaeAh4AUTxApsjabF3Hjuyd9nyObfLzd2xcItH6Wjqj/wcSSJORWWVJ6j?=
 =?us-ascii?Q?ijeSoLkhuLqFM+d0cshL5mT2Zzv5+QNGTQOVHeu6KqKVqz9TImF9MG8sudWf?=
 =?us-ascii?Q?CccrQPwXlK3Ly7mdjZRT/VgPXfQrHUiNUDTUSqTkftYON2lEJWPMfdCw70tK?=
 =?us-ascii?Q?UMjDKrU+eIPV8oj2MqoijWNEnUTriZeyiFeyyCu2gH7k7gbN6whmzkGoPUvH?=
 =?us-ascii?Q?xrN4fxTPCHAhLbOKa03+YK6n+iqDyfKW8+mgaaJ4oH7XIufc+JpxDyQKcBY5?=
 =?us-ascii?Q?xw4WJW7Uq3rAKtTxcDBF6o/DREAwfnn8zrUBWxiF/OxQjTq9WE7YK6hyp70/?=
 =?us-ascii?Q?LGp8UFr35Wn6qJjvvysJ92+qC6pegQXFHWiOgHqqx6sXEFo9slzc+K2cHKH6?=
 =?us-ascii?Q?sSQ6Jj8mbo8ixmsPqhvOZDYoCW5aBpetX+KUGAgT+Od+RiHcQIWzIwEQXkS2?=
 =?us-ascii?Q?WZHimgrWuDvN8t7Mf0JayZzofVArEb5QKdkbPdSQfz8lYa5k9i3/zRuy4t17?=
 =?us-ascii?Q?ButL02ag8KCqRpYjAgHFDRardnwPaoIGg062SBbpmwy7dIod0nV8VgHR+YI2?=
 =?us-ascii?Q?Gng+4Cwpg69Msu5KAGBB9Qd2u+PPpTeqIXb5fXSE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec545325-8744-42d5-94b0-08dc58c68dda
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 18:54:58.7523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z6ZQVOWN7wr/LIRrXmvBLOZ4M0/uhAoih1siMEqpXcNcYTge1aw0ip/Y1PvsxVlj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8856

On Tue, Apr 09, 2024 at 11:38:59AM -0700, Alexander Duyck wrote:
> > > phenomenon where if we even brushed against block of upstream code
> > > that wasn't being well maintained we would be asked to fix it up and
> > > address existing issues before we could upstream any patches.
> >
> > Well, Intel has it's own karma problems in the kernel community. :(
> 
> Oh, I know. I resisted the urge to push out the driver as "idgaf:
> Internal Device Generated at Facebook" on April 1st instead of
> "fbnic"

That would have been hilarious!

> to poke fun at the presentation they did at Netdev 0x16 where they
> were trying to say all the vendors should be implementing "idpf" since
> they made it a standard.

Yes, I noticed this also. For all the worries I've heard lately about
lack of commonality/etc it seems like a major missed ecosystem
opportunity to have not invested in an industry standard. From what I
can see fbnic has no hope of being anything more than a one-off
generation for Meta. Too many silicon design micro-details are exposed
to the OS.

> It all depends on your definition of being extractive. I would assume
> a "consumer" that is running a large number of systems and is capable
> of providing sophisticated feedback on issues found within the kernel,
> in many cases providing fixes for said issues, or working with
> maintainers on resolution of said issues, is not extractive.

I don't know, as I said there is some grey scale.

IMHO it is not appropriate to make such decisions based on some
company wide metric. fbnic team alone should be judged and shouldn't
get a free ride based on the other good work Meta is doing. Otherwise
it turns into a thing where bigger/richer companies just get to do
whatever they want because they do the most "good" in aggregate.

Jason

