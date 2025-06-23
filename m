Return-Path: <linux-pci+bounces-30410-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B8CAE4875
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 17:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05D3A7A7A99
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 15:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB5728C868;
	Mon, 23 Jun 2025 15:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxnO0C6b"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F791CD1F;
	Mon, 23 Jun 2025 15:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750692379; cv=none; b=ZIvYoEhdYp5DSx24l7k5eauxupTbLFWD4KfpAzJcwEMU5EmS5trdIq9JzVw1Qg2Ek7kQlRWK6v93S8LqHZrObIPHBSWa1pzENwqqNtzv7G0fgY0sZDbc6pyzt5tH+UPearkAu7gSwUq73ixdRJqJQObTZMk9cfUyDxrpt5fzPME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750692379; c=relaxed/simple;
	bh=+hXT9NgKl54nrfoBfadxq8ETqumOuW4V7oUlv+01yZI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=BmFZjwiqk/juWPO2+Q0QETpGHMf+KVpSWQA7gmTpeymyCDo1JJTNOpnweQK6PF3vgcO+UZzIIF5u17cWk+Lx+Tbz52eenDbOop9IuHZ8BLFQSWiHwzRw8EWbeps1nG7I1maJnOVcPXtNy5HEljmd0ruclmE7oZ7nnYMXIgvSs4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxnO0C6b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D822AC4CEEF;
	Mon, 23 Jun 2025 15:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750692379;
	bh=+hXT9NgKl54nrfoBfadxq8ETqumOuW4V7oUlv+01yZI=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=JxnO0C6bM+y5mdsqgVRs6SRVQiKmcNmRb2yI+wAPQSM6DDHueeuhxpQ6IP4ocbp8c
	 X6RfZr128BtMRyabHNVxToqBNi34raB6iTkfilIYgOheIfPxjKD3Gsvd3vMLJJgtw5
	 G9eqIXf40iVMXZRYibCpCUhV7hfn7f83khSgSuQQghbW/BdWuCZ65x13tDmTH781M1
	 49KaoKy8Ibpd1dqP8tYndEwEus+zBNekkJdor0Cz3ngn/LaTPRJ5xt51H4ke/txB3g
	 30EZzcOS+fzarwnHX/9cFzXQV1X1mndQS6BZuwl09lYlwxYDXLo6GHF/SDbZNHWJNc
	 YBz4VT1/Wm5GQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Jun 2025 17:26:14 +0200
Message-Id: <DAU0NHTHTDG4.2HNEABNAI8GHZ@kernel.org>
Subject: Re: [PATCH v4 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
From: "Benno Lossin" <lossin@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>, "Danilo Krummrich"
 <dakr@kernel.org>
Cc: "Daniel Almeida" <daniel.almeida@collabora.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250608-topics-tyr-request_irq-v4-0-81cb81fb8073@collabora.com> <20250608-topics-tyr-request_irq-v4-3-81cb81fb8073@collabora.com> <aEbJt0YSc3-60OBY@pollux> <CAH5fLghDbrgO2PiKyKZ87UrtouG25xWhVP_YmcgO0fFcnvZRkQ@mail.gmail.com>
In-Reply-To: <CAH5fLghDbrgO2PiKyKZ87UrtouG25xWhVP_YmcgO0fFcnvZRkQ@mail.gmail.com>

On Mon Jun 23, 2025 at 5:10 PM CEST, Alice Ryhl wrote:
> On Mon, Jun 9, 2025 at 12:47=E2=80=AFPM Danilo Krummrich <dakr@kernel.org=
> wrote:
>> On Sun, Jun 08, 2025 at 07:51:08PM -0300, Daniel Almeida wrote:
>> > +        dev: &'a Device<Bound>,
>> > +        irq: u32,
>> > +        flags: Flags,
>> > +        name: &'static CStr,
>> > +        handler: T,
>> > +    ) -> impl PinInit<Self, Error> + 'a {
>> > +        let closure =3D move |slot: *mut Self| {
>> > +            // SAFETY: The slot passed to pin initializer is valid fo=
r writing.
>> > +            unsafe {
>> > +                slot.write(Self {
>> > +                    inner: Devres::new(
>> > +                        dev,
>> > +                        RegistrationInner {
>> > +                            irq,
>> > +                            cookie: slot.cast(),
>> > +                        },
>> > +                        GFP_KERNEL,
>> > +                    )?,
>> > +                    handler,
>> > +                    _pin: PhantomPinned,
>> > +                })
>> > +            };
>> > +
>> > +            // SAFETY:
>> > +            // - The callbacks are valid for use with request_irq.
>> > +            // - If this succeeds, the slot is guaranteed to be valid=
 until the
>> > +            // destructor of Self runs, which will deregister the cal=
lbacks
>> > +            // before the memory location becomes invalid.
>> > +            let res =3D to_result(unsafe {
>> > +                bindings::request_irq(
>> > +                    irq,
>> > +                    Some(handle_irq_callback::<T>),
>> > +                    flags.into_inner() as usize,
>> > +                    name.as_char_ptr(),
>> > +                    slot.cast(),
>> > +                )
>> > +            });
>> > +
>> > +            if res.is_err() {
>> > +                // SAFETY: We are returning an error, so we can destr=
oy the slot.
>> > +                unsafe { core::ptr::drop_in_place(&raw mut (*slot).ha=
ndler) };
>> > +            }
>> > +
>> > +            res
>> > +        };
>> > +
>> > +        // SAFETY:
>> > +        // - if this returns Ok, then every field of `slot` is fully
>> > +        // initialized.
>> > +        // - if this returns an error, then the slot does not need to=
 remain
>> > +        // valid.
>> > +        unsafe { pin_init_from_closure(closure) }
>>
>> Can't we use try_pin_init!() instead, move request_irq() into the initia=
lizer of
>> RegistrationInner and initialize inner last?
>
> We need a pointer to the entire struct when calling
> bindings::request_irq. I'm not sure this allows you to easily get one?
> I don't think using container_of! here is worth it.

There is the `&this in` syntax (`this` is of type `NonNull<Self>`):

    try_pin_init!(&this in Self {
        inner: Devres::new(
            dev,
            RegistrationInner {
                irq,
                cookie: this.as_ptr().cast(),
            },
            GFP_KERNEL,
        )?,
        handler,
        _pin: {
            to_result(unsafe {
                bindings::request_irq(
                    irq,
                    Some(handle_irq_callback::<T>),
                    flags.into_inner() as usize,
                    name.as_char_ptr(),
                    slot.as_ptr().cast(),
                )
            })?;
            PhantomPinned
        },
    })

Last time around, I also asked this question and you replied with that
we need to abort the initializer when `request_irq` returns false and
avoid running `Self::drop` (thus we can't do it using `pin_chain`).

I asked what we could do instead and you mentioned the `_: {}`
initializers and those would indeed solve it, but we can abuse the
`_pin` field for that :)

---
Cheers,
Benno

