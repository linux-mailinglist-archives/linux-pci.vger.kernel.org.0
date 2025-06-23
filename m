Return-Path: <linux-pci+bounces-30457-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65738AE4DA1
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 21:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 750063A4D96
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 19:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF432D3225;
	Mon, 23 Jun 2025 19:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYQaGryN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4441D9346;
	Mon, 23 Jun 2025 19:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750706939; cv=none; b=BRPaQa7dD/cR3FskRQ7XG93qaUozSMsmuOaUGgkaK5o3t4l9Gaj7a5AcdZ5rL9xZAAOhGLGcaETqqtpNht0gHwdVqQa8t2xCEc0wBFuGS8bZNlJOvSxbxwxp7jOQSy7GA5n3EotHbmL2i1Hb6QgaMnTMQvLQ5+WIuGtVAgkpb6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750706939; c=relaxed/simple;
	bh=abqYg+NPlH/Y1LdYWR56sWNYNyn4CS03rSTerLlXcJQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ZtSRa8Zc2D7XIJJUn3YFujMHjq3gGEtUNp6pWohGcNOzw/tRl+ecpUnA8+DIvLH5A6ewiIjgN54DDZPoVGsqAEaCFLoe53CXVf9VO5Wr5JNZBx/2dvpeGL5e8oFx56f9ZQW6dWzDmzXmjAGR2WgO/MJkvK5P5ccbVp49ZnOfODc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYQaGryN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB33EC4CEEA;
	Mon, 23 Jun 2025 19:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750706939;
	bh=abqYg+NPlH/Y1LdYWR56sWNYNyn4CS03rSTerLlXcJQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=WYQaGryNnFdWSc/jLwvOTlmVsGbC4vQR3Ay1+PM0Au2R8O43kDF1y51mqI7/ynea4
	 A/iWrMbikXQaVHXJTh2is/kPY4kEq5N3wfWM+6S0h23nhLH9EgdPh+zaos8+m4ysDG
	 1aHzS18o4qYT6Sv2alAe4pEgFe7u2Y9nmSK+p0bckvuh+d+ZIzIPhz+VQsJJor53Wk
	 3D1SQF4FawbW9guCCeBZZEjl+40zq9WDbP69tm7zV7NrT5aQtQkrmy1tloG/D4CSZI
	 PYE3OzkH9r1TsD6ppl/9Ojp/nrtFn/K4s92p5iBwQZwsiRKWBILzW0kF0Qcd1MQPjr
	 R0EKi4FwNimXQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Jun 2025 21:28:53 +0200
Message-Id: <DAU5TAFKJQOF.2DFO7YAHZA4V2@kernel.org>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Daniel Almeida" <daniel.almeida@collabora.com>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C2=B4nski?=
 <kwilczynski@kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250608-topics-tyr-request_irq-v4-0-81cb81fb8073@collabora.com> <20250608-topics-tyr-request_irq-v4-3-81cb81fb8073@collabora.com> <aEbJt0YSc3-60OBY@pollux> <CAH5fLghDbrgO2PiKyKZ87UrtouG25xWhVP_YmcgO0fFcnvZRkQ@mail.gmail.com> <DAU0NHTHTDG4.2HNEABNAI8GHZ@kernel.org> <aFmPZMLGngAE_IHJ@tardis.local> <aFmodsQK6iatXKoZ@tardis.local>
In-Reply-To: <aFmodsQK6iatXKoZ@tardis.local>

On Mon Jun 23, 2025 at 9:18 PM CEST, Boqun Feng wrote:
> On Mon, Jun 23, 2025 at 10:31:16AM -0700, Boqun Feng wrote:
>> On Mon, Jun 23, 2025 at 05:26:14PM +0200, Benno Lossin wrote:
>> > On Mon Jun 23, 2025 at 5:10 PM CEST, Alice Ryhl wrote:
>> > > On Mon, Jun 9, 2025 at 12:47=E2=80=AFPM Danilo Krummrich <dakr@kerne=
l.org> wrote:
>> > >> On Sun, Jun 08, 2025 at 07:51:08PM -0300, Daniel Almeida wrote:
>> > >> > +        dev: &'a Device<Bound>,
>> > >> > +        irq: u32,
>> > >> > +        flags: Flags,
>> > >> > +        name: &'static CStr,
>> > >> > +        handler: T,
>> > >> > +    ) -> impl PinInit<Self, Error> + 'a {
>> > >> > +        let closure =3D move |slot: *mut Self| {
>> > >> > +            // SAFETY: The slot passed to pin initializer is val=
id for writing.
>> > >> > +            unsafe {
>> > >> > +                slot.write(Self {
>> > >> > +                    inner: Devres::new(
>> > >> > +                        dev,
>> > >> > +                        RegistrationInner {
>> > >> > +                            irq,
>> > >> > +                            cookie: slot.cast(),
>> > >> > +                        },
>> > >> > +                        GFP_KERNEL,
>> > >> > +                    )?,
>> > >> > +                    handler,
>> > >> > +                    _pin: PhantomPinned,
>> > >> > +                })
>> > >> > +            };
>> > >> > +
>> > >> > +            // SAFETY:
>> > >> > +            // - The callbacks are valid for use with request_ir=
q.
>> > >> > +            // - If this succeeds, the slot is guaranteed to be =
valid until the
>> > >> > +            // destructor of Self runs, which will deregister th=
e callbacks
>> > >> > +            // before the memory location becomes invalid.
>> > >> > +            let res =3D to_result(unsafe {
>> > >> > +                bindings::request_irq(
>> > >> > +                    irq,
>> > >> > +                    Some(handle_irq_callback::<T>),
>> > >> > +                    flags.into_inner() as usize,
>> > >> > +                    name.as_char_ptr(),
>> > >> > +                    slot.cast(),
>> > >> > +                )
>> > >> > +            });
>> > >> > +
>> > >> > +            if res.is_err() {
>> > >> > +                // SAFETY: We are returning an error, so we can =
destroy the slot.
>> > >> > +                unsafe { core::ptr::drop_in_place(&raw mut (*slo=
t).handler) };
>> > >> > +            }
>> > >> > +
>> > >> > +            res
>> > >> > +        };
>> > >> > +
>> > >> > +        // SAFETY:
>> > >> > +        // - if this returns Ok, then every field of `slot` is f=
ully
>> > >> > +        // initialized.
>> > >> > +        // - if this returns an error, then the slot does not ne=
ed to remain
>> > >> > +        // valid.
>> > >> > +        unsafe { pin_init_from_closure(closure) }
>> > >>
>> > >> Can't we use try_pin_init!() instead, move request_irq() into the i=
nitializer of
>> > >> RegistrationInner and initialize inner last?
>> > >
>> > > We need a pointer to the entire struct when calling
>> > > bindings::request_irq. I'm not sure this allows you to easily get on=
e?
>> > > I don't think using container_of! here is worth it.
>> >=20
>> > There is the `&this in` syntax (`this` is of type `NonNull<Self>`):
>> >=20
>> >     try_pin_init!(&this in Self {
>> >         inner: Devres::new(
>> >             dev,
>> >             RegistrationInner {
>> >                 irq,
>> >                 cookie: this.as_ptr().cast(),
>> >             },
>> >             GFP_KERNEL,
>> >         )?,
>> >         handler,
>> >         _pin: {
>> >             to_result(unsafe {
>> >                 bindings::request_irq(
>> >                     irq,
>> >                     Some(handle_irq_callback::<T>),
>> >                     flags.into_inner() as usize,
>> >                     name.as_char_ptr(),
>> >                     slot.as_ptr().cast(),
>>=20
>> this is "this" instead of "slot", right?
>>=20
>> >                 )
>> >             })?;
>> >             PhantomPinned
>> >         },
>> >     })
>> >=20
>> > Last time around, I also asked this question and you replied with that
>> > we need to abort the initializer when `request_irq` returns false and
>> > avoid running `Self::drop` (thus we can't do it using `pin_chain`).
>> >=20
>> > I asked what we could do instead and you mentioned the `_: {}`
>> > initializers and those would indeed solve it, but we can abuse the
>> > `_pin` field for that :)
>> >=20
>>=20
>> Hmm.. but if request_irq() fails, aren't we going to call `drop` on
>> `inner`, which drops the `Devres` which will eventually call
>> `RegistrationInner::drop()`? And that's a `free_irq()` without
>> `request_irq()` succeeded.
>>=20
>
> This may however work ;-) Because at `request_irq()` time, all it needs
> is ready, and if it fails, `RegistrationInner` won't construct.
>
>     try_pin_init!(&this in Self {
>         handler,
>         inner: Devres::new(
>             dev,
>             RegistrationInner {
>                 // Needs to use `handler` address as cookie, same for
>                 // request_irq().
>                 cookie: &raw (*(this.as_ptr().cast()).handler),
>                 irq: {
>                      to_result(unsafe { bindings::request_irq(...) })?;
> 					 irq
> 				}
>              },
>              GFP_KERNEL,
>         )?,
>         _pin: PhantomPinned
>     })

Well yes and no, with the Devres changes, the `cookie` can just be the
address of the `RegistrationInner` & we can do it this way :)

---
Cheers,
Benno

