Return-Path: <linux-pci+bounces-32656-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 472BAB0C745
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 17:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83D623A8BA5
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 15:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFC92C15A8;
	Mon, 21 Jul 2025 15:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Hy1Tvr2U"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66AC2E406;
	Mon, 21 Jul 2025 15:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753110674; cv=pass; b=IQwdBScEMTolk/fJr6O2HUubvpfPpE42ZT0u4tQR4Flx+/utv39UWLEOSmTTfkLK/rSMNXGWlWcHVDYWV/8bywYz01e8DteNiKUZABf5bMSnunXCf2BrK7L76tHH187Ahh1KzQHn3aMoehmW53L9uwKabRjUEbRSDLoveCytRC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753110674; c=relaxed/simple;
	bh=tq6KhC1MGKI2JW90l7+Z3SyOwlMcu07eQT+YGKWbZ9Q=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NCacGPzbHZKqojgO2WQBxiA9ayrpthfnvo66xG414e9njX5oQiq8l34/vDGA6nWXIgLkkZATax7L5vudaTptuH7j0Y6TKMH+1PiPIgcXQnl0u9cP68DrirLInodhkMCYjuMOE4h/uWonAoYeqbbrIkS/VNFMKI/qi5EicdaZo+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Hy1Tvr2U; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753110628; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZkMaSkhXdCS2Lkkb2yofjU9xGKUQQRxsNq2SW8N2ioJkfkQDcsqzWg30uFd7kMuv6xeatMPS5lQCVJ9UD3eEXjVen1vHjsG/pJaxLeZCgiG0yQT17CfyLtVDpR1W9FATHfkQqo4z9yxh9OwEhtKP0I7zAdthkbPKhFDko8TAyYo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753110628; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tq6KhC1MGKI2JW90l7+Z3SyOwlMcu07eQT+YGKWbZ9Q=; 
	b=dhXd1c0iS8pm369g4Z5M7VrYVjQc2VeWq7MPf5PLx7agunp43EBQoNjEyxRY2BaTzHQZXCLG0Bu3nDHZFx2fEZ4QATOZrH7etFH+9vO8rO62s7leDf0YwxFxS+g7HTc8CKgVNclsVnZsTfX2VwwwTzt23oMC/jNp1/FnWE628Lc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753110628;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=tq6KhC1MGKI2JW90l7+Z3SyOwlMcu07eQT+YGKWbZ9Q=;
	b=Hy1Tvr2UaprJN6+ixH9h4fRCM8ESONLG0JSAkEn+EPmGhxR0kn0kljufNqJ2HOnv
	QgGghz5xkEqTxyspuIO/N6jCA/7BtxZ3wcrDEDCf/XNQ/7MVtkTqegHxA+m4U1eMN8u
	DNwZ+YaoukzRB93loYC8+gfM+k7wLvSXyCLxwI8g=
Received: by mx.zohomail.com with SMTPS id 1753110626585914.0594313125245;
	Mon, 21 Jul 2025 08:10:26 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v7 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <aH5SiKFESpnD4jvZ@google.com>
Date: Mon, 21 Jul 2025 12:10:10 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
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
 linux-pci@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1CC4638E-C682-4F68-A616-553169BB677C@collabora.com>
References: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com>
 <20250715-topics-tyr-request_irq2-v7-3-d469c0f37c07@collabora.com>
 <aH5SiKFESpnD4jvZ@google.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Alice, thanks for looking into this again :)


[=E2=80=A6]

>> diff --git a/rust/kernel/irq/request.rs b/rust/kernel/irq/request.rs
>> new file mode 100644
>> index =
0000000000000000000000000000000000000000..2f4637d8bc4c9fda23cbc83076870359=
57b0042a
>> --- /dev/null
>> +++ b/rust/kernel/irq/request.rs
>> @@ -0,0 +1,267 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// SPDX-FileCopyrightText: Copyright 2025 Collabora ltd.
>> +
>> +//! This module provides types like [`Registration`] which allow =
users to
>> +//! register handlers for a given IRQ line.
>> +
>> +use core::marker::PhantomPinned;
>> +
>> +use crate::alloc::Allocator;
>> +use crate::device::Bound;
>> +use crate::device::Device;
>=20
> The usual style is to write this as:
>=20
> use crate::device::{Bound, Device};

I dislike this syntax because I think it is a conflict magnet. Moreover, =
when
you get conflicts, they are harder to solve than they are when each =
import
is in its own line, at least IMHO. =20

In any case, I don't think we have a guideline for imports at the =
moment?

[=E2=80=A6]

>> +/// A registration of an IRQ handler for a given IRQ line.
>> +///
>> +/// # Examples
>> +///
>> +/// The following is an example of using `Registration`. It uses a
>> +/// [`AtomicU32`](core::sync::AtomicU32) to provide the interior =
mutability.
>> +///
>> +/// ```
>> +/// use core::sync::atomic::AtomicU32;
>> +/// use core::sync::atomic::Ordering;
>> +///
>> +/// use kernel::prelude::*;
>> +/// use kernel::device::Bound;
>> +/// use kernel::irq::flags;
>> +/// use kernel::irq::Registration;
>> +/// use kernel::irq::IrqRequest;
>> +/// use kernel::irq::IrqReturn;
>=20
> /// use kernel::irq::{Flags, IrqRequest, IrqReturn, Registration};

Same here. I=E2=80=99d rather not do this, if it=E2=80=99s ok with =
others.

=E2=80=94 Daniel=

