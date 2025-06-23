Return-Path: <linux-pci+bounces-30455-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDF4AE4D92
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 21:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78BCD1897B30
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 19:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64047288511;
	Mon, 23 Jun 2025 19:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FeO73gcT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366891E1DFE;
	Mon, 23 Jun 2025 19:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750706729; cv=none; b=ofqf9s6Lbeic53/ynnKIX7UzNRO4VRAOoo2+u+vuwI+0rJzCoNT8Fqq2cLdZRtEMnnnKQW+nU/FZsps+eZYAtiMM/DZj1Rey+HeftHUvycrR2UOhuy2iRzaEMvXGCtA7Ws+o2JLCewZuOqNWX94uC8ms07WtDB3dNYj+I0bVZ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750706729; c=relaxed/simple;
	bh=JmZmp75kdGDdC1XA59SnUh+LpRTyEr40586zQDgBptY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KJeJqsBOy5BXTL7auIjZ7fFEtDN9C24JCxoq45liPb5HXqWED3o9OewXTiPSp3QEq7lrbcpWBvuU8fIVUC1dzoSXnpgcPVx4BIwRrvwTiQ1O0E66RLbqo7cdDsjgCsSGwci1FxiLw0VRkI6GACIoODju8da0ILQRyeAInxpF5FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FeO73gcT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547A4C4CEEA;
	Mon, 23 Jun 2025 19:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750706728;
	bh=JmZmp75kdGDdC1XA59SnUh+LpRTyEr40586zQDgBptY=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=FeO73gcTq8XH956Ae2nclMOw3mYyjz70fg7p0LF9aZlXd6kO/1HiJQSWiFn0uY7ki
	 7b4gx53xXqSJkFsDnTjij6+FDihLjATgdy/aF7lIhT7HiIY5nR5iE+G0jWt/HKc2Mm
	 8OWFhhrbaj6Cnho8Pf7RfnSINxMjlTm+qSjumWA3izVXPqS0N9fUh6xYeSR8rXg7US
	 eOvC+cWVT268sAjaTzVJ5+dC2OMHmT2G+6VkZ5KfVHCAZXhE3A1+YLx7zvM+etA8Qo
	 JMvHdnQ2Whjkoh+TetyiZbL6Zv7I80PBflBpPUePpXAR1ReB1RdyAP3v2GKF5JzK+7
	 K++7/nOKntrCw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Jun 2025 21:25:23 +0200
Message-Id: <DAU5QLRJBYMS.2OQ83W31ETX07@kernel.org>
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
References: <20250608-topics-tyr-request_irq-v4-0-81cb81fb8073@collabora.com> <20250608-topics-tyr-request_irq-v4-3-81cb81fb8073@collabora.com> <aEbJt0YSc3-60OBY@pollux> <CAH5fLghDbrgO2PiKyKZ87UrtouG25xWhVP_YmcgO0fFcnvZRkQ@mail.gmail.com> <DAU0NHTHTDG4.2HNEABNAI8GHZ@kernel.org> <aFmPZMLGngAE_IHJ@tardis.local>
In-Reply-To: <aFmPZMLGngAE_IHJ@tardis.local>

On Mon Jun 23, 2025 at 7:31 PM CEST, Boqun Feng wrote:
> On Mon, Jun 23, 2025 at 05:26:14PM +0200, Benno Lossin wrote:
>> On Mon Jun 23, 2025 at 5:10 PM CEST, Alice Ryhl wrote:
>> > On Mon, Jun 9, 2025 at 12:47=E2=80=AFPM Danilo Krummrich <dakr@kernel.=
org> wrote:
>> >> On Sun, Jun 08, 2025 at 07:51:08PM -0300, Daniel Almeida wrote:
>> >> > +        dev: &'a Device<Bound>,
>> >> > +        irq: u32,
>> >> > +        flags: Flags,
>> >> > +        name: &'static CStr,
>> >> > +        handler: T,
>> >> > +    ) -> impl PinInit<Self, Error> + 'a {
>> >> > +        let closure =3D move |slot: *mut Self| {
>> >> > +            // SAFETY: The slot passed to pin initializer is valid=
 for writing.
>> >> > +            unsafe {
>> >> > +                slot.write(Self {
>> >> > +                    inner: Devres::new(
>> >> > +                        dev,
>> >> > +                        RegistrationInner {
>> >> > +                            irq,
>> >> > +                            cookie: slot.cast(),
>> >> > +                        },
>> >> > +                        GFP_KERNEL,
>> >> > +                    )?,
>> >> > +                    handler,
>> >> > +                    _pin: PhantomPinned,
>> >> > +                })
>> >> > +            };
>> >> > +
>> >> > +            // SAFETY:
>> >> > +            // - The callbacks are valid for use with request_irq.
>> >> > +            // - If this succeeds, the slot is guaranteed to be va=
lid until the
>> >> > +            // destructor of Self runs, which will deregister the =
callbacks
>> >> > +            // before the memory location becomes invalid.
>> >> > +            let res =3D to_result(unsafe {
>> >> > +                bindings::request_irq(
>> >> > +                    irq,
>> >> > +                    Some(handle_irq_callback::<T>),
>> >> > +                    flags.into_inner() as usize,
>> >> > +                    name.as_char_ptr(),
>> >> > +                    slot.cast(),
>> >> > +                )
>> >> > +            });
>> >> > +
>> >> > +            if res.is_err() {
>> >> > +                // SAFETY: We are returning an error, so we can de=
stroy the slot.
>> >> > +                unsafe { core::ptr::drop_in_place(&raw mut (*slot)=
.handler) };
>> >> > +            }
>> >> > +
>> >> > +            res
>> >> > +        };
>> >> > +
>> >> > +        // SAFETY:
>> >> > +        // - if this returns Ok, then every field of `slot` is ful=
ly
>> >> > +        // initialized.
>> >> > +        // - if this returns an error, then the slot does not need=
 to remain
>> >> > +        // valid.
>> >> > +        unsafe { pin_init_from_closure(closure) }
>> >>
>> >> Can't we use try_pin_init!() instead, move request_irq() into the ini=
tializer of
>> >> RegistrationInner and initialize inner last?
>> >
>> > We need a pointer to the entire struct when calling
>> > bindings::request_irq. I'm not sure this allows you to easily get one?
>> > I don't think using container_of! here is worth it.
>>=20
>> There is the `&this in` syntax (`this` is of type `NonNull<Self>`):
>>=20
>>     try_pin_init!(&this in Self {
>>         inner: Devres::new(
>>             dev,
>>             RegistrationInner {
>>                 irq,
>>                 cookie: this.as_ptr().cast(),
>>             },
>>             GFP_KERNEL,
>>         )?,
>>         handler,
>>         _pin: {
>>             to_result(unsafe {
>>                 bindings::request_irq(
>>                     irq,
>>                     Some(handle_irq_callback::<T>),
>>                     flags.into_inner() as usize,
>>                     name.as_char_ptr(),
>>                     slot.as_ptr().cast(),
>
> this is "this" instead of "slot", right?
>
>>                 )
>>             })?;
>>             PhantomPinned
>>         },
>>     })
>>=20
>> Last time around, I also asked this question and you replied with that
>> we need to abort the initializer when `request_irq` returns false and
>> avoid running `Self::drop` (thus we can't do it using `pin_chain`).
>>=20
>> I asked what we could do instead and you mentioned the `_: {}`
>> initializers and those would indeed solve it, but we can abuse the
>> `_pin` field for that :)
>>=20
>
> Hmm.. but if request_irq() fails, aren't we going to call `drop` on
> `inner`, which drops the `Devres` which will eventually call
> `RegistrationInner::drop()`? And that's a `free_irq()` without
> `request_irq()` succeeded.

That is indeed correct :(

But hold on, we aren't allowed to forget the `Devres`, it's a pinned
type and thus the pin guarantee is that it must be dropped before the
underlying memory is freed. So the current version is unsound.

---
Cheers,
Benno

