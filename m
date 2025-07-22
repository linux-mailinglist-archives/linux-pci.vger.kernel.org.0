Return-Path: <linux-pci+bounces-32724-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19481B0D8F8
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 14:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 612B41889F65
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 12:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60A22E11DA;
	Tue, 22 Jul 2025 12:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgh1FQ8v"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA08528A1D5;
	Tue, 22 Jul 2025 12:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753186140; cv=none; b=vGqpjUkXwCvePqcPV+Ge2O7+genlAFts4xD3SWotQNjt9GZKqDMwVdLVZ2iSLJpD0/AuRe6M6A9OTQKoAB0T5InblGGPoidL00yPsqb+6YYbbFCDGPyoDAcyCByizZmOvHzDDXC6Gmti0GX+jUeEKokOrZkmSULRmIFXf3Ys1zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753186140; c=relaxed/simple;
	bh=9tnk65GQHOuj2Pt0uMyPZaXg1fEIkfzRLOs6t+AmPis=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Jy3lOXzzlEnozqfG2iqGAAvwbZjpjc+bdJCD5jKPBAhoo5S7cOZCpJLT5Fh2JeynmRxb7+4DM6KoRJl+axbiZcMttZzx6MMZ6W1WxuFXlGbr4Nocno5wFpeO0b0foUnYOVA8gzKrx6cwWXSZb+F/JVe+LuG72hjvFjJIGleQ218=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgh1FQ8v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6439C4CEEB;
	Tue, 22 Jul 2025 12:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753186140;
	bh=9tnk65GQHOuj2Pt0uMyPZaXg1fEIkfzRLOs6t+AmPis=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=tgh1FQ8vA1ApjRpCVZoxwWfdsxjI65drnmgyfCudJMagNtFQiuyKiPPzx0V6+D2eA
	 ELWFlOlAJRPfiaf8Yk5ZbcSDY8Ea/W5OQYqTm9vc/MN7P6Lx31Suw9+PbFcwhwxDyj
	 XkkQC4A6/WkcRpCHDKWrfEVxjYTNYp+UX+HZPaJu7dm2QXDWXi86C7P1n/48fWRzf8
	 JgGnHqqOl1fhVjpgsaEF3y6A8TBoulnI8kcImHn1GUf1zpnUSILEx6ychMLLlJtsdA
	 r0Zcla4jJPEq+Zy+6NwIo6sfFT5/vnMyuyDeT+4l56928DE5ZJOUPqdMwACmH+j3Uh
	 fnML9SCe9s1YA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Jul 2025 14:08:55 +0200
Message-Id: <DBIKM7U4TSB8.17MTNSR81W8F3@kernel.org>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alistair Popple"
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
Subject: Re: [PATCH v2 1/2] rust: Update PCI binding safety comments and add
 inline compiler hint
From: "Benno Lossin" <lossin@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
X-Mailer: aerc 0.20.1
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
In-Reply-To: <CAH5fLghic7MZd-BO=Z-ostGLgWmBciQmZp9VjQpLGWskFK_gyQ@mail.gmail.com>

On Tue Jul 22, 2025 at 1:35 PM CEST, Alice Ryhl wrote:
> On Tue, Jul 22, 2025 at 12:57=E2=80=AFPM Benno Lossin <lossin@kernel.org>=
 wrote:
>>
>> On Tue Jul 22, 2025 at 11:51 AM CEST, Danilo Krummrich wrote:
>> > I think they're good, but we're pretty late in the cycle now. That sho=
uld be
>> > fine though, we can probably take them through the nova tree, or in th=
e worst
>> > case share a tag, if needed.
>> >
>> > Given that, it would probably be good to add the Guarantee section on =
as_raw(),
>> > as proposed by Benno, right away.
>> >
>> > @Benno: Any proposal on what this section should say?
>>
>> At a minimum I'd say "The returned pointer is valid.", but that doesn't
>> really say for what it's valid... AFAIK you're mostly using this pointer
>> to pass it to the C side, in that case, how about:
>>
>>     /// # Guarantees
>>     ///
>>     /// The returned pointer is valid for reads and writes from the C si=
de for as long as `self` exists.
>>
>> Maybe we need to change it a bit more, but let's just start with this.
>>
>> (If you're also using the pointer from Rust, then we need to make
>> changes)
>
> Honestly I think this is a bit over the top. I wouldn't bother adding
> a section like that to every single as_raw() method out there.

Hmm. And then just assume that these kinds of functions return valid
pointers? I get that this is annoying to put on every function...

Another option would be to have a `Ptr<'a, T>` type that is a valid
pointer, but doesn't allow writing/reading safely (you need to justify
why it's not a data race). And for FFI there could be an `as_ptr`
function.

---
Cheers,
Benno

