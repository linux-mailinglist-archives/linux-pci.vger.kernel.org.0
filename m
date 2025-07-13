Return-Path: <linux-pci+bounces-32014-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F00B030D0
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 13:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EEAF172B6A
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 11:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E761F9F70;
	Sun, 13 Jul 2025 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="br4EkYAc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB2414F121;
	Sun, 13 Jul 2025 11:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752405597; cv=none; b=X3qN1u3Dhq1GuRHEwjPuDDxejwK6kW5sknpGNnOTv+Y/brBZzBl/pSi+eEauksCyTG6qddGxWgNU7B3/TJzMoqQBvlznAr4Bk5hvXWdXB779IaRwYVF9Zri4hwMVZVMomHX0VFGrHGXt1vD5R44sceeBg26OB0b5prW01wg4Ffc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752405597; c=relaxed/simple;
	bh=io50k6l82j+7RewCzGHhH52lZfIeTY1p+YrXiVtHZEc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Smg42bnTZT69UEi9vDFldQ6BWToGDjyxud54py4KdvyHAz/iYbYEp+e0Uy8MDvpsJwQIncxZz8sLPh6HVhQkNucksIBWivokvRgZZ6XzQxYiezeOyalevhtQ24z/UmRT6z4fz4GaL1Blacl6Em/aUZ9+zXmTu2uf8fBGlWLStEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=br4EkYAc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13098C4CEE3;
	Sun, 13 Jul 2025 11:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752405596;
	bh=io50k6l82j+7RewCzGHhH52lZfIeTY1p+YrXiVtHZEc=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=br4EkYAcPruXbjh5MQ4nD5XleVU51Jqxqe0VafFZ5VCZs6WCdXlHH7PwdVeN43bY1
	 +365SHAcKU+Z4I/E8OlQgpMKxaSvTXpgN7SSzf11kiYfbWmh0U/K9m1F39z0Yb7JMh
	 iGri9dSR2gdHuOiQMZUWGMjldrv+X/D/FJOpz/qyJD0G85OsYsfv5ebgQaMEvuMG72
	 3EcORhDmoORy3cghvW0zZJ+WM2s5O4Q9NUP6z5/IxrIez0gKHo0kbDqMCIiX/L0CYK
	 jSuOZhOOp9/JAqyn6NaHQmD7B8y/qEiO1kGPj86RftYqpkT3WwOeZZAKxLPwGOu0sE
	 6QdHBPvXhIt3Q==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 13 Jul 2025 13:19:51 +0200
Message-Id: <DBAVXQTMR38Z.2782EGR84L7OP@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v6 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com> <20250703-topics-tyr-request_irq-v6-3-74103bdc7c52@collabora.com> <DBAE5TCBT8F8.25XWHTO92R9V4@kernel.org> <DAD3292B-2DBF-442A-8B60-A999AE0F6511@collabora.com> <DBAURC9BEFI0.1LQCRIDT6ZBV9@kernel.org>
In-Reply-To: <DBAURC9BEFI0.1LQCRIDT6ZBV9@kernel.org>

On Sun Jul 13, 2025 at 12:24 PM CEST, Danilo Krummrich wrote:
> On Sun Jul 13, 2025 at 1:32 AM CEST, Daniel Almeida wrote:
>>
>>
>>> On 12 Jul 2025, at 18:24, Danilo Krummrich <dakr@kernel.org> wrote:
>>>=20
>>> On Thu Jul 3, 2025 at 9:30 PM CEST, Daniel Almeida wrote:
>>>> +/// Callbacks for an IRQ handler.
>>>> +pub trait Handler: Sync {
>>>> +    /// The hard IRQ handler.
>>>> +    ///
>>>> +    /// This is executed in interrupt context, hence all correspondin=
g
>>>> +    /// limitations do apply.
>>>> +    ///
>>>> +    /// All work that does not necessarily need to be executed from
>>>> +    /// interrupt context, should be deferred to a threaded handler.
>>>> +    /// See also [`ThreadedRegistration`].
>>>> +    fn handle(&self) -> IrqReturn;
>>>> +}
>>>=20
>>> One thing I forgot, the IRQ handlers should have a &Device<Bound> argum=
ent,
>>> i.e.:
>>>=20
>>> fn handle(&self, dev: &Device<Bound>) -> IrqReturn
>>>=20
>>> IRQ registrations naturally give us this guarantee, so we should take a=
dvantage
>>> of that.
>>>=20
>>> - Danilo
>>
>> Hi Danilo,
>>
>> I do not immediately see a way to get a Device<Bound> from here:
>>
>> unsafe extern "C" fn handle_irq_callback<T: Handler>(_irq: i32, ptr: *mu=
t c_void) -> c_uint {
>>
>> Refall that we've established `ptr` to be the address of the handler. Th=
is
>> came after some back and forth and after the extensive discussion that B=
enno
>> and Boqun had w.r.t to pinning in request_irq().
>
> You can just wrap the Handler in a new type and store the pointer there:
>
> 	#[pin_data]
> 	struct Wrapper {
> 	   #[pin]
> 	   handler: T,
> 	   dev: NonNull<Device<Bound>>,
> 	}
>
> And then pass a pointer to the Wrapper field to request_irq();
> handle_irq_callback() can construct a &T and a &Device<Bound> from this.
>
> Note that storing a device pointer, without its own reference count, is
> perfectly fine, since inner (Devres<RegistrationInner>) already holds a
> reference to the device and guarantees the bound scope for the handler
> callbacks.

Can't we just add an accessor function to `Devres`?

Also `Devres` only stores `Device<Normal>`, not `Device<Bound>`...

---
Cheers,
Benno

> It makes sense to document this as an invariant of Wrapper (or whatever w=
e end
> up calling it).

