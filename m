Return-Path: <linux-pci+bounces-41310-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D932DC60AED
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 21:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 909883AD702
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 20:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C861F4613;
	Sat, 15 Nov 2025 20:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="Tf5IYlEB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EA822756A
	for <linux-pci@vger.kernel.org>; Sat, 15 Nov 2025 20:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763239741; cv=none; b=hQk68B1N1hDNXunlvmdl9SzTJqyWFYhY+ec0bJJt1dqrjYMZfmVxY/sFj+bI52kjXzahgv2HyPxDA2r3OkpDR6W8Zje7epxOCXKUR0fYB1XasSQzPP1l6kbSaokenJBGLKxFqV4ZQgdyEEZaI/9Dzin4ggZViNf1irTERoHgUEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763239741; c=relaxed/simple;
	bh=sQYZGJsQRRd1QMTcBNirlxNEL5Xs9dHfnnqarMnqjn4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cvMlQ4D1x3TYQx/yMIA6sKRikbUEyzQKI98/QUbvlwC5d/n3Qs5EQk2jV3AnABFjG55URSoRai3ZRULZ6KtGpEDPJ7vlNNp5ug+WS8vEe/+R6yu4mfv+XVt9qNnOP+BtVmqmMhTq/XkHNprKNRoJtCtT2VynU+e5HYfBetnb9dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=Tf5IYlEB; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 8AB7A240109
	for <linux-pci@vger.kernel.org>; Sat, 15 Nov 2025 21:48:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1763239737; bh=zk4TGvGAtJdN0xZe2iibjM9r66Fae4Cco1M/d9junsk=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:OpenPGP:From;
	b=Tf5IYlEB4medrpo2eui39wbEaGoNZ0vVdPDjeysJLIN7+mfYMRluPJJz4un2r1SM9
	 MwEbyckI/Gggd1yUnsKyQ8bkpuILUVHLQKHDpbU651FE+enPA1LUuBnmqZ/G+gKhBV
	 QLCW0eaBbDs5QxKj4kn/CNDgymlPXuyXznU0KYqbyGKeF2HNw9i7lKo3igRzxaWhip
	 q3TXzI49yClt1jhrj4DzohJeqmYgXjhBDEaRVIMrNaSqQsR0sUF5yY27m/qb3U1/rz
	 WKaiZ8Vp7mJoY9KZATH3fqnf6PCn3o+csXGI2U1KMtZs+wp00eVGOuI/nfL6eZvmsS
	 O6tq4ZnKrpN4w==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4d85hR17rxz9rwn;
	Sat, 15 Nov 2025 21:48:55 +0100 (CET)
Message-ID: <9efcbdf770b41eea9a38f4d10b1c9859b05152a6.camel@posteo.de>
Subject: Re: [PATCH v8 2/4] rust: leds: add basic led classdev abstractions
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
Date: Sat, 15 Nov 2025 20:48:56 +0000
In-Reply-To: <20251115-rust_leds-v8-2-d9a41f355538@posteo.de>
References: <20251115-rust_leds-v8-0-d9a41f355538@posteo.de>
	 <20251115-rust_leds-v8-2-d9a41f355538@posteo.de>
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
> Implement the core abstractions needed for led class devices, including:
>=20
> * `led::LedOps` - the trait for handling leds, including
>   `brightness_set`, `brightness_get` and `blink_set`
>=20
> * `led::InitData` - data set for the led class device
>=20
> * `led::Device` - a safe wrapper around `led_classdev`
>=20
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
>  MAINTAINERS        |   7 +
>  rust/kernel/led.rs | 477 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  rust/kernel/lib.rs |   1 +
>  3 files changed, 485 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ddecf1ef3bed..2d66db23a63b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14104,6 +14104,13 @@ F:	drivers/leds/
>  F:	include/dt-bindings/leds/
>  F:	include/linux/leds.h
> =20
> +LED SUBSYSTEM [RUST]
> +M:	Markus Probst <markus.probst@posteo.de>
> +L:	linux-leds@vger.kernel.org
> +L:	rust-for-linux@vger.kernel.org
> +S:	Maintained
> +F:	rust/kernel/led.rs
> +
>  LEGO MINDSTORMS EV3
>  R:	David Lechner <david@lechnology.com>
>  S:	Maintained
> diff --git a/rust/kernel/led.rs b/rust/kernel/led.rs
> new file mode 100644
> index 000000000000..4c1b72c998e1
> --- /dev/null
> +++ b/rust/kernel/led.rs
> @@ -0,0 +1,477 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Abstractions for the leds driver model.
> +//!
> +//! C header: [`include/linux/leds.h`](srctree/include/linux/leds.h)
> +
> +use core::{
> +    marker::PhantomData,
> +    mem::transmute,
> +    pin::Pin,
> +    ptr::NonNull, //
> +};
> +
> +use pin_init::{
> +    pin_data,
> +    pinned_drop,
> +    PinInit, //
> +};
> +
> +use crate::{
> +    build_error,
> +    container_of,
> +    device::{
> +        self,
> +        property::FwNode,
> +        AsBusDevice,
> +        Bound, //
> +    },
> +    devres::Devres,
> +    error::{
> +        code::EINVAL,
> +        from_result,
> +        to_result,
> +        Error,
> +        Result,
> +        VTABLE_DEFAULT_ERROR, //
> +    },
> +    macros::vtable,
> +    str::CStr,
> +    try_pin_init,
> +    types::{
> +        ARef,
> +        Opaque, //
> +    }, //
> +};
> +
> +/// The led class device representation.
> +///
> +/// This structure represents the Rust abstraction for a C `struct led_c=
lassdev`.
> +#[pin_data(PinnedDrop)]
> +pub struct Device<T: LedOps> {
> +    ops: T,
> +    #[pin]
> +    classdev: Opaque<bindings::led_classdev>,
> +}
> +
> +/// The led init data representation.
> +///
> +/// This structure represents the Rust abstraction for a C `struct led_i=
nit_data` with additional
> +/// fields from `struct led_classdev`.
> +#[derive(Default)]
> +pub struct InitData<'a> {
> +    fwnode: Option<&'a FwNode>,
> +    default_label: Option<&'a CStr>,
> +    devicename: Option<&'a CStr>,
> +    devname_mandatory: bool,
> +    initial_brightness: u32,
> +    default_trigger: Option<&'a CStr>,
> +    color: Color,
> +}
> +
> +impl InitData<'static> {
> +    /// Creates a new [`InitData`]
> +    pub fn new() -> Self {
> +        Self::default()
> +    }
> +}
> +
> +impl<'a> InitData<'a> {
> +    /// Sets the firmware node
> +    pub fn fwnode(self, fwnode: &'a FwNode) -> Self {
> +        InitData {
> +            fwnode: Some(fwnode),
> +            ..self
> +        }
> +    }
`led::InitData::fwnode()` will accept a `Option<ARef<Fwnode>>` as
parameter instead in the next patch iteration. This is the same type
returned by `Fwnode::get_child_by_name()`.

Thanks
- Markus Probst
> +
> +    /// Sets a default label
> +    pub fn default_label(self, label: &'a CStr) -> Self {
> +        InitData {
> +            default_label: Some(label),
> +            ..self
> +        }
> +    }
> +
> +    /// Sets the device name
> +    pub fn devicename(self, devicename: &'a CStr) -> Self {
> +        Self {
> +            devicename: Some(devicename),
> +            ..self
> +        }
> +    }
> +
> +    /// Sets if a device name is mandatory
> +    pub fn devicename_mandatory(self, mandatory: bool) -> Self {
> +        Self {
> +            devname_mandatory: mandatory,
> +            ..self
> +        }
> +    }
> +
> +    /// Sets the initial brightness value for the led
> +    ///
> +    /// The default brightness is 0.
> +    /// If [`LedOps::brightness_get`] is implemented, this value will be=
 ignored.
> +    pub fn initial_brightness(self, brightness: u32) -> Self {
> +        Self {
> +            initial_brightness: brightness,
> +            ..self
> +        }
> +    }
> +
> +    /// Set the default led trigger
> +    ///
> +    /// This value can be overwritten by the "linux,default-trigger" fwn=
ode property.
> +    pub fn default_trigger(self, trigger: &'a CStr) -> Self {
> +        Self {
> +            default_trigger: Some(trigger),
> +            ..self
> +        }
> +    }
> +
> +    /// Sets the color of the led
> +    ///
> +    /// This value can be overwritten by the "color" fwnode property.
> +    pub fn color(self, color: Color) -> Self {
> +        Self { color, ..self }
> +    }
> +}
> +
> +/// Trait defining the operations for a LED driver.
> +///
> +/// # Examples
> +///
> +///```
> +/// # use kernel::{
> +/// #     c_str, device, devres::Devres,
> +/// #     error::Result, led,
> +/// #     macros::vtable, platform, prelude::*,
> +/// # };
> +/// # use core::pin::Pin;
> +///
> +/// struct MyLedOps;
> +///
> +///
> +/// #[vtable]
> +/// impl led::LedOps for MyLedOps {
> +///     type Bus =3D platform::Device<device::Bound>;
> +///     const BLOCKING: bool =3D false;
> +///     const MAX_BRIGHTNESS: u32 =3D 255;
> +///
> +///     fn brightness_set(
> +///         &self,
> +///         _dev: &platform::Device<device::Bound>,
> +///         _classdev: &led::Device<Self>,
> +///         _brightness: u32
> +///     ) -> Result<()> {
> +///         // Set the brightness for the led here
> +///         Ok(())
> +///     }
> +/// }
> +///
> +/// fn register_my_led(
> +///     parent: &platform::Device<device::Bound>,
> +/// ) -> Result<Pin<KBox<Devres<led::Device<MyLedOps>>>>> {
> +///     KBox::pin_init(led::Device::new(
> +///         parent,
> +///         led::InitData::new()
> +///             .default_label(c_str!("my_led")),
> +///         MyLedOps,
> +///     ), GFP_KERNEL)
> +/// }
> +///```
> +/// Led drivers must implement this trait in order to register and handl=
e a [`Device`].
> +#[vtable]
> +pub trait LedOps: Send + 'static + Sized {
> +    /// The bus device required by the implementation.
> +    #[allow(private_bounds)]
> +    type Bus: AsBusDevice<Bound>;
> +    /// If set true, [`LedOps::brightness_set`] and [`LedOps::blink_set`=
] must perform the
> +    /// operation immediately. If set false, they must not sleep.
> +    const BLOCKING: bool;
> +    /// The max brightness level
> +    const MAX_BRIGHTNESS: u32;
> +
> +    /// Sets the brightness level.
> +    ///
> +    /// See also [`LedOps::BLOCKING`].
> +    fn brightness_set(
> +        &self,
> +        dev: &Self::Bus,
> +        classdev: &Device<Self>,
> +        brightness: u32,
> +    ) -> Result<()>;
> +
> +    /// Gets the current brightness level.
> +    fn brightness_get(&self, _dev: &Self::Bus, _classdev: &Device<Self>)=
 -> u32 {
> +        build_error!(VTABLE_DEFAULT_ERROR)
> +    }
> +
> +    /// Activates hardware accelerated blinking.
> +    ///
> +    /// delays are in milliseconds. If both are zero, a sensible default=
 should be chosen.
> +    /// The caller should adjust the timings in that case and if it can'=
t match the values
> +    /// specified exactly. Setting the brightness to 0 will disable the =
hardware accelerated
> +    /// blinking.
> +    ///
> +    /// See also [`LedOps::BLOCKING`].
> +    fn blink_set(
> +        &self,
> +        _dev: &Self::Bus,
> +        _classdev: &Device<Self>,
> +        _delay_on: &mut usize,
> +        _delay_off: &mut usize,
> +    ) -> Result<()> {
> +        build_error!(VTABLE_DEFAULT_ERROR)
> +    }
> +}
> +
> +/// Led colors.
> +#[derive(Copy, Clone, Debug, Default)]
> +#[repr(u32)]
> +#[non_exhaustive]
> +#[expect(
> +    missing_docs,
> +    reason =3D "it shouldn't be necessary to document each color"
> +)]
> +pub enum Color {
> +    #[default]
> +    White =3D bindings::LED_COLOR_ID_WHITE,
> +    Red =3D bindings::LED_COLOR_ID_RED,
> +    Green =3D bindings::LED_COLOR_ID_GREEN,
> +    Blue =3D bindings::LED_COLOR_ID_BLUE,
> +    Amber =3D bindings::LED_COLOR_ID_AMBER,
> +    Violet =3D bindings::LED_COLOR_ID_VIOLET,
> +    Yellow =3D bindings::LED_COLOR_ID_YELLOW,
> +    Ir =3D bindings::LED_COLOR_ID_IR,
> +    Multi =3D bindings::LED_COLOR_ID_MULTI,
> +    Rgb =3D bindings::LED_COLOR_ID_RGB,
> +    Purple =3D bindings::LED_COLOR_ID_PURPLE,
> +    Orange =3D bindings::LED_COLOR_ID_ORANGE,
> +    Pink =3D bindings::LED_COLOR_ID_PINK,
> +    Cyan =3D bindings::LED_COLOR_ID_CYAN,
> +    Lime =3D bindings::LED_COLOR_ID_LIME,
> +}
> +
> +impl TryFrom<u32> for Color {
> +    type Error =3D Error;
> +
> +    fn try_from(value: u32) -> core::result::Result<Self, Self::Error> {
> +        const _: () =3D {
> +            assert!(bindings::LED_COLOR_ID_MAX =3D=3D 15);
> +        };
> +        if value < bindings::LED_COLOR_ID_MAX {
> +            // SAFETY:
> +            // - `Color` is represented as `u32`
> +            // - the const block above guarantees that no additional col=
or has been added
> +            // - `value` is guaranteed to be in the color id range
> +            Ok(unsafe { transmute::<u32, Color>(value) })
> +        } else {
> +            Err(EINVAL)
> +        }
> +    }
> +}
> +
> +// SAFETY: A `led::Device` can be unregistered from any thread.
> +unsafe impl<T: LedOps + Send> Send for Device<T> {}
> +
> +// SAFETY: `led::Device` can be shared among threads because all methods=
 of `led::Device`
> +// are thread safe.
> +unsafe impl<T: LedOps + Sync> Sync for Device<T> {}
> +
> +impl<T: LedOps> Device<T> {
> +    /// Registers a new led classdev.
> +    ///
> +    /// The [`Device`] will be unregistered on drop.
> +    pub fn new<'a>(
> +        parent: &'a T::Bus,
> +        init_data: InitData<'a>,
> +        ops: T,
> +    ) -> impl PinInit<Devres<Self>, Error> + 'a {
> +        Devres::new(
> +            parent.as_ref(),
> +            try_pin_init!(Self {
> +                ops,
> +                classdev <- Opaque::try_ffi_init(|ptr: *mut bindings::le=
d_classdev| {
> +                    // SAFETY: `try_ffi_init` guarantees that `ptr` is v=
alid for write.
> +                    // `led_classdev` gets fully initialized in-place by
> +                    // `led_classdev_register_ext` including `mutex` and=
 `list_head`.
> +                    unsafe {
> +                        ptr.write(bindings::led_classdev {
> +                            brightness_set: (!T::BLOCKING)
> +                                .then_some(Adapter::<T>::brightness_set_=
callback),
> +                            brightness_set_blocking: T::BLOCKING
> +                                .then_some(Adapter::<T>::brightness_set_=
blocking_callback),
> +                            brightness_get: T::HAS_BRIGHTNESS_GET
> +                                .then_some(Adapter::<T>::brightness_get_=
callback),
> +                            blink_set: T::HAS_BLINK_SET.then_some(Adapte=
r::<T>::blink_set_callback),
> +                            max_brightness: T::MAX_BRIGHTNESS,
> +                            brightness: init_data.initial_brightness,
> +                            default_trigger: init_data.default_trigger
> +                                .map_or(core::ptr::null(), CStr::as_char=
_ptr),
> +                            color: init_data.color as u32,
> +                            ..bindings::led_classdev::default()
> +                        })
> +                    };
> +
> +                    let fwnode =3D init_data.fwnode.map(ARef::from);
> +
> +                    let mut init_data =3D bindings::led_init_data {
> +                        fwnode: fwnode
> +                            .as_ref()
> +                            .map_or(core::ptr::null_mut(), |fwnode| fwno=
de.as_raw()),
> +                        default_label: init_data
> +                            .default_label
> +                            .map_or(core::ptr::null(), CStr::as_char_ptr=
),
> +                        devicename: init_data
> +                            .devicename
> +                            .map_or(core::ptr::null(), CStr::as_char_ptr=
),
> +                        devname_mandatory: init_data.devname_mandatory,
> +                    };
> +
> +                    // SAFETY:
> +                    // - `parent.as_raw()` is guaranteed to be a pointer=
 to a valid `device`
> +                    //    or a null pointer.
> +                    // - `ptr` is guaranteed to be a pointer to an initi=
alized `led_classdev`.
> +                    to_result(unsafe {
> +                        bindings::led_classdev_register_ext(
> +                            parent.as_ref().as_raw(),
> +                            ptr,
> +                            &mut init_data,
> +                        )
> +                    })?;
> +
> +                    core::mem::forget(fwnode); // keep the reference cou=
nt incremented
> +
> +                    Ok::<_, Error>(())
> +                }),
> +            }),
> +        )
> +    }
> +
> +    /// # Safety
> +    /// `led_cdev` must be a valid pointer to a `led_classdev` embedded =
within a
> +    /// `led::Device`.
> +    unsafe fn from_raw<'a>(led_cdev: *mut bindings::led_classdev) -> &'a=
 Self {
> +        // SAFETY: The function's contract guarantees that `led_cdev` po=
ints to a `led_classdev`
> +        // field embedded within a valid `led::Device`. `container_of!` =
can therefore
> +        // safely calculate the address of the containing struct.
> +        unsafe { &*container_of!(Opaque::cast_from(led_cdev), Self, clas=
sdev) }
> +    }
> +
> +    fn parent(&self) -> &device::Device<Bound> {
> +        // SAFETY:
> +        // - `self.classdev.get()` is guaranteed to be a valid pointer t=
o `led_classdev`.
> +        unsafe { device::Device::from_raw((*(*self.classdev.get()).dev).=
parent) }
> +    }
> +}
> +
> +struct Adapter<T: LedOps> {
> +    _p: PhantomData<T>,
> +}
> +
> +impl<T: LedOps> Adapter<T> {
> +    /// # Safety
> +    /// `led_cdev` must be a valid pointer to a `led_classdev` embedded =
within a
> +    /// `led::Device`.
> +    /// This function is called on setting the brightness of a led.
> +    unsafe extern "C" fn brightness_set_callback(
> +        led_cdev: *mut bindings::led_classdev,
> +        brightness: u32,
> +    ) {
> +        // SAFETY: The function's contract guarantees that `led_cdev` is=
 a valid pointer to a
> +        // `led_classdev` embedded within a `led::Device`.
> +        let classdev =3D unsafe { Device::<T>::from_raw(led_cdev) };
> +        // SAFETY: `classdev.parent()` is guaranteed to be contained in =
`T::Bus`.
> +        let parent =3D unsafe { T::Bus::from_device(classdev.parent()) }=
;
> +
> +        let _ =3D classdev.ops.brightness_set(parent, classdev, brightne=
ss);
> +    }
> +
> +    /// # Safety
> +    /// `led_cdev` must be a valid pointer to a `led_classdev` embedded =
within a
> +    /// `led::Device`.
> +    /// This function is called on setting the brightness of a led immed=
iately.
> +    unsafe extern "C" fn brightness_set_blocking_callback(
> +        led_cdev: *mut bindings::led_classdev,
> +        brightness: u32,
> +    ) -> i32 {
> +        from_result(|| {
> +            // SAFETY: The function's contract guarantees that `led_cdev=
` is a valid pointer to a
> +            // `led_classdev` embedded within a `led::Device`.
> +            let classdev =3D unsafe { Device::<T>::from_raw(led_cdev) };
> +            // SAFETY: `classdev.parent()` is guaranteed to be contained=
 in `T::Bus`.
> +            let parent =3D unsafe { T::Bus::from_device(classdev.parent(=
)) };
> +
> +            classdev.ops.brightness_set(parent, classdev, brightness)?;
> +            Ok(0)
> +        })
> +    }
> +
> +    /// # Safety
> +    /// `led_cdev` must be a valid pointer to a `led_classdev` embedded =
within a
> +    /// `led::Device`.
> +    /// This function is called on getting the brightness of a led.
> +    unsafe extern "C" fn brightness_get_callback(led_cdev: *mut bindings=
::led_classdev) -> u32 {
> +        // SAFETY: The function's contract guarantees that `led_cdev` is=
 a valid pointer to a
> +        // `led_classdev` embedded within a `led::Device`.
> +        let classdev =3D unsafe { Device::<T>::from_raw(led_cdev) };
> +        // SAFETY: `classdev.parent()` is guaranteed to be contained in =
`T::Bus`.
> +        let parent =3D unsafe { T::Bus::from_device(classdev.parent()) }=
;
> +
> +        classdev.ops.brightness_get(parent, classdev)
> +    }
> +
> +    /// # Safety
> +    /// `led_cdev` must be a valid pointer to a `led_classdev` embedded =
within a
> +    /// `led::Device`.
> +    /// `delay_on` and `delay_off` must be valid pointers to `usize` and=
 have
> +    /// exclusive access for the period of this function.
> +    /// This function is called on enabling hardware accelerated blinkin=
g.
> +    unsafe extern "C" fn blink_set_callback(
> +        led_cdev: *mut bindings::led_classdev,
> +        delay_on: *mut usize,
> +        delay_off: *mut usize,
> +    ) -> i32 {
> +        from_result(|| {
> +            // SAFETY: The function's contract guarantees that `led_cdev=
` is a valid pointer to a
> +            // `led_classdev` embedded within a `led::Device`.
> +            let classdev =3D unsafe { Device::<T>::from_raw(led_cdev) };
> +            // SAFETY: `classdev.parent()` is guaranteed to be contained=
 in `T::Bus`.
> +            let parent =3D unsafe { T::Bus::from_device(classdev.parent(=
)) };
> +
> +            classdev.ops.blink_set(
> +                parent,
> +                classdev,
> +                // SAFETY: The function's contract guarantees that `dela=
y_on` points to a `usize`
> +                // and is exclusive for the period of this function.
> +                unsafe { &mut *delay_on },
> +                // SAFETY: The function's contract guarantees that `dela=
y_off` points to a `usize`
> +                // and is exclusive for the period of this function.
> +                unsafe { &mut *delay_off },
> +            )?;
> +            Ok(0)
> +        })
> +    }
> +}
> +
> +#[pinned_drop]
> +impl<T: LedOps> PinnedDrop for Device<T> {
> +    fn drop(self: Pin<&mut Self>) {
> +        let raw =3D self.classdev.get();
> +        // SAFETY: The existence of `self` guarantees that `self.classde=
v.get()` is a pointer to a
> +        // valid `struct led_classdev`.
> +        let dev: &device::Device =3D unsafe { device::Device::from_raw((=
*raw).dev) };
> +
> +        let _fwnode =3D dev
> +            .fwnode()
> +            // SAFETY: the reference count of `fwnode` has previously be=
en
> +            // incremented in `led::Device::new`.
> +            .map(|fwnode| unsafe { ARef::from_raw(NonNull::from(fwnode))=
 });
> +
> +        // SAFETY: The existence of `self` guarantees that `self.classde=
v` has previously been
> +        // successfully registered with `led_classdev_register_ext`.
> +        unsafe { bindings::led_classdev_unregister(self.classdev.get()) =
};
> +    }
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 3dd7bebe7888..c03b7b242a2b 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -103,6 +103,7 @@
>  pub mod jump_label;
>  #[cfg(CONFIG_KUNIT)]
>  pub mod kunit;
> +pub mod led;
>  pub mod list;
>  pub mod maple_tree;
>  pub mod miscdevice;

