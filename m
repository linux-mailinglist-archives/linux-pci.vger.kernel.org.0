Return-Path: <linux-pci+bounces-32675-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7ECDB0CAE7
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 21:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 247B63BE99A
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 19:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE0B226D04;
	Mon, 21 Jul 2025 19:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="WOvb9k+n"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B6321D3CD;
	Mon, 21 Jul 2025 19:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753125251; cv=pass; b=OOxV7aLVhaji0fz8eqk3Dq004QD7ZMRJXRAoGzslLGiBvs7o9fEEvgvcMYR9uIRORphz14kaQskoBHFE9l1ICbFtQZL9HRqyJ1SI0MpTUDkKZRzztOQeCZ+uv1lYBkUPnyF397I6PPyHYkRgsdwSjxv1aD3oHV10Ezw6lkeUDFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753125251; c=relaxed/simple;
	bh=0h0SQouOS+2/ecprirETTnJHVqGqbMtPui7LsXV271w=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=XaSa6EVXMR5LI4GZDb4ortmiG9qlMO9AgZ9Z7vvsk4PBOk1oKuUyYAvSCR9uq8apBiC43FInpZV8Ny9/dYiUyOEacYbeEWmW4IfqkzbDArm8hRLI3IClflu8U5eh5isRnXVl6pF/JorpgZe4iqZr9jyo7cZAguUUl1D2A0IAlC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=WOvb9k+n; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753125229; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UpwfzHxlshxi99vvcgDCdiC103IxjsttCljykHz944X1Pn2oh4lFWtl106yYg/5rNRqbNqk1yly5zqnSWM4JpQ6rl0MbKWDkH90pKl/C/GVgKpz2FrWbqqAJe8mR6hZpJ7+hyQLKl1f1uBzHSKbKjgxRUqJO+N6TXGMF4ex+lRw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753125229; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Ou8ViXoRaNCpJ3Be1xNdxsQtmjp1qCTLsimQKmnyD8w=; 
	b=FijhhAiYB1Q0oQ41pMY6WaVQyBRSUGzmvzdbPw1ATf5TBJ9CKljLonKuGC1mFIC4UZ1yDgy20YKL6Ff5CJsUW4CUk9tA413uIgBaZ23X86v6ppRUeW/bD2wtefu1UgIlhHrCliv5pqQjLge+nG5aocrn2waS/gSqMqHQC8IwpTY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753125229;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=Ou8ViXoRaNCpJ3Be1xNdxsQtmjp1qCTLsimQKmnyD8w=;
	b=WOvb9k+n7gaqvwL3fq68zIkrgXpoKVQcQi9cx2b3F1PD1Ea9kX/qNnJdxwD8fntr
	gwCoxV4k/N7cJbWENd91hYVWIuntQx+DVt+LKF9pvNtZzA2T8lacQ5b0/1LyUvKuAvf
	TSha05t+gRcuFVGBgL0PAeC4P+shtQJGnTQ7ZNOU=
Received: by mx.zohomail.com with SMTPS id 1753125226406624.466779770213;
	Mon, 21 Jul 2025 12:13:46 -0700 (PDT)
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
In-Reply-To: <20250721-irq-bound-device-v1-1-4fb2af418a63@google.com>
Date: Mon, 21 Jul 2025 16:13:30 -0300
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
Message-Id: <DCBBFAC5-A4B4-41BA-8732-32FA96EDE28E@collabora.com>
References: <20250721-irq-bound-device-v1-1-4fb2af418a63@google.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Alice,

> On 21 Jul 2025, at 11:38, Alice Ryhl <aliceryhl@google.com> wrote:
>=20
> When working with a bus device, many operations are only possible =
while
> the device is still bound. The &Device<Bound> type represents a proof =
in
> the type system that you are in a scope where the device is guaranteed
> to still be bound. Since we deregister irq callbacks when unbinding a
> device, if an irq callback is running, that implies that the device =
has
> not yet been unbound.
>=20
> To allow drivers to take advantage of that, add an additional argument
> to irq callbacks.
>=20
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> This patch is a follow-up to Daniel's irq series [1] that adds a
> &Device<Bound> argument to all irq callbacks. This allows you to use
> operations that are only safe on a bound device inside an irq =
callback.
>=20
> The patch is otherwise based on top of driver-core-next.
>=20
> [1]: =
https://lore.kernel.org/r/20250715-topics-tyr-request_irq2-v7-0-d469c0f37c=
07@collabora.com

I am having a hard time applying this locally.

> ///
> /// This function should be only used as the callback in =
`request_irq`.
> unsafe extern "C" fn handle_irq_callback<T: Handler>(_irq: i32, ptr: =
*mut c_void) -> c_uint {
> -    // SAFETY: `ptr` is a pointer to T set in `Registration::new`
> -    let handler =3D unsafe { &*(ptr as *const T) };
> -    T::handle(handler) as c_uint
> +    // SAFETY: `ptr` is a pointer to `Registration<T>` set in =
`Registration::new`
> +    let registration =3D unsafe { &*(ptr as *const Registration<T>) =
};
> +    // SAFETY: The irq callback is removed before the device is =
unbound, so the fact that the irq
> +    // callback is running implies that the device has not yet been =
unbound.
> +    let device =3D unsafe { registration.inner.device().as_bound() };

Where was this function introduced? i.e. I am missing the change that =
brought
in RegistrationInner::device(), or maybe some Deref impl that would make =
this
possible?

Also, I wonder if we can't make the scope of this unsafe block smaller?

=E2=80=94 Daniel



