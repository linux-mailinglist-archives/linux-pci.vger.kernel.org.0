Return-Path: <linux-pci+bounces-26045-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C977A90C53
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 21:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A2F116F238
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 19:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6925A224AE8;
	Wed, 16 Apr 2025 19:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jm7ONVrF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3543A28373;
	Wed, 16 Apr 2025 19:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744831747; cv=none; b=j5fGOgnDrbpljwAsw9YCcHy1BbXlyiiy1ZOHEXFwxpHTonRnkx/Y2/qBzZj7JY1ddcU6XhSXPOKdm3NfMrLTeEtKcfMJ1+XOwku/KkmaBN94I5KTO8uduaU1IQOsSfHLoNdteEsrqOx72I1VKhDkPGQ5jzjk2wAAX+jQDUAgPXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744831747; c=relaxed/simple;
	bh=sLL3Rk04mgf4fJSpP8L0B5HUGnIWGNmLFxz9gyU48tg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jjrOONHYV2u4AL+LRoUsdxTv+QN4DEO/SjqsHn+LX0YAa3V1b8WDj4Ricr5rnA2M+OZvlbs2utiLNpr1XzOqHkJ4e+ZDdFWW5aJx+Gp9gL1zksfPXHbVzsJEF9voegGurIrF55rB0oylYvM6FzVrmz63SEU123W/DWNJnqLPazY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jm7ONVrF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C10C4CEE2;
	Wed, 16 Apr 2025 19:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744831746;
	bh=sLL3Rk04mgf4fJSpP8L0B5HUGnIWGNmLFxz9gyU48tg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Jm7ONVrFXm90RmgYMNYqOQxFXK+iVgTyH2ydbIvPHFYjBI0WtvLmNjQNdwnAlRtk6
	 yuNLpqUtcgxIBMDZWIj595dApop2VZd0Ry5WnkDss1TWn48Xe82tJnBXdBlQHjOqki
	 s03LJr+6CS/XOpoQLEy6LSm3S4dDF40ayMzomUqhYhHqYMtYw91j951vSMo5WkYWkh
	 FU+KAUjzczFCj9CXWchFtxjb6PqJuT1PnBVQJciCITE5OPzJWTjZrmn5hMbwTXjhTU
	 hiNCOQs6s4/JRALCiYNu0ox0k6AoLPuZms6yNfzq42ItXcwBUYU7bZJ66ljqsrx7o3
	 DDqpk6FI2BWRw==
Date: Wed, 16 Apr 2025 14:29:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>, Phil Elwell <phil@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	kernel-list@raspberrypi.com
Subject: Re: [PATCH v8 07/13] arm64: dts: rp1: Add support for RaspberryPi's
 RP1 device
Message-ID: <20250416192905.GA78240@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99269f7762ec0124315e0e8977d9ca4f469f89ce.1742418429.git.andrea.porta@suse.com>

On Wed, Mar 19, 2025 at 10:52:28PM +0100, Andrea della Porta wrote:
> RaspberryPi RP1 is a multi function PCI endpoint device that
> exposes several subperipherals via PCI BAR.
> Add a dtb overlay that will be compiled into a binary blob
> and linked in the RP1 driver.
> This overlay offers just minimal support to represent the
> RP1 device itself, the sub-peripherals will be added by
> future patches.

Would be nice to have a blank line between paragraphs.

