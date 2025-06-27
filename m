Return-Path: <linux-pci+bounces-30902-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA37AEB219
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 11:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 369EC7B6A07
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 09:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802D7293C61;
	Fri, 27 Jun 2025 09:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTLpJw6r"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526AD293B7E;
	Fri, 27 Jun 2025 09:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751015150; cv=none; b=jXrRLW7LAjQ6/U1vZ2XeuR2rWOA0IITyXJtJQV7DoDoK44nqBhrijSgwg6UOrlXD0coWE9lk8nOoRDn7MjU8viTxJR+YC9HFskd8OPqTZy+FzXgKMpGu1tjak1TtRbEc2jb2JNiDvlCW4GnO1durVNqyqc5rzDTIOSNqk/a5MPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751015150; c=relaxed/simple;
	bh=XvxycTB3onM69EDKebMKpJFwtx2tibWRvWCOQn8a4IU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=AaWiE87tNbxHJ00ZWqGPpgDZRBNEtPkd1L6/lJ1fETSb/F79hHukJqKnVXAV10HlaJz2vSvodITI/+hIFnRoegFXvPcKarn+MAzQxSPy6KmBlG6WGiPwuxrEEMa8gMA4ay0nrA/IgHX5k6kaYcv762co2M/wKSYfvWqNGXTR7z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTLpJw6r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52484C4CEE3;
	Fri, 27 Jun 2025 09:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751015149;
	bh=XvxycTB3onM69EDKebMKpJFwtx2tibWRvWCOQn8a4IU=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=nTLpJw6rxqPJ1mmiibAIPVRYLcl1FLPvAt0F4lpglJcAKuMZ1e8sbjxCbwfgE3nUX
	 tRy1STZYPYA7s8yBvgzBAscd1KJO3CuBEVO9OxR4VCGF6O4U71aOlUYky0StnZu+NW
	 7mTuVIoJRIBJXL2YQf6oveN3gjvZBIGbjFAtw7V1pL64ZaB0J/nCrCw4KdWOyqpzhE
	 DASbjievzFGMoGBfZalKwzlZNRPER4xTMba413UiUpFO75HjadRw0B1RnCTfCrQ8o2
	 GwM+w58EqX3NHanHyZqqcGV6ZMB1Q5d2MiUEv/FdfHYutTfa2y21qmQ5Zwax1ze1rk
	 G6xBE9uOeJTiQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Jun 2025 11:05:44 +0200
Message-Id: <DAX72CI4S0JF.1GCUWSOEO3H7W@kernel.org>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, <alex.gaynor@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, "Andreas Hindborg"
 <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor
 Gross" <tmgross@umich.edu>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <kwilczynski@kernel.org>,
 <bhelgaas@google.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 4/5] rust: types: ForeignOwnable: Add type Target
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>, "Danilo Krummrich"
 <dakr@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250626200054.243480-1-dakr@kernel.org>
 <20250626200054.243480-5-dakr@kernel.org> <aF2rpzSccqgoVvn0@tardis.local>
 <DAWUKB7PAZG1.2K2W9VCATZ3O0@kernel.org>
 <45a2bd65-ec77-4ce7-bd8e-553880d85bdf@app.fastmail.com>
 <DAWUY4YH6XP9.TWAP6N95L5BR@kernel.org>
 <8922f6f0-241a-4659-b382-fb8c62b77e8f@app.fastmail.com>
 <44579f29-a8a4-41cb-97ea-5ab7711e4d2a@app.fastmail.com>
In-Reply-To: <44579f29-a8a4-41cb-97ea-5ab7711e4d2a@app.fastmail.com>

On Fri Jun 27, 2025 at 1:55 AM CEST, Boqun Feng wrote:
> On Thu, Jun 26, 2025, at 4:45 PM, Boqun Feng wrote:
>> On Thu, Jun 26, 2025, at 4:36 PM, Benno Lossin wrote:
>>> On Fri Jun 27, 2025 at 1:21 AM CEST, Boqun Feng wrote:
>>>> On Thu, Jun 26, 2025, at 4:17 PM, Benno Lossin wrote:
>>>>> On Thu Jun 26, 2025 at 10:20 PM CEST, Boqun Feng wrote:
>>>>>> On Thu, Jun 26, 2025 at 10:00:42PM +0200, Danilo Krummrich wrote:
>>>>>>> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
>>>>>>> index 3958a5f44d56..74c787b352a9 100644
>>>>>>> --- a/rust/kernel/types.rs
>>>>>>> +++ b/rust/kernel/types.rs
>>>>>>> @@ -27,6 +27,9 @@
>>>>>>>  /// [`into_foreign`]: Self::into_foreign
>>>>>>>  /// [`PointedTo`]: Self::PointedTo
>>>>>>>  pub unsafe trait ForeignOwnable: Sized {
>>>>>>> +    /// The payload type of the foreign-owned value.
>>>>>>> +    type Target;
>>>>>>
>>>>>> I think `ForeignOwnable` also implies a `T` maybe get dropped via a
>>>>>> pointer from `into_foreign()`. Not sure it's worth mentioning though=
.
>>>>>
>>>>> What? How would that happen?
>>>>
>>>> The owner of the pointer can do from_foreign() and eventually drop
>>>> the ForeignOwnable, hence dropping T.
>>>
>>> I'm confused, you said `into_foreign` above. I don't think any sensible
>>> ForeignOwnable implementation will drop a T in any of its functions.
>>>
>>
>> A KBox<T> would drop T when it gets dropped, no?
>> A Arc<T> would drop T when it gets dropped if it=E2=80=99s the last refc=
ount.
>>
>> I was trying to say =E2=80=9CForeignOwnable::drop() may implies Target::=
drop()=E2=80=9D,
>> that=E2=80=99s what a =E2=80=9Cpayload=E2=80=9D means. Maybe that I used=
 =E2=80=9CT=E2=80=9D instead of =E2=80=9CTarget=E2=80=9D
>> in the original message caused confusion?

Ah now I understand what you are saying. Your mentioning of
`into_foreign` and `from_foreign` confused me. Yes a `ForeignOwnable`
may drop a `T`/`Target` in its own drop function. But I don't think we
need to document that.

> The point is whichever receives the pointer from a into_foreign()
> would owns the Target, because it can from_foreign() and
> drop the ForeignOwnable. So for example, if the pointer can
> be passed across threads, that means Target needs to be Send.

We should solve this in a different manner. Document the `Send` & `Sync`
requirements on `into_foreign`. So when you turn a `P: ForeignOwnable`
that is `!Send` into a raw pointer, you are not allowed to call
`from_foreign` on a different thread.

If `P: !Sync` then you're not allowed to call `borrow[_mut]` on the
pointer from two different threads (ie only the one that is currently
owning the value is allowed to call that).

---
Cheers,
Benno

