Return-Path: <linux-pci+bounces-32712-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 677ACB0D784
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 12:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 415A61891CAA
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 10:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3C82DFA3A;
	Tue, 22 Jul 2025 10:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gG92PNxZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7F028B4E7;
	Tue, 22 Jul 2025 10:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753181370; cv=none; b=XXZ/9Z2zGBLaBEQU+YRXhnzOb04ebST3lDyslQc+pLU0vw4i2gPLinx6E+n0/Av9xD2Ff9xFkfvmfy8nGH35vXKOyvsac66iRRpqLxbq4iH77h+oLgJQSIci6QeaMzpfcTDCNS2FtE97j8p7U1YSmhbk93107dms4jhe5WGuWvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753181370; c=relaxed/simple;
	bh=T9qJH4S/R7Y9U7L1zcb7GfuX4Qq01/z/XzvsNVmzdUI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=GBbBUbWmIv2LApG7JBzN4RR3AYBjvYa53pVSLS3B8cIvgBSw0td42OM2xuT46FKuFM7NJIIjB9QfAyDNWUbZ4Nvx5X/dhdfDb7PsNWJZ69g2JRjWrvetoAljNMdF6vss/f3sUcRytMTe581R5WvfruWAXCby3eota3qqy1bvkU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gG92PNxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA70C4CEEB;
	Tue, 22 Jul 2025 10:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753181369;
	bh=T9qJH4S/R7Y9U7L1zcb7GfuX4Qq01/z/XzvsNVmzdUI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=gG92PNxZ+3Q0VkLVNW2JOOKzinCjpvki4rDXhoOcW2qnYXCfj4dx5GqZZdhvbnirO
	 Ju8tEV3WxLx3qlIdYs42rZrqRUKUUDZjtT2GcEUs8uy6JCfCWGh59Znq2mcT70kJnP
	 RpSnA8OYkfXPFlcJCvb84MlFFlvbQs4ZXG8vs9cjT8grubEmsgfefxZA6p9J0F79Rd
	 URIZQ03BFlJfv3UtINpoqeg2FLa7mqsOTDvaO1XmikN9QqIUoT4IlU3DEZYGyVgTd/
	 4GJjp2XhIP/I7q4vm35QCson3HQTiiYjI4RghTGVvRVyLKA0ByOvjQVxpvMRAEAhGA
	 BypGGT8BexvQA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Jul 2025 12:49:24 +0200
Message-Id: <DBIIXC694S6P.18BOBCI4LZ4HA@kernel.org>
Cc: "Danilo Krummrich" <dakr@kernel.org>, <rust-for-linux@vger.kernel.org>,
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
Subject: Re: [PATCH v2 1/2] rust: Update PCI binding safety comments and add
 inline compiler hint
From: "Benno Lossin" <lossin@kernel.org>
To: "Alistair Popple" <apopple@nvidia.com>
X-Mailer: aerc 0.20.1
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
> obvious than `.0.get()`.

Makes sense, then I wouldn't recommend changing it.

> However now I'm confused ... what if anything needs changing to get
> these two small patches merged?

I'd like to see `as_raw` get a `Guarantee` section, but that is
independent from this patch series.

---
Cheers,
Benno

