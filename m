Return-Path: <linux-pci+bounces-39181-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B08C02BA4
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 19:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C2A43AACD8
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 17:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5256347BC1;
	Thu, 23 Oct 2025 17:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="UU00TY7L"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE592332EA3
	for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 17:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761240501; cv=none; b=A6VfvSZyWcNhhRF2F+lS3m3/m9/K3Bjo/p7gyiQ0EFdcrf4YoVEBzP/ly3VnMmmp6VVi7GVWGd/Q/o5is5Q5hy64z85xrbGeXMSddh2pQcPneFSCBou19S5qzKj4Kwk1D68a+rXpwF1uivGByjKPk0662CdPCFWZcblvbJ12NpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761240501; c=relaxed/simple;
	bh=+boXjJBPWRynfBk+lRnrSB2xWOoEAPkmnAQ85xZ7MwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p7yg55UpaW39dYwMCgWcuUhcxd/DLT9e/HHug9CE3cyQ0KzDufv9LwmwxrvwnKVpWfrRct+Xq4k0m3GNeNST9PBzu024q8AcDMfzYBFamMwgEjq5oZMrFlcJWEJT8a2EENjaK/Dxk1+I3/4vUtRxHwx9RuAT2ZzC3ir4hGt2Dy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=UU00TY7L; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id AFF18240028
	for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 19:28:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1761240497; bh=9gzmJ2ZtdhgAdFd762KIuH7eitOFI5aNo7ccb3xqZcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Autocrypt:OpenPGP:From;
	b=UU00TY7LeIQ0EVhtt6rI2+yrC4QXmyjVHyA1LzA+ijsrRkuuZ08KzzPOJM4EVChol
	 Vj76UbGr2Id8r9UCC84P7tgrywxl7cRpAXVHCEPu7qpbEKDfIDG+UH0N7BZbQ5ppnz
	 OSqVeAdvJJLvgvgGgljsaF5g6Z215zGJIro7oTw8BNlYYoHlNPm9bo62uvTF2n9Eb7
	 1maUfx6w3gHRg1KaPJnPIsVIY2JJQwihRHGsk07KW9MhRAgDssybaU/gUZFlqZoJTk
	 rO0Q9/x/DKwDz6M4+d0BPca4F2GTgYObbYM4gnJQgoq0yoqxmvaiXlG4O+xG/jrpas
	 WI25RvZSbpQnw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cstKT0DQ3z6v2F;
	Thu, 23 Oct 2025 19:28:12 +0200 (CEST)
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
Subject: [PATCH v6 0/2] rust: leds: add led classdev abstractions
Date: Thu, 23 Oct 2025 17:28:15 +0000
Message-ID: <20251023172803.730677-1-markus.probst@posteo.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2666; i=markus.probst@posteo.de; h=from:subject; bh=+boXjJBPWRynfBk+lRnrSB2xWOoEAPkmnAQ85xZ7MwE=; b=owEBbQKS/ZANAwAIATR2H/jnrUPSAcsmYgBo+mWbtNfzpe43PLHqMwmOrNoN7SEF/RxBOzwE5 NHZCg53VSqJAjMEAAEIAB0WIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaPplmwAKCRA0dh/4561D 0oA3D/9UHsnjWFXS+NMPcP+gGqp/2/n8K9toV9IlxtJtOX23pWtGYRefLQbGfPYW2rE/wGy7rhx QVGH0IXa4zaMb29S0x+ZUys2RTQAWteyS0XfUVsePAmNUJH9n6VRNQBWU3tzTx1oewrZZ4HbhZq HE00Qb+2iJCG28OP6SvVg0QO02ccw/6hOpRsnDJh87TyjOCZ8CsuQPppgooqozsdn4GIaZOfaqP JSh3EfhBQ7DgOAV7GEiUctc5Qt6CPR4hlLgEf6dvj6oMYRxyZdVH1NrwjkyMwbCBmgPOf+IzWjI dPG6Y8hrPqOy7UibxC9THkbWS0GmHc9Ucd1q4tZ6zWWkFzoj9tDL+lwF/TjXijG1tOsgH/R0+Po TdKA6lzucDaeeBmU6SZX1RQvg+WwfUkWHwmkeHNxIHuABZXZor7unk3xWP6zcSRNhL9su6qWwa+ ujbEl9QVmDS9fLbaZswOAIeLQO3uA57YD+D770Kno9GZz/1H16CCw5MH8fk/qu5Owm5arpUJ6uP 6Ob+W8BvonwT19oz2Uih0yiu6KCYFVj3rYNIuB/V2ys6cjXYcY2utBUIB4hpTM+UEQdEjQ0nldX 9Gfjq0pAqXNz+nccTUavRIKWox3myxBUhHDP3+rUFLhgiY0goXG+Fl5GmBZVXh/gCtpVDs9nh+b u6jbNcUbA1Qekag=
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

 rust/kernel/auxiliary.rs |   7 +
 rust/kernel/device.rs    |  30 ++++
 rust/kernel/led.rs       | 375 +++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs       |   1 +
 rust/kernel/pci.rs       |   7 +
 rust/kernel/platform.rs  |   7 +
 rust/kernel/usb.rs       |   6 +
 7 files changed, 433 insertions(+)
 create mode 100644 rust/kernel/led.rs

-- 
2.51.0


