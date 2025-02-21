Return-Path: <linux-pci+bounces-22038-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6F6A4020E
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 22:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC463170A04
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 21:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C5F20896C;
	Fri, 21 Feb 2025 21:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pI+OqPw3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE5C1BC09A;
	Fri, 21 Feb 2025 21:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740173593; cv=none; b=EqnhmrFZumEP1WzFC65BevlTIW9LwuEXjA1+XrmbxAOoB164gM0CR1tSbTdknwuiOtabmdjkx1dJBg216vj1v1a1I/eUZQGQCvWx5YrLJ+CAKpbSq3+E2ZZ4kTsy7SOMZI2jdEr8dOxtPBdzvl4CTPgh1QKPtfxDLDsFQNtZ+ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740173593; c=relaxed/simple;
	bh=YguojFeZQ1Lx0oD73VLf2qvbtWuaYfQHYVhFNJxGqcc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=V2TFy3hn91uAArvnYQHuFHYDXOaRdUToupKSjPz55C3Wiyeiuwzo6Kz+IR8S7bkOzpDyTrLR98ezZLynN7FT/YGJdtM3y4Xkuj4OzUUGuI3r88bGVjle+F2D8/yJ00drtMbLUymWoWwPaymqKWIaoGZkFCt+eyM4/efY9dqgLLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pI+OqPw3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8B4C4CED6;
	Fri, 21 Feb 2025 21:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740173593;
	bh=YguojFeZQ1Lx0oD73VLf2qvbtWuaYfQHYVhFNJxGqcc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pI+OqPw3S1f4uPK/qsVZPlTlFkJWoXXV7COQC0U7sscNezGrsRxoHQ7/xOeYHDSev
	 Ypy/37X2kBbp8bKR0BpV/ndXbZBx4msKzDlYpvA/spRVQvSl7M8QkclZuW5CbNxIsT
	 fx4Xoe43a7Eg41JFcEXylnOFiG9MAojydrpN8PIAnbRmPBC1rlagN3UaI4VTNIBMp6
	 bzQKQhU/o9jw8wTKTlYBf7PgQScsDlbsfd29giuk+Nklsj2dHc63joYmTUXUMkzeZJ
	 WaKcwOS/8GOzvUSQYXRYDGv4r7SZB3pnHLj0xPbOC+cqft1mVBhEBaj7MJyrjJk4eB
	 6d0fuZiT53IKw==
Date: Fri, 21 Feb 2025 15:33:11 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v5 -next 07/11] PCI: brcmstb: Adjust PHY PLL setup to use
 a 54MHz input refclk
Message-ID: <20250221213311.GA362736@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120130119.671119-8-svarbanov@suse.de>

On Mon, Jan 20, 2025 at 03:01:15PM +0200, Stanimir Varbanov wrote:
> The default input reference clock for the PHY PLL is 100Mhz, except for
> some devices where it is 54Mhz like bcm2712C1 and bcm2712D0.
> 
> To implement this adjustments introduce a new .post_setup op in
> pcie_cfg_data and call it at the end of brcm_pcie_setup function.
> 
> The bcm2712 .post_setup callback implements the required MDIO writes that
> switch the PLL refclk and also change PHY PM clock period.
> 
> Without this RPi5 PCIex1 is unable to enumerate endpoint devices on
> the expansion connector.

This makes it sound like this patch should be reordered before "[PATCH
v5 -next 06/11] PCI: brcmstb: Add bcm2712 support".

We don't really want a driver to claim a bcm2712 controller before
it's able to enumerate devices, because that would break bisection
through this.

Bjorn

