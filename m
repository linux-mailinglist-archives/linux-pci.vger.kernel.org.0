Return-Path: <linux-pci+bounces-29173-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A94AD1561
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 00:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A395167AF5
	for <lists+linux-pci@lfdr.de>; Sun,  8 Jun 2025 22:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0231B20A5DD;
	Sun,  8 Jun 2025 22:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="E7gJuhok"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7DE1B040B;
	Sun,  8 Jun 2025 22:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749423299; cv=pass; b=ZZOfE+nOw+YYZ5Ej+SBTlNcRYGlZpCW9nAJgTiyyxYt//uer3D0Wka/PJiHpQns81SuHqpeIPULth5Sb83ZGQ8mY3d1l1BuS1Iw2fNCL1j6wAm12YVnRUz9fY5jviiQ65HwKP1w08HVuWOUIhSDmzMm8vADlvXD6A40NkC9ndNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749423299; c=relaxed/simple;
	bh=2fZoZ5jJv9HHeP1leAw3yhUquA5EcdamhflkOAvzgXQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Lt0fkmr5irC+BieTrHZqoy3KG0w2K2uXsX42QI9knwu0q2qUjsFDk3wB4ImuSjDzu75+Yvdu4dKNb4s/YH2a7cdFvClplWO3WhzbUF7GeEs8dhPPfEXgZ9wfDOWRybDq66hjwzQJVeZOwQh2uDji3Bg2EKx8EXDszFb6pNu1G8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=E7gJuhok; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1749423259; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=i6VNEIIZaAQyopT/rIoj+OCKhe4wQPTDxP79YOayS/QmrYSjZe8+YthBagyQ3K/BpvyXiSsdvF3NxmjFQKSw9L3bOE3dFAsHdJMo+XhPJVWQB/ANEQmmPrf4/oHbdtrzCDxbW2xYEZCqvymkp9fk5KBBhBfDwIXDqsKwNvJ3DFw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749423259; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=J5enc0/kvMz/L1DnMYOJvLCUp+cT1jmXCz+cBPtfPRg=; 
	b=WBNGRJLgL9KcpvcOXruG/HQWGHstEFhjpoIcfrFybkZXdf87pT+PZk8vYA9cgO/5zpOiyswwPQyIJvjGJiGPgAQyN9d1duLS6R6z8asZG9WA++UHXc3Zp0L58Io2nole7sHoAcvVI/jaA0+SyT0fWL7Agnk8q6tafGfN2avpyhM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749423259;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=J5enc0/kvMz/L1DnMYOJvLCUp+cT1jmXCz+cBPtfPRg=;
	b=E7gJuhok8ws/fSgfrkixSKB51PnoHzfIRG8mOhSFV7c74asDKE+flqmnYnC8jaRu
	7uwC4rWcfAce/wB5Cn6C6nqxPveNeKI2MTR1QJDsbCJZ22JjdXmBSj/Wf8IgnoBjTpf
	toWUaMEJ4OyzNNI7e922lZEvTPLg+nbUf3Du/JVw=
Received: by mx.zohomail.com with SMTPS id 174942325721399.7236909146244;
	Sun, 8 Jun 2025 15:54:17 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Subject: [PATCH v4 0/6] rust: add support for request_irq
Date: Sun, 08 Jun 2025 19:51:05 -0300
Message-Id: <20250608-topics-tyr-request_irq-v4-0-81cb81fb8073@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANkTRmgC/6WPQQ6CMBBFr2K6dghtoYIr72GMGcsgkwDVFomEc
 HcBFyYu3Lh8k7z3M6MI5JmC2G9G4annwK6dIdluhK2wvRJwMbNQsUrjVCbQuRvbAN3gwdP9QaE
 7s79DUhrUcaZ3hJmY5Zunkp9r+HiaueLQOT+sO71cru+kVEoanWsVJcbkO5BQYMtUR1g3xAUer
 KtrvDiPkXWNWFK9+k/XH/3HQ72GGApTWqvSXGKWfaemaXoB3tFIKz4BAAA=
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
 rust/kernel/irq.rs              |  21 ++
 rust/kernel/irq/flags.rs        | 102 ++++++++
 rust/kernel/irq/request.rs      | 515 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 rust/kernel/pci.rs              |  35 +++
 rust/kernel/platform.rs         | 127 +++++++++-
 9 files changed, 810 insertions(+), 2 deletions(-)
---
base-commit: e271ed52b344ac02d4581286961d0c40acc54c03
change-id: 20250514-topics-tyr-request_irq-4f6a30837ea8

Best regards,
-- 
Daniel Almeida <daniel.almeida@collabora.com>


