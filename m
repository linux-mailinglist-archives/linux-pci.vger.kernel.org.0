Return-Path: <linux-pci+bounces-27395-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 717E0AAEC64
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 21:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8BE27B6A6D
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 19:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D4128E5E1;
	Wed,  7 May 2025 19:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPlzZc0V"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AC719CC0A;
	Wed,  7 May 2025 19:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746647094; cv=none; b=DfPk902Xcbbmkobr/2d9ObOeLQgshaqd6mYlL/7as1iuogfG5qpTRpzH1z6utp6M+oRD4YGXY+wH1VtUBqBAJSsgc86i7PmezAXNW6s+YJ8FXGfem+kWe8hU8yxYnE6n03veRZ4fF0bnNE9mC1QVSnzLv4odl7emBJ/QjaYd50o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746647094; c=relaxed/simple;
	bh=q4hIvtoNu1oOGcAKyK/6LoLwv0LjCdfMt4xNiihRoZs=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=erNPT2NAmtzPrNhQpD2OvoY1hShV81fUCRUaVXn2XuY+5RuxIG2C7VdEwso4SnMGArH57eoM/uKYMn7i8BIS/keuY3jKzCb/Oj5HPLFl5jlpPV5nghTFbDCle35G4UjjuS3HHWR9wT5HaXvXa69fWa8e0RGQa5uO+d5j9A+l9u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPlzZc0V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B39BC4CEE2;
	Wed,  7 May 2025 19:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746647092;
	bh=q4hIvtoNu1oOGcAKyK/6LoLwv0LjCdfMt4xNiihRoZs=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=qPlzZc0VbmcBh/IBRlviaOz38xt5NO496/SGC3ggUSWMOx+oBrVl2jObCeavNvfQ+
	 R2Yi7Nlm9rfbJgoaXwyCKj2+ORCv6v0HaZJ0vqGuwN7Es/6uNpXxzd6A98Oqag6/4Q
	 KLKfNStxTE+v7NgktYd/xEvLRGaIYYxg8sv8f65ld+ldjyPrDGSxRLJDlxz/jXV73e
	 fgZWLjaXcVfUI2r95d5TaZJEvSNNaR5PzP6cwA0c9orH+RhqEOdelSyuxSVp3PCvp2
	 O4B+hWoqwNALx3co7BWGW3jVCf/SnTxgH2PwTHEn19aVaECO8D2/8vMdJ6+gFGt4gf
	 D5t4O/WiNTw+g==
Message-ID: <8513c30f597f757a199e4f9a565b0bf5@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aBprHfQ7Afx1cxPe@apocalypse>
References: <cover.1745347417.git.andrea.porta@suse.com> <e8a9c2cd6b4b2af8038048cda179ebbf70891ba7.1745347417.git.andrea.porta@suse.com> <aBprHfQ7Afx1cxPe@apocalypse>
Subject: Re: [PATCH v9 -next 04/12] clk: rp1: Add support for clocks provided by RP1
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof Wilczynski <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org, Masahiro
  Yamada <masahiroy@kernel.org>, Stefan Wahren <wahrenst@gmx.net>, Herve Codina <herve.codina@bootlin.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, Phil Elwell <phil@raspberrypi.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>, kernel-list@raspberrypi.com, Matthias Brugger <mbrugger@suse.com>
To: Andrea della Porta <andrea.porta@suse.com>
Date: Wed, 07 May 2025 12:44:50 -0700
User-Agent: alot/0.12.dev8+g17a99a841c4b

Quoting Andrea della Porta (2025-05-06 13:03:41)
> Hi Stephen,
>=20
> On 20:53 Tue 22 Apr     , Andrea della Porta wrote:
> > RaspberryPi RP1 is an MFD providing, among other peripherals, several
> > clock generators and PLLs that drives the sub-peripherals.
> > Add the driver to support the clock providers.
>=20
> Since subsequent patches in the set depends on this one and as the next
> merge window is approaching, assuming there are no blockers can I kindly =
ask
> if you can merge it on your tree for the upcoming pull request?
>=20
> This patch should apply cleanly to your clk-next branch except for some f=
uzz
> lines on MAINTAINERS. Please let me know if you want me to adjust it.
>=20

I need to take the dt-binding header as well so it compiles. What's the
plan there? Do you want me to provide a branch with the clk driver and
binding header? Or do you want to send a PR to clk tree with the clk
driver and the binding header and then base your DTS patches on the
binding header and send that to the soc maintainers? I'm also happy to
give a Reviewed-by tag if that works for you and then you can just take
it through the soc tree.

