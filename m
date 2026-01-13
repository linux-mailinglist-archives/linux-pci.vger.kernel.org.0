Return-Path: <linux-pci+bounces-44666-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BEFD1B1A9
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 20:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE7873002D2C
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 19:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677CA314B60;
	Tue, 13 Jan 2026 19:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0lvGy8H"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DF730DEDD;
	Tue, 13 Jan 2026 19:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768333713; cv=none; b=FTOG7wbvctQ0YPYQxLgnC+gDmbDvQcF4Hi2YFOP3btvHhWy9Vtl03uwpcIhBm7dHWQNVgT2nFW41fWhOEXONX5UZppmpW7Ixf+pT5eQPTMonrrRQnkNO3fz3ogI68knH4/NvC09920wbnBppkA4RugRjqVn2SidfrQDcMB/heEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768333713; c=relaxed/simple;
	bh=52j9AsPVJF8C276omodYbCAaqg1Kyg4VVTwaQWADMIw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=p0oYolAH6KBfPVpbFe7hbi5hlvQx0aUdNaTcbylAnblryg3Ctw1WG/Qz/9PJivDK/zJ7bf8hHgaUa80vjmmQs+D1gvshl6YMLUj8HIBeR6yTB1n6fIEYi8DQRO0pzuo8cPCOZYpzv72wgST5H9HPKF3XIWfBQVq61jTT00ovK5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0lvGy8H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD97C19423;
	Tue, 13 Jan 2026 19:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768333712;
	bh=52j9AsPVJF8C276omodYbCAaqg1Kyg4VVTwaQWADMIw=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=Y0lvGy8H2GQMqic9A1WC1fuM2kDlSUcx0RgOj4SRFfe41ie9mDfaeXTqyL4PYpe8y
	 CUF5UH4yFs0aHEEZFcSo79HNA85uM+AwwZjvrb1t53cJhepEfIWtNSnwZQbLl0Ujid
	 LASmi/WvPZNK/lEmw+N1fDOWI/Gw8G+Kyj8UviNqwi32yG0p4QjEv60Urd6s77LRY9
	 qJ+sKRkKncWDiD7VR7e2akw8Kux4zKF1NcdqueTuAYJQuMfwMLOK3uOAaJRAbKzBBl
	 0ttURQ30pI8II1bEwtMHEaipYy/J3+lK0FF/1q15P/9+08nIQ96l5sbkdhpU3StAaK
	 3BhTz7X1KNpMQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Jan 2026 20:48:25 +0100
Message-Id: <DFNPZDQW3FX5.4UI5M96GZUT6@kernel.org>
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
Subject: Re: [PATCH v8 4/5] rust: pci: add config space read/write support
References: <20260113092253.220346-1-zhiw@nvidia.com>
 <20260113092253.220346-5-zhiw@nvidia.com>
In-Reply-To: <20260113092253.220346-5-zhiw@nvidia.com>

On Tue Jan 13, 2026 at 10:22 AM CET, Zhi Wang wrote:
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 82e128431f08..f373413e8a84 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -40,7 +40,10 @@
>      ClassMask,
>      Vendor, //
>  };
> -pub use self::io::Bar;
> +pub use self::io::{
> +    Bar,
> +    ConfigSpace, //
> +};
>  pub use self::irq::{
>      IrqType,
>      IrqTypes,
> @@ -331,6 +334,30 @@ fn as_raw(&self) -> *mut bindings::pci_dev {
>      }
>  }
> =20
> +/// Represents the size of a PCI configuration space.
> +///
> +/// PCI devices can have either a *normal* (legacy) configuration space =
of 256 bytes,
> +/// or an *extended* configuration space of 4096 bytes as defined in the=
 PCI Express
> +/// specification.
> +#[repr(usize)]
> +pub enum ConfigSpaceSize {
> +    /// 256-byte legacy PCI configuration space.
> +    Normal =3D 256,
> +
> +    /// 4096-byte PCIe extended configuration space.
> +    Extended =3D 4096,
> +}
> +
> +impl ConfigSpaceSize {
> +    /// Get the raw value of this enum.
> +    #[inline(always)]
> +    pub const fn as_raw(self) -> usize {
> +        // CAST: PCI configuration space size is at most 4096 bytes, so =
the value always fits
> +        // within `usize` without truncation or sign change.
> +        self as usize
> +    }
> +}

Please move this to rust/kernel/pci/io.rs as well.

> +
>  impl Device {
>      /// Returns the PCI vendor ID as [`Vendor`].
>      ///
> @@ -427,6 +454,20 @@ pub fn pci_class(&self) -> Class {
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
> +            _ =3D> {
> +                debug_assert!(false);
> +                Err(EINVAL)
> +            }
> +        }
> +    }

Same here.

>  }
> =20
>  impl Device<device::Core> {
> diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
> index e3377397666e..c8741f0080ec 100644
> --- a/rust/kernel/pci/io.rs
> +++ b/rust/kernel/pci/io.rs
> @@ -2,12 +2,19 @@
> =20
>  //! PCI memory-mapped I/O infrastructure.
> =20
> -use super::Device;
> +use super::{
> +    ConfigSpaceSize,
> +    Device, //
> +};
>  use crate::{
>      bindings,
>      device,
>      devres::Devres,
>      io::{
> +        define_read,
> +        define_write,
> +        IoBase,
> +        IoKnownSize,
>          Mmio,
>          MmioRaw, //
>      },
> @@ -16,6 +23,101 @@
>  };
>  use core::ops::Deref;
> =20
> +/// The PCI configuration space of a device.
> +///
> +/// Provides typed read and write accessors for configuration registers
> +/// using the standard `pci_read_config_*` and `pci_write_config_*` help=
ers.
> +///
> +/// The generic const parameter `SIZE` can be used to indicate the
> +/// maximum size of the configuration space (e.g. 256 bytes for legacy,
> +/// 4096 bytes for extended config space).

Let's refer to ConfigSpaceSize instead.

> +pub struct ConfigSpace<'a, const SIZE: usize =3D { ConfigSpaceSize::Exte=
nded as usize }> {
> +    pub(crate) pdev: &'a Device<device::Bound>,
> +}

