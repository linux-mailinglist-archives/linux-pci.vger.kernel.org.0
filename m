Return-Path: <linux-pci+bounces-31448-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AACAF815E
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 21:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFA531C83D49
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 19:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DFB298CC5;
	Thu,  3 Jul 2025 19:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Fpp2i2Na"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6724F2F32;
	Thu,  3 Jul 2025 19:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751571063; cv=pass; b=UkBsEiOnjFVd3tLymSQbbF+/B4aVCHd1DciZsJPUqMJpsLdMRvcBnun5tkWB7wetRKcUQjIO5T3yMLvNeBiA6kQ/xV8gVDT04CLZjYOJXBybTrcQkvKWRh7gDye0ZNEif3T/HDY9uE45eqNkEqTlpPoEa02oe9Casw+wZBkZJiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751571063; c=relaxed/simple;
	bh=Ds091A2QHY1R50IW9GXE0qk+a0KraO37xj+yVkIfagk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uPWeyNmumaibkp5XVpQ6gZL93UKpDIuzUXFBX33LxiYC2ZFhGjhtI6uDNgnDLbD5/QwRFoSmtDOG8h60FNTBLWbZTHyaniUgjMCCgH9/ZjcuYDSYb2TYhpx/aIHOgNg6+7y9emhaU2P3TJckl5wXxAmAxVX2U08yyB0Oc8sJnrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Fpp2i2Na; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751571040; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=a5AIitHHpc0UrPLnyAdIZLZkbJM0+CuLtGvk5p4DsvsuB4R71gKPInwSqSGVGzQhdfxQ6fw9SiuLQg45h/NDpRqdFTsD6MWihc/IOBvz4xj2pEI90ssP8CvizFJrGM0f+vmfy7tRnMdAtliF5yqqL9g1UGb3wRxYnpXJPhf3BPM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751571040; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=z29PaVAh0oaF9dtOWNlB1A+h3wpFMIUnr7A55gjmThA=; 
	b=Gcal96NVmvYYvTXw8xRR2bUX8ke3eZFUIMMhcULnkDywmTA5TyyCMGhWctLv3H4hTHSVqMyrG6ed/iczGSdigGVj/5F5H7IL/2DWxGXI78zxZUVqng8TFl/h5MmsROxB3V4/ffsJjgbUdQUGJc8XObMPKOOCH4/JEtszIcAUkjY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751571040;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=z29PaVAh0oaF9dtOWNlB1A+h3wpFMIUnr7A55gjmThA=;
	b=Fpp2i2Na9Ebip3jADvhUdCqrv1ngx0ZXNkTSqNOeEvh+ZzLH/BeTMqrR6EN9PTWI
	DpOcB6S1TzMu1NFdvFz6+t/bVM7gcgL/RO/9S/mJvhPLLGjm5sPh+2egaiMakhbOdZr
	V+L8//r1zFJHrgk9JS6cj0bKN0p9u4Y5Y5imKE0w=
Received: by mx.zohomail.com with SMTPS id 1751571039028940.1650885014568;
	Thu, 3 Jul 2025 12:30:39 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Subject: [PATCH v6 0/6] rust: add support for request_irq
Date: Thu, 03 Jul 2025 16:29:58 -0300
Message-Id: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADbaZmgC/6XPTWrDMBAF4KsErSujf8tZ9R6llLE0bgYcK5Fc0
 xB89yrpIqUk3XT5Bt73mDMrmAkL227OLONChdJUg3vasLCD6R05xZqZEsoKKw2f04FC4fMp84z
 HDyzzG+UjN4MDLbxuETyr5UPGgT6v8MtrzTsqc8qn684iL9dvUiolne60aoxzXcsljzARjg2Me
 6QIzyGNI/QpQxPSnl2oRf2vrm/1Px5aNBc8uiEEZTsJ3t+jzI1ywj+kTKW8DL2XQ+9Fq+9R9ge
 l2oeUrZSwxiKaCHFwv6l1Xb8A/NNHcNQBAAA=
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
 rust/kernel/irq/flags.rs        | 102 ++++++++
 rust/kernel/irq/request.rs      | 508 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 rust/kernel/pci.rs              |  45 +++-
 rust/kernel/platform.rs         | 143 ++++++++++-
 10 files changed, 837 insertions(+), 3 deletions(-)
---
base-commit: 40b37285e5ecf9bbf7ab29ed5a6e9640e7684e5d
change-id: 20250514-topics-tyr-request_irq-4f6a30837ea8

Best regards,
-- 
Daniel Almeida <daniel.almeida@collabora.com>


