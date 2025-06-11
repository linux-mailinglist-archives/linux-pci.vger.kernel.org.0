Return-Path: <linux-pci+bounces-29432-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AFCAD54A3
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 13:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEE4E17B7CE
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 11:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9094127C87E;
	Wed, 11 Jun 2025 11:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1ON1W7n"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A1927C145;
	Wed, 11 Jun 2025 11:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749642690; cv=none; b=kr6aU262sfJT0jS1KnI4o5FI6erb4CwUJVjHTxUGeBUeOCxjmuNDUUA2Sf2DfkXzB3ux4G2BygxY8vOO7h277bG0sT8HhkCaWzd8xTUCiAi8q1bmeXhwZvWvoFmv/sMRXIa627OL5KN/ZCgPoQQd7V2no3Lp+yArrcP2iGJfX74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749642690; c=relaxed/simple;
	bh=UntChnF5TiA3QQXJoWwoKNQ5Ir99qkBbzql/YHxX4gQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=fEEpI/UbOcPgVx18yXSHj75oCWFxzBO9uDyVvz3rRDVJvY0nAGvrPlDpNb6Fjmtf1V/qTafn03FD7TFN0zXQc6mIvsozbaq15lCt9BcUL50L+f8LZwRcj01e1Ar4DAGGJ1s6WhApDbt2jBzjX9Pf5LFDGH1yX2l8KY1LXHzU6BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1ON1W7n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F05DC4CEF1;
	Wed, 11 Jun 2025 11:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749642689;
	bh=UntChnF5TiA3QQXJoWwoKNQ5Ir99qkBbzql/YHxX4gQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b1ON1W7nmk2q9a+Sy1guAfKKNVdJERx8Xfk2riNPkvD+SpVHLr5ONi28DQHQ3cyim
	 K0Sd8xd3fNR7VI9QpEQyNNyc73p20nNh9O42ME1aQHNr3lRl4FS4x5BKpCNM8YZam0
	 5dTQ+I/mzElbkdulywvtWKdzDnTd3puG8wBhxFBYxqb7+Dli5DIs+6mfBvxGT0d+Qo
	 UOO8HlMHI9aKXxQwEqdMv9/BdYV4ISJZVvfXS5faxs2komCAyJVsZJlxRdEV2sU8wu
	 +ldnQY7ll2GN55FfhXL+XXKNP9QrXNEcEVTHLeJJYMv1rOXm8B9Opasy5h6qY+Ae5J
	 zosPd5HxaiOIA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Jun 2025 13:51:21 +0200
Message-Id: <DAJOKFHW96XZ.2ANYSSFQO03ZL@kernel.org>
From: "Benno Lossin" <lossin@kernel.org>
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Trevor Gross" <tmgross@umich.edu>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Tamir Duberstein" <tamird@gmail.com>, "Viresh Kumar"
 <viresh.kumar@linaro.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: Re: [PATCH v2] rust: types: add FOREIGN_ALIGN to ForeignOwnable
X-Mailer: aerc 0.20.1
References: <20250610-pointed-to-v2-1-fad8f92cf1e5@kernel.org>
 <HCd56HpzAlpsTZWbmM8R3IN8MCXWW-kpIjIt_K1D8ZFN6DLqIGmpNRJdle94PGpHYS86rmmhCPci9TajHZCCrw==@protonmail.internalid> <DAIV6MJAJ5R0.3TZ4IC2KO9MOL@kernel.org> <87v7p3znz6.fsf@kernel.org> <CAH5fLgi3B_Wyz2OzBLhHHgWrg7hboyFUcQe-+GUrrvXiX9di=w@mail.gmail.com> <GHUD6hpYDty0s_oTLGC6owDPKqrNepeGOL9F-XlvY6G50K8Zptjp4f8kVVnyoTjf-E_0QVeHfmUUvcN-p1i24Q==@protonmail.internalid> <DAJHVMM9DND0.2FM0FJYN0XEFV@kernel.org> <87jz5izhg3.fsf@kernel.org>
In-Reply-To: <87jz5izhg3.fsf@kernel.org>

On Wed Jun 11, 2025 at 12:43 PM CEST, Andreas Hindborg wrote:
> "Benno Lossin" <lossin@kernel.org> writes:
>
>> On Tue Jun 10, 2025 at 4:15 PM CEST, Alice Ryhl wrote:
>>> On Tue, Jun 10, 2025 at 4:10=E2=80=AFPM Andreas Hindborg <a.hindborg@ke=
rnel.org> wrote:
>>>>
>>>> "Benno Lossin" <lossin@kernel.org> writes:
>>>>
>>>> > On Tue Jun 10, 2025 at 1:30 PM CEST, Andreas Hindborg wrote:
>>>> >> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
>>>> >> index 22985b6f6982..0ccef6b5a20a 100644
>>>> >> --- a/rust/kernel/types.rs
>>>> >> +++ b/rust/kernel/types.rs
>>>> >> @@ -21,15 +21,11 @@
>>>> >>  ///
>>>> >>  /// # Safety
>>>> >>  ///
>>>> >> -/// Implementers must ensure that [`into_foreign`] returns a point=
er which meets the alignment
>>>> >> -/// requirements of [`PointedTo`].
>>>> >> -///
>>>> >> -/// [`into_foreign`]: Self::into_foreign
>>>> >> -/// [`PointedTo`]: Self::PointedTo
>>>> >> +/// Implementers must ensure that [`Self::into_foreign`] returns p=
ointers aligned to
>>>> >> +/// [`Self::FOREIGN_ALIGN`].
>>>> >>  pub unsafe trait ForeignOwnable: Sized {
>>>> >> -    /// Type used when the value is foreign-owned. In practical te=
rms only defines the alignment of
>>>> >> -    /// the pointer.
>>>> >> -    type PointedTo;
>>>> >> +    /// The alignment of pointers returned by `into_foreign`.
>>>> >> +    const FOREIGN_ALIGN: usize;
>>>> >>
>>>> >>      /// Type used to immutably borrow a value that is currently fo=
reign-owned.
>>>> >>      type Borrowed<'a>;
>>>> >> @@ -39,18 +35,20 @@ pub unsafe trait ForeignOwnable: Sized {
>>>> >>
>>>> >>      /// Converts a Rust-owned object to a foreign-owned one.
>>>> >>      ///
>>>> >> +    /// The foreign representation is a pointer to void. Aside fro=
m the guarantees listed below,
>>>> >
>>>> > I feel like this reads better:
>>>> >
>>>> > s/guarantees/ones/
>>>> >
>>>> >> +    /// there are no other guarantees for this pointer. For exampl=
e, it might be invalid, dangling
>>>> >
>>>> > We should also mention that it could be null. (or is that assumption
>>>> > wrong?)
>>>>
>>>> It is probably not going to be null, but it is allowed to. I can add i=
t.
>>>>
>>>> The list does not claim to be exhaustive, and a null pointer is just a
>>>> special case of an invalid pointer.
>>>
>>> We probably should not allow null pointers. If we do, then
>>> try_from_foreign does not make sense.
>>
>> That's a good point. Then let's add that as a safety requirement for the
>> trait.
>
> I disagree. It does not matter for the safety of the trait.
>
> From the point of the user, the pointer is opaque and can be any value.
> In fact, one could do a safe implementation where the returned value is
> a key into some mapping structure. Probably not super fast, but the user
> should not care.

Then we'll have to remove `try_from_foreign`.

---
Cheers,
Benno

