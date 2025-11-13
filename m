Return-Path: <linux-pci+bounces-41093-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E63DFC58096
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 15:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D269B3BBE48
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 14:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2200E2D1936;
	Thu, 13 Nov 2025 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="pUaRuL6o"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A342D0C94
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 14:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763044990; cv=none; b=CR6kJV05PZnW/qWcS8Q2l3sdVx6fwNyQqMDAS+Q1TBWYsuxRUysx+pSV37zvdexLpQz1O6rd7q4fMWrn3Pw2sLvfOylRCnC2eKqZsugyE2CCI53ByC9GnZyhg8VMLqcMhE+JeFWGvEgbNwA7UjFMNcRBdzNVuRVbdkIl0Bb8YaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763044990; c=relaxed/simple;
	bh=pzyv7vLjjU9lDazIwtsSgVGiP+Et3EtHRfN13T3NXVk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BLSY4+eunqxzxMOqc+73i77IDl5sRKDF8kI+eL2TfqNPI9IxNW/Q5HIgSpqa/7kR3mdtXnSOnHaJb5mHL6q5VCL0gskBEbtU9HucFFlUlLRvEWRQ7+uMNSIeFwmuI2Cp3lz70OQOK4FN2mPX9nH81NSeI9T9HjlPCGmIW90ZDMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=pUaRuL6o; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id B479724002B
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 15:43:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1763044984; bh=q7uv+pZE/Rt1SjFLQLc3Ebfv1mmsna4IvbAjN0LEdXM=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:OpenPGP:From;
	b=pUaRuL6ooOsKt9kULEak6RFgNePZcJxGrNSSQ7HmWr/dfmzKIsOrCBryqNsQYWUhB
	 IQZ2CNFRbT7dG9CxYUfldhM0cuLnRiXfCy6z9Bbl0cTflPIT2q3eZsVfilEgtB7U/9
	 gI6QfxEUpsSnEgH7GfMmDStI8oJ0TIW/wRG7Swv4jGXinMJEbqnUhJpOJVF4N1HYkk
	 U5YjRiwZhUXDnrlzzqxtruu+RsctzXtOy9Q3sipmADCzeHgXUOvNuUbkLUMdT7hKT/
	 Dy0x/xDSVeyt4C2HC2SO0UiPuRRkL8p4bPdOa/ZREjnPg7MxhFEtzj1Rx40rWreG4b
	 Sr4Nv/vkibNew==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4d6jg92v54z6trs;
	Thu, 13 Nov 2025 15:43:01 +0100 (CET)
Message-ID: <8e1d09db23439a361e12b93bbaa2f80959799775.camel@posteo.de>
Subject: Re: [PATCH v7 0/2] rust: leds: add led classdev abstractions
From: Markus Probst <markus.probst@posteo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda
	 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Danilo Krummrich
	 <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Lee Jones
	 <lee@kernel.org>, Pavel Machek <pavel@kernel.org>
Cc: Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>,
  Leon Romanovsky	 <leon@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, 	bjorn3_gh@protonmail.com, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross	 <tmgross@umich.edu>, Bjorn Helgaas
 <bhelgaas@google.com>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=	
 <kwilczynski@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 13 Nov 2025 14:43:03 +0000
In-Reply-To: <bf4192fd466571f798023b70c3e83e19448d8149.camel@posteo.de>
References: <20251027200547.1038967-1-markus.probst@posteo.de>
	 <bf4192fd466571f798023b70c3e83e19448d8149.camel@posteo.de>
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

On Thu, 2025-11-13 at 15:20 +0100, Markus Probst wrote:
> On Mon, 2025-10-27 at 20:06 +0000, Markus Probst wrote:
> > This patch series has previously been contained in
> > https://lore.kernel.org/rust-for-linux/20251008181027.662616-1-markus.p=
robst@posteo.de/T/#t
> > which added a rust written led driver for a microcontroller via i2c.
> >=20
> > As the reading and writing to the i2c client via the register!
> > macro has not been implemented yet [1], the patch series will only
> > contain the additional abstractions required.
> >=20
> > [1] https://lore.kernel.org/rust-for-linux/DDDS2V0V2NVJ.16ZKXCKUA1HUV@k=
ernel.org/
> >=20
> > The following changes were made:
> > * add abstraction to convert a device reference to a bus device
> >   reference for use in class device callbacks
> >=20
> > * add basic led classdev abstractions to register and unregister leds
> >=20
> > Changes since v6:
> > * fixed typos
> > * improved documentation
> >=20
> > Changes since v5:
> > * rename `IntoBusDevice` trait into `AsBusDevice`
> > * fix documentation about `LedOps::BLOCKING`
> > * removed dependency on i2c bindings
> > * added `AsBusDevice` implementation for `platform::Device`
> > * removed `device::Device` fallback implementation
> > * document that `AsBusDevice` must not be used by drivers and is
> >   intended for bus and class device abstractions only.
> >=20
> > Changes since v4:
> > * add abstraction to convert a device reference to a bus device
> >   reference
> > * require the bus device as parent device and provide it in class devic=
e
> >   callbacks
> > * remove Pin<Vec<_>> abstraction (as not relevant for the led
> >   abstractions)
> > * fixed formatting in `led::Device::new`
> > * fixed `LedOps::BLOCKING` did the inverse effect
> >=20
> > Changes since v3:
> > * fixed kunit tests failing because of example in documentation
> >=20
> > Changes since v2:
> > * return `Devres` on `led::Device` creation
> > * replace KBox<T> with T in struct definition
> > * increment and decrement reference-count of fwnode
> > * make a device parent mandatory for led classdev creation
> > * rename `led::Handler` to `led::LedOps`
> > * add optional `brightness_get` function to `led::LedOps`
> > * use `#[vtable]` instead of `const BLINK: bool`
> > * use `Opaque::cast_from` instead of casting a pointer
> > * improve documentation
> > * improve support for older rust versions
> > * use `&Device<Bound>` for parent
> >=20
> > Changes since v1:
> > * fixed typos noticed by Onur =C3=96zkan
> >=20
> > Markus Probst (2):
> >   rust: Add trait to convert a device reference to a bus device
> >     reference
> >   rust: leds: add basic led classdev abstractions
> >=20
> > Markus Probst (2):
> >   rust: Add trait to convert a device reference to a bus device
> >     reference
> >   rust: leds: add basic led classdev abstractions
>=20
> Hi,
>=20
> So you know in advance, I will add a 3. patch for multicolor led
> classdev abstractions (drivers/leds/led-class-multicolor.c,
> include/linux/led-class-multicolor.h) to this patch series.
>=20
> In the atmega1608 led driver (the user of these abstractions) there are
> leds with different colors that share the same slot.
> Technically "drivers/leds/rgb/leds-group-multicolor.c" could be used in
> combination with single color leds instead, but then hardware
> accelerated blinking wouldn't be supported. I think it would make more
> sense to directly implement it in the driver.
>=20
> The existing 2 patches shouldn't change, so feel free to review them.
>=20
> Thanks
> - Markus Probst

ignore the duplicate email. Sending the email gave an error, retrying
resulted in the email being sent twice.

Thanks
- Markus Probst

>=20
> >=20
> >  rust/kernel/auxiliary.rs |   7 +
> >  rust/kernel/device.rs    |  33 ++++
> >  rust/kernel/led.rs       | 375 +++++++++++++++++++++++++++++++++++++++
> >  rust/kernel/lib.rs       |   1 +
> >  rust/kernel/pci.rs       |   7 +
> >  rust/kernel/platform.rs  |   7 +
> >  rust/kernel/usb.rs       |   6 +
> >  7 files changed, 436 insertions(+)
> >  create mode 100644 rust/kernel/led.rs

