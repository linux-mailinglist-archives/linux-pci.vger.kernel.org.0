Return-Path: <linux-pci+bounces-29302-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDAAAD32EF
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 11:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 960FC3B5349
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 09:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5925B28BA90;
	Tue, 10 Jun 2025 09:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCglwtz2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C44E28B4FD;
	Tue, 10 Jun 2025 09:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749549493; cv=none; b=lmdPNz8Lqasz3YKDlh4hQszgRE7mMBbMuADyRTSrnj44Umo+u6hoL3FnfGFMcukZ/V7eTjBqYoHkNnyeNATenkKL6zA4cA1EFM/ICcViz65eb0ybpqbqA8uQ4OHewb/prTk8wc83GZ4kUdrXOAszlX+cYYB4/3E3O9w9RtBynAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749549493; c=relaxed/simple;
	bh=LvjZWTxkoJjdq6mNR3PqdVpVlqtMMxO1dSyjw1hqIEc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=SC1sbrIPm/hi6FD/Mw/boTOLIgMc/slQRtRU8iXvACpFvPY+HxaKjdi4O4kSEQv48ft4o5vd4vM8V55KGRApx2L5XalAuTN/04Q9NNQDGEeJtcaKHJQV1jNNNy/GEqTiMM+cZ6eHkvrGWRSEOGgamKu9haPMby+ujTuO1xBp3P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCglwtz2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D04C4CEEF;
	Tue, 10 Jun 2025 09:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749549492;
	bh=LvjZWTxkoJjdq6mNR3PqdVpVlqtMMxO1dSyjw1hqIEc=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=FCglwtz2hrf8dzbUZ8iQ9kWAncwhQ/PaJYnGSUAll7aI/78jgYWgUJt3+Pnn6+RD/
	 oUqFmjn3ylB4L14cUtnVVn5HZnkXTr3CDOw60R2qMfIOtzTiZGKAs0+TbvuYMWCNJ6
	 NqsPL8Xk2ochKmB3Jg5Ikm4Gyq7hEjOnWZfEWrsQXoa2mkRm3X2MaeaIxAeoWOorsx
	 KlWSxtMoJKPZ0fKBnihQ/3giYj+jZ2O5l2A6qB1C5VXawJobp/lIcHjNRAAP+2t/kt
	 RjUNR06X4x1qVDxBGl0yNbxDrxJDBGXn/eAmGC/QH0UijSppwY0bCDYm1Y+L9T8NZQ
	 Pw6LnMQJVqMIw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Jun 2025 11:58:07 +0200
Message-Id: <DAIRJ71UP655.2NF13FJSA0G68@kernel.org>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor
 Gross" <tmgross@umich.edu>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Tamir Duberstein" <tamird@gmail.com>, "Viresh Kumar"
 <viresh.kumar@linaro.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: Re: [PATCH] rust: types: add FOREIGN_ALIGN to ForeignOwnable
From: "Benno Lossin" <lossin@kernel.org>
To: "Andreas Hindborg" <a.hindborg@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250605-pointed-to-v1-1-ee1e262912cc@kernel.org>
 <WubHJPtx9Uu0qugeELZ2ooYWKq4KDj7r8P7k4i_QhgOP53MWk1V3XHH4Ztmzp42zMwHSntslAbfpLFY9AhjfxQ==@protonmail.internalid> <DAFB0GKSGPSF.24BE695LGC28Z@kernel.org> <87sek82bgf.fsf@kernel.org>
In-Reply-To: <87sek82bgf.fsf@kernel.org>

On Tue Jun 10, 2025 at 11:27 AM CEST, Andreas Hindborg wrote:
> Hi Benno,
>
> "Benno Lossin" <lossin@kernel.org> writes:
>
>> The title should probably also mention that it removes `PointedTo`.

Just making sure that you saw this.

>> On Thu Jun 5, 2025 at 9:55 PM CEST, Andreas Hindborg wrote:
>>>  pub unsafe trait ForeignOwnable: Sized {
>>> -    /// Type used when the value is foreign-owned. In practical terms =
only defines the alignment of
>>> -    /// the pointer.
>>> -    type PointedTo;
>>> +    /// The alignment of pointers returned by `into_foreign`.
>>> +    const FOREIGN_ALIGN: usize;
>>>
>>>      /// Type used to immutably borrow a value that is currently foreig=
n-owned.
>>>      type Borrowed<'a>;
>>> @@ -39,18 +35,17 @@ pub unsafe trait ForeignOwnable: Sized {
>>>
>>>      /// Converts a Rust-owned object to a foreign-owned one.
>>>      ///
>>> -    /// # Guarantees
>>
>> Why remove this section? I think we should streamline it, (make it use
>> bullet points, shorten the sentences etc). We can keep the paragraph you
>> wrote below as normal docs.
>
> Not sure exactly what you are going for here. How is this:
>
>
>   Converts a Rust-owned object to a foreign-owned one.
>
>   The foreign representation is a pointer to void.
>
>   # Guarantees
>
>   - Minimum alignment of returned pointer is [`Self::FOREIGN_ALIGN`].
>
>   There are no other guarantees for this pointer. For example, it might b=
e invalid, dangling
>   or pointing to uninitialized memory. Using it in any way except for [`f=
rom_foreign`],
>   [`try_from_foreign`], [`borrow`], or [`borrow_mut`] can result in undef=
ined behavior.

Maybe even move this paragraph above the `Guarantees` section and change
the beginning of it to "Aside from the guarantees listed below, there
are no other..."?

Otherwise looks good!

---
Cheers,
Benno

