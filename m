Return-Path: <linux-pci+bounces-31670-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2180AFC760
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 11:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F14C1165BB3
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 09:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBA42343BE;
	Tue,  8 Jul 2025 09:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3A7YfYI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF051FBEBE;
	Tue,  8 Jul 2025 09:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751968123; cv=none; b=LMF3rnrJaHmcV8BGTL0zCjzAFVbO4awP7NPljy/gD2YeJCG6nV1Wr3qwb6QLU0dOQ5Yf3RYQIyVaxIKtp7OV51AHi8E6aymnZqYbVpmhf6fr84euqMqU5Z/H6vby0o6kB1UVyu/+stPR6N62+otWJr3+MqdZqoY2U6mIsddrR30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751968123; c=relaxed/simple;
	bh=nJZziPt5NASkQ4VYndMG5RDb3+l0adF6BWLpXEqDyZU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=c14SmepZu10GP9ahyo+XjDQUbkZSzKuel72e5ad1IJ5ag8dB/KDhYKqheILbNNsNC96sXkH4aHN/PV8xHtpZRiHSXIuXCkYpJRVsXThLe7ItUPeNcMt8YSKILc/88SCEEUS/vl97oJD7V4p3/ORoGzACo4AQLXpaA06Yuk7Zm7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3A7YfYI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EAF5C4CEED;
	Tue,  8 Jul 2025 09:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751968121;
	bh=nJZziPt5NASkQ4VYndMG5RDb3+l0adF6BWLpXEqDyZU=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=g3A7YfYIR1aOagAlboL6HhqaKSUdo2bf5X4jag77WB+jDmeVQEPk4JDkTaUvw7zlO
	 pMGZaLeP3bnedwWmfyK/vlEq1jTRveKAvnd2EZSLCbLbaInkp6eqHTbPWpt7Vq+L9g
	 YzFsapvWf3y6o55TK2kPvqx0z98UO+3cq8IHXJEd/EaoJqW7OQbwf1jqZR1m3f2sNn
	 ag+eQKS2cdQf4vDnafUSdrfHc9OuUcpTP0NJ6uSQ6Hk1O73u/h+eGXt2D4dQNRjyMV
	 Ndq+dVFK5ppz+TmRcfyOEIfj5fGbSzuQEOzUXhuf8cBfrh7BQD2YWunc0ESV9fwsfU
	 +4XQ8u+tVjfuw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Jul 2025 11:48:36 +0200
Message-Id: <DB6KV5SVWIYG.2FAIFGZ90ZR2I@kernel.org>
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
In-Reply-To: <DB6JF2JLZEO8.4HZPDC26F3G8@kernel.org>

On Tue Jul 8, 2025 at 10:40 AM CEST, Danilo Krummrich wrote:
> On Tue Jul 8, 2025 at 8:04 AM CEST, Alistair Popple wrote:
>> Add bindings to allow setting the DMA masks for both a generic device
>> and a PCI device.
>
> Nice coincidence, I was about to get back to this. I already implemented =
this in
> a previous patch [1], but didn't apply it yet.
>
> I think the approach below is thought a bit too simple:
>
>   (1) We want the DMA mask methods to be implemented by a trait in dma.rs=
.
>       Subsequently, the trait should only be implemented by bus devices w=
here
>       the bus actually supports DMA. Allowing to set the DMA mask on any =
device
>       doesn't make sense.

Forgot to mention, another reason for a trait is that we can also use it as=
 a
trait bound on dma::CoherentAllocation::new(), such that people can't pass
arbitrary devices to dma::CoherentAllocation::new(), but only those that
actually sit on a DMA capable bus.

>
>   (2) We need to consider that with this we do no prevent
>       dma_set_coherent_mask() to concurrently with dma_alloc_coherent() (=
not
>       even if we'd add a new `Probe` device context).
>
> (2) is the main reason why I didn't follow up yet. So far I haven't found=
 a nice
>     solution for a sound API that doesn't need unsafe.
>
> One thing I did consider was to have some kind of per device table (simil=
ar to
> the device ID table) for drivers to specify the DMA mask already at compi=
le
> time. However, I'm pretty sure there are cases where the DMA mask has to =
derived
> dynamically from probe().
>
> I think I have to think a bit more about it.
>
> [1] https://lore.kernel.org/all/20250317185345.2608976-7-abdiel.janulgue@=
gmail.com/


