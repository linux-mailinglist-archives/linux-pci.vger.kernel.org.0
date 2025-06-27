Return-Path: <linux-pci+bounces-30940-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A75CAEBD0E
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 18:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E93A16480B6
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 16:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61CE1B3925;
	Fri, 27 Jun 2025 16:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="E7XKTaqC"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DFB29898B;
	Fri, 27 Jun 2025 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751041329; cv=pass; b=uiPrDfbaygQ2aVLmuQaDLghQSrl0qdXmtPNf++G9s1UEOEb5SX6PaU34peqaMVWT08cVruVVXZYwR68m/N6MZ1Id0rMapT2oXAzYhZuEHzoyr5y8uAj8YxNJkpTI1SxojvvO+rIOm3XHigsbq61TCjHmfnWSidqD3to0VIMUxvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751041329; c=relaxed/simple;
	bh=67y3eSaIOMj715iqLuG7zX5APAHA3q6uqtg/Bf+95tA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AST039upfOq3kIhLmshVA2v0EFrc9eNmqaLMJ8+TVNP7MXwNr7CX3CVnwztZbalspin17X4hS0kjtoJPN6ho6Mx0BXqhm/fOdBVO52hr/ELMPR7aOM4ljdf+yuE7w+4jEI+M1mg+O89rbW0syiUWQwgUErX846PRSaJbLRuYcxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=E7XKTaqC; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751041291; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mfys5trg145DTNpH/H/5wdq8ifMmixM9aWd2Tz8Ig3GxIx4EJiE3+XNGp1djUUjm0kxr3tVxtK9z7rmx889V17G+ISRAqb+5bT2D4JJ+mbDTdEAL7HmWai57X+Puk7RXHnpwQLlKMOBBidSVkfRvF464V40KL5maCr7NGTWR//4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751041291; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Br6qrfU9G/rljqjcWFT/el79U1sgTrkcXWV4H28U/7s=; 
	b=jL0Fyrigh0P0vT1e9O0ZBku2O/QjSpJiqD5jCNEWzPSW3w1TWqtOj9tzP0/vk9TX+8536aWFjWlESGbgChkYgLVSesiYhHfbc6FvrfOCkgCuLLUxU9UnfC3wV83WJ1hypDJRcGyAivt8xsQSkhxdIcOTnJ018w08urU3nkynEhc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751041291;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=Br6qrfU9G/rljqjcWFT/el79U1sgTrkcXWV4H28U/7s=;
	b=E7XKTaqCd7i1z6xcrQszm1drrK+ovQXTWHaq6+7NOsdj5SfuNHP5TE1hE0YQw0+7
	dcAxV2ZzNXXvz/fqRzv/Vyo63bYmqQmZIwq1I8E0HDxnmsTEVKx09LP8U+4SYh2f+Oy
	eFHiWwxeLPT1nUBsrpNG4lYKbHTsSUTnG9J4R08I=
Received: by mx.zohomail.com with SMTPS id 1751041289353319.45520051759866;
	Fri, 27 Jun 2025 09:21:29 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Subject: [PATCH v5 0/6] rust: add support for request_irq
Date: Fri, 27 Jun 2025 13:21:02 -0300
Message-Id: <20250627-topics-tyr-request_irq-v5-0-0545ee4dadf6@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO7EXmgC/6XPTWrDMBAF4KsErTNGf5blrnqPUspYHicDjpVIr
 mkIvnuVdBEobTZZvoH3PeYiMiWmLF42F5Fo4cxxKqHebkTY47Qj4L5koaWuZa0szPHIIcN8TpD
 o9El5/uB0Ajs4NNKbhtCLUj4mGvjrBr+9l7znPMd0vu0s6nr9IZXWypnW6Mo61zagoMeJaaxwP
 BD3+BriOGIXE1YhHsSVWvRzdXOvP3hoMSChd0MIum4Vev8XZe+Uk/5fyhbKq9B5NXReNuY3ta7
 rNwWhrh2JAQAA
X-Change-ID: 20250514-topics-tyr-request_irq-4f6a30837ea8
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Benno Lossin <lossin@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-pci@vger.kernel.org, Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2
X-ZohoMailClient: External


---
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
 rust/kernel/irq.rs              |  22 ++
 rust/kernel/irq/flags.rs        | 102 +++++++++
 rust/kernel/irq/request.rs      | 496 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 rust/kernel/pci.rs              |  45 +++-
 rust/kernel/platform.rs         | 143 +++++++++++-
 10 files changed, 825 insertions(+), 3 deletions(-)
---
base-commit: 40b37285e5ecf9bbf7ab29ed5a6e9640e7684e5d
change-id: 20250514-topics-tyr-request_irq-4f6a30837ea8

Best regards,
-- 
Daniel Almeida <daniel.almeida@collabora.com>


