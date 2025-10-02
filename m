Return-Path: <linux-pci+bounces-37452-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A370CBB4B81
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 19:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 914457AF61D
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 17:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B06270572;
	Thu,  2 Oct 2025 17:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMs+zvMv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DA84501A;
	Thu,  2 Oct 2025 17:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759426814; cv=none; b=DVb3hHnCiMCECCtcHeh5f6JQ8OsxB87oCiVA4cy71z+nkryVT1Ii9GSbI/TYkoxg/jayV4Xoa7FcBY0RlDd7URIeebw/ofc6wuBlFvU7t5zzwiTUEWK0fY/cQ3bAe6U34XavjpRtAEY5+EYo9jQUnVSvNFJLCLcOStMgUHFNaCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759426814; c=relaxed/simple;
	bh=oYrJIA6vkpZceZ0M4mLdsW2GlBt5dZV94uJaeXi0tbw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=HmOemIFfLugswg3v+5sXGgVmzvKxHLjFUXXmVVnLgpp0h2AP53Kk2Qsz+xEb9hhKv3QhNPLIL7RzVySHcGtS247bb2JaLXky9Et/Loi/NOEl1orRDi3StJxG49EDLbnUz0dbXo28Z4aNDa47cDdZmxubEgeW5drJ/TlWqrPSEYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMs+zvMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48285C4CEF4;
	Thu,  2 Oct 2025 17:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759426814;
	bh=oYrJIA6vkpZceZ0M4mLdsW2GlBt5dZV94uJaeXi0tbw=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=tMs+zvMve/ExgwSR4GhJRVFojCHnCjw6KsVJvq7zKVIqlvrLizd4h4L7T+SuaEFn/
	 uWJ4QHe7cbigKndSLyAa5/1m/W7nucbm2fkjaJ+nr/D/qCByUap9cW5IluD1SZsawQ
	 0mNiDqDSJOgShiOTsX6VynxmTpHlmnMCMeVEiLTSdLXWTaEhHbmyyEHYTD27i05ElT
	 gCEoAgmYoyNOwkaJbz/ao3M4CbG+nM2a7CQR+QyNB5Pi+QHPWkP/3ST7Ie0AnnN8Wd
	 rMJb2zVXKIK8TstdDYQ4NqWpLjp9L5YOZ7Ms2QyrSNstEqZxuDu8zvSIn/4Su1B3AP
	 R1O74Jlt8l4kQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Oct 2025 19:40:07 +0200
Message-Id: <DD80R10HBCHR.1BZNEAAQI36LE@kernel.org>
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
References: <20251002020010.315944-1-jhubbard@nvidia.com>
 <20251002020010.315944-2-jhubbard@nvidia.com>
 <20251002121110.GE3195801@nvidia.com>
 <DD7TWUPD83M9.5IO0VX7PP1UK@kernel.org>
 <20251002123921.GG3195801@nvidia.com>
 <DD7UVCEVB21H.SQ00WZLLPINP@kernel.org>
 <20251002135600.GB3266220@nvidia.com>
 <DD7XKV6T2PS7.35C66VPOP6B3C@kernel.org>
 <20251002152346.GA3298749@nvidia.com>
 <DD7YQK3PQIA1.15L4J6TTR9JFZ@kernel.org>
 <20251002170506.GA3299207@nvidia.com>
 <DD80P7SKMLI2.1FNMP21LJZFCI@kernel.org>
In-Reply-To: <DD80P7SKMLI2.1FNMP21LJZFCI@kernel.org>

On Thu Oct 2, 2025 at 7:37 PM CEST, Danilo Krummrich wrote:
> On Thu Oct 2, 2025 at 7:05 PM CEST, Jason Gunthorpe wrote:
>> On Thu, Oct 02, 2025 at 06:05:28PM +0200, Danilo Krummrich wrote:
>>> On Thu Oct 2, 2025 at 5:23 PM CEST, Jason Gunthorpe wrote:
>>> > This is not what I've been told, the VF driver has significant
>>> > programming model differences in the NVIDIA model, and supports
>>> > different commands.
>>>=20
>>> Ok, that means there are some more fundamental differences between the =
host PF
>>> and the "VM PF" code that we have to deal with.
>>
>> That was my understanding.
>> =20
>>> But that doesn't necessarily require that the VF parts of the host have=
 to be in
>>> nova-core as well, i.e. with the information we have we can differentia=
te
>>> between PF, VF and PF in the VM (indicated by a device register).
>>
>> I'm not entirely sure what you mean by this..
>>
>> The driver to operate the function in "vGPU" mode as indicated by the
>> register has to be in nova-core, since there is only one device ID.
>
> Yes, the PF driver on the host and the PF (from VM perspective) driver in=
 the VM
> have to be that same. But the VF driver on the host can still be a seapar=
ate
> one.
>
>>> > If you look at the VFIO driver RFC it basically does no mediation, it
>>> > isn't intercepting MMIO - the guest sees the BARs directly. Most of
>>> > the code is "profiling" from what I can tell. Some config space
>>> > meddling.
>>>=20
>>> Sure, there is no mediation in that sense, but it needs quite some setu=
p
>>> regardless, no?
>>>
>>> I thought there is a significant amount of semantics that is different =
between
>>> booting the PF and the VF on the host.
>>
>> I think it would be good to have Zhi clarify more of this, but from
>> what I understand are at least three activites comingled all together:
>>
>>  1) Boot the PF in "vGPU" mode so it can enable SRIOV
>
> Ok, this might be where the confusion above comes from. When I talk about
> nova-core in vGPU mode I mean nova-core running in the VM on the (from VM
> perspective) PF.
>
> But you seem to mean nova-core running on the host PF with vGPU on top? T=
hat of
> course has to be in nova-core.
>
>>  2) Enable SRIOV and profile VFs to allocate HW resources to them
>
> I think that's partially in nova-core and partially in vGPU; nova-core pr=
oviding
> the abstraction of the corresponding firmware / hardware interfaces and v=
GPU
> controlling the semantics of the resource handling?
>
> This is what I thought vGPU has a secondary part for where it binds to no=
va-core
> through the auxiliary bus, i.e. vGPU consisting out of two drivers actual=
ly; the
> VFIO parts and a "per VF resource controller".

Forgot to add: But I think Zhi explained that this is not necessary and can=
 be
controlled by the VFIO driver, i.e. the PCI driver that binds to the VF its=
elf.

>>  3) VFIO variant driver to convert the VF into a "VM PF" with whatever
>>     mediation and enhancement needed
>
> That should be vGPU only land.


