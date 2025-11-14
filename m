Return-Path: <linux-pci+bounces-41275-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3828CC5F40D
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 21:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0704935BA2F
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 20:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4A73491EB;
	Fri, 14 Nov 2025 20:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2qkLRWU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CF32F12AB
	for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 20:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763152461; cv=none; b=VPSeJmnHmbJ7PVhy8a2vENGNx32QqQ7Yl+asZ9lgksCV4tAQMDThheZc1STjmiV3hEbGK35BXrDHMZS4utgq8Yb8J7f91gSH01jB6SxvDbFuYSwuz38wxyJz2e9bhgSN+k8SvVL4OuXhzzOYa1ul7uPcE5RpX07LcOyn3o67QdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763152461; c=relaxed/simple;
	bh=74t65GlEcLLe61c+jn1X9deXuYNch6SLqwI2PPCxfxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpefyIlsGqrbodFBhjVbLtpeRf0AasH53W1ziwkZzmjtu3Bs5+6G8keS7/5vpRbZyponJnJBI+KNqEY0gHnIdck0JhivifV7gqikctWJaAQ650dmNJELEFoSklwF3mBNqcdaXy1qD0IWSPHa75THQhHjeWiygair0lDUYqKYWGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2qkLRWU; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3437c093ef5so2299007a91.0
        for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 12:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763152460; x=1763757260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2tUyhIah92QGKm3skN+GFPKLkbDp3lL7w3hkBKRK+M=;
        b=U2qkLRWUvNKBGlcbhz/ytqPaWTvOT+obvEtPAyLYCpD8en0AtlLclB5y5wInHnnmaF
         oiGzo9h5nfN8+e5uuh+RJX6x+TVul8+9atFtOecZ7Pux0W4z2GsCRE/qc57/MhGP1HWx
         7gUb+XMl1C5UccfsXSbJVErNvvp8WoTjp7gn3FW2q1NI3QXq0ZWlj3rsfillsCcc0GqT
         xcKEBjYKyKw2FAYiQNcc6rren+yQPqx+0HfD3pqcBdjYLNzNotHT6tn5RuqbaQAnWzme
         lU1m0FPoR2aZf2wXSJE7v1vPtXn/lJltqmcYLwCS0RigDn7FgHit5nxqoPyUcn7aC1/l
         LD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763152460; x=1763757260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2tUyhIah92QGKm3skN+GFPKLkbDp3lL7w3hkBKRK+M=;
        b=hiWmGooBY95O4YtHRmu0Tj+0FShIjEJp0xzJKeT/uczYgozIPpocO7GWqEefbVuhrC
         /iKtTOT3IAnOw0Y15PTGbY73fCCaXK68kDimNuUyB/XezE/gAtZYBvsGxyjvoiRsGExm
         ERowO/jwVv6oXN10hKL35WaVQyl3pP1jLVKh/a8+IHmevwydanSN63tj5jYVJaE6xIPS
         vGKU3e2YrHSqKY5TBVeaAs7WzadAquX4dliw8v2IFZKLX8Ym0lrQCel5bDZHTj0A7PeO
         zJbT2lDTaa1bGHb9wOpISNa93kdj3EhhaEyUDKqgWHkHuOb9wP+GQaquHJz0BM9Abdtb
         lhZA==
X-Forwarded-Encrypted: i=1; AJvYcCWeH3BOKCb3ZI26Ly36ZccdjSo5o43UNZISa2cQdV/YiaoJ2Yl1mxiMS+UjUiGu+/RWsswZ2jPHVtE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9oo9Wa9YSc93j36eOfRmDUrXokrgx63VR6DTKbY9tNLqiOVL0
	hxuj/y9x/YM+WiL0btvOIe58fulPx/bULfCCcZlOkkPAAWa2eR74oLgJ
X-Gm-Gg: ASbGnctNE8xF7Mna3DxwRIW5hk74fUXoIDLyyyXTDmmrciaWRf46FcG8Mc00W32TCbG
	YKB04+tokoI/T9mWgm4QkQ61qKhvdzKk7gOjDczBHzFnBO0t2hNuq7YKuboNoS/nBZk8JZtZJka
	uWWEgcx7qb1ci1AaLVJSlzmieagvY9wnoXNi8nS+rwyGuC25HHXRgfbeg6KJ5YHClMjAfnhGb3Y
	qFy4Z/L2rAstG/iwBFzWy7Awa8zfUJpNpcbJSfT6EjvueuUbioNOmZrX3JAuXMIxn8sWu8IuMS3
	EaI7PGr4rmLbVua0yvi7AzTQ09ybUUIGkQ3OyLfCeDr2mGIZA1DozGlbH2daHCHxtnqDICHyMpU
	2Qx5Rr4I+p92rXEc20eTOnowC716uy1bEwBcTHWfTOhhw3hVE42hecw0UAmtF6Gjsl3/FT5I4xH
	+jVfhrJQBo8mWjyWW2rHc=
X-Google-Smtp-Source: AGHT+IEe7JuZ4t+UG3Ej2ub9oJMa/3y/sYYCQh/JHxxvjriyxwW0b8MtjVbBgwEpy0ihZpW+2/eVvw==
X-Received: by 2002:a17:90b:37ce:b0:340:f05a:3ebd with SMTP id 98e67ed59e1d1-343fa7469ecmr4392519a91.28.1763152459570;
        Fri, 14 Nov 2025 12:34:19 -0800 (PST)
Received: from geday ([2804:7f2:800b:9c95::dead:c001])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36db22439sm5747058a12.4.2025.11.14.12.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 12:34:18 -0800 (PST)
Date: Fri, 14 Nov 2025 17:34:05 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci <linux-pci@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	krzk+dt <krzk+dt@kernel.org>, conor+dt <conor+dt@kernel.org>,
	Johan Jonker <jbx6244@gmail.com>,
	linux-rockchip <linux-rockchip@lists.infradead.org>,
	Simon Glass <sjg@chromium.org>,
	Philipp Tomsich <philipp.tomsich@vrull.eu>,
	Kever Yang <kever.yang@rock-chips.com>,
	Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
	=?utf-8?B?5byg54Oo?= <ye.zhang@rock-chips.com>
Subject: Re: [PATCH] arm64: dts: rockchip: align bindings to PCIe spec
Message-ID: <aReSPbRxCgdNRI9y@geday>
References: <aQsIXcQzeYop6a0B@geday>
 <67b605b0-7046-448a-bc9b-d3ac56333809@rock-chips.com>
 <aQ1c7ZDycxiOIy8Y@geday>
 <d9e257bd-806c-48b4-bb22-f1342e9fc15a@rock-chips.com>
 <aRLEbfsmXnGwyigS@geday>
 <AGsAmwCFJj0ZQ4vKzrqC84rs.3.1762847224180.Hmail.ye.zhang@rock-chips.com>
 <aRQ_R90S8T82th45@geday>
 <aRUvr0UggTYkkCZ_@geday>
 <aRazCssWVdAOmy7D@geday>
 <e8524bf8-a90c-423f-8a58-9ef05a3db1dd@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8524bf8-a90c-423f-8a58-9ef05a3db1dd@rock-chips.com>

On Fri, Nov 14, 2025 at 05:16:21PM +0800, Shawn Lin wrote:
> Don't worry, it's helpful, so I think Ye could have a look.
> May I ask if the failure only happened to one specific board?

Hi Shawn,

Yes, testing is restricted to my Radxa Rock Pi N10 board.

> 
> Another thing I noticed is about one commit:
> 114b06ee108c ("PCI: rockchip: Set Target Link Speed to 5.0 GT/s before 
> retraining")
> 
> It said: "Rockchip controllers can support up to 5.0 GT/s link speed."
> But we issued an errata long time ago to announced it doesn't, you could
> also check the PCIe part of RK3399 datasheet:
> https://opensource.rock-chips.com/images/d/d7/Rockchip_RK3399_Datasheet_V2.1-20200323.pdf

OK, I'm partly responsible for that as author of the commit in question.

First off let me say I do not intend to send any patches setting
max-link-speed to TWO for this platform.

I understand you issued an erratum, but are you absolutely sure about
that erratum? Because my testing shows otherwise:

---
With max-link-speed = <2>
pci 0000:01:00.0: 16.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x4 link at 0000:00:00.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)

/dev/nvme0n1:
 Timing cached reads:   3002 MB in  2.00 seconds = 1502.21 MB/sec
 Timing buffered disk reads: 2044 MB in  3.00 seconds = 680.79 MB/sec
---
With max-link-speed = <1>
pci 0000:01:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:00.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)

/dev/nvme0n1:
 Timing cached reads:   2730 MB in  2.00 seconds = 1366.15 MB/sec
 Timing buffered disk reads: 2028 MB in  3.00 seconds = 675.71 MB/sec
---

As you can see, not only the kernel PCI driver recognizes 5.0 GT/s PCIe
link but there's even a marginal increase in cached reads as measured by
hdparm, the gains are of course limited by CPU performance.

> Also we set max-link-speed to ONE in rk3399-base.dtsi but seems another
> patch slip in: 755fff528b1b ("arm64: dts: rockchip: add variables for 
> pcie completion to helios64")

I can't speak for patches I haven't authored, but I believe you're
welcome to send a correction.

Thank you,
Geraldo Nascimento

