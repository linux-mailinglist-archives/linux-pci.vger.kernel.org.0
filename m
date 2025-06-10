Return-Path: <linux-pci+bounces-29329-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C0FAD3AD8
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 16:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B46DD189E8E1
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 14:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46492BDC31;
	Tue, 10 Jun 2025 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1Z2mF99"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68792BDC17;
	Tue, 10 Jun 2025 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749564647; cv=none; b=WWx/RWQnrEi7uI042YqFD2D2fw1fyoU7uLHLFsO7550nfEg/sRy52YZl1YwnVUASN5ckK70XDOPUhuqr4qJbRK9/ayMqoR9TurgDUMZhPswJnCCwPB9CLXy64vF0rstKlxjnOiXr8EL7QxdlXqsF2ZLsT3VHlGCy5C5G8bwjdko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749564647; c=relaxed/simple;
	bh=QjZ8a8P4pQqwJf6dWhzKqNDeFLekYrZPqAJgEZkFTeo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jXbk3nG6OrTPyxPSVJdWePOTCaR6KbmNwQr1KZdUt/t+EE/dT9B2GCV2zWVEaO26/EoonUGrJQZCC8qXDeLFPdr5Fj8evjXlbKDTCqnfwxKjMzafXabN5T02a3qkht/uexUkMaL80o98z4mXwXuhDWthMFxSFgn79tjDvf0uuvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1Z2mF99; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735B5C4CEED;
	Tue, 10 Jun 2025 14:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749564647;
	bh=QjZ8a8P4pQqwJf6dWhzKqNDeFLekYrZPqAJgEZkFTeo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=k1Z2mF99d/FU6slRmDZ4SUg8YGOODDgBzvVpMJCDxEcLlwMqQhXhCx8b91rsToKgr
	 PZu1g/7rqFKosT/zJKT8t9kknQD9nf4BgIJS6Ec3Wocj1uKKBILdyhZOS/COYhx1l3
	 ZIsDiha0d3g4qjy34HuG/VW7ILm5hZ7SgA0CcRIPqFJBfc7NhrapBqhUXKuYvoYA8k
	 Eb6SltDsH97HgP1VotZHOWSlN990nhDqZIVcMzm3bwcTQPcn2LMKbCDjPDgXYUt6Mq
	 q0ZbjXngB8hLfIxzTLcKmDmzAhKP2c4Ic0OyikLa2YvKY3i+yXHoamgM/uMpk+vbeo
	 6X8xUVDyaxgxw==
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
Subject: Re: [PATCH v2] rust: types: add FOREIGN_ALIGN to ForeignOwnable
In-Reply-To: <DAIV6MJAJ5R0.3TZ4IC2KO9MOL@kernel.org> (Benno Lossin's message
	of "Tue, 10 Jun 2025 14:49:47 +0200")
References: <20250610-pointed-to-v2-1-fad8f92cf1e5@kernel.org>
	<HCd56HpzAlpsTZWbmM8R3IN8MCXWW-kpIjIt_K1D8ZFN6DLqIGmpNRJdle94PGpHYS86rmmhCPci9TajHZCCrw==@protonmail.internalid>
	<DAIV6MJAJ5R0.3TZ4IC2KO9MOL@kernel.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 10 Jun 2025 16:10:37 +0200
Message-ID: <87v7p3znz6.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <lossin@kernel.org> writes:

> On Tue Jun 10, 2025 at 1:30 PM CEST, Andreas Hindborg wrote:
>> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
>> index 22985b6f6982..0ccef6b5a20a 100644
>> --- a/rust/kernel/types.rs
>> +++ b/rust/kernel/types.rs
>> @@ -21,15 +21,11 @@
>>  ///
>>  /// # Safety
>>  ///
>> -/// Implementers must ensure that [`into_foreign`] returns a pointer which meets the alignment
>> -/// requirements of [`PointedTo`].
>> -///
>> -/// [`into_foreign`]: Self::into_foreign
>> -/// [`PointedTo`]: Self::PointedTo
>> +/// Implementers must ensure that [`Self::into_foreign`] returns pointers aligned to
>> +/// [`Self::FOREIGN_ALIGN`].
>>  pub unsafe trait ForeignOwnable: Sized {
>> -    /// Type used when the value is foreign-owned. In practical terms only defines the alignment of
>> -    /// the pointer.
>> -    type PointedTo;
>> +    /// The alignment of pointers returned by `into_foreign`.
>> +    const FOREIGN_ALIGN: usize;
>>
>>      /// Type used to immutably borrow a value that is currently foreign-owned.
>>      type Borrowed<'a>;
>> @@ -39,18 +35,20 @@ pub unsafe trait ForeignOwnable: Sized {
>>
>>      /// Converts a Rust-owned object to a foreign-owned one.
>>      ///
>> +    /// The foreign representation is a pointer to void. Aside from the guarantees listed below,
>
> I feel like this reads better:
>
> s/guarantees/ones/
>
>> +    /// there are no other guarantees for this pointer. For example, it might be invalid, dangling
>
> We should also mention that it could be null. (or is that assumption
> wrong?)

It is probably not going to be null, but it is allowed to. I can add it.

The list does not claim to be exhaustive, and a null pointer is just a
special case of an invalid pointer.


Best regards,
Andreas Hindborg



