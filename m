Return-Path: <linux-pci+bounces-32728-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD6DB0DA23
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 14:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090AB16FB60
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 12:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4F52E4266;
	Tue, 22 Jul 2025 12:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtyPEni2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFE02E3361;
	Tue, 22 Jul 2025 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753188579; cv=none; b=dbai6WvVwm2TdDZwFRqxpNQaT1Bb8U1dQ05iooLBUn8u1z+ueQaT478g6pKUiQRz7RMyKdIkh4HBwFPPwGdUkR8U08vuoj+r1NMLexW3cAtG5EGSr0Ym//FdwxViV7FvOA1lSZRNnIV0T6cmZcIjHTN52p+C7X+mIo7DC2MQ2FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753188579; c=relaxed/simple;
	bh=oNwMiBXgoxAtXhsHS6DKVIyV2eUv8rV5AOhnRZAWJ2E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=R9/oWEtuC+O1J2GUwem6W9lV2d6liskg3RvH+czQTeeXi/6cvs6hPwfjXK3QFhqUcNYT763CNYLm3RECocAxCqgz7hxnKBP/IHxtxd26AIa6nqe0waTwHIjd4SLZ1/i7otDauXRB5bLn0SYOakSqVLNpFZPv5uZqdJgQR8ceKJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtyPEni2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15FF1C4CEEB;
	Tue, 22 Jul 2025 12:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753188578;
	bh=oNwMiBXgoxAtXhsHS6DKVIyV2eUv8rV5AOhnRZAWJ2E=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=JtyPEni2pn3zIZBbMRXsPZRCZxDuIZH+7lkzf9SixKAErZdKqkxbHXKyC5BNPKQrQ
	 jKcmHIlHtAAEvKsGQEtFbKESYHoFWSsZIbWVUGGknV0ZGcDJw1Mfjd6F/GwFd+ub6+
	 4G0cpruII5Etz3YAjHMXvaGJGkxlWT2cbx1FLzpUC8J8vx5QQP9cpwHqxj1a+9eJ4k
	 dArNEBEpCx3acyQ15vyMWH4FadVVBoekvdVSKnWlL+nbsNqOsd0g6LDLakRgPRLi/t
	 McOzDVtORpMv7PMbqlwkgi+qmETPr/PeZzklNhZKsn+2mvf6WDybNFBg2UnDYDJlUt
	 h3F9uOCTLxSBQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Jul 2025 14:49:33 +0200
Message-Id: <DBILHBVA0NKJ.3R2QIVE9QIMM3@kernel.org>
Subject: Re: [PATCH v2 1/2] rust: Update PCI binding safety comments and add
 inline compiler hint
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Alistair Popple"
 <apopple@nvidia.com>, <rust-for-linux@vger.kernel.org>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "John Hubbard" <jhubbard@nvidia.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Benno Lossin" <lossin@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250710022415.923972-1-apopple@nvidia.com>
 <DB87TX9Y5018.N1WDM8XRN74K@kernel.org>
 <DB9BF6WK8KMH.1RQOOMYBL6UAO@kernel.org>
 <DB9FUEJUOH3L.14CYPZ8YQT52E@kernel.org>
 <DB9H6HEF9CKG.2SAPXM8F9KOO3@kernel.org>
 <DB9IQAU4WPSP.XZL4ZDPT59KU@kernel.org>
 <bwbern2t7k5fcj6zxze6bjpasu3t26n6dmfptlmhbhd7qmligs@3fgwifsw7qai>
 <DBIHP8IP3OHA.8Y1S9ZV1Y1SZ@kernel.org>
 <DBIJ3POBANNM.KSO1I5557PFV@kernel.org>
 <CAH5fLghic7MZd-BO=Z-ostGLgWmBciQmZp9VjQpLGWskFK_gyQ@mail.gmail.com>
 <DBIKM7U4TSB8.17MTNSR81W8F3@kernel.org>
In-Reply-To: <DBIKM7U4TSB8.17MTNSR81W8F3@kernel.org>

On Tue Jul 22, 2025 at 2:08 PM CEST, Benno Lossin wrote:
> On Tue Jul 22, 2025 at 1:35 PM CEST, Alice Ryhl wrote:
>> On Tue, Jul 22, 2025 at 12:57=E2=80=AFPM Benno Lossin <lossin@kernel.org=
> wrote:
>>>
>>> On Tue Jul 22, 2025 at 11:51 AM CEST, Danilo Krummrich wrote:
>>> > I think they're good, but we're pretty late in the cycle now. That sh=
ould be
>>> > fine though, we can probably take them through the nova tree, or in t=
he worst
>>> > case share a tag, if needed.
>>> >
>>> > Given that, it would probably be good to add the Guarantee section on=
 as_raw(),
>>> > as proposed by Benno, right away.
>>> >
>>> > @Benno: Any proposal on what this section should say?
>>>
>>> At a minimum I'd say "The returned pointer is valid.", but that doesn't
>>> really say for what it's valid... AFAIK you're mostly using this pointe=
r
>>> to pass it to the C side, in that case, how about:
>>>
>>>     /// # Guarantees
>>>     ///
>>>     /// The returned pointer is valid for reads and writes from the C s=
ide for as long as `self` exists.
>>>
>>> Maybe we need to change it a bit more, but let's just start with this.
>>>
>>> (If you're also using the pointer from Rust, then we need to make
>>> changes)
>>
>> Honestly I think this is a bit over the top. I wouldn't bother adding
>> a section like that to every single as_raw() method out there.
>
> Hmm. And then just assume that these kinds of functions return valid
> pointers? I get that this is annoying to put on every function...
>
> Another option would be to have a `Ptr<'a, T>` type that is a valid
> pointer, but doesn't allow writing/reading safely (you need to justify
> why it's not a data race). And for FFI there could be an `as_ptr`
> function.

I don't understand where's the difference between the two. For FFI calls we=
'd
also have to justify it's not a data race, no?

The only guarantee we take as granted from as_raw() is that it returns a ra=
w
pointer to the wrapped FFI type in Self, i.e. it points to valid memory. An=
y
additional guarantees may come from the context where the pointer is used a=
nd
which specific fields it is used to access.

