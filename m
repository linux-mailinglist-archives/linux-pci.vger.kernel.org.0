Return-Path: <linux-pci+bounces-38632-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74702BEDC11
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 22:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB8094E2A4D
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 20:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F06295DBD;
	Sat, 18 Oct 2025 20:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="amtZBlVL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513702638BF
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 20:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760821184; cv=none; b=FXLqHAHeDyEBDd4cn3A5AkVsXyeL3gdTYF/fKT2dnWkI6jIF5F6xikqpLaEAkZv5yKwP9DO6/gFRvRuweJbEFk/mGpvMHxCgo1BFfjGeL0GC6P+QqXxHrkGufvddmEKFYBA4WTrn7wWfl/mUnT05f+mkd69GwmvQDjrlAFuW2h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760821184; c=relaxed/simple;
	bh=YfY6KgeB2rPLnk/MLYDelBy2rmkxTgE8N2ub43tYcDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MuMaRGvWRK9yCJR2a+b514p389G9ptUVv/kQ+05n4i6lVTolqNkTu61e3GCJ/kfGZytREr9OLel5f50blkA0h2MppPzYb9mG+q9DHf1ipnXPIsl5cfJvtpJmngjTFtbwYMLkxxyn382exFCacquZiUN5uRGUIuVlS2fKnjG+HQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=amtZBlVL; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id C70C8240103
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 22:59:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1760821173; bh=F2cSEpeV2BqiFapyyXh7JbtDaMNav58NP92cwY1MFSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Autocrypt:OpenPGP:From;
	b=amtZBlVLGzcudfh4YxybYw/SsvpSm7ZgIn7RZAEEuwWhHL5wgind4dSml2MxeM47k
	 WROYvJCpyyGrcl/4qGARq3wVyUQSa0jqEOdxJhqSH5obWU4W/bJr5elMb3xruUoXMB
	 9fnEO2ScY0PyBrZZ6S66s2tLhqWnVfYHtlQ75K8sPxzVOeeSPhMBZA5/fEMPDxghu6
	 SWjpmofqBpEH3DlPkgFyKCrSHrlg/Cqmw/vk3QD3dJV5L9q83BFsq/3J09zta4P4XX
	 onWkromF25j7JVP5MSkUk+T4sZjKuMukXsH3UivNtlG08w64mzDjtQ/FlRHrREVY7m
	 wVPOjhXC0WDFQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cpvFZ2TzHz9rxF;
	Sat, 18 Oct 2025 22:59:30 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Igor Korotin <igor.korotin.linux@gmail.com>,
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
	Daniel Almeida <daniel.almeida@collabora.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	kwilczynski@kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-leds@vger.kernel.org,
	Markus Probst <markus.probst@posteo.de>
Subject: [PATCH v5 0/2] rust: leds: add led classdev abstractions
Date: Sat, 18 Oct 2025 20:59:32 +0000
Message-ID: <20251018205912.1528811-1-markus.probst@posteo.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2405; i=markus.probst@posteo.de; h=from:subject; bh=YfY6KgeB2rPLnk/MLYDelBy2rmkxTgE8N2ub43tYcDo=; b=kA0DAAgBNHYf+OetQ9IByyZiAGjz/3KhkuOxcVpFxU4soOcNDXN8esFok50Dy96mZWQVeLOaz 4kCMwQAAQgAHRYhBIJ0GMT0rFjncjDEczR2H/jnrUPSBQJo8/9yAAoJEDR2H/jnrUPS054P/Rr7 T0QezWxJkvUjy5F76ygkmk5DSN0mYVRKpJXoA7yOAQCrc1QsIC91fblapox5efXN38XHpEbRf4W XkNeZ37co6KJ/2oApAaar3aNCxZl0T0fuT3EPy99q6MZsu4Z8uXXs1ldQac1C/O/N1TjqaTNrSG YG0vT/YshoYB1V49bqdceNtHRuwJKDgpTtO3RtnGlljTs7KzXPzuLn7eQz6YP0WIlmmFl3+EAYK M6R+N5N40q53MnNIhDeonNF+g3NedGFkgc/RMM1bTQztAipnhLwc+KeOQJN9cm3A3vvQIRtqYbw 3yxbJcT6tKxqX2KJ4nHaZCdFrhE9+555EA2AIDNhBmvfyM1peXgwv9dWvBvgzRryMb6k7SFtpL6 5UmKjYuNmvHhrAb4XrvALhCR66Z4CELDfaFzsjyZj/TRpi6xlUTqJDwCIRht17kNUz7uQeuYkXU h9eSrOcijM2UWrSxpkXMW8nETRqEktt0ff9bxlHH0jAnyUnNHyuyjdyNDI6yCwfwnpNma1/5Q/6 ohTwqbya2NFMKXRNydAoqQHy7qmxAVxqQR+KQmXhRs3ewo7ycuVFmoqEFdmj7/ZvGPWVpXGVON5 mlEcYttMhJf+MBjxawa5stBDVLMmEYwWnmoQkANo7vUHkcfAbX58O2KqgZjC1yZwrqCR0k8CITf YmTvg
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp; fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

This patch currently depends on
https://lore.kernel.org/rust-for-linux/20251005102226.41876-1-igor.korotin.linux@gmail.com/.

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
 rust/kernel/device.rs    |  41 +++++
 rust/kernel/i2c.rs       |   7 +
 rust/kernel/led.rs       | 375 +++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs       |   1 +
 rust/kernel/pci.rs       |   7 +
 rust/kernel/usb.rs       |   6 +
 7 files changed, 444 insertions(+)
 create mode 100644 rust/kernel/led.rs

-- 
2.49.1


