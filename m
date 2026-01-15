Return-Path: <linux-pci+bounces-44910-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25142D23014
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 09:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D7EE301D178
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 08:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD4F1D8DFB;
	Thu, 15 Jan 2026 08:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ohSLYb2k"
X-Original-To: linux-pci@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010026.outbound.protection.outlook.com [52.101.46.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEBD28DB49;
	Thu, 15 Jan 2026 08:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768464449; cv=fail; b=uJcV0tZMUImAppH4t/c7cW0gwjS/HwO7Q3VI7JSKxgwF7Fp39oo7U2SCWGRj8aFmGdg21IRxtT3LB4Vf9XWAqj819DqCQXp3fdxmMHmVJwBJb7nL6HSFnKds4DzMHY3D5k3VLV3V/E9ILpeBNYQYVjmoAmtR9QiZCl0IXMYOfkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768464449; c=relaxed/simple;
	bh=WRPyxvUWCgYGF33CyvttSFM04BJbbep9xy8W77spZaA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bxtds4bYtbuAt/GyY1scTLRSB1Wv8o/JZOQWXpo5F+1yoifWfzxQ8fU5OqIFb0KOhJQYwopAZX7Zlvko1xQ5lBLFuCCKCfIOIrVjH0307+wVc1d7VFPChUReqygGR9YDazY6rbG+vrFdhf/vYvu9bYr/skrI1Squldt7wJr7Ukc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ohSLYb2k; arc=fail smtp.client-ip=52.101.46.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NkrXgos8aFqYZVGLlz9yEPBzyAr3NYubdwEGO+dK/baI+LqbSAXVdu+IXtXN9D9pj7zNXhyfO8Tf1TpJOCMg444z2eenasiWUxIdX/hTZ8eM+xh11b/4WE4gR3h9DR4E1fOgvw9jfpkeoeS8N3Lf4OvaElhlRwm7oHyDTRMJEIyycpNdVXtHv8E41ev9sWqMxL27/9AwcMTguzpPhs2LnDVOqS20zA//FAd8cOB/Gu6tDWCnQNgUEBK1bhCfIN0Ox/50aM/ifvCtiTTFhmzmoicjDUZLu6mBrYbYhO733G0hOZNCbkKvipPoB4FCiN/NLwZwql0RvSkiABM6ry5eaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLzm0kfkMadTwpDeXZbodg+BQZ7HWWIp1L/iNQhztjU=;
 b=mssCocBVEb2AmOwKxdneKeNU3rL7Vc2riXYlLXxcOd1HlGuVy3xifPGigXlYbgtfJmLACghil7w724RdnJw2oYxqWuzrNFublOAr9CIrsV0HRtk1rFDg5tUfFNT2y9qeHtK/G9OE0CJBXz8Jv8Uzi+lMsrDOXgpJ72zl30+J8CNXd613VEL8ETWei3Ydk6/6l7FXEg7Oa3zgBKuvYbzv6njf5BmmIrizjk2C2myr4Wfigksn/cahDeTy8wEB8G/ODgYx62cZAKLetkSrLn7oQT1MnnZrf1xd4TkPVxh1uSLYB7ay8HYgtdz+vdBdgfhQeZaFIz3/ZEcHvS2g6mHc6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=garyguo.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLzm0kfkMadTwpDeXZbodg+BQZ7HWWIp1L/iNQhztjU=;
 b=ohSLYb2k7dYbzJ8aBzNvhE4ZS1gWpA4B9ew/8sENdh75G3V83bUuTTFurZCW5Ff3z6nZWnrww+rlXSb3jsYrArXTBTJmkP0xKfZiiZj0703CdaSz1yZSGIkTLIYUgohkgVbs6HcrJ5vwbx8WSTKgTwiJQEKl6JxnEqQrDE5Es0+42ZgGsKVGnVCek/OOC8ifF6hw6STdV+tGxzk0Is6PGj7dwAduB85CbUKJlDzcxAYF4hlS7S+vO/N3RPNQRvzMANZHaDNRkmmrwnyyXRWT6Flq2UaxckvO37nKakDKqnQERRXTBMiIyGSBm+0HRGxDktb/EB1d05CcnqGQ6koZ0g==
Received: from BY1P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::11)
 by IA0PR12MB8905.namprd12.prod.outlook.com (2603:10b6:208:484::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Thu, 15 Jan
 2026 08:07:23 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::90) by BY1P220CA0011.outlook.office365.com
 (2603:10b6:a03:59d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Thu,
 15 Jan 2026 08:07:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 15 Jan 2026 08:07:23 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 00:07:11 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 00:07:10 -0800
Received: from inno-thin-client (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 15
 Jan 2026 00:07:03 -0800
Date: Thu, 15 Jan 2026 10:07:02 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Gary Guo <gary@garyguo.net>
CC: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <aliceryhl@google.com>,
	<bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
	<markus.probst@posteo.de>, <helgaas@kernel.org>, <cjia@nvidia.com>,
	<smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>, <acourbot@nvidia.com>,
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>, "Miguel
 Ojeda" <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH v8 1/5] rust: devres: style for imports
Message-ID: <20260115100625.432482dc.zhiw@nvidia.com>
In-Reply-To: <DFNJ3XN9ZGEC.1BS235XP021OQ@garyguo.net>
References: <20260113092253.220346-1-zhiw@nvidia.com>
	<20260113092253.220346-2-zhiw@nvidia.com>
	<DFNJ3XN9ZGEC.1BS235XP021OQ@garyguo.net>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|IA0PR12MB8905:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cbe3ad4-f616-4b64-5f30-08de540d1d58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OpY8bOJ9wWWq4336/ZVzrGb/137QNpuWXecJq990+y9E+51KykEfsLY0hqFw?=
 =?us-ascii?Q?oSsWOMy6/Ypecr6NmysrPxlbc0wU6m50o5NJCKVq3bUAaucHvp+KLUTUDJnm?=
 =?us-ascii?Q?mG9bqqMHR/EW5zfPUMyO4paGXruoKEQkIxQUAzJyggYnM03ygtQS1atpzEFa?=
 =?us-ascii?Q?7m3GBljW7KveisvBfZn9J1wA+6LqnwDEF0s9HHU7m6EOAPQlVIgvqCLL75l9?=
 =?us-ascii?Q?SbIl8NZrztpYr+dXTsF+GdQjATDNZiFRDMp4yzrDQEQLh0kcSQBwQi8SMAgv?=
 =?us-ascii?Q?lUX1jujZF64WWxVOLttlIyilZ441FfkDIjz3Zs3X8z3KWeVQ5SzEIOsVTGP2?=
 =?us-ascii?Q?YAfgLQg9DqeV1p66lxkx9njF8BUG+MTkCg9mS7ZJeVqxdadxQcS65C+UtTs+?=
 =?us-ascii?Q?Z0BRi9Q0ympLhIgPS7XPO3GBQVyadec8Q9yXokcoJeWsSZI82vFdIzKBVpZz?=
 =?us-ascii?Q?AjJsDc/WbFhGR9WzykxOsQvxOqW60WqisOe98oBspRfzEgtYK1cXDfmffj3N?=
 =?us-ascii?Q?YYABzx2IVnUCA3eKmMws6sdtCzkOLVCr30eeimO2mGf8wxbf4uLyMozYiJcz?=
 =?us-ascii?Q?fD/YepsYvuUjsU3ydNUNP+xjwZhX8gm7v+0Hi0PzfSjXpmveipovhxObehWN?=
 =?us-ascii?Q?DyEPL9o+fNXzqKE7YayjOjwuDJyIhku56reDK71bTc6T4YmMKOXYXzTxi1Gr?=
 =?us-ascii?Q?//ou/Ht0/5/wly6KwxavySTm6VNUZafgMcMmAYQP5zkDBxuHRdzOHZoDwTCl?=
 =?us-ascii?Q?0TeGsN0hcQ0VRumTmpTcHFvnig6aMczOfx9YhI/yDdgy3q4ffI3DGAob9NQR?=
 =?us-ascii?Q?M7kS1N62u6es52NSIo8OUTE9U0oe2oxMn2FRPGW5J3M0SXWDvOf+rvvQXqj9?=
 =?us-ascii?Q?rf3bhq4JbfQENEwbyXkhITXdRxH1fGu83ffuN0eHaLQoSRjPzBdwUv1hQz49?=
 =?us-ascii?Q?jBQ9iB8S5+wxrWgYvku/Ehe7zO/0aELOZ+qilzx6flZs1nM0FMmbUN09T7MA?=
 =?us-ascii?Q?BBd0Tk8uMESaWZG23OwjhEzeYCpv2Z3AkARG8G+NAvEmpXmtyTQ03HrdmUbV?=
 =?us-ascii?Q?P5Yf76Kuu9FzI/4E5S6dukCwqx08sXk8Mb8cs8Mzmd9DifXYltLMn08o1oM1?=
 =?us-ascii?Q?GgW6YfLJ4FxXcOeKNFEqcmgoJq4tB+SJKqrKuaaEwpf0Yd5OZU2cA/fnISDh?=
 =?us-ascii?Q?bK92KzvpOp4kRqDYYmIYldQO6jQkHaluBI4HV/namRNbJs6GPFQWSfsCoaRQ?=
 =?us-ascii?Q?uBQVPNz4WQagJdWfKxViYUq46bdXGh/9WWBlPEZfFlD7yUoo6SrzQgZHWduz?=
 =?us-ascii?Q?gg+zbNwkLrcp0YHiEwvL5uW+WB3okonE18efy+XKJHjkKKFnKjFx39d23b8m?=
 =?us-ascii?Q?riuIV6mlDAUMPpAPsUUPIrByFfzuwkNJWRqHM0dpRLUKQmf6tpufxnQPIySf?=
 =?us-ascii?Q?sTKk97QTv3mH2qubw6EgONQWclpTNiqttRHBDJ3S2M+fzw0dTQ7qCTIox1AD?=
 =?us-ascii?Q?iyDMzL0SRRf9ugEt0iEy4cBv0kSETYnJ6PgUW18j89xxW8yF3LH5qeLoHD+L?=
 =?us-ascii?Q?Ir80+VDWlXFAS0zLm3lgSTMoQb7hpa8CEj9UqFDeSOg4qgcDppBP7YgxDs1V?=
 =?us-ascii?Q?z+LnRAH6aEmSRpC2VVNfvaKOkoUFa5yCdSwhRuOpNa5R/s8mmhX/WQBKNbzE?=
 =?us-ascii?Q?P3jiBQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 08:07:23.6487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cbe3ad4-f616-4b64-5f30-08de540d1d58
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8905

On Tue, 13 Jan 2026 14:25:14 +0000
"Gary Guo" <gary@garyguo.net> wrote:

> On Tue Jan 13, 2026 at 9:22 AM GMT, Zhi Wang wrote:
> > Convert all imports in the devres to use "kernel vertical" style. Drop
> > unnecessary imports covered by prelude::*.
> 
> There doesn't appear to be any dropped import?

Yes. It has been done by someone already during the rebase. I will update
this.

> 
> Best,
> Gary
> 
> >
> > Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> > Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> > ---
> >  rust/kernel/devres.rs | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> > index db02f8b1788d..43089511bf76 100644
> > --- a/rust/kernel/devres.rs
> > +++ b/rust/kernel/devres.rs
> > @@ -254,8 +254,12 @@ pub fn device(&self) -> &Device {
> >      /// # Examples
> >      ///
> >      /// ```no_run
> > -    /// # #![cfg(CONFIG_PCI)]
> > -    /// # use kernel::{device::Core, devres::Devres, pci};
> > +    /// #![cfg(CONFIG_PCI)]
> > +    /// use kernel::{
> > +    ///     device::Core,
> > +    ///     devres::Devres,
> > +    ///     pci, //
> > +    /// };
> >      ///
> >      /// fn from_core(dev: &pci::Device<Core>, devres:
> > Devres<pci::Bar<0x4>>) -> Result { ///     let bar =
> > devres.access(dev.as_ref())?; @@ -358,7 +362,13 @@ fn
> > register_foreign<P>(dev: &Device<Bound>, data: P) -> Result /// #
> > Examples ///
> >  /// ```no_run
> > -/// use kernel::{device::{Bound, Device}, devres};
> > +/// use kernel::{
> > +///     device::{
> > +///         Bound,
> > +///         Device, //
> > +///     },
> > +///     devres, //
> > +/// };
> >  ///
> >  /// /// Registration of e.g. a class device, IRQ, etc.
> >  /// struct Registration;
> 


