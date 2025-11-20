Return-Path: <linux-pci+bounces-41830-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4674FC75EF1
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 19:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC1CA4E03F3
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 18:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97BC242D84;
	Thu, 20 Nov 2025 18:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FD+bCcmy"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010018.outbound.protection.outlook.com [52.101.61.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AA425742F;
	Thu, 20 Nov 2025 18:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763663720; cv=fail; b=hHC8SY2P2jsqOpwYKQF/VhrKbzZLQbDvE+OEDo6w070V4F1TLr/se0IVJ/Nmo1JJJKR8SishrI/Syt7pe90Q5P5oPDOq1aVXvhECyDqClZfUsgjCQoKcHhLqX09RcaqfOmx/djdEuVcH6Eei4umeRCVA7EN/37i2zkZnqAguyAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763663720; c=relaxed/simple;
	bh=05MlqH0rrvDiXCNcOp7chkN8gntEvzMiab59kBN4tgA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CtMQNnc4aFQ9YdYxchgZ6RhIWXopetH17gTTpjr/sWjej6NZ1NY7PMZ4Lb4DmFWPa5gNfFQXlqiM74FJinqiMrPjO6O21Qv+Dq6hILQu1mbowlU0fENS6Brcxup1gD3aH2SbJ+ZZRvmxylRsWFtrPx4g7KBjGx83SyzPISem7SY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FD+bCcmy; arc=fail smtp.client-ip=52.101.61.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVRYgcL3rMb4XzFlKZxJCqKBu8pBa4V+cPGNh/UM0rtZ/AynluMl7hfLwWNluhteuBaEZbH/nbaWTjCCVeP7sZBvE1bIos9t1mXWbA6Vu9YcIvWlg3amluMuCfi9MfQqAWHdIQio2GqVZ9U7LsdsC5Yrn48msF8Q40SxqxzT7FpRfizpW9jtq9xWnvr0jdiGpzT6ZsNTlA9e4asmdnw9zuJj0MtwWCFgune+MBDvM6C5Wv5RnLpfY1SMlYiY4AUJMbBYxqnPLZVj/7M/CRy85IORw+XAyR5/hxjo3OJ+YQzvVQkvCJKO6nEBIA4K6NYi5ytvfNUz1VImnDnYjg9YSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGEFZhDi0p0IR4jQfN2DX+lQfoQJSI6zpe0h+MNsha0=;
 b=gVzlX7xqZogSO7b4gtlhyhBCnTSIjXC5r2qKJlRGNJtY0SLMnU4U3JSDn3H3du7lExEkKOrHhc4wJThWjf8N2PYTMHny3FQAXWmPTVPdvdL86Rz04Lj8Ip5YOf/MrTByJWO2catpl3cAKSEH7XXefTYEQAkk2dTbaPjxlsdr12wIUpXTePOGCrhHeNMHHxBwsOFwn6qTmtu1yz/axWEj7LMig5c9KOm25DswjD0S4UeEaZ0B3Lol8BudEcDr3w8Sgy4xrVaS860AEAWefj9zvmTLz6yHQQvs65cCZI0DwWaUU0JycyxnB4wljnLadccNWEmUvw9nTnNxKyt5aZ+26A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGEFZhDi0p0IR4jQfN2DX+lQfoQJSI6zpe0h+MNsha0=;
 b=FD+bCcmyTFQK8HuuUSOmg9NUtMwHPpyKaXqhYipDSYZ/Z6jjo4ux2LxKQR/lyIV6udgP7/I5r59ShY7IC9mAutbPJTSvxD4eqzAWOhIa30GRwERTImYede9A35wZ1019khYkBJB9prsFMEWo1Fzp5MhYbsEsDEu9b/QpzFiKMM/yhECYHYNVGuq7yfz4IMH6MzAZL4A9QSj/s7YQw307w3hiffGldl78VHXwcoQ7+SfXn0ckc9ZDJWNBBvvVc24/Ewwq0P6guvovYKgVra5JbQ2Yp+yq+cJ2AU6XRzivrz+ALm6z2w+X1dLWEH+LLdMUSWlvrbZCj7G6Xm1HBt2s2A==
Received: from BY3PR05CA0046.namprd05.prod.outlook.com (2603:10b6:a03:39b::21)
 by CH3PR12MB7522.namprd12.prod.outlook.com (2603:10b6:610:142::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 18:35:11 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:39b:cafe::1a) by BY3PR05CA0046.outlook.office365.com
 (2603:10b6:a03:39b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.4 via Frontend Transport; Thu,
 20 Nov 2025 18:35:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 18:35:10 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 10:34:53 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 20 Nov 2025 10:34:53 -0800
Received: from inno-thin-client (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 20 Nov 2025 10:34:46 -0800
Date: Thu, 20 Nov 2025 20:34:44 +0200
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
Message-ID: <20251120203444.321378c2.zhiw@nvidia.com>
In-Reply-To: <aR8t0XdZVyN-0mak@earendel>
References: <20251119-rust-pci-sriov-v1-0-883a94599a97@redhat.com>
	<20251120083213.6c5c01a5.zhiw@nvidia.com>
	<aR8t0XdZVyN-0mak@earendel>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|CH3PR12MB7522:EE_
X-MS-Office365-Filtering-Correlation-Id: b5935d0f-2502-46d9-8d8b-08de28638955
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FlFCwELD1n9iGDQH9x3nrbDigkiVr1IhJR2oOAqmdfgomaeWuvryz0X3j/cy?=
 =?us-ascii?Q?KACyZg0UJnO/wI7kc+VDFtaW7po3DOKXHeBY3xHjlaXDScwNeGZzmisxGKr4?=
 =?us-ascii?Q?V+gNsXccyg5oeAFAb70oaPjT8zIbMli5xZ4PeYqyG53ECDQFGlyjx8gnAvg0?=
 =?us-ascii?Q?weGYUBgfu72Ub3hSE6rOFEHNVOYUmZCZcmxZC2v2YcmPF1cuLYvyq2bsb/mq?=
 =?us-ascii?Q?SUOZVmkUGL/uxJKAVCKl15Oxg8XGCGXZXyzBiKmLvLBDGDNwGGVXT7c3iJGK?=
 =?us-ascii?Q?g3npRLoYFL78o0dYmaFFk3A6O5BtHWLpvXhr2W8kLhFJRCPtC5enqXg18qmC?=
 =?us-ascii?Q?tvAGzCoZ6EL/EuF7j0Zzp0HhhKG79BUbjY91PmtnsfLf87NTU4zE62CiNj6i?=
 =?us-ascii?Q?2XDkJsT2Jc8sS6LgNFndzJl4l2WCKrpQgOzFKAKDRiUH2y2uY0mYRksTK2g7?=
 =?us-ascii?Q?BWJHNNdS0XvyepwC/iYEPqzFQrkI3Q+PFinq7Le9jOcUfR8zRwrwgB6ZILBa?=
 =?us-ascii?Q?YW+S/uq0nO83PuGbFxZUqgShW1Wxzr+i6eteMLkGtQn8afQoV09cUi0PS+HM?=
 =?us-ascii?Q?QRFsM4UQm7x0KILr5UJw7FXg8k6ruy9+zGXyqOej8F4+MyKqUcJ+nCvpPRDZ?=
 =?us-ascii?Q?3IdYKA2W4s0vbeapZMKZgzaWXJ5OhIRag9FrNpSMoqGQQJDJLItCz4IQTy/v?=
 =?us-ascii?Q?L0bONnOAXEfwjcggAmzFR72ofo01tmavdTTtGZ6X39wL12ZAFSfeASUe3jcG?=
 =?us-ascii?Q?05113S2QKeNMx6UL5+7Cyaf+aCfI1aZ879DTxChRNzWlx2POClZ4HM2bwIMl?=
 =?us-ascii?Q?JMlirakLK1lvoB4NFIRQL8qqt3QHi2ZklV9f9O6y3LQlslJog7d5TLd6RSjQ?=
 =?us-ascii?Q?lViZvkDCKiEkmA9M7fYfyJrKm9mEyw/yMDQLsu6Jy1WItmhDt4D8ZgxyEQDd?=
 =?us-ascii?Q?Z7zoQuxZW73imhTPhMCv4vI3Y/fkWXBCfMZ7f243VYGcsEKx0OTTh7U002+x?=
 =?us-ascii?Q?izP1vnuWtXZkBN+MlXYKnhmtQftA2nwYVqtfRrRGG12ptSUje4btza+okLNw?=
 =?us-ascii?Q?1GIeSlh3667MEGzAglMA9zPk37Qo5g5K2QX/AIltSKL0QtmUpMY+pr5LaqZt?=
 =?us-ascii?Q?qxU0bigtAnQriDjgbpMOiqjzS7WV+3BUbCh8IsZ4qes5llkF+xJhXXH6hze/?=
 =?us-ascii?Q?lsegu4WI2SjeRkLEd9D5DP2xqPEnuNgX20F4NgNh3NGzIGzJu7KU85WjglRD?=
 =?us-ascii?Q?4W3lZGH1Pg9mlfUlusAunouqQVOjfwYV9joLBEBqE2m7+T40YVnWNZULeQXm?=
 =?us-ascii?Q?rYa3CAkPRzM0RLw5HZMgTRLXtIL4PidomJpFJbDJ4PHbETJK7CFSLu2sjRvQ?=
 =?us-ascii?Q?xYBt8iaFRtClUU225sLp9FBv4lvWlbBaMfz74DPAu+pSYELp/HTV/HytuThx?=
 =?us-ascii?Q?WEZVCj5Etyi4AwbvHBtt0q6gcnm88YHJV09k1rfvJ11zRnVI95A+Mncvzdi7?=
 =?us-ascii?Q?97BVADIcMKpzRD28lbbNRc3twZis0QE+GxImGpW4YFzchRE1U8SOKW+y2Gu8?=
 =?us-ascii?Q?1r3wJW0GKXs71mbg3Dj/ysY9/mjxKpC1ZAQimYIj?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 18:35:10.3273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5935d0f-2502-46d9-8d8b-08de28638955
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7522

On Thu, 20 Nov 2025 10:03:45 -0500
Peter Colberg <pcolberg@redhat.com> wrote:

Hi Peter:

I met some errors when compiling on driver-core-next branch, you can
fix those in the next spin.

Fixes:

diff --git a/drivers/gpu/nova-core/driver.rs
b/drivers/gpu/nova-core/driver.rs index ca0d5f8ad54b..730e745cad63
100644 --- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -49,6 +49,7 @@ pub(crate) struct NovaCore {
     ]
 );
 
+#[vtable]
 impl pci::Driver for NovaCore {
     type IdInfo = ();
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index d6cc5d7e7cd7..2d68db076f92 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -292,6 +292,7 @@ macro_rules! pci_device_table {
 ///     ]
 /// );
 ///
+/// #[vtable]
 /// impl pci::Driver for MyDriver {
 ///     type IdInfo = ();
 ///     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;

The code in the examples should be able to compile.

You can enable doctest by:

CONFIG_RUST_KERNEL_DOCTESTS=y

Then:

impl Device<device::Bound> {
    /// Returns the Physical Function (PF) device for a Virtual
Function (VF) device. ///
    /// # Examples
    ///

snip

    /// ```
    /// let pf_pdev = vf_pdev.physfn()?;
    /// let pf_drvdata = pf_pdev.as_ref().drvdata::<MyDriver>()?;

I saw this part is not able to be compiled.^

Z.

> On Thu, Nov 20, 2025 at 08:32:13AM +0200, Zhi Wang wrote:
> > On Wed, 19 Nov 2025 17:19:04 -0500
> > Peter Colberg <pcolberg@redhat.com> wrote:
> > 
> > Hi Peter:
> > 
> > Thanks for the patches. :) I will test them with nova-core and come
> > back with Tested-bys.
> 
> Perfect, thanks Zhi.
> 
> > Nit: Let's use "kernel vertical" styles on imports. [1]
> > 
> > [1]
> > https://lore.kernel.org/all/20251105120352.77603-1-dakr@kernel.org/
> 
> Thanks, done for patch "samples: rust: add SR-IOV driver sample".
> 
> Peter
> 
> > 
> > > Add Rust abstractions for the Single Root I/O Virtualization
> > > (SR-IOV) capability of a PCI device. Provide a minimal set of
> > > wrappers for the SR-IOV C API to enable and disable SR-IOV for a
> > > device, and query if a PCI device is a Physical Function (PF) or
> > > Virtual Function (VF).
> > > 
> > > Using the #[vtable] attribute, extend the pci::Driver trait with
> > > an optional bus callback sriov_configure() that is invoked when a
> > > user-space application writes the number of VFs to the sysfs file
> > > `sriov_numvfs` to enable SR-IOV, or zero to disable SR-IOV [1].
> > > 
> > > Add a method physfn() to return the Physical Function (PF) device
> > > for a Virtual Function (VF) device in the bound device context.
> > > Unlike for a PCI driver written in C, guarantee that when a VF
> > > device is bound to a driver, the underlying PF device is bound to
> > > a driver, too.
> > > 
> > > When a device with enabled VFs is unbound from a driver, invoke
> > > the sriov_configure() callback to disable SR-IOV before the
> > > unbind() callback. To ensure the guarantee is upheld, call
> > > disable_sriov() to remove all VF devices if the driver has not
> > > done so already.
> > > 
> > > This series is based on Danilo Krummrich's series
> > > "Device::drvdata() and driver/driver interaction (auxiliary)"
> > > applied to driver-core-next, which similarly guarantees that when
> > > an auxiliary bus device is bound to a driver, the underlying
> > > parent device is bound to a driver, too [2].
> > > 
> > > Add an SR-IOV driver sample that exercises the SR-IOV capability
> > > using QEMU's 82576 (igb) emulation and was used to test the
> > > abstractions [3].
> > > 
> > > [1] https://docs.kernel.org/PCI/pci-iov-howto.html
> > > [2]
> > > https://lore.kernel.org/rust-for-linux/20251020223516.241050-1-dakr@kernel.org/
> > > [3] https://www.qemu.org/docs/master/system/devices/igb.html
> > > 
> > > Signed-off-by: Peter Colberg <pcolberg@redhat.com>
> > > ---
> > > John Hubbard (1):
> > >       rust: pci: add is_virtfn(), to check for VFs
> > > 
> > > Peter Colberg (7):
> > >       rust: pci: add is_physfn(), to check for PFs
> > >       rust: pci: add {enable,disable}_sriov(), to control SR-IOV
> > > capability rust: pci: add num_vf(), to return number of VFs
> > >       rust: pci: add vtable attribute to pci::Driver trait
> > >       rust: pci: add bus callback sriov_configure(), to control
> > > SR-IOV from sysfs rust: pci: add physfn(), to return PF device
> > > for VF device samples: rust: add SR-IOV driver sample
> > > 
> > >  MAINTAINERS                           |   1 +
> > >  rust/kernel/pci.rs                    | 148
> > > ++++++++++++++++++++++++++++++++++ samples/rust/Kconfig
> > >    |  11 +++ samples/rust/Makefile                 |   1 +
> > >  samples/rust/rust_dma.rs              |   1 +
> > >  samples/rust/rust_driver_auxiliary.rs |   1 +
> > >  samples/rust/rust_driver_pci.rs       |   1 +
> > >  samples/rust/rust_driver_sriov.rs     | 107
> > > ++++++++++++++++++++++++ 8 files changed, 271 insertions(+)
> > > ---
> > > base-commit: e4addc7cc2dfcc19f1c8c8e47f3834b22cb21559
> > > change-id: 20251026-rust-pci-sriov-ca8f501b2ae3
> > > 
> > > Best regards,
> > 
> 
> 


