Return-Path: <linux-pci+bounces-31883-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A144B00C38
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 21:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D457C4E29C5
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 19:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFD32FD592;
	Thu, 10 Jul 2025 19:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwxDQ7UU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042702F4A19;
	Thu, 10 Jul 2025 19:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752176349; cv=none; b=i7/K9B+TlmFdhfByIdThr4pALl77DZFHcaDsJ+GC88FsR3VVeQFFaYLCgDcLGxwuFNFBd4CoyOhTYLIrAQsF0kTH0n0jkFDIa5nomr8c3O/y/EiKg+JE/x58ZpRlpwzoo5fOF/SsxmGEfl/NjxtvDZE+ouHiWuLby/xXWUAc1jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752176349; c=relaxed/simple;
	bh=B9XoDqFdJaX9Edg0FmLsZBwvxJIU8v6zJAUrrMr8Qbs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=M1rfBKqSKnqYvYa6ABvM02I8mLwmmaiGJg8NRzRbH8o4UziP/xkVAJ4WHGDxN7D1PPFPLGPM5/uQVzN3zH2rGF2yIFme45cqAcKOXUsyjG6C1oJFR/ntzWKw1syf949SzN/0XNp5AkN1A1DGYDg4zLZ22w1cDOJXxJJrz2l+iU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwxDQ7UU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6AE1C4CEE3;
	Thu, 10 Jul 2025 19:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752176348;
	bh=B9XoDqFdJaX9Edg0FmLsZBwvxJIU8v6zJAUrrMr8Qbs=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=mwxDQ7UUFIGtq6oyJNziwz1adWhaC1WBF/Eq8hckn8nVcD2qBWK4lUy+HQuXlslYC
	 00mqwDQ2wAGYh2ZvsR1m86Wf/RJFF5dP39ZwtzlJQGdefLxuyBqx3N1bq+ntr2+/h0
	 dJqiC3MB7wavzFwqqISODZatCJiXDUAOwq0NssohRv9eVudSF4lkEbnG9sj6A2c2aN
	 9O3/9a4dMpsvOkmtlhaTytF/g+WmJXMTA08twQQOe3E7i5gHILVhuciwpUtyi6Wt2s
	 NbUlbbYoDEyrZYT3upcYbFz+EgQ9meO6exB4S4OcXUqcn2cWY/i24o9RvM48oGrfJm
	 1F5aNbMSCME7g==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Jul 2025 21:39:02 +0200
Message-Id: <DB8MOBBJGM0N.DESF9OJ8YNZZ@kernel.org>
Subject: Re: [PATCH 1/2] rust: Add dma_set_mask() and
 dma_set_coherent_mask() bindings
Cc: <rust-for-linux@vger.kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "John Hubbard" <jhubbard@nvidia.com>, "Alexandre
 Courbot" <acourbot@nvidia.com>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Alistair Popple" <apopple@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250708060451.398323-1-apopple@nvidia.com>
 <DB6JF2JLZEO8.4HZPDC26F3G8@kernel.org>
 <DB6KV5SVWIYG.2FAIFGZ90ZR2I@kernel.org>
 <DB6YTN5P23X3.2S0NH4YECP1CP@kernel.org>
In-Reply-To: <DB6YTN5P23X3.2S0NH4YECP1CP@kernel.org>

On Tue Jul 8, 2025 at 10:44 PM CEST, Danilo Krummrich wrote:
> On Tue Jul 8, 2025 at 11:48 AM CEST, Danilo Krummrich wrote:
>> On Tue Jul 8, 2025 at 10:40 AM CEST, Danilo Krummrich wrote:
>>> On Tue Jul 8, 2025 at 8:04 AM CEST, Alistair Popple wrote:
>>>> Add bindings to allow setting the DMA masks for both a generic device
>>>> and a PCI device.
>>>
>>> Nice coincidence, I was about to get back to this. I already implemente=
d this in
>>> a previous patch [1], but didn't apply it yet.
>>>
>>> I think the approach below is thought a bit too simple:
>>>
>>>   (1) We want the DMA mask methods to be implemented by a trait in dma.=
rs.
>>>       Subsequently, the trait should only be implemented by bus devices=
 where
>>>       the bus actually supports DMA. Allowing to set the DMA mask on an=
y device
>>>       doesn't make sense.
>>
>> Forgot to mention, another reason for a trait is that we can also use it=
 as a
>> trait bound on dma::CoherentAllocation::new(), such that people can't pa=
ss
>> arbitrary devices to dma::CoherentAllocation::new(), but only those that
>> actually sit on a DMA capable bus.
>>
>>>
>>>   (2) We need to consider that with this we do no prevent
>>>       dma_set_coherent_mask() to concurrently with dma_alloc_coherent()=
 (not
>>>       even if we'd add a new `Probe` device context).
>>>
>>> (2) is the main reason why I didn't follow up yet. So far I haven't fou=
nd a nice
>>>     solution for a sound API that doesn't need unsafe.
>>>
>>> One thing I did consider was to have some kind of per device table (sim=
ilar to
>>> the device ID table) for drivers to specify the DMA mask already at com=
pile
>>> time. However, I'm pretty sure there are cases where the DMA mask has t=
o derived
>>> dynamically from probe().
>>>
>>> I think I have to think a bit more about it.
>
> Ok, there are multiple things to consider in the context of (2) above.
>
>   (a) We have to ensure that the dev->dma_mask pointer is properly initia=
lized,
>       which happens when the corresponding bus device is initialized. Thi=
s is
>       definitely the case when probe() is called, i.e. when the device is=
 bound.
>
>       So the solutions here is simple, we just implement the dma::Device =
trait
>       (which implements dma_set_mask() and dma_set_coherent_mask()) for
>       &Device<Bound>.
>
>   (b) When dma_set_mask() or dma_set_coherent_mask() are called concurren=
tly
>       with e.g. dma_alloc_coherent(), there is a data race with dev->dma_=
mask,
>       dev->coherent_dma_mask and dev->dma_skip_sync (also set by
>       dma_set_mask()).
>
>       However, AFAICT, this does not necessarily make the Rust API unsafe=
 in the
>       sense of Rust's requirements. I.e. a potential data race does not l=
ead to
>       undefined behavior on the CPU side of things, but may result into a=
 not
>       properly functioning device.

Apparently, this is wrong, and it might indeed result in undefined behavior=
 on
the CPU side of things. :(

>
>       It would be possible to declare dma_set_mask() and dma_set_coherent=
_mask()
>       Rust accessors as safe with the caveat that the device may not be a=
ble to
>       use the memory concurrently allocated with e.g.
>       dma::CoherentAllocation::new() properly.
>
>       The alternative would be to make dma_set_mask() and
>       dma_set_coherent_mask() unsafe to begin with.
>
>       I don't think there's a reasonable alternative given that the mask =
may be
>       derived on runtime in probe() by probing the device itself.
>
>       I guess we could do something with type states and cookie values et=
c., but
>       that's unreasonable overhead for something that is clearly more a
>       theoretical than a practical concern.
>
>       My conclusion is that we should just declare dma_set_mask() and
>       dma_set_coherent_mask() as safe functions (with proper documentatio=
n on
>       the pitfalls), given that the device is equally malfunctioning if t=
hey're
>       not called at all.
>
> @Alistair: If that is fine for you I'll pick up my old patches ([1] and r=
elated
> ones) and re-send them.
>
> If there is more discussion on (b) I'm happy to follow up either here or =
in the
> mentioned patches once I re-visited and re-sent them.
>
>>> [1] https://lore.kernel.org/all/20250317185345.2608976-7-abdiel.janulgu=
e@gmail.com/


