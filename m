Return-Path: <linux-pci+bounces-27574-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14531AB3582
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 13:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF760864154
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 10:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DD5267F53;
	Mon, 12 May 2025 10:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="ShP2Q1lh"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA57268FF4
	for <linux-pci@vger.kernel.org>; Mon, 12 May 2025 10:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747047555; cv=none; b=dhfD4c8T3pQR7YrD0r/H7mopuFelz9Jl+5t/NCSy8d64r8ZKX1masWBoII2W3RpJqX4LhTV4U+QUNDxVCOlYLiIMFATMcd9H26/2qf9Pks8KinaWUnaOVoY0EjySJVTsRji3i9ixlOYgongtmxvsmj2zTon9jG2yEgDXy1x6gNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747047555; c=relaxed/simple;
	bh=KOKI1TT7Ffxa/5Huul2yUCdIH6bNQbnt9ywZxg209f0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=eq6+MgxgtEWTlX4VWUjg7ahNZwqcYtakWzAP07GyurxsuL8x2xSQU/AEPKGBEpbLeuluHVZIR+BJkp1iliUvli5FsqoC3G2p7whStcQsiQiuWmxW4ynPrL5BpXDytrtYh+C6yjeOoWbjLjMawQlMOsQv6MDomH202SowN9ZtBCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=ShP2Q1lh; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1747047550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T8/Ht4vLH47yQgnyA3aHoKEjFyY3IKH+TxDUhnG4Pis=;
	b=ShP2Q1lh0QUy9ERDnw/XyUESNdFmosr43cn7zNMQgNobgnz3j/jedkv9j5CKVBYNm+8vDn
	N0gyToplqVDXrQrVDcUo6cyt5E4+/YT8KJ5L9dFRdOWn2PZXu6NEvup8tYnORw9ZAUZpov
	VBU9NUrFQ69gEAFU4nxCCclW/gFw4YVNjlPQD19mamiA/0ygoD4YmyVflSybIMuGtxGRbb
	Gc17pDEGSpSW9spEv7cHsnlo+Uy1UYeDbt4WgEBK4KiHyKOTaeX1RbQkohfqK/VXiiRBOx
	vhvHoPWtq25Yuek/wANmqPZYLaLtTNlXPQF/SbXXdC9/fLBBJNlNr1jTIdOMhA==
Content-Type: multipart/signed;
 boundary=f5128d620a41dad2d3ab473cb7c3567b2921ffecd91198bee2646459e69b;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 12 May 2025 12:58:51 +0200
Message-Id: <D9U4NW0TLBIE.2WTOIETA78EVQ@cknow.org>
Subject: Re: [PATCH 0/1] arm64: dts: rockchip: rk3568: Move PCIe3 MSI to use
 GIC ITS
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Chukun Pan" <amadeus@jmu.edu.cn>, <linux-pci@vger.kernel.org>
Cc: <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
 <dsimic@manjaro.org>, <heiko@sntech.de>, <krzk+dt@kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-rockchip@lists.infradead.org>
References: <D9RSA5K547DD.1LYPIZZM4XALS@cknow.org>
 <20250512070009.336989-1-amadeus@jmu.edu.cn>
In-Reply-To: <20250512070009.336989-1-amadeus@jmu.edu.cn>
X-Migadu-Flow: FLOW_OUT

--f5128d620a41dad2d3ab473cb7c3567b2921ffecd91198bee2646459e69b
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

Added linux-pci ML to "To".

On Mon May 12, 2025 at 9:00 AM CEST, Chukun Pan wrote:
>> > With this patch I get the following kernel warnings:
>> >
>> > pci 0001:10:00.0: Primary bus is hard wired to 0
>> > pci 0002:20:00.0: Primary bus is hard wired to 0
>> >
>> > If I 'unapply' this patch, I don't see those warnings.
>
>> I was pretty sure I had seen those messages before, but couldn't find
>> them before. But now I have: on my rk3588-rock-5b.
>
> Thanks for the reminder, I didn't notice this before.
> The BSP kernel also has this warning.
>
> Before this patch:
> [    2.997725] pci_bus 0001:01: busn_res: can not insert [bus 01-ff] unde=
r [bus 00-0f] (conflicts with (null) [bus 00-0f])
> [    3.009990] pci 0001:00:00.0: BAR 6: assigned [mem 0xf2200000-0xf220ff=
ff pref]
> [    3.018100] pci 0001:00:00.0: PCI bridge to [bus 01-ff]
> ...
> [    3.401416] pci_bus 0002:01: busn_res: can not insert [bus 01-ff] unde=
r [bus 00-0f] (conflicts with (null) [bus 00-0f])
> ...
> [    3.545459] pci 0002:00:00.0: PCI bridge to [bus 01-ff]
>
> After this patch:
> [    3.037779] pci 0001:10:00.0: Primary bus is hard wired to 0
> [    3.044120] pci 0001:10:00.0: bridge configuration invalid ([bus 01-ff=
]), reconfiguring
> [    3.053362] pci_bus 0001:11: busn_res: [bus 11-1f] end is updated to 1=
1
> [    3.068920] pci 0001:10:00.0: PCI bridge to [bus 11]
> ...
> [    3.451429] pci 0002:20:00.0: Primary bus is hard wired to 0
> [    3.457793] pci 0002:20:00.0: bridge configuration invalid ([bus 01-ff=
]), reconfiguring
> ...
> [    3.535794] pci_bus 0002:21: busn_res: [bus 21-2f] end is updated to 2=
1
> ...
> [    3.612893] pci 0002:20:00.0: PCI bridge to [bus 21]
>
> Looks like a harmless warning.

I see various messages which look odd or suboptimal to me:
- (conflicts with (null) [bus 00-0f])
- bridge configuration invalid ([bus 01-ff]), reconfiguring

But those are informational messages, so I guess that is considered
normal. Looking a bit further and it does look that the severities in
``drivers/pci/probe.c`` are chosen deliberately. So even though my NVMe
drives seem to work, I'm not ready yet to ignore a WARNING.

In my view, a warning is something that should be fixed or if it's
indeed harmless, then its severity should be downgraded.

So I looked where that warning came from and found commit
71f6bd4a2313 ("PCI: workaround hard-wired bus number V2")

And its commit message does not make it clear to *me* if it's valid:

    Fixes PCI device detection on IBM xSeries IBM 3850 M2 / x3950 M2
    when using ACPI resources (_CRS).
    This is default, a manual workaround (without this patch)
    would be pci=3Dnocrs boot param.

    V2: Add dev_warn if the workaround is hit. This should reveal
    how common such setups are (via google) and point to possible
    problems if things are still not working as expected.

This could be interpreted as "let's make it a warning so people will put
it in a search engine (and not just ignore it) and then we can find out
via that, if it's a common issue".

It would be helpful if the people (way) more familiar with the PCI
subsystem then me to tell me/us whether the severity is appropriate (and
thus should be fixed?) or if this should be an info or dbg level message
instead.

Cheers,
  Diederik

--f5128d620a41dad2d3ab473cb7c3567b2921ffecd91198bee2646459e69b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaCHUdwAKCRDXblvOeH7b
brPcAQDFLvLOr4MVv6bPcn//tl4F4G7GpE+qkYliDw8IQiSYpAEAmxHUXv878qId
zZdpqj/69uyB2oVZDR5clQaoGkkD7wU=
=2NDu
-----END PGP SIGNATURE-----

--f5128d620a41dad2d3ab473cb7c3567b2921ffecd91198bee2646459e69b--

