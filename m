Return-Path: <linux-pci+bounces-37451-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B012FBB4B55
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 19:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BEF1189143F
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 17:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C93270576;
	Thu,  2 Oct 2025 17:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hi4eaRPN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117AE236A70;
	Thu,  2 Oct 2025 17:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759426672; cv=none; b=qfGj5t2BbqWQIBHbNBauBIH3qSXZz6FW0hh0DdLutz/4hRZVjlsn/q/ufglJws9NahbiEfsnXDqgAiznXkY6cF+q3TDhoTA5TrHxZW1Iqqf5W6yeke1rW7rQToMLZZEFbJqfKgoQzHYHuRSuRfu2tWvqr62Me3WDVcYx0mBdgWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759426672; c=relaxed/simple;
	bh=S0d9r03/9v9N3ZbCfImI3d/7yrfx9R+EGPykgOqDrXk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Fm8ifHEVKFWghj0NGDnnsds8+hLekql5h3pGU88hw+MkVkJapTTFJClR3GnD3Pr4/xahH13InRM46jJLAqGRDKG0g3nHriQRYUCcUtSQFqCyz/HUcJBUbou9Gq3kkwDoNHwn5y4EkdMUPqU/88o+k+aIZDz83IYywRXGNLq7YLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hi4eaRPN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235D9C4CEF4;
	Thu,  2 Oct 2025 17:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759426671;
	bh=S0d9r03/9v9N3ZbCfImI3d/7yrfx9R+EGPykgOqDrXk=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=hi4eaRPNY9GEnJ2h2BRe9o/nS8dMgEJHsVzfOyYM6Fw41EHvpUVbPYDk2+QUPXbb1
	 IafOee7NPx++PZaNdXwgGrQ9695Zx8Pj/f6rHllmpA3yieNn9S/6mkdcAOBO81z2Yv
	 lY89xlUsG16x/xgWtoH0k1IlrlA6w+o2lbSpwYRWdGGEULKpkoNWS1emq2GeohUO97
	 2uygYRZtIMk9ggYcAEhaoMDIdRk2ZXl5jLMgbCgrQHfEHxJzaqEBFiZiAIo2F04bA5
	 ia8v+Rsc02aFbpMPs7yyFwaJ+ZNjtLHu2yeHystxJSWb3MAXmb4hclIbUobUY6BmMn
	 ZGZcpoyN0Mcog==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Oct 2025 19:37:45 +0200
Message-Id: <DD80P7SKMLI2.1FNMP21LJZFCI@kernel.org>
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
From: "Danilo Krummrich" <dakr@kernel.org>
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
In-Reply-To: <20251002170506.GA3299207@nvidia.com>

On Thu Oct 2, 2025 at 7:05 PM CEST, Jason Gunthorpe wrote:
> On Thu, Oct 02, 2025 at 06:05:28PM +0200, Danilo Krummrich wrote:
>> On Thu Oct 2, 2025 at 5:23 PM CEST, Jason Gunthorpe wrote:
>> > This is not what I've been told, the VF driver has significant
>> > programming model differences in the NVIDIA model, and supports
>> > different commands.
>>=20
>> Ok, that means there are some more fundamental differences between the h=
ost PF
>> and the "VM PF" code that we have to deal with.
>
> That was my understanding.
> =20
>> But that doesn't necessarily require that the VF parts of the host have =
to be in
>> nova-core as well, i.e. with the information we have we can differentiat=
e
>> between PF, VF and PF in the VM (indicated by a device register).
>
> I'm not entirely sure what you mean by this..
>
> The driver to operate the function in "vGPU" mode as indicated by the
> register has to be in nova-core, since there is only one device ID.

Yes, the PF driver on the host and the PF (from VM perspective) driver in t=
he VM
have to be that same. But the VF driver on the host can still be a seaparat=
e
one.

>> > If you look at the VFIO driver RFC it basically does no mediation, it
>> > isn't intercepting MMIO - the guest sees the BARs directly. Most of
>> > the code is "profiling" from what I can tell. Some config space
>> > meddling.
>>=20
>> Sure, there is no mediation in that sense, but it needs quite some setup
>> regardless, no?
>>
>> I thought there is a significant amount of semantics that is different b=
etween
>> booting the PF and the VF on the host.
>
> I think it would be good to have Zhi clarify more of this, but from
> what I understand are at least three activites comingled all together:
>
>  1) Boot the PF in "vGPU" mode so it can enable SRIOV

Ok, this might be where the confusion above comes from. When I talk about
nova-core in vGPU mode I mean nova-core running in the VM on the (from VM
perspective) PF.

But you seem to mean nova-core running on the host PF with vGPU on top? Tha=
t of
course has to be in nova-core.

>  2) Enable SRIOV and profile VFs to allocate HW resources to them

I think that's partially in nova-core and partially in vGPU; nova-core prov=
iding
the abstraction of the corresponding firmware / hardware interfaces and vGP=
U
controlling the semantics of the resource handling?

This is what I thought vGPU has a secondary part for where it binds to nova=
-core
through the auxiliary bus, i.e. vGPU consisting out of two drivers actually=
; the
VFIO parts and a "per VF resource controller".

>  3) VFIO variant driver to convert the VF into a "VM PF" with whatever
>     mediation and enhancement needed

That should be vGPU only land.

