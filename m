Return-Path: <linux-pci+bounces-40218-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08ACEC31E24
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 16:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEB993AA585
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 15:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E512C15B7;
	Tue,  4 Nov 2025 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JC12Pj2C"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FC22609EE;
	Tue,  4 Nov 2025 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762270602; cv=none; b=c+Bqsex72QQQca9k/LvVS85FbAwR2jQokLHWLNgPPp0sxiJsTo/4Cslw6RzLDGC81emcJ42t84/B/4NAuzGwGbvvnsv2fahX8Qp6KNvcp+mpRm1FXF6pgttUgfqtsurNGgsyQCvDiONM7xlIdMRRvVmMKBK6D2lulkbcDD+DWfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762270602; c=relaxed/simple;
	bh=jqMyXxij4g04AjD8Ah8fCRuqiVT/KplYlSbfovB7oo8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=O5JALHE11L9cyRDJPdl8Bedz1wsSpTWM5/ssix0+CzzNeKS9Ytz2e+vRvQf330Uv0FKjcD+zd8gRCXmmOdsElP/T+yDJwIOaT6RsvbYDfNE7isAjojhG9+Ev7N6XjuDD1a8jrxoF9dcJGD93wqwpWoIGwSGpVVXDXcLQyXfWVCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JC12Pj2C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F441C116B1;
	Tue,  4 Nov 2025 15:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762270602;
	bh=jqMyXxij4g04AjD8Ah8fCRuqiVT/KplYlSbfovB7oo8=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=JC12Pj2C9avf0O9t1aAQAPSluuozIj4n6LUw6vIoyDLA9MsFPaNCWW2KKZBnsky0b
	 ITfkEFC9R0wslmY1dlLyH9SLvuoTiu8k5Wzi4Rh896wMZb5lI51C0W/GpxHwqjrrQr
	 PYGZa7JlWiBBK7G6/0SbLZ9ywgyrv/Rpklfj7pUXSDAbkZeziW5071yrS2b9zW2ARt
	 eNkM4RnUcMvyYcooFpJCKXabwaOSn4tsFE7z5H9k24cWD2gQGhJMT9r63f8otHviP4
	 eZ2l2hxDrFKVRkLO2OHemhuPMXJD1vxwj6J9/HT8r53cPhtgNM4FudpCKl557+YHcq
	 W2CZTKPcdougQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Nov 2025 16:36:35 +0100
Message-Id: <DE00SF7OYYVO.1WGOGATPYXCBT@kernel.org>
Subject: Re: [PATCH RESEND v4 3/4] rust: pci: add config space read/write
 support
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <acourbot@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
 <zhiwang@kernel.org>
To: "Zhi Wang" <zhiw@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251104142733.5334-1-zhiw@nvidia.com>
 <20251104142733.5334-4-zhiw@nvidia.com>
In-Reply-To: <20251104142733.5334-4-zhiw@nvidia.com>

On Tue Nov 4, 2025 at 3:27 PM CET, Zhi Wang wrote:
> Drivers might need to access PCI config space for querying capability
> structures and access the registers inside the structures.
>
> For Rust drivers need to access PCI config space, the Rust PCI abstractio=
n
> needs to support it in a way that upholds Rust's safety principles.
>
> Introduce a `ConfigSpace` wrapper in Rust PCI abstraction to provide safe
> accessors for PCI config space. The new type implements the `Io` trait to
> share offset validation and bound-checking logic with others.
>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  rust/kernel/pci.rs | 148 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 142 insertions(+), 6 deletions(-)
>
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 77a8eb39ad32..630660a7f05d 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -5,13 +5,31 @@
>  //! C header: [`include/linux/pci.h`](srctree/include/linux/pci.h)
> =20
>  use crate::{
> -    bindings, container_of, device,
> -    device_id::{RawDeviceId, RawDeviceIdIndex},
> +    bindings,
> +    container_of,
> +    device,
> +    device_id::{
> +        RawDeviceId,
> +        RawDeviceIdIndex
> +    },
>      devres::Devres,
>      driver,
> -    error::{from_result, to_result, Result},
> -    io::{Mmio, MmioRaw},
> -    irq::{self, IrqRequest},
> +    error::{
> +        from_result,
> +        to_result,
> +        Result
> +    },
> +    io::{
> +        define_read,
> +        define_write,
> +        Io,
> +        Mmio,
> +        MmioRaw
> +    },
> +    irq::{
> +        self,
> +        IrqRequest
> +    },
>      str::CStr,
>      sync::aref::ARef,
>      types::Opaque,
> @@ -20,7 +38,10 @@
>  use core::{
>      marker::PhantomData,
>      ops::Deref,
> -    ptr::{addr_of_mut, NonNull},
> +    ptr::{
> +        addr_of_mut,
> +        NonNull
> +    },
>  };

Please add a comma and use `//` at the end of the last element of a block a=
s
described in [1]. Otherwise rustfmt will change it up again.

I think most of the diff is not related to this patch. I think it would be =
good
to convert the whole module and then add further changes.

I just did such a cleanup for the I/O module [1], I can send another patch =
for
all the PCI stuff.

[1] https://docs.kernel.org/rust/coding-guidelines.html#imports
[2] https://lore.kernel.org/lkml/20251104133301.59402-1-dakr@kernel.org/

>  use kernel::prelude::*;
> =20
> @@ -305,6 +326,83 @@ pub struct Device<Ctx: device::DeviceContext =3D dev=
ice::Normal>(
>      PhantomData<Ctx>,
>  );
> =20
> +/// Represents the PCI configuration space of a device.
> +///
> +/// Provides typed read and write accessors for configuration registers
> +/// using the standard `pci_read_config_*` and `pci_write_config_*` help=
ers.
> +///
> +/// The generic const parameter `SIZE` can be used to indicate the
> +/// maximum size of the configuration space (e.g. 256 bytes for legacy,
> +/// 4096 bytes for extended config space). The actual size is obtained
> +/// from the underlying `struct pci_dev` via [`Device::cfg_size`].
> +pub struct ConfigSpace<'a, const SIZE: usize =3D { ConfigSpaceSize::Exte=
nded as usize }> {
> +    pdev: &'a Device<device::Core>,
> +}
> +
> +macro_rules! call_config_read {
> +    (infallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr) =3D> {{
> +        let mut val: $ty =3D 0;
> +        let ret =3D unsafe { bindings::$c_fn($self.pdev.as_raw(), $addr =
as i32, &mut val) };
> +        match ret {
> +            0 =3D> val,
> +            _ =3D> !0,
> +        }

I think the match is not needed, the value should already be set accordingl=
y.

> +    }};
> +/// Represents the size of a PCI configuration space.
> +///
> +/// PCI devices can have either a *normal* (legacy) configuration space =
of 256 bytes,
> +/// or an *extended* configuration space of 4096 bytes as defined in the=
 PCI Express
> +/// specification.
> +pub enum ConfigSpaceSize {

I think this should be [repr(usize)].

> +    /// 256-byte legacy PCI configuration space.
> +    Normal =3D 256,
> +
> +    /// 4096-byte PCIe extended configuration space.
> +    Extended =3D 4096,
> +}
> +
>  impl Device {
>      /// Returns the PCI vendor ID as [`Vendor`].
>      ///
> @@ -514,6 +625,17 @@ pub fn pci_class(&self) -> Class {
>          // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev=
`.
>          Class::from_raw(unsafe { (*self.as_raw()).class })
>      }
> +
> +    /// Returns the size of configuration space.
> +    fn cfg_size(&self) -> Result<ConfigSpaceSize> {
> +        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev=
`.
> +        let size =3D unsafe { (*self.as_raw()).cfg_size };
> +        match size {
> +            256 =3D> Ok(ConfigSpaceSize::Normal),
> +            4096 =3D> Ok(ConfigSpaceSize::Extended),
> +            _ =3D> Err(EINVAL),

I'd add a debug_assert!() in this case.

> +        }
> +    }
>  }
> =20
>  impl Device<device::Bound> {
> @@ -591,6 +713,20 @@ pub fn set_master(&self) {
>          // SAFETY: `self.as_raw` is guaranteed to be a pointer to a vali=
d `struct pci_dev`.
>          unsafe { bindings::pci_set_master(self.as_raw()) };
>      }
> +
> +    /// Return an initialized config space object.
> +    pub fn config_space<'a>(
> +        &'a self,
> +    ) -> Result<ConfigSpace<'a, { ConfigSpaceSize::Normal as usize }>> {

Let's add as_raw() to ConfigSpaceSize and use that instead.

> +        Ok(ConfigSpace { pdev: self })
> +    }
> +
> +    /// Return an initialized config space object.
> +    pub fn config_space_exteneded<'a>(
> +        &'a self,
> +    ) -> Result<ConfigSpace<'a, { ConfigSpaceSize::Extended as usize }>>=
 {
> +        Ok(ConfigSpace { pdev: self })
> +    }
>  }
> =20
>  // SAFETY: `Device` is a transparent wrapper of a type that doesn't depe=
nd on `Device`'s generic
> --=20
> 2.51.0


