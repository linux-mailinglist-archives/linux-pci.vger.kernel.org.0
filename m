Return-Path: <linux-pci+bounces-32709-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3B7B0D64C
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 11:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73AC61C26BDB
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 09:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1872DECC5;
	Tue, 22 Jul 2025 09:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbyzv/mx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401D72DECB1;
	Tue, 22 Jul 2025 09:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753177914; cv=none; b=MyLEmeyV20ubrtl3wkvVolblZne9SMneXeZugodZ09SjBkEUHxeGV3zo1Li0lTS6aN2CuKI2LI9NioB6s2H0JTyJdfDPZfCMRDhr2J9z75QAfhyvz8jIn/hWe+cKVq0OmbsKZdwxmVMfkcu9TLR+AVI/g7OqTm7+6JXNMvlTD94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753177914; c=relaxed/simple;
	bh=g9Czfb6/NYPOxRMMj/Y+35i+ICwKvV5Vq7aeNekjp6E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=gBI5toehtZyqi5VsN+d3t2vSLBM6q10exnF8USlNguJFJxX+0xJjYZHQXZqIFKgDyo/zhfTxZ7ABA8IDtWyl7QRmQKccqeuX/GB/BgqCARtmTe5d2l1aptiPbTawUZsUpRNxO3fTzAg/M+Jw9Ws82Ad+vDkP3LEke9ulGAsUHOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbyzv/mx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0C8C4CEEB;
	Tue, 22 Jul 2025 09:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753177913;
	bh=g9Czfb6/NYPOxRMMj/Y+35i+ICwKvV5Vq7aeNekjp6E=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=cbyzv/mxrBzEHhit25wf2Vl1yiDppfGeX+HJQtnUXsD86a+hxphTEp9xlqjL5FPcY
	 veZer4iy1oL6RO/Dw1KlvU05Ctm8okCKnnV9+Kuj6hLxo5LDIyDYdMIoVjs7wmXi88
	 9mYzBdaQeQBZLDP49SqotiBmnsDjcZfGSRqVsvvNAbGzcsmIqXhy65LfxrZRjklU2b
	 8ePQoLF1iUAdQb1VN8mLC5Bq5vzDljA5IfslofyeSA8UAXD2VPl/cQceKD3ot7owlD
	 +t5UzXz6rCViogRJfecaEnOZOHgV2iX1demFLog6Q7cFuuyXawqy96yYTEOHRxN2Ug
	 rCVr21lZVq4Cg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Jul 2025 11:51:48 +0200
Message-Id: <DBIHP8IP3OHA.8Y1S9ZV1Y1SZ@kernel.org>
Subject: Re: [PATCH v2 1/2] rust: Update PCI binding safety comments and add
 inline compiler hint
Cc: "Benno Lossin" <lossin@kernel.org>, <rust-for-linux@vger.kernel.org>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
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
To: "Alistair Popple" <apopple@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250710022415.923972-1-apopple@nvidia.com>
 <DB87TX9Y5018.N1WDM8XRN74K@kernel.org>
 <DB9BF6WK8KMH.1RQOOMYBL6UAO@kernel.org>
 <DB9FUEJUOH3L.14CYPZ8YQT52E@kernel.org>
 <DB9H6HEF9CKG.2SAPXM8F9KOO3@kernel.org>
 <DB9IQAU4WPSP.XZL4ZDPT59KU@kernel.org>
 <bwbern2t7k5fcj6zxze6bjpasu3t26n6dmfptlmhbhd7qmligs@3fgwifsw7qai>
In-Reply-To: <bwbern2t7k5fcj6zxze6bjpasu3t26n6dmfptlmhbhd7qmligs@3fgwifsw7qai>

On Tue Jul 22, 2025 at 7:17 AM CEST, Alistair Popple wrote:
> On Fri, Jul 11, 2025 at 10:46:13PM +0200, Benno Lossin wrote:
>> On Fri Jul 11, 2025 at 9:33 PM CEST, Danilo Krummrich wrote:
>> > On Fri Jul 11, 2025 at 8:30 PM CEST, Benno Lossin wrote:
>> >> On Fri Jul 11, 2025 at 5:02 PM CEST, Danilo Krummrich wrote:
>> >>> On Thu Jul 10, 2025 at 10:01 AM CEST, Benno Lossin wrote:
>> >>>> On Thu Jul 10, 2025 at 4:24 AM CEST, Alistair Popple wrote:
>> >>>>> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
>> >>>>> index 8435f8132e38..5c35a66a5251 100644
>> >>>>> --- a/rust/kernel/pci.rs
>> >>>>> +++ b/rust/kernel/pci.rs
>> >>>>> @@ -371,14 +371,18 @@ fn as_raw(&self) -> *mut bindings::pci_dev {
>> >>>>> =20
>> >>>>>  impl Device {
>> >>>>>      /// Returns the PCI vendor ID.
>> >>>>> +    #[inline]
>> >>>>>      pub fn vendor_id(&self) -> u16 {
>> >>>>> -        // SAFETY: `self.as_raw` is a valid pointer to a `struct =
pci_dev`.
>> >>>>> +        // SAFETY: by its type invariant `self.as_raw` is always =
a valid pointer to a
>> >>>>
>> >>>> s/by its type invariant/by the type invariants of `Self`,/
>> >>>> s/always//
>> >>>>
>> >>>> Also, which invariant does this refer to? The only one that I can s=
ee
>> >>>> is:
>> >>>>
>> >>>>     /// A [`Device`] instance represents a valid `struct device` cr=
eated by the C portion of the kernel.
>> >>>>
>> >>>> And this doesn't say anything about the validity of `self.as_raw()`=
...
>> >>>
>> >>> Hm...why not? If an instance of Self always represents a valid struc=
t pci_dev,
>> >>> then consequently self.as_raw() can only be a valid pointer to a str=
uct pci_dev,
>> >>> no?
>> >>
>> >> While it's true, you need to look into the implementation of `as_raw`=
.
>> >> It could very well return a null pointer...
>> >>
>> >> This is where we can use a `Guarantee` on that function. But since it=
's
>> >> not shorter than `.0.get()`, I would just remove it.
>> >
>> > We have 15 to 20 as_raw() methods of this kind in the tree. If this re=
ally needs
>> > a `Guarantee` to be clean, we should probably fix it up in a treewide =
change.
>> >
>> > as_raw() is a common pattern and everyone knows what it does, `.0.get(=
)` seems
>> > much less obvious.
>
> Coming from a C kernel programming background I agree `.as_raw()` is more
> obvious than `.0.get()`. However now I'm confused ... what if anything ne=
eds
> changing to get these two small patches merged?

I think they're good, but we're pretty late in the cycle now. That should b=
e
fine though, we can probably take them through the nova tree, or in the wor=
st
case share a tag, if needed.

Given that, it would probably be good to add the Guarantee section on as_ra=
w(),
as proposed by Benno, right away.

@Benno: Any proposal on what this section should say?

One minor nit would be to start the safety comments with a capital letter
instead.

