Return-Path: <linux-pci+bounces-41832-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C78D2C765A6
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 22:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B2DA74E01E0
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 21:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BBB2C11CB;
	Thu, 20 Nov 2025 21:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FYxA2GBO"
X-Original-To: linux-pci@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010068.outbound.protection.outlook.com [52.101.85.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57BC221271;
	Thu, 20 Nov 2025 21:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763673431; cv=fail; b=SFy61pyEIxj5mFWX2oLSh6obRWarVxMQwWhnMDaOIqWmR7sXPt8UIWSzB44NrneVW3yuYIKiVFhgo6Lzm8gE2S4b/a24T2PgtMVt0VWvkAMoKjtXgUHcSIgAk6MHkOsQmNHFKQ77YoTDL2aZFIpDRc1mPc6snTIN3jBi+jhSc1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763673431; c=relaxed/simple;
	bh=5Vzfz1TYiLv2A5D3aMYepOMP4N3OP/4Fu6ikn0W5y6w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IauuDTuOTmBfT5eCVB7uRhYLzB6elibgwv5a+EPcm5yOZpqGG+y6H8v7rbJJciQXCI2TETGKyyNEuAHUsHfXP61+uepmQL7g9coOu656JLiRirZe06Z3a9OpiFezQLzXziXS/xS9CEo/fL13SstM2PsFDE7SNP0ZL2n8iASWOJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FYxA2GBO; arc=fail smtp.client-ip=52.101.85.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmtmAkJPatNM49adMoSs6gT9s5froiBrhp4Sv65KczgbiCnONaRH4V45fKeYZK7+ZCgWKirOqgzSefYOmc73AHjGsjjHqK5qbxkd4O7U7WCtU+/es1T0We29dfCUMgNKB8XVfiWZr1doC2SB+2NwbaGncX+xcAbIZs0ZgH1+Yq3zb1hgMNLQIGk4zsACHAuYhaeJFJa0QjLTMQzg8ccelHbkJKUDRf+tZLQfDvZeCxpUiV9eMqY4R4p+59Td60wLdWVYdWpz9903Ld66xAVcn7aSwsa5INKVoN2oPwTUxRYD/UzykCBTnFUdR1oWHNyjC7dfCt2aqfrV8YH4zhvkpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofg/Fr6pnMDnkbzhaPlKs8aBUHD1tcK0XogaWI6F0IA=;
 b=aqFg/JgnWyCYNoYUJR8jclh3Ju1eZhdwQgacjl6MAVIMAOPRydiiSi9lOl/bTxHw/SWH122HeXoRqRCQV2/Rd3YgAfMdMZlXdx19UAtUk0vOLVuhz8hvcx6ZZqqUpazRnlNECttH2kT1uGe9IDt/TVU/rlCjqIx3oXX6nmgQY+Pl1r867ROl/8Pwx1ohbY09dFpBcFDk4BDTczQzD5Wc9AgPGQ4bWpO8+XVtlEiU2sJJNsBpMaI1R5EWIovUIogXp2cycZihNq7P0e+QFoor3NYZdb8s1JyqQQzrRbhTw2ZGaDBAO/vC6iXr1PnewK6qAUGW1gkJarm5vPkxDBKOJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofg/Fr6pnMDnkbzhaPlKs8aBUHD1tcK0XogaWI6F0IA=;
 b=FYxA2GBODryH7vmzezJwKw1zmj+2WuTKXyYfMZ+QXePzbCw3J6K9KX0X/w4B6timY6pU7thOyEXtT4jKYruPiSSM4FIfZKdi0SBWnQ4p0zBmDGo89cz9w4azlBidh6hG5AQso7yrpoI5H80FUUWNY9VRA120zcYhMDqO2nZKl0PVagl7rtBq85iBWhG48gFI9sxGCLrqArbw8W8RBzkV9wmu6qXRK32tjq7Q0NathLehUEBTLbVLaMfcC1hE8CMIrCKNcsR1qlQpciF0Fl+10woxK05cwQRAs648/+v9kV8oYf0/8ufeRbT1eyj1qFuCofvmZ8tBhGimYuoCyGQy1w==
Received: from PH7PR02CA0024.namprd02.prod.outlook.com (2603:10b6:510:33d::10)
 by DM6PR12MB4201.namprd12.prod.outlook.com (2603:10b6:5:216::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 21:17:05 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:510:33d:cafe::c4) by PH7PR02CA0024.outlook.office365.com
 (2603:10b6:510:33d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 21:17:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.1 via Frontend Transport; Thu, 20 Nov 2025 21:17:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 13:16:34 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 13:16:34 -0800
Received: from inno-thin-client (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 20
 Nov 2025 13:16:25 -0800
Date: Thu, 20 Nov 2025 23:16:24 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Peter Colberg <pcolberg@redhat.com>
CC: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, "=?UTF-8?B?QmrDtnJu?=
 Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>, Abdiel Janulgue
	<abdiel.janulgue@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>,
	<linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 0/8] rust: pci: add abstractions for SR-IOV capability
Message-ID: <20251120231624.5cac712b.zhiw@nvidia.com>
In-Reply-To: <20251120203444.321378c2.zhiw@nvidia.com>
References: <20251119-rust-pci-sriov-v1-0-883a94599a97@redhat.com>
	<20251120083213.6c5c01a5.zhiw@nvidia.com>
	<aR8t0XdZVyN-0mak@earendel>
	<20251120203444.321378c2.zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|DM6PR12MB4201:EE_
X-MS-Office365-Filtering-Correlation-Id: 98d968e1-41f9-44ea-317b-08de287a2754
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YW8n3aHRxwCsTu2jlI2AkMSU9n8nurkm8h6c8I4EUeIusjFAEBHPs7nVix1N?=
 =?us-ascii?Q?p9Cl2tvLqa1/CYgOH3xPK2HhbouQ+BF+2zUUStVapxQGS3114b60dCuzeH1C?=
 =?us-ascii?Q?TBVASwMNgCHFuKlrGtMku/o8AHz1s8eRIygEaQM56Fsit1fbHK3gesW8p7RK?=
 =?us-ascii?Q?F5OnoClAdaP1zC7RBfXVB0T9TmQIHBHLRy+K0UVD3L18d/1ck1MiPPVuHa19?=
 =?us-ascii?Q?qa+fQCqw2+mbfrLzETRT9RbILgY1CuegU+i3md3zxyVoIqOgoImSfquEPfGf?=
 =?us-ascii?Q?MwY4/2BGdkLwYt4xQRGuvHOJzzDEjbG6ESu2BxpfK0PxHDKIqdXHDUZi7Piy?=
 =?us-ascii?Q?2e/JdFFcPjTQ5HZ0NXT33VQIsqeuSygxP24QikoZC9A6R9U95o7aH2s8l5Jh?=
 =?us-ascii?Q?9acpYL7HQqyJ/LnjMnmjXkkOpkuJZ1FUi1ErSHJ+BnkzbHZH39fgwoTnP/UU?=
 =?us-ascii?Q?PKRYuWQC5NElDifmNyu3380xt7PpfEHBr41OdA54NgidUawYmCAjzYOiMK5T?=
 =?us-ascii?Q?deSASU5cOJzlGaS/F0ZRhLkNNlwAmboJNFnmM0k4C4bsqjePqSwMzhXzzoVU?=
 =?us-ascii?Q?R19341rrj/ndwnzkuT1cUU8eJVikphzDswLisHj73nzpCxkLEvCZcOrcoEV6?=
 =?us-ascii?Q?dcskFk+YvTlwiwa9BLhh2C057nChyDjVAR1dNjB1Syx0K4hpYIda041bn088?=
 =?us-ascii?Q?P0e0LZjzlLFYBU/XlTvFUGJsaWQ8JXimhEB0A/etomBRy6zD4bDcwE0IDmeP?=
 =?us-ascii?Q?Rp/J4xbbwh1SoTX5ZEnJNUa5Gh5LYGRGiQXucLBdkZnlCqln5nkwLYsAT+XD?=
 =?us-ascii?Q?OSmLw0otcebPZX9wmFQOoG6/izHRIH0vMqGRghRpgg94/hP93KuHiWdUNOjU?=
 =?us-ascii?Q?qvla6KctQs3Mi+UIAEz9PwCJWPT8QDa83ynHsvW88V+RccyRv4ghZRhTpDo+?=
 =?us-ascii?Q?Z9Fvridn+FliLEiCJCMQrgNY6IExS3TOmjoYaFRGLdqx68Eqk0B43zMEpe7u?=
 =?us-ascii?Q?hLSiKI1l91hcXHdUSsF7ezLgLEaqnpWj4YLGltcvASzclNf8Ja6X6KdlWZ+D?=
 =?us-ascii?Q?SENQpgTweK/2g5tTc8ZKWW5YKHpwpgRVok4VnOmITviY6tjZuplDJI9syyfj?=
 =?us-ascii?Q?M6nfnqcpK1r1hH2+JY+PiPxd70DKEi2eXZS3gkRSYF/2yxyBZX4Ad70A1FfK?=
 =?us-ascii?Q?N0wxf3wH/2tvW0SfZ45lJcdXhPTA3kuXaQh2WzNvcevQSKfcT3BEiW4YT1gb?=
 =?us-ascii?Q?lC9dDHdS1ftrES+L5j7Nk/ocQBAhH2xvK187pNMT0CBhM9R5RQsBcXZ6CK1q?=
 =?us-ascii?Q?a6iGTbTHEzejecEODyTLDhYfhOMI+QRJKivvKQbWDKydAAvEwqbNRrTGw/0r?=
 =?us-ascii?Q?cNS2SA3Vde40lyKksEKlaUyqo3zQ2nSYra9tu7N/VsjZdoqVk5zZ0vwVlqe2?=
 =?us-ascii?Q?IcGgvrUXdBqzyw3DrHizg6/ogLC7YsINJuU/hAShFZkWH7myGlTHcPM89lku?=
 =?us-ascii?Q?SqRJoh685aFJvVjpYnEY+1axodGqs5hg77vW0/VkXFvrMl6wzadL+atY4Rx1?=
 =?us-ascii?Q?5LNpqKSDUgvLHXghT/d7u6e2rgJ8b1/29nw8usNi?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 21:17:04.2600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d968e1-41f9-44ea-317b-08de287a2754
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4201

On Thu, 20 Nov 2025 20:34:44 +0200
Zhi Wang <zhiw@nvidia.com> wrote:

I tested the patches on a L4, they are working perfectly. :) Though we
can't bootstrap a vGPU and actually poke the VF so far, but VF
enabling/disabling works without problem.

[   97.447502] NovaCore 0000:b6:00.0: Enable SR-IOV (PCI ID: NVIDIA, 0x27b8).
[   97.549467] pci 0000:b6:00.4: [10de:27b8] type 00 class 0x030200 PCIe Endpoint
[   97.549499] pci 0000:b6:00.4: enabling Extended Tags
[   97.549570] pci 0000:b6:00.4: Enabling HDA controller
[   97.549894] pci 0000:b6:00.4: Adding to iommu group 88
[   97.550649] NovaCore 0000:b6:00.4: enabling device (0000 -> 0002)
[   97.550745] NovaCore 0000:b6:00.4: probe with driver NovaCore failed with error -22
[  117.248723] NovaCore 0000:b6:00.0: Disable SR-IOV (PCI ID: NVIDIA, 0x27b8).

The repo I am using can be found here:

https://github.com/zhiwang-nvidia/nova-core/tree/rust-for-linux/test-sriov-on-nova-core

Will test them again on the next spin. :)

Z.

> On Thu, 20 Nov 2025 10:03:45 -0500
> Peter Colberg <pcolberg@redhat.com> wrote:
> 
> Hi Peter:
> 
> I met some errors when compiling on driver-core-next branch, you can
> fix those in the next spin.
> 
> Fixes:
> 
> diff --git a/drivers/gpu/nova-core/driver.rs
> b/drivers/gpu/nova-core/driver.rs index ca0d5f8ad54b..730e745cad63
> 100644 --- a/drivers/gpu/nova-core/driver.rs
> +++ b/drivers/gpu/nova-core/driver.rs
> @@ -49,6 +49,7 @@ pub(crate) struct NovaCore {
>      ]
>  );
>  
> +#[vtable]
>  impl pci::Driver for NovaCore {
>      type IdInfo = ();
>      const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
> 
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index d6cc5d7e7cd7..2d68db076f92 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -292,6 +292,7 @@ macro_rules! pci_device_table {
>  ///     ]
>  /// );
>  ///
> +/// #[vtable]
>  /// impl pci::Driver for MyDriver {
>  ///     type IdInfo = ();
>  ///     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
> 
> The code in the examples should be able to compile.
> 
> You can enable doctest by:
> 
> CONFIG_RUST_KERNEL_DOCTESTS=y
> 
> Then:
> 
> impl Device<device::Bound> {
>     /// Returns the Physical Function (PF) device for a Virtual
> Function (VF) device. ///
>     /// # Examples
>     ///
> 
> snip
> 
>     /// ```
>     /// let pf_pdev = vf_pdev.physfn()?;
>     /// let pf_drvdata = pf_pdev.as_ref().drvdata::<MyDriver>()?;
> 
> I saw this part is not able to be compiled.^
> 
> Z.
> 
> > On Thu, Nov 20, 2025 at 08:32:13AM +0200, Zhi Wang wrote:
> > > On Wed, 19 Nov 2025 17:19:04 -0500
> > > Peter Colberg <pcolberg@redhat.com> wrote:
> > > 
> > > Hi Peter:
> > > 
> > > Thanks for the patches. :) I will test them with nova-core and
> > > come back with Tested-bys.
> > 
> > Perfect, thanks Zhi.
> > 
> > > Nit: Let's use "kernel vertical" styles on imports. [1]
> > > 
> > > [1]
> > > https://lore.kernel.org/all/20251105120352.77603-1-dakr@kernel.org/
> > 
> > Thanks, done for patch "samples: rust: add SR-IOV driver sample".
> > 
> > Peter
> > 
> > > 
> > > > Add Rust abstractions for the Single Root I/O Virtualization
> > > > (SR-IOV) capability of a PCI device. Provide a minimal set of
> > > > wrappers for the SR-IOV C API to enable and disable SR-IOV for a
> > > > device, and query if a PCI device is a Physical Function (PF) or
> > > > Virtual Function (VF).
> > > > 
> > > > Using the #[vtable] attribute, extend the pci::Driver trait with
> > > > an optional bus callback sriov_configure() that is invoked when
> > > > a user-space application writes the number of VFs to the sysfs
> > > > file `sriov_numvfs` to enable SR-IOV, or zero to disable SR-IOV
> > > > [1].
> > > > 
> > > > Add a method physfn() to return the Physical Function (PF)
> > > > device for a Virtual Function (VF) device in the bound device
> > > > context. Unlike for a PCI driver written in C, guarantee that
> > > > when a VF device is bound to a driver, the underlying PF device
> > > > is bound to a driver, too.
> > > > 
> > > > When a device with enabled VFs is unbound from a driver, invoke
> > > > the sriov_configure() callback to disable SR-IOV before the
> > > > unbind() callback. To ensure the guarantee is upheld, call
> > > > disable_sriov() to remove all VF devices if the driver has not
> > > > done so already.
> > > > 
> > > > This series is based on Danilo Krummrich's series
> > > > "Device::drvdata() and driver/driver interaction (auxiliary)"
> > > > applied to driver-core-next, which similarly guarantees that
> > > > when an auxiliary bus device is bound to a driver, the
> > > > underlying parent device is bound to a driver, too [2].
> > > > 
> > > > Add an SR-IOV driver sample that exercises the SR-IOV capability
> > > > using QEMU's 82576 (igb) emulation and was used to test the
> > > > abstractions [3].
> > > > 
> > > > [1] https://docs.kernel.org/PCI/pci-iov-howto.html
> > > > [2]
> > > > https://lore.kernel.org/rust-for-linux/20251020223516.241050-1-dakr@kernel.org/
> > > > [3] https://www.qemu.org/docs/master/system/devices/igb.html
> > > > 
> > > > Signed-off-by: Peter Colberg <pcolberg@redhat.com>
> > > > ---
> > > > John Hubbard (1):
> > > >       rust: pci: add is_virtfn(), to check for VFs
> > > > 
> > > > Peter Colberg (7):
> > > >       rust: pci: add is_physfn(), to check for PFs
> > > >       rust: pci: add {enable,disable}_sriov(), to control SR-IOV
> > > > capability rust: pci: add num_vf(), to return number of VFs
> > > >       rust: pci: add vtable attribute to pci::Driver trait
> > > >       rust: pci: add bus callback sriov_configure(), to control
> > > > SR-IOV from sysfs rust: pci: add physfn(), to return PF device
> > > > for VF device samples: rust: add SR-IOV driver sample
> > > > 
> > > >  MAINTAINERS                           |   1 +
> > > >  rust/kernel/pci.rs                    | 148
> > > > ++++++++++++++++++++++++++++++++++ samples/rust/Kconfig
> > > >    |  11 +++ samples/rust/Makefile                 |   1 +
> > > >  samples/rust/rust_dma.rs              |   1 +
> > > >  samples/rust/rust_driver_auxiliary.rs |   1 +
> > > >  samples/rust/rust_driver_pci.rs       |   1 +
> > > >  samples/rust/rust_driver_sriov.rs     | 107
> > > > ++++++++++++++++++++++++ 8 files changed, 271 insertions(+)
> > > > ---
> > > > base-commit: e4addc7cc2dfcc19f1c8c8e47f3834b22cb21559
> > > > change-id: 20251026-rust-pci-sriov-ca8f501b2ae3
> > > > 
> > > > Best regards,
> > > 
> > 
> > 
> 


