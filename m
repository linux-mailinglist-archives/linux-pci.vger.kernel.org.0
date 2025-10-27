Return-Path: <linux-pci+bounces-39465-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F590C11510
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 21:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B1AA189038F
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 20:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC88B320A0D;
	Mon, 27 Oct 2025 20:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="eJ/3B5AE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E26322C78
	for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 20:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761595576; cv=none; b=IB7AgINOhUCsqEy+my/toEfdJvFbCoBdkf4obOOjYL/U/xkuZwo3gkFOtNpBhEdragLXu7mckpP1Nwv/g5kBePeIKnpaSHKkW2F60dGhWwkkq3YTUzjUxZ0OhDC8Ks3FE0tAB5Y6BgNBDf+8lIQnLEuvBPxCzOtHSoslcmAQacg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761595576; c=relaxed/simple;
	bh=wSBf5Xy4Aslo7SOGQU/mF5ZHvq4mmV3sP1znVcDJV8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tLZUJ0ELdxErsjzKSc7PdVZrK61lnhYbPPSWaesbL+1lIj1Z9FkvaB/66UURzj5KP5ZWhr8YTssC39JTGwFdUCmsLJLvN1JCMAjLfpQf3pSx4jWGmRoLKJNI85C8k7jDIwf508ap9QRS5/LfGj01tuOpOeFUgRirBRij8VkIP1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=eJ/3B5AE; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 26457240101
	for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 21:06:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1761595562; bh=O37ZSH19ALLogD4cYR4ZnjINIQhJoZZcAsSu5q2wlf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Autocrypt:OpenPGP:From;
	b=eJ/3B5AEFrWv6iu5CE+FzcpVWc0yiGU9nnGMOwKEcX0iKXc9nvA+tQsK83fVPh3nT
	 7fhtibKsReArXIq8oExS0dJAZrbMm39ASUvlIgTCjCx/Wy8H+ZJ9jj6OpyoUQvFoHe
	 NurvvnaA6fervtroqgVmDIMpHp8EmfRodKH9FLuwGOIDreildB4q+iCkLj/jy+Ug7G
	 dnMQrHGg8vIYPkBLIl2s/9RoGpqYt4YpQnVujzlM1+0RmqckGSNIXRXhwo2OgjQNy6
	 xFONqbwQT8mk6pOBL+5Al9BaGN/mqSvr1qBLZdBRScCG0d8Qt9C2hEQode/3woqF6f
	 T9srXx1dgkrfQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cwPdf42dxz9rxB;
	Mon, 27 Oct 2025 21:05:58 +0100 (CET)
From: Markus Probst <markus.probst@posteo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>
Cc: Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	bjorn3_gh@protonmail.com,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Markus Probst <markus.probst@posteo.de>,
	rust-for-linux@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/2] rust: leds: add led classdev abstractions
Date: Mon, 27 Oct 2025 20:06:01 +0000
Message-ID: <20251027200547.1038967-1-markus.probst@posteo.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2881; i=markus.probst@posteo.de; h=from:subject; bh=wSBf5Xy4Aslo7SOGQU/mF5ZHvq4mmV3sP1znVcDJV8o=; b=owEBbQKS/ZANAwAIATR2H/jnrUPSAcsmYgBo/9B4JsuuiA0OKSWEXg+sojaOajOX0n2M15kxE tnRYnT9YaSJAjMEAAEIAB0WIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaP/QeAAKCRA0dh/4561D 0tSpD/9Iagsy9UUpit6BzNhdkBEz0eYFQjCT3IUhC/LWIKycXyHU8ym65yBb2slilc2lLiZir8h BSJ/9308hnZ1u+D6wMGlZqihcxzYJrCzJdxmyDAhJnRhuC16wY+uytbBSj05CBp5Hx0FPWbLs/8 0TVmtmF8zT6VTQjCs0eNtMG9rkLIdZaso8rkp3Fl6P76ncE4CYgMe4qCx0UpcKQa+yR59pU8wxN f2L6IaB3KK68NONPrH5Gxts4Q69d+USYxuxdDeI2JEUgHL9IQInzpAP/hr1WI7d8QBhzIgp5xcQ o5eWDKVpyZz6lSv1O9tUfwqL8IqYLIH6YAL/it6VDsRwMwOhU3lWPLBk+E1WzkYW+eYAFmdxrkL jLNCpa6OB9jJcjzUY/p7INoH9edPpwcQoSh6Jv6twSkbm88a66unNJYNfrr6Uj5z1GAKVMfxzkY viLVsHVzhEwxluARsz3eNaXvMtw9pDAZ8v1tHsRSjhprJAubUlbj2/8lX5iojVQyaEXrW6IEPdY X34aaQINLSlVOVNqbHYccc9Ii5jUoEuTHaxZnfWarqAgVQUXbPLwyE27YvduqYAQe9MntNcWR0D CmIjDJmwrUAcj+MHS5ZWlfcQGEXl3KsaMVRQ3HQzOErdBdNc78rBHAYLk1exAawuWTsJE43q4yz Q05ey4gbWQ+iTEQ=
 =
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp; fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

This patch series has previously been contained in
https://lore.kernel.org/rust-for-linux/20251008181027.662616-1-markus.probst@posteo.de/T/#t
which added a rust written led driver for a microcontroller via i2c.

As the reading and writing to the i2c client via the register!
macro has not been implemented yet [1], the patch series will only
contain the additional abstractions required.

[1] https://lore.kernel.org/rust-for-linux/DDDS2V0V2NVJ.16ZKXCKUA1HUV@kernel.org/

The following changes were made:
* add abstraction to convert a device reference to a bus device
  reference for use in class device callbacks

* add basic led classdev abstractions to register and unregister leds

Changes since v6:
* fixed typos
* improved documentation

Changes since v5:
* rename `IntoBusDevice` trait into `AsBusDevice`
* fix documentation about `LedOps::BLOCKING`
* removed dependency on i2c bindings
* added `AsBusDevice` implementation for `platform::Device`
* removed `device::Device` fallback implementation
* document that `AsBusDevice` must not be used by drivers and is
  intended for bus and class device abstractions only.

Changes since v4:
* add abstraction to convert a device reference to a bus device
  reference
* require the bus device as parent device and provide it in class device
  callbacks
* remove Pin<Vec<_>> abstraction (as not relevant for the led
  abstractions)
* fixed formatting in `led::Device::new`
* fixed `LedOps::BLOCKING` did the inverse effect

Changes since v3:
* fixed kunit tests failing because of example in documentation

Changes since v2:
* return `Devres` on `led::Device` creation
* replace KBox<T> with T in struct definition
* increment and decrement reference-count of fwnode
* make a device parent mandatory for led classdev creation
* rename `led::Handler` to `led::LedOps`
* add optional `brightness_get` function to `led::LedOps`
* use `#[vtable]` instead of `const BLINK: bool`
* use `Opaque::cast_from` instead of casting a pointer
* improve documentation
* improve support for older rust versions
* use `&Device<Bound>` for parent

Changes since v1:
* fixed typos noticed by Onur Özkan

Markus Probst (2):
  rust: Add trait to convert a device reference to a bus device
    reference
  rust: leds: add basic led classdev abstractions

Markus Probst (2):
  rust: Add trait to convert a device reference to a bus device
    reference
  rust: leds: add basic led classdev abstractions

 rust/kernel/auxiliary.rs |   7 +
 rust/kernel/device.rs    |  33 ++++
 rust/kernel/led.rs       | 375 +++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs       |   1 +
 rust/kernel/pci.rs       |   7 +
 rust/kernel/platform.rs  |   7 +
 rust/kernel/usb.rs       |   6 +
 7 files changed, 436 insertions(+)
 create mode 100644 rust/kernel/led.rs

-- 
2.51.0


