Return-Path: <linux-pci+bounces-30466-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6306AE57BF
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 01:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEBBE44592D
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 23:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BBD22A7E8;
	Mon, 23 Jun 2025 23:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMx7Wr4f"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D927229B16;
	Mon, 23 Jun 2025 23:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750720489; cv=none; b=cqQdnTORY9devEwbqKWJvPBhq05/8I8aBYiYSPeHrZugQ3fw39I7/54z3nXjzG3yBV2/mz99gHlL5NafUSWrSAl70PtBYbEIHr4QSSmjrbw8KWvPjVGNs/OFcYbBB4LRJELmQdUNnyyRB4M2p5Tc+oZf9tzEFm3zTo8a0Fy+7fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750720489; c=relaxed/simple;
	bh=6LzesJl0kmLg/Yoa6T382QmQxVwEVUfX/TAiShEDAEk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=d0XE20wF3ozcv8vQt4vvCu7MajwhsT3jZUZBkB9dvWvLuhz8/D2TooaTW3S5PpNHWlf/9CAdj/YUmHToP9VZlzCPW3dBCcg2EJiI2fMOGruVCM7vshsvJixVDxiHvmwQrXgb2JAfECukiHQz2QBNZtjZD+BIygXyXI5Dplb+pwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMx7Wr4f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C9BC4CEEA;
	Mon, 23 Jun 2025 23:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750720488;
	bh=6LzesJl0kmLg/Yoa6T382QmQxVwEVUfX/TAiShEDAEk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kMx7Wr4fbnk/OW/YvdljcMwfmBjZhDh0Q/9ALni+SFRZvk8ogsIogtkBFck15xHZs
	 oKelFlmsXQgR7XLJoiMShq98NGyWzsGi7AuplNLuw0GdmkYKB7U4Rxnj+60kW6CDHi
	 W0YJVlA5fFOMFPdnbucDFKkLuR8ILnblAy0jY/4Sc9O1jG7MfuQ3oxjwOYrwAhpMMZ
	 4ALzWQ/bHaLnLeUJqada7xvk/desc+kQCG5Tq8tbdpbxpNb9qk0XliDwBklYtFLk/2
	 FzxBBOzRttdHDDi9xHVtjWYATXb7IrOzaj6ybNDVcb4CLu1oU4tNuFtGpBMu7lbZyf
	 SANU2FJJvYBvw==
Date: Mon, 23 Jun 2025 18:14:47 -0500
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
	kernel-list@raspberrypi.com, Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH v2 stblinux/next 2/2] clk: rp1: Implement remaining clock
 tree
Message-ID: <20250623231447.GA1450188@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17e5c6e0c085cfa0bf4b63b639cdc92c6a4c1418.1750714412.git.andrea.porta@suse.com>

On Mon, Jun 23, 2025 at 11:46:28PM +0200, Andrea della Porta wrote:
> The RP1 clock generator driver currently defines only the fundamental
> clocks such as the front PLLs for system, audio and video subsystems
> and the ethernet clock.
> 
> Add the remaining clocks to the tree so as to be completed, which means
> that the following RP1 peripherals could now consume their specific clocks
> and be enabled to work (provided that the relevant driver changes for each
> specific peripheral, if any, are committed):
> 
> - ADC
> - Audio IN/OUT
> - DMA controller
> - I2S
> - MIPI DPI/DSI
> - PWM
> - SDIO
> - UART
> - Video Encoder

Thanks for this detail, that's exactly what I hoped for!

