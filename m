Return-Path: <linux-pci+bounces-34339-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4C9B2D2C3
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 05:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 528AB7A977F
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 03:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5734E4315F;
	Wed, 20 Aug 2025 03:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b="dG/wmGlY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661E5223324
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 03:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755662083; cv=none; b=nUkrG9rtwQCDtiSnooIGCGZJlYdxoNW7PIZuHV4E+lkgYZ3SfwJOtJZGr0SgK4Pr5SP2gkQ4VPkHASb0s++HhsFB7XukzTeBk9Tpt4ri9OsukgmFnVgsFmkKZ4loAT5i9WuDNW0yOidR2oi1JBBHhJMYJ1Fivu4aQxVXLBV4MYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755662083; c=relaxed/simple;
	bh=g1pY+oTA/VB2PMvfPvT2uWU3P9c5/FMXs5is+w88jjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvsw6iN2nXaWCXmy6uQjlx5x3+ffpj7EBFfLlZz6xBrF8ivKTMetZAJB8/CygtwiMYXHwRhPveqxAeiReqUvrAMGJywreT2p0m3POA0bOXANLw8hBzr5MMyge8YJoCDPbm8Mf4DRjskODroX3lj8w+bMVS27Qy1Qygr+YDPiS6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev; spf=pass smtp.mailfrom=weathered-steel.dev; dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b=dG/wmGlY; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weathered-steel.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weathered-steel.dev;
	s=protonmail3; t=1755662064; x=1755921264;
	bh=u6ikxkS64lhp8sngIBbUYJt8706AhSAaRomGOcSzkzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=dG/wmGlYlNursxRLrOfoH3+niP5sdBh+c2yOxdDEgu3o+ct95yfcwnV2xxYp0gFHv
	 ojY/g+Oqdaj7g7aBPV22mUJUFYqHqBPYlj1xTcYhfQOkrG9vLiQDuHR3wzavwxqtx6
	 HjERxwRCh0259Lq2cmBHd9OdLfA7pK7/Ja5xzeybdGr+fV9zBjk4tejieXmXgstabF
	 TaSUQO56APnq4KF4FQBr8yERtDFaLULO+MoAtHUhSQb3hFjw50O6Fy+MzfesIoJPRc
	 ChrmJ6zHVfvC5pk3tq0JcDsn70zSQjgM8A3MLWr8T4farCOcjjCyTeEWDNrwLHC0Ta
	 vMglScuZvt3ow==
X-Pm-Submission-Id: 4c6CHy1kjtz2ScPN
Date: Wed, 20 Aug 2025 03:54:19 +0000
From: Elle Rhumsaa <elle@weathered-steel.dev>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] rust: pci: provide access to PCI Vendor values
Message-ID: <aKVG67rgURYVk8y3@archiso>
References: <20250818013305.1089446-1-jhubbard@nvidia.com>
 <20250818013305.1089446-4-jhubbard@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818013305.1089446-4-jhubbard@nvidia.com>

On Sun, Aug 17, 2025 at 06:33:05PM -0700, John Hubbard wrote:
> This allows callers to write Vendor::SOME_COMPANY instead of
> bindings::PCI_VENDOR_ID_SOME_COMPANY.
> 
> It also allows removing "use kernel::bindings" entirely from most of
> the affected files here.
> 
> Apply this to the various Rust for Linux callers who were previously
> using bindings::PCI_VENDOR_ID_*.
> 
> New APIs:
>     Vendor::SOME_COMPANY
>     Vendor::from_u32(), as_u32()
>     DeviceId::from_class_and_vendor() now takes Vendor type
> 
> Cc: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  drivers/gpu/nova-core/driver.rs       |  12 +-
>  rust/kernel/pci.rs                    | 327 +++++++++++++++++++++++++-
>  samples/rust/rust_dma.rs              |   3 +-
>  samples/rust/rust_driver_auxiliary.rs |   4 +-
>  samples/rust/rust_driver_pci.rs       |   4 +-
>  5 files changed, 338 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
> index 4ec5b861a345..d0272289f863 100644
> --- a/drivers/gpu/nova-core/driver.rs
> +++ b/drivers/gpu/nova-core/driver.rs
> @@ -1,7 +1,13 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
>  use kernel::{
> -    auxiliary, bindings, c_str, device::Core, pci, pci::Class, prelude::*, sizes::SZ_16M, sync::Arc,
> +    auxiliary, c_str,
> +    device::Core,
> +    pci,
> +    pci::{Class, Vendor},
> +    prelude::*,
> +    sizes::SZ_16M,
> +    sync::Arc,
>  };
>  
>  use crate::gpu::Gpu;
> @@ -26,7 +32,7 @@ pub(crate) struct NovaCore {
>              pci::DeviceId::from_class_and_vendor(
>                  Class::DISPLAY_VGA,
>                  Class::MASK_CLASS_SUBCLASS,
> -                bindings::PCI_VENDOR_ID_NVIDIA
> +                Vendor::NVIDIA
>              ),
>              ()
>          ),
> @@ -34,7 +40,7 @@ pub(crate) struct NovaCore {
>              pci::DeviceId::from_class_and_vendor(
>                  Class::DISPLAY_3D,
>                  Class::MASK_CLASS_SUBCLASS,
> -                bindings::PCI_VENDOR_ID_NVIDIA
> +                Vendor::NVIDIA
>              ),
>              ()
>          ),
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 9caa1d342d52..7a42b91ad873 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -196,6 +196,327 @@ pub const fn as_u32(self) -> u32 {
>      OTHERS                     = bindings::PCI_CLASS_OTHERS,                     // 0xff0000
>  }
>  
> +macro_rules! define_all_pci_vendors {
> +    (
> +        $($variant:ident = $binding:expr,)+
> +    ) => {
> +        /// PCI vendor IDs.
> +        ///
> +        /// Each entry contains the 16-bit PCI vendor ID as assigned by the PCI SIG.
> +        /// These IDs uniquely identify the manufacturer of a PCI device.
> +        /// All values are derived from kernel constants.
> +        #[derive(Debug, Clone, Copy, PartialEq, Eq)]
> +        #[repr(transparent)]
> +        pub struct Vendor(u32);
> +
> +        impl Vendor {
> +            // Associated constants derived from kernel bindings
> +            $(
> +                #[allow(missing_docs)]
> +                pub const $variant: Self = Self($binding);
> +            )+
> +
> +            /// Create a `Vendor` from the raw vendor ID value, or `None` if the value doesn't
> +            /// match any known vendor.
> +            pub fn from_u32(value: u32) -> Option<Self> {
> +                match value {
> +                    $(x if x == Self::$variant.0 => Some(Self::$variant),)+
> +                    _ => None,
> +                }
> +            }
> +
> +            /// Get the raw 16-bit vendor ID value.
> +            pub const fn as_u32(self) -> u32 {
> +                self.0
> +            }
> +        }
> +    };
> +}
> +
> +define_all_pci_vendors! {
> +    PCI_SIG                  = bindings::PCI_VENDOR_ID_PCI_SIG,                  // 0x0001
> +
> +    ...
> +
> +    NCUBE                    = bindings::PCI_VENDOR_ID_NCUBE,                    // 0x10ff
> +}
> +
>  /// An adapter for the registration of PCI drivers.
>  pub struct Adapter<T: Driver>(T);
>  
> @@ -335,9 +656,9 @@ pub const fn from_class(class: u32, class_mask: u32) -> Self {
>      ///
>      /// This is more targeted than [`DeviceId::from_class`]: in addition to matching by Vendor, it
>      /// also matches the PCI Class (up to the entire 24 bits, depending on the mask).
> -    pub const fn from_class_and_vendor(class: Class, class_mask: u32, vendor: u32) -> Self {
> +    pub const fn from_class_and_vendor(class: Class, class_mask: u32, vendor: Vendor) -> Self {
>          Self(bindings::pci_device_id {
> -            vendor,
> +            vendor: vendor.as_u32(),
>              device: DeviceId::PCI_ANY_ID,
>              subvendor: DeviceId::PCI_ANY_ID,
>              subdevice: DeviceId::PCI_ANY_ID,
> @@ -396,7 +717,7 @@ macro_rules! pci_device_table {
>  ///     <MyDriver as pci::Driver>::IdInfo,
>  ///     [
>  ///         (
> -///             pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_REDHAT, bindings::PCI_ANY_ID as u32),
> +///             pci::DeviceId::from_id(pci::Vendor::REDHAT.as_u32(), bindings::PCI_ANY_ID as u32),
>  ///             (),
>  ///         )
>  ///     ]
> diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
> index c5e7cce68654..520c59b930dc 100644
> --- a/samples/rust/rust_dma.rs
> +++ b/samples/rust/rust_dma.rs
> @@ -5,7 +5,6 @@
>  //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
>  
>  use kernel::{
> -    bindings,
>      device::Core,
>      dma::{CoherentAllocation, Device, DmaMask},
>      pci,
> @@ -46,7 +45,7 @@ unsafe impl kernel::transmute::FromBytes for MyStruct {}
>      MODULE_PCI_TABLE,
>      <DmaSampleDriver as pci::Driver>::IdInfo,
>      [(
> -        pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_REDHAT, 0x5),
> +        pci::DeviceId::from_id(pci::Vendor::REDHAT.as_u32(), 0x5),
>          ()
>      )]
>  );
> diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
> index f2a820683fc3..d8470e4bf88b 100644
> --- a/samples/rust/rust_driver_auxiliary.rs
> +++ b/samples/rust/rust_driver_auxiliary.rs
> @@ -5,7 +5,7 @@
>  //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
>  
>  use kernel::{
> -    auxiliary, bindings, c_str, device::Core, driver, error::Error, pci, prelude::*, InPlaceModule,
> +    auxiliary, c_str, device::Core, driver, error::Error, pci, prelude::*, InPlaceModule,
>  };
>  
>  use pin_init::PinInit;
> @@ -51,7 +51,7 @@ struct ParentDriver {
>      MODULE_PCI_TABLE,
>      <ParentDriver as pci::Driver>::IdInfo,
>      [(
> -        pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_REDHAT, 0x5),
> +        pci::DeviceId::from_id(pci::Vendor::REDHAT.as_u32(), 0x5),
>          ()
>      )]
>  );
> diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
> index 606946ff4d7f..a3a7a0837961 100644
> --- a/samples/rust/rust_driver_pci.rs
> +++ b/samples/rust/rust_driver_pci.rs
> @@ -4,7 +4,7 @@
>  //!
>  //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
>  
> -use kernel::{bindings, c_str, device::Core, devres::Devres, pci, prelude::*, types::ARef};
> +use kernel::{c_str, device::Core, devres::Devres, pci, prelude::*, types::ARef};
>  
>  struct Regs;
>  
> @@ -38,7 +38,7 @@ struct SampleDriver {
>      MODULE_PCI_TABLE,
>      <SampleDriver as pci::Driver>::IdInfo,
>      [(
> -        pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_REDHAT, 0x5),
> +        pci::DeviceId::from_id(pci::Vendor::REDHAT.as_u32(), 0x5),
>          TestIndex::NO_EVENTFD
>      )]
>  );
> -- 
> 2.50.1

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

