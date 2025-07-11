Return-Path: <linux-pci+bounces-31951-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDE7B024A2
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 21:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCD761799E7
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 19:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53721D61BC;
	Fri, 11 Jul 2025 19:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YA/Unteg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790BE197A8E;
	Fri, 11 Jul 2025 19:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752262412; cv=none; b=fuZmruaj0v6G5ScYjw1xWaiqH1gczl1KNjXF1Gdus0LXdEAAsmqtCRsJWsRUAfpuNd2VG/ST5u4Ev02Csy+KwkFATCORMj1lCH/J8ZB4HPepZePY5jauwNqpYZGiHpCVWa95JvXcf8csvC+pAHeBhbcbl4MyWCL7onHIglhup1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752262412; c=relaxed/simple;
	bh=LywabPEu9d7NRWO11xLovXQdvhGxvblOkxJVWM8BGqs=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=QR0iAuGfp0kHxuRzUi1lMXKsaj+qyDnnoqvZyzXDTTU65xTVp2WQ6nyZDpWwV4fwfWCeiW8CwBkd0CCR8Gt5zF3aj08dB23o/9RMWn/8iwsw2kWZp3my3XG5PpHM5F5YK/OJ19pmuSa/hYM/Wqcfu56Mb82AOWoNOxXbjoCx8Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YA/Unteg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997B3C4CEED;
	Fri, 11 Jul 2025 19:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752262412;
	bh=LywabPEu9d7NRWO11xLovXQdvhGxvblOkxJVWM8BGqs=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=YA/UntegWkyVtkEGNWeq/PMKaCzfiSk8tXOC+EBlgRnP0VrgunJU4DWkJNIEjWHQF
	 hxpVT/4fNU83t+ABRUKVqDJuhLGrSypY3byFZ08alp9u15SUz4gIwOl3S8WAQkVkAb
	 DwBwKy5xovWhT1DjSEBZfIMg2I1nGLMKgBsOnQb6XansGxtOh0CApWUgKnjdDCoV3W
	 qKTpxZl9KaeSlxCNx+8ZkJ+K/swOAdueJkfsTJGTrKjtIbf5Ozk11Z+tnm9odgrzQ4
	 ku9bmWwtMJ9iXDQdrXtG/TfbsSgTx+6ywJdSupBwC7XMuT+hDxoUO5AmlaW8ebfpmd
	 hC1bydfy1t4lQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Jul 2025 21:33:19 +0200
Message-Id: <DB9H6HEF9CKG.2SAPXM8F9KOO3@kernel.org>
To: "Benno Lossin" <lossin@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 1/2] rust: Update PCI binding safety comments and add
 inline compiler hint
Cc: "Alistair Popple" <apopple@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "John Hubbard" <jhubbard@nvidia.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
References: <20250710022415.923972-1-apopple@nvidia.com>
 <DB87TX9Y5018.N1WDM8XRN74K@kernel.org>
 <DB9BF6WK8KMH.1RQOOMYBL6UAO@kernel.org>
 <DB9FUEJUOH3L.14CYPZ8YQT52E@kernel.org>
In-Reply-To: <DB9FUEJUOH3L.14CYPZ8YQT52E@kernel.org>

On Fri Jul 11, 2025 at 8:30 PM CEST, Benno Lossin wrote:
> On Fri Jul 11, 2025 at 5:02 PM CEST, Danilo Krummrich wrote:
>> On Thu Jul 10, 2025 at 10:01 AM CEST, Benno Lossin wrote:
>>> On Thu Jul 10, 2025 at 4:24 AM CEST, Alistair Popple wrote:
>>>> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
>>>> index 8435f8132e38..5c35a66a5251 100644
>>>> --- a/rust/kernel/pci.rs
>>>> +++ b/rust/kernel/pci.rs
>>>> @@ -371,14 +371,18 @@ fn as_raw(&self) -> *mut bindings::pci_dev {
>>>> =20
>>>>  impl Device {
>>>>      /// Returns the PCI vendor ID.
>>>> +    #[inline]
>>>>      pub fn vendor_id(&self) -> u16 {
>>>> -        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_=
dev`.
>>>> +        // SAFETY: by its type invariant `self.as_raw` is always a va=
lid pointer to a
>>>
>>> s/by its type invariant/by the type invariants of `Self`,/
>>> s/always//
>>>
>>> Also, which invariant does this refer to? The only one that I can see
>>> is:
>>>
>>>     /// A [`Device`] instance represents a valid `struct device` create=
d by the C portion of the kernel.
>>>
>>> And this doesn't say anything about the validity of `self.as_raw()`...
>>
>> Hm...why not? If an instance of Self always represents a valid struct pc=
i_dev,
>> then consequently self.as_raw() can only be a valid pointer to a struct =
pci_dev,
>> no?
>
> While it's true, you need to look into the implementation of `as_raw`.
> It could very well return a null pointer...
>
> This is where we can use a `Guarantee` on that function. But since it's
> not shorter than `.0.get()`, I would just remove it.

We have 15 to 20 as_raw() methods of this kind in the tree. If this really =
needs
a `Guarantee` to be clean, we should probably fix it up in a treewide chang=
e.

as_raw() is a common pattern and everyone knows what it does, `.0.get()` se=
ems
much less obvious.

