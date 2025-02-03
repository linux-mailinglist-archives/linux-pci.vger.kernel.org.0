Return-Path: <linux-pci+bounces-20678-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DA9A267FA
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 00:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F7F37A1E55
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 23:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DA7211475;
	Mon,  3 Feb 2025 23:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2XgL4fp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066011FFC58;
	Mon,  3 Feb 2025 23:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738626286; cv=none; b=U5+DmBL+8QvB6HlaBcZbH/rwHElC1k25b7zCO7TpB2mTSjjfv0AQ5xFSJE13+MBYJPZnZrqGrjfJ1ulbwBzoFuTagyVesd0pY29+yU5RhCUfOCQpQdzhZ4UHcBJ/t8v0gw+8z25ypqcc5+FrjVIzsTzdEtkXiDChB4aFIp6/GbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738626286; c=relaxed/simple;
	bh=v+AuDIgJ0k5UvEy9luF0KK3FYg1kQKwaER5D0fle/no=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HrYxnhfQt/AaWyTa670eLAQ1DqmXtclqNuiDvcbJhAA2bCj7UEN93/gkRq415LwFI7c3UMt/IbbgesFKE0IAuMpLqdTR8+ljDTddsVYjxWFhzHFMaXFc0j/skUFiK0Xy1/DMeLv30Umla68cGaYC3YZ4vPmBDZSYHJ+fdqdgagY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2XgL4fp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C69AC4CEE0;
	Mon,  3 Feb 2025 23:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738626285;
	bh=v+AuDIgJ0k5UvEy9luF0KK3FYg1kQKwaER5D0fle/no=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=U2XgL4fpLohrYMGFQsDpDmoiPq6PrVe58w/FVxQ1fSm6Umxk/MnowFc4T+9SDrFJ4
	 mcrvcRiXNn8XAyBuXP6FdT/090h2HmDh+4AsGf+/H8UIx403WZM75wXVaMTu7Lg3Mk
	 f10mFaCI98UMvtWTqWCyi2/t1D3fAesnYY+vDIj7be9yqMpr58hdzQVh+y90LdjZ5K
	 E0E+8eTLfmvHVDd/8Ye4KIa/wmqM5KZpeEvhhawF5g1ZOULtfi6dgqFk0SfZU03wfP
	 1ChFA5M2zxRLWUNuMBOXLINQZLiRZDQBluRBFZHdHZbDsGoqztoJE8eidGzWW2NiBT
	 IBmBMulY3HlhQ==
Date: Mon, 3 Feb 2025 17:44:43 -0600
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
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v6 05/10] clk: rp1: Add support for clocks provided by RP1
Message-ID: <20250203234443.GA810409@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b12caa1c8c674a56afa7b2de780d9ae5423159a3.1736776658.git.andrea.porta@suse.com>

On Mon, Jan 13, 2025 at 03:58:04PM +0100, Andrea della Porta wrote:
> RaspberryPi RP1 is an MFD providing, among other peripherals, several
> clock generators and PLLs that drives the sub-peripherals.
> Add the driver to support the clock providers.

> +#define PLL_PRIM_DIV1_SHIFT		16
> +#define PLL_PRIM_DIV1_WIDTH		3
> +#define PLL_PRIM_DIV1_MASK		GENMASK(PLL_PRIM_DIV1_SHIFT + \
> +						PLL_PRIM_DIV1_WIDTH - 1, \
> +						PLL_PRIM_DIV1_SHIFT)
> +
> +#define PLL_PRIM_DIV2_SHIFT          12
> +#define PLL_PRIM_DIV2_WIDTH          3
> +#define PLL_PRIM_DIV2_MASK           GENMASK(PLL_PRIM_DIV2_SHIFT + \
> +                                             PLL_PRIM_DIV2_WIDTH - 1, \
> +                                             PLL_PRIM_DIV2_SHIFT)

Maybe this is standard drivers/clk style, but this seems like overkill
to me.  I think this would be sufficient and easier to read:

  #define PLL_PRIM_DIV1_MASK   GENMASK(18, 16)
  #define PLL_PRIM_DIV2_MASK   GENMASK(14, 12)

> +static unsigned long rp1_pll_recalc_rate(struct clk_hw *hw,
> +					 unsigned long parent_rate)
> +{
> +	struct rp1_clk_desc *pll = container_of(hw, struct rp1_clk_desc, hw);
> +	struct rp1_clockman *clockman = pll->clockman;
> +	const struct rp1_pll_data *data = pll->data;
> +	u32 prim, prim_div1, prim_div2;
> +
> +	prim = clockman_read(clockman, data->ctrl_reg);
> +	prim_div1 = (prim & PLL_PRIM_DIV1_MASK) >> PLL_PRIM_DIV1_SHIFT;
> +	prim_div2 = (prim & PLL_PRIM_DIV2_MASK) >> PLL_PRIM_DIV2_SHIFT;

And then here, I think you can just use FIELD_GET():

  prim_div1 = FIELD_GET(PLL_PRIM_DIV1_MASK, prim);
  prim_div2 = FIELD_GET(PLL_PRIM_DIV2_MASK, prim);

It looks like the same could be done for PLL_SEC_DIV_MASK,
PLL_CS_REFDIV_SHIFT, PLL_PH_PHASE_SHIFT, CLK_CTRL_AUXSRC_MASK, etc.

