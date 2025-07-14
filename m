Return-Path: <linux-pci+bounces-32060-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C591B03AED
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 11:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F7C33A5C96
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 09:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C947224169D;
	Mon, 14 Jul 2025 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEUGd856"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9415723A9BF;
	Mon, 14 Jul 2025 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752485795; cv=none; b=EhehirnqSWkaxZ+FteYIQbvA8hYBc1hsV/9oRZ2qED+7ejSoLn9HpOWVc3syVK7JUWKcyZaWgrvLP2hB4iZzi+mc2/7f+Hwnm4/kb29cjWjfd7ygzIk2/t7XeCnpUV2XhB9AnBsWXEzidwURFMWjfVRTdSZ7N+Lhbx8xbnuEfOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752485795; c=relaxed/simple;
	bh=Vzxq/edcrTJeXzQiDeTB7+LshkLJsBhp6E8UKnKvfSM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=aST13iuBOswOUxZZjucu20RVPqIgDxsy/qEmoULYqCR0GGpKJhI+ob+q5lKIa1j9ZPMvFy79JpHIn5X+jLe2uBJzt2lLXl4opls3mlMhs4y0z1zTaKk7QQ0lli0xx0iUZv9E3Y7TUc/YBMGi5QvA+HYUBOvnp+1QqhCpxjyWjfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEUGd856; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990D1C4CEED;
	Mon, 14 Jul 2025 09:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752485795;
	bh=Vzxq/edcrTJeXzQiDeTB7+LshkLJsBhp6E8UKnKvfSM=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=OEUGd856MPfzTVt06by6WFNAR4j7ZTfCOc3jSN3pFPIBGbLKkYeX4oz0TR/4rFjCz
	 V091A06vmH7yuTIszh/AVdwo3exBgjAkqNFtdXsVcgLBSFxeN080BMH9NA3NPFnGdn
	 xr3guGW5KVvlqss1gy609IiYHVyoE4IA1mBm4Nn5zHhhvl4/+ILB/UiOmVmYaiPVxJ
	 bRv6gDACgIU3MHE7+5fv59w8i2PDkQjB9mhwrbUxngbI8eoOFicCcgffRZBXMNrwuz
	 8LqZAtvy0vbLBvGOWWyX5UuWMATVp3kjbqNUEl8lSsq0fXkh616x2/A+27ItsJqwAu
	 dSrkF/V6m+y9A==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Jul 2025 11:36:29 +0200
Message-Id: <DBBOD5MK9FQ9.2ZOBX2ERFIE2S@kernel.org>
Cc: "Daniel Almeida" <daniel.almeida@collabora.com>, "Benno Lossin"
 <lossin@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>
To: "Dirk Behme" <dirk.behme@de.bosch.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v6 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com> <20250703-topics-tyr-request_irq-v6-3-74103bdc7c52@collabora.com> <DBAE5TCBT8F8.25XWHTO92R9V4@kernel.org> <DAD3292B-2DBF-442A-8B60-A999AE0F6511@collabora.com> <DBAURC9BEFI0.1LQCRIDT6ZBV9@kernel.org> <DBAVXQTMR38Z.2782EGR84L7OP@kernel.org> <DBAWQG1PX5TO.6I2ARFGLX88N@kernel.org> <DBAX59YKO0FV.ANLOWRHDDS92@kernel.org> <DBAXP68U809C.2G8DMB52M3UZ7@kernel.org> <C4A101A7-282D-4A67-A966-CF39850952EA@collabora.com> <DBAZRNHGIGL8.3L2NGPCVXLI25@kernel.org> <d6e62068-a05a-43cf-ace3-ff7a41e9a1d7@de.bosch.com>
In-Reply-To: <d6e62068-a05a-43cf-ace3-ff7a41e9a1d7@de.bosch.com>

On Mon Jul 14, 2025 at 9:57 AM CEST, Dirk Behme wrote:
> On 13/07/2025 16:19, Danilo Krummrich wrote:
>> On Sun Jul 13, 2025 at 4:09 PM CEST, Daniel Almeida wrote:
>>> On a second look, I wonder how useful this will be.
>>>
>>>  fn handle(&self, dev: &Device<Bound>) -> IrqReturn
>>>
>>> Sorry for borrowing this terminology, but here we offer Device<Bound>, =
while I
>>> suspect that most drivers will be looking for the most derived Device t=
ype
>>> instead. So for drm drivers this will be drm::Device, for example, not =
the base
>>> dev::Device type. I assume that this pattern will hold for other subsys=
tems as
>>> well.
>>>
>>> Which brings me to my second point: drivers can store an ARef<drm::Devi=
ce> on
>>> the handler itself, and I assume that the same will be possible in othe=
r
>>> subsystems.
>>=20
>> Well, the whole point is that you can use a &Device<Bound> to directly a=
ccess
>> device resources without any overhead, i.e.
>>=20
>> 	fn handle(&self, dev: &Device<Bound>) -> IrqReturn {
>> 	   let io =3D self.iomem.access(dev);
>>=20
>> 	   io.write32(...);
>
> As this is exactly the example I was discussing privately with Daniel
> (many thanks!), independent on the device discussion here, just for my
> understanding:
>
> Is it ok to do a 'self.iomem.access(dev)' at each interrupt?

Absolutely, Devres::access() is a very cheap accessor, see also [1]. Compil=
ed
down, the only thing that Revocable::access() does is deriving a pointer fr=
om
another pointer by adding an offset.

That's exactly why we want the &Device<Bound> cookie, to avoid more expensi=
ve
operations.

[1] https://rust.docs.kernel.org/src/kernel/revocable.rs.html#151

> Wouldn't it
> be cheaper/faster to pass 'io' instead of 'iomem' to the interrupt handle=
r?

Well, consider the types of the example:

	iomem: Devres<IoMem<SIZE>>
	io: &IoMem<Size>

You can't store a reference with a non-static lifetime in something with an
open-ended lifetime, such as the Handler object.

How would you ensure that the reference is still valid? The Devres<IoMem<SI=
ZE>>
object might have been dropped already, either by the user or by Devres rev=
oking
the inner object due to device unbind.

