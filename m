Return-Path: <linux-pci+bounces-29422-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C89EAD5270
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 12:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F6F7189A611
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 10:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5D72741BD;
	Wed, 11 Jun 2025 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5y97M6f"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815672741A2;
	Wed, 11 Jun 2025 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749638645; cv=none; b=Q9x0nox6mcY5ZMdxCafyTo6whNmuePUJUlysWQqDEhMRtHC6/HOnd74nWw9N11IBm14cR/sqLqufHBAU/KOjCoMnqXnsbjtJrzQjBx7Fl9TJkJ78qm40ASXWptezTn0mBEGYDFd4aCUkPUsPrJiAiMWyZ9KklQauxVNc6WmFmXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749638645; c=relaxed/simple;
	bh=Y+E0RernoPBy6Uu3TI84qynsG952E7mhrc4IsFrLBMw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ssse8i2HAk3q3K5ZkH838PXXJ5HjkpIpEws16umrv3lXihK5Ss9xVtMwJExoofubFwfnYX2f3DWZsioQLayAMD1ISz3fMeY1zMTEOEzpq0txEoivL4DZwjarBQEK79/RpjqoICSrD81I1zGHY7cC67afdK9SCtKMQVdFD31cUlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5y97M6f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F408C4CEF1;
	Wed, 11 Jun 2025 10:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749638645;
	bh=Y+E0RernoPBy6Uu3TI84qynsG952E7mhrc4IsFrLBMw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=I5y97M6f50cvQr9uKp0kUq+9BZMTImITmMRenueRNabxOzKVQyQnTLxbxmtTZxO5U
	 MuDdYfxHemloZH4Cae0vXdincPivKew92K2fsYKBHvufaFJ/6hh27G0I3cVM3HsxR/
	 12P5c9q3qgMr0wbH+6gYGusSngdMQNcdUaZ5O+VMO6WFUjTDstfcZjjKhCunYBUlR2
	 iA/84eicv9QqagjXKqAOgVl4u17gVrqDc4fHejiYpneNgSaHf9RORlssoWb3SghNBz
	 R27yj1lvJ5M7ad3VBUwV+z1ppAVFVDZFKOVd8PQjCyAgkHTt1rLqEelEff47K1kHdi
	 y8iJweniGuBfQ==
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
In-Reply-To: <DAJHVMM9DND0.2FM0FJYN0XEFV@kernel.org> (Benno Lossin's message
	of "Wed, 11 Jun 2025 08:36:50 +0200")
References: <20250610-pointed-to-v2-1-fad8f92cf1e5@kernel.org>
	<HCd56HpzAlpsTZWbmM8R3IN8MCXWW-kpIjIt_K1D8ZFN6DLqIGmpNRJdle94PGpHYS86rmmhCPci9TajHZCCrw==@protonmail.internalid>
	<DAIV6MJAJ5R0.3TZ4IC2KO9MOL@kernel.org> <87v7p3znz6.fsf@kernel.org>
	<CAH5fLgi3B_Wyz2OzBLhHHgWrg7hboyFUcQe-+GUrrvXiX9di=w@mail.gmail.com>
	<GHUD6hpYDty0s_oTLGC6owDPKqrNepeGOL9F-XlvY6G50K8Zptjp4f8kVVnyoTjf-E_0QVeHfmUUvcN-p1i24Q==@protonmail.internalid>
	<DAJHVMM9DND0.2FM0FJYN0XEFV@kernel.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 11 Jun 2025 12:43:56 +0200
Message-ID: <87jz5izhg3.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Benno Lossin" <lossin@kernel.org> writes:

> On Tue Jun 10, 2025 at 4:15 PM CEST, Alice Ryhl wrote:
>> On Tue, Jun 10, 2025 at 4:10=E2=80=AFPM Andreas Hindborg <a.hindborg@ker=
nel.org> wrote:
>>>
>>> "Benno Lossin" <lossin@kernel.org> writes:
>>>
>>> > On Tue Jun 10, 2025 at 1:30 PM CEST, Andreas Hindborg wrote:
>>> >> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
>>> >> index 22985b6f6982..0ccef6b5a20a 100644
>>> >> --- a/rust/kernel/types.rs
>>> >> +++ b/rust/kernel/types.rs
>>> >> @@ -21,15 +21,11 @@
>>> >>  ///
>>> >>  /// # Safety
>>> >>  ///
>>> >> -/// Implementers must ensure that [`into_foreign`] returns a pointe=
r which meets the alignment
>>> >> -/// requirements of [`PointedTo`].
>>> >> -///
>>> >> -/// [`into_foreign`]: Self::into_foreign
>>> >> -/// [`PointedTo`]: Self::PointedTo
>>> >> +/// Implementers must ensure that [`Self::into_foreign`] returns po=
inters aligned to
>>> >> +/// [`Self::FOREIGN_ALIGN`].
>>> >>  pub unsafe trait ForeignOwnable: Sized {
>>> >> -    /// Type used when the value is foreign-owned. In practical ter=
ms only defines the alignment of
>>> >> -    /// the pointer.
>>> >> -    type PointedTo;
>>> >> +    /// The alignment of pointers returned by `into_foreign`.
>>> >> +    const FOREIGN_ALIGN: usize;
>>> >>
>>> >>      /// Type used to immutably borrow a value that is currently for=
eign-owned.
>>> >>      type Borrowed<'a>;
>>> >> @@ -39,18 +35,20 @@ pub unsafe trait ForeignOwnable: Sized {
>>> >>
>>> >>      /// Converts a Rust-owned object to a foreign-owned one.
>>> >>      ///
>>> >> +    /// The foreign representation is a pointer to void. Aside from=
 the guarantees listed below,
>>> >
>>> > I feel like this reads better:
>>> >
>>> > s/guarantees/ones/
>>> >
>>> >> +    /// there are no other guarantees for this pointer. For example=
, it might be invalid, dangling
>>> >
>>> > We should also mention that it could be null. (or is that assumption
>>> > wrong?)
>>>
>>> It is probably not going to be null, but it is allowed to. I can add it.
>>>
>>> The list does not claim to be exhaustive, and a null pointer is just a
>>> special case of an invalid pointer.
>>
>> We probably should not allow null pointers. If we do, then
>> try_from_foreign does not make sense.
>
> That's a good point. Then let's add that as a safety requirement for the
> trait.

I disagree. It does not matter for the safety of the trait.

From the point of the user, the pointer is opaque and can be any value.
In fact, one could do a safe implementation where the returned value is
a key into some mapping structure. Probably not super fast, but the user
should not care.


Best regards,
Andreas Hindborg



