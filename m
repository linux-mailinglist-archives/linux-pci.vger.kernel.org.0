Return-Path: <linux-pci+bounces-28717-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B06AC8F95
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 15:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52BA2167B0D
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 13:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAB4EACD;
	Fri, 30 May 2025 13:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fgnjMsIz"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C3323315E
	for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748610659; cv=fail; b=uqs89VOUSqJkRqg0WnUt0YzQ+hVDGfVySJfHc/S3FwYqvp99Ukwwfg2fTkdJnl46YNB8NxC4IABbXtBqQBMXd0gWdgtsSzGbesg2lqoKvRybH925mbpPo2asHw3qefnNElQ7O0BvBfkHyg5piDUHYA+PuPUybHVuHkY/pbbKCMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748610659; c=relaxed/simple;
	bh=6vh7zAij/cDr4HygCS+7NUKqpa/72AN0GhW6tPLqOjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A5xutfEQqXjIdAE2sIpHpQRfke+LOZyrZLeHgCsAtPyuuTxgwIUSzc9o/OuIbd16j4jl0UfXxjMO/PxEVr+3dUu4kaXHw0CpyAgSDHS9+RJqYpr/R2DZSYb0SrhEpLtJcAYkkNwkz3EO5gkK81h8UWWyFihkzo/nB7CtLhQm3Rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fgnjMsIz; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L02ibVfRaoQ7CjXVPoXr3KlSlK31hu2BgZPo2VRaWyqIBv237qN8RxCJ0V40FWzf3Nck60C3W6A64WDsdArxP/Uttpb5ocUcreILbf+7VnubJDt03BdHX6laAgTcqllmDQIFyieTIvgEUD2lZJnrfACmL6TTkPf6bigyUWKoI+k8qPWSyVKQGHoa+aJYG1lOrUCJnTfNDT5OoBgvqpNEzOh7naIvIgJQqh75ZZlBuhHHcNqNUHBRu50wXWigepUfjrHhki/jeki1PCiok3c07SW7xdetq9NWq8KippP/A4CfWm12sOIfXJzt9FvGjJJmpcoXD+oVzxrIprx6/sHvRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzGs4aaLxqC1ydHFvcXicp/xx38zSPgOwvpeldQUOIo=;
 b=kjYJp2ec/+a1kIMWItOzdhd/aKhE5LJnjmXxz3bU5BadtGOi1Fix1NPRxgQ018bsJzpb+k0tikolXr5Yi0doICOTpdQ+E7AvFbEFgSf5DMHI6BTV0LWho+KWZgb/klTRLxxtBKPm6wskxVe0p+QOFw4rpFg1f0ZexF+p5uX0OfQlRlkNAHiqGz+Hrk4aoD+dxw4GpnrZH5WawrWGtxCs+f7XMpBIf9QFGpBV8jF8aXN6mgIs5e/1a0uL80u79uDHjlkgV0EdoYop1PtPxVgZ77pYARWPN1ebnB2YpYIuDJMjc2B1iHevkA/ZxDy6mOVg0gFlZYLkRNDZMGcWtEREMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzGs4aaLxqC1ydHFvcXicp/xx38zSPgOwvpeldQUOIo=;
 b=fgnjMsIzFFK8LTocThgNfS/++v68zmlt1JrJXta9++SYKYZQ28d3RaHKKOsUwLw0KystnGr4HLv3gRQKpLdvwbqsgJRC4nmLpFmyMCjM5AWnW3DA0lLYlOXeo3Kg564/A9bF/DUr4pcwzo7e6Y+6J75yDvn0aFfh8JAyfxH/lsd257J00LxR7ouIwyZIb4dMnz0AtTde5JUyFGhQK1VAvLH+q3N5erwBHk0Y2VmzPkCEcGqIeq+vREQoNPrEHLxP8pkkqZZxzfGZ7GFC84wONWIBAdg+owIa8koaMZfJdqs+QUgCien9KGGgvuf+xk4EIcnb4x1rFvFchtnG49tQ0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB7337.namprd12.prod.outlook.com (2603:10b6:930:53::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Fri, 30 May
 2025 13:10:51 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8769.029; Fri, 30 May 2025
 13:10:51 +0000
Date: Fri, 30 May 2025 10:10:50 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Mastro <amastro@fb.com>
Cc: linux-pci@vger.kernel.org, alex.williamson@redhat.com,
	peterx@redhat.com, kbusch@kernel.org, linux-mm@kvack.org
Subject: Re: [BUG?] vfio/pci: VA alignment sensitivity of VFIO_IOMMU_MAP_DMA
 which target MMIO
Message-ID: <20250530131050.GA233377@nvidia.com>
References: <20250529214414.1508155-1-amastro@fb.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529214414.1508155-1-amastro@fb.com>
X-ClientProxiedBy: BL1P223CA0033.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:5b6::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a5ff844-602e-463f-26c5-08dd9f7b6701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CD8FGw59Mu81d9rAq5YyKn6YJRyO3k9gXmXQ0Yoz/Zma3ncrDP3LYvNrh+c5?=
 =?us-ascii?Q?cO1YKOXHsoaWqjN2qLSOpoaN6k4JkvneTtf0HGXtKUyvJB1NBPyLOZImJd8q?=
 =?us-ascii?Q?ia7ta7ICAelzMmABgxwilawOUp3UjrlzznFOTiIef8dBTJqmgIBcRh7uv00t?=
 =?us-ascii?Q?9pAcHkuT5SM+r9HC0osQx9n7b1/EPJN9NVL9WObQxjcI6HwVx3qi9DOtE4u7?=
 =?us-ascii?Q?g32ftoAa47MQPLXTr+nfUDFd9nF9X9kZ4p5bWfE73LL+wgQR/Kw3b0httvFl?=
 =?us-ascii?Q?LrB7BXNGDEYaI2SL2oMA2iT+9x42bYo7e+6U223nBu6AhhLKXlkKGsxGzFQl?=
 =?us-ascii?Q?AvTsb/sH5VGLEVX2lVnGxSxZJHiaSn0Nc1S/dIH3Mwfq0+xqvL6FlqK1Pxp9?=
 =?us-ascii?Q?Ue6MfsnsPDGI/bdrzwE6oFGVIOj0Mn0Za/fdvmuiQ8GtbCaV+/Lcqc77kaWs?=
 =?us-ascii?Q?+QNBF8JAvpLMmvtUSzFAm1snPsxpv7AHk6ccp/yWZ78jtJ++429hVk4u+809?=
 =?us-ascii?Q?SdA8Mk/zmOX7A4C3p4iTOA0qzOBUBZbS51U1PjdqUKAOr3l48cNbBUgom1or?=
 =?us-ascii?Q?KHdfJnwEAjkFcJwGIxdvdx65RRbZMlJltB8i49n9vhwFxT7oju1Txm770E/u?=
 =?us-ascii?Q?JKpAyAsVnIZNRCAwCDc37++JdclQtcOYJhFkWh21DV1FZwYFTJEyciYL0YVK?=
 =?us-ascii?Q?ytowrCma/tryBPYS51kqKelkQnN/0xUDnLExaTgBZVbsGEnkeXAMX5h02fe9?=
 =?us-ascii?Q?2OzDYmyGIKNBvHdiL3wbXP+N/32ZAx8gSgX7Dlvu/4UiZZrdjC37nJhc5oaU?=
 =?us-ascii?Q?aKDM7YBgUKw/iTqy6I1wGzGph3g8f6D3Ay1BEBMLkoJE63r2z/RjViCoZsBK?=
 =?us-ascii?Q?q6twb4qMXjPTOwwYfTialByKWCHl1M1vHpKG/v8vaZSsj28eW+dVHE/OSsmi?=
 =?us-ascii?Q?qGzudGsF+Q9Xut7Bn0IvaFVrHW4QsTPAYGbDaUU/UUExH5kesfywkV3NHyam?=
 =?us-ascii?Q?p9qUmM/ZW6lB3jPkXyGCx98SbS+4ziJ7xiOmMZ2ZbXeRUdXovL7/RpRvzfuG?=
 =?us-ascii?Q?u1TPbra+xnGKw5jMAMoyk1RmkhKhjM4Rq5dNPQeHkjaW5MDl3eLLVaV5VJS3?=
 =?us-ascii?Q?hq3Pm4VxhWGoqb9h40zi1rxZcJCfiJx5fbVMLU/zHPe6SYABwBhLHHoFdUjS?=
 =?us-ascii?Q?tILON8a51zkY12DWtzuxrjQgQDyRr6Y5Erzc9f5ybBpZ9hUr2xahnV+n0nv8?=
 =?us-ascii?Q?jB8GyfjwF8BhcsCqpk2+LsQVNbQPzi9mwtkwxnijCP3wT2z38OPnqubXQa0O?=
 =?us-ascii?Q?UiNwvuJSptEpGPSxZnycvGjbfvUYaU3kfZAvx5S6hZ3xRNfAuD7KCTY2PfQq?=
 =?us-ascii?Q?rnR7t//zSXxQ1CnXgiwtQWLKvp6VwtN2jXtDcEnQRDtAk8XPJG34xqxIxOUT?=
 =?us-ascii?Q?l4jQi58lPuo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sfeDfIObpC4Hon/W2F0FSQvhEKdK0+Vz7nFXBzFURf98Of/lB4zF6VrnVxnu?=
 =?us-ascii?Q?GzltJD+7vSx3uT4tryq4nhM1SfKW9B5ZjOZWjrp8U+MpMxxESQB/tE/jXETL?=
 =?us-ascii?Q?PhZIWhDb3ISDRIXp2zhw7JxNBzPAiAaJ3Z6LCSGcgsfR9DNVI/GZ9dqroMy4?=
 =?us-ascii?Q?PfsZ2qOMvyCraCEzczYpu2Pm5tYEBjoZdNTf6cOOHW8CaVGBI2Hqf1HZW7az?=
 =?us-ascii?Q?xuIpz4s47iZTdkuVitAZ+NqPh1BjlXRbnD6sCGJWvwdRQvHEwDqR2+s2WIP6?=
 =?us-ascii?Q?DVcSsCz5VcliyOTeMQ6oMMUZno0+jllNdWwVKq0hWZ1LSEi/uOq7ikX0Wzmg?=
 =?us-ascii?Q?HF+j3tl/mhgzFEiWRy9jIR191P29XmUTTafdxoCjFV7dZDo9x1GYC3GJ1nRQ?=
 =?us-ascii?Q?TZ9n3ylsvOUtcXmTtuOtoBv7IVCr7hKkGtEigSCqPN0nFv5lPQSIqw0o9GVR?=
 =?us-ascii?Q?5fTYaDeUlWeS8yjuBan0gR/Qdo+IRG0NKqg5gLGTFpISEJdmu13qCL0Ge8iu?=
 =?us-ascii?Q?ikKYP5N4AzX51bXomKYt/cZfZbP5XHwwN/CbtP2J+yquROWMF42vz2ygSadU?=
 =?us-ascii?Q?EgUX1FPdUYQlcvMoYJos6nGl3KiE1XKMOfZjkxYnIwaKgW6XOuwalxu0/LpH?=
 =?us-ascii?Q?BpILmiOKpd7r/iY0ocHTXiP4Nh2kBXKDyFiKhsbBhfZ2iYnazYRLVIa80YDz?=
 =?us-ascii?Q?G2IiMHG5okZ0i0c6VVTRbs5TEJtEcufExeVQFiZJXh9vq4K40jYvkAZmK9SQ?=
 =?us-ascii?Q?SZUfxsDbUrzy39nsX5n1XELQafodk5jPtNLX2+mAb5FyYzsiTNfE3hN6Xkw6?=
 =?us-ascii?Q?4Q5z95U6HkpZqJa+teTVtwsCQn6p1IXvZkjWauLrWqEmX+gPokQFLdmx+cyT?=
 =?us-ascii?Q?CwrtfzWEDmBQ4FTUGh/klPZXMeqH8vO7PHADhY4BecGiRQCZ5sgNDDNQcLRZ?=
 =?us-ascii?Q?8OJnJNu1VBZEjsATSobr4xx8zoYj2CMWiBLvKj5i8tT5bxay5KdVPwhvAzCB?=
 =?us-ascii?Q?yBlCtUC3J6Ru5skks45n6AxzHpARoXfqw/oBIb4liM2h16uBe5k21bFoVKGv?=
 =?us-ascii?Q?cdHZwe5hYfFlCJ6JtYqZAqc1WVzTgzTAf0r/mHnW8D9Ml/Fptuz6+xS1OhbB?=
 =?us-ascii?Q?TIPoSM4z6RTXVywsz4pOQM8kOOZKu8zO4X+EofiNPNihN+5gYxFd8kYEVSqN?=
 =?us-ascii?Q?Dld+Df6Y5U/6ek+fCX6WKqQ/vyl7PCePcjN3gxd1fVu2kvuwvvFS4zRiQxwf?=
 =?us-ascii?Q?bric1yXy0+o7w4u5dS8Lepmt2/n8NEMvXwIigvUDmB3hx6upA4sujBwMcaiz?=
 =?us-ascii?Q?bYJP7+rO8y0/l1qQS51AlfutFTAPO0smc/5roY6VoA/uPJQqe5FrtvfhhlrN?=
 =?us-ascii?Q?i8vNzOc+uq5JrKuuHpsADsAhdl6t6vd/gcMsvbrE1M5Jp8BZyiqymOktYtF9?=
 =?us-ascii?Q?KL8dJlLaLzKTAoxOZQhr2GVBIZPqSOLaJAbYzG0/cX4rh4IoMMZlKnkTtUv5?=
 =?us-ascii?Q?zZ2XlWh3KwXMf6iPxn2/FtfeZqPDc2HliBm/xTqrmP34uGAF9RhUnAkqKVAf?=
 =?us-ascii?Q?jj4aAJ9bKrDqTCykTJZipjjgFro+K5B1Hsz/vu4R?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5ff844-602e-463f-26c5-08dd9f7b6701
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 13:10:51.6334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVcqRiL0xFVSzwr+XGapqymolVOvt1tn1/PHYPkNnf255O4ADWFWjukgoIlWf6yj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7337

On Thu, May 29, 2025 at 02:44:14PM -0700, Alex Mastro wrote:

> We are wondering the following:
> - Is all of the above expected behavior, and usage of VFIO?
> - Is there an expected minimum alignment greater than 4K (our system page size)
>   for non-MAP_FIXED mmap on a VFIO device fd?
> - Was there an unintended regression to our use-case in between 6.9 and 6.13?

I think this is something we have missed. VFIO should automatically
align the VMA's address if not MAP_FIXED, otherwise it can't use the
efficient huge page sizes anymore. qemu uses MAP_FIXED so we've left
out the non-qemu users from this performance optimization.

To fix it, the flow from the mm side is something like what
shmem_get_unmapped_area() does. VFIO would probably want to align all
BAR's to their size.

Which seems to me probably wants some refactoring and a core helper
'mm_get_aligned_unmapped_area()'..

I think if you are mmaping a huge huge BAR it is not surprising that
it will take a huge amount of time to write out all of the 4K
PTEs. The stalls on old kernels should probably be addressed by having
cond_resched() inside the remap_pfnmap().

Jason

