Return-Path: <linux-pci+bounces-30503-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2833BAE651C
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 14:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FF9C3BCFAF
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 12:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748F2291C03;
	Tue, 24 Jun 2025 12:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="ISpPr20l"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8525527D77B;
	Tue, 24 Jun 2025 12:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750768341; cv=pass; b=KOD5+iw97tIkYY6326RRjEtjJxwGED7jWWqJrSoos+xfGmoOn4+Ldo7UdtzkfVurycZim8iumvrtdSYplJSJwuK3RRqdI5vR01vztlTZneuFI17ojPjyVvls7VZMbc8isKZaVYoeYHTLyVQzu7GAhJyhK9A0/hvdLHUpj09fpgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750768341; c=relaxed/simple;
	bh=/IVY3SRvdgqomqV+YcXPg7x2Uj3Au0mfQNdUpIf6cxs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=OUC2oTh3bBbrJSREEBbmEHV0V7YRyJ6lReBSlQbk5x1oyDs05vTlkMYZYKXeCcFbQtbC+VuPc5FHBoljjhrp7oKQuBU1/3qDjfxBKRaE/+tydbOjkW+ShT4W5zFRbavWbM+33nscdL6u97S4nKkirXU2cXNFfbjlwAnrm/20FUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=ISpPr20l; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1750768302; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ss7szBl0C6vo5/TtI4TTs/5e8FEcW6SuOFLmtDIZ/tSzqaTsyK0gLgxc41jpiSuaRZ7BqZXfetf4ddWVqGXM27sLVGomXH3uni4Ygcy+Y2wXgQFASKUc8IK+PaGp5T+tDRWB9iEXdx7T95vfgZhXrm9Z3vFB8XglCPMH4MWyAAg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750768302; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Ie2joQ92AW905Mdsf8/ZIdEOpEY3fNe+VdtRpB8fjJc=; 
	b=hRn2P0ElWzxqttX7k1AnHLgwprLRHHn1k0DRjVn+6acu5rpzMNisyZvh7+UrcxzUxbwEnkz220rhJ6Ikot8zQkGiCT3AnYxqajbJfaenUEeQ9bz0J1nYcQfy1dW+5SASmKmda/mh0OIQK66MXsj39Da6VY6u63ubSYrndHNU7JU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750768302;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=Ie2joQ92AW905Mdsf8/ZIdEOpEY3fNe+VdtRpB8fjJc=;
	b=ISpPr20lQACBPMWyHmiigWOfLBud7LH+hg2ayxLBHprKY37qRS7jhw4Kocbvv2oT
	ISCgvv4RkURorlcZSCOg2vTpv3sQE9m5+vAzjoobVbuJw67iSLDh1C5NHYR8EttsxuJ
	nfdFtkSBxww05OMTQqKTfn21CJzWVQtfnYcEaBHA=
Received: by mx.zohomail.com with SMTPS id 1750768300488400.79605759042045;
	Tue, 24 Jun 2025 05:31:40 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v4 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <DAU5TAFKJQOF.2DFO7YAHZA4V2@kernel.org>
Date: Tue, 24 Jun 2025 09:31:24 -0300
Cc: Boqun Feng <boqun.feng@gmail.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C2=B4nski?= <kwilczynski@kernel.org>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DB7F39EC-5F7D-49DA-BF2B-6200998B45E2@collabora.com>
References: <20250608-topics-tyr-request_irq-v4-0-81cb81fb8073@collabora.com>
 <20250608-topics-tyr-request_irq-v4-3-81cb81fb8073@collabora.com>
 <aEbJt0YSc3-60OBY@pollux>
 <CAH5fLghDbrgO2PiKyKZ87UrtouG25xWhVP_YmcgO0fFcnvZRkQ@mail.gmail.com>
 <DAU0NHTHTDG4.2HNEABNAI8GHZ@kernel.org> <aFmPZMLGngAE_IHJ@tardis.local>
 <aFmodsQK6iatXKoZ@tardis.local> <DAU5TAFKJQOF.2DFO7YAHZA4V2@kernel.org>
To: Benno Lossin <lossin@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 23 Jun 2025, at 16:28, Benno Lossin <lossin@kernel.org> wrote:
>=20
> On Mon Jun 23, 2025 at 9:18 PM CEST, Boqun Feng wrote:
>> On Mon, Jun 23, 2025 at 10:31:16AM -0700, Boqun Feng wrote:
>>> On Mon, Jun 23, 2025 at 05:26:14PM +0200, Benno Lossin wrote:
>>>> On Mon Jun 23, 2025 at 5:10 PM CEST, Alice Ryhl wrote:
>>>>> On Mon, Jun 9, 2025 at 12:47=E2=80=AFPM Danilo Krummrich =
<dakr@kernel.org> wrote:
>>>>>> On Sun, Jun 08, 2025 at 07:51:08PM -0300, Daniel Almeida wrote:
>>>>>>> +        dev: &'a Device<Bound>,
>>>>>>> +        irq: u32,
>>>>>>> +        flags: Flags,
>>>>>>> +        name: &'static CStr,
>>>>>>> +        handler: T,
>>>>>>> +    ) -> impl PinInit<Self, Error> + 'a {
>>>>>>> +        let closure =3D move |slot: *mut Self| {
>>>>>>> +            // SAFETY: The slot passed to pin initializer is =
valid for writing.
>>>>>>> +            unsafe {
>>>>>>> +                slot.write(Self {
>>>>>>> +                    inner: Devres::new(
>>>>>>> +                        dev,
>>>>>>> +                        RegistrationInner {
>>>>>>> +                            irq,
>>>>>>> +                            cookie: slot.cast(),
>>>>>>> +                        },
>>>>>>> +                        GFP_KERNEL,
>>>>>>> +                    )?,
>>>>>>> +                    handler,
>>>>>>> +                    _pin: PhantomPinned,
>>>>>>> +                })
>>>>>>> +            };
>>>>>>> +
>>>>>>> +            // SAFETY:
>>>>>>> +            // - The callbacks are valid for use with =
request_irq.
>>>>>>> +            // - If this succeeds, the slot is guaranteed to be =
valid until the
>>>>>>> +            // destructor of Self runs, which will deregister =
the callbacks
>>>>>>> +            // before the memory location becomes invalid.
>>>>>>> +            let res =3D to_result(unsafe {
>>>>>>> +                bindings::request_irq(
>>>>>>> +                    irq,
>>>>>>> +                    Some(handle_irq_callback::<T>),
>>>>>>> +                    flags.into_inner() as usize,
>>>>>>> +                    name.as_char_ptr(),
>>>>>>> +                    slot.cast(),
>>>>>>> +                )
>>>>>>> +            });
>>>>>>> +
>>>>>>> +            if res.is_err() {
>>>>>>> +                // SAFETY: We are returning an error, so we can =
destroy the slot.
>>>>>>> +                unsafe { core::ptr::drop_in_place(&raw mut =
(*slot).handler) };
>>>>>>> +            }
>>>>>>> +
>>>>>>> +            res
>>>>>>> +        };
>>>>>>> +
>>>>>>> +        // SAFETY:
>>>>>>> +        // - if this returns Ok, then every field of `slot` is =
fully
>>>>>>> +        // initialized.
>>>>>>> +        // - if this returns an error, then the slot does not =
need to remain
>>>>>>> +        // valid.
>>>>>>> +        unsafe { pin_init_from_closure(closure) }
>>>>>>=20
>>>>>> Can't we use try_pin_init!() instead, move request_irq() into the =
initializer of
>>>>>> RegistrationInner and initialize inner last?
>>>>>=20
>>>>> We need a pointer to the entire struct when calling
>>>>> bindings::request_irq. I'm not sure this allows you to easily get =
one?
>>>>> I don't think using container_of! here is worth it.
>>>>=20
>>>> There is the `&this in` syntax (`this` is of type `NonNull<Self>`):
>>>>=20
>>>>    try_pin_init!(&this in Self {
>>>>        inner: Devres::new(
>>>>            dev,
>>>>            RegistrationInner {
>>>>                irq,
>>>>                cookie: this.as_ptr().cast(),
>>>>            },
>>>>            GFP_KERNEL,
>>>>        )?,
>>>>        handler,
>>>>        _pin: {
>>>>            to_result(unsafe {
>>>>                bindings::request_irq(
>>>>                    irq,
>>>>                    Some(handle_irq_callback::<T>),
>>>>                    flags.into_inner() as usize,
>>>>                    name.as_char_ptr(),
>>>>                    slot.as_ptr().cast(),
>>>=20
>>> this is "this" instead of "slot", right?
>>>=20
>>>>                )
>>>>            })?;
>>>>            PhantomPinned
>>>>        },
>>>>    })
>>>>=20
>>>> Last time around, I also asked this question and you replied with =
that
>>>> we need to abort the initializer when `request_irq` returns false =
and
>>>> avoid running `Self::drop` (thus we can't do it using `pin_chain`).
>>>>=20
>>>> I asked what we could do instead and you mentioned the `_: {}`
>>>> initializers and those would indeed solve it, but we can abuse the
>>>> `_pin` field for that :)
>>>>=20
>>>=20
>>> Hmm.. but if request_irq() fails, aren't we going to call `drop` on
>>> `inner`, which drops the `Devres` which will eventually call
>>> `RegistrationInner::drop()`? And that's a `free_irq()` without
>>> `request_irq()` succeeded.
>>>=20
>>=20
>> This may however work ;-) Because at `request_irq()` time, all it =
needs
>> is ready, and if it fails, `RegistrationInner` won't construct.
>>=20
>>    try_pin_init!(&this in Self {
>>        handler,
>>        inner: Devres::new(
>>            dev,
>>            RegistrationInner {
>>                // Needs to use `handler` address as cookie, same for
>>                // request_irq().
>>                cookie: &raw (*(this.as_ptr().cast()).handler),
>>                irq: {
>>                     to_result(unsafe { bindings::request_irq(...) =
})?;
>>  irq
>> }
>>             },
>>             GFP_KERNEL,
>>        )?,
>>        _pin: PhantomPinned
>>    })
>=20
> Well yes and no, with the Devres changes, the `cookie` can just be the
> address of the `RegistrationInner` & we can do it this way :)
>=20
> ---
> Cheers,
> Benno


No, we need this to be the address of the the whole thing (i.e.
Registration<T>), otherwise you can=E2=80=99t access the handler in the =
irq
callback.



=E2=80=94 Daniel=

