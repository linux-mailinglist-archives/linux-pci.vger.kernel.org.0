Return-Path: <linux-pci+bounces-33756-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04921B21161
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 18:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62ECA6E1B82
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 16:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131012E0925;
	Mon, 11 Aug 2025 16:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PdD5h+PA"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932062E0405;
	Mon, 11 Aug 2025 16:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928248; cv=none; b=jTNwwMJDBrVky13A/1Zyef17fQnPdDrnOSXWRAEth9K5aw1VBNiMGK1qWbEyCg/NZ0eyn5Nuu3XAs64Ipwa7zA7kzUDPbseT3hxC1/ZZKEl8Ln7C7DJBaZkrzyKZKR38PlH7vTv6uvb2iZonONeGPrei7WTr3MVzTYHA9ZzrBQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928248; c=relaxed/simple;
	bh=EXasBqd9Wi9d1f2YvcHPxhQBUshQ/kCqJ7Yjos04bcI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K6J0zSz8mmNKIkVjKgkZgZhUXu3Y25I2/GBAUE7pf8ppdxOIuV7WxJ/xWwxIFn2sAGMGjgV+/2M3YEKFwZ9YUIJpxshjo+OctKNZcHtOVy84fN2dnyMGdWnO50dAUBWPrfC8XXwrl64efjC3GXBVKiZF9ttoXWXhNS8mm9ICe1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PdD5h+PA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754928243;
	bh=EXasBqd9Wi9d1f2YvcHPxhQBUshQ/kCqJ7Yjos04bcI=;
	h=From:Subject:Date:To:Cc:From;
	b=PdD5h+PAB5iQ8sE9KLY17oUcWJukA/UN2JyM6COawVJxVj/k4sO3IEkuUBuV6rYe2
	 mmsH4w7f4+jIk8e+IEVqb9G/PPx30lp/AAzWF7aS6xOXiq1Uoyulz64jzDu1MCUZcO
	 vtbA1urG4CuyFDE5/vmg9Gg7FJrh6Qpdv3m+UnYyV8hoXHbj1/tUejOccCjnl354VP
	 I7mJv0D9Biig9M6uKlh2uUlaHgpR2h7fXXbw/KP8CN4L2+t/FZinPON2wzXtPtjZgu
	 lzVKGiAbKP8Z4No7GSRjIdDE8LCz+DVjorr4qVU7IdFv8Sl/b9W3Ns8F1saBvCx9y2
	 zZHQUVg7e131Q==
Received: from [192.168.0.23] (unknown [IPv6:2804:14d:72b4:82f6:67c:16ff:fe57:b5a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9A97817E00EC;
	Mon, 11 Aug 2025 18:03:59 +0200 (CEST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Subject: [PATCH v9 0/7] rust: add support for request_irq
Date: Mon, 11 Aug 2025 13:03:38 -0300
Message-Id: <20250811-topics-tyr-request_irq2-v9-0-0485dcd9bcbf@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFoUmmgC/3XN0QqDIBTG8VcZXs9hpmm72nuMMcxOS2hZ6mQRv
 fssGINBl/8Pzu/MyIMz4NH5MCMH0Xhj+xTl8YB0q/oHYFOnRpRQTkRGcbCD0R6HyWEH4wt8uBs
 3UqxAAJSV5JIzlK4HB415b/L1lro1Plg3bY+iWNevyXfNKDDBNStKTZpcaCIu2nadqqxTJ22fa
 HWj/FkyI/uWTJbMirxhmulcFf/WsiwfeA/7ZQ4BAAA=
X-Change-ID: 20250712-topics-tyr-request_irq2-ae7ee9b85854
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-pci@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>, 
 Dirk Behme <dirk.behme@de.bosch.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2

Changes in v9:
- Added more tags (thanks, Alice!)
- Added Alice's patch for &dev: Device<Bound> support
- Applied a diff to account for the latest review comment on the patch
  above
- Added #[pin_data] as applicable to the examples
- Got rid of the "Handler" type alias in the examples
- Removed the leading "#" from the imports in the examples so that they show
  up in the docs
- Made all inner modules private, removed #[doc(inline)] from the
  re-exports
- Link to v8: https://lore.kernel.org/r/20250810-topics-tyr-request_irq2-v8-0-8163f4c4c3a6@collabora.com

Changes in v8:
- Rebased on top of v6.17-rc1
- Used Completion instead of Atomics in the examples for non-threaded IRQs
  (Boqun)
- Take in "impl PinInit<T, Error>" instead of T in
  [Threaded]Registration::new() (Boqun)
- Propagated the changes above to the platform/pci accessors.
- Used a Mutex instead of Atomics in the examples for threaded IRQs.
- Added more links in the docs as appropriate (Alice)
- Re-exported irq::flags::Flags through a "pub use" (Alice).
- Note: left the above as optional  as it does not hurt to specify the full
  path anyway. As a result, no modules were made private.
- Added #[doc(inline)] as appropriate to the re-exports (Boqun).
- Formatted all the examples using nightly rustfmt +
  "format_code_in_doc_comments"
- Fixed a few issues pointed out by make rustdoc
- Merged imports (Alice)
- Defaulted ThreadedIrqHandler::handle() to WakeThread (Danilo)
- Added tags (thanks, Joel & Dirk!)
- Link to v7: https://lore.kernel.org/r/20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com

Changes in v7:
- Rebased on top of driver-core-next
- Added Flags::new(), which is a const fn. This lets us use build_assert!()
  to verify the casts (hopefully this is what you meant, Alice?)
- Changed the Flags inner type to take c_ulong directly, to minimize casts
  (Thanks, Alice)
- Moved the flag constants into Impl Flags, instead of using a separate
  module (Alice)
- Reverted to using #[repr(u32)] in Threaded/IrqReturn (Thanks Alice,
  Benno)
- Fixed all instances where the full path was specified for types in the
  prelude (Alice)
- Removed 'static from the CStr used to perform the lookup in the platform
  accessor (Alice)
- Renamed the PCI accessors, as asked by Danilo
- Added more docs to Flags, going into more detail on what they do and how
  to use them (Miguel)
- Fixed the indentation in some of the docs (Alice)
- Added Alice's r-b as appropriate
- Link to v6: https://lore.kernel.org/rust-for-linux/20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com/

Changes in v6:
- Fixed some typos in the docs (thanks, Dirk!)
- Reordered the arguments for the accessors in platform.rs (Danilo)
- Renamed handle_on_thread() to handle_threaded() (Danilo)
- Changed the documentation for Handler and ThreadedHandler to what
  Danilo suggested
- Link to v5: https://lore.kernel.org/r/20250627-topics-tyr-request_irq-v5-0-0545ee4dadf6@collabora.com

Changes in v5:

Thanks, Danilo {
  - Removed extra scope in the examples.
  - Renamed Registration::register() to Registration::new(),
  - Switched to try_pin_init! in Registration::new() (thanks for the
    code and the help, Boqun and Benno)
  - Renamed the trait functions to handle() and handle_on_thread().
  - Introduced IrqRequest with an unsafe pub(crate) constructor
  - Made both register() and the accessors that return IrqRequest public
    the idea is to allow both of these to work:
	// `irq` is an `irq::Registration`
	let irq = pdev.threaded_irq_by_name()?
  and
	// `req` is an `IrqRequest`.
	let req = pdev.irq_by_name()?;
	// `irq` is an `irq::Registration`
	let irq = irq::ThreadedRegistration::new(req)?;

  - Added another name in the byname variants. There's now one for the
    request part and the other one to register()
  - Reworked the examples in request.rs
  - Implemented the irq accessors in place for pci.rs
  - Split the platform accessor macros into two
}

- Added a rust helper for pci_irq_vectors if !CONFIG_PCI_MSI (thanks,
Intel 0day bot)
- Link to v4: https://lore.kernel.org/r/20250608-topics-tyr-request_irq-v4-0-81cb81fb8073@collabora.com

Changes in v4:

Thanks, Benno {
  - Split series into more patches (see patches 1-4)
  - Use cast() where possible
  - Merge pub use statements.
  - Add {Threaded}IrqReturn::into_inner() instead of #[repr(u32)]
  - Used AtomicU32 instead of SpinLock to add interior mutability to the
    handler's data. SpinLockIrq did not land yet.
  - Mention that `&self` is !Unpin and was initialized using pin_init in
    drop()
  - Fix the docs slightly
}

- Add {try_}synchronize_irq().
- Use Devres for the irq registration (see RegistrationInner). This idea
  was suggested by Danilo and Alice.
- Added PCI accessors (as asked by Joel Fernandez)
- Fix a major oversight: we were passing in a pointer to Registration
  in register_{threaded}_irq() but casting it to Handler/ThreadedHandler in
  the callbacks.
- Make register() pub(crate) so drivers can only retrieve registrations
  through device-specific accessors. This forbids drivers from trying to
  register an invalid irq.
- I think this will still go through a few rounds, so I'll defer the
  patch to update MAINTAINERS for now.

- Link to v3: https://lore.kernel.org/r/20250514-topics-tyr-request_irq-v3-0-d6fcc2591a88@collabora.com

Changes in v3:
- Rebased on driver-core-next
- Added patch to get the irq numbers from a platform device (thanks,
  Christian!)
- Split flags into its own file.
- Change iff to "if and only if"
- Implement PartialEq and Eq for Flags
- Fix some broken docs/markdown
- Reexport most things so users can elide ::request from the path
- Add a blanket implementation of ThreadedHandler and Handler for
  Arc/Box<T: Handler> that just forwards the call to the T. This lets us
  have Arc<Foo> and Box<Foo> as handlers if Foo: Handler.
- Rework the examples a bit.
- Remove "as _" casts in favor of "as u64" for flags. This is needed to
  cast the individual flags into u64.
- Use #[repr(u32)] for ThreadedIrqReturn and IrqReturn.
- Wrapped commit messages to < 75 characters

- Link to v2: https://lore.kernel.org/r/20250122163932.46697-1-daniel.almeida@collabora.com

Changes in v2:
- Added Co-developed-by tag to account for the work that Alice did in order to
figure out how to do this without Opaque<T> (Thanks!)
- Removed Opaque<T> in favor of plain T
- Fixed the examples
- Made sure that the invariants sections are the last entry in the docs
- Switched to slot.cast() where applicable,
- Mentioned in the safety comments that we require that T: Sync,
- Removed ThreadedFnReturn in favor of IrqReturn,
- Improved the commit message

Link to v1: https://lore.kernel.org/rust-for-linux/20241024-topic-panthor-rs-request_irq-v1-1-7cbc51c182ca@collabora.com/

---
Alice Ryhl (1):
      rust: irq: add &Device<Bound> argument to irq callbacks

Daniel Almeida (6):
      rust: irq: add irq module
      rust: irq: add flags module
      rust: irq: add support for non-threaded IRQs and handlers
      rust: irq: add support for threaded IRQs and handlers
      rust: platform: add irq accessors
      rust: pci: add irq accessors

 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/irq.c              |   9 +
 rust/helpers/pci.c              |   8 +
 rust/kernel/irq.rs              |  24 ++
 rust/kernel/irq/flags.rs        | 124 ++++++++++
 rust/kernel/irq/request.rs      | 507 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 rust/kernel/pci.rs              |  45 +++-
 rust/kernel/platform.rs         | 142 +++++++++++
 10 files changed, 860 insertions(+), 2 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250712-topics-tyr-request_irq2-ae7ee9b85854

Best regards,
-- 
Daniel Almeida <daniel.almeida@collabora.com>


