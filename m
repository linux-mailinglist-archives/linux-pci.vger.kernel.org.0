Return-Path: <linux-pci+bounces-30516-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB8FAE6B35
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 17:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F0D74C3D60
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 15:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C522D9EC7;
	Tue, 24 Jun 2025 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3xVX5l0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227072D8769;
	Tue, 24 Jun 2025 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750778232; cv=none; b=I+mMM/VkAL9PPsxnTSkQ1QoOjLJQ8VxkfATSxlH9M6VrGpD5OEHlHJ5dOmEoU4SwqrsXsnucXJhyxzt/MOW74WxwoEhnUeNpgJgsIoq8gse/FSSXw7h4zLdXGsCtfI9mtLiABZaci4YDr0yQAPTbp9tR43bqo7w2cpjuC43wxTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750778232; c=relaxed/simple;
	bh=h+uujzYgLvm3l5drPRdBYXxVWiU4db2cSeKLGXFtkk8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=N1iNf1toe41V5RjPz6OPVfH4QMQvF9f29okT2CrB9j+fwkC90bm8o1KmCdVAefRgoLOQ83I3r7gk3R9sdk2USYaWyWD4MEatN0YSFvT/zQd2jYoyfeNAQW9iH2TQIP5FGaVbV4fnYMPs73ItC0V62+jHUQ484T83omS73ET/lPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3xVX5l0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D42C4CEE3;
	Tue, 24 Jun 2025 15:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750778231;
	bh=h+uujzYgLvm3l5drPRdBYXxVWiU4db2cSeKLGXFtkk8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=m3xVX5l0+OT1x+5xvcA8Y4/8hiXqr3P8TIaWwCzErH6iga0O4BWT0XL9sUjxLypiR
	 XlZKjBL84DqhvdyFuTqaCe7EYP6LSv/ncbmzvKd2SWfwA0W7OD2Xo7WnWcNVhhik2F
	 lPXw2Pa+dmIUGNofTdUvBZBCcPUxnwUzaQiA2KaVI6Dr9tXzZ5vaxBmrqiDsYZc8Hc
	 0lgnc+4WHzqKytl/iAEUhI96KX+2eso6W65AH6eDocDCJeODbUjoY3hnLsFo2vsNDE
	 JI4DcRAYOH6WClYKl4tyyvGIT9liwjvW8ubXMKtjOxxJjCZFOR6wBo4H2zuvsJtfNe
	 3+g37JvEyFTMw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Jun 2025 17:17:06 +0200
Message-Id: <DAUV31OTE7QC.3R9LSCO61CFR3@kernel.org>
Subject: Re: [PATCH v4 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>, "Alice Ryhl" <aliceryhl@google.com>
Cc: "Daniel Almeida" <daniel.almeida@collabora.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C2=B4nski?=
 <kwilczynski@kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250608-topics-tyr-request_irq-v4-3-81cb81fb8073@collabora.com> <aEbJt0YSc3-60OBY@pollux> <CAH5fLghDbrgO2PiKyKZ87UrtouG25xWhVP_YmcgO0fFcnvZRkQ@mail.gmail.com> <DAU0NHTHTDG4.2HNEABNAI8GHZ@kernel.org> <aFmPZMLGngAE_IHJ@tardis.local> <aFmodsQK6iatXKoZ@tardis.local> <DAU5TAFKJQOF.2DFO7YAHZA4V2@kernel.org> <DB7F39EC-5F7D-49DA-BF2B-6200998B45E2@collabora.com> <DAURVNHM7PKM.PLUFKFRVXR25@kernel.org> <CAH5fLggs=mUi0xAEuiLvZrua4qrMYjBDEmyK8xc-kkXVyUKRog@mail.gmail.com> <aFq3P_4XgP0dUrAS@Mac.home>
In-Reply-To: <aFq3P_4XgP0dUrAS@Mac.home>

On Tue Jun 24, 2025 at 4:33 PM CEST, Boqun Feng wrote:
> On Tue, Jun 24, 2025 at 02:50:23PM +0100, Alice Ryhl wrote:
>> On Tue, Jun 24, 2025 at 1:46=E2=80=AFPM Benno Lossin <lossin@kernel.org>=
 wrote:
>> > On Tue Jun 24, 2025 at 2:31 PM CEST, Daniel Almeida wrote:
>> > > On 23 Jun 2025, at 16:28, Benno Lossin <lossin@kernel.org> wrote:
>> > >> On Mon Jun 23, 2025 at 9:18 PM CEST, Boqun Feng wrote:
>> > >>>    try_pin_init!(&this in Self {
>> > >>>        handler,
>> > >>>        inner: Devres::new(
>> > >>>            dev,
>> > >>>            RegistrationInner {
>> > >>>                // Needs to use `handler` address as cookie, same f=
or
>> > >>>                // request_irq().
>> > >>>                cookie: &raw (*(this.as_ptr().cast()).handler),
>> > >>>                irq: {
>> > >>>                     to_result(unsafe { bindings::request_irq(...) =
})?;
>> > >>>  irq
>> > >>> }
>> > >>>             },
>> > >>>             GFP_KERNEL,
>> > >>>        )?,
>> > >>>        _pin: PhantomPinned
>> > >>>    })
>> > >>
>> > >> Well yes and no, with the Devres changes, the `cookie` can just be =
the
>> > >> address of the `RegistrationInner` & we can do it this way :)
>> > >>
>> > >> ---
>> > >> Cheers,
>> > >> Benno
>> > >
>> > >
>> > > No, we need this to be the address of the the whole thing (i.e.
>> > > Registration<T>), otherwise you can=E2=80=99t access the handler in =
the irq
>> > > callback.
>
> You only need the access of `handler` in the irq callback, right? I.e.
> passing the address of `handler` would suffice (of course you need
> to change the irq callback as well).
>
>> >
>> > Gotcha, so you keep the cookie field, but you should still be able to
>> > use `try_pin_init` & the devres improvements to avoid the use of
>> > `pin_init_from_closure`.
>>=20
>> It sounds like this is getting too complicated and that
>> `pin_init_from_closure` is the simpler way to go.

The current code is not correct and the version that Boqun has below
looks pretty correct (and much simpler).

> Even if we use `pin_init_from_closure`, we still need the other
> `try_pin_init` anyway for `Devres::new()` (or alternatively we can
> implement a `RegistrationInner::new()`).
>
> Below is what would look like with the Devres changes in mind:
>
>
>     try_pin_init!(&this in Self {
>         handler,
>         inner: <- Devres::new(
>             dev,
>             try_pin_init!( RegistrationInner {
>                 // Needs to use `handler` address as cookie, same for
>                 // request_irq().
>                 cookie: &raw (*(this.as_ptr().cast()).handler),
> 		// @Benno, would this "this" work here?

Yes.

>                 irq: {
>                      to_result(unsafe { bindings::request_irq(...) })?;
>                      irq
> 		}
>              }),
>         )?,
>         _pin: PhantomPinned
>     })

---
Cheers,
Benno

