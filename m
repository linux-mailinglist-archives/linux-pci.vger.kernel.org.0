Return-Path: <linux-pci+bounces-37488-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2CEBB5B14
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 02:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D0CD4A689E
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 00:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F332F1A38F9;
	Fri,  3 Oct 2025 00:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBZc1qsh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA773BBF2;
	Fri,  3 Oct 2025 00:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759453080; cv=none; b=aWo2YfZOjDOLLLkZkr/wpW5rEdw/0+pwRCFbq/VaF3m//E65a5Oei16zvUkZNYf0MYL5JKLROPVyo8kIAKdrsSnMfgQiBMlJ2Da4+zQ69MHrlFOtzFuJCuw1ovQRoQgZ1Vw8MxjfIsTfPePE96802kwLZC2GBVlkd+tTwWoluLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759453080; c=relaxed/simple;
	bh=gGh/Qei7nmlKhJsFz5d/aOUzsnnKuTRbbLHu6gETIL8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=useYmpGTj7UmYDyn9IpKI48HrxuaAShQRHkC9bUWyLXBu9JoY0bCT8jsCkB28/Tuh9s+5PDjrV3y+pF/eyHtvpjkzPz4uhwKfO9yfxHPnEuXlS7E5VI4Qxeuwi5voVrUsvwbaE0xTLGzBfv9TVVI5SKOm7QrhpaMAYv7ZH4k8xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBZc1qsh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30AC0C4CEF4;
	Fri,  3 Oct 2025 00:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759453080;
	bh=gGh/Qei7nmlKhJsFz5d/aOUzsnnKuTRbbLHu6gETIL8=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=aBZc1qshQFME0il50O32b479A0SKwLY3NxmXgsaQ6+wEJYnrPpN/hLGQELMJlI8Hw
	 rKCU8sUyvUMDGkrbbu5rU8cydiXTeLFMOFdjRMjFocVNuBeXFd0zOMUKhoMca/w+w9
	 jJLkq7SNWwFZBHpolw3xw28U48UPunczKExPaY7bXolnWVvim8byQYL8XMItUiVhAi
	 EeJ8hlUV8GP45FbHce0LNH4oDkyWDRzLZKX2aVDQM6GIu4rLbbZN2nZlJkauXAjlsG
	 S8gIr38HKrTx+dmzMj5B6ZauV+jqNs8polvqTtPk+f8ocyGKuNt4v9MQabV/vLCDm3
	 SKHNJ6OhRXYCQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Oct 2025 02:57:53 +0200
Message-Id: <DD8A27ESH61G.306ZAIGZCMJ97@kernel.org>
To: "Jason Gunthorpe" <jgg@nvidia.com>
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
References: <af4b7ce4-eb13-4f8d-a208-3a527476d470@nvidia.com>
 <20251002180525.GC3299207@nvidia.com>
 <3ab338fb-3336-4294-bd21-abd26bc18392@kernel.org>
 <20251002183114.GD3299207@nvidia.com>
 <56daf2fe-5554-4d52-94b3-feec4834c5be@kernel.org>
 <20251002185616.GG3299207@nvidia.com>
 <DD837Z9VQY0H.1NGRRI2ZRLG4F@kernel.org>
 <20251002210433.GH3299207@nvidia.com>
 <bba17237-2401-4e9b-912b-29d31af748e1@kernel.org>
 <DD85P4NV5B5Y.367RGWFHBR0RF@kernel.org>
 <20251002234010.GI3299207@nvidia.com>
In-Reply-To: <20251002234010.GI3299207@nvidia.com>

On Fri Oct 3, 2025 at 1:40 AM CEST, Jason Gunthorpe wrote:
> On Thu, Oct 02, 2025 at 11:32:44PM +0200, Danilo Krummrich wrote:
>
>> So, when we call pdev.physfn().drvdata_borrow::<NovaCore>() the checks a=
re
>> included already.
>
> I'm not keen on hiding this reasoning inside an physfn() accessor like
> this. ie one that returns a Device<Bound>. The reasoning for this is
> tricky and special. We have enough cases where physfn won't be a bound
> driver. I think it is big stretch just to declare that unconditionally
> safe.

In this example physfn() would return a &pci::Device<Bound>.

This is what I mentioned previously; I want the subsystem to guarantee (at =
least
under certain circumstances) that if the VF device is bound that the PF dev=
ice
must be bound as well.

> There is a reason pci_iov_get_pf_drvdata() has such a big comment..
>
> So I'd rather see you follow the C design and have an explicit helper
> function to convert a VF bound device to a PF bound device

Well, this is exactly what physfn() does (with the precondition that we can=
 get
the guarantee from the subsystem).

> and check
> the owner, basically split up pci_iov_get_pf_drvdata() into a part to
> get the struct device and an inline to get the drvdata. Rust still has an
> ops pointer it can pass in so it can be consistent with the C code

Which ops pointer are you referring to? Do you mean the struct pci_driver
pointer? If so, no we can't access this one. We could make it accessible, b=
ut it
would result into horrible code, wouldn't make it possible to implement the
check generically for any device (which we need anyways) and would have som=
e
other bad implications.

I try to be as consistent as possible with C code, but sometimes it just do=
esn't
fit at all and would even hurt. This is one of those cases.

To give at least some background: A driver structure (like struct pci_drive=
r) is
embedded in a module structure, which is a global static and intentionally =
not
directly accessible for drivers.

Even if we'd make it accessible, the driver field within a module structure
depends on the exact implementation, i.e. it depends on whether a module is
declared "by hand", or whether it is generated by a module_driver!() macro =
(e.g.
module_pci_driver!().

It probably also helps to have a look at samples/rust/rust_driver_auxiliary=
.rs,
which open codes driver registrations, since it registers two drivers in th=
e
same module for the purpose of illustrating an auxiliary connection, i.e. i=
t
doesn't use a module_driver!() macro.

The struct struct auxiliary_driver resides within the
driver::Registration<auxiliary::Adapter<T>>, where driver::Registration is =
a
generic type for registering drivers, auxiliary::Adapter defines the auxili=
ary
specific bits for this registration and T is the driver specific type that
implements the auxiliary::Driver trait, containing the bus callbacks etc.

> even if it does another check inside its drvdata_borrow.

It's the exact same check; just a better fitting implementation.

I.e. instead of checking a pointer which is hard to access, we check if the=
 type
ID we gave to the device matches the driver specific type (the T in
driver::Registration<auxiliary::Adapter<T>>).

Semantically, there is no difference, but it results in less cumbersome and=
 more
flexible code.

