Return-Path: <linux-pci+bounces-29396-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBA7AD4BD8
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 08:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D67F73A5D32
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 06:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AD417A300;
	Wed, 11 Jun 2025 06:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTx02RgH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8833C79C0;
	Wed, 11 Jun 2025 06:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749623819; cv=none; b=ZEKcdBY1wSnF1EwR7iMKUOrBcqVmq40WYks93Z0gyYjzf7xmvGSoh/f3zrU++n2P4UsPvhFNICsbZeh4AR81n4co8d6EnVp1d8BU6+0Kc2uh7nurttVU1ERBU59QJLG08pmX/Tr5AT57ADwYWESDxCI1cpRaXtcCjQwPlTujUh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749623819; c=relaxed/simple;
	bh=PIQNNAo+DGVA4MpA0hOkYGdVW3ZOmQ8xd6n1BXPRYC8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=HTmTHEnCo8KjDBz8B9Z4A2lmhvi7vVkLGWvELJAM8FDPSY0/OppL4B3+eHov1jjpOEeI91iqkeHiFIwNvlpyUl1tZNXKLfmPUzwyKLEBaYt66hP/6QeSXd+8WDsKFsYTaTcIlKwvF/pZdP47kJznlFtjg8MLilLE3tRLc0P5Wbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTx02RgH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 525E8C4CEEE;
	Wed, 11 Jun 2025 06:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749623819;
	bh=PIQNNAo+DGVA4MpA0hOkYGdVW3ZOmQ8xd6n1BXPRYC8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=MTx02RgHT/gNtB7rEI8Yl7N+0lmbNTAZf8y9c/WAoGAXg43z7echXL+RyHy5toLiv
	 5lZ9R1KGmy7fxsZ58Tj12XyW2oFlJMhWjyPLkD3XcJBCxopCGLL9yFF7LOigqXsFwH
	 COGxWxOYVrLt0tBtR2r3/K7gz1pC7THIQQCar0IkQX+cTzPIaDPnW+ywpmu4sIy8/C
	 QUKYB4x26lde4nOfV7sO5YSo+LorrLk8XwJhXJ4+L5rRvfUt6TR3e6ac9IEwTNx3+U
	 LlfYtRfUMTdkp/8zK9Uj5bnUN7Zlsi3SKWs+8GADd8CQtIngPURnLecMc7DyzcNChJ
	 p8hueRKhk6h0A==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Jun 2025 08:36:50 +0200
Message-Id: <DAJHVMM9DND0.2FM0FJYN0XEFV@kernel.org>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Trevor Gross" <tmgross@umich.edu>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Tamir Duberstein" <tamird@gmail.com>, "Viresh Kumar"
 <viresh.kumar@linaro.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: Re: [PATCH v2] rust: types: add FOREIGN_ALIGN to ForeignOwnable
From: "Benno Lossin" <lossin@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>, "Andreas Hindborg"
 <a.hindborg@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250610-pointed-to-v2-1-fad8f92cf1e5@kernel.org>
 <HCd56HpzAlpsTZWbmM8R3IN8MCXWW-kpIjIt_K1D8ZFN6DLqIGmpNRJdle94PGpHYS86rmmhCPci9TajHZCCrw==@protonmail.internalid> <DAIV6MJAJ5R0.3TZ4IC2KO9MOL@kernel.org> <87v7p3znz6.fsf@kernel.org> <CAH5fLgi3B_Wyz2OzBLhHHgWrg7hboyFUcQe-+GUrrvXiX9di=w@mail.gmail.com>
In-Reply-To: <CAH5fLgi3B_Wyz2OzBLhHHgWrg7hboyFUcQe-+GUrrvXiX9di=w@mail.gmail.com>

On Tue Jun 10, 2025 at 4:15 PM CEST, Alice Ryhl wrote:
> On Tue, Jun 10, 2025 at 4:10=E2=80=AFPM Andreas Hindborg <a.hindborg@kern=
el.org> wrote:
>>
>> "Benno Lossin" <lossin@kernel.org> writes:
>>
>> > On Tue Jun 10, 2025 at 1:30 PM CEST, Andreas Hindborg wrote:
>> >> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
>> >> index 22985b6f6982..0ccef6b5a20a 100644
>> >> --- a/rust/kernel/types.rs
>> >> +++ b/rust/kernel/types.rs
>> >> @@ -21,15 +21,11 @@
>> >>  ///
>> >>  /// # Safety
>> >>  ///
>> >> -/// Implementers must ensure that [`into_foreign`] returns a pointer=
 which meets the alignment
>> >> -/// requirements of [`PointedTo`].
>> >> -///
>> >> -/// [`into_foreign`]: Self::into_foreign
>> >> -/// [`PointedTo`]: Self::PointedTo
>> >> +/// Implementers must ensure that [`Self::into_foreign`] returns poi=
nters aligned to
>> >> +/// [`Self::FOREIGN_ALIGN`].
>> >>  pub unsafe trait ForeignOwnable: Sized {
>> >> -    /// Type used when the value is foreign-owned. In practical term=
s only defines the alignment of
>> >> -    /// the pointer.
>> >> -    type PointedTo;
>> >> +    /// The alignment of pointers returned by `into_foreign`.
>> >> +    const FOREIGN_ALIGN: usize;
>> >>
>> >>      /// Type used to immutably borrow a value that is currently fore=
ign-owned.
>> >>      type Borrowed<'a>;
>> >> @@ -39,18 +35,20 @@ pub unsafe trait ForeignOwnable: Sized {
>> >>
>> >>      /// Converts a Rust-owned object to a foreign-owned one.
>> >>      ///
>> >> +    /// The foreign representation is a pointer to void. Aside from =
the guarantees listed below,
>> >
>> > I feel like this reads better:
>> >
>> > s/guarantees/ones/
>> >
>> >> +    /// there are no other guarantees for this pointer. For example,=
 it might be invalid, dangling
>> >
>> > We should also mention that it could be null. (or is that assumption
>> > wrong?)
>>
>> It is probably not going to be null, but it is allowed to. I can add it.
>>
>> The list does not claim to be exhaustive, and a null pointer is just a
>> special case of an invalid pointer.
>
> We probably should not allow null pointers. If we do, then
> try_from_foreign does not make sense.

That's a good point. Then let's add that as a safety requirement for the
trait.

---
Cheers,
Benno

