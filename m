Return-Path: <linux-pci+bounces-34337-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9971FB2D2B6
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 05:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 819C05E7518
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 03:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6681EBA0D;
	Wed, 20 Aug 2025 03:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b="GpcTHbhN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AF61D7E31;
	Wed, 20 Aug 2025 03:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755661702; cv=none; b=muy+5o771DSet/5oRMh06s/K4UvqKvvsn5maeyEqMXMn994UZv+4Kdr2kehnEFe2R/6zK69N8cAkdZQPsgHYREb1HevnNXtWr2XjNQB4a3zdbkYDIGxDpEziZNy/unq7uKdLjWePXNfaEncSrBLp9AkN3ZKRfG4UyItvfESICnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755661702; c=relaxed/simple;
	bh=CZ6lWXfVYCM7xAdBsZGzRttG9D2KjVHw0YsHg56QY7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrocM6WrJhSMUdsVFoADTBrfAAT6QG+dWANcVgm/zzLKmmAqPPOvc9yHJbMJStCGeJ0MLUJKqsa0Q8S/HYn2U5SK13DlxK2/iGiFgfFTAFWBeXx7IRbJgPZOa35nYcUQC4poImqtzs25S5ZZ6dt4QNCEABJPfucaDzH2ULr72t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev; spf=pass smtp.mailfrom=weathered-steel.dev; dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b=GpcTHbhN; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weathered-steel.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weathered-steel.dev;
	s=protonmail3; t=1755661696; x=1755920896;
	bh=qIDOe0QSvA2p3uohZj2DaxRg0Kq5ls/HnNnWTRUdDrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=GpcTHbhNWGLmNYiGuteRHZmUj5G+dd1Oq4feazckGhttqPzBF61QGT1JPM8xnbdqV
	 yI7TaX8pdW568cSuRPacdBrmD3AC6m+lFkniTBRjyxdB2oGvwjHBdCAEMGllqxVpTt
	 GGTVHGM1GA6nCliN7hNViwLzKZ5etZY2bCJo0lw8IPG7eNHz8WIUFxroz0XqYZX8Tk
	 +PhbOXC0Fg9fRlg/jDK6dMpv5ta7Kr3iARTVNVKUcdZoCq0Cq7wC7a0nvGAZk4pPHB
	 MfBr4LJicXSUjn7FsAu3B3tm7eYbhy0JJJwJgUsrUwh1B7wcyPC0YiOsy4b/AUNtfV
	 zKDH6EGUx+huQ==
X-Pm-Submission-Id: 4c6C8s63rSz2Sccc
Date: Wed, 20 Aug 2025 03:48:10 +0000
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
Subject: Re: [PATCH v2 1/3] rust: pci: provide access to PCI Class, subclass,
 implementation values
Message-ID: <aKVFVO3wbzClcLwg@archiso>
References: <20250818013305.1089446-1-jhubbard@nvidia.com>
 <20250818013305.1089446-2-jhubbard@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818013305.1089446-2-jhubbard@nvidia.com>

On Sun, Aug 17, 2025 at 06:33:03PM -0700, John Hubbard wrote:
> Allow callers to write Class::STORAGE_SCSI instead of
> bindings::PCI_CLASS_STORAGE_SCSI, for example.
> 
> New APIs:
>     Class::STORAGE_SCSI, Class::NETWORK_ETHERNET, etc.
>     Class::from_u32(), as_u32()
>     Class::MASK_FULL, MASK_CLASS_SUBCLASS
>     DeviceId::from_class_and_vendor()
>     Device::class_code_raw(), class_enum()
> 
> Cc: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  rust/kernel/pci.rs | 202 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 202 insertions(+)
> 
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 887ee611b553..9caa1d342d52 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -23,6 +23,179 @@
>  };
>  use kernel::prelude::*;
>  
> +macro_rules! define_all_pci_classes {
> +    (
> +        $($variant:ident = $binding:expr,)+
> +    ) => {
> +        /// Converts a PCI class constant to 24-bit format.
> +        ///
> +        /// Many device drivers use only the upper 16 bits (base class and subclass), but some
> +        /// use the full 24 bits. In order to support both cases, store the class code as a 24-bit
> +        /// value, where 16-bit values are shifted up 8 bits.
> +        const fn to_24bit_class(val: u32) -> u32 {
> +            if val > 0xFFFF { val } else { val << 8 }
> +        }
> +
> +        /// PCI device class codes.
> +        ///
> +        /// Each entry contains the full 24-bit PCI class code (base class in bits 23-16, subclass
> +        /// in bits 15-8, programming interface in bits 7-0).
> +        ///
> +        #[derive(Debug, Clone, Copy, PartialEq, Eq)]
> +        #[repr(transparent)]
> +        pub struct Class(u32);
> +
> +        impl Class {
> +            $(
> +                #[allow(missing_docs)]
> +                pub const $variant: Self = Self(to_24bit_class($binding));
> +            )+
> +
> +            /// Match the full class code.
> +            pub const MASK_FULL: u32 = 0xffffff;
> +
> +            /// Match the upper 16 bits of the class code (base class and subclass only).
> +            pub const MASK_CLASS_SUBCLASS: u32 = 0xffff00;
> +
> +            /// Create a `Class` from the raw class code value, or `None` if the value doesn't
> +            /// match any known class.
> +            pub fn from_u32(value: u32) -> Option<Self> {
> +                match value {
> +                    $(x if x == Self::$variant.0 => Some(Self::$variant),)+
> +                    _ => None,
> +                }
> +            }
> +
> +            /// Get the raw 24-bit class code value.
> +            pub const fn as_u32(self) -> u32 {
> +                self.0
> +            }
> +        }
> +    };
> +}
> +
> +define_all_pci_classes! {
> +    NOT_DEFINED                = bindings::PCI_CLASS_NOT_DEFINED,                // 0x000000
> +
> +    ...
> +
> +    OTHERS                     = bindings::PCI_CLASS_OTHERS,                     // 0xff0000
> +}
> +
>  /// An adapter for the registration of PCI drivers.
>  pub struct Adapter<T: Driver>(T);
>  
> @@ -157,6 +330,23 @@ pub const fn from_class(class: u32, class_mask: u32) -> Self {
>              override_only: 0,
>          })
>      }
> +
> +    /// Create a new `pci::DeviceId` from a class number, mask, and specific vendor.
> +    ///
> +    /// This is more targeted than [`DeviceId::from_class`]: in addition to matching by Vendor, it
> +    /// also matches the PCI Class (up to the entire 24 bits, depending on the mask).
> +    pub const fn from_class_and_vendor(class: Class, class_mask: u32, vendor: u32) -> Self {
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
>  
>  // SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `pci_device_id` and does not add
> @@ -410,6 +600,18 @@ pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
>          // - by its type invariant `self.as_raw` is always a valid pointer to a `struct pci_dev`.
>          Ok(unsafe { bindings::pci_resource_len(self.as_raw(), bar.try_into()?) })
>      }
> +
> +    /// Returns the full 24-bit PCI class code as stored in hardware.
> +    /// This includes base class, subclass, and programming interface.
> +    pub fn class_code_raw(&self) -> u32 {
> +        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
> +        unsafe { (*self.as_raw()).class }
> +    }
> +
> +    /// Returns the PCI class as a `Class` struct, or `None` if the class code is invalid.
> +    pub fn class_enum(&self) -> Option<Class> {
> +        Class::from_u32(self.class_code_raw())
> +    }
>  }
>  
>  impl Device<device::Bound> {
> -- 
> 2.50.1

All of the functions could probably be `#[inline]`ed, though I'm not
sure how much it affects the `const` functions, since they're already
evaluated at compile-time.

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

