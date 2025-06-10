Return-Path: <linux-pci+bounces-29306-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7711AD3386
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 12:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE9A3AC017
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 10:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEDE28C2BA;
	Tue, 10 Jun 2025 10:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1GFuKMg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9DF28315B;
	Tue, 10 Jun 2025 10:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749551118; cv=none; b=KAfArYR60/DFjrBMF5XyW3FglK9gge2u5OxE5/r+8w+KSzk16OZ5SdO/f8Y6jNPilA+oPeW05Xmq+jn12NYW3opU9dMywsoeuF9zs5juAL4B++MErNw5svP2W8VhDH1Db6FGlAFeyd+p265Kb2kn/K/ZRNCd1snuQgFxM9NueWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749551118; c=relaxed/simple;
	bh=ROS8mtNiUd4xDjSycsgTS1G1TFzJbGvldHsVm3fwtWw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fag//t/yta+yCCNb3SdJsWgWQkrfxRVI5IYXzLptxj5eEwfocaivfqRfD+j3YoQH2kgLABInojUzydXWWdCv724xN1VMtJSf8CSDAm50gNCHF+ZmGz5HtEfAh8W+z6oWhNkxMGyYChfVktIw/5cglBa6gbQ7ivH+4j8zxIAo/co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1GFuKMg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9902BC4CEED;
	Tue, 10 Jun 2025 10:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749551118;
	bh=ROS8mtNiUd4xDjSycsgTS1G1TFzJbGvldHsVm3fwtWw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=t1GFuKMgZYhQ4KSiDsCEMXN0MJSQ8z7/xR8B0n7RRHNt9gP67TxvdFew1L4ljIoHL
	 3N7tn1hA5vX15Gkos0gnDWOucPiV1+P90CWK+tMR7FgWzXFj7luQajQoPMahnvIb4J
	 F3KQnBJlXN1DInHVt8Ol+ImBQUuBdbk4SAffSnXfi069EMvZBuN/58rQTyYHK6knCa
	 l0pmwIHfUwjp8xfxKXnv9nFmoI4AwSFPtSM7aP24gnINmkjCa4612izUDmrqDMGdKF
	 Wcdnbgvorcqop37EuoiZO5Gobrab3wkoIcD9kKuMLZJhttSTq/pwoX5CSgxt7sZJvD
	 BeO3EdpXZnPZQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <lossin@kernel.org>
Cc: "Danilo Krummrich" <dakr@kernel.org>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor
 Gross" <tmgross@umich.edu>,  "Bjorn Helgaas" <bhelgaas@google.com>,
  Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,  "Greg
 Kroah-Hartman"
 <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki" <rafael@kernel.org>,
  "Tamir Duberstein" <tamird@gmail.com>,  "Viresh Kumar"
 <viresh.kumar@linaro.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-pci@vger.kernel.org>,
  =?utf-8?Q?Ma=C3=ADra?=
 Canal <mcanal@igalia.com>
Subject: Re: [PATCH] rust: types: add FOREIGN_ALIGN to ForeignOwnable
In-Reply-To: <DAIRJ71UP655.2NF13FJSA0G68@kernel.org> (Benno Lossin's message
	of "Tue, 10 Jun 2025 11:58:07 +0200")
References: <20250605-pointed-to-v1-1-ee1e262912cc@kernel.org>
	<WubHJPtx9Uu0qugeELZ2ooYWKq4KDj7r8P7k4i_QhgOP53MWk1V3XHH4Ztmzp42zMwHSntslAbfpLFY9AhjfxQ==@protonmail.internalid>
	<DAFB0GKSGPSF.24BE695LGC28Z@kernel.org> <87sek82bgf.fsf@kernel.org>
	<B5pQuQkk-qtv2Ot8IX9eCoREwxBBx4xPoUIVYwdYjryB3OAHUhSOhZISNh1ft6F38icSGojZSIsxsyoX_nBRDQ==@protonmail.internalid>
	<DAIRJ71UP655.2NF13FJSA0G68@kernel.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 10 Jun 2025 12:25:08 +0200
Message-ID: <87bjqv3ncr.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <lossin@kernel.org> writes:

> On Tue Jun 10, 2025 at 11:27 AM CEST, Andreas Hindborg wrote:
>> Hi Benno,
>>
>> "Benno Lossin" <lossin@kernel.org> writes:
>>
>>> The title should probably also mention that it removes `PointedTo`.
>
> Just making sure that you saw this.
>
>>> On Thu Jun 5, 2025 at 9:55 PM CEST, Andreas Hindborg wrote:
>>>>  pub unsafe trait ForeignOwnable: Sized {
>>>> -    /// Type used when the value is foreign-owned. In practical terms only defines the alignment of
>>>> -    /// the pointer.
>>>> -    type PointedTo;
>>>> +    /// The alignment of pointers returned by `into_foreign`.
>>>> +    const FOREIGN_ALIGN: usize;
>>>>
>>>>      /// Type used to immutably borrow a value that is currently foreign-owned.
>>>>      type Borrowed<'a>;
>>>> @@ -39,18 +35,17 @@ pub unsafe trait ForeignOwnable: Sized {
>>>>
>>>>      /// Converts a Rust-owned object to a foreign-owned one.
>>>>      ///
>>>> -    /// # Guarantees
>>>
>>> Why remove this section? I think we should streamline it, (make it use
>>> bullet points, shorten the sentences etc). We can keep the paragraph you
>>> wrote below as normal docs.
>>
>> Not sure exactly what you are going for here. How is this:
>>
>>
>>   Converts a Rust-owned object to a foreign-owned one.
>>
>>   The foreign representation is a pointer to void.
>>
>>   # Guarantees
>>
>>   - Minimum alignment of returned pointer is [`Self::FOREIGN_ALIGN`].
>>
>>   There are no other guarantees for this pointer. For example, it might be invalid, dangling
>>   or pointing to uninitialized memory. Using it in any way except for [`from_foreign`],
>>   [`try_from_foreign`], [`borrow`], or [`borrow_mut`] can result in undefined behavior.
>
> Maybe even move this paragraph above the `Guarantees` section and change
> the beginning of it to "Aside from the guarantees listed below, there
> are no other..."?

Alright.


Best regards,
Andreas Hindborg




