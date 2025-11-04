Return-Path: <linux-pci+bounces-40221-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8D5C32032
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 17:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9C061898FCA
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 16:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D7B283FEA;
	Tue,  4 Nov 2025 16:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KGGWrPKt"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013020.outbound.protection.outlook.com [40.107.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F4832ED29;
	Tue,  4 Nov 2025 16:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762273193; cv=fail; b=C5R2nUvjGPILH5alB6xM0tWvyJoSxgXrvcw0azWSOngK18yNq6pER9OhQ9A2coSK2pP9X6QPBLDBwiLgodvdExwH1EMRjIF3hdFRDqQT19LtsE6c3pl9dIbFh8qwD9/muUfTf1vBnHxKnDcVtn7Yngpdb3CZyocmhdgF8x+rjpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762273193; c=relaxed/simple;
	bh=xCTr3JUIGqDGVBEXhO+nffZjwj3tD9tF0heQgnJp/jo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RMEC74EM6Wx01I/3zWT1lgkKa8cQ3GmG4L0FebIsOjFfsPdrolii9tSOMlLk6y9ZozlDNvucIS4FFudBtzlw+Jqkr9EJkkU/t9writm0x0FmvL4Cd2u/r4f/oBSTzUQZGgpy0FXvnYiT3ExG+wGJ0yK/eMPgpKSFLt+QEOwIxNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KGGWrPKt; arc=fail smtp.client-ip=40.107.201.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NA5F+J6LAiZVdsrxNToay9zgtE18YQqg58WGOhdMnHSsL71q0vY+XfLOi+TOGKNV+mW2fRXNLVXZk/pJ/PMV72q137B0vuQCC6lA+W2vWFYgEwRMFuAnHavmtwBMvxri6vF0lJqMkCeOMnZFEN/qL2BcSYUoGsIkdl4fpGEVyKS0x02ZBoqGE8yBeh00UBqcJGX6FIzIHcHwUc/886aHY5oPf7zwKLXCZSSk7Z3U+JwzqTR05bZy07SfKN3XabTzwxoVa9TAsnljW8Y/sUM9DjjAPcIcImBoxurUA9exzj7SPMqPrp5MYbeDioIxeQOTTT3xnx7awMmV39SPNbng0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwQHp8obTSPKHDN6yEQ/5Osy9aJj6Cvx4FKSC9ENv30=;
 b=mb+L0agpmyOgEZQPegLTNk9eA1ULprzqxuj7ErC7RM0GH2G4LttKE2kDHp44NLOwk+VCzryG6V+Le1scWMfQskpsxokckZ4aCrjLKQtZQHlDh/alHgS1UbNwPaYaClzuFAkT6khqmzPwyxd6/eKaOPwliaFsNjE119YwB2izl2/a9eJRpsWbEzGFKOHI3c/0H1LhN6Jdpr/QFsHs463k8rTOG2+noNTjjNUFRlWJQLiF22XksdDgg3FxX9i4VW+mMSihqcsFN3NrSnSp4ACtDgpPH557NWKnfegjoV/+sdcgWJNqc0RIRHULytsoAaaNiHbD0GHwQLesyLQWOLC+sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwQHp8obTSPKHDN6yEQ/5Osy9aJj6Cvx4FKSC9ENv30=;
 b=KGGWrPKtPk8uK3V4xtfkrlHJ8YAYkrST8opZR9dCn6VTAkQngY7KBwn3n2c5Hvcz5DQP4vjwyoKDyk/J/zpMfLOUsxylAC8rqQCmzweksCDMjRwhdZTqD88tZ4ifwNUCzggPsvEPiFLW4L/EPwNLwN9b+gB84FUMdC5oMUVEWqZeHyTBG14iGjA3S8bncaBnoxcfmhhggESPq61ZyWXxeepo4ABgb9sVCo6iJ4QywYhchxZrognds/MCSxe6kPBfgPChwV9zWJQzlgBbb8izVAET/HHWAZrYIhh+4v8Gpn2za1uvnsEzyYgzEAFZU5+MtcAHw6BIvPztjVILK9/IFQ==
Received: from CH5PR05CA0004.namprd05.prod.outlook.com (2603:10b6:610:1f0::9)
 by IA1PR12MB6329.namprd12.prod.outlook.com (2603:10b6:208:3e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 16:19:38 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::8c) by CH5PR05CA0004.outlook.office365.com
 (2603:10b6:610:1f0::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 16:19:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 16:19:38 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 08:19:32 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 4 Nov 2025 08:19:31 -0800
Received: from inno-thin-client (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 4 Nov 2025 08:19:25 -0800
Date: Tue, 4 Nov 2025 18:19:24 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <aliceryhl@google.com>,
	<bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
	<bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
	<tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<acourbot@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
	<zhiwang@kernel.org>
Subject: Re: [PATCH RESEND v4 3/4] rust: pci: add config space read/write
 support
Message-ID: <20251104181924.5a6c3fe7.zhiw@nvidia.com>
In-Reply-To: <DE00SF7OYYVO.1WGOGATPYXCBT@kernel.org>
References: <20251104142733.5334-1-zhiw@nvidia.com>
	<20251104142733.5334-4-zhiw@nvidia.com>
	<DE00SF7OYYVO.1WGOGATPYXCBT@kernel.org>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|IA1PR12MB6329:EE_
X-MS-Office365-Filtering-Correlation-Id: f787bc2a-e798-4234-6da9-08de1bbdf3d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?peWEtOXjhKx4Fji0ZlGsLeB6tVg5XUt7rV01sXZK//otQ+LKX3xjvmoxG3dA?=
 =?us-ascii?Q?n6bhE6z4xqN2YRmKcPUXTL9jXVJKuYd9ybZJrAYQFaZcCYRakW9rkeUM0ZmW?=
 =?us-ascii?Q?Fok+n4F7Q4rqxvTM5kCAnIUDhqla97zSunDRDDHEdquGRAVxon1dSYesvhzd?=
 =?us-ascii?Q?4wAuJZmbDpiQ91dK/eHAYJl6Vo/N+ISOK5sZj6ZlrPYBDo7EO2rkf99MXGMC?=
 =?us-ascii?Q?+Vlk+kDKnEc9JQZfLufiC9n7k+LSJl1hgSZHDh6HgxoI1kOVLt2aurPb7I8Q?=
 =?us-ascii?Q?QqFe05zJuhQk1NacZBfFn/z7E8TtWOogMdEbm4rbn7IE277jius+4Kz4lCHw?=
 =?us-ascii?Q?Rjw+1bOEfHesS8EjHjrISHAsffOq8deVZ5y2odDHJ0o3j7YUdscFDAi4LeoB?=
 =?us-ascii?Q?k9QA9Vto410mE5Gec3CZP5hrFIApoUucHpxrg7QBndeUCuDkzlCEEfRAwCUr?=
 =?us-ascii?Q?8qv/sNp5ZAJWpQIrjHOrcrjR1Wyjke8XQKOqFEHWjSyqbQnKU3ZiOMlhhbyD?=
 =?us-ascii?Q?GdwLTi4ycUpLXpnbQJw8TTdBPxm8lPgvy7sHEHXcIiLVyC9LXHcxFfwzTDlh?=
 =?us-ascii?Q?fMZtsssewy2D9nh1CelCVWzZkE1FAdn54PwZdkdLPyG7ZBu53axIoNBvzJdL?=
 =?us-ascii?Q?hgGVUDIxSpbDq0dBqaCqyhPbL13WvjrPAVhh+HF9KHhnNvNdpP5bwlezCaeE?=
 =?us-ascii?Q?DiYj1KulBAjJkYLVkYCMj5Kd66t5JJynjJx9SGSemOoC3cI8nIPXkKa1eSR2?=
 =?us-ascii?Q?LppDzRWYWdpNcM2mx0GOr8Vo3A/GungZRze6tgzoG2HnBVECZodEyHAaqFFO?=
 =?us-ascii?Q?pIepotQQjXGfQkmUcqzHxJ8i9livJRCBHMTTc9GP3cGMvtJUh3f5Dv/ZwnwA?=
 =?us-ascii?Q?YCypqv49DYLKjuG/s/dkBRVpadW1HK1FLvT/w7E+BVHYmWB3kfsvBeCe4FUk?=
 =?us-ascii?Q?XBefG5pb711MMRMzUyQcfZxlfTRJKRK58ZhdwOMxKdqK//y8820s5JPy35M/?=
 =?us-ascii?Q?TbjOWl8RKZMNRWF/JkQy8e7ozYXTBGhgiPEZCBvAKhZE9k6M/v35sZ7BxEwm?=
 =?us-ascii?Q?XLqgxqWwxkXpEOg8euqou7rGjNRaXSOyxgV7pmGJ7mSLU+iIiuQvSEB62Y7S?=
 =?us-ascii?Q?1bW3EKW+eRYKaPamgCoE8fCjOB3H5gDbcI7eEoOgfqqFimDMrkGLfrNC/tUG?=
 =?us-ascii?Q?pkFQn16EKIWupy36gIm0Fa1YMBcHaSp19VdVJbzFEHx8iAE2//zd93TZ+bO3?=
 =?us-ascii?Q?0rD07ghFP5Qu982jegOD83w8CmgN0/eEkx/aBMQvQJknGUve6AyMYLzhg2KJ?=
 =?us-ascii?Q?OWV/qkxaG5S/Q+Rf4bZerMzb1RJJ8CgbqBA6DywiRfXvoP62/ka8nVuTcglB?=
 =?us-ascii?Q?4813+lufIORDLrgBkEHX3DM30ffL+/q2KbomtVXH9J43mt4IPJorDxs/sdrp?=
 =?us-ascii?Q?qsfRXa4SYTAUQ5iMu3mBQN+b21NAR/TZs2tfy3v0KrAYqD7vOIEiJwv7tJv4?=
 =?us-ascii?Q?bf9yxW4KtQPT3M7Lrnzko7m+tLbnok5dkJOJFA5YQBXBrStj0BC85c+LILnT?=
 =?us-ascii?Q?u684KX9+yJ7slzuVGbo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 16:19:38.5247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f787bc2a-e798-4234-6da9-08de1bbdf3d0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6329

On Tue, 04 Nov 2025 16:36:35 +0100
"Danilo Krummrich" <dakr@kernel.org> wrote:

> On Tue Nov 4, 2025 at 3:27 PM CET, Zhi Wang wrote:
> > Drivers might need to access PCI config space for querying
> > capability structures and access the registers inside the
> > structures.
> >
> > For Rust drivers need to access PCI config space, the Rust PCI
> > abstraction needs to support it in a way that upholds Rust's safety
> > principles.
> >
> > Introduce a `ConfigSpace` wrapper in Rust PCI abstraction to
> > provide safe accessors for PCI config space. The new type
> > implements the `Io` trait to share offset validation and
> > bound-checking logic with others.
> >
> > Cc: Danilo Krummrich <dakr@kernel.org>
> > Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> > ---
> >  rust/kernel/pci.rs | 148
> > +++++++++++++++++++++++++++++++++++++++++++-- 1 file changed, 142
> > insertions(+), 6 deletions(-)
> >
> > diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> > index 77a8eb39ad32..630660a7f05d 100644
> > --- a/rust/kernel/pci.rs
> > +++ b/rust/kernel/pci.rs
> > @@ -5,13 +5,31 @@
> >  //! C header: [`include/linux/pci.h`](srctree/include/linux/pci.h)
> >  
> >  use crate::{
> > -    bindings, container_of, device,
> > -    device_id::{RawDeviceId, RawDeviceIdIndex},
> > +    bindings,
> > +    container_of,
> > +    device,
> > +    device_id::{
> > +        RawDeviceId,
> > +        RawDeviceIdIndex
> > +    },
> >      devres::Devres,
> >      driver,
> > -    error::{from_result, to_result, Result},
> > -    io::{Mmio, MmioRaw},
> > -    irq::{self, IrqRequest},
> > +    error::{
> > +        from_result,
> > +        to_result,
> > +        Result
> > +    },
> > +    io::{
> > +        define_read,
> > +        define_write,
> > +        Io,
> > +        Mmio,
> > +        MmioRaw
> > +    },
> > +    irq::{
> > +        self,
> > +        IrqRequest
> > +    },
> >      str::CStr,
> >      sync::aref::ARef,
> >      types::Opaque,
> > @@ -20,7 +38,10 @@
> >  use core::{
> >      marker::PhantomData,
> >      ops::Deref,
> > -    ptr::{addr_of_mut, NonNull},
> > +    ptr::{
> > +        addr_of_mut,
> > +        NonNull
> > +    },
> >  };
> 
> Please add a comma and use `//` at the end of the last element of a
> block as described in [1]. Otherwise rustfmt will change it up again.
> 

I see.

> I think most of the diff is not related to this patch. I think it
> would be good to convert the whole module and then add further
> changes.
> 
> I just did such a cleanup for the I/O module [1], I can send another
> patch for all the PCI stuff.
> 

I can rebase this series on top of yours once your sent them out. 

> [1] https://docs.kernel.org/rust/coding-guidelines.html#imports
> [2]
> https://lore.kernel.org/lkml/20251104133301.59402-1-dakr@kernel.org/
> 
> >  use kernel::prelude::*;
> >  
> > @@ -305,6 +326,83 @@ pub struct Device<Ctx: device::DeviceContext =
> > device::Normal>( PhantomData<Ctx>,
> >  );
> >  
> > +/// Represents the PCI configuration space of a device.
> > +///
> > +/// Provides typed read and write accessors for configuration
> > registers +/// using the standard `pci_read_config_*` and
> > `pci_write_config_*` helpers. +///
> > +/// The generic const parameter `SIZE` can be used to indicate the
> > +/// maximum size of the configuration space (e.g. 256 bytes for
> > legacy, +/// 4096 bytes for extended config space). The actual size
> > is obtained +/// from the underlying `struct pci_dev` via
> > [`Device::cfg_size`]. +pub struct ConfigSpace<'a, const SIZE: usize
> > = { ConfigSpaceSize::Extended as usize }> {
> > +    pdev: &'a Device<device::Core>,
> > +}
> > +
> > +macro_rules! call_config_read {
> > +    (infallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr) =>
> > {{
> > +        let mut val: $ty = 0;
> > +        let ret = unsafe { bindings::$c_fn($self.pdev.as_raw(),
> > $addr as i32, &mut val) };
> > +        match ret {
> > +            0 => val,
> > +            _ => !0,
> > +        }
> 
> I think the match is not needed, the value should already be set
> accordingly.
> 
> > +    }};
> > +/// Represents the size of a PCI configuration space.
> > +///
> > +/// PCI devices can have either a *normal* (legacy) configuration
> > space of 256 bytes, +/// or an *extended* configuration space of
> > 4096 bytes as defined in the PCI Express +/// specification.
> > +pub enum ConfigSpaceSize {
> 
> I think this should be [repr(usize)].
> 
> > +    /// 256-byte legacy PCI configuration space.
> > +    Normal = 256,
> > +
> > +    /// 4096-byte PCIe extended configuration space.
> > +    Extended = 4096,
> > +}
> > +
> >  impl Device {
> >      /// Returns the PCI vendor ID as [`Vendor`].
> >      ///
> > @@ -514,6 +625,17 @@ pub fn pci_class(&self) -> Class {
> >          // SAFETY: `self.as_raw` is a valid pointer to a `struct
> > pci_dev`. Class::from_raw(unsafe { (*self.as_raw()).class })
> >      }
> > +
> > +    /// Returns the size of configuration space.
> > +    fn cfg_size(&self) -> Result<ConfigSpaceSize> {
> > +        // SAFETY: `self.as_raw` is a valid pointer to a `struct
> > pci_dev`.
> > +        let size = unsafe { (*self.as_raw()).cfg_size };
> > +        match size {
> > +            256 => Ok(ConfigSpaceSize::Normal),
> > +            4096 => Ok(ConfigSpaceSize::Extended),
> > +            _ => Err(EINVAL),
> 
> I'd add a debug_assert!() in this case.
> 
> > +        }
> > +    }
> >  }
> >  
> >  impl Device<device::Bound> {
> > @@ -591,6 +713,20 @@ pub fn set_master(&self) {
> >          // SAFETY: `self.as_raw` is guaranteed to be a pointer to
> > a valid `struct pci_dev`. unsafe {
> > bindings::pci_set_master(self.as_raw()) }; }
> > +
> > +    /// Return an initialized config space object.
> > +    pub fn config_space<'a>(
> > +        &'a self,
> > +    ) -> Result<ConfigSpace<'a, { ConfigSpaceSize::Normal as usize
> > }>> {
> 
> Let's add as_raw() to ConfigSpaceSize and use that instead.
> 
> > +        Ok(ConfigSpace { pdev: self })
> > +    }
> > +
> > +    /// Return an initialized config space object.
> > +    pub fn config_space_exteneded<'a>(
> > +        &'a self,
> > +    ) -> Result<ConfigSpace<'a, { ConfigSpaceSize::Extended as
> > usize }>> {
> > +        Ok(ConfigSpace { pdev: self })
> > +    }
> >  }
> >  
> >  // SAFETY: `Device` is a transparent wrapper of a type that
> > doesn't depend on `Device`'s generic -- 
> > 2.51.0
> 


