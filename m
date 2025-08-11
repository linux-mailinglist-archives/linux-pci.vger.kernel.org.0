Return-Path: <linux-pci+bounces-33684-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D98B1FD5D
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 02:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 568231894978
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 00:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3062E16A395;
	Mon, 11 Aug 2025 00:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="D5HLT61f"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E87F5A79B;
	Mon, 11 Aug 2025 00:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754873393; cv=pass; b=fW6N3pU/beFXT/niRwC3m6/DynQmt4prvltWh9i9eZzJ7bmBwxIXNY9HIQfVWgXt6Z+3EG/GNWc5nvKKeBvz5tDaNFJlBjIxO7j7H8+g92cf1PABz3xdfrgAUxaQGP90rWY0WXZoOh1C99SO/WsK2+QogMl7/xFb/U67GP5SvW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754873393; c=relaxed/simple;
	bh=7tRAxSqqY10mzKrcbVRG8/IZwAS+LDj4oPQ8Z7Ab7ls=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Sjjjyu4c4VNTDdcNE8vbzr4CnypD+JLHdU3awf5IkiDLksPuRVv14MyL/GQdejlYk4/qEOu7aLqwqR02ukai2PwRk6xqH3xYM8CEYfy9xKjE4gPiCoG/Oxy56LYtHFMF6bpywYoBgkxl9IJqdMl9ylvmyHXzE57sjQSfIwJCZIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=D5HLT61f; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1754873372; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Z8ofV6Cvt3DO1NJ0TmDOvxxCDpV/UF0IYFuezegzMlrUp8JwigZEab+8PA5y5/waHNemW63SHh7DAux2bxf1ea+iJv70Jf+I1fkHF2F26e00YIPjkzVS+cv4M5vhVuOr1B4oOCNogGI/uUcwk+f+l0ACYkXzd1v0F/2mSoeR2cI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754873372; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0Tb/rAbCLPWTr4mCwUuhZK5oJw4n1wEh7gOYvWxHnOA=; 
	b=UVzVQNq/rbTbopXXDlP9v04IuZfPdahXU88wQOAcrL6angzDyO7FbNpMT3U/r8d+IoMQ9u4x3PuPBm4dFYry71SZVFvcAI5yYq6iT6roAZzQ80pk13s+i+3HuD/TFi5Gcv+a+bTj2mNtHG2Bvctin3zD2pm7jttnIxsGJOXoOBA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754873372;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=0Tb/rAbCLPWTr4mCwUuhZK5oJw4n1wEh7gOYvWxHnOA=;
	b=D5HLT61fJQU3k2R2bz9Sn+EPPC5UavsU2azW5hcZcLQp3zwWZL89L7WiiIkF4FwY
	DBaPtZjWtw3HzMf59AewCkKr9YAlW7y8t5lexxc3TqzxgXVsWxaPY9Qmw+eI7Pq4lAN
	LhbpOyty2MY0Atns3yogumdm3yfCy4Ttdf3tg3Kw=
Received: by mx.zohomail.com with SMTPS id 1754873370723666.3021283578192;
	Sun, 10 Aug 2025 17:49:30 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] rust: irq: add &Device<Bound> argument to irq callbacks
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <CAH5fLghRi-QAqGdxOhPPdp6bMyGSuDifnxMFBn3a3NWzN4G4vQ@mail.gmail.com>
Date: Sun, 10 Aug 2025 21:49:14 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
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
 Dirk Behme <dirk.behme@gmail.com>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0303C763-76CC-456D-AB76-215DF253560C@collabora.com>
References: <20250721-irq-bound-device-v1-1-4fb2af418a63@google.com>
 <DCBBFAC5-A4B4-41BA-8732-32FA96EDE28E@collabora.com>
 <CAH5fLghRi-QAqGdxOhPPdp6bMyGSuDifnxMFBn3a3NWzN4G4vQ@mail.gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 21 Jul 2025, at 16:33, Alice Ryhl <aliceryhl@google.com> wrote:
>=20
> On Mon, Jul 21, 2025 at 9:14=E2=80=AFPM Daniel Almeida
> <daniel.almeida@collabora.com> wrote:
>>=20
>> Alice,
>>=20
>>> On 21 Jul 2025, at 11:38, Alice Ryhl <aliceryhl@google.com> wrote:
>>>=20
>>> When working with a bus device, many operations are only possible =
while
>>> the device is still bound. The &Device<Bound> type represents a =
proof in
>>> the type system that you are in a scope where the device is =
guaranteed
>>> to still be bound. Since we deregister irq callbacks when unbinding =
a
>>> device, if an irq callback is running, that implies that the device =
has
>>> not yet been unbound.
>>>=20
>>> To allow drivers to take advantage of that, add an additional =
argument
>>> to irq callbacks.
>>>=20
>>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>>> ---
>>> This patch is a follow-up to Daniel's irq series [1] that adds a
>>> &Device<Bound> argument to all irq callbacks. This allows you to use
>>> operations that are only safe on a bound device inside an irq =
callback.
>>>=20
>>> The patch is otherwise based on top of driver-core-next.
>>>=20
>>> [1]: =
https://lore.kernel.org/r/20250715-topics-tyr-request_irq2-v7-0-d469c0f37c=
07@collabora.com
>>=20
>> I am having a hard time applying this locally.
>=20
> Your irq series currently doesn't apply cleanly on top of
> driver-core-next and requires resolving a minor conflict. You can find
> the commits here:
> =
https://github.com/Darksonn/linux/commits/sent/20250721-irq-bound-device-c=
9fdbfdd8cd9-v1/

Ah, we=E2=80=99ve already discussed this, it seems.

>=20
>>> ///
>>> /// This function should be only used as the callback in =
`request_irq`.
>>> unsafe extern "C" fn handle_irq_callback<T: Handler>(_irq: i32, ptr: =
*mut c_void) -> c_uint {
>>> -    // SAFETY: `ptr` is a pointer to T set in `Registration::new`
>>> -    let handler =3D unsafe { &*(ptr as *const T) };
>>> -    T::handle(handler) as c_uint
>>> +    // SAFETY: `ptr` is a pointer to `Registration<T>` set in =
`Registration::new`
>>> +    let registration =3D unsafe { &*(ptr as *const Registration<T>) =
};
>>> +    // SAFETY: The irq callback is removed before the device is =
unbound, so the fact that the irq
>>> +    // callback is running implies that the device has not yet been =
unbound.
>>> +    let device =3D unsafe { registration.inner.device().as_bound() =
};
>>=20
>> Where was this function introduced? i.e. I am missing the change that =
brought
>> in RegistrationInner::device(), or maybe some Deref impl that would =
make this
>> possible?
>=20
> In this series:
> https://lore.kernel.org/all/20250713182737.64448-2-dakr@kernel.org/
>=20
>> Also, I wonder if we can't make the scope of this unsafe block =
smaller?
>=20
> I guess we could with an extra `let` statement.
>=20
> Alice



