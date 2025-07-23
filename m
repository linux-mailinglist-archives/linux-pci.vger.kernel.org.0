Return-Path: <linux-pci+bounces-32828-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D73AB0F77A
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 17:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C7D7189B4B0
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 15:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5A81A4F3C;
	Wed, 23 Jul 2025 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPEe0uZc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2158A95C;
	Wed, 23 Jul 2025 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753285927; cv=none; b=MH7OirecaDo+BxVXq7uwlZMtu3d9OyddliaP2Av01n+1Ki0CSzaLn1gzNy8Ks320M/QuvyEPxZfxDKWTzCbl5qQdC3S5xt4695frwrSmfe6vLOPX900dAZqgyBWLsN5pbwfski0cQkl9qdC25fFxns8GzU5IXv1Wbkgtg/QfP+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753285927; c=relaxed/simple;
	bh=qmx86GClRdTh+GmCFQ9s0XfZC0/2nNXkeIbHp8gEHAY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=SuTRk8kFiHpLm91agQqPMsloVeZcomoQm25hlek/f7iqKKiahGjrlO+P+YR05vNyt4Xtww5P2LxKGQE2OG2QvMQl7wo9zayLcWtRlxjeUeCWBi1b+t6ukv0D7vlA55r/jUemdDDrdQ/LJiGW2Mvm3GUYXdwgMV7ktAU8DTEmuGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPEe0uZc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C864BC4CEE7;
	Wed, 23 Jul 2025 15:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753285927;
	bh=qmx86GClRdTh+GmCFQ9s0XfZC0/2nNXkeIbHp8gEHAY=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=CPEe0uZchNTvxnafRpM7AFxu2Ioxl0xOwyIGJ3HBtJ3Xd4Yrc6TrlYeCTqLeemfvO
	 2lHysHKURYajjzIDRE4LKHb04FVpOyqneT5a6Unoq05VmunQL1lYhjDB3s3/duoIH8
	 q0eTkUvtOY98JL9IeXWiK+vLwGemTxAQ7pnZp5QTE5HopPWjqiEAswhtpFejkGJEMK
	 vxwfo/om7nuVXa0F8GlQDuHb0KQnebXQZhSC3LZTtKU/qiuOzESxL0hYCnHsE3V86e
	 BViQOMsbu198ff6bub+F2xKkGffbzJIM77Y8d8Ik4+RU6K8ZR+T5+4tTU7HkVUV+jU
	 lkxaxSzLVESIQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Jul 2025 17:52:02 +0200
Message-Id: <DBJJZL9MXYSJ.3S4JQ14MK6N3B@kernel.org>
Subject: Re: [PATCH v7 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
Cc: "Daniel Almeida" <daniel.almeida@collabora.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C2=B4nski?=
 <kwilczynski@kernel.org>, "Benno Lossin" <lossin@kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com> <20250715-topics-tyr-request_irq2-v7-3-d469c0f37c07@collabora.com> <aIBl6JPh4MQq-0gu@tardis-2.local> <ED19060D-265A-4DEF-A12B-3F5901BBF4F3@collabora.com> <aIDxFoQV_fRLjt3h@tardis-2.local> <7fa90026-d2ac-4d39-bbd8-4e6c9c935b34@kernel.org> <8742EFD5-1949-4900-ACC6-00B69C23233C@collabora.com> <DBJIY7IKSNVH.1Q2QD6X30GIRC@kernel.org> <aIEDbB_FcgHgzfKd@google.com>
In-Reply-To: <aIEDbB_FcgHgzfKd@google.com>

On Wed Jul 23, 2025 at 5:44 PM CEST, Alice Ryhl wrote:
> On Wed, Jul 23, 2025 at 05:03:12PM +0200, Danilo Krummrich wrote:
>> On Wed Jul 23, 2025 at 4:56 PM CEST, Daniel Almeida wrote:
>> >> On 23 Jul 2025, at 11:35, Danilo Krummrich <dakr@kernel.org> wrote:
>> >> On 7/23/25 4:26 PM, Boqun Feng wrote:
>> >>> On Wed, Jul 23, 2025 at 10:55:20AM -0300, Daniel Almeida wrote:
>> >>> But sure, this and the handler pinned initializer thing is not a blo=
cker
>> >>> issue. However, I would like to see them resolved as soon as possibl=
e
>> >>> once merged.
>> >>=20
>> >> I think it would be trivial to make the T an impl PinInit<T, E> and u=
se a
>> >> completion as example instead of an atomic. So, we should do it right=
 away.
>> >>=20
>> >> - Danilo
>> >
>> >
>> > I agree that this is a trivial change to make. My point here is not to=
 postpone
>> > the work; I am actually somewhat against switching to completions, as =
per the
>> > reasoning I provided in my latest reply to Boqun. My plan is to switch=
 directly
>> > to whatever will substitute AtomicU32.
>>=20
>> I mean, Boqun has a point. AFAIK, the Rust atomics are UB in the kernel.
>>=20
>> So, this is a bit as if we would use spin_lock() instead of spin_lock_ir=
q(),
>> it's just not correct. Hence, we may not want to showcase it until it's =
actually
>> resolved.
>>=20
>> The plain truth is, currently there's no synchronization primitive for g=
etting
>> interior mutability in interrupts.
>
> Is the actual argument here "we are getting rid of Rust atomics in the
> next cycle, so please don't introduce any more users during the next
> cycle because if you do it will take one cycle longer to get rid of
> all Rust atomics"?

That's an argument as well, I guess.

> I can accept that argument. But I don't accept the argument that we
> shouldn't use them here because of the UB technicality. That is an
> isolated demand for rigor and I think it is unreasonable. Using Rust
> atomics is an accepted workaround until the LKMM atomics land.

I think there's a difference between actually needing them and using them t=
o
showcase something. Or in other words, limiting workarounds to only those p=
laces
where we can't avoid them seems like the correct thing to do.

Using a completion in the hard IRQ and showing a spinlock or mutex example =
in
the threaded handler seems like a good mix to me.

