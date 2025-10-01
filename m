Return-Path: <linux-pci+bounces-37382-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA030BB2170
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 01:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F3B61661D7
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 23:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43829298CAB;
	Wed,  1 Oct 2025 23:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOJYzq/d"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D1A296BA8;
	Wed,  1 Oct 2025 23:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759362967; cv=none; b=r2wistJ/SnaXIKIv/U74vX3wHM5+psNz5B9g1y3lyzfeqv6NWiS1WOlPsAkyH0/V9Y++fyN7pkWOac5MUkyiqFOGlX66ri3BdaBJPOCy9jT26/mH4vUP70LUIpfJsHlClgUhZCpGE/YZZ2gUjyjH0um5TQL9aAC4JKWvC28LpK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759362967; c=relaxed/simple;
	bh=ILkjc/XVyx6bQd0jLKnZzkgG0gPtYYukDOQdK37yZo4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=eYxQ8pB308FCAPcWaKzCkNdj8JsKjzHgVXCZi/Ysyuxppvr38XPS+h0zgNtleuK5FsXr54ExDa7Rd3uUKn2DSwCsog2rHb5sTQWjUNzk+U1JFvt7KOZi4lVEc92phLta3Z9VjslYz3Ha45QDXRVUeSNx8LFzqBsYTS683ECRCOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOJYzq/d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4126C4CEF1;
	Wed,  1 Oct 2025 23:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759362964;
	bh=ILkjc/XVyx6bQd0jLKnZzkgG0gPtYYukDOQdK37yZo4=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=OOJYzq/d9GisZWtqu9cNN5RFi3FocdFAYpWPhUh2NCuSnPRxyxBP3x1IHCSv1xUUO
	 bEdCEO+Vas16q+omPselXFEFb7cDvooOz1rAbQ+RVKbWxndUsP+bl5lO+qL2GWdZj2
	 BjXO3hTDcObebkjFTKK88bDcGj8s3bmuYoV0OEuof03/1V62oXgDdHjY7JLxFRNpb2
	 TUyq4QuFJg+jmzmh/nCFYPF8j4dmmVDxY22+sKrV57gXwK6mg9TLKcbEunAjFk/sK8
	 Vwnx7glv/LyvQ/ISNgyKBbMKIYVYTHCIV/Pl61l1hsmjcgwqGmUWd2YWArY447pMg5
	 s7w45BbsVUyFg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Oct 2025 01:55:57 +0200
Message-Id: <DD7E4902SAFP.3JLTVDIKKCRWS@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
Cc: "Joel Fernandes" <joelagnelf@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 "Alistair Popple" <apopple@nvidia.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Surath Mitra"
 <smitra@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, "LKML"
 <linux-kernel@vger.kernel.org>, "Jason Gunthorpe" <jgg@nvidia.com>, "Alex
 Williamson" <alex.williamson@redhat.com>
To: "John Hubbard" <jhubbard@nvidia.com>
References: <20250930220759.288528-1-jhubbard@nvidia.com>
 <h6jdcfhhf3wuiwwj3bmqp5ohvy7il6sfyp6iufovdswgoz7vul@gjindki2pyeh>
 <e77bbcda-35a3-4ec6-ac24-316ab34a201a@nvidia.com>
 <DD6X0PXA0VAO.101O3FEAHJUH9@kernel.org>
 <f145fd29-e039-4621-b499-17ab55572ea4@nvidia.com>
 <ae48fad0-d40e-4142-87d0-8205abdf42d6@nvidia.com>
 <DD7CREVYE5L7.2FALGBC35L8CN@kernel.org>
 <e19781f3-1451-4b4d-b4be-c71c9ec8dc63@nvidia.com>
 <1FA2746D-6F73-4D5A-A0DC-803D0563A5D7@nvidia.com>
 <a7bd8285-922e-446f-9b43-a67fff67a505@nvidia.com>
In-Reply-To: <a7bd8285-922e-446f-9b43-a67fff67a505@nvidia.com>

On Thu Oct 2, 2025 at 1:51 AM CEST, John Hubbard wrote:
> On 10/1/25 4:47 PM, Joel Fernandes wrote:
>>> On Oct 1, 2025, at 7:00=E2=80=AFPM, John Hubbard <jhubbard@nvidia.com> =
wrote:
>>> =EF=BB=BFOn 10/1/25 3:52 PM, Danilo Krummrich wrote:
>>>>> On Thu Oct 2, 2025 at 12:38 AM CEST, John Hubbard wrote:
>>>>> On 10/1/25 6:52 AM, Zhi Wang wrote:
>>>>>> On 1.10.2025 13.32, Danilo Krummrich wrote:
>>>>>>> On Wed Oct 1, 2025 at 3:22 AM CEST, John Hubbard wrote:
>>>>>>>> On 9/30/25 5:29 PM, Alistair Popple wrote:
>>>>>>>>> On 2025-10-01 at 08:07 +1000, John Hubbard <jhubbard@nvidia.com> =
wrote...
>>>>> ...
>> Here is my opinion and correct me if I missed something:
>>=20
>> It feels premature to remove the option of nova-core binding to a VF, si=
nce other options to disable auto probing do exist as Jason pointed out.
>>=20
>> Taking a parallel with VFIO pass through for instance, the user already =
has to do some diligence like preventing drivers from binding and then maki=
ng vfio-pci bind to the device IDs. This case is similar though slightly di=
fferent, but VFIO setup requires some configuration anyway so will it reall=
y improve anything?
>>=20
>> I quietly suggest holding on till there is a real need or we are sure no=
va cannot bind to, or operate on a VF. This=20
>
> I'm confident that nova-core cannot properly handle a VF with *today's* c=
ode.
> There is no expectation at all for a VF to show up--yet.
>
> Which is why I think it's appropriate to skip it right now.

I agree with John.

If a driver does not support a certain device, it is not the user's
responsibility to prevent probing. Currently nova-core does not support VFs=
, so
it should never get probed for them in the first place.

