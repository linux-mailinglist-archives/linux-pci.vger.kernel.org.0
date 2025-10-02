Return-Path: <linux-pci+bounces-37428-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C08F2BB3FA1
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 15:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 966234E111A
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 13:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F33B2F83DF;
	Thu,  2 Oct 2025 13:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tK7L357z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D4D2EC08E;
	Thu,  2 Oct 2025 13:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759410226; cv=none; b=BjGdS+zxpQvtXSh6Gwy4t3s9ZkoYv7GmAOGyVH7x6TJmhlES3wAC9m0fX34WppLVBwppe2yHHvYVLD1jS7lwisrBzlFWU0QBtYkqiskfepqHJL4FsDjEWzwEohBRQYeqvJMtLQqQIIheFeczM5nNC7hN+DUNaw7fY6606Xxm96Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759410226; c=relaxed/simple;
	bh=IqmZ2qn3/cwmHXiV+sDN9KZgmACU1tPIoXsK0UdOIVg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=cLSgjTFc5GXzWuc9Txcdm4Wy++L5S7r4nwa0z6lKw4oTMMoNBMF2NSAcOrBVadWwLso39jgvWxD5uxv1uEpsPsMzZiiwzE4UeBLtgHxnc0fZML+rCdeZV7o6lM6nbRLwB1ayRSfeQtnMEaieEQ444dP0xhGNzanyUA7NVGRa/ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tK7L357z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F94CC4CEF4;
	Thu,  2 Oct 2025 13:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759410225;
	bh=IqmZ2qn3/cwmHXiV+sDN9KZgmACU1tPIoXsK0UdOIVg=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=tK7L357zNRoAygiOUdtULi+T8umVIFJxKaXPxAvPO/y5yIv7YNhM7mm/9ecDNViJb
	 U5c24LtvIkzzXU+wyIYZgyR/Knb1Xc4rQwmfSTb/wFwN1Ajm0X+7zIrvoVscLgOvwI
	 R+qaC+Azn3dYLZPyQ3Tt1bb/psBFOV7wzGXRwSLEf07icqaRWz6NEh1KEEjh+WLYYa
	 As1LaqL6oWluc9DUTl41JaWPxewctI23uLEHtcXblAPrJLxovJU+LP6w8jlxDKRsaR
	 0BHN0wN9fMYudk6kEeNyDQnTDi7/CbM75I63QgKiyWR9/FZXYd5kV+ePZkxuGHqGQB
	 iL9XYmmt+fE4g==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Oct 2025 15:03:38 +0200
Message-Id: <DD7UVCEVB21H.SQ00WZLLPINP@kernel.org>
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
In-Reply-To: <20251002123921.GG3195801@nvidia.com>

On Thu Oct 2, 2025 at 2:39 PM CEST, Jason Gunthorpe wrote:
> On Thu, Oct 02, 2025 at 02:18:36PM +0200, Danilo Krummrich wrote:
>> On Thu Oct 2, 2025 at 2:11 PM CEST, Jason Gunthorpe wrote:
>> > On Wed, Oct 01, 2025 at 07:00:09PM -0700, John Hubbard wrote:
>> >> Add a "supports_vf" flag to struct pci_driver to let drivers declare
>> >> Virtual Function (VF) support. If a driver does not support VFs, then
>> >> the PCI driver core will not probe() any VFs for that driver's device=
s.
>> >>=20
>> >> On the Rust side, add a const "SUPPORTS_VF" Driver trait, defaulting =
to
>> >> false: drivers must explicitly opt into VF support.
>> >
>> > As I said in the other thread - please no.
>> >
>> > Linux drivers are expected to run on their VFs.
>>=20
>> The consequence would be that drivers for HW that can export VFs would n=
eed to
>> be rejected upstream if they only support the PF, but no VFs. IMHO, that=
's an
>> unreasonable requirement.
>
> Not rejected, they just need to open code a simple isvf check and fail
> during probe if they really have a (hopefully temporary) problem.

The question is whether it is due to a (temporary) problem, or if it is by
design.

I think it's not unreasonable to have a driver for the PF and a separate dr=
iver
for the VFs if they are different enough; the drivers can still share commo=
n
code of course.

Surely, you can argue that if they have different enough requirements they
should have different device IDs, but "different enough requirements" is pr=
etty
vague and it's not under our control either.

> This not really a realistic case. Linux running in the VM *should*
> have drivers that operate the VF, and those existing drivers *should*
> work in the PF context.
>
> Drivers that work in VM but not in a host should not be encouraged!!

I agree, we should indeed encourage HW manufacturers to design the HW in a =
way
that a single driver works in both cases, i.e. less less code to maintain, =
less
surface for bugs, etc., if that is what you mean.

But, if there is another solution for VFs already, e.g. in the case of nova=
-core
vGPU, why restrict drivers from opt-out of VFs. (In a previous reply I ment=
ioned
I prefer opt-in, but you convinced me that it should rather be opt-out.)

> AFAICT this is even true for novacore, the driver should "work" but
> the VF won't be provisioned today so it should fail startup in some
> way. eg "no vram" or something like that.
>
>> > This temporary
>> > weirdness of novacore should not be elevated to a core behavior that
>> > people will misuse.
>>=20
>> It's not just nova-core, please see [1].
>>=20
>> [1] https://lore.kernel.org/lkml/DD7TP31FEE92.2E0AKAHUOHVVF@kernel.org/
>
> I responded there, I don't think the reasons those were added to ICE
> and then cargo-culted are very good, not good enough to justify adding
> it to the core code.

Indeed, the justification of ICE is clearly wrong.

