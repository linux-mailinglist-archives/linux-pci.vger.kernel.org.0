Return-Path: <linux-pci+bounces-37468-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1B0BB503A
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 21:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E95D18894C3
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 19:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188F02820B2;
	Thu,  2 Oct 2025 19:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdjtIipV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD15027B325;
	Thu,  2 Oct 2025 19:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759433785; cv=none; b=tcxUl0JDFL3llmI0pZc4PaZFRb159K+EVRegsx2CthbbkXgbPfzQzsaK0p1bL0LdZYA0DFf2Ot6V1ZPbbWvkPkAWJqf6mWlDnfxy3FvYxNwP8bquFDvlYIKUSS7KFVeodV3JO0d0biJZtzX1nc4Y0a1K/xiqn5HT9PN74nZi3bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759433785; c=relaxed/simple;
	bh=2KEOHJzy9FGeh4KvBIePLQ1m8QALxmsTaAdrHMcDGwg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=AUw1NFzfckqRobbbcJsLvM1qf/qLiwaKjZZHMHt8tRI0IGy66ZLvrtYjxjAZCOUz1cVfI5utajX7kOxYhjjmp45maWccv6MhNKvtMIpH33XIZ7I3ZBAYopu4brMVOu0Il2lkiUwLaXFivxQpkvqC6xpoSLYNgF4pJLb4g+QR9fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdjtIipV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1257C4CEF4;
	Thu,  2 Oct 2025 19:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759433784;
	bh=2KEOHJzy9FGeh4KvBIePLQ1m8QALxmsTaAdrHMcDGwg=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=tdjtIipVZc4EbvIJCjCG3dVwyx7VM/6ZabxllImlXmi5u8K/CZuc+4ril0c9q4Ivn
	 Kd64F+qIaAvxplzsvSp/0p0HSF233hyKfaTujIYidnd5PIKm0WbspFfRo39ujzNnHb
	 /e/dqFA1c6TVOlgt7IhhIkRp9ZAF57GmMYzpQpWCkeefO2Kpd9VV7QQ+n4SqVT0NVx
	 kZ7tw8VAKPV7no3ryezBjRCXCrspcAN43eT07CCPvS7P+PDQq6W1zlCbKhjmmVNwoq
	 wkjl7EqLC5zW/+zA+gsoG3zd2REGEtaj+RmHA/pFW9pTc83zKjRXVEm1udfUnJNKE/
	 YxcqYdPG1ZaLw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Oct 2025 21:36:17 +0200
Message-Id: <DD837Z9VQY0H.1NGRRI2ZRLG4F@kernel.org>
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
References: <20251002152346.GA3298749@nvidia.com>
 <DD7YQK3PQIA1.15L4J6TTR9JFZ@kernel.org>
 <20251002170506.GA3299207@nvidia.com>
 <DD80P7SKMLI2.1FNMP21LJZFCI@kernel.org>
 <DD80R10HBCHR.1BZNEAAQI36LE@kernel.org>
 <af4b7ce4-eb13-4f8d-a208-3a527476d470@nvidia.com>
 <20251002180525.GC3299207@nvidia.com>
 <3ab338fb-3336-4294-bd21-abd26bc18392@kernel.org>
 <20251002183114.GD3299207@nvidia.com>
 <56daf2fe-5554-4d52-94b3-feec4834c5be@kernel.org>
 <20251002185616.GG3299207@nvidia.com>
In-Reply-To: <20251002185616.GG3299207@nvidia.com>

On Thu Oct 2, 2025 at 8:56 PM CEST, Jason Gunthorpe wrote:
> On Thu, Oct 02, 2025 at 08:42:58PM +0200, Danilo Krummrich wrote:
>> On 10/2/25 8:31 PM, Jason Gunthorpe wrote:
>> > This exactly how this function is used.
>> >=20
>> > The core PF driver provides an API:
>> >=20
>> > struct mlx5_core_dev *mlx5_vf_get_core_dev(struct pci_dev *pdev)
>> >=20
>> > Which takes in the VF as pdev and internally it invokes:
>> >=20
>> > 	mdev =3D pci_iov_get_pf_drvdata(pdev, &mlx5_core_driver);
>>=20
>> Oh, I see, that makes sense then. Thanks for clarifying. I think I alrea=
dy had
>> in mind how this would look like in the Rust abstraction, and there we d=
on't
>> need pci_iov_get_pf_drvdata() to achieve the same thing.
>
> I'm skeptical, there is nothing about rust that should avoid having to
> us pci_iov_get_pf_drvdata().. It does a number of safety checks
> related to the linux driver model that are not optional.

The checks will be the same, but using pci_iov_get_pf_drvdata() directly is=
 not
workable because of how the abstractions are layered.

If we want to obtain the driver's private data from a device outside the sc=
ope
of bus callbacks, we always need to ensure that the device is guaranteed to=
 be
bound and we also need to prove the type of the private data, since a devic=
e
structure can't be generic over its bound driver.

Usually that's not an issue because other entry points into the driver, e.g=
.
subsystem callbacks have their own private data through the class device, I=
RQs
have their own private data in the IRQ registration, etc.

>> Yes, I already thought about this. In the context of adding support for =
SR-IOV
>> in the Rust abstractions I'm planning on sending an RFC to let the subsy=
stem
>> provide this guarantee instead (at least under certain conditions).
>
> Certain conditions may be workable, some drivers seem to have
> preferences not to call disable, though I think that is wrong :\

I fully agree! I was told that this is because apparently some PF drivers a=
re
only loaded to enable SR-IOV and then removed to shrink the potential attac=
k
surface. Personally, I think that's slightly paranoid, if the driver would =
not
do anything else than enable / disable SR-IOV, but I think we can work arou=
nd
this use-case if people really want it.

