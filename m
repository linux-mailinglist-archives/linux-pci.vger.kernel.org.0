Return-Path: <linux-pci+bounces-32016-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 180FEB030F6
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 14:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 042DA17DE4C
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 12:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51F72AE99;
	Sun, 13 Jul 2025 12:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uo/2tBZ/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770FB8F4A;
	Sun, 13 Jul 2025 12:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752409008; cv=none; b=ZfzqAKiiLrrklcbBVQ8X2I5LCCujExgoCtCZrbDHsFksp8vt2EXsVAXbr82jftcGYpLKGLdgxKfP3nHklsS6+0kn98BjLLXPho2oKXThQFok2JtQ+6nOe4C7w7YssCjSLHCJbkzz2q+OJ2vnnSX1ZXr7DcYTMTS0sbSVyADP42o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752409008; c=relaxed/simple;
	bh=4wACIZ7jO0V7Vo4t1TayqDDK2Ldzk66J0NbQImHwQHs=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=rU4YS8WJOR9WLkOU4y+CQyzsHepwkvGiGBaR0hPtsNkxvQ/gsVZFZodCMxViVdd6H+T4VJRNaqTTH9gr+sTzugYXPq5wD6X4RuEgDfzMzp86BR2BqF54buTYFFl1zEXYLNTBVNDXsQATTQY1clD0PZcj2BmQ5KhVnZsMWFQg9v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uo/2tBZ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86AF3C4CEE3;
	Sun, 13 Jul 2025 12:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752409007;
	bh=4wACIZ7jO0V7Vo4t1TayqDDK2Ldzk66J0NbQImHwQHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uo/2tBZ/1li7+8/v2GolNJ5d4oH8EuD5YghDpmT8uLsR7xQkZaksxYWvH2Og4OUE7
	 AmYSXPHJQj35ZkDF1eQb0/OrOLpO2b4/L9Idvjshlyjft8RrKD8BN050dmeQaVB2Cq
	 IeY8iRFua66IpIVgnthMGoxV9ymirYNQdUwCbJSBPgVLLk2la+nNfawmGN1/uYfnIk
	 6gjUk9Q1MGRl/k352VulQDKHQkoeBLSrOv/Ce1JvXFh46w30Djv+mt9+JxO1orfF9n
	 Z7TUCRNeH7kLdNx1eik8euuCyf/kzUEijK4RBMi66lDtxKBobZ+tDb1WLpVWGwwFGe
	 2lvAOFHoFPdjQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 13 Jul 2025 14:16:42 +0200
Message-Id: <DBAX59YKO0FV.ANLOWRHDDS92@kernel.org>
From: "Benno Lossin" <lossin@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>
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
X-Mailer: aerc 0.20.1
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com> <20250703-topics-tyr-request_irq-v6-3-74103bdc7c52@collabora.com> <DBAE5TCBT8F8.25XWHTO92R9V4@kernel.org> <DAD3292B-2DBF-442A-8B60-A999AE0F6511@collabora.com> <DBAURC9BEFI0.1LQCRIDT6ZBV9@kernel.org> <DBAVXQTMR38Z.2782EGR84L7OP@kernel.org> <DBAWQG1PX5TO.6I2ARFGLX88N@kernel.org>
In-Reply-To: <DBAWQG1PX5TO.6I2ARFGLX88N@kernel.org>

On Sun Jul 13, 2025 at 1:57 PM CEST, Danilo Krummrich wrote:
> On Sun Jul 13, 2025 at 1:19 PM CEST, Benno Lossin wrote:
>> On Sun Jul 13, 2025 at 12:24 PM CEST, Danilo Krummrich wrote:
>>> On Sun Jul 13, 2025 at 1:32 AM CEST, Daniel Almeida wrote:
>>>>
>>>>
>>>>> On 12 Jul 2025, at 18:24, Danilo Krummrich <dakr@kernel.org> wrote:
>>>>>=20
>>>>> On Thu Jul 3, 2025 at 9:30 PM CEST, Daniel Almeida wrote:
>>>>>> +/// Callbacks for an IRQ handler.
>>>>>> +pub trait Handler: Sync {
>>>>>> +    /// The hard IRQ handler.
>>>>>> +    ///
>>>>>> +    /// This is executed in interrupt context, hence all correspond=
ing
>>>>>> +    /// limitations do apply.
>>>>>> +    ///
>>>>>> +    /// All work that does not necessarily need to be executed from
>>>>>> +    /// interrupt context, should be deferred to a threaded handler=
.
>>>>>> +    /// See also [`ThreadedRegistration`].
>>>>>> +    fn handle(&self) -> IrqReturn;
>>>>>> +}
>>>>>=20
>>>>> One thing I forgot, the IRQ handlers should have a &Device<Bound> arg=
ument,
>>>>> i.e.:
>>>>>=20
>>>>> fn handle(&self, dev: &Device<Bound>) -> IrqReturn
>>>>>=20
>>>>> IRQ registrations naturally give us this guarantee, so we should take=
 advantage
>>>>> of that.
>>>>>=20
>>>>> - Danilo
>>>>
>>>> Hi Danilo,
>>>>
>>>> I do not immediately see a way to get a Device<Bound> from here:
>>>>
>>>> unsafe extern "C" fn handle_irq_callback<T: Handler>(_irq: i32, ptr: *=
mut c_void) -> c_uint {
>>>>
>>>> Refall that we've established `ptr` to be the address of the handler. =
This
>>>> came after some back and forth and after the extensive discussion that=
 Benno
>>>> and Boqun had w.r.t to pinning in request_irq().
>>>
>>> You can just wrap the Handler in a new type and store the pointer there=
:
>>>
>>> 	#[pin_data]
>>> 	struct Wrapper {
>>> 	   #[pin]
>>> 	   handler: T,
>>> 	   dev: NonNull<Device<Bound>>,
>>> 	}
>>>
>>> And then pass a pointer to the Wrapper field to request_irq();
>>> handle_irq_callback() can construct a &T and a &Device<Bound> from this=
.
>>>
>>> Note that storing a device pointer, without its own reference count, is
>>> perfectly fine, since inner (Devres<RegistrationInner>) already holds a
>>> reference to the device and guarantees the bound scope for the handler
>>> callbacks.
>>
>> Can't we just add an accessor function to `Devres`?
>
> 	#[pin_data]
> 	pub struct Registration<T: Handler + 'static> {
> 	    #[pin]
> 	    inner: Devres<RegistrationInner>,
> =09
> 	    #[pin]
> 	    handler: T,
> =09
> 	    /// Pinned because we need address stability so that we can pass a p=
ointer
> 	    /// to the callback.
> 	    #[pin]
> 	    _pin: PhantomPinned,
> 	}
>
> Currently we pass the address of handler to request_irq(), so this doesn'=
t help,
> hence my proposal to replace the above T with Wrapper (actually Wrapper<T=
>).

You can just use `container_of!`?

>> Also `Devres` only stores `Device<Normal>`, not `Device<Bound>`...
>
> The Devres instance itself may out-live device unbind, but it ensures tha=
t the
> encapsulated data does not, hence it holds a reference count, i.e. ARef<D=
evice>.
>
> Device<Bound> or ARef<Device<Bound>> *never* exists, only &'a Device<Boun=
d>
> within a corresponding scope for which we can guarantee the device is bou=
nd.
>
> In the proposed wrapper we can store a NonNull<Device<Bound>> though, bec=
ause we
> can safely give out a &Device<Bound> in the IRQ's handle() callback. This=
 is
> because:
>
>   (1) RegistrationInner is guarded by Devres and guarantees that free_irq=
() is
>       completed *before* the device is unbound.

How does it ensure that?

>
>   (2) It is guaranteed that the device pointer is valid because (1) guara=
ntees
>       it's even bound and because Devres<RegistrationInner> itself has a
>       reference count.

Yeah but I would find it much more natural (and also useful in other
circumstances) if `Devres<T>` would give you access to `Device` (at
least the `Normal` type state).

Depending on how (1) is ensured, we might just need an unsafe function
that turns `Device<Normal>` into `Device<Bound>`.

---
Cheers,
Benno

