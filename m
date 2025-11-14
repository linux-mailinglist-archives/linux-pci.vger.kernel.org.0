Return-Path: <linux-pci+bounces-41274-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 042FFC5F3E6
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 21:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC2B73AC014
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 20:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557ED2FABE3;
	Fri, 14 Nov 2025 20:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNU4yA6M"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241A9298CB7;
	Fri, 14 Nov 2025 20:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763152312; cv=none; b=fjhmIvEqPgDC5wnvraX2de/z7RUBIyX6paaDd7TyxvMOaaf3ipyoHbcr8aSXrRyaNRbZbkVFuws7hq4rmGtVQVBlzrG/ihp52oBnV0MKaSecMiTx4H+7xYnfRIaKp+oHyq8f2uOFksNRlFQcB7fl49RsmkWh9y0dkaWOHqMy8RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763152312; c=relaxed/simple;
	bh=RQAycrRdDG6PX9YchmNQs8NFRoHLj3mYp461FoSrf70=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=rC/V+HcDwscndUsuQra6N/s3FoCJqX0QItGtjPUtKmgaxuMndjls+PGDO5tYrlo4Xe+Wpw4WR4pHZlQFdnrybJZUEb6BFlicJ+N9C5s62MC9sd2OQx/neXvoIQqxViwW1TKBglD01C0n5U89NtjBGB/ggbuy86jgM97K4WsyZ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNU4yA6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F51BC4AF09;
	Fri, 14 Nov 2025 20:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763152311;
	bh=RQAycrRdDG6PX9YchmNQs8NFRoHLj3mYp461FoSrf70=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=nNU4yA6McIqMf1wVmAw1fX7QY9K27aQR/giu4hu+yYI+HtPeNhT56UVy5XRRPXbUd
	 Xw+caW+8p/zmUaBzjWaH7z9RNDi5YJt9n0KwJZFRzb8Pbu6U5Ai/XTCaM1Gj5Mq3Fo
	 ZwLnbNhIHzx9pQYGbNqY5p00cZrhMvAFyCURg8umjpYCWGgdJCHFmdmkrBBOYs5Kpa
	 tWVNdF4rwxTRZMopZJlk/7HRx1baBxHcKxyPeRrofhggttawkVmj+wNn3cEkewKZot
	 4G+CuMe623sSO0mxz2xtx5bKgOoWwckSYNe9L4g3zfZH00t4on0VZuU/LILdirSsWl
	 QzkRsq9mjBmjw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 15 Nov 2025 07:31:37 +1100
Message-Id: <DE8PBRC48D14.IX6FUPOLLVHR@kernel.org>
Cc: "Alice Ryhl" <aliceryhl@google.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <acourbot@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
 <zhiwang@kernel.org>
To: "Zhi Wang" <zhiw@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v6 RESEND 4/7] rust: io: factor common I/O helpers into
 Io trait
References: <20251110204119.18351-1-zhiw@nvidia.com>
 <20251110204119.18351-5-zhiw@nvidia.com> <aRcnd_nSflxnALQ9@google.com>
 <20251114192719.15a3c1a7.zhiw@nvidia.com>
In-Reply-To: <20251114192719.15a3c1a7.zhiw@nvidia.com>

On Sat Nov 15, 2025 at 4:27 AM AEDT, Zhi Wang wrote:
> On Fri, 14 Nov 2025 12:58:31 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
>> This defines three traits:
>>=20
>> * Io
>> * IoInfallible: Io
>> * IoFallible: Io
>>=20
>> This particular split says that there are going to be cases where we
>> implement IoInfallible only, cases where we implement IoFallible only,
>> and maybe cases where we implement both.
>>=20
>> And the distiction between them is whether the bounds check is runtime
>> or compile-time.
>>=20
>> But this doesn't make much sense to me. Surely any Io resource that
>> can provide compile-time checked io can also provide runtime-checked
>> io, so maybe IoFallible should extend IoInfallible?

Yeah, though I did like that with this split we can enforce one or the othe=
r.

E.g. in the case of the PCI configuration space we can always assert the
expected size at compile time and drivers should not have to deal with runt=
ime
offsets either.

Hence, with this split we can avoid that drivers implement unnecessary runt=
ime
checks.

Either is fine with me though.

>> And why are these separate traits at all? Why not support both
>> compile-time and runtime-checked IO always?
>>
>
> Hi Alice:
>
> Thanks for comments. I did have a version that PCI configuration space
> only have fallible accessors because I thought the device can be
> unplugged or a VF might fail its FLR and get unresponsive, so the driver
> may need to check the return all the time. And Danilo's comments were
> let's have the infallible accessors for PCI configuration space and add
> them later if some driver needs it. [1]

Yeah, that's the same with MMIO accesses as well, yet we don't check all th=
e
time. Actually, when a device falls from the bus, the error state is not
available immediately either and hence drivers have to be robust enough to =
deal
with it anyway.

Adding in that a driver is also unbound as soon as the device falling from =
the
bus is detected, there is not much value in those checks.

