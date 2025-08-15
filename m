Return-Path: <linux-pci+bounces-34109-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E684EB28093
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 15:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 419F61BC0D57
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 13:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4932E3019A2;
	Fri, 15 Aug 2025 13:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="F3q33r6y"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C84227B9F;
	Fri, 15 Aug 2025 13:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755264297; cv=pass; b=Vktw3kAAYhIE527WxGzGKRBdR0tMFj+EYNEWD1sxlUQKhGR3V+/WTqMG18VPC2BBgofw8BKrtrK1bmaujg/wKqdHLXtTk+qoekX9C88zBIc88SXHxXTNw6vPlzdMuiEtBM/D5IkRmVOn9DlMJpxYvuUrUHfVQLlG+YlSn7MkDlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755264297; c=relaxed/simple;
	bh=1IhuYdZxh6yhCoY7SrBcUTK331T2VYb8HyBSH9ZP7g0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=hBjAY6gyeMdJGLUGeePJEZLmaPMqTp+4tJQ9UhgqdV4jmqusn6UutjCjHUbhO/nb1MnbH4yY494CNOkHh9tvW0SP1isc06sibEsL2MSBCmlmimA+H8WIvegZUgxxwtXuJEQ9xtryMpjj1nov9+mDUxG12ISf6lRIU+y01r3uZzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=F3q33r6y; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1755264254; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RxPi/t1+mzpngm9pb3EnUvsE2xW2IRMhniA+VkdgGv7bY489rq5uoVx6VVw5dVURKxOxh3uPClK02RFMRIdjSsaZdtrHkJKVmNfTOa0P4S6nYNlio2qtpimT0fnWCTteI1t7fMKS5thUechE37L96ZqZ5NajVEcXNkQzviApW6Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755264254; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6n/uWKHNCTgzPhbDkd1VtcwXGEJytOiNAvz8JYFv540=; 
	b=ascBJLBKL+v+yK/hpVhonZGS6a08Wy+MOE+D0ZuP02OPJ2i9OG6hEIAmMlm9rFkHTLthdCpx97UaBZzFNYkeuPkizCIZT6HVzWoxF3X4Dcvu+GqN5wja0IkxHMD80ks+KICjBNYjfcDGTZF8wUl9Zd49qadoepLh04e3Puu3DAw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755264254;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=6n/uWKHNCTgzPhbDkd1VtcwXGEJytOiNAvz8JYFv540=;
	b=F3q33r6yRUj5ujsnbWj/IrmiKinrE3PcaE537XS9naJWbbBV+B+n0D2EBqmiSc+U
	n2n659q+COXAzqDhv+G7EEd7OHCWwzfm64f2XiJp+M3DFkhxzNshuzYQHamGE8okqjM
	pxWle64Al/wSgRlDQ9QRzmht9tSA3vYxuMGoQFjU=
Received: by mx.zohomail.com with SMTPS id 1755264253647106.54876964435778;
	Fri, 15 Aug 2025 06:24:13 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v9 2/7] rust: irq: add flags module
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <87349seqsj.fsf@t14s.mail-host-address-is-not-set>
Date: Fri, 15 Aug 2025 10:23:55 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Benno Lossin <lossin@kernel.org>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Dirk Behme <dirk.behme@de.bosch.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9FDC8FB8-B8DA-4647-A602-4732EFA4CCD6@collabora.com>
References: <20250811-topics-tyr-request_irq2-v9-0-0485dcd9bcbf@collabora.com>
 <jjFmLoNIrT4EPz7LdN97j6uH8O6tsBHwC7-j9YfE6wdzydDFNRGMiVFcv5GI4waWhs_jdhILALP1ObzX7GEzzQ==@protonmail.internalid>
 <20250811-topics-tyr-request_irq2-v9-2-0485dcd9bcbf@collabora.com>
 <87349seqsj.fsf@t14s.mail-host-address-is-not-set>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 15 Aug 2025, at 09:02, Andreas Hindborg <a.hindborg@kernel.org> =
wrote:
>=20
> "Daniel Almeida" <daniel.almeida@collabora.com> writes:
>=20
>> Manipulating IRQ flags (i.e.: IRQF_*) will soon be necessary, =
specially to
>> register IRQ handlers through bindings::request_irq().
>>=20
>> Add a kernel::irq::Flags for that purpose.
>>=20
>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>> Tested-by: Joel Fernandes <joelagnelf@nvidia.com>
>> Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
>> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
>> ---
>> rust/kernel/irq.rs       |   5 ++
>> rust/kernel/irq/flags.rs | 124 =
+++++++++++++++++++++++++++++++++++++++++++++++
>> 2 files changed, 129 insertions(+)
>>=20
>> diff --git a/rust/kernel/irq.rs b/rust/kernel/irq.rs
>> index =
fae7b15effc80c936d6bffbd5b4150000d6c2898..068df2fea31de51115c30344f7ebdb4d=
a4ad86cc 100644
>> --- a/rust/kernel/irq.rs
>> +++ b/rust/kernel/irq.rs
>> @@ -9,3 +9,8 @@
>> //! drivers to register a handler for a given IRQ line.
>> //!
>> //! C header: =
[`include/linux/device.h`](srctree/include/linux/interrupt.h)
>> +
>> +/// Flags to be used when registering IRQ handlers.
>> +mod flags;
>> +
>> +pub use flags::Flags;
>> diff --git a/rust/kernel/irq/flags.rs b/rust/kernel/irq/flags.rs
>> new file mode 100644
>> index =
0000000000000000000000000000000000000000..e62820ea67755123b4f96e4331244bbb=
4fbcfd9d
>> --- /dev/null
>> +++ b/rust/kernel/irq/flags.rs
>> @@ -0,0 +1,124 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// SPDX-FileCopyrightText: Copyright 2025 Collabora ltd.
>> +
>> +use crate::bindings;
>> +use crate::prelude::*;
>> +
>> +/// Flags to be used when registering IRQ handlers.
>> +///
>> +/// Flags can be used to request specific behaviors when registering =
an IRQ
>> +/// handler, and can be combined using the `|`, `&`, and `!` =
operators to
>> +/// further control the system's behavior.
>> +///
>> +/// A common use case is to register a shared interrupt, as sharing =
the line
>> +/// between devices is increasingly common in modern systems and is =
even
>> +/// required for some buses. This requires setting [`Flags::SHARED`] =
when
>> +/// requesting the interrupt. Other use cases include setting the =
trigger type
>> +/// through `Flags::TRIGGER_*`, which determines when the interrupt =
fires, or
>> +/// controlling whether the interrupt is masked after the handler =
runs by using
>> +/// [`Flags::ONESHOT`].
>> +///
>> +/// If an invalid combination of flags is provided, the system will =
refuse to
>> +/// register the handler, and lower layers will enforce certain =
flags when
>> +/// necessary. This means, for example, that all the
>> +/// [`crate::irq::Registration`] for a shared interrupt have to =
agree on
>=20
> `rustdoc` will complain about this being undefined.

I think Danilo fixed this before applying. As I said a few days ago, I =
just ran
rustdoc on the final result, not on the individual commits. My bad, =
I=E2=80=99ll
pay attention to this next time.

>=20
>> +/// [`Flags::SHARED`] and on the same trigger type, if set.
>> +#[derive(Clone, Copy, PartialEq, Eq)]
>> +pub struct Flags(c_ulong);
>> +
>> +impl Flags {
>> +    /// Use the interrupt line as already configured.
>> +    pub const TRIGGER_NONE: Flags =3D =
Flags::new(bindings::IRQF_TRIGGER_NONE);
>> +
>> +    /// The interrupt is triggered when the signal goes from low to =
high.
>> +    pub const TRIGGER_RISING: Flags =3D =
Flags::new(bindings::IRQF_TRIGGER_RISING);
>> +
>> +    /// The interrupt is triggered when the signal goes from high to =
low.
>> +    pub const TRIGGER_FALLING: Flags =3D =
Flags::new(bindings::IRQF_TRIGGER_FALLING);
>> +
>> +    /// The interrupt is triggered while the signal is held high.
>> +    pub const TRIGGER_HIGH: Flags =3D =
Flags::new(bindings::IRQF_TRIGGER_HIGH);
>> +
>> +    /// The interrupt is triggered while the signal is held low.
>> +    pub const TRIGGER_LOW: Flags =3D =
Flags::new(bindings::IRQF_TRIGGER_LOW);
>> +
>> +    /// Allow sharing the IRQ among several devices.
>> +    pub const SHARED: Flags =3D Flags::new(bindings::IRQF_SHARED);
>> +
>> +    /// Set by callers when they expect sharing mismatches to occur.
>> +    pub const PROBE_SHARED: Flags =3D =
Flags::new(bindings::IRQF_PROBE_SHARED);
>> +
>> +    /// Flag to mark this interrupt as timer interrupt.
>> +    pub const TIMER: Flags =3D Flags::new(bindings::IRQF_TIMER);
>> +
>> +    /// Interrupt is per CPU.
>> +    pub const PERCPU: Flags =3D Flags::new(bindings::IRQF_PERCPU);
>> +
>> +    /// Flag to exclude this interrupt from irq balancing.
>> +    pub const NOBALANCING: Flags =3D =
Flags::new(bindings::IRQF_NOBALANCING);
>> +
>> +    /// Interrupt is used for polling (only the interrupt that is =
registered
>> +    /// first in a shared interrupt is considered for performance =
reasons).
>> +    pub const IRQPOLL: Flags =3D Flags::new(bindings::IRQF_IRQPOLL);
>> +
>> +    /// Interrupt is not reenabled after the hardirq handler =
finished. Used by
>> +    /// threaded interrupts which need to keep the irq line disabled =
until the
>> +    /// threaded handler has been run.
>> +    pub const ONESHOT: Flags =3D Flags::new(bindings::IRQF_ONESHOT);
>> +
>> +    /// Do not disable this IRQ during suspend. Does not guarantee =
that this
>> +    /// interrupt will wake the system from a suspended state.
>> +    pub const NO_SUSPEND: Flags =3D =
Flags::new(bindings::IRQF_NO_SUSPEND);
>> +
>> +    /// Force enable it on resume even if [`Flags::NO_SUSPEND`] is =
set.
>> +    pub const FORCE_RESUME: Flags =3D =
Flags::new(bindings::IRQF_FORCE_RESUME);
>> +
>> +    /// Interrupt cannot be threaded.
>> +    pub const NO_THREAD: Flags =3D =
Flags::new(bindings::IRQF_NO_THREAD);
>> +
>> +    /// Resume IRQ early during syscore instead of at device resume =
time.
>> +    pub const EARLY_RESUME: Flags =3D =
Flags::new(bindings::IRQF_EARLY_RESUME);
>> +
>> +    /// If the IRQ is shared with a [`Flags::NO_SUSPEND`] user, =
execute this
>> +    /// interrupt handler after suspending interrupts. For system =
wakeup devices
>> +    /// users need to implement wakeup detection in their interrupt =
handlers.
>> +    pub const COND_SUSPEND: Flags =3D =
Flags::new(bindings::IRQF_COND_SUSPEND);
>> +
>> +    /// Don't enable IRQ or NMI automatically when users request it. =
Users will
>> +    /// enable it explicitly by `enable_irq` or `enable_nmi` later.
>> +    pub const NO_AUTOEN: Flags =3D =
Flags::new(bindings::IRQF_NO_AUTOEN);
>> +
>> +    /// Exclude from runnaway detection for IPI and similar =
handlers, depends on
>> +    /// `PERCPU`.
>=20
> Should we link `PERCPU` here?
>=20
>> +    pub const NO_DEBUG: Flags =3D =
Flags::new(bindings::IRQF_NO_DEBUG);
>> +
>> +    pub(crate) fn into_inner(self) -> c_ulong {
>=20
> You need `#[expect(dead_code)]` here.
>=20
>> +        self.0
>> +    }
>> +
>> +    const fn new(value: u32) -> Self {
>> +        build_assert!(value as u64 <=3D c_ulong::MAX as u64);
>=20
> I am curious about this line. Can you add a short explanation?
>=20
> I would think this can never assert. That would require c_ulong to be
> less than 32 bits, right? Are there any configurations where that is =
the case?

This is just a way to validate the cast at build time. IMHO, regardless =
of
whether this can possibly trigger, it's always nice to err on the side =
of
caution, specially because this type doesn't have a fixed bit width.

>=20
>=20
> Best regards,
> Andreas Hindborg



