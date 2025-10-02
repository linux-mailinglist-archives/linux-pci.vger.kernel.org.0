Return-Path: <linux-pci+bounces-37475-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2B5BB5799
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 23:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 836E14E4218
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 21:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1EB1494DB;
	Thu,  2 Oct 2025 21:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FT5tGjTv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784433BB44;
	Thu,  2 Oct 2025 21:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759440772; cv=none; b=FCUtGzxpGKLRFCLwcrgUYO5K5pmnbEtFRLZpF1o6dbW6YdDBvSoLnVD1E7jJ+NgJsH4sIkIGSALuWva3gNhk2MxAM/TW+cSMzUC1fX+2DNKzHyGCh+GrCnL9BZTcuSL9XW+vuuG4+resRzPGhoqEeX758e013zvClNFMVByMKqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759440772; c=relaxed/simple;
	bh=L6sLUDYC2mIpeZa6zlf8RaB7dU8gXnHoIwa5yefwsIA=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=K/2AsPUhZoUyuCeEUrVJRIvjffQFkIFNKJkIPJdX78VCDKhmCXhRYmpjtqDfQpa4Lso+2atF6rdl68NXBFgkhbGONT5t6xgpYWpHYzC+74V0J39m7wgiJyAvGipyKzsflvl0ilkcMysRPFsQ9np7wxoYsRpnKrckF2HXYQWqZpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FT5tGjTv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080D4C4CEF4;
	Thu,  2 Oct 2025 21:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759440771;
	bh=L6sLUDYC2mIpeZa6zlf8RaB7dU8gXnHoIwa5yefwsIA=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=FT5tGjTvx9anXGJJZpqlUnzmhZVCLjbzfE1uMbfa+yvW3vpSEUISyuS3xg1dIv2zB
	 Ug/A9nye/60ZJHaC8Uur30OfmfTXXctJ/1NcI44k4R4hvj/AJXhAaiSuorhoDFRSzg
	 K9Th1cKcBjuyTQq7fO6ceOe+M2R2LClT7qdM5r5J8uQX+PCI/JnexJVt70S2IEbqdg
	 qNhAsrYT2DTFuZKHGKRhGPLXESxvX0EGGlpmzE7dRWFotM7v8pyO9vjQe8HliEYrRr
	 DjrXdwtBp408hV864FHu2X+RvVsJeccvNzVqD+zpe/JQrNnZc4cRLBfKF/Sc6zUfZy
	 fjviCRYDin/ZQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Oct 2025 23:32:44 +0200
Message-Id: <DD85P4NV5B5Y.367RGWFHBR0RF@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 1/2] rust: pci: skip probing VFs if driver doesn't
 support VFs
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Zhi
 Wang" <zhiw@nvidia.com>, "Surath Mitra" <smitra@nvidia.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Alex Williamson"
 <alex.williamson@redhat.com>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <nouveau@lists.freedesktop.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>
To: "Jason Gunthorpe" <jgg@nvidia.com>
References: <20251002170506.GA3299207@nvidia.com>
 <DD80P7SKMLI2.1FNMP21LJZFCI@kernel.org>
 <DD80R10HBCHR.1BZNEAAQI36LE@kernel.org>
 <af4b7ce4-eb13-4f8d-a208-3a527476d470@nvidia.com>
 <20251002180525.GC3299207@nvidia.com>
 <3ab338fb-3336-4294-bd21-abd26bc18392@kernel.org>
 <20251002183114.GD3299207@nvidia.com>
 <56daf2fe-5554-4d52-94b3-feec4834c5be@kernel.org>
 <20251002185616.GG3299207@nvidia.com>
 <DD837Z9VQY0H.1NGRRI2ZRLG4F@kernel.org>
 <20251002210433.GH3299207@nvidia.com>
 <bba17237-2401-4e9b-912b-29d31af748e1@kernel.org>
In-Reply-To: <bba17237-2401-4e9b-912b-29d31af748e1@kernel.org>

On Thu Oct 2, 2025 at 11:14 PM CEST, Danilo Krummrich wrote:
> On 10/2/25 11:04 PM, Jason Gunthorpe wrote:
>> On Thu, Oct 02, 2025 at 09:36:17PM +0200, Danilo Krummrich wrote:
>>> If we want to obtain the driver's private data from a device outside th=
e scope
>>> of bus callbacks, we always need to ensure that the device is guarantee=
d to be
>>> bound and we also need to prove the type of the private data, since a d=
evice
>>> structure can't be generic over its bound driver.
>>=20
>> pci_iov_get_pf_drvdata() does both of these things - this is what it
>> is for. Please don't open code it :(
>
> It makes no sense to use it, both of those things will be ensured in a mo=
re
> generic way in the base device implementation already (which is what I me=
ant
> with layering).
>
> Both requirements are not specific to PCI, or the specific VF -> PF use-c=
ase.
>
> In order to guarantee soundness both of those things have to be guarantee=
d for
> any access to the driver's private data.

Actually, let me elaborate a bit more on this:

In C when a driver calls dev_get_drvdata() it asserts two things:

  (1) The device is bound to the driver calling this function.
  (2) It casts the returned void * to the correct type.

Obviously, relying on this in Rust would be fundamentally unsafe.

Hence, the idea is to implement Device::drvdata_borrow::<T>(), which takes =
a
&Device<Bound> as argument, which proves that the device must be bound.

The T must be the driver specific driver type, i.e. the type that implement=
s
e.g. the pci::Driver trait.

With that, Device::drvdata_borrow() can internally check whether the assert=
ed
type T matches the unique type ID that we store in the device in probe().

This way we can prove that the device is actually bound and that we cast to=
 the
correct type.

Furthermore, the returned reference to the driver's private data can't out-=
live
the lifetime of the given &Device<Bound>, so we're also guaranteed that the
device won't be unbound while we still have a reference to the driver's pri=
vate
data.

So, when we call pdev.physfn().drvdata_borrow::<NovaCore>() the checks are
included already.

> I will send some patches soon, I think this will make it obvious. :)
>>>> Certain conditions may be workable, some drivers seem to have
>>>> preferences not to call disable, though I think that is wrong :\
>>>
>>> I fully agree! I was told that this is because apparently some PF drive=
rs are
>>> only loaded to enable SR-IOV and then removed to shrink the potential a=
ttack
>>> surface. Personally, I think that's slightly paranoid, if the driver wo=
uld not
>>> do anything else than enable / disable SR-IOV, but I think we can work =
around
>>> this use-case if people really want it.
>>=20
>> I've heard worse reasons than that. If that is the interest I'd
>> suggest they should just use VFIO and leave a userspace stub
>> process..
>
> I'm not sure I follow your proposal, can you elaborate?


