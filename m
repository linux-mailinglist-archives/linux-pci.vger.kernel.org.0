Return-Path: <linux-pci+bounces-32659-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E23B0C796
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 17:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E8861AA56D2
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 15:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D043B2DFA28;
	Mon, 21 Jul 2025 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7PE1OWz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25B42DFA25;
	Mon, 21 Jul 2025 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753111720; cv=none; b=EWamnPXcXTkdpNIlsKHWPUam20sWKNREfMuhzv04t1oqwLUf3UI0tw2gHPcbG7dc5yM5XLnVay+pP+wFSYKMx+ORRLbHYxN2UDpEHnhINrCjJaP6t7i1+lNTbat5M+byYzQnhOxx4yrvgqMhJzwjWmMyMGk5JH1xoYUSCEX15MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753111720; c=relaxed/simple;
	bh=nCpcqFOSQBYfouxESADSKBlFi0oBNti09eO/gQc1dJU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=kVk+fY7GNVTUEf4/imCUeakhnyib70Nx38rS+Jv6xyFSqLQ+BmVUe1/xAz+VLG4EgZ83hdZP6nal9MlGA9hTfX9WyLTJsfPDgUBokh+13xtDlyJ9OSTLsI7x/AJMBTut3iwb6jQxszQvw9qwP4PfjvqruW0tw5MIpvHKHD1aErA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7PE1OWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD1A6C4CEF4;
	Mon, 21 Jul 2025 15:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753111720;
	bh=nCpcqFOSQBYfouxESADSKBlFi0oBNti09eO/gQc1dJU=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=g7PE1OWzQVvcURRkYpCt9Aqm0v1wR0ELiFhWnrTmeekNzQnVFdanN1j+F3PUbb1ah
	 5mXhzK+30KLzokUgnHDCdJQ0Kz0g7lbFz+AUPoNv++4vZjG/jUT/y4m4N7bCCQLzkG
	 y07v7MF/iB1rshh2xvnbCheyKQKCckvc4brz7YdF5zASdQp8gPFn2ZkEgM+u73ojXu
	 WTqMpYKHpCkrJK/VQ+hEK7vhtpQGb0yDSURmvScw8k329iuORn8Lmn8ckyTTbDxI4J
	 55nQT6i4n3iHoB6jMlvBHJRheKMNQdyxcrTV60pu982ParXlMAffyTmzOyT/uyVT0B
	 Wa0ZhU+mj8RDg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Jul 2025 17:28:35 +0200
Message-Id: <DBHU8JNG1P7I.NNDX9ZDT9DNU@kernel.org>
Subject: Re: [PATCH v7 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Benno Lossin" <lossin@kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com> <20250715-topics-tyr-request_irq2-v7-3-d469c0f37c07@collabora.com> <aH5SiKFESpnD4jvZ@google.com> <1CC4638E-C682-4F68-A616-553169BB677C@collabora.com>
In-Reply-To: <1CC4638E-C682-4F68-A616-553169BB677C@collabora.com>

On Mon Jul 21, 2025 at 5:10 PM CEST, Daniel Almeida wrote:
> Hi Alice, thanks for looking into this again :)
>
>
> [=E2=80=A6]
>
>>> diff --git a/rust/kernel/irq/request.rs b/rust/kernel/irq/request.rs
>>> new file mode 100644
>>> index 0000000000000000000000000000000000000000..2f4637d8bc4c9fda23cbc83=
07687035957b0042a
>>> --- /dev/null
>>> +++ b/rust/kernel/irq/request.rs
>>> @@ -0,0 +1,267 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +// SPDX-FileCopyrightText: Copyright 2025 Collabora ltd.
>>> +
>>> +//! This module provides types like [`Registration`] which allow users=
 to
>>> +//! register handlers for a given IRQ line.
>>> +
>>> +use core::marker::PhantomPinned;
>>> +
>>> +use crate::alloc::Allocator;
>>> +use crate::device::Bound;
>>> +use crate::device::Device;
>>=20
>> The usual style is to write this as:
>>=20
>> use crate::device::{Bound, Device};
>
> I dislike this syntax because I think it is a conflict magnet. Moreover, =
when
> you get conflicts, they are harder to solve than they are when each impor=
t
> is in its own line, at least IMHO. =20

Intuitively, I would agree. However, I think practically it's not that bad.

While it's true that Rust has generally more conflict potential - especiall=
y in
the current phase - my feeling hasn't been that includes produce significan=
tly
more conflicts then any other code so far.

> In any case, I don't think we have a guideline for imports at the moment?

No, but I think we should try to be as consistent as possible (at least wit=
hin a
a certain logical unit, e.g. subsystem, module, etc.). Not sure where exact=
ly
the IRQ stuff will end up yet. :)

>>> +/// A registration of an IRQ handler for a given IRQ line.
>>> +///
>>> +/// # Examples
>>> +///
>>> +/// The following is an example of using `Registration`. It uses a
>>> +/// [`AtomicU32`](core::sync::AtomicU32) to provide the interior mutab=
ility.
>>> +///
>>> +/// ```
>>> +/// use core::sync::atomic::AtomicU32;
>>> +/// use core::sync::atomic::Ordering;
>>> +///
>>> +/// use kernel::prelude::*;
>>> +/// use kernel::device::Bound;
>>> +/// use kernel::irq::flags;
>>> +/// use kernel::irq::Registration;
>>> +/// use kernel::irq::IrqRequest;
>>> +/// use kernel::irq::IrqReturn;
>>=20
>> /// use kernel::irq::{Flags, IrqRequest, IrqReturn, Registration};
>
> Same here. I=E2=80=99d rather not do this, if it=E2=80=99s ok with others=
.
>
> =E2=80=94 Daniel


