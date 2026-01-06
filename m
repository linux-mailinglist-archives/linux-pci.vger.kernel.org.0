Return-Path: <linux-pci+bounces-44075-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 138B4CF65BB
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 02:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 83F1B30049C9
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 01:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5963521B9F5;
	Tue,  6 Jan 2026 01:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="K7OwsQsv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305E57640E
	for <linux-pci@vger.kernel.org>; Tue,  6 Jan 2026 01:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767664277; cv=none; b=sxiP2Ouh7G5Xtirq1OrWzLeOLip1JgeyBDCQrBuj+zjWE4qFzzlamUfDloZQPih/fZVVg5rVPyLOl/6H4wdithZQJARUcXqTcAGF8TvwVDI9UHbuQujx8KD3U63olacqK78SbEWT0u+tlKMutlQWb6NdWNUIYu8cuEQMWP4kaIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767664277; c=relaxed/simple;
	bh=8MSE3Yb96JSZ/BcM2wM0bdHrKhTNa23LItYGHcA+xiM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U+aHUHIssfZrXBwZG1/mDo3hVrkVOU69zFZPVPqn+DSi80NQU04pmIOmxQBe4ZZAS0n64Q3lgCbOF0ZH/Xec5HjophKTDryPjglpHlxcP/47C1Nt+AdQeiT87NtKKYGqhXKjJ56VzleH+qUPfaU2WSFPh3dqY9C8GklDhhtEh+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=K7OwsQsv; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 32287240103
	for <linux-pci@vger.kernel.org>; Tue,  6 Jan 2026 02:42:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1767663771; bh=JMPEtJXwdE0+nP9UAdzxiJcf272bDj8c9U2R9zT0DpY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:To:Cc:Autocrypt:OpenPGP:From;
	b=K7OwsQsv+P67Sefd3M0IiG2QbnEkyEW4F7a/JDuNzb3cfv5iQLMQRYiha0ZYQvzRn
	 ofvxSxou5qBpAH+4sVLZpqiZqUfkKcjRd/fq1rT08Vhg0ZOr46UlFjrL7KJ/Pq88rF
	 bIfuD+ouyrng9qPdqKyCUqX6TefV1oIaP8c0oxJL5Jwohe+nBqG3M41218CWKUJxzf
	 wZwsLEgwhl7TPwVhAEkLzyX7hffWLspR0IHyJZ7aDYZhXoD22yEe/EphxYR4HoPPOV
	 3wo9/3SZQ2PfzUpUtgRLFgIOJN/7xENyBcB6914K3aTksgT9Jok2ysm5Ik2WmVoB2R
	 rMWeXrxouZ1jg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dlYnz5jWpz6twB;
	Tue,  6 Jan 2026 02:42:47 +0100 (CET)
From: Markus Probst <markus.probst@posteo.de>
Subject: [PATCH v10 0/3] rust: leds: add led classdev abstractions
Date: Tue, 06 Jan 2026 01:42:50 +0000
Message-Id: <20260106-rust_leds-v10-0-e0a1564884f9@posteo.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIhoXGkC/02MUQuDIBRG/0r4PIe3srx72v8YY0helzAytMlG9
 N9nwcDH7/Cds7JIwVFkl2plgZKLzk95gDhVbBj19CTuTAasFrUEgJaHd1weLzKRa5Ro+6G2vUW
 W/3Mg6z5H7HbPe3Rx8eF7tJPa6b8ii0pSXHCDugXbSCkbdZ19XMifDbG9krA0sTQxm6obQBoNK
 LqmNLdt+wESpvE73QAAAA==
X-Change-ID: 20251114-rust_leds-a959f7c2f7f9
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 Markus Probst <markus.probst@posteo.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3834;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=8MSE3Yb96JSZ/BcM2wM0bdHrKhTNa23LItYGHcA+xiM=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBpXGiX16CU7jkRK9hAvyEsOfQiyU9YZ3niezWDg
 IRccCTDgR+JAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaVxolxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQNHYf+OetQ9KouhAAhYAVE1gszuAg9GbUtYUDSG9oVJWk/i+
 4qo0OaLNSqnxz4tpeihlkDi768OFkSc1bCiYy+8vM+KicZmvzTWqlfIs1pWD0fLBSYq4Ydo20nY
 pwso3gIxXWGxlhpocaWHL/PU6lI9y1WBr9lvo2+2B13wXqRekYNli6Gp4NgH8BvJN/C/9+nns9w
 x+ohNcanBBlOjpda+NHfwxx61g3MjvRtY0xMZhY7JaoRo7Dy+bvO+oT8fdxs7OWxy6UxE4CCaaq
 9xM/2i8udBayxNamIX61caHFf8dyKDxrgq6aLVqRdb4nt9reIZLVGkEgam3qdmyiUwJ6PFrCdRa
 V7kRlGxr/cnomGleBpvIHLDMMf/w2U88L7HBKe01KjN5NOD53OhmPwNLJZpA8mAhegeUe6avkbl
 NOG3mNl3pH3azctb3hydqYxg03+6ZuAxvtuntFaSAnBDvAzOW1T6rURHQo0pz/ievcs24JwRNG9
 wV45Xa7Ujz0q+iYLRUZAYWieVTaW4hH75WDgBTAJV9ST0H3nHagi4Ujhq5wV/wfnULT6tXXEnbo
 fdNbtOQoOPeOZhxn+RvC6b8oyyXmKLOgDza9qzFFDa2KEZuOjLNlZ01ynfPCAFx9134O1OWUyuL
 fXSUUKjTBLA0A8JVcIJ1EwhLGV6Si7OUmWzlQoZffqcnFZ0xuc5k=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
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
* add basic led classdev abstractions to register and unregister leds

* add basic led classdev abstractions to register and unregister
  multicolor leds

Changes since v9:
* add missing periods in documentation
* duplicate `led::Device` and `led::Adapter` instead of using a complex
  trait
* fix imports not using prelude
* adapt to CStr change
* documented `led::Color::Multi` and `led::Color::Rgb`

Changes since v8:
* accept `Option<ARef<Fwnode>>` in `led::InitData::fwnode()`
* make functions in `MultiColorSubLed` const
* drop the "rust: Add trait to convert a device reference to a bus
  device reference" patch, as it has been picked into driver-core

Changes since v7:
* adjusted import style
* added classdev parameter to callback functions in `LedOps`
* implement `led::Color`
* extend `led::InitData` with
  - initial_brightness
  - default_trigger
  - default_color
* split generic and normal led classdev abstractions up (see patch 3/4)
* add multicolor led class device abstractions (see patch 4/4)
* added MAINTAINERS entry

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

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
Markus Probst (3):
      rust: leds: add basic led classdev abstractions
      rust: leds: split generic and normal led classdev abstractions up
      rust: leds: add multicolor classdev abstractions

 MAINTAINERS                     |   8 +
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/led.rs              | 300 +++++++++++++++++++++++++++++++
 rust/kernel/led/multicolor.rs   | 384 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/led/normal.rs       | 223 +++++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 6 files changed, 917 insertions(+)
---
base-commit: 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb
change-id: 20251114-rust_leds-a959f7c2f7f9


