Return-Path: <linux-pci+bounces-31956-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B46DEB025E1
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 22:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 486C7A437E3
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 20:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5332E1D61BC;
	Fri, 11 Jul 2025 20:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3+M4sy+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2257219995E;
	Fri, 11 Jul 2025 20:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752266779; cv=none; b=IwbFv8t3vlwXHk4ajvZ2LAZUpNFlHcJzP6t6Jquqy1zEhJNmnzcgzQWJZ98CFw6AqMMKY3i4EBLlA+uNKXtvNAUdtitCeBe7pp51S7UX6xjYBzcPyvQV7locwp12bB6B7D0hW84TO/tMN5iwctmD734Ce9n4AzsU0bnnB4m9kKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752266779; c=relaxed/simple;
	bh=16+0LCcEdw6GvpPwotqiuiC+sCNvSh/28Nb0FvM2evA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KU6nM4SnbTM5YXO+iSM9xNrpeY43fE1GTMhrg5UVbnt15bFp4GCV1s+oGb8SuxDtynqice42hRYGg/hPXYQwsMn6vDtCyUYm5v60uRgyYq1+PpGm3X1yOc1RP/ccUtmrRaJ2P0gm12UCKXl7Jvxu4HjfGrlDUn7esuO9fdSdpCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3+M4sy+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25847C4CEF4;
	Fri, 11 Jul 2025 20:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752266778;
	bh=16+0LCcEdw6GvpPwotqiuiC+sCNvSh/28Nb0FvM2evA=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=J3+M4sy+cQHDtzqoOFjEpc4EUByqu8oeXC9qPnAUbL6cNOXC8P74E1Nvs0EN52H/y
	 znLsu+RwUFVqK0PU9RpNDr66OXp/FHBOrvlby0CaeR0Zo1/Nzv/fhtv9xiYmwWrC//
	 gwwEvJZcY5313ZryXFeUMiNsqfWzsa/4CKkbKUCqE4Tvnzhz9U4Z4VkTmbeEmWncB/
	 64vBeQzk8cQgPHetcF+bpaWOoqHTGvgyo08EsBc41pe/Oh0dTAvbSR7A9ZAoFsUY1D
	 3gJY0zyFr7ty9abwzkXInYKzg90tdyfxD7mSHJNgD34Lc3hyEU1sV0FsX5TjJQUxn9
	 tUbxjOxH4fAlA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Jul 2025 22:46:13 +0200
Message-Id: <DB9IQAU4WPSP.XZL4ZDPT59KU@kernel.org>
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
In-Reply-To: <DB9H6HEF9CKG.2SAPXM8F9KOO3@kernel.org>

On Fri Jul 11, 2025 at 9:33 PM CEST, Danilo Krummrich wrote:
> On Fri Jul 11, 2025 at 8:30 PM CEST, Benno Lossin wrote:
>> On Fri Jul 11, 2025 at 5:02 PM CEST, Danilo Krummrich wrote:
>>> On Thu Jul 10, 2025 at 10:01 AM CEST, Benno Lossin wrote:
>>>> On Thu Jul 10, 2025 at 4:24 AM CEST, Alistair Popple wrote:
>>>>> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
>>>>> index 8435f8132e38..5c35a66a5251 100644
>>>>> --- a/rust/kernel/pci.rs
>>>>> +++ b/rust/kernel/pci.rs
>>>>> @@ -371,14 +371,18 @@ fn as_raw(&self) -> *mut bindings::pci_dev {
>>>>> =20
>>>>>  impl Device {
>>>>>      /// Returns the PCI vendor ID.
>>>>> +    #[inline]
>>>>>      pub fn vendor_id(&self) -> u16 {
>>>>> -        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci=
_dev`.
>>>>> +        // SAFETY: by its type invariant `self.as_raw` is always a v=
alid pointer to a
>>>>
>>>> s/by its type invariant/by the type invariants of `Self`,/
>>>> s/always//
>>>>
>>>> Also, which invariant does this refer to? The only one that I can see
>>>> is:
>>>>
>>>>     /// A [`Device`] instance represents a valid `struct device` creat=
ed by the C portion of the kernel.
>>>>
>>>> And this doesn't say anything about the validity of `self.as_raw()`...
>>>
>>> Hm...why not? If an instance of Self always represents a valid struct p=
ci_dev,
>>> then consequently self.as_raw() can only be a valid pointer to a struct=
 pci_dev,
>>> no?
>>
>> While it's true, you need to look into the implementation of `as_raw`.
>> It could very well return a null pointer...
>>
>> This is where we can use a `Guarantee` on that function. But since it's
>> not shorter than `.0.get()`, I would just remove it.
>
> We have 15 to 20 as_raw() methods of this kind in the tree. If this reall=
y needs
> a `Guarantee` to be clean, we should probably fix it up in a treewide cha=
nge.
>
> as_raw() is a common pattern and everyone knows what it does, `.0.get()` =
seems
> much less obvious.

Yeah I guess then we need to do the treewide change... I don't have the
bandwidth for that, we can probably make this a good-first-issue.

---
Cheers,
Benno

