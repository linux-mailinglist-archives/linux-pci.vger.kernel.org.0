Return-Path: <linux-pci+bounces-32817-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1633B0F53B
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 16:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0CF6AC10AB
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 14:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC62B2EF2B4;
	Wed, 23 Jul 2025 14:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZtKuJ02"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928AA2D9EDC;
	Wed, 23 Jul 2025 14:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753280753; cv=none; b=I4/WhBCEqWeoV4djV9lbsUSIzdmF68/kSiR5gJsk7OZj58byX868Ft/Csz5OqPGuMi1r+eUACnhybQLU7z+e2g0oTsk2czz1mPLfmaEZU7b6zBTUSHJLKRQkvcy3cStGYksW5tZSWlqhihj5J+LEMbg5Pi7/pNeMtWxdt+pewiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753280753; c=relaxed/simple;
	bh=fzHnblsgfySNaH2EsHFzy4vZVAOUhRBnZwE03ZsLOec=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=gpfBAoKhD2MYgz9h6IgTyIPXZ3Aa23WDiFmQDP96hiFmx6zsuOtZJbW9Cs9iiMDiTAnWHrLGYZihhX8eiHPeCyi9+7wZ8O/JUAzlo6XYQV8631U64Xmrmp9Arjup4Yu77VIuyf3XaqbhKdsHxZ6bo1jwo5aLwJ9eZqwrdilXx44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZtKuJ02; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41BFC4CEE7;
	Wed, 23 Jul 2025 14:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753280753;
	bh=fzHnblsgfySNaH2EsHFzy4vZVAOUhRBnZwE03ZsLOec=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=kZtKuJ02zCU3VAdZelmzShoXa8SBSk/3PQbG1K1JP32a1AEJzEBnTSpRdKFzSP64P
	 hbfqs6YCvaqOLAE0LxZx11YbSGXYI7WDT8221i3Ty8pKWbZOeaefZBbfefYy1NdB9F
	 Vf1pkvSUUuyfBQK/0b9NIGIwHOe0KdXf2etXYsYY9bcS3yH8u2MBMj7E4HLcvLwj5d
	 RO53NlqnQDm3bzn7W96mVT8zQKgZsrqYh2tbK9PslTMrvolX+bkCzjkPJ5ZrSs5p6U
	 621rMLeBsBPfGpTn6n75FpFyzKkUDmjAqxa+CZLBCcBXbIcMjIEUP+sI6vzmn7l//P
	 K5R1Yhvqnc2ew==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Jul 2025 16:25:47 +0200
Message-Id: <DBJI5K94Q0K0.336A61IF19ZEZ@kernel.org>
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
Subject: Re: [PATCH v2 1/2] rust: Update PCI binding safety comments and add
 inline compiler hint
From: "Benno Lossin" <lossin@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>
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
 <DBIKM7U4TSB8.17MTNSR81W8F3@kernel.org>
 <DBILHBVA0NKJ.3R2QIVE9QIMM3@kernel.org>
In-Reply-To: <DBILHBVA0NKJ.3R2QIVE9QIMM3@kernel.org>

On Tue Jul 22, 2025 at 2:49 PM CEST, Danilo Krummrich wrote:
> On Tue Jul 22, 2025 at 2:08 PM CEST, Benno Lossin wrote:
>> On Tue Jul 22, 2025 at 1:35 PM CEST, Alice Ryhl wrote:
>>> On Tue, Jul 22, 2025 at 12:57=E2=80=AFPM Benno Lossin <lossin@kernel.or=
g> wrote:
>>>>
>>>> On Tue Jul 22, 2025 at 11:51 AM CEST, Danilo Krummrich wrote:
>>>> > I think they're good, but we're pretty late in the cycle now. That s=
hould be
>>>> > fine though, we can probably take them through the nova tree, or in =
the worst
>>>> > case share a tag, if needed.
>>>> >
>>>> > Given that, it would probably be good to add the Guarantee section o=
n as_raw(),
>>>> > as proposed by Benno, right away.
>>>> >
>>>> > @Benno: Any proposal on what this section should say?
>>>>
>>>> At a minimum I'd say "The returned pointer is valid.", but that doesn'=
t
>>>> really say for what it's valid... AFAIK you're mostly using this point=
er
>>>> to pass it to the C side, in that case, how about:
>>>>
>>>>     /// # Guarantees
>>>>     ///
>>>>     /// The returned pointer is valid for reads and writes from the C =
side for as long as `self` exists.
>>>>
>>>> Maybe we need to change it a bit more, but let's just start with this.
>>>>
>>>> (If you're also using the pointer from Rust, then we need to make
>>>> changes)
>>>
>>> Honestly I think this is a bit over the top. I wouldn't bother adding
>>> a section like that to every single as_raw() method out there.
>>
>> Hmm. And then just assume that these kinds of functions return valid
>> pointers? I get that this is annoying to put on every function...
>>
>> Another option would be to have a `Ptr<'a, T>` type that is a valid
>> pointer, but doesn't allow writing/reading safely (you need to justify
>> why it's not a data race). And for FFI there could be an `as_ptr`
>> function.
>
> I don't understand where's the difference between the two. For FFI calls =
we'd
> also have to justify it's not a data race, no?

Yes, but there you need a raw pointer.

> The only guarantee we take as granted from as_raw() is that it returns a =
raw
> pointer to the wrapped FFI type in Self, i.e. it points to valid memory. =
Any
> additional guarantees may come from the context where the pointer is used=
 and
> which specific fields it is used to access.

Sure you need additional guarantees from the context, but you also need
the fact that the pointer coming from `as_raw` isn't just a random
pointer, but that it is derived from the reference...

I don't have any good plan forward for this, so maybe we should revisit
this in the future...

---
Cheers,
Benno

