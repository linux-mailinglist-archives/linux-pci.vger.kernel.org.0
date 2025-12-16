Return-Path: <linux-pci+bounces-43114-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8699CC2B4A
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 13:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6106931E1AA5
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 12:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9253559C6;
	Tue, 16 Dec 2025 12:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwArkI3A"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745FB34DB48;
	Tue, 16 Dec 2025 12:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765887249; cv=none; b=Qq/0iXyrThfXb8cWWAppHAkkX3CSNBj/XtQ50FwQlPcED4s/gnwNX/gqOYRjh0WWFocsJPttEXK0jhhhD+7AjV+irogHoMd9UgmJWJmLhsZQDpfk1LOgLXdgTjTDD8NSuDOt0gPT/KB2ypMSUIdMeFVD6t4wmeg/u0GGwU4QKHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765887249; c=relaxed/simple;
	bh=pZP2BYvtE9bxefV3Xhyf3JysEWckorGNQUlBT4sl0HE=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=ujd9hTfGS2HK/gEaEyOJ0q9w7kwmP1g0T+1cEqS62V6GNjCEbU+CWPesXwaq0MVadsdmMHE84RXW1OibEMuMDbvLxvBZAJ6jfWdjEdkTQXXQZzkI/8jQCw4ddkv3dxaJV5z37BC2SXMXXXXrUORBTh2CRjitC69gYLpy4Szr2HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwArkI3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448E7C4CEF5;
	Tue, 16 Dec 2025 12:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765887247;
	bh=pZP2BYvtE9bxefV3Xhyf3JysEWckorGNQUlBT4sl0HE=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=mwArkI3A22We2dV9k1nt+llKSV/PdjOlNKOSh58EWc2WT3tKVntnnU6I/YiUggG3i
	 Tqh2Avr7N+p89KUHE18Db1eNRQr79btWxbHXefSDfhZbHyPA/X5xWRI6d6bq8M/40R
	 iV8mM+xU+ytME+2AjSpNZGzkx0IfVa7eE8uf0+3iDgrlmtU4sIq2ms8QUuDz+/wK8P
	 m4yWOoT3dvUDqi/WRJE4SvI7m8geXpOuHNWA1S5VFcizIh/UM8imRRxIg0GS8i499V
	 jjoKi9KwaPezhIb7cI2YtgnG3oibWCi65T41bi5MZzcwoSs2uqWgnMrLLbCZakN2of
	 +r0DoPlVFuRgg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Dec 2025 13:14:00 +0100
Message-Id: <DEZMS6Y4A7XE.XE7EUBT5SJFJ@kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 1/7] rust: pci: pass driver data by value to `unbind`
Cc: "Alice Ryhl" <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Edwin Peer" <epeer@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
References: <20251216-nova-unload-v1-0-6a5d823be19d@nvidia.com>
 <20251216-nova-unload-v1-1-6a5d823be19d@nvidia.com>
In-Reply-To: <20251216-nova-unload-v1-1-6a5d823be19d@nvidia.com>

On Tue Dec 16, 2025 at 6:13 AM CET, Alexandre Courbot wrote:
> When unbinding a PCI driver, the `T::unbind` callback is invoked by the
> driver framework, passing the driver data as a `Pin<&T>`.
>
> This artificially restricts what the driver can do, as it cannot mutate
> any state on the data. This becomes a problem in e.g. Nova, which needs
> to invoke mutable methods when unbinding.
>
> `remove_callback` retrieves the driver data by value, and drops it right
> after the call to `T::unbind`, meaning it is the only reference to the
> driver data by the time `T::unbind` is called.
>
> There is thus no reason for not granting full ownership of the data to
> `T::unbind`, so do it.

There are multiple reasons I did avoid this for:

(1) Race conditions

A driver can call Device::drvdata() and obtain a reference to the driver's
device private data as long as it has a &Device<Bound> and asserts the corr=
ect
type of the driver's device private data [1].

Assume you have an IRQ registration, for instance, that lives within this d=
evice
private data.  Within the IRQ handler, nothing prevents us from calling
Device::drvdata() given that the IRQ handler has a Device<Bound> reference.

Consequently, with passing the device private data by value to unbind() it =
can
happen that we have both a mutable and immutable reference at of the device
private data at the same time.

The same is true for a lot of other cases, such as work items or workqueues=
 that
are scoped to the Device being bound living within the device private data.

More generally, you can't take full ownership of the device private data as=
 long
as the device is not yet fully unbound (which is not yet the case in unbind=
()).

(2) Design

It is intentional that the device private data has a defined lifetime that =
ends
with the device being unbound from its driver. This way we get the guarante=
e
that any object stored in the device private data won't survive device / dr=
iver
unbind. If we give back the ownership to the driver, this guarantee is lost=
.

Conclusion:

Having that said, if you need mutable access to the fields of the device pr=
ivate
data within unbind() the corresponding field(s) should be protected by a lo=
ck.

Alternatively, you have mutable access within the destructor as well, but t=
here
you don't have a bound device anymore. Which is only consequent, since we c=
an't
call the destructor of the device private data before the device is fully
unbound.

(In fact, as by now, there is a bug with this, which I noticed a few days a=
go
when I still was on vacation: The bus implementations call the destructor o=
f the
device private data too early, i.e. when the device is not fully unbound ye=
t.

I'm working on a fix for this. Luckily, as by now, this is not a real bug i=
n
practice, yet it has to be fixed.)

From your end you don't have to worry about this though. nova-core should j=
ust
employ a lock for this, as we will need it in the future anyways, since we =
will
have concurrent access to the GSP.

[1] https://rust.docs.kernel.org/kernel/device/struct.Device.html#method.dr=
vdata

