Return-Path: <linux-pci+bounces-41937-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1723EC7FD05
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 11:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B8329342FD4
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 10:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE3A2FA0F5;
	Mon, 24 Nov 2025 10:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GYGUapyp"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013053.outbound.protection.outlook.com [40.93.201.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F302F7462;
	Mon, 24 Nov 2025 10:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763978959; cv=fail; b=SHveq5dezf6SMNqdDo5lZg7htK590F6YHFlLDNL4ngIL2e/n+EB+2CbVF9D4s6xNF0gyJstpIWOaMo67GyZ/7e65nAvcOtgTf2Yp31LDQDNYeB7qx+jCkDn6DQtev6Vi/xXZZjAHHQnFgEChifefZBSLK8O3l/033oiivYnXCDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763978959; c=relaxed/simple;
	bh=Z+g3MOgcEq/FAhhfZVzwTkMZCn6Zi8aRYaCl2VWZ8Z8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ewJErG2sCGGDLh3faBzdocYEFc+mJ/WeX6xc73hycco+Z3l/pMI+SBfwF3fVrh4mtZbtTySV2/D5LgPsII1vXCOfndkw3fx38bqNVf4OcjpmIQzUEQLgvqgWaAzjExjYf8ucDor8PHmOZmv34utcmoedY6Yp2iYyTI8R44Q3ItU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GYGUapyp; arc=fail smtp.client-ip=40.93.201.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8HQuzT+BC+Io4pohlmTwYsVt3yKHrMPxykdIf3qTqTZ2O/HrjMpZVDlu0QeiRUe0rk9VC5yPOxGJ9AfPrZxycJu8+iMhjJDjKnjg07RqmxYBvuOI23BrQZRxYs8dLfPMqirnaN5vdWKlLviLeQxDvdye6CQqQhrfBBQsBPr/dLF1ycBXqs+F5FJp128FBwzkAvc44M7Iu+YWiV9+MPM50Ol2DHM+FlMXXIRVe55xqHpAwr2hqOZR7gKiVylapyM+F0NEHAV/7/oKYLR/qS9j/P9ULfhYLT9kRs/odD8OiUUWw6H2Hm7Fks5shPw10Lfau68jWyg/xEDclJZUPwfYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HayH3pEFaJVC+lWDqcxHaNHXPpR0IDsy5zKuxUfjMiw=;
 b=dwM6AhoOe5L0rZiLO/06wV2MrQLnaK4eYqdy18uKR/NPTpFw5LdFmrlAKrTISb6CKgdnWy0SJEXs2qnF+YYphz2EhqsGRbSQ6Hiq7vYxNe+uKur05grDCkRHje9tImFa3qKjVNEBXN7+LqWZbPAG+BIZ9DaVbTaqvvx/eyErpBlRlLCnw4fX02+Mt6KTmEbLTshVOzcSSQrptBbA1AX29umKCIMQ+6b/gqB7DqX3LFrR9YwckffTmgQIaldYrYFHCZ8tlfICMzEiEZqCf4GqN9ww+i68dfDb8BmsJH+w9jq9HiXi1PB9+fI/zTQXQu94ceg/BCfj9bR0CUB7ZqGfLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HayH3pEFaJVC+lWDqcxHaNHXPpR0IDsy5zKuxUfjMiw=;
 b=GYGUapyprF3aNq1OBzk7tscxXv1/NKtA9aPsc6JC7NLubzqUxCrkadUEQFQnpOUOUWX85IitQX99mo+YSorF0nw+5zs1rUIIsss2l4GgAHHNEyn7nvc4T2h8MSVuvmHJGFwm6XrOU66SqJzurN8p+EvFQVxeXJAth9aoYCxYtXcyO8IqxSAJxWRpigCUuPEWlDvtw9t+kMy1jZVDHHwAfa9RJHft9UxQ9OxfpeJ+9MUV0NJpwSKitrEctZ+IfbHgl1hnYkD63y2xEXggT7BfpAL0Z2pf6rr8qfyu97by97v+O5rSTLJ8quRXwY14bE/l0dLYdlNdmUhAV9qlNZUtsg==
Received: from BN9PR03CA0600.namprd03.prod.outlook.com (2603:10b6:408:10d::35)
 by CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 24 Nov
 2025 10:09:12 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:10d:cafe::a7) by BN9PR03CA0600.outlook.office365.com
 (2603:10b6:408:10d::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 10:08:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 10:09:12 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 02:08:59 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 02:08:56 -0800
Received: from inno-thin-client (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 24
 Nov 2025 02:08:47 -0800
Date: Mon, 24 Nov 2025 12:08:46 +0200
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
Message-ID: <20251124120846.267078e5.zhiw@nvidia.com>
In-Reply-To: <aSB1Hcqr6W7EEjjK@google.com>
References: <20251119112117.116979-1-zhiw@nvidia.com>
	<20251119112117.116979-4-zhiw@nvidia.com>
	<aSB1Hcqr6W7EEjjK@google.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|CY8PR12MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: cce79c1d-22ad-4704-b5f7-08de2b418444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|1800799024|376014|82310400026|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aK4pYzUFSQiziCUeI98R+aiHNzabLMOzcuK+ymnxTdl1YwvJBVy40NGGjFKE?=
 =?us-ascii?Q?XE6FqRScLfIbk4GDlvpTxOJLgxwy4FDSwUOfvfpXsaScY0T2CqN206Igp+mL?=
 =?us-ascii?Q?jMkm/uhHhl6ET0yd1EG47bkLCE9n1i0pyNbBcKy51SqWv2abPP/7uS6jAcOs?=
 =?us-ascii?Q?gogr5SA6XVLpKdZJX+uxNXty0rLlQZLovnHQUEGUUi3qJnJY0/YNd6DrW48v?=
 =?us-ascii?Q?23QeB6aBTuiUilnknPKGIOvo8vhKLLR8jqMEwFgQQ+dIgxWx8z+7UoLDAYDO?=
 =?us-ascii?Q?nsUlKC6nblP1HAX0AiMQK++LzIaD7M40MzBeOBycLlSaRuCnZjvkK+sgqMyE?=
 =?us-ascii?Q?7QWx58wS93VgwWlBsG02WZj6ljOvKHAcfWZE7lrvyEKYgVO4Sk4llyQHxzSS?=
 =?us-ascii?Q?N1rsDERDCqtifhzxBI8myUaA5BGBeQN/UXrUny/6bPK1aYx6jOcqYd4Y/Ayo?=
 =?us-ascii?Q?o+GefvROjYbi3JXik/IZP6DlT2XPB2vjxyio0AIUsFwOJVfwS2Ng+K1+Mu08?=
 =?us-ascii?Q?IMThzboB7l0EsUeMeJ1KNTUbQ4yL7mFMFQio43GczlznRcWAhSP1gAmLlUFl?=
 =?us-ascii?Q?0sJkxnRRrcx9Hoz8POowG8qTR50kLv0BXrJ+quu8j0crlAQlhziJl+hzkRI9?=
 =?us-ascii?Q?QnCts6Gp1iMlI+ZR3iwEA23H/5VV5R7RRpH/6SXfANDMQh2zwPmzbB0LULHq?=
 =?us-ascii?Q?un/FT0DTgkOAVUhlaPxEOyqQch9IFU9yvWrnmzlESsuFJfak6LAb4COdXX08?=
 =?us-ascii?Q?ZaKkjRiMEOnF5LVJoN0RJavk4GHRCXLHEJ6sK2OFBjWc9Tlh601HuysRXmET?=
 =?us-ascii?Q?MdXf9gRB44ZUL29WfA7nUOdJjWWVLiqqeCA9McvGi/RU/mw/rviPlbI8Tk4O?=
 =?us-ascii?Q?98zlArjqv3ireHhR1XDi1VxyCXNTlS01QZAIMNdhhf+4SD5i31ufpnUT9hSz?=
 =?us-ascii?Q?VCsZj34da7z0AxbmqlMP/b0Q8q9mt4xI/Hr7j2+x/kSOwze/tvw/ivVZ77X4?=
 =?us-ascii?Q?MiGd3xcDnlh+jqKBDUPE3vNPiyRE48daZnKdCK+mBknfj9oE7VBk+ifArmkV?=
 =?us-ascii?Q?hbVMPBNrn2bzNktW6So+sbiPG6WOl5FDVNOBKDGuEDMKPV4Dj8rICk95V08d?=
 =?us-ascii?Q?HW6eLYqC72WYWsMb0J4vOxdJkKrHxK6C6JLrhhSMsGFUQ086mluI7Xl3SUks?=
 =?us-ascii?Q?s5sAvXuvjbTPIt8w2EyJJnwKPAUTsoZaqHUHCtqyFYJ+fHySrlilG1eB2BQL?=
 =?us-ascii?Q?YjYm+T/gGpIDjLU2bWm1YEQBapxQaAru0A499cU40CGS+2Nxzin3jHgPxjMF?=
 =?us-ascii?Q?ysEH7ryb600MdSySwlV/4fymMO/rECYOxu/LzA7NRMRQO5oHMI1vfcC+c+a5?=
 =?us-ascii?Q?EqEOKZGyh3JfiwTt8SMK9CHcmTK4Ezld/bGrj8u5VGrYJiLXTFRroP37msTt?=
 =?us-ascii?Q?9bsCej5dqeQyAfocxrStfv7ZxA5aLdp0z3kD0OXYlhFWjUgQ4g43BIcyOuTI?=
 =?us-ascii?Q?BKgo2vHuVeUoe0TKPxGG3pTAmSyX7OCtCV/Rz0H8UVqpDXIrLOEg0u2SHPql?=
 =?us-ascii?Q?y7ltBSjIsj9OEMdu/xF+T4t8VcYC3d2HVZSRtWYT?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(1800799024)(376014)(82310400026)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 10:09:12.3204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cce79c1d-22ad-4704-b5f7-08de2b418444
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7170

On Fri, 21 Nov 2025 14:20:13 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> On Wed, Nov 19, 2025 at 01:21:13PM +0200, Zhi Wang wrote:
> > The previous Io<SIZE> type combined both the generic I/O access
> > helpers and MMIO implementation details in a single struct.
> > 
> > To establish a cleaner layering between the I/O interface and its
> > concrete backends, paving the way for supporting additional I/O
> > mechanisms in the future, Io<SIZE> need to be factored.
> > 
> > Factor the common helpers into new {Io, Io64} traits, and move the
> > MMIO-specific logic into a dedicated Mmio<SIZE> type implementing
> > that trait. Rename the IoRaw to MmioRaw and update the bus MMIO
> > implementations to use MmioRaw.
> > 
> > No functional change intended.
> > 
> > Cc: Alexandre Courbot <acourbot@nvidia.com>
> > Cc: Alice Ryhl <aliceryhl@google.com>
> > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > Cc: Danilo Krummrich <dakr@kernel.org>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> 
> I said this on a previous version, but I still don't buy the split
> into IoFallible and IoInfallible.
> 
> For one, we're never going to have a method that can accept any Io -
> we will always want to accept either IoInfallible or IoFallible, so
> the base Io trait serves no purpose.
> 
> For another, the docs explain that the distinction between them is
> whether the bounds check is done at compile-time or runtime. That is
> not the kind of capability one normally uses different traits to
> distinguish between. It makes sense to have additional traits to
> distinguish between e.g.:
> 
> * Whether IO ops can fail for reasons *other* than bounds checks.
> * Whether 64-bit IO ops are possible.
> 
> Well ... I guess one could distinguish between whether it's possible
> to check bounds at compile-time at all. But if you can check them at
> compile-time, it should always be possible to check at runtime too, so
> one should be a sub-trait of the other if you want to distinguish
> them. (And then a trait name of KnownSizeIo would be more idiomatic.)
> 

Thanks a lot for the detailed feedback. Agree with the points. Let's
keep the IoFallible and IoInfallible traits but not just tie them to the
bound checks in the docs.

> And I'm not really convinced that the current compile-time checked
> traits are a good idea at all. See:
> https://lore.kernel.org/all/DEEEZRYSYSS0.28PPK371D100F@nvidia.com/
> 
> If we want to have a compile-time checked trait, then the idiomatic
> way to do that in Rust would be to have a new integer type that's
> guaranteed to only contain integers <= the size. For example, the
> Bounded integer being added elsewhere.
> 

Oops, this is a interesting bug. :) I think we can apply the bound
integer to IoFallible and IoInfallible to avoid possible problems
mentioned above. E.g. constructing a Bounded interger when constructing
Mmio and ConfigSpace objects and use them in the boundary checks in the
trait methods.

I saw Alex had already had an implementation of Bounded integer [1] in
rust-next. While my patchset is against driver-core-testing
branch. Would it be OK that we move on without it and switch to Bounded
integer when it is landed to driver-core-testing? I am open to
suggestions. :)

Z.

[1]
https://lore.kernel.org/all/CANiq72nV1zwoCCcHuizdfqWF=e8hvd6RO1CBXTEt73eqe4ayaA@mail.gmail.com/
> Alice


