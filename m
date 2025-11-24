Return-Path: <linux-pci+bounces-41944-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DFDC80C7E
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 14:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 661D73A57D9
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 13:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A851F3054F2;
	Mon, 24 Nov 2025 13:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="elcZuPjZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013000.outbound.protection.outlook.com [40.93.196.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BD1B652;
	Mon, 24 Nov 2025 13:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763991173; cv=fail; b=HXgXqe++hNASAoBJIXcMyJ93oohxaAIPJHPrVezQmt1s7KseMJWtnU9araHpksMXQpdy1EZ4Y0jtuVJEd/kvsW1uoi+5rc/f9kDqwOSRShsKWd4zXs+1E1vRihNTrutuz3U65it/6tBwLRkjRfsp3qRgWZ5CMpfSWOJUD2/lMBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763991173; c=relaxed/simple;
	bh=tvpwMonYietbT33sgo787LLTV8kPN6ov6wqWLAo+56M=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f4Bs0yKGBQu+cDD+nh3q1dhC/FwXSlptGWRs4QpZjoCfjaRfSoQSCEPy2S/yzjuzr7VTZVD5h6AeQVzSo6K58wF2b0nY4fy9QspKxMXrdHOkZC7I6gDhK1iymRsN9o0azMGbwZigREbzTjXwpgAbjr2VkvHN+2YTv6wtsmjTp98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=elcZuPjZ; arc=fail smtp.client-ip=40.93.196.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dbm2DXygH4q2GdJBu2LXZVQMYX/4gvuEmbUWV/KbPiHA8jb3mrf0i5eVOPOoZvJ4fRn5cr5/jHLThB9ha80kIBFEKid8Gox9n0HEj7xZ/rgFuwXw5RsPyALyvqPvjoII6q06q0dp6wm7+XMXiU3auiYjgxJXd6C/5v5bbteodyLBEYdU5dz5uyJXQ+1O/EY3fQayCSDS+qs4rnSaeuoneUnUtpTcy1q42qXRJXLTXzgrbquj07BnRz35EtYJRmIi4erA6iHHgy0kQfAt4o9IHmT4VMljTiakA+GAvsQUGfAim+500k9dsHAU5DvhnWMLZvUeIhdWLu2eRSU7Ux03+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfrs+xYKSBIm0aUuIWZdBvO+O/psjuW9ZReKSmq6oJU=;
 b=N63DJ9unmZIUqBT6CpPhTv2zgT6U2z5lBcHcMb3Eg44Pb5S4FmiwuNOqJvYUtpxYSB0S8PPDVfOk9SDJIreGIzFvzVlwL0kyJ1/hoPCcHnDnjHCUhcY/SlTvJOKUG+UITaPIMf+dpIrsnpv63pXyqqrZ9QwDlkEOCsGIwiRTp5fMjShQ9TX3K+DOJ3I5x7LqZp9BeFjbx4RMT7sClhmI15m5dJgmE2fL18e0q2pIHJpdb9oJ0udrA+3gzlE3K9k533mhTuu5NKfpp/Jxd1XBk6FHvcU3pa9yjPGMbWy61GR6UjVBP8Iag9n+kic24xf3Oqz4oQcxKoc0RULXldQDhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfrs+xYKSBIm0aUuIWZdBvO+O/psjuW9ZReKSmq6oJU=;
 b=elcZuPjZryJYWUlH+kQhIcWzFpYgShZo7o8dmuLGi4utr9Z0E084mXfAIHCXe3YsbtfMUG4i9fMZYH49DtL9sHxC9JQQBJIU3bC1Dlc6oyN6YzxMxLeO44qvFpAMquCH810+V+QwxnoM7Xs0o0OR/wf22E6jTOr00mDKB9rOS/ahl4Z34q23OXI5XLYlFRWb994mKihS0Ht7qKFmKVwBzxfJD5dQiw7rvbwEymNEKH4wh8O2NpXQ1h/vD9Uw5mrC3Xat3GhsU0ZCnAWQx5uwZhn8/wWoYQgx0h2sclHzCG1WFcSDD22vq5NuCxQzQ+e03dEdN2IBXP2kX4sKwievqw==
Received: from SJ0PR03CA0174.namprd03.prod.outlook.com (2603:10b6:a03:338::29)
 by BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 13:32:45 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:a03:338:cafe::95) by SJ0PR03CA0174.outlook.office365.com
 (2603:10b6:a03:338::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 13:32:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.0 via Frontend Transport; Mon, 24 Nov 2025 13:32:44 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 05:32:26 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 24 Nov 2025 05:32:26 -0800
Received: from inno-thin-client (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 24 Nov 2025 05:32:19 -0800
Date: Mon, 24 Nov 2025 15:32:18 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Alice Ryhl <aliceryhl@google.com>
CC: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
	<markus.probst@posteo.de>, <helgaas@kernel.org>, <cjia@nvidia.com>,
	<smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>, <acourbot@nvidia.com>,
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>
Subject: Re: [PATCH v7 3/6] rust: io: factor common I/O helpers into Io
 trait
Message-ID: <20251124153218.7694b78a.zhiw@nvidia.com>
In-Reply-To: <aSQxeSX0q4Z_jaAu@google.com>
References: <20251119112117.116979-1-zhiw@nvidia.com>
	<20251119112117.116979-4-zhiw@nvidia.com>
	<aSB1Hcqr6W7EEjjK@google.com>
	<20251124120846.267078e5.zhiw@nvidia.com>
	<aSQxeSX0q4Z_jaAu@google.com>
Organization: NVIDIA
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.33; x86_64-pc-linux-gnu)
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|BL1PR12MB5732:EE_
X-MS-Office365-Filtering-Correlation-Id: 4710a83f-7271-46eb-ce7c-08de2b5df35c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3QpPkMagsxxjrXfnZcn+f7NSwMV3bsya6frTU0iIUdJ6AExdJ/LmKkbwcpbT?=
 =?us-ascii?Q?lfSTRBt7jl/LDdS9NTCFiJu+6vMWYQpGOJu8HUShCT8RcVYMfN8kJ4kcwhx/?=
 =?us-ascii?Q?2PSwLUhDhcSbFhUtYmHsi68VBMVLyJdrdkA2Ya6fQPWmUu3EvwQ6JCUIxSWX?=
 =?us-ascii?Q?jMpUOx9Y419WkEXLPUXXVKACuaLyy2YjKzXrCF6bJXERW7y0Dr7cRDOUWPQM?=
 =?us-ascii?Q?qoZXt3yHlHivzNwiYQJWnWtg0tAlM0mZjZpYCiCLH9T7aGTJjiyRvSfNO0/+?=
 =?us-ascii?Q?2xyRtFsmr/LEaXXUbX31v71MJxjRiHptZarmf90skH8v6KOHU0ih8l58wv01?=
 =?us-ascii?Q?pJMuDv1lAso624tTqO9u/3mAmupwQqab1JiVbYV1U0rwm8okLAmzXO8E12PC?=
 =?us-ascii?Q?yjx+HWgOZOrqTMMeUXeBhBpJEeues6igwmNyiGNJR1Tdin1zxuwWTpkerQfS?=
 =?us-ascii?Q?OHvR03hvbKucYrrL+fv6JPzVbv6I5d5pM8IKaFeS6HeqkOeuyxPm5TB1Jeqh?=
 =?us-ascii?Q?R6ZZcta8saUJtThx13Krx8Ztt15VmUUJhHjPN9zh4icAueC8zK7iE3dOFrJv?=
 =?us-ascii?Q?eqvY+aUp8foJRxMxL8rOmlK4Xc5sfGVc7aUQBW/4d58A+11cpSFqbB6BpIq1?=
 =?us-ascii?Q?SpTLYkHAobNQZWg2lTMjOibjjR4c0TRXndfQka3KGzely88JpPaYeEO7quk8?=
 =?us-ascii?Q?hFFj3qYoYJL9NT01iP4JM+XL/VYS6YfkRSV5I3kW0vULpg9jqWDhssY+0oRB?=
 =?us-ascii?Q?6j56Ci4GaXf4eO8D3KbhIZ8RbMbiATdaaGKwqLe7FJ2dh/WmdqtQoj1j2X9A?=
 =?us-ascii?Q?2LODAuNUWIEAXTm+nL1xaSY7YvmBhHWA2Yb5ii3EXq/rHMG3GT5KbukC4i+M?=
 =?us-ascii?Q?H9WzajEI/EkGKSYl4vtBmHhcFHMZpTXPeZW3ohgpbry0XhIUGzVPLshcDqDn?=
 =?us-ascii?Q?3PLs8iKy3zVsTbpgV4KdfMmbsp3AxikLjFHAaNpEKAI/6k9edWs5Z9SEwJti?=
 =?us-ascii?Q?y/fVHM4HpCekX04+qtvss57nTYGiVUmLilzPI/wRbTJdGG1yLQMmy7yFeH0R?=
 =?us-ascii?Q?dKwQxyr/aAa2TTCCzuw4aywSW7hnUafg9b87UQOdleRIlheNFeYwfxHI/Xmt?=
 =?us-ascii?Q?MW/nS83izFs4nvgG7Zagcd1nWraGzIVwW3nhDFoKOJTEOapBiqSfA0UnPpjf?=
 =?us-ascii?Q?HtZnTu9zYdP9bo2bnnrWN4rVGmA5Wqcyo9x8h4dNF4UWONMvnmKrJKJIKfmS?=
 =?us-ascii?Q?CfTBuw0KUMkTgAfJSu5z4rcCRQiAFCIlXP9dAdNehUOvtEp3/rk+B539aebK?=
 =?us-ascii?Q?vYM48aZnXj28C1pWfxOOru/3CAM1vDqt33uG6BBj9BdkCL2yTD5WxmFurX/9?=
 =?us-ascii?Q?9zLZQlv8l0PF8nrka++Sqq/3zu785XpyDw2/EbT5tek0DsEDiZX7E2UC99Tb?=
 =?us-ascii?Q?+hlanTB6UlI6o9/dCqiqov9dsVwBO9vxeH7ZOvysR2jRx0lsxyBrOsAUmyJv?=
 =?us-ascii?Q?NipIhUoKmZzQM/9ZKxKhY+1rQtYeyqJHhAn0PZitiw/0IndShZQ2tmVsZJ13?=
 =?us-ascii?Q?XDqqKQVo3ab0WMl8f4Y=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 13:32:44.7097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4710a83f-7271-46eb-ce7c-08de2b5df35c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5732

On Mon, 24 Nov 2025 10:20:41 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> On Mon, Nov 24, 2025 at 12:08:46PM +0200, Zhi Wang wrote:
> > On Fri, 21 Nov 2025 14:20:13 +0000
> > Alice Ryhl <aliceryhl@google.com> wrote:
> > 
> > > On Wed, Nov 19, 2025 at 01:21:13PM +0200, Zhi Wang wrote:
> > > > The previous Io<SIZE> type combined both the generic I/O access
> > > > helpers and MMIO implementation details in a single struct.
> > > > 
> > > > To establish a cleaner layering between the I/O interface and
> > > > its concrete backends, paving the way for supporting additional
> > > > I/O mechanisms in the future, Io<SIZE> need to be factored.
> > > > 
> > > > Factor the common helpers into new {Io, Io64} traits, and move
> > > > the MMIO-specific logic into a dedicated Mmio<SIZE> type
> > > > implementing that trait. Rename the IoRaw to MmioRaw and update
> > > > the bus MMIO implementations to use MmioRaw.
> > > > 
> > > > No functional change intended.
> > > > 
> > > > Cc: Alexandre Courbot <acourbot@nvidia.com>
> > > > Cc: Alice Ryhl <aliceryhl@google.com>
> > > > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > > > Cc: Danilo Krummrich <dakr@kernel.org>
> > > > Cc: John Hubbard <jhubbard@nvidia.com>
> > > > Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> > > 
> > > I said this on a previous version, but I still don't buy the split
> > > into IoFallible and IoInfallible.
> > > 
> > > For one, we're never going to have a method that can accept any
> > > Io - we will always want to accept either IoInfallible or
> > > IoFallible, so the base Io trait serves no purpose.
> > > 
> > > For another, the docs explain that the distinction between them is
> > > whether the bounds check is done at compile-time or runtime. That
> > > is not the kind of capability one normally uses different traits
> > > to distinguish between. It makes sense to have additional traits
> > > to distinguish between e.g.:
> > > 
> > > * Whether IO ops can fail for reasons *other* than bounds checks.
> > > * Whether 64-bit IO ops are possible.
> > > 
> > > Well ... I guess one could distinguish between whether it's
> > > possible to check bounds at compile-time at all. But if you can
> > > check them at compile-time, it should always be possible to check
> > > at runtime too, so one should be a sub-trait of the other if you
> > > want to distinguish them. (And then a trait name of KnownSizeIo
> > > would be more idiomatic.)
> > > 
> > 
> > Thanks a lot for the detailed feedback. Agree with the points. Let's
> > keep the IoFallible and IoInfallible traits but not just tie them
> > to the bound checks in the docs.
> 
> What do you plan to write in the docs instead?
> 

What I understad according to the discussion:

1. Infallible vs Fallible:

- Infallible indicates the I/O operation can will not return error from
  the API level, and doesn't guarentee the hardware status from device
  level.

- Fallible indicates the I/O operation can return error from the
  API level.

2. compiling-time check vs run-time check:

- driver specifies a known-valid-size I/O region, we go compiling-time
  check (saves the cost of run-time check).

- driver is not able to specifiy a known-valid-size I/O region, we
  should go run-time check.

For IoInfallible, I would write the doc as:

A trait for I/O accessors that are guaranteed to succeed at the API
level.

Implementations of this trait provide I/O operations that do
not return errors to the caller. From the perspective of the I/O
API, the I/O operation is always considered successful.

Note that this does *not* mean that the underlying device is guaranteed
to be in a healthy state. Hardware-specific exceptional states must be
detected and handled by the driver or subsystem managing the device.

For Iofallible, 

A trait for I/O accessors that may return an error.

This trait represents I/O operations where the API can intentionally
return an error. The error typically reflects issues detected by the
subsystem.

> > > And I'm not really convinced that the current compile-time checked
> > > traits are a good idea at all. See:
> > > https://lore.kernel.org/all/DEEEZRYSYSS0.28PPK371D100F@nvidia.com/

snip

> The last -rc of this cycle is already out, so I don't think you need
> to worry about branch issues - you won't land it in time for that.
> 

I am mostly refering to the dependances if I have to implement this on
top of bounded integer on driver-core-testing.

> 
> But there is another problem: Bounded only supports the case where the
> bound is a power of two, so I don't think it's usable here. You can
> have Io regions whose size is not a power of two.

Any suggestion on this? :) Should I implement something like
BoundedOffset? Also would like to hear some inputs from Danilo as well.

Z.

> 
> Alice


