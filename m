Return-Path: <linux-pci+bounces-29433-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BBEAD552D
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 14:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 139843A980A
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 12:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF75B27C864;
	Wed, 11 Jun 2025 12:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Edv1PjRq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07C027C144;
	Wed, 11 Jun 2025 12:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749644078; cv=none; b=j/CaWHhSq4AHnijxufar/wpdMfsBV7o91D77sNlbIRDSHI7JBTIe5Fu4h4FIxICNq3wsPKi71ByfPTweg23gC5XZWrR70mg5y6bHnhYB7KPx2adBBlJlauTEVWK70AhbnVRV4OJvnuwzmKTuFqkPngjuxmc+ZnXQNwO7UEdbYZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749644078; c=relaxed/simple;
	bh=FJ1AHEgMmhRXu6CGnQHlc/GRmFKNYpmO4gT7upoqODo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X1oWY2vZDV33IuZ6GL6EgUXm9aPIGY+2jIYZy647t3AaKu3/EQGOyTI0rthHTLooHpKuy78Kuhmbmgnd4RyjQRRIHifVKoMqicJSlExD9jTlrE+Fg9KyFuA0HPL2nuRhhxnUF9lHABzNtS+j0jiHvKKTBouN6tf1Ub30/kI2IU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Edv1PjRq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CA4C4CEEE;
	Wed, 11 Jun 2025 12:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749644078;
	bh=FJ1AHEgMmhRXu6CGnQHlc/GRmFKNYpmO4gT7upoqODo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Edv1PjRqitKqfWC53D9UEbG5O7XatWHfY7eu+CVCezYUjI3iBlpiUxBWy9hpBq1Hi
	 O1ZCBbV56G1rRrHGu22LJh5nGSOp5lyHWsjC6T287wv7lwRVjbRyjPOfLiZXH1LltK
	 cARMxYQmV/wbB3nmtlqA9Akubigyrr7gNIu1LFSWDfi+mvit8EIB0rCMQgGta+L5Hn
	 r43JxzN/IgcIkVdtPJnrFYuDYgwzqrMhshnPiaFdKb3jZSFZITCXcER5VXNDIVr1A/
	 qeJrKq6C14kg1z1G0WmqEcuqy4UISfjKibFRO1t6myCj0+5+fZJcZS7YS616khN/Ak
	 4vv72X4cGTt5g==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <lossin@kernel.org>
Cc: "Alice Ryhl" <aliceryhl@google.com>,  "Danilo Krummrich"
 <dakr@kernel.org>,  "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Trevor
 Gross" <tmgross@umich.edu>,  "Bjorn Helgaas" <bhelgaas@google.com>,
  Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,  "Greg
 Kroah-Hartman"
 <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki" <rafael@kernel.org>,
  "Tamir Duberstein" <tamird@gmail.com>,  "Viresh Kumar"
 <viresh.kumar@linaro.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-pci@vger.kernel.org>,
  =?utf-8?Q?Ma=C3=ADra?=
 Canal <mcanal@igalia.com>
Subject: Re: [PATCH v2] rust: types: add FOREIGN_ALIGN to ForeignOwnable
In-Reply-To: <DAJOKFHW96XZ.2ANYSSFQO03ZL@kernel.org> (Benno Lossin's message
	of "Wed, 11 Jun 2025 13:51:21 +0200")
References: <20250610-pointed-to-v2-1-fad8f92cf1e5@kernel.org>
	<HCd56HpzAlpsTZWbmM8R3IN8MCXWW-kpIjIt_K1D8ZFN6DLqIGmpNRJdle94PGpHYS86rmmhCPci9TajHZCCrw==@protonmail.internalid>
	<DAIV6MJAJ5R0.3TZ4IC2KO9MOL@kernel.org> <87v7p3znz6.fsf@kernel.org>
	<CAH5fLgi3B_Wyz2OzBLhHHgWrg7hboyFUcQe-+GUrrvXiX9di=w@mail.gmail.com>
	<GHUD6hpYDty0s_oTLGC6owDPKqrNepeGOL9F-XlvY6G50K8Zptjp4f8kVVnyoTjf-E_0QVeHfmUUvcN-p1i24Q==@protonmail.internalid>
	<DAJHVMM9DND0.2FM0FJYN0XEFV@kernel.org> <87jz5izhg3.fsf@kernel.org>
	<WXoNAlTJvpteJEAZ3TkYKk2QWHBC0oID8Dy3AHGxLEwiZwBPdSLZB4MpdbObLtFvqiN9re3q6OQpiua2uiv1Hw==@protonmail.internalid>
	<DAJOKFHW96XZ.2ANYSSFQO03ZL@kernel.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 11 Jun 2025 14:14:25 +0200
Message-ID: <878qlyzd9a.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Benno Lossin" <lossin@kernel.org> writes:

> On Wed Jun 11, 2025 at 12:43 PM CEST, Andreas Hindborg wrote:
>> "Benno Lossin" <lossin@kernel.org> writes:
>>
>>> On Tue Jun 10, 2025 at 4:15 PM CEST, Alice Ryhl wrote:
>>>> On Tue, Jun 10, 2025 at 4:10=E2=80=AFPM Andreas Hindborg <a.hindborg@k=
ernel.org> wrote:
>>>>>
>>>>> "Benno Lossin" <lossin@kernel.org> writes:
>>>>>
>>>>> > On Tue Jun 10, 2025 at 1:30 PM CEST, Andreas Hindborg wrote:
>>>>> >> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
>>>>> >> index 22985b6f6982..0ccef6b5a20a 100644
>>>>> >> --- a/rust/kernel/types.rs
>>>>> >> +++ b/rust/kernel/types.rs
>>>>> >> @@ -21,15 +21,11 @@
>>>>> >>  ///
>>>>> >>  /// # Safety
>>>>> >>  ///
>>>>> >> -/// Implementers must ensure that [`into_foreign`] returns a poin=
ter which meets the alignment
>>>>> >> -/// requirements of [`PointedTo`].
>>>>> >> -///
>>>>> >> -/// [`into_foreign`]: Self::into_foreign
>>>>> >> -/// [`PointedTo`]: Self::PointedTo
>>>>> >> +/// Implementers must ensure that [`Self::into_foreign`] returns =
pointers aligned to
>>>>> >> +/// [`Self::FOREIGN_ALIGN`].
>>>>> >>  pub unsafe trait ForeignOwnable: Sized {
>>>>> >> -    /// Type used when the value is foreign-owned. In practical t=
erms only defines the alignment of
>>>>> >> -    /// the pointer.
>>>>> >> -    type PointedTo;
>>>>> >> +    /// The alignment of pointers returned by `into_foreign`.
>>>>> >> +    const FOREIGN_ALIGN: usize;
>>>>> >>
>>>>> >>      /// Type used to immutably borrow a value that is currently f=
oreign-owned.
>>>>> >>      type Borrowed<'a>;
>>>>> >> @@ -39,18 +35,20 @@ pub unsafe trait ForeignOwnable: Sized {
>>>>> >>
>>>>> >>      /// Converts a Rust-owned object to a foreign-owned one.
>>>>> >>      ///
>>>>> >> +    /// The foreign representation is a pointer to void. Aside fr=
om the guarantees listed below,
>>>>> >
>>>>> > I feel like this reads better:
>>>>> >
>>>>> > s/guarantees/ones/
>>>>> >
>>>>> >> +    /// there are no other guarantees for this pointer. For examp=
le, it might be invalid, dangling
>>>>> >
>>>>> > We should also mention that it could be null. (or is that assumption
>>>>> > wrong?)
>>>>>
>>>>> It is probably not going to be null, but it is allowed to. I can add =
it.
>>>>>
>>>>> The list does not claim to be exhaustive, and a null pointer is just a
>>>>> special case of an invalid pointer.
>>>>
>>>> We probably should not allow null pointers. If we do, then
>>>> try_from_foreign does not make sense.
>>>
>>> That's a good point. Then let's add that as a safety requirement for the
>>> trait.
>>
>> I disagree. It does not matter for the safety of the trait.
>>
>> From the point of the user, the pointer is opaque and can be any value.
>> In fact, one could do a safe implementation where the returned value is
>> a key into some mapping structure. Probably not super fast, but the user
>> should not care.
>
> Then we'll have to remove `try_from_foreign`.

Oh, I see. OK, it is a safety requirement. Should I just add it to this pat=
ch?


Best regards,
Andreas Hindborg




