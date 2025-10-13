Return-Path: <linux-pci+bounces-37938-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F32DEBD5B24
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 20:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BE0518A7376
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 18:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E64D2D46A2;
	Mon, 13 Oct 2025 18:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tvMXstnU"
X-Original-To: linux-pci@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010012.outbound.protection.outlook.com [52.101.85.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9A42D4B6D;
	Mon, 13 Oct 2025 18:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379950; cv=fail; b=kb16VEp0zIt+N9Ta1EEteCLSqMzWlePVbigwkI02LNEu1m8KU7htLCNIf54TEMfKxrMEUodBox+gfT9MeTWnh6wKbeTz5z2jmW30Fk4TdBabwMS9coid6lSXSY1A1lkgsSMnMOsDRTYRLM6QycZTvUZVvtQ8i3ggph05XgvSDk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379950; c=relaxed/simple;
	bh=qFDyzMePWjTwadprEf9bg5ZEqPSMA5H/es2tHXv+EDk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NdnxE2W/DmmF3GuX+g5E/RcwkgWAM4k2/d8kzf5PVP0RScVnPo4Bpr4iGgFsvwDjWE6I5KHwcL8GXN1pTOzJm1CAVr8+TW31L5faxxI4JRUYLYi1tk5JVzjNOZsObV0GForI8e6dWa+5ZGqaGqZ4lurcc3ySHOjWKbca+EDNgeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tvMXstnU; arc=fail smtp.client-ip=52.101.85.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uGtZsjCwuWnyoHkniyodCq69x4rS42HNglwHcVYwhtfNekZGgEMT2rU1Ei3ivnDo5w36fzMApt0P+V7kizpQOHUwtIvK2bfe3WIA4f1xvyA+NvENdKgst33bUBP1juIzmnF6jyUprbe8oG2FosmZMLLDEi4LKodR1rCpG87U/62J23LCoYSOig2ihYidJtpt2kMaO7LTOW2dZFz0d1reGKxPUhDh1XOPto83GlA/4SI5bZ4h26czn+irLYpNmJ51nN82bMXHl3Gw9cSYU3Gn/msm9hMiGtsbs6fGtgPUHMoFFg9s5cYvJ1zBlgFYcE6lfyoLwi/OxjChDba3c5m4OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/7y1yLOCXob2ZHuDkHM2q2kQPkRRspDSJ/TF/N5e3Q=;
 b=hRGl7zxDFjCs9BV0A50ti1Y1pkXdfGMnhAtS9aTx+D6/K00JfGSf6bt7zpTgsYnv4tiMrhF5xnMI1x/JN5X/KzMMuiflIf6Y/Cx+QdvLMaN9SJ32l1m1qkUr9h+TVNmr0x/CRJYH7mk8mG8PoKHTscW6nVy05xQuDFAo1VRtPjxZSZcR4cdZ/w6p/NwwTJX20Lq6wlmTiYNKaEe8Ycga57DhrJQKKvb0AuR5vtygsenrBeQhA96xZLZ9T83Ly9cYU7wwH8tXew5E9HiA8kz2syDTzEBs2nig/q/lP2sfThZeoVy0wOIsR54JYvRNmWrugP+LNn0Ogg+Deilnbrgfeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/7y1yLOCXob2ZHuDkHM2q2kQPkRRspDSJ/TF/N5e3Q=;
 b=tvMXstnU4Czl8FnlEWG4e7aUo3F/X17PTPtC9pkdhpHavMUScylWC5EjKPu6Kn7PlDDplCAXraUdfHMa75vSJUy4UP5Key94lf+uFLlLQXJFnRRU8j8yILEtwKKdNeKJ7ZlPDXfpoLk8mnjJ/VMYCztNnY8ip+wxrewPgXM9OL8byAvEKbN4XvSFd/WDNO5R2kkqqQW3sReuwooG3aUYj8MEfzTK3Kw8AOjb7SHrih9CmKg1BxhNqSky56jYRVUTGYThl0UkS3N+hDIlG1z6IsdMFIdgpwIuuwV/xXzxQdDU+b5WbhkbKfGb6bgCxj9Ivgn+c7YYknuuhqi4eU+bDQ==
Received: from BN0PR04CA0140.namprd04.prod.outlook.com (2603:10b6:408:ed::25)
 by BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 18:25:42 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:408:ed:cafe::24) by BN0PR04CA0140.outlook.office365.com
 (2603:10b6:408:ed::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 18:25:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.0 via Frontend Transport; Mon, 13 Oct 2025 18:25:41 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 13 Oct
 2025 11:25:25 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 13 Oct 2025 11:25:25 -0700
Received: from inno-thin-client (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 13 Oct 2025 11:25:19 -0700
Date: Mon, 13 Oct 2025 21:25:18 +0300
From: Zhi Wang <zhiw@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: <rust-for-linux@vger.kernel.org>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
	<tmgross@umich.edu>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
	<ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
	<targupta@nvidia.com>, <zhiwang@kernel.org>, <acourbot@nvidia.com>,
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <markus.probst@posteo.de>
Subject: Re: [RFC 0/6] rust: pci: add config space read/write support
Message-ID: <20251013212518.555a19ad.zhiw@nvidia.com>
In-Reply-To: <DDHB2T3G9BUA.18YWV70J82Z01@kernel.org>
References: <20251010080330.183559-1-zhiw@nvidia.com>
	<DDHB2T3G9BUA.18YWV70J82Z01@kernel.org>
Organization: NVIDIA
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|BY5PR12MB4322:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ace9911-0dff-4b83-d67d-08de0a85eae3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O/Vfn5VLgCbwR2QytBH5pumI3R+T0a8Zfe/D3YednzUFCSUlm40UbT9KocG0?=
 =?us-ascii?Q?annMM3TEVBvI0ItdSXP45u0v6GMrPMoy1Afa/9rQASiZ5QSqAiA5Rbdl4Baq?=
 =?us-ascii?Q?pB2N02wLYuQhSGMcoaNB2ZpoJtJlB8Dd6b1UbomWHiYB+sSn3XdfzcNAern0?=
 =?us-ascii?Q?A8QYlv1JZAkVow0A3RFLHH2AOptyt8gjrZuU6/Go8BYxP0jNIuHIBUd4EQJh?=
 =?us-ascii?Q?E0XqbvUQuEMKIHSDasehdLLQfQEN8HsmvhN+ZzbDTpRHMALbf/JXYc8Krugn?=
 =?us-ascii?Q?nU1inz5Vakli8SsGhP0Sma/8CBrCTwIY0JYFSRPEGLmftiEOQ3QXMbIrhDAg?=
 =?us-ascii?Q?K5zNFpZ0qhnojE6xPgR+j1YQYp6X5Jtf0c1VtncPTHzJK7MDMqKLKSsE7yXm?=
 =?us-ascii?Q?o09jLYdkRM/K36Xd7TnBE7fgbbx15nfxUvk7SIxhHiTvZ4HPMVBcsV2PG/iM?=
 =?us-ascii?Q?1hU8VjOX4yxTMGkNt7mlai00RuAcgvC4A4wts0WLDcyivLsuPRLUzFDoWL//?=
 =?us-ascii?Q?d4U6jRIk9KwpmEmC+EcJNHyzMr1+s5mC1ofp8rzOEY+QZA0dP/Z7Uus3hXLT?=
 =?us-ascii?Q?73jaDLZrgVI4s+KFiBwo9ECqpIxIvJ8WP1sr1si0p8HSSrRQ1cf9QZQfD6Q+?=
 =?us-ascii?Q?QyWtYdj4WdVnqY84UNmtz3WsAjWgqHZKkc8Oo6YTyRMn++j/+OCsg5ZcvK/K?=
 =?us-ascii?Q?7oa6QtYxRLfk04hFqNwgGSBJodIt0Zy70j74QdqBgr/4XXqNQptTmAsaDnk1?=
 =?us-ascii?Q?q3gDDJL9HZrtggZuPeVjiVHV1YnlPhPDlGd36u5VVGNUSvSOtKWFkskxI+AC?=
 =?us-ascii?Q?6nsBApOd//Dy7DNMC/z7K736qJK4/nUxkLPWvhDO9RPT2abbOyKA/paNtX4/?=
 =?us-ascii?Q?hR+MQq+UKcH8OteCnvQA9nRsIIpxQEDmSAjGpWlW60NaIliS37GnrPzsYTa5?=
 =?us-ascii?Q?vYZf1XuImrOOPUnvsKgyGth602hxwNJ9veSzlWzb8RglgROfbaklijo4qb6Y?=
 =?us-ascii?Q?Cc1ABGVZLLIiDK3t6hulV17qA5eF7q1r8EHjHnxnWnVHGMQU/IN0S9/siYCE?=
 =?us-ascii?Q?Kb++7v64b5F7LUV2mmJoaSQPgBRJ50mVKSAikEs9IzAS/r+paFwCOZq2FvDt?=
 =?us-ascii?Q?w2y4O+NEVo+x6lqYxWSkBXiYr7/Am0XY3ugk57m8jjTDcTT6rMEr75tt6Mkc?=
 =?us-ascii?Q?UOh6uVI2mPIA0K0Us7MUw0eSU2GWiW/MHovn9CI+Aw10g2Fd3ODKefv9+aDo?=
 =?us-ascii?Q?NOXLQj+lHiitf2sc4U4CJRXOgRaD+V/8WGCIx4JFRHrOR4xN17ajfRcQpWiA?=
 =?us-ascii?Q?zIQUtwv4x3PATnZAoF2t8wCmBphaqcAlwGr3psft3oUOScdacsKe4NY7+aI1?=
 =?us-ascii?Q?ATT0loZurxsuT9crlHi8snpIJIoLAgNVUoBBzOjKGeIRFuGPlwqjQ0f12WOl?=
 =?us-ascii?Q?i2X82WMbRwtJfDPgVKBUoD+tQsUe+Vufw5zNWvAuc4xTEJICj3WELajVJRM3?=
 =?us-ascii?Q?3UhPfCYxFCWC8lwsuDDf/IpsK+XwCLFDW/UQuFxhBFd7fgsi+/FxTNWP3mKQ?=
 =?us-ascii?Q?ofYSf9Juvz2x3LqJKdI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 18:25:41.9250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ace9911-0dff-4b83-d67d-08de0a85eae3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4322

On Mon, 13 Oct 2025 17:39:41 +0200
"Danilo Krummrich" <dakr@kernel.org> wrote:

> Hi Zhi,
> 
> (Cc: Alex, Joel, John, Markus)
> 
> On Fri Oct 10, 2025 at 10:03 AM CEST, Zhi Wang wrote:
> > This ideas of this series are:
> >
> > - Factor out a common trait IoRegion for other accessors to share
> > the same compiling/runtime check like before.  
> 
> Yes, this is something we want to have in general:
> 
> Currently, we have a single I/O backend (struct Io) which is used for
> generic MMIO. However, we should make Io a trait instead and require
> a new MMIO type to implement the trait, where the trait methods would
> remain to be {try_}{read,write}{8,16,..}().
> 

I was considering the same when writing this series. The concern is
mostly about having to change the drivers' MMIO code to adapt to the
re-factor.

IMHO, if we are seeing the necessity of this re-factor, we should do it
before it got more usage. This could be the part 1 of the next spin.

and adding pci::Device<Bound>::config_space() could be part 2 and
register! marco could be part 3.

ditto

> 
> > The current kernel::Io MMIO read/write doesn't return a failure,
> > because {read, write}{b, w, l}() are always successful. This is not
> > true in pci_{read, write}_config{byte, word, dword}() because a PCI
> > device can be disconnected from the bus. Thus a failure is
> > returned.  
> 
> This is in fact also true for the PCI configuration space. The PCI
> configuration space has a minimum size that is known at compile time.
> All registers within this minimum size can be access in an infallible
> way with the non try_*() methods.
> 
> The main idea behind the fallible and infallible accessors is that
> you can assert a minimum expected size of an I/O backend (e.g. a PCI
> bar). I.e. drivers know their minimum requirements of the size of the
> I/O region. If the I/O backend can fulfill the request we can be sure
> about the minimum size and hence accesses with offsets that are known
> at compile time can be infallible (because we know the minimum
> accepted size of the I/O backend at compile time as well).
> 

For PCI configuration space. Standard configuration space should be
readable and to access the extended configuration space, the MCFG
should be enabled beforehand and the enabling is system-wide.

I think the size of standard configuration space falls in "falliable
accessors", and the extended configuration space falls in "infalliable"
parts

But for the "infallible" part in PCI configuration space, the device
can be disconnected from the PCI bus. E.g. unresponsive device. In that
case, the current PCI core will mark the device as "disconnected" before
they causes more problems and any access to the configuration space
will fail with an error code. This can also happen on access to
"infalliable" part.

How should we handle this case in "infallible" accessors of PCI
configuration space? Returning Result<> seems doesn't fit the concept
of "infallible", but causing a rust panic seems overkill...

Z.

