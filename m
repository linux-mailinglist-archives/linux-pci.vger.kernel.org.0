Return-Path: <linux-pci+bounces-8696-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2D1905F23
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 01:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B1AD2832F1
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 23:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDDD12CD88;
	Wed, 12 Jun 2024 23:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IJaHsKVZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811D712C522;
	Wed, 12 Jun 2024 23:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718234593; cv=fail; b=OYEfzofqOhS0tjXpb9D3kfqFTscyK68RvKR3iQtbBQ9/IiqU7pQD1bzWXF+tVV+I/VCfRvoNJtaIJdS1xYeyFioqFX1GHReGGTwcec679ZHqFcuiSubJ8hGeaS9uuCBdXeqS/C5qwl4H5UkaC4BcLFAi0Wh3+W/XHOuj0xlPIfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718234593; c=relaxed/simple;
	bh=7eEz6T0U86IZwiTuadwVBSSGKQ2BI5t33qMRtPmdIIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BnJmj7JR3evCxL+Eel+tmT3zVOa64J57Vg33yVnjarf2DFMW2JLqxITJdDo7boSwkWlcQZycooPZFoWSwHMo8oV7c0S0kKbXrz9mo+M2mtGQAbqPV7BKiLZOFgqs4M/PUM3iJRnjSj+Hb3NVub2kYbRU9M39gYP5ImZkX6XR5m4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IJaHsKVZ; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e59gj/KXrioaiUtll5s1JLcCr30d2x5vZcTSZZSPE8jXmjdJ3tTBiyYOsJsuFyk6pDrsjnSWPN1Ef0g1eqXFXdqF5DS97hO8Yo5FmGe7WLGBbglu+VGcASouVP9rbYYtUSW8UdLPg8saCntzAGBkJtKJMSyHsTm72Hn5G+QX0BOZjx7929ydfGdHZHu2oV5ID1aMtBxIf85skj22e58EZpWo35FbnKV/uBX8rfi8fwh3mrKVAUTvsK2OyJM/XRmJzQGZJPYYjTtKaxerEPREPxynzQfVHr0EXT6RbNlkqQm1OeT5Qf1QFj016S1orgO+daywpRHjNIN+hf4gKYPc9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oN2ehtxYr2eAagENRUhuFFGZA4RLAzQVtGMAJ0lm4s0=;
 b=i0ESiYZiwNtrdh7IPyTjSsCvqo4eLS6Uzic7gDZolbLClRoVcBKFkIPFblAGKmyHXq4T7M7Tvasg6x2Pat9CkmXK3k7Z+8k2dhuZNZiyjIi0lrsTuV/jvAUY2tnu6ogAslSXGK7OnfkTKcNbNWdJRxNw6Wwk/pQ2l3WbUUpHbyGlUYPRuZ1ux0vOFlcJ0R062PV5R+dNVUdrtO1lbASvJCGM7u7oCLrkvADGD4wDxigABm+4Em3RGTw+ghm1CdAC36QIPyP3zVvURJ+euH6Bd8bBOMWwoVg6EK8+0tHH3Fc5XHqrY+eC5Wfd7ESO6HlPN9N5wklcUxgFRX92IfwO/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oN2ehtxYr2eAagENRUhuFFGZA4RLAzQVtGMAJ0lm4s0=;
 b=IJaHsKVZkIVgDYyxeG+woTq3BM5kdB7RrGtRCIfybiBaLLgBqjhIhtTQvhytXrmiEiFM+l2vTBpeZvXjWZ1uSCVKtHmm5t5EMViDla3RzNAwYrYhioB6K0r4CD1hN0RpZEFhQcIvFe2WoW/ffG/Ag/ApD8I/RKRUi2YzOpo9ewkAC4xCUNyusYz1bFBs/HdwsB8s5PrfJfTBoGvwXwO7WL+tKARTXbg1Ky5ULYBtHmzqbnE7FZ+IXERekhKTdPreIkf08BPO27lRBnjLvRbDWxKvJGkdqpuB321aC8elm11ZegR1kONVOXhUfiR6/t5tmNIEZONVq92JQJjHpT5ATg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CY8PR12MB8313.namprd12.prod.outlook.com (2603:10b6:930:7d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Wed, 12 Jun
 2024 23:23:04 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.036; Wed, 12 Jun 2024
 23:23:04 +0000
Date: Wed, 12 Jun 2024 20:23:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Vidya Sagar <vidyas@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	Gal Shalom <galshalom@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Masoud Moshref Javadi <mmoshrefjava@nvidia.com>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Vikram Sethi <vsethi@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	Jiandi An <jan@nvidia.com>, Tushar Dave <tdave@nvidia.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Krishna Thota <kthota@nvidia.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	"sagar.tv@gmail.com" <sagar.tv@gmail.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH V3] PCI: Extend ACS configurability
Message-ID: <20240612232301.GB19897@nvidia.com>
References: <20240610113849.GO19897@nvidia.com>
 <20240612212903.GA1037897@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612212903.GA1037897@bhelgaas>
X-ClientProxiedBy: BL1PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:208:256::20) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CY8PR12MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c836eba-13a7-400b-3af1-08dc8b369c04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230034|376008|1800799018|366010|7416008;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EHnefYfFKyduUMzhaH7QKpuo8KrDekSXz/ilDJBQkz9/oVl8sjPDmJCG095Z?=
 =?us-ascii?Q?eep75RZvYCYrveimRsYQjTcVblgSTQTWbez4Kfyo6Jj4T43EXTodPFL/ZKg3?=
 =?us-ascii?Q?Vd2q6lmxT9Gu6aDWOrRGaocaV2rAaAqcuWhjwHSLQfo4KWL4Q40de2ZyF2br?=
 =?us-ascii?Q?JSl467a39p3g9i0V+NcgkjK4ky7Tfu9Wx+UIb/pm8v/NMre6N4xO98W1iT+8?=
 =?us-ascii?Q?zEYHM57w4GIltsb42gfMbMLHuTtpA5Os/ZwcZeOkv3danzPOisNlUeTX7oyT?=
 =?us-ascii?Q?LHBLxC53VjUE5gjdHpGG2GFsBNcr6ZOYY/12kNRUQnQxXNOVUq37PUl539F4?=
 =?us-ascii?Q?LrBtSvZQouLv3RQIjf9l8H5aRv1R20f0Oack81TT9a1T6dj58gY3z3G4Pi1q?=
 =?us-ascii?Q?RR5HSXp3VOqbVjZefcdx7UiCPvnRycNx+MT54TVUr2V3ikHnCAjJYtVY4Mwd?=
 =?us-ascii?Q?9y9mGi8MS31Qq39Q8EIAjrHcXCr9GTTFePnbnk0OUYQmUFnKReB8rC6ZeJjc?=
 =?us-ascii?Q?sp/0tY8WxVdJvfA5rP1AOXrDRL8Q1rXl8imm1qOB3yU7wdpBz2cjRBCSBKtm?=
 =?us-ascii?Q?SPbkkt16W6rNWCDbRMKcmYJ880de6i+cPL45BnhuIf1yGlDuzVrAP1vK9nY8?=
 =?us-ascii?Q?AEIlIYJrQshHNHBcM8yDGWnX6A1glKpdNZea+t2a4ru7aZyiV53NwVSkZiBH?=
 =?us-ascii?Q?HCZPOXheV2eJeC7EdalkC9M8KLi0tyMe6JQbNbq/+oV7sloMPoFsZjznlXSb?=
 =?us-ascii?Q?CES7f/mfaO5mkqIK8rT+/x5qDkNtN+5nTfpiEFV5UkcGGDb0tTwifEtGh8AI?=
 =?us-ascii?Q?8AzHlOh9cwSDYKF2JejhorW+5jJxrGXJ2duzO/rXM19tjAKOjiaFD6KJa9NY?=
 =?us-ascii?Q?/wqk6Aj6iVLL5WTBypdnf38uEDRXa8oGKP+t1zl/1DLHV9/sn56XXIgmY0RR?=
 =?us-ascii?Q?BUAXAeuA8PJowWr0bB5tg8q2g+tQ12BVFvmT0dGev9UlTxCNgr55sZs27b58?=
 =?us-ascii?Q?/G5CjYzOpSBa8aAohITWvozbDqXl6fq0j4eoyxLF3/DxpHMm3oiMO+JYMuOB?=
 =?us-ascii?Q?a3FN5cIi7bOCloHXRU6C5CUBg3pAWK4rTSKp2ONXelXKYzbbmAWuzUvsiiRJ?=
 =?us-ascii?Q?wLDgYg7+yelcZX7oRjEXRy2uM0XsIeahDCzkgQqcylVu/EUyidgctkpaI5Dz?=
 =?us-ascii?Q?h0mhVOilGteaxLQgTImhvvG1wCOtXRYs0FPqbUDcqaVKgVbKQq/imQOWDgCh?=
 =?us-ascii?Q?ieWvzGCNYY7o8+dpYUWVk+vrx1sr/ra1x2joMBTCK+frtpVLLLVIampXd3Uy?=
 =?us-ascii?Q?0J/STEQMQD3SS/YKUANM/EIJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010)(7416008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iKUHIjcSXgaChRnvZV3iCJTZn1VcxacknrxAtUV2YvUZzNNzEV9606vMCJYe?=
 =?us-ascii?Q?Km4aFsywVRe1ju9o6LRj4JB7aKouUOA102/tCH4S+ajJz+AZQAapmeFoGvlq?=
 =?us-ascii?Q?CilMaugtIgmYUGynUvfnTqkEvCoQIIv3jQuVL9XPXC8XDEZHg79t7unCiKAd?=
 =?us-ascii?Q?Sd4cY7un4x7vcT8yQCxtkA6u+1TupDCZ6+E3gFHRWy0F+G+PRDg5dW1kgAel?=
 =?us-ascii?Q?In321b8ieGJbSt6tJ0AKDp3uOdT2UEUQeFCLRYzh7c7kZY76DXPgmJroxLRg?=
 =?us-ascii?Q?G6Q6IK9vl1qIVJgnIsk1pZisbSw8edWoq9JEm7a4NJbOIBioh9PGi7bVZv5p?=
 =?us-ascii?Q?BxujxJ6WYZmfThtpN+qjEzK0nQLcKOTMcYYL2I1Pf5M794W+088dDDzV5Pa6?=
 =?us-ascii?Q?TI7QuajZOArMN1UnYAFq6aIKgFM3MXvLYfENJMTr5pNIr86d/KmMdwGKWhp5?=
 =?us-ascii?Q?V6xOn9ma9IWj8V1NKwMkA0FCnx+pjYugDqwNitTtkx67bNA5cw6NcH76g2Yq?=
 =?us-ascii?Q?scZEDCnpRrBD7ulU1P70Aic8e09ay+FX2d3kxp+pPnkmMMRZDnZCaYoUdh7j?=
 =?us-ascii?Q?QfThk0u9ZBq71fM2OAPLv1r8cl9gwl60/3S67Hxmkt0tL+HjZArxDoy6kvjX?=
 =?us-ascii?Q?2YVeGTRADI7yDOOYP9pQeUrVxfmCR8Y9zpVZ0t8H8/IO/Sb/XWnPARFzXsOL?=
 =?us-ascii?Q?SokJyeY2G8e7irq0qlaJ2sZp3vu+puaCSGwAerMWb2PJJ2leMb+m1MveeCsF?=
 =?us-ascii?Q?3A1PEMDJIJA5x4UaLGeVegpJt3CSmMiQN0P5kB7KYhU83Ptg2ajVARAP7YlE?=
 =?us-ascii?Q?8FYpSiOZS2vR4gwN+qbMR8RKilOgly9+k5Uil+NzWJ4cMBmti2ModvLg+kyf?=
 =?us-ascii?Q?kE6T70bcjx6updt2Z8iVtwYgTKmTfWamjEQFpwrqDMzPVFm06d02kHtKYO2+?=
 =?us-ascii?Q?fAYWJ3DlTfhZB2GmuwDW/3lvFXbmAYoHNYuQTJTFcJjSez74ZCBNiaGm/GG0?=
 =?us-ascii?Q?tIpLurKGE6BNc2CAq04Y+WzeMIEASeHTe/ydTVhBhNvXt4JbSzofequ/4BNu?=
 =?us-ascii?Q?E0R5LbhsB45LvMwQqY2iX1rsfB5oc62E8CB/eQxW3rYl9Jj6O4A3wkUvD2L0?=
 =?us-ascii?Q?zH40P4oQfWazkuw1eVXYwbQ4hL0CEdTihSAG2OYG2zrCg+vwNHAGrK9G0q21?=
 =?us-ascii?Q?cjOXfUIvv5E01qf4QYO+SNlQxWpiPb7tJmjGs6Bp5OieipZHxOjA5xLQaDUM?=
 =?us-ascii?Q?gSM/XAo+319Gu4sBlYgX4mKRKgj2Y7Fa/+SfZsj4CQSvHzhURSuhna+j1+9U?=
 =?us-ascii?Q?Lustq/rE1Cwg1wtnUpvmnqwKOqijOcCsAAqzwm1F5UD5+JApzWU+R83z1WIp?=
 =?us-ascii?Q?PdOUE6OxU2NEA9F9SyrjQ1ysBX4gC35s+9Gnmt6JdRXpALtRRovof66gETcx?=
 =?us-ascii?Q?I/NcvIDQauUmXgy7fFaD//xuzWNUI12G0f7ahszmnSPGZoFcAWYKOI6OlJ+M?=
 =?us-ascii?Q?/H8llbudoznJG4+Yk3P+y0kd8F1koxETy6HcZ/5ZNBAG6x45v4bVk4Nqw05F?=
 =?us-ascii?Q?s4l2glrqyzwuUPXpjHAu24efNjPNl+Q9nnCNmNf7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c836eba-13a7-400b-3af1-08dc8b369c04
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 23:23:04.4430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2bF2DwHetMovWSAgkOG3HMssaq88O42z5WBSWs0kCJAtmfZgWNf8qn69VDpkelzq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8313

On Wed, Jun 12, 2024 at 04:29:03PM -0500, Bjorn Helgaas wrote:
> [+cc Alex since VFIO entered the conversation; thread at
> https://lore.kernel.org/r/20240523063528.199908-1-vidyas@nvidia.com]
> 
> On Mon, Jun 10, 2024 at 08:38:49AM -0300, Jason Gunthorpe wrote:
> > On Fri, Jun 07, 2024 at 02:30:55PM -0500, Bjorn Helgaas wrote:
> > > "Correctly" is not quite the right word here; it's just a fact that
> > > the ACS settings determined at boot time result in certain IOMMU
> > > groups.  If the user desires different groups, it's not that something
> > > is "incorrect"; it's just that the user may have to accept less
> > > isolation to get the desired IOMMU groups.
> > 
> > That is not quite accurate.. There are HW configurations where ACS
> > needs to be a certain way for the HW to work with P2P at all. It isn't
> > just an optimization or the user accepts something, if they want P2P
> > at all they must get a ACS configuration appropriate for their system.
> 
> The current wording of "For iommu_groups to form correctly, the ACS
> settings in the PCIe fabric need to be setup early" suggests that the
> way we currently configure ACS is incorrect in general, regardless of
> P2PDMA.

Yes, I'd agree with this. We don't have enough information to
configurate it properly in the kernel in an automatic way. We don't
know if pairs of devices even have SW enablement to do P2P in the
kernel and we don't accurately know what issues the root complex
has. All of this information goes into choosing the right ACS bits.

> But my impression is that there's a trade-off between isolation and
> the ability to do P2PDMA, and users have different requirements, and
> the preference for less isolation/more P2PDMA is no more "correct"
> than a preference for more isolation/less P2PDMA.

Sure, that makes sense
 
> Maybe something like this:
> 
>   PCIe ACS settings determine how devices are put into iommu_groups.
>   The iommu_groups in turn determine which devices can be passed
>   through to VMs and whether P2PDMA between them is possible.  The
>   iommu_groups are built at enumeration-time and are currently static.

Not quite, the iommu_groups don't have alot to do with the P2P. Even
devices in the same kernel group can still have non working P2P.

Maybe:

 PCIe ACS settings control the level of isolation and the possible P2P
 paths between devices. With greater isolation the kernel will create
 smaller iommu_groups and with less isolation there is more HW that
 can achieve P2P transfers. From a virtualization perspective all
 devices in the same iommu_group must be assigned to the same VM as
 they lack security isolation.

 There is no way for the kernel to automatically know the correct
 ACS settings for any given system and workload. Existing command line
 options allow only for large scale change, disabling all
 isolation, but this is not sufficient for more complex cases.

 Add a kernel command-line option to directly control all the ACS bits
 for specific devices, which allows the operator to setup the right
 level of isolation to achieve the desired P2P configuration. The
 definition is future proof, when new ACS bits are added to the spec
 the open syntax can be extended.

 ACS needs to be setup early in the kernel boot as the ACS settings
 effect how iommu_groups are formed. iommu_group formation is a one
 time event during initial device discovery, changing ACS bits after
 kernel boot can result in an inaccurate view of the iommu_groups
 compared to the current isolation configuration.
 
 ACS applies to PCIe Downstream Ports and multi-function devices.
 The default ACS settings are strict and deny any direct traffic
 between two functions. This results in the smallest iommu_group the
 HW can support. Frequently these values result in slow or
 non-working P2PDMA.

 ACS offers a range of security choices controlling how traffic is
 allowed to go directly between two devices. Some popular choices:
   - Full prevention
   - Translated requests can be direct, with various options
   - Asymetric direct traffic, A can reach B but not the reverse
   - All traffic can be direct
 Along with some other less common ones for special topologies.

 The intention is that this option would be used with expert knowledge
 of the HW capability and workload to achieve the desired
 configuration.

Jason

