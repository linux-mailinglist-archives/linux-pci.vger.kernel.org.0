Return-Path: <linux-pci+bounces-31292-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3424BAF5E73
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 18:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C713B6D07
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 16:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916F52E7BBC;
	Wed,  2 Jul 2025 16:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFslyyS3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEF3137923;
	Wed,  2 Jul 2025 16:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751473334; cv=none; b=dvLvMXYOHbSz2YfS7erTni/qIXvZgxTnooJwKQFlaJqhoNn7UuGSkwaAMQa07zdQUF/uIdGCjSf5KNkdzsCFjLGAESDMIRhmUSJ4AZqfNmYdHAU61wacoQD8x8xCXeviTpYW9kLbgjn5NhFFeKH4a+NJz/wGik01FUgSj3y4dEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751473334; c=relaxed/simple;
	bh=Hfsayn1suRAdKExU2SCJOYW20rvzhbLzUZJDd33jhGs=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:To:
	 Date:Message-ID; b=FLlIwIcgNOGhth6BBTrHd8fDk1OoY6yamxH5UgAMHLfCE7W4dXLZGcLjnZPdinie1cwyrYCJUzQ7uzvfu/TqKYkdmvBGvhSDm4M4Yvo0IRMi/vaMibGK9Ix3+4e4caYL15ydpdP/Keytyy3rMl/mYOvSTQKGLe7o6G9Xwddwa/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFslyyS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF392C4CEE7;
	Wed,  2 Jul 2025 16:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751473334;
	bh=Hfsayn1suRAdKExU2SCJOYW20rvzhbLzUZJDd33jhGs=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=pFslyyS3LTpJJt1LBlZ8liCXxnD9ohZn4e1Bp97jeZRXI0T45dPWirbfLvb2jOT1B
	 UebJ9q/f1bX9/WvKykTVX7VZrMtmOlno6D8yHsjOruEVNtmDXQ91LxQKJ9re6NXHl8
	 rP9bog3oApPfY7sbY3XLyibBR8zqAAkYSvfERWRSp6Bn9tkczQAejx/5lM6I5J6oPZ
	 Z4B5HxPojk/G+F/lgXGbh6rOrkVTsxQEQNIsRWG1eUCA32dngSS8yovG/LXCnrxetg
	 OqsQSBJbbFL2j788cBZN0AL5TyZt/nNZopHi/fgbjH6ACXB3n+hMsw49jS9bevqlC0
	 w+LPb6L2QUBag==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <17e5c6e0c085cfa0bf4b63b639cdc92c6a4c1418.1750714412.git.andrea.porta@suse.com>
References: <c20066500908db854aa4816b40e956296bab526a.1750714412.git.andrea.porta@suse.com> <17e5c6e0c085cfa0bf4b63b639cdc92c6a4c1418.1750714412.git.andrea.porta@suse.com>
Subject: Re: [PATCH v2 stblinux/next 2/2] clk: rp1: Implement remaining clock tree
From: Stephen Boyd <sboyd@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>, Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>, Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, Dave Stevenson <dave.stevenson@raspberrypi.com>, Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>, Florian Fainelli <florian.fainelli@broadcom.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Herve Codina <herve.codina@bootlin.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Krzysztof Wilczynski <kw@linux.com>, Linus Walleij <linus.walleij@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Luca Ceresoli <luca.ceresoli@bootlin.com>, Masahiro Yamada <masahiroy@kernel.org>, Matthias Brugger <mbrugger@suse.com>, Michael Turquette <mturquette@baylibre.com>, Phil Elwell <phil@raspberrypi.com>, Rob Herring <robh@kernel.
 org>, Saravana Kannan <saravanak@google.com>, Stefan Wahren <wahrenst@gmx.net>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, kernel-list@raspberrypi.com, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Date: Wed, 02 Jul 2025 09:22:13 -0700
Message-ID: <175147333319.1004940.14279071596597163164@lazor>
User-Agent: alot/0.11

Quoting Andrea della Porta (2025-06-23 14:46:28)
> The RP1 clock generator driver currently defines only the fundamental
> clocks such as the front PLLs for system, audio and video subsystems
> and the ethernet clock.
>=20
> Add the remaining clocks to the tree so as to be completed, which means
> that the following RP1 peripherals could now consume their specific clocks
> and be enabled to work (provided that the relevant driver changes for each
> specific peripheral, if any, are committed):
>=20
> - ADC
> - Audio IN/OUT
> - DMA controller
> - I2S
> - MIPI DPI/DSI
> - PWM
> - SDIO
> - UART
> - Video Encoder
>=20
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

