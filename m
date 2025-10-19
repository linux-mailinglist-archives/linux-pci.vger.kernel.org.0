Return-Path: <linux-pci+bounces-38676-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 63008BEE710
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 16:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 58D444E21B8
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 14:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B84A258EE9;
	Sun, 19 Oct 2025 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MP03uqEj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162CF2459EA;
	Sun, 19 Oct 2025 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760884128; cv=none; b=uuje19fGo6gsunfKZX4qwT2ZefmT1Gm1QG4pq/JBY5Vb0j1uV2UrFAscFe+76adm4d3gXEbY5aL4Z8fzjTH90sIzKY2oLTORdNAohwciWEGbATr+OciaD6NGllazg0PSNypZ9/N1loTh4+1TdUYq3r3IRSNjD1vPneXmf2YPZig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760884128; c=relaxed/simple;
	bh=2Lk3VteT5ZUYtGV3L7w6wKgSGuoqrZ/lGhL+exIXDm8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=Cc8IFpNXVqlSEP9dMgyjZwMJehP0YGanSKe0P+61FC3S4dpZqPLzi+CsytLqjvp0UZ9dwbzEjxc+CtZ4rBPECe2y0bmT4m/RjJrVLiUP95ctmTM+jnJKAMmVY9p2jpEeC5o1w2Ks2cvTDzafhx/H34NuoGb3GdqQM2N3tlIFxI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MP03uqEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4830C4CEE7;
	Sun, 19 Oct 2025 14:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760884127;
	bh=2Lk3VteT5ZUYtGV3L7w6wKgSGuoqrZ/lGhL+exIXDm8=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=MP03uqEjX3dT3tNfORhl0l847PRKqtZ5CKZZ6jtJVg/gObj2g3axOfyuXJAOL/CCd
	 6et/er0QZsqeHeYSpFjj4gs7GCC/aN27fEpcA19izrrOOWBG6ctcuB4LNj6bo/64A+
	 sLqp8CaLTIL7U1AU7IiuLT2oy/5MyqMyseRFgC1e54qOl27t6crh33k2F03oekgIWB
	 SqylejnRdM1buwwgRTLQxtvicZHCu+9a2mLXT0EUTFLlyOuOYnn2gMZJsSK0+q8HLQ
	 +bHhisezI8jZ+1eNnQnFqoNFtxSfVA2NgUUI9onNLltSFLTzrn+lhexkX0rX3mrp8x
	 bDxQ2guleBZ2g==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 19 Oct 2025 16:28:40 +0200
Message-Id: <DDMDBPDZHN6G.KI90E7ZWWX39@kernel.org>
To: "Markus Probst" <markus.probst@posteo.de>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v5 1/2] rust: Add trait to convert a device reference to
 a bus device reference
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, "Igor Korotin"
 <igor.korotin.linux@gmail.com>, "Lee Jones" <lee@kernel.org>, "Pavel
 Machek" <pavel@kernel.org>, "Dave Ertman" <david.m.ertman@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, "Leon Romanovsky" <leon@kernel.org>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Bjorn Helgaas" <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-leds@vger.kernel.org>
References: <20251018205912.1528811-1-markus.probst@posteo.de>
 <20251018205912.1528811-2-markus.probst@posteo.de>
In-Reply-To: <20251018205912.1528811-2-markus.probst@posteo.de>

On Sat Oct 18, 2025 at 10:59 PM CEST, Markus Probst wrote:
> Implement the `IntoBusDevice` trait for converting a `Device` reference t=
o a
> bus device reference for all bus devices. `Device` implements this trait =
as a
> fallback.
>
> The `IntoBusDevice` trait allows abstractions to provide the bus device i=
n
> class device callbacks.
>
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
>  rust/kernel/auxiliary.rs |  7 +++++++
>  rust/kernel/device.rs    | 41 ++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/i2c.rs       |  7 +++++++

i2c is not upstream yet, hence it should not be part of this patch. Instead=
 you
should include the platform bus though.

>  rust/kernel/pci.rs       |  7 +++++++
>  rust/kernel/usb.rs       |  6 ++++++
>  5 files changed, 68 insertions(+)
>
> diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
> index e11848bbf206..dea24265f549 100644
> --- a/rust/kernel/auxiliary.rs
> +++ b/rust/kernel/auxiliary.rs
> @@ -15,6 +15,7 @@
>  };
>  use core::{
>      marker::PhantomData,
> +    mem::offset_of,
>      ptr::{addr_of_mut, NonNull},
>  };
> =20
> @@ -239,6 +240,12 @@ extern "C" fn release(dev: *mut bindings::device) {
>      }
>  }
> =20
> +// SAFETY: `auxilary::Device` is a transparent wrapper of `struct auxili=
ary_device`.
> +// The offset is guaranteed to point to a valid device field inside `aux=
ilary::Device`.
> +unsafe impl<Ctx: device::DeviceContext> device::IntoBusDevice<Ctx> for D=
evice<Ctx> {
> +    const OFFSET: usize =3D offset_of!(bindings::auxiliary_device, dev);
> +}
> +
>  // SAFETY: `Device` is a transparent wrapper of a type that doesn't depe=
nd on `Device`'s generic
>  // argument.
>  kernel::impl_device_context_deref!(unsafe { Device });
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index 1321e6f0b53c..5527854a195f 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -511,6 +511,47 @@ impl DeviceContext for Core {}
>  impl DeviceContext for CoreInternal {}
>  impl DeviceContext for Normal {}
> =20
> +/// Bus devices can implement this trait to allow abstractions to provid=
e the bus device in
> +/// class device callbacks.
> +///
> +/// # Safety
> +///
> +/// `IntoBusDevice::OFFSET` must be a offset to a device field in the im=
plemented struct.

I think we should also require that this must only be implemented by bus de=
vice
types.

> +pub(crate) unsafe trait IntoBusDevice<Ctx: DeviceContext>:
> +    AsRef<Device<Ctx>>

We should probably name this AsBusDevice.

> +{
> +    /// The relative offset to the device field.
> +    ///
> +    /// Use `offset_of!(bindings, field)` macro to avoid breakage.
> +    const OFFSET: usize;
> +
> +    /// Convert a reference to [`Device`] into `Self`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `dev` must be contained in `Self`.
> +    unsafe fn from_device(dev: &Device<Ctx>) -> &Self

As mentioned in the other thread, my concern remains that this could be abu=
sed
by drivers.

For now the trait is pub(crate), but with the new build system coming soon,
we're able to split things out of the kernel crate, and hence bus abstracti=
ons
and driver-core code may end up in different crates requiring this to becom=
e
public.

We should at least document that this must not be used by drivers and is
intended for bus and class device abstractions only.

> +    where
> +        Self: Sized,
> +    {
> +        let raw =3D dev.as_raw();
> +        // SAFETY: `raw - Self::OFFSET` is guaranteed by the safety requ=
irements
> +        // to be a valid pointer to `Self`.
> +        unsafe { &*raw.byte_sub(Self::OFFSET).cast::<Self>() }
> +    }
> +}
> +
> +// SAFETY: `Device` is a transparent wrapper of `device`.
> +unsafe impl<Ctx: DeviceContext> IntoBusDevice<Ctx> for Device<Ctx> {
> +    const OFFSET: usize =3D 0;
> +}

A generic device is not guaranteed to be a bus device. Also, I don't see a
reason why class device abstractions would want to work with a generic devi=
ce
rather than the actual bus device parent. Hence, let's drop this impl.

