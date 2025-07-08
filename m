Return-Path: <linux-pci+bounces-31725-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9456AFD89E
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 22:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0A942734D
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 20:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A207E241669;
	Tue,  8 Jul 2025 20:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m55/GDKj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C923C01;
	Tue,  8 Jul 2025 20:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752007499; cv=none; b=qnpsSG+M+r27PTRezf3kaVLo/SLwBNVdc5mcOIW52b4U+75Kw+ZgR6NE4Zb8IsN7ZEM6dxBs3cpybWEpbEgpuf1RiKuFu3yihsT0wXwUBMtF57gNVwFb7qo6RXo6KeYK+pNib/6cj68VRimu2BNKnSV0cpPOkySfBhPcStG/U74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752007499; c=relaxed/simple;
	bh=8Q6sDL9TC7gEBxbyHgPrZGhIvXltjl2WkEW6qmKlx0g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=ckbbsPJYS/wuLIaEubhTJl9/d/6gAmgZmk0CdvRh3fmTPYk52uIBoBBky9hOvTCqVhqspoyRHrJcg34L8yaeZ82bzI+HZ9htd7IgDXjP6ODcOgdt2MTC5w4r1RThNscLdO7MLId4XZBeJKWtW2c/TeGEE0DqJsg5UUwG/Hl0hTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m55/GDKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B111C4CEF6;
	Tue,  8 Jul 2025 20:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752007499;
	bh=8Q6sDL9TC7gEBxbyHgPrZGhIvXltjl2WkEW6qmKlx0g=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=m55/GDKj4PvSQ65+fgCgndruc1M3w+T+pL0o0muv4kE0AFlCPydzJTZcIjKMGCcZm
	 ZVOkR9+7J+4/MUgAyI0tlIZsoep9h11OViW1YLxHygMqmVnDJVc9mzRT9HseX5WItX
	 ymstfQa8mGaWbtjS379p1pYnZGg60puYFebjIoak8Zl5y0tK/hvVx5A/8ca86LCGGV
	 OLBS8BrlEV9lgydk7q6YP8PDbgxT75DbI761ZHNykt+5nVsJFV8HrYVkxSeQmK9Ave
	 532S+LQ1Uks6uzhgE8hWEKrbECHdd+3nWrOEWoooFSSU/NoN4z2KigPLo5yiv9KOSV
	 2+XoDVMaRv3rQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Jul 2025 22:44:53 +0200
Message-Id: <DB6YTN5P23X3.2S0NH4YECP1CP@kernel.org>
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
In-Reply-To: <DB6KV5SVWIYG.2FAIFGZ90ZR2I@kernel.org>

On Tue Jul 8, 2025 at 11:48 AM CEST, Danilo Krummrich wrote:
> On Tue Jul 8, 2025 at 10:40 AM CEST, Danilo Krummrich wrote:
>> On Tue Jul 8, 2025 at 8:04 AM CEST, Alistair Popple wrote:
>>> Add bindings to allow setting the DMA masks for both a generic device
>>> and a PCI device.
>>
>> Nice coincidence, I was about to get back to this. I already implemented=
 this in
>> a previous patch [1], but didn't apply it yet.
>>
>> I think the approach below is thought a bit too simple:
>>
>>   (1) We want the DMA mask methods to be implemented by a trait in dma.r=
s.
>>       Subsequently, the trait should only be implemented by bus devices =
where
>>       the bus actually supports DMA. Allowing to set the DMA mask on any=
 device
>>       doesn't make sense.
>
> Forgot to mention, another reason for a trait is that we can also use it =
as a
> trait bound on dma::CoherentAllocation::new(), such that people can't pas=
s
> arbitrary devices to dma::CoherentAllocation::new(), but only those that
> actually sit on a DMA capable bus.
>
>>
>>   (2) We need to consider that with this we do no prevent
>>       dma_set_coherent_mask() to concurrently with dma_alloc_coherent() =
(not
>>       even if we'd add a new `Probe` device context).
>>
>> (2) is the main reason why I didn't follow up yet. So far I haven't foun=
d a nice
>>     solution for a sound API that doesn't need unsafe.
>>
>> One thing I did consider was to have some kind of per device table (simi=
lar to
>> the device ID table) for drivers to specify the DMA mask already at comp=
ile
>> time. However, I'm pretty sure there are cases where the DMA mask has to=
 derived
>> dynamically from probe().
>>
>> I think I have to think a bit more about it.

Ok, there are multiple things to consider in the context of (2) above.

  (a) We have to ensure that the dev->dma_mask pointer is properly initiali=
zed,
      which happens when the corresponding bus device is initialized. This =
is
      definitely the case when probe() is called, i.e. when the device is b=
ound.

      So the solutions here is simple, we just implement the dma::Device tr=
ait
      (which implements dma_set_mask() and dma_set_coherent_mask()) for
      &Device<Bound>.

  (b) When dma_set_mask() or dma_set_coherent_mask() are called concurrentl=
y
      with e.g. dma_alloc_coherent(), there is a data race with dev->dma_ma=
sk,
      dev->coherent_dma_mask and dev->dma_skip_sync (also set by
      dma_set_mask()).

      However, AFAICT, this does not necessarily make the Rust API unsafe i=
n the
      sense of Rust's requirements. I.e. a potential data race does not lea=
d to
      undefined behavior on the CPU side of things, but may result into a n=
ot
      properly functioning device.

      It would be possible to declare dma_set_mask() and dma_set_coherent_m=
ask()
      Rust accessors as safe with the caveat that the device may not be abl=
e to
      use the memory concurrently allocated with e.g.
      dma::CoherentAllocation::new() properly.

      The alternative would be to make dma_set_mask() and
      dma_set_coherent_mask() unsafe to begin with.

      I don't think there's a reasonable alternative given that the mask ma=
y be
      derived on runtime in probe() by probing the device itself.

      I guess we could do something with type states and cookie values etc.=
, but
      that's unreasonable overhead for something that is clearly more a
      theoretical than a practical concern.

      My conclusion is that we should just declare dma_set_mask() and
      dma_set_coherent_mask() as safe functions (with proper documentation =
on
      the pitfalls), given that the device is equally malfunctioning if the=
y're
      not called at all.

@Alistair: If that is fine for you I'll pick up my old patches ([1] and rel=
ated
ones) and re-send them.

If there is more discussion on (b) I'm happy to follow up either here or in=
 the
mentioned patches once I re-visited and re-sent them.

>> [1] https://lore.kernel.org/all/20250317185345.2608976-7-abdiel.janulgue=
@gmail.com/

