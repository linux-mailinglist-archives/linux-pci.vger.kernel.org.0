Return-Path: <linux-pci+bounces-41309-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2D1C60AE4
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 21:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 434113A6338
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 20:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A784B18AFD;
	Sat, 15 Nov 2025 20:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="F8oR5aqh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6F120A5F3
	for <linux-pci@vger.kernel.org>; Sat, 15 Nov 2025 20:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763239649; cv=none; b=s02Lq0DNbhrCQ7Mmm+2Zh7iAtL9A9mHwheEe7nKq/4dzr/6D2s3qwjw1PrTNvgxxHLWvrX6tIWwJWKcLbhBMjdpCgOuULkWIaNW78Zke8ScGFeTyISn9RPGhxi7aB4j6W3MNTuIsf1a15oQnMQ8Qsn7/WsBm2mLTz3V3dm0t7Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763239649; c=relaxed/simple;
	bh=OHnaCkTuVuLcfUq57Xjj7ErFMsGvwUwS4qG/Xalb0ZI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ma0opajfX9vTkHsp31OmIZDxYLXM9TyaBZ5PECTZyYeS2x99OmRR8brUZPb/7WP47+P9x0jCg+c5aL24mgholjnlUQlxUK2AOk/gGRgyPSmDQuMdZhYKD8/GB0cgy8IM6uDmCMxC0KLOrQdq1fqU0SIBD+AgeUww8M66U8j1Kf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=F8oR5aqh; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id B6C9A240104
	for <linux-pci@vger.kernel.org>; Sat, 15 Nov 2025 21:47:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1763239645; bh=73ocHBkI0eBhzEKX+v5Uv0IQ/W/SAiBzOk2ySE6M2uM=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:OpenPGP:From;
	b=F8oR5aqhwUah3BSF4Y3XL+RjB0ZkAv54OipN4/wcIbH7rx7oGbvHcrLDW6tIvFAFm
	 kyoYxHO20wtlFx2MPPfyV94Rs3jpwhzb1v7tryu6BuIcts0kTZOdoyQjld3J+y8QiR
	 KI0VGiiyi97RCepSXs+VMiD6a0P8DsHGA5uENW5uHPOMmQqZnMFNGDTaSKRf5ACnxK
	 NDFe8W97sLNp0gdw5xSpplxAlzkfFNs1Nx36dxiGueU7q+2g6cxTK8jH2kRSfcTe+T
	 DXNxcDl2kBbRgPAi+gUNwhcHVC8HDpPTNDUrttaNgmBbCt367G5b4MXZu+qPOZ/Sh7
	 99rSphSRNVk5Q==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4d85ff5yk7z9rxN;
	Sat, 15 Nov 2025 21:47:22 +0100 (CET)
Message-ID: <96672eb9779a7b1c0a51775da153a85014da5615.camel@posteo.de>
Subject: Re: [PATCH v8 4/4] rust: leds: add multicolor classdev abstractions
From: Markus Probst <markus.probst@posteo.de>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman
 <david.m.ertman@intel.com>, Ira Weiny	 <ira.weiny@intel.com>, Leon
 Romanovsky <leon@kernel.org>, Miguel Ojeda	 <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Boqun Feng	 <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>,  =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross	 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 "Rafael J. Wysocki"	 <rafael@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=	
 <kwilczynski@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Date: Sat, 15 Nov 2025 20:47:24 +0000
In-Reply-To: <20251115-rust_leds-v8-4-d9a41f355538@posteo.de>
References: <20251115-rust_leds-v8-0-d9a41f355538@posteo.de>
	 <20251115-rust_leds-v8-4-d9a41f355538@posteo.de>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 R3rOFHA==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

On Sat, 2025-11-15 at 17:26 +0000, Markus Probst wrote:
> Implement the abstractions needed for multicolor led class devices,
> including:
>=20
> * `led::MultiColor` - the led mode implementation
>=20
> * `MultiColorSubLed` - a safe wrapper arround `mc_subled`
>=20
> * `led::Device::new_multicolor()` - the function to register a multicolor
>   led class device
>=20
> * `led::Device::subleds()` - the function to access the brightness and
>   intensity of the individual sub leds
>=20
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
>  rust/bindings/bindings_helper.h |   1 +
>  rust/kernel/led.rs              |   7 +-
>  rust/kernel/led/multicolor.rs   | 195 ++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 202 insertions(+), 1 deletion(-)
>=20
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 2e43c66635a2..ba8605eeecce 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -61,6 +61,7 @@
>  #include <linux/ioport.h>
>  #include <linux/jiffies.h>
>  #include <linux/jump_label.h>
> +#include <linux/led-class-multicolor.h>
>  #include <linux/mdio.h>
>  #include <linux/mm.h>
>  #include <linux/miscdevice.h>
> diff --git a/rust/kernel/led.rs b/rust/kernel/led.rs
> index c55f9852d378..4add9d15a5e0 100644
> --- a/rust/kernel/led.rs
> +++ b/rust/kernel/led.rs
> @@ -44,8 +44,12 @@
>      }, //
>  };
> =20
> +#[cfg(CONFIG_LEDS_CLASS_MULTICOLOR)]
> +mod multicolor;
>  mod normal;
> =20
> +#[cfg(CONFIG_LEDS_CLASS_MULTICOLOR)]
> +pub use multicolor::{MultiColor, MultiColorSubLed};
>  pub use normal::Normal;
> =20
>  /// The led class device representation.
> @@ -288,7 +292,8 @@ fn try_from(value: u32) -> core::result::Result<Self,=
 Self::Error> {
>  ///
>  /// Each led mode has its own led class device type with different capab=
ilities.
>  ///
> -/// See [`Normal`].
> +#[cfg_attr(CONFIG_LEDS_CLASS_MULTICOLOR, doc =3D "See [`Normal`] and [`M=
ultiColor`].")]
> +#[cfg_attr(not(CONFIG_LEDS_CLASS_MULTICOLOR), doc =3D "See [`Normal`] an=
d `MultiColor`.")]
>  pub trait Mode: private::Mode {}
> =20
>  impl<T: private::Mode> Mode for T {}
> diff --git a/rust/kernel/led/multicolor.rs b/rust/kernel/led/multicolor.r=
s
> new file mode 100644
> index 000000000000..3afefaef6498
> --- /dev/null
> +++ b/rust/kernel/led/multicolor.rs
> @@ -0,0 +1,195 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Led mode for the `struct led_classdev_mc`.
> +//!
> +//! C header: [`include/linux/led-class-multicolor.h`](srctree/include/l=
inux/led-class-multicolor.h)
> +
> +use crate::{
> +    alloc::KVec,
> +    error::code::EINVAL,
> +    prelude::*, //
> +};
> +
> +use super::*;
> +
> +/// The led mode for the `struct led_classdev_mc`. Leds with this mode c=
an have multiple colors.
> +pub enum MultiColor {}
> +
> +/// The multicolor sub led info representation.
> +///
> +/// This structure represents the Rust abstraction for a C `struct mc_su=
bled`.
> +#[repr(C)]
> +#[derive(Copy, Clone, Debug)]
> +pub struct MultiColorSubLed {
> +    /// the color of the sub led
> +    pub color: Color,
> +    /// the brightness of the sub led.
> +    ///
> +    /// The value will be automatically calculated.
> +    /// See `MultiColor::pre_brightness_set`.
> +    pub brightness: u32,
> +    /// the intensity of the sub led.
> +    pub intensity: u32,
> +    /// arbitrary data for the driver to store.
> +    pub channel: u32,
> +    _p: PhantomData<()>, // Only allow creation with `MultiColorSubLed::=
new`.
> +}
> +
> +// We directly pass a reference to the `subled_info` field in `led_class=
dev_mc` to the driver via
> +// `Device::subleds()`.
> +// We need safeguards to ensure `MultiColorSubLed` and `mc_subled` stay =
identical.
> +const _: () =3D {
> +    use core::mem::offset_of;
> +
> +    const fn assert_same_type<T>(_: &T, _: &T) {}
> +
> +    let rust_zeroed =3D MultiColorSubLed {
> +        color: Color::White,
> +        brightness: 0,
> +        intensity: 0,
> +        channel: 0,
> +        _p: PhantomData,
> +    };
> +    let c_zeroed =3D bindings::mc_subled {
> +        color_index: 0,
> +        brightness: 0,
> +        intensity: 0,
> +        channel: 0,
> +    };
> +
> +    assert!(offset_of!(MultiColorSubLed, color) =3D=3D offset_of!(bindin=
gs::mc_subled, color_index));
> +    assert_same_type(&0u32, &c_zeroed.color_index);
> +
> +    assert!(
> +        offset_of!(MultiColorSubLed, brightness) =3D=3D offset_of!(bindi=
ngs::mc_subled, brightness)
> +    );
> +    assert_same_type(&rust_zeroed.brightness, &c_zeroed.brightness);
> +
> +    assert!(offset_of!(MultiColorSubLed, intensity) =3D=3D offset_of!(bi=
ndings::mc_subled, intensity));
> +    assert_same_type(&rust_zeroed.intensity, &c_zeroed.intensity);
> +
> +    assert!(offset_of!(MultiColorSubLed, channel) =3D=3D offset_of!(bind=
ings::mc_subled, channel));
> +    assert_same_type(&rust_zeroed.channel, &c_zeroed.channel);
> +
> +    assert!(size_of::<MultiColorSubLed>() =3D=3D size_of::<bindings::mc_=
subled>());
> +};
> +
> +impl MultiColorSubLed {
> +    /// Create a new multicolor sub led info.
> +    pub fn new(color: Color) -> Self {
> +        Self {
> +            color,
> +            brightness: 0,
> +            intensity: 0,
> +            channel: 0,
> +            _p: PhantomData,
> +        }
> +    }
> +
> +    /// Set arbitrary data for the driver.
> +    pub fn channel(mut self, channel: u32) -> Self {
> +        self.channel =3D channel;
> +        self
> +    }
> +
> +    /// Set the initial intensity of the subled.
> +    pub fn initial_intensity(mut self, intensity: u32) -> Self {
> +        self.intensity =3D intensity;
> +        self
> +    }
> +}
All functions in `MultiColorSubLed` will be const in the next patch
iteration.

Thanks
- Markus Probst

> +
> +impl private::Mode for MultiColor {
> +    type Type =3D bindings::led_classdev_mc;
> +    const REGISTER: RegisterFunc<Self::Type> =3D bindings::led_classdev_=
multicolor_register_ext;
> +    const UNREGISTER: UnregisterFunc<Self::Type> =3D bindings::led_class=
dev_multicolor_unregister;
> +
> +    unsafe fn device<'a>(raw: *mut Self::Type) -> &'a device::Device {
> +        // SAFETY:
> +        // - The function's contract guarantees that `raw` is a valid po=
inter to `led_classdev`.
> +        unsafe { device::Device::from_raw((*raw).led_cdev.dev) }
> +    }
> +
> +    unsafe fn from_classdev(led_cdev: *mut bindings::led_classdev) -> *m=
ut Self::Type {
> +        // SAFETY: The function's contract guarantees that `led_cdev` is=
 a valid pointer to
> +        // `led_classdev` embedded within a `Self::Type`.
> +        unsafe { container_of!(led_cdev, bindings::led_classdev_mc, led_=
cdev) }
> +    }
> +
> +    unsafe fn pre_brightness_set(raw: *mut Self::Type, brightness: u32) =
{
> +        // SAFETY: The function's contract guarantees that `raw` is a va=
lid pointer to
> +        // `led_classdev_mc`.
> +        unsafe { bindings::led_mc_calc_color_components(raw, brightness)=
 };
> +    }
> +
> +    fn release(led_cdev: &mut Self::Type) {
> +        // SAFETY: `subled_info` is guaranteed to be a valid array point=
er to `mc_subled` with the
> +        // length and capacity of `led_cdev.num_colors`. See `led::Devic=
e::new_multicolor`.
> +        let _subleds_vec =3D unsafe {
> +            KVec::from_raw_parts(
> +                led_cdev.subled_info,
> +                led_cdev.num_colors as usize,
> +                led_cdev.num_colors as usize,
> +            )
> +        };
> +    }
> +}
> +
> +impl<T: LedOps<Mode =3D MultiColor>> Device<T> {
> +    /// Registers a new multicolor led classdev.
> +    ///
> +    /// The [`Device`] will be unregistered on drop.
> +    pub fn new_multicolor<'a>(
> +        parent: &'a T::Bus,
> +        init_data: InitData<'a>,
> +        ops: T,
> +        subleds: &'a [MultiColorSubLed],
> +    ) -> impl PinInit<Devres<Self>, Error> + 'a {
> +        assert!(subleds.len() <=3D u32::MAX as usize);
> +        Self::__new(parent, init_data, ops, |led_cdev| {
> +            let mut subleds_vec =3D KVec::new();
> +            subleds_vec.extend_from_slice(subleds, GFP_KERNEL)?;
> +            let (subled_info, num_colors, capacity) =3D subleds_vec.into=
_raw_parts();
> +            debug_assert_eq!(num_colors, capacity);
> +
> +            let mut used =3D 0;
> +            if subleds.iter().any(|subled| {
> +                let bit =3D 1 << (subled.color as u32);
> +                if (used & bit) !=3D 0 {
> +                    true
> +                } else {
> +                    used |=3D bit;
> +                    false
> +                }
> +            }) {
> +                dev_err!(parent.as_ref(), "duplicate color in multicolor=
 led\n");
> +                return Err(EINVAL);
> +            }
> +
> +            Ok(bindings::led_classdev_mc {
> +                led_cdev,
> +                // CAST: We checked above that the length of subleds fit=
s into a u32.
> +                num_colors: num_colors as u32,
> +                // CAST: The safeguards in the const block ensure that `=
MultiColorSubLed` has an
> +                // identical layout to `mc_subled`.
> +                subled_info: subled_info.cast::<bindings::mc_subled>(),
> +            })
> +        })
> +    }
> +
> +    /// Returns the subleds passed to [`Device::new_multicolor`].
> +    pub fn subleds(&self) -> &[MultiColorSubLed] {
> +        // SAFETY: The existence of `self` guarantees that `self.classde=
v.get()` is a pointer to a
> +        // valid `led_classdev_mc`.
> +        let raw =3D unsafe { &*self.classdev.get() };
> +        // SAFETY: `raw.subled_info` is a valid pointer to `mc_subled[nu=
m_colors]`.
> +        // CAST: The safeguards in the const block ensure that `MultiCol=
orSubLed` has an identical
> +        // layout to `mc_subled`.
> +        unsafe {
> +            core::slice::from_raw_parts(
> +                raw.subled_info.cast::<MultiColorSubLed>(),
> +                raw.num_colors as usize,
> +            )
> +        }
> +    }
> +}

