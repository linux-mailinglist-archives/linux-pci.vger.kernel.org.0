Return-Path: <linux-pci+bounces-34268-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C60F9B2BCB4
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 11:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 230FE1898FAA
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 09:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003A7315771;
	Tue, 19 Aug 2025 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eq0cgxKm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89651F37D3;
	Tue, 19 Aug 2025 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755594595; cv=none; b=P6uHtmi0+j+1j3a7W0HvKgKpe8zjR5bnDS7U+dww7zg+Ck5TSuZ9aYfYuUZE1eHl5fGf0y3CMnFn8GVGcqu8IF1ZevVb23kTsh8gf8hd4zHosWG3a6K+/4VOiSNb1U7kzZQeP7KDPYYj8Cr4sJpugGs3Ewvib2wQli7AuFGkcfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755594595; c=relaxed/simple;
	bh=9853QO76uaASuzg+F7gdYIngtiCcvywWCkxZZ5hHy5s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=MtJXqdO6QTOzvYHAbLWbqgNZMsBHPfM5iy9dnDMCuJmx/vrcFTDQIBvV51eGU2+eKnc3KckckgyqppTH/hi7oJKJm3MW9iUUlAMprskuj3rkGmeUe3M6JEz5Gv+YhpEpW14kI9+dZYX7Bip6hpuh0mDSN8vK4TdMEN1CPpfhOGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eq0cgxKm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9E9C4CEF1;
	Tue, 19 Aug 2025 09:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755594595;
	bh=9853QO76uaASuzg+F7gdYIngtiCcvywWCkxZZ5hHy5s=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=eq0cgxKmFllHAfPDiZzSWkhYsa3v+v7zkifOqP2C+Feb8fxbpJj6777Rg5L3NQltl
	 s0tNhzDRlV2sxHqzDHaiZqazQvVKH6t0c2ThzMJkIIFz0K3t+Xd9RVRIC7br9EkBKJ
	 OspYUlIoSR5ogKfINRIqgxrwWBBwkp2Ta3OaZfPe1AA/JZxQ1MJDszihtFELrvcft6
	 JfdbvBYaDmjzr3q2+XlO0t1rxUU4HCuIhg3NkKV+tZFO8smjj/6YWMAU7fc3qX0KAT
	 aYNziVrM3mgG9j7PdwQ0mnMdo05wM79ZQQjZVAo8kVrsRY/1/QcHDcDiFvE+HfpAd4
	 ZuWRAL3yoBdwA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Aug 2025 11:09:49 +0200
Message-Id: <DC6ACCFEBPYR.1R4LQL7EGKM5F@kernel.org>
Subject: Re: [PATCH v3 1/3] rust: pci: provide access to PCI Class,
 subclass, implementation values
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <nouveau@lists.freedesktop.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>
To: "John Hubbard" <jhubbard@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250819031117.560568-1-jhubbard@nvidia.com>
 <20250819031117.560568-2-jhubbard@nvidia.com>
In-Reply-To: <20250819031117.560568-2-jhubbard@nvidia.com>

On Tue Aug 19, 2025 at 5:11 AM CEST, John Hubbard wrote:
> +/// PCI device class codes. Each entry contains the full 24-bit PCI
> +/// class code (base class in bits 23-16, subclass in bits 15-8,
> +/// programming interface in bits 7-0).
> +///
> +/// # Examples
> +///
> +/// ```
> +/// # use kernel::{device::Core, pci::{self, Class}, prelude::*};
> +/// fn probe_device(pdev: &pci::Device<Core>) -> Result<()> {
> +///     // Get the PCI class for this device
> +///     let pci_class =3D pdev.pci_class();
> +///     dev_info!(
> +///         pdev.as_ref(),
> +///         "Detected PCI class: (0x{:06x})\n",
> +///         pci_class.as_u32()
> +///     );

Maybe a bit cleaner to implement Display for pci::Class?

> +///     Ok(())
> +/// }
> +/// ```
> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
> +#[repr(transparent)]
> +pub struct Class(u32);

[ Class impl and lots of pci class ids... ]

I think we should move all this to a new Rust module (rust/kernel/pci/class=
.rs)
to keep this file reasonably small.

You can add

	use self::class::Class;
	use self::class::ClassMask;

in this file to make it appear as e.g. kernel::pci::Class.

Sorry I didn't mention this in the previous version.

>  /// An adapter for the registration of PCI drivers.
>  pub struct Adapter<T: Driver>(T);
> =20
> @@ -157,6 +355,23 @@ pub const fn from_class(class: u32, class_mask: u32)=
 -> Self {
>              override_only: 0,
>          })
>      }
> +
> +    /// Create a new `pci::DeviceId` from a class number, mask, and spec=
ific vendor.
> +    ///
> +    /// This is more targeted than [`DeviceId::from_class`]: in addition=
 to matching by Vendor, it
> +    /// also matches the PCI Class (up to the entire 24 bits, depending =
on the mask).
> +    pub const fn from_class_and_vendor(class: Class, class_mask: u32, ve=
ndor: u32) -> Self {

I think it would be good if class_mask would be a new type ClassMask that o=
nly
has the constants that are applicable for this field, i.e. MASK_FULL and
MASK_CLASS_SUBCLASS.

> +        Self(bindings::pci_device_id {
> +            vendor,
> +            device: DeviceId::PCI_ANY_ID,
> +            subvendor: DeviceId::PCI_ANY_ID,
> +            subdevice: DeviceId::PCI_ANY_ID,
> +            class: class.as_u32(),
> +            class_mask,
> +            driver_data: 0,
> +            override_only: 0,
> +        })
> +    }
>  }
> =20
>  // SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `pci_device=
_id` and does not add
> @@ -410,6 +625,18 @@ pub fn resource_len(&self, bar: u32) -> Result<bindi=
ngs::resource_size_t> {
>          // - by its type invariant `self.as_raw` is always a valid point=
er to a `struct pci_dev`.
>          Ok(unsafe { bindings::pci_resource_len(self.as_raw(), bar.try_in=
to()?) })
>      }
> +
> +    /// Returns the full 24-bit PCI class code as stored in hardware.
> +    /// This includes base class, subclass, and programming interface.
> +    pub fn pci_class_code_raw(&self) -> u32 {
> +        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev=
`.
> +        unsafe { (*self.as_raw()).class }
> +    }

Do we need this method? I think drivers can just call pdev.pci_class().as_u=
32()
instead (which we could also name as_raw()).

> +    /// Returns the PCI class as a `Class` struct.
> +    pub fn pci_class(&self) -> Class {
> +        Class(self.pci_class_code_raw())
> +    }

This is good! At a first glance the name looks a bit odd or redundant, but
people would clearly expect something different when this is called as
pdev.class() (i.e. a struct class representation).

