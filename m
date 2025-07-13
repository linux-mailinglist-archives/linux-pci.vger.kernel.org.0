Return-Path: <linux-pci+bounces-32030-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE554B031BF
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 17:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B16633A758F
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 15:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA6E27A91D;
	Sun, 13 Jul 2025 15:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoI1ZltM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2091627A47C;
	Sun, 13 Jul 2025 15:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752420706; cv=none; b=G0q4mK6p67gKTVBTn0xNc4K7wuvkWq6DwOuZ3edctz1syY1I6hEyYUF88OboFUg+bQkGL2XXqnin2uj/oYMSqD7TEUoRZ0CxUTwXUbzwKY5+IaOA12cBQF263bPr8qycFpypgzs8pu7boU0eo3HIke/fhcR0U+UEZVpdnAQf/oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752420706; c=relaxed/simple;
	bh=YH6ovRkqwsfXl0kwUECrXekJQhmSpXS0WQwetH95HHA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JKevyN4kAheyScuO1deYvyf0E42ps6aDxyKz7Zl7Bzhny1/vVQCchwqem/CxCbQ6NIjuKTpCTV4Rlp1GdDPIhPcA9DWWC2FgcY66QRCWSPIDP1yCbzqe9hw1ReFXTgGkxJdkGEP2aN/4ruLjkgBTW7vx5tdve1mdiMk3arjkzTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoI1ZltM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD12C4CEE3;
	Sun, 13 Jul 2025 15:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752420705;
	bh=YH6ovRkqwsfXl0kwUECrXekJQhmSpXS0WQwetH95HHA=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=aoI1ZltMmClZwfTLoH0LUe4XLHFK46Ny/UyUXkP6rGTbjEZC4WLL3bzBPJg0Luiys
	 wYdVSADtOmxH5vw7BuOkfEH0miLs++D47wiaUz0npgC14k6bGpt4lQuuugI4DT2YlY
	 L+uxXnJChipHuIbOX2yfrER6VtVFxbjZgqRZ7NOp4LEBWVbCbpIlOBESAhdBNPjr6c
	 NLgum5A6Tw1dFr+imXln9dhdcemTC1GRFG8ofIa6KRpip7z4bT/B/a9l15wzBRdMKQ
	 gJWT3tVukU+eeC2ojMHpaieKOWyVbupuVH0GfVvyVzecH4UlOvHujpJo5pVMUhHVWh
	 QDX0C53pGSqrQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 13 Jul 2025 17:29:36 +0200
Message-Id: <DBB18YX7MBDW.3C5Q5Y1O28NFL@kernel.org>
Cc: "Daniel Almeida" <daniel.almeida@collabora.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v6 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
From: "Benno Lossin" <lossin@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com> <20250703-topics-tyr-request_irq-v6-3-74103bdc7c52@collabora.com> <DBAE5TCBT8F8.25XWHTO92R9V4@kernel.org> <DAD3292B-2DBF-442A-8B60-A999AE0F6511@collabora.com> <DBAURC9BEFI0.1LQCRIDT6ZBV9@kernel.org> <DBAVXQTMR38Z.2782EGR84L7OP@kernel.org> <DBAWQG1PX5TO.6I2ARFGLX88N@kernel.org> <DBAX59YKO0FV.ANLOWRHDDS92@kernel.org> <DBAXP68U809C.2G8DMB52M3UZ7@kernel.org>
In-Reply-To: <DBAXP68U809C.2G8DMB52M3UZ7@kernel.org>

On Sun Jul 13, 2025 at 2:42 PM CEST, Danilo Krummrich wrote:
> On Sun Jul 13, 2025 at 2:16 PM CEST, Benno Lossin wrote:
>> On Sun Jul 13, 2025 at 1:57 PM CEST, Danilo Krummrich wrote:
>>> On Sun Jul 13, 2025 at 1:19 PM CEST, Benno Lossin wrote:
>>>> On Sun Jul 13, 2025 at 12:24 PM CEST, Danilo Krummrich wrote:
>>>>> On Sun Jul 13, 2025 at 1:32 AM CEST, Daniel Almeida wrote:
>>>>>>
>>>>>>
>>>>>>> On 12 Jul 2025, at 18:24, Danilo Krummrich <dakr@kernel.org> wrote:
>>>>>>>=20
>>>>>>> On Thu Jul 3, 2025 at 9:30 PM CEST, Daniel Almeida wrote:
>>>>>>>> +/// Callbacks for an IRQ handler.
>>>>>>>> +pub trait Handler: Sync {
>>>>>>>> +    /// The hard IRQ handler.
>>>>>>>> +    ///
>>>>>>>> +    /// This is executed in interrupt context, hence all correspo=
nding
>>>>>>>> +    /// limitations do apply.
>>>>>>>> +    ///
>>>>>>>> +    /// All work that does not necessarily need to be executed fr=
om
>>>>>>>> +    /// interrupt context, should be deferred to a threaded handl=
er.
>>>>>>>> +    /// See also [`ThreadedRegistration`].
>>>>>>>> +    fn handle(&self) -> IrqReturn;
>>>>>>>> +}
>>>>>>>=20
>>>>>>> One thing I forgot, the IRQ handlers should have a &Device<Bound> a=
rgument,
>>>>>>> i.e.:
>>>>>>>=20
>>>>>>> fn handle(&self, dev: &Device<Bound>) -> IrqReturn
>>>>>>>=20
>>>>>>> IRQ registrations naturally give us this guarantee, so we should ta=
ke advantage
>>>>>>> of that.
>>>>>>>=20
>>>>>>> - Danilo
>>>>>>
>>>>>> Hi Danilo,
>>>>>>
>>>>>> I do not immediately see a way to get a Device<Bound> from here:
>>>>>>
>>>>>> unsafe extern "C" fn handle_irq_callback<T: Handler>(_irq: i32, ptr:=
 *mut c_void) -> c_uint {
>>>>>>
>>>>>> Refall that we've established `ptr` to be the address of the handler=
. This
>>>>>> came after some back and forth and after the extensive discussion th=
at Benno
>>>>>> and Boqun had w.r.t to pinning in request_irq().
>>>>>
>>>>> You can just wrap the Handler in a new type and store the pointer the=
re:
>>>>>
>>>>> 	#[pin_data]
>>>>> 	struct Wrapper {
>>>>> 	   #[pin]
>>>>> 	   handler: T,
>>>>> 	   dev: NonNull<Device<Bound>>,
>>>>> 	}
>>>>>
>>>>> And then pass a pointer to the Wrapper field to request_irq();
>>>>> handle_irq_callback() can construct a &T and a &Device<Bound> from th=
is.
>>>>>
>>>>> Note that storing a device pointer, without its own reference count, =
is
>>>>> perfectly fine, since inner (Devres<RegistrationInner>) already holds=
 a
>>>>> reference to the device and guarantees the bound scope for the handle=
r
>>>>> callbacks.
>>>>
>>>> Can't we just add an accessor function to `Devres`?
>>>
>>> 	#[pin_data]
>>> 	pub struct Registration<T: Handler + 'static> {
>>> 	    #[pin]
>>> 	    inner: Devres<RegistrationInner>,
>>> =09
>>> 	    #[pin]
>>> 	    handler: T,
>>> =09
>>> 	    /// Pinned because we need address stability so that we can pass a=
 pointer
>>> 	    /// to the callback.
>>> 	    #[pin]
>>> 	    _pin: PhantomPinned,
>>> 	}
>>>
>>> Currently we pass the address of handler to request_irq(), so this does=
n't help,
>>> hence my proposal to replace the above T with Wrapper (actually Wrapper=
<T>).
>>
>> You can just use `container_of!`?
>
> Sure, that's possible too.
>
>>>> Also `Devres` only stores `Device<Normal>`, not `Device<Bound>`...
>>>
>>> The Devres instance itself may out-live device unbind, but it ensures t=
hat the
>>> encapsulated data does not, hence it holds a reference count, i.e. ARef=
<Device>.
>>>
>>> Device<Bound> or ARef<Device<Bound>> *never* exists, only &'a Device<Bo=
und>
>>> within a corresponding scope for which we can guarantee the device is b=
ound.
>>>
>>> In the proposed wrapper we can store a NonNull<Device<Bound>> though, b=
ecause we
>>> can safely give out a &Device<Bound> in the IRQ's handle() callback. Th=
is is
>>> because:
>>>
>>>   (1) RegistrationInner is guarded by Devres and guarantees that free_i=
rq() is
>>>       completed *before* the device is unbound.
>>
>> How does it ensure that?
>
> RegistrationInner calls free_irq() in it's drop() method; Devres revokes =
it on
> device unbind.

Makes sense, so we probably do need the unsafe typestate change
function in this case.

>>>
>>>   (2) It is guaranteed that the device pointer is valid because (1) gua=
rantees
>>>       it's even bound and because Devres<RegistrationInner> itself has =
a
>>>       reference count.
>>
>> Yeah but I would find it much more natural (and also useful in other
>> circumstances) if `Devres<T>` would give you access to `Device` (at
>> least the `Normal` type state).
>
> If we use container_of!() instead or just pass the address of Self (i.e.
> Registration) to request_irq() instead,
>
> 	pub fn device(&self) -> &Device
>
> is absolutely possible to add to Devres, of course.
>
>> Depending on how (1) is ensured, we might just need an unsafe function
>> that turns `Device<Normal>` into `Device<Bound>`.
>
> `&Device<Normal>` in `&Device<Bound>`, yes. I have such a method locally
> already (but haven't sent it yet), because that's going to be a use-case =
for
> other abstractions as well. One specific example is the PWM Chip abstract=
ion
> [1].
>
> [1] https://lore.kernel.org/lkml/20250710-rust-next-pwm-working-fan-for-s=
ending-v11-3-93824a16f9ec@samsung.com/

I think this solution sounds much better than storing an additional
`NonNull<Device<Bound>>`.

---
Cheers,
Benno

