Return-Path: <linux-pci+bounces-41784-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E29AC74133
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 14:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D003034750E
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 13:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC32339B5B;
	Thu, 20 Nov 2025 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="ESGve6/J"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75DC338909
	for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 13:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763643615; cv=none; b=o5GR0ninUNSdDTDIt2G6YrJFgmTiDL5PEE7dMNpWXxYlOcrYaggQPegte/1iEY+EZuhxcTMbewUpRg0kA21uu62/HThVsgWxrKErtiRSveJ1Ucglu21PkJpJ0qjWxyW1jM00Ky8W5GHuMJ+D8mzOQ0h5htaeA5Q6HWhUSvhus/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763643615; c=relaxed/simple;
	bh=8Z+hDiwvrPMWuY4uXNJyCH+MNAnBdSaIkwO0p+G22Wo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J3IeaWb6fkGEbVoMEb9iB1SQzCEhb050w4RB9aySjG1021cev4xmj25wBwkWRY5JBgxsEVap38usowDrCg+g/Is9buv+g74s6bgODXIqavtze36hwd2A9TEW1iwvvwEZByoixPZhzhVCt5i7zyrum1SadUOlY76XsFkxh4/XIz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=ESGve6/J; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id E5C16240029
	for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 14:00:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1763643610; bh=vhsUxwE6xNQ4+dhDBeuysWt11E79WeRbxcahyyAMSK4=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:OpenPGP:From;
	b=ESGve6/J6BDLQ4utPRO3skkzVdsgErQl5ns+PKmC4U8oXQwTITgzDbFGLgJhLcBut
	 vzDnBFiouiEgPmtL9FTnaGKuUGTSnAFgEhPx/LWq8UZlw7Sb3b0BIj051izBbzf9qh
	 1EbV6+IB32WsTdDWpMKj8UgmCCEoxt1m1mfGrAKF9+3jlglLW8J95gXWsm/ZPBpI8v
	 uofM0gahdGPQvFueW2c5ZeC39uaQD0JJ0ApvkjpjKBMB/l+CumkQy+OfLC/soy3Cbq
	 GaKXBYKPne1ZD8PlwCdpAH+dgDAMRn2pr+dQ7wY631he+xHx2L+0YCflrJNuxCl7rg
	 T7n/qiKBTI5AA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dBz3C1jVDz9rxT;
	Thu, 20 Nov 2025 14:00:07 +0100 (CET)
Message-ID: <f0158d9e98734d325fbde643ca982332c40980cd.camel@posteo.de>
Subject: Re: [PATCH v9 1/3] rust: leds: add basic led classdev abstractions
From: Markus Probst <markus.probst@posteo.de>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman
 <david.m.ertman@intel.com>, Ira Weiny	 <ira.weiny@intel.com>, Leon
 Romanovsky <leon@kernel.org>, Miguel Ojeda	 <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Boqun Feng	 <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>,  =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich	 <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Bjorn Helgaas	 <bhelgaas@google.com>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=
	 <kwilczynski@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Date: Thu, 20 Nov 2025 13:00:09 +0000
In-Reply-To: <aR78ywVnpWaOEeJ-@google.com>
References: <20251119-rust_leds-v9-0-86c15da19063@posteo.de>
	 <20251119-rust_leds-v9-1-86c15da19063@posteo.de>
	 <aR78ywVnpWaOEeJ-@google.com>
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

On Thu, 2025-11-20 at 11:34 +0000, Alice Ryhl wrote:
> On Wed, Nov 19, 2025 at 02:11:21PM +0000, Markus Probst wrote:
> > Implement the core abstractions needed for led class devices, including=
:
> >=20
> > * `led::LedOps` - the trait for handling leds, including
> >   `brightness_set`, `brightness_get` and `blink_set`
> >=20
> > * `led::InitData` - data set for the led class device
> >=20
> > * `led::Device` - a safe wrapper around `led_classdev`
> >=20
> > Signed-off-by: Markus Probst <markus.probst@posteo.de>
> > ---
> >  MAINTAINERS        |   7 +
> >  rust/kernel/led.rs | 472 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  rust/kernel/lib.rs |   1 +
> >  3 files changed, 480 insertions(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index b71ea515240a..80cb030911b7 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14112,6 +14112,13 @@ F:	drivers/leds/
> >  F:	include/dt-bindings/leds/
> >  F:	include/linux/leds.h
> > =20
> > +LED SUBSYSTEM [RUST]
> > +M:	Markus Probst <markus.probst@posteo.de>
> > +L:	linux-leds@vger.kernel.org
> > +L:	rust-for-linux@vger.kernel.org
> > +S:	Maintained
> > +F:	rust/kernel/led.rs
> > +
> >  LEGO MINDSTORMS EV3
> >  R:	David Lechner <david@lechnology.com>
> >  S:	Maintained
> > diff --git a/rust/kernel/led.rs b/rust/kernel/led.rs
> > new file mode 100644
> > index 000000000000..fca55f02be8d
> > --- /dev/null
> > +++ b/rust/kernel/led.rs
> > @@ -0,0 +1,472 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Abstractions for the leds driver model.
> > +//!
> > +//! C header: [`include/linux/leds.h`](srctree/include/linux/leds.h)
> > +
> > +use core::{
> > +    marker::PhantomData,
> > +    mem::transmute,
> > +    pin::Pin,
> > +    ptr::NonNull, //
> > +};
> > +
> > +use pin_init::{
> > +    pin_data,
> > +    pinned_drop,
> > +    PinInit, //
> > +};
> > +
> > +use crate::{
> > +    build_error,
> > +    container_of,
> > +    device::{
> > +        self,
> > +        property::FwNode,
> > +        AsBusDevice,
> > +        Bound, //
> > +    },
> > +    devres::Devres,
> > +    error::{
> > +        code::EINVAL,
> > +        from_result,
> > +        to_result,
> > +        Error,
> > +        Result,
> > +        VTABLE_DEFAULT_ERROR, //
> > +    },
> > +    macros::vtable,
> > +    str::CStr,
> > +    try_pin_init,
> > +    types::{
> > +        ARef,
> > +        Opaque, //
> > +    }, //
> > +};
>=20
> Please import kernel::prelude::* and remove all the imports that are
> available from the prelude.
>=20
> > +impl<'a> InitData<'a> {
> > +    /// Sets the firmware node
> > +    pub fn fwnode(self, fwnode: Option<ARef<FwNode>>) -> Self {
>=20
> I'm thinking that perhaps this should just be a `&'a FwNode` instead?
> That way, you can increment the refcount in Device::new() if
> registration is successful.
This was the way I have done it in v8. I issue with this approch is, if
the fwnode is optional, you have to do this ugly code:

let mut init_data =3D InitData::new()
    .default_label(c_str!(":label"))
    .devicename(c_str!("devicename"));

let child_fwnode =3D fwnode.child_by_name(c_str!("led"));

if let Some(child_fwnode_ref) =3D &child_fwnode {
    init_data =3D init_data.fwnode(child_fwnode_ref);
}

Instead of

let mut init_data =3D InitData::new()
    .fwnode(fwnode.child_by_name(c_str!("led")))
    .default_label(c_str!(":label"))
    .devicename(c_str!("devicename"));

Furthermore, most of the functions in the rust abstractions return a
`ARef<FwNode>` anyway. The only exception I found is
`device::Device::fwnode()`, but an led driver usually has more than one
led to its unlikely that the root fwnode will be directly passed to an
led classdev. As a result with the `&'a FwNode` approach, the led
abstraction would increment the reference count once, and the driver
will then decrement it once (dropping of the ARef<FwNode>).
Sounds like a tiny overhead to me.

>=20
> > +        Self { fwnode, ..self }
> > +    }
> > +
> > +    /// Sets a default label
>=20
> There are many missing periods in doc-comments.
>=20
> > +/// Trait defining the operations for a LED driver.
> > +///
> > +/// # Examples
> > +///
> > +///```
> > +/// # use kernel::{
> > +/// #     c_str, device, devres::Devres,
> > +/// #     error::Result, led,
> > +/// #     macros::vtable, platform, prelude::*,
> > +/// # };
> > +/// # use core::pin::Pin;
> > +///
> > +/// struct MyLedOps;
>=20
> When using # in examples, please do not have an empty line before
> beginning the example. It shows up as a weird extra empty line in the
> rendered docs.
>=20
> You could consider just making the imports displayed here also.
>=20
> Also the ``` both above and below the example usually has a space:
>=20
> /// ```
>=20
> rather than
>=20
> ///```
>=20
> > +                    // SAFETY:
> > +                    // - `parent.as_raw()` is guaranteed to be a point=
er to a valid `device`
> > +                    //    or a null pointer.
> > +                    // - `ptr` is guaranteed to be a pointer to an ini=
tialized `led_classdev`.
> > +                    to_result(unsafe {
> > +                        bindings::led_classdev_register_ext(
> > +                            parent.as_ref().as_raw(),
> > +                            ptr,
> > +                            &mut init_data_raw,
> > +                        )
> > +                    })?;
> > +
> > +                    core::mem::forget(init_data.fwnode); // keep the r=
eference count incremented
>=20
> This led abstraction implicitly takes a refcount on the fwnode and then
> drops it when the device is unbound.
I did look through the led classdev code and noticed that the fwnode
refcount isn't incremented. From what I can tell, the driver is
responsible to ensure the fwnode refcount never hits 0 while the led
classdev is registered. Thats why I incremented the refcount of the
fwnode to ensure the safety requirement is met.

Thanks
- Markus Probst

>=20
> Lee, can you confirm that taking a refcount on the fwnode is the right
> way to use the LED subsytem?
>=20
> Alice

