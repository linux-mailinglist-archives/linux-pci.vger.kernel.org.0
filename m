Return-Path: <linux-pci+bounces-32017-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D732BB03100
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 14:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4124189CE84
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 12:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606B024BD03;
	Sun, 13 Jul 2025 12:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="op1pLZAc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A26C1A7264;
	Sun, 13 Jul 2025 12:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752410567; cv=none; b=GMSXclahEWX7uJAW+2izip2AaoYyARPwK6ODLqzIKncvraDdLk4iQrNf+Ga+j1I0OYlIWg+S8E1ItQfC46H6cLYdh4oJCO1/uBml36D6dzbkHhbbUTpt+EnuFiwkdfUfRFrapeaJbFrV6UDFf94VLR3rTxm6FnTvxOLrZWoDD7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752410567; c=relaxed/simple;
	bh=NRCDt9pKCngWcpqRoaYJF3UkZJgRNWt5UVO9j/wWGEg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=dG3a8FP37VQId1GfqpII/rgkJv58Z8kcMCv14sIK5FV/K6yGxjmGzjj95cxwocwoYI9UcYTNQd5kd2CDM/lRSYgiteYwDm97X88VhtcxZ829H2KRH/0l7eHliDZNv1Y2LSw0eOXx8Xqg98n/K+5YTKWH/kpXdBac1vPNjfyJ0W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=op1pLZAc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A51C4CEE3;
	Sun, 13 Jul 2025 12:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752410566;
	bh=NRCDt9pKCngWcpqRoaYJF3UkZJgRNWt5UVO9j/wWGEg=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=op1pLZAcS1Z+FfF+ct02wbsATFO2ujtNRpoJOwd60z+kKyGyAPGQf2bPr+nwD+SwD
	 GfcoqZhbCXgRVKOPe2jqDmx3RiGO/d9lAR9ohz5WpQzeo2u6O1zOZXVIcfif7t6Ugi
	 2RPO/aCur5v5VZdNDa6lNIZGySukddwNTSWj/ELb1i+aOAbctExDZ+5NjStQpMgDaV
	 wstGjuI1Net5LdQePsze+FbePsxawVxGYNb+rxMhBKYtj2hHgkkGPI3zo5XXk3W8Tg
	 XjNx8uOtqWIIW6eQExmM0u3jRgD5K9mZ3pGKQ3hkdropB6/2mOz0EtpSTzxGCRQqbo
	 UtKgEq5mjw9tw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 13 Jul 2025 14:42:41 +0200
Message-Id: <DBAXP68U809C.2G8DMB52M3UZ7@kernel.org>
Subject: Re: [PATCH v6 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
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
To: "Benno Lossin" <lossin@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com> <20250703-topics-tyr-request_irq-v6-3-74103bdc7c52@collabora.com> <DBAE5TCBT8F8.25XWHTO92R9V4@kernel.org> <DAD3292B-2DBF-442A-8B60-A999AE0F6511@collabora.com> <DBAURC9BEFI0.1LQCRIDT6ZBV9@kernel.org> <DBAVXQTMR38Z.2782EGR84L7OP@kernel.org> <DBAWQG1PX5TO.6I2ARFGLX88N@kernel.org> <DBAX59YKO0FV.ANLOWRHDDS92@kernel.org>
In-Reply-To: <DBAX59YKO0FV.ANLOWRHDDS92@kernel.org>

On Sun Jul 13, 2025 at 2:16 PM CEST, Benno Lossin wrote:
> On Sun Jul 13, 2025 at 1:57 PM CEST, Danilo Krummrich wrote:
>> On Sun Jul 13, 2025 at 1:19 PM CEST, Benno Lossin wrote:
>>> On Sun Jul 13, 2025 at 12:24 PM CEST, Danilo Krummrich wrote:
>>>> On Sun Jul 13, 2025 at 1:32 AM CEST, Daniel Almeida wrote:
>>>>>
>>>>>
>>>>>> On 12 Jul 2025, at 18:24, Danilo Krummrich <dakr@kernel.org> wrote:
>>>>>>=20
>>>>>> On Thu Jul 3, 2025 at 9:30 PM CEST, Daniel Almeida wrote:
>>>>>>> +/// Callbacks for an IRQ handler.
>>>>>>> +pub trait Handler: Sync {
>>>>>>> +    /// The hard IRQ handler.
>>>>>>> +    ///
>>>>>>> +    /// This is executed in interrupt context, hence all correspon=
ding
>>>>>>> +    /// limitations do apply.
>>>>>>> +    ///
>>>>>>> +    /// All work that does not necessarily need to be executed fro=
m
>>>>>>> +    /// interrupt context, should be deferred to a threaded handle=
r.
>>>>>>> +    /// See also [`ThreadedRegistration`].
>>>>>>> +    fn handle(&self) -> IrqReturn;
>>>>>>> +}
>>>>>>=20
>>>>>> One thing I forgot, the IRQ handlers should have a &Device<Bound> ar=
gument,
>>>>>> i.e.:
>>>>>>=20
>>>>>> fn handle(&self, dev: &Device<Bound>) -> IrqReturn
>>>>>>=20
>>>>>> IRQ registrations naturally give us this guarantee, so we should tak=
e advantage
>>>>>> of that.
>>>>>>=20
>>>>>> - Danilo
>>>>>
>>>>> Hi Danilo,
>>>>>
>>>>> I do not immediately see a way to get a Device<Bound> from here:
>>>>>
>>>>> unsafe extern "C" fn handle_irq_callback<T: Handler>(_irq: i32, ptr: =
*mut c_void) -> c_uint {
>>>>>
>>>>> Refall that we've established `ptr` to be the address of the handler.=
 This
>>>>> came after some back and forth and after the extensive discussion tha=
t Benno
>>>>> and Boqun had w.r.t to pinning in request_irq().
>>>>
>>>> You can just wrap the Handler in a new type and store the pointer ther=
e:
>>>>
>>>> 	#[pin_data]
>>>> 	struct Wrapper {
>>>> 	   #[pin]
>>>> 	   handler: T,
>>>> 	   dev: NonNull<Device<Bound>>,
>>>> 	}
>>>>
>>>> And then pass a pointer to the Wrapper field to request_irq();
>>>> handle_irq_callback() can construct a &T and a &Device<Bound> from thi=
s.
>>>>
>>>> Note that storing a device pointer, without its own reference count, i=
s
>>>> perfectly fine, since inner (Devres<RegistrationInner>) already holds =
a
>>>> reference to the device and guarantees the bound scope for the handler
>>>> callbacks.
>>>
>>> Can't we just add an accessor function to `Devres`?
>>
>> 	#[pin_data]
>> 	pub struct Registration<T: Handler + 'static> {
>> 	    #[pin]
>> 	    inner: Devres<RegistrationInner>,
>> =09
>> 	    #[pin]
>> 	    handler: T,
>> =09
>> 	    /// Pinned because we need address stability so that we can pass a =
pointer
>> 	    /// to the callback.
>> 	    #[pin]
>> 	    _pin: PhantomPinned,
>> 	}
>>
>> Currently we pass the address of handler to request_irq(), so this doesn=
't help,
>> hence my proposal to replace the above T with Wrapper (actually Wrapper<=
T>).
>
> You can just use `container_of!`?

Sure, that's possible too.

>>> Also `Devres` only stores `Device<Normal>`, not `Device<Bound>`...
>>
>> The Devres instance itself may out-live device unbind, but it ensures th=
at the
>> encapsulated data does not, hence it holds a reference count, i.e. ARef<=
Device>.
>>
>> Device<Bound> or ARef<Device<Bound>> *never* exists, only &'a Device<Bou=
nd>
>> within a corresponding scope for which we can guarantee the device is bo=
und.
>>
>> In the proposed wrapper we can store a NonNull<Device<Bound>> though, be=
cause we
>> can safely give out a &Device<Bound> in the IRQ's handle() callback. Thi=
s is
>> because:
>>
>>   (1) RegistrationInner is guarded by Devres and guarantees that free_ir=
q() is
>>       completed *before* the device is unbound.
>
> How does it ensure that?

RegistrationInner calls free_irq() in it's drop() method; Devres revokes it=
 on
device unbind.

>>
>>   (2) It is guaranteed that the device pointer is valid because (1) guar=
antees
>>       it's even bound and because Devres<RegistrationInner> itself has a
>>       reference count.
>
> Yeah but I would find it much more natural (and also useful in other
> circumstances) if `Devres<T>` would give you access to `Device` (at
> least the `Normal` type state).

If we use container_of!() instead or just pass the address of Self (i.e.
Registration) to request_irq() instead,

	pub fn device(&self) -> &Device

is absolutely possible to add to Devres, of course.

> Depending on how (1) is ensured, we might just need an unsafe function
> that turns `Device<Normal>` into `Device<Bound>`.

`&Device<Normal>` in `&Device<Bound>`, yes. I have such a method locally
already (but haven't sent it yet), because that's going to be a use-case fo=
r
other abstractions as well. One specific example is the PWM Chip abstractio=
n
[1].

[1] https://lore.kernel.org/lkml/20250710-rust-next-pwm-working-fan-for-sen=
ding-v11-3-93824a16f9ec@samsung.com/

