Return-Path: <linux-pci+bounces-29934-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EFAADD0B5
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 16:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22675188AC00
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 14:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EBC21C179;
	Tue, 17 Jun 2025 14:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2+LJqlx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C372EF653;
	Tue, 17 Jun 2025 14:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750171906; cv=none; b=ulPDby9HCxvJTbXoFsw2L6d3cZgoUDw+5Ez7QCI2+mkabRk4Az5Wnjwgf/eqw44cE9xHQp0Ap2HGtg5qHTZ/zu9ngTwz1CrUb81ZEuLFTZ0PQ8gXQnWsl++Js7gO6wvMRllhVCapD3+Oq2iLv4SIg/44yN3udA4ud/kYtf5jobc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750171906; c=relaxed/simple;
	bh=GJNDpDkdKnWwO964hGEn7dPszcj2MajR6OvVee6Hb1o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=T5VOZwHiPtPc2MpWclNBGByE/f+fdcBToxoGFScrtZ8ZJ2lVxZlaXdjElbM3/QsransM4V0B12ymJutCeYH6ewAGDoZbU+E4+5FU1OY5LfHNKBQCvwxnuPyvZZzQn7CWhC2pckCsX1YgEqx5s2/LeQmM/BjqJKmBMUoKvsOYnoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2+LJqlx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF6EC4CEE3;
	Tue, 17 Jun 2025 14:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750171906;
	bh=GJNDpDkdKnWwO964hGEn7dPszcj2MajR6OvVee6Hb1o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Z2+LJqlx6+TL/hZHm8WCskW3k2OV7kpcNCs02+3FZQFT09KQ8TJU3zto91XJ+DyEq
	 /z/1HcGzaeoptb5J2eo2eIBP1CkROT1/0SuZW74f55fEybTsVTIsF9Kr4NSDPf6oEz
	 oxyGbN6RUfnxd1apQerveF99Mt7FaIifoK7VnV0Ic803vdpspcb5VlalWI0JaXMCbo
	 mm8fU076psXpF1DAbIx94NXo8gSq0eWYe//4sEuGwCLi1Uid0UGjtXdR03tScpHa4j
	 s9I5TTvL2fLecj9y89qIvyrhifu9krBxJMMCDQyulGp2DcYqgLVTlycV4nlBKcCOof
	 7842kN3i4S7kw==
Date: Tue, 17 Jun 2025 09:51:44 -0500
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
	kernel-list@raspberrypi.com, Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH stblinux/next 2/2] clk: rp1: Implement ramaining clock
 tree
Message-ID: <20250617145144.GA1135520@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b70b9f2d50e3155509c2672e6779c0840f38ad5e.1750165398.git.andrea.porta@suse.com>

On Tue, Jun 17, 2025 at 03:10:27PM +0200, Andrea della Porta wrote:
> The RP1 clock generator driver currently defines only the fundamental
> clocks such as the front PLLs for system, audio and video subsystems
> and the ethernet clock.
> 
> Add the remaining clocks to the tree so as to be completed.

In subject, s/ramaining/remaining/

I guess we actually get some functional benefit here (something that
previously did not work, will start working after this patch)?  It
would be good to mention that here.  "Completing the tree" sounds
nice, but if I were being asked to merge this, I'd like to know what
benefit it brings.

Bjorn

