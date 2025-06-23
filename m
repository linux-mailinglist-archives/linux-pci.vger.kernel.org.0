Return-Path: <linux-pci+bounces-30456-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B82AE4D9D
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 21:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1734517D82D
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 19:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC6D2D3A60;
	Mon, 23 Jun 2025 19:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mr4w0W6x"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896461E1DFE;
	Mon, 23 Jun 2025 19:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750706868; cv=none; b=Y3uY/cRq79//+cfbD39Y0twHxNsjzdBE9z4DLP9HxsBorncRczX/xe8DrWSR9oR+MObgGVynRWLsKktGGF+DM6YKpI7QxJ8QxQFQ9IrBd9daBz8+9GhW7zii6AYF33ZFKKa8XvDWvmEuUXvjIfrZTd2ORHe/hHN+ZehwaIOSL0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750706868; c=relaxed/simple;
	bh=6bacQ/7kwZh1TXvsDqlvaDV9Gh52RxpWHPFij2atGIg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=abP7+8IpszoUkw+pFxHri+QhckDmhThhAdU7wsDA90yJfEorc/U/uLbxu2fOfN9JWxvro09XMFB5MgyqOH2UMLmWzH02pU1D3ikS/kismmBOXOwaq8H5GvzaG7KHa4EYfwxzBR8LqkvSY2AhKCGgdZhvGTTnD9l704Uchs7XCp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mr4w0W6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBD0C4CEEA;
	Mon, 23 Jun 2025 19:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750706868;
	bh=6bacQ/7kwZh1TXvsDqlvaDV9Gh52RxpWHPFij2atGIg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=mr4w0W6xzFpKRv4+CcW9AbbxoNWff/jeWxk+DBTTGMh5Tbvq6iG38eK2A5wC+50l+
	 bQeL1niehWw/aTwRY7/pnOdv+iQ/CInrm2sfn3/N7HGbaQOg+0U7s+K44xcPy9hTTp
	 No8CTqCNqdQP7mEL/iHhxg6WZoe77OXQEvnIWI+z4Q5DJBpNcLp7bKDd8EKw6jSNwz
	 wREitik3RPa/8z9abDN1E/TS5L5ja/soFXqkG4GRkRZ0aFzMepvHf0gw9pc5EvXrYp
	 7ZLZFUzIeoyGGD7gOtULZepZ53gcYdhWBdwDCN0mQC1zp4kJqWh29l7aq/wANW9reV
	 R+Ast1R4DguMQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Jun 2025 21:27:43 +0200
Message-Id: <DAU5SDZWTB21.2S8F08BVX1ZE1@kernel.org>
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
References: <20250608-topics-tyr-request_irq-v4-0-81cb81fb8073@collabora.com> <20250608-topics-tyr-request_irq-v4-3-81cb81fb8073@collabora.com> <aEbJt0YSc3-60OBY@pollux> <CAH5fLghDbrgO2PiKyKZ87UrtouG25xWhVP_YmcgO0fFcnvZRkQ@mail.gmail.com> <DAU0NHTHTDG4.2HNEABNAI8GHZ@kernel.org> <aFmPZMLGngAE_IHJ@tardis.local> <DAU5QLRJBYMS.2OQ83W31ETX07@kernel.org>
In-Reply-To: <DAU5QLRJBYMS.2OQ83W31ETX07@kernel.org>

On Mon Jun 23, 2025 at 9:25 PM CEST, Benno Lossin wrote:
> On Mon Jun 23, 2025 at 7:31 PM CEST, Boqun Feng wrote:
>> On Mon, Jun 23, 2025 at 05:26:14PM +0200, Benno Lossin wrote:
>>> On Mon Jun 23, 2025 at 5:10 PM CEST, Alice Ryhl wrote:
>>> > On Mon, Jun 9, 2025 at 12:47=E2=80=AFPM Danilo Krummrich <dakr@kernel=
.org> wrote:
>>> >> On Sun, Jun 08, 2025 at 07:51:08PM -0300, Daniel Almeida wrote:
>>> >> > +        dev: &'a Device<Bound>,
>>> >> > +        irq: u32,
>>> >> > +        flags: Flags,
>>> >> > +        name: &'static CStr,
>>> >> > +        handler: T,
>>> >> > +    ) -> impl PinInit<Self, Error> + 'a {
>>> >> > +        let closure =3D move |slot: *mut Self| {
>>> >> > +            // SAFETY: The slot passed to pin initializer is vali=
d for writing.
>>> >> > +            unsafe {
>>> >> > +                slot.write(Self {
>>> >> > +                    inner: Devres::new(
>>> >> > +                        dev,
>>> >> > +                        RegistrationInner {
>>> >> > +                            irq,
>>> >> > +                            cookie: slot.cast(),
>>> >> > +                        },
>>> >> > +                        GFP_KERNEL,
>>> >> > +                    )?,
>>> >> > +                    handler,
>>> >> > +                    _pin: PhantomPinned,
>>> >> > +                })
>>> >> > +            };
>>> >> > +
>>> >> > +            // SAFETY:
>>> >> > +            // - The callbacks are valid for use with request_irq=
.
>>> >> > +            // - If this succeeds, the slot is guaranteed to be v=
alid until the
>>> >> > +            // destructor of Self runs, which will deregister the=
 callbacks
>>> >> > +            // before the memory location becomes invalid.
>>> >> > +            let res =3D to_result(unsafe {
>>> >> > +                bindings::request_irq(
>>> >> > +                    irq,
>>> >> > +                    Some(handle_irq_callback::<T>),
>>> >> > +                    flags.into_inner() as usize,
>>> >> > +                    name.as_char_ptr(),
>>> >> > +                    slot.cast(),
>>> >> > +                )
>>> >> > +            });
>>> >> > +
>>> >> > +            if res.is_err() {
>>> >> > +                // SAFETY: We are returning an error, so we can d=
estroy the slot.
>>> >> > +                unsafe { core::ptr::drop_in_place(&raw mut (*slot=
).handler) };
>>> >> > +            }
>>> >> > +
>>> >> > +            res
>>> >> > +        };
>>> >> > +
>>> >> > +        // SAFETY:
>>> >> > +        // - if this returns Ok, then every field of `slot` is fu=
lly
>>> >> > +        // initialized.
>>> >> > +        // - if this returns an error, then the slot does not nee=
d to remain
>>> >> > +        // valid.
>>> >> > +        unsafe { pin_init_from_closure(closure) }
>>> >>
>>> >> Can't we use try_pin_init!() instead, move request_irq() into the in=
itializer of
>>> >> RegistrationInner and initialize inner last?
>>> >
>>> > We need a pointer to the entire struct when calling
>>> > bindings::request_irq. I'm not sure this allows you to easily get one=
?
>>> > I don't think using container_of! here is worth it.
>>>=20
>>> There is the `&this in` syntax (`this` is of type `NonNull<Self>`):
>>>=20
>>>     try_pin_init!(&this in Self {
>>>         inner: Devres::new(
>>>             dev,
>>>             RegistrationInner {
>>>                 irq,
>>>                 cookie: this.as_ptr().cast(),
>>>             },
>>>             GFP_KERNEL,
>>>         )?,
>>>         handler,
>>>         _pin: {
>>>             to_result(unsafe {
>>>                 bindings::request_irq(
>>>                     irq,
>>>                     Some(handle_irq_callback::<T>),
>>>                     flags.into_inner() as usize,
>>>                     name.as_char_ptr(),
>>>                     slot.as_ptr().cast(),
>>
>> this is "this" instead of "slot", right?
>>
>>>                 )
>>>             })?;
>>>             PhantomPinned
>>>         },
>>>     })
>>>=20
>>> Last time around, I also asked this question and you replied with that
>>> we need to abort the initializer when `request_irq` returns false and
>>> avoid running `Self::drop` (thus we can't do it using `pin_chain`).
>>>=20
>>> I asked what we could do instead and you mentioned the `_: {}`
>>> initializers and those would indeed solve it, but we can abuse the
>>> `_pin` field for that :)
>>>=20
>>
>> Hmm.. but if request_irq() fails, aren't we going to call `drop` on
>> `inner`, which drops the `Devres` which will eventually call
>> `RegistrationInner::drop()`? And that's a `free_irq()` without
>> `request_irq()` succeeded.
>
> That is indeed correct :(
>
> But hold on, we aren't allowed to forget the `Devres`, it's a pinned
> type and thus the pin guarantee is that it must be dropped before the
> underlying memory is freed. So the current version is unsound.

Ah oops, already had the devres improvements in mind, this version uses
the non-pinned devres, which when not dropped will leak an `Arc` in the
`DevresInner`... Which also isn't desired.

---
Cheers,
Benno

