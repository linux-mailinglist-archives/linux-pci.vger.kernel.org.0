Return-Path: <linux-pci+bounces-29873-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E584ADB296
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 15:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17084161196
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 13:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3916F2877D8;
	Mon, 16 Jun 2025 13:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="h7XMA1G1"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5422877DF;
	Mon, 16 Jun 2025 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750082011; cv=pass; b=VzniAGeovsTde/aM93H9zmXvzpCM7sG4tDB3R+9VONAvASd2lFIUYJ9pXc2/k3axgsyqziOvpeOj3tnUJRu7S3e2lVmBLNsOplPFoVBfzGnUEkpDxBqNQ5HW8r4gCnrkYj6+ymCO3za+xMaYlbRG1Uzs0Js87IW9eHy4YnsP+Qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750082011; c=relaxed/simple;
	bh=VPBW3DUZWR8rEu+xKM8mLtm8j6S+GyFkek9AfvzzjtY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=dNyZLlk1kVK6S8tjFfunT7MnNHty77W0S0wQCkrAgPK1jd1pXhXsO1S3vtKGDF1uwsgvgjqEdCIJZQhi26tNYmQErHJ7z+cBdEKi9hDtctOnwXze1XFnX1poSe7dF8fIwB3HYW+w/1Ig3VzfbHZ0mO8cLFJXCJnyXZANmeA9cNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=h7XMA1G1; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1750081982; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PLKRiJVJmOyTAh2bXwlTII/rAuVlxuOBFvmRD8uxukWTwO/W5f3KfBu02FQihNT3EujN2JMsySR10GfMFNvge1tMTknr4TQ0ScsjEsgHoPZt+ps2m1yj7L6ZIyK3fg9Qm8tEL0NuPXPrvvdp6+eSqvxLTWTQzrm6Y4ja++Hcsqc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750081982; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1KfyiRvfAxxfHaWLnswCRSWM0xyQXffOX6Zl0uvCN6o=; 
	b=I4aRotmYjNrU2gOe3zrwlmnBIe3JQaYiFYtio7k18SlZb1D0bcuMj2f+mZ1J76rX65RLJrBQV7x3ew/r6fneoWQwjJR/FWwwDGrQ+P+BJaRVuZcaeai0aL+pXcS212gfgFhFUM1nZfdTacSQ8JWEhF7gdupKOiOl+t7sCZ5wpHI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750081982;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=1KfyiRvfAxxfHaWLnswCRSWM0xyQXffOX6Zl0uvCN6o=;
	b=h7XMA1G1BS40763It7I+21kD5l55RVWd4SasXUxDkq4tQryH19E0esGJuzPEelG4
	fbBPV8ErEkEiWTuIJjx0ORWvXvKV8GT1INfNfOeLr2pVmo9tOt7ZYGaA4ExO9YX3Y3n
	NjQYfqnS+KY1mlIt1+JttTtEGycBMcbMVyUvAArI=
Received: by mx.zohomail.com with SMTPS id 1750081979926577.9845647874406;
	Mon, 16 Jun 2025 06:52:59 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v4 4/6] rust: irq: add support for threaded IRQs and
 handlers
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <5B3865E5-E343-4B5D-9BF7-7B9086AA9857@collabora.com>
Date: Mon, 16 Jun 2025 10:52:44 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Benno Lossin <lossin@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <24F81191-5391-4208-9943-64440FCC19D8@collabora.com>
References: <20250608-topics-tyr-request_irq-v4-0-81cb81fb8073@collabora.com>
 <20250608-topics-tyr-request_irq-v4-4-81cb81fb8073@collabora.com>
 <aEbTOhdfmYmhPiiS@pollux>
 <5B3865E5-E343-4B5D-9BF7-7B9086AA9857@collabora.com>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi,

>>=20
>>> +
>>> +impl<T: ?Sized + ThreadedHandler, A: Allocator> ThreadedHandler for =
Box<T, A> {
>>> +    fn handle_irq(&self) -> ThreadedIrqReturn {
>>> +        T::handle_irq(self)
>>> +    }
>>> +
>>> +    fn thread_fn(&self) -> IrqReturn {
>>> +        T::thread_fn(self)
>>> +    }
>>> +}
>>> +
>>> +/// A registration of a threaded IRQ handler for a given IRQ line.
>>> +///
>>> +/// Two callbacks are required: one to handle the IRQ, and one to =
handle any
>>> +/// other work in a separate thread.
>>> +///
>>> +/// The thread handler is only called if the IRQ handler returns =
`WakeThread`.
>>> +///
>>> +/// # Examples
>>> +///
>>> +/// The following is an example of using `ThreadedRegistration`. It =
uses a
>>> +/// [`AtomicU32`](core::sync::AtomicU32) to provide the interior =
mutability.
>>> +///
>>> +/// ```
>>> +/// use core::sync::atomic::AtomicU32;
>>> +/// use core::sync::atomic::Ordering;
>>> +///
>>> +/// use kernel::prelude::*;
>>> +/// use kernel::device::Bound;
>>> +/// use kernel::irq::flags;
>>> +/// use kernel::irq::ThreadedIrqReturn;
>>> +/// use kernel::irq::ThreadedRegistration;
>>> +/// use kernel::irq::IrqReturn;
>>> +/// use kernel::platform;
>>> +/// use kernel::sync::Arc;
>>> +/// use kernel::sync::SpinLock;
>>> +/// use kernel::alloc::flags::GFP_KERNEL;
>>> +/// use kernel::c_str;
>>> +///
>>> +/// // Declare a struct that will be passed in when the interrupt =
fires. The u32
>>> +/// // merely serves as an example of some internal data.
>>> +/// struct Data(AtomicU32);
>>> +///
>>> +/// // [`handle_irq`] takes &self. This example illustrates =
interior
>>> +/// // mutability can be used when share the data between process =
context and IRQ
>>> +/// // context.
>>> +///
>>> +/// type Handler =3D Data;
>>> +///
>>> +/// impl kernel::irq::request::ThreadedHandler for Handler {
>>> +///     // This is executing in IRQ context in some CPU. Other CPUs =
can still
>>> +///     // try to access to data.
>>> +///     fn handle_irq(&self) -> ThreadedIrqReturn {
>>> +///         self.0.fetch_add(1, Ordering::Relaxed);
>>> +///
>>> +///         // By returning `WakeThread`, we indicate to the system =
that the
>>> +///         // thread function should be called. Otherwise, return
>>> +///         // ThreadedIrqReturn::Handled.
>>> +///         ThreadedIrqReturn::WakeThread
>>> +///     }
>>> +///
>>> +///     // This will run (in a separate kthread) if and only if =
`handle_irq`
>>> +///     // returns `WakeThread`.
>>> +///     fn thread_fn(&self) -> IrqReturn {
>>> +///         self.0.fetch_add(1, Ordering::Relaxed);
>>> +///
>>> +///         IrqReturn::Handled
>>> +///     }
>>> +/// }
>>> +///
>>> +/// // This is running in process context.
>>> +/// fn register_threaded_irq(handler: Handler, dev: =
&platform::Device<Bound>) -> Result<Arc<ThreadedRegistration<Handler>>> =
{
>>> +///     let registration =3D dev.threaded_irq_by_index(0, =
flags::SHARED, c_str!("my-device"), handler)?;
>>=20
>> This doesn't compile (yet). I think this should be a "raw" example, =
i.e. the
>> function should take an IRQ number.
>>=20
>> The example you sketch up here is for =
platform::Device::threaded_irq_by_index().
>=20
> Yes, I originally had an example along the lines of what you =
mentioned. Except
> that with the changes in register() from pub to pub(crate) they =
stopped
> compiling.
>=20
> I am not sure how the doctest to kunit machinery works, but I was =
expecting
> tests to have access to everything within the module they're defined =
in, but
> this is apparently not the case.

Does anybody have any input on this? Again, I tried it already before =
sending
the current version but it does not compile due to pub(crate).

=E2=80=94 Daniel=

