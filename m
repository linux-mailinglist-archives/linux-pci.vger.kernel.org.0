Return-Path: <linux-pci+bounces-37437-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5A9BB4473
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 17:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D01EF7AABEE
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 15:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B5A17A306;
	Thu,  2 Oct 2025 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7LAEI6A"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A7186342;
	Thu,  2 Oct 2025 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759417868; cv=none; b=eP8aUtuOG8BCRSgNdmlmHLa4truSAuPSnM/MyH/RKZt+9B3n1WJ9D+cq+hngxHJDRbJfEqqNFvrMjAZydjn8b8GvRyOkYV234hdbhJHVrGsu9nD4+9EWErPJMrYZJdNY+AzU6TV2pazOk4sCv2PhgOa+qjCQzpl9MRt8/4ggrik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759417868; c=relaxed/simple;
	bh=FNclR2C69WQjyAgJd3PWTF23QQxMqsFUS9Q5YQBoudQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=fWwXIKIVDaQwaR92ZuWrcCAlnPjIxPIA3kJkGGsCWoPOZT6CjNMRcAK2QeTZ7VavCMD+Rrb48fMwaHq3kL1/7jnK5b0WBgzt4sl3X1WGFboK5T52G5nWuuepFxT956tyTVH4OdlDRZFJWJFvEZ/6gPt5khvRv63/D0WWkMSBlaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7LAEI6A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8D0C4CEF4;
	Thu,  2 Oct 2025 15:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759417867;
	bh=FNclR2C69WQjyAgJd3PWTF23QQxMqsFUS9Q5YQBoudQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=b7LAEI6A6X546xyoF4Ubb8NI3YdGNvaf/frUPbRe5r73qhmkrRjcLnf/9Lbbl05x1
	 bceaUsBFQNzE+rDRu+V+2H/e/ibmjucWQvWLj1U5YnwDZmfg2fOroR+TpcUwqsFbGK
	 AUNsL/ekG3Ksyie+AtPSMbscI1/ffKm24o2Q6lhfdJoMo/JDZO3PJKoAn7BpOcpO47
	 gYjqSYKmpIDbQ6iKO0owh/TeE4cZF3BWlJQ4TZc3gB2EnzP6jVkO/Qz7jTlloYYn+p
	 2n8nv942OpFmUZbjSSVNs2qwMEyzQYidZcNpQuSHHFGwGY9xI52RlmA5jOyMyRavCG
	 +Py3BykTxtXAQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Oct 2025 17:11:01 +0200
Message-Id: <DD7XKV6T2PS7.35C66VPOP6B3C@kernel.org>
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
In-Reply-To: <20251002135600.GB3266220@nvidia.com>

On Thu Oct 2, 2025 at 3:56 PM CEST, Jason Gunthorpe wrote:
> On Thu, Oct 02, 2025 at 03:03:38PM +0200, Danilo Krummrich wrote:
>
>> I think it's not unreasonable to have a driver for the PF and a separate=
 driver
>> for the VFs if they are different enough; the drivers can still share co=
mmon
>> code of course.
>
> This isn't feasible without different PCI IDs.

At least on the host you can obviously differentiate them.

>> Surely, you can argue that if they have different enough requirements th=
ey
>> should have different device IDs, but "different enough requirements" is=
 pretty
>> vague and it's not under our control either.
>
> If you want two drivers in Linux you need two PCI IDs.
>
> We can't reliably select different drivers based on VFness because
> VFness is wiped out during virtualization.

Sure, but I thought the whole point is that some VFs are not given directly=
 to
the VM, but have some kind of intermediate layer, such as vGPU. I.e. some k=
ind
of hybrid approach between full pass-through and mediated devices?

>> But, if there is another solution for VFs already, e.g. in the case of n=
ova-core
>> vGPU, why restrict drivers from opt-out of VFs. (In a previous reply I m=
entioned
>> I prefer opt-in, but you convinced me that it should rather be
>> opt-out.)
>
> I think nova-core has a temporary (OOT even!) issue that should be
> resolved - that doesn't justify adding core kernel infrastructure that
> will encourage more drivers to go away from our kernel design goals of
> drivers working equally in host and VM.

My understanding is that vGPU will ensure that the device exposed to the VM=
 will
be set up to be (at least mostly) compatible with nova-core's PF code paths=
?

So, there is a semantical difference between vGPU and nova-core that makes =
a
differentiation between VF and PF meaningful and justified.

But maybe this understanding is not correct. If so, please educate me.

