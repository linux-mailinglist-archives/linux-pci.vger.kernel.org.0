Return-Path: <linux-pci+bounces-34227-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6649B2B44A
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 01:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91692A0B29
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 23:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6411F221FBF;
	Mon, 18 Aug 2025 23:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blwLuBx1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AF91DDC2C;
	Mon, 18 Aug 2025 23:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755558402; cv=none; b=kqvJ2fRLnSKGdRYeB581ttXM0jo0dyBPOyOH4GQCmt4Zg04Uz1jTwBWmZgtu/bZJls4b/zvUnngmt2Gq1eBgVUZosNy9wDHYAhFB5Ry2ibf6I6kikwlZBDZaHvfwxhprwLSZRJnIngLpuiZBkcrhJDDtyXL2RrmRnquSkMwDY1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755558402; c=relaxed/simple;
	bh=FEJffBBO1GLCjVFd+vVCwbbTg5k2KIInXnhfagOBwMs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WWVNs1ly7UItk9bDj/cBAm7rGrew8Q80i6QY2LtlKqWz9xZfB87eQe7n1mY9Xj1AHtI/ILnr68ZSxUwxT9A/Kb9q3aIM3zOavv6hEk83wESdmT4gFTdp9mS+iVfuPAi1F3prpZ+Y20elsKDZwOi1ed5RYxZ0YSkAlrXNU+I1eo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blwLuBx1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7603C4CEEB;
	Mon, 18 Aug 2025 23:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755558402;
	bh=FEJffBBO1GLCjVFd+vVCwbbTg5k2KIInXnhfagOBwMs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=blwLuBx1g4adfeKGLh3pBnCLg9iEbXEvSOMPLrSmWNuooAFkAtZyO4IB66/G79Emr
	 wFY5JUW6IO22P30f9reCRQEXOScadGZpvELaHJl6J1ddMfYSHZRKHfv9VbTCeMxxPM
	 nhEj2d7FoAD9WuQzpAP2IZQvBLDdFtUCJ/e1SrahHsiUy4sZ3W2Pr8DoilPM6xwng8
	 xPFcMmmcfF4gY0Br1MYl0yFfp2Io+lTINebmUgCaQcADnEb5OO3UjgXQd5sKlbSS2a
	 jULfiSAnXYHHpuP+IxZwKm5kY0/lzMO7fDd2FEIHgHZhLWt4kt7AspAopU7vjB3N3u
	 CkqzjyqjPGZKw==
Date: Mon, 18 Aug 2025 18:06:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, p.zabel@pengutronix.de,
	johan+linaro@kernel.org, cassel@kernel.org, shradha.t@samsung.com,
	thippeswamy.havalige@amd.com, quic_schintav@quicinc.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v12 2/9] PCI: stm32: Add PCIe host support for STM32MP25
Message-ID: <20250818230640.GA560877@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <917c9323-9c0c-406f-a314-a6e4a5511b45@foss.st.com>

[+cc Linus]

On Mon, Aug 18, 2025 at 12:50:19PM +0200, Christian Bruel wrote:
> On 8/13/25 21:29, Bjorn Helgaas wrote:
> > On Tue, Jun 10, 2025 at 11:07:07AM +0200, Christian Bruel wrote:
> > > Add driver for the STM32MP25 SoC PCIe Gen1 2.5 GT/s and Gen2 5GT/s
> > > controller based on the DesignWare PCIe core.
> > > ...

> > > +static int stm32_pcie_resume_noirq(struct device *dev)
> > > +{
> > > +	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
> > > +	int ret;
> > > +
> > > +	/*
> > > +	 * The core clock is gated with CLKREQ# from the COMBOPHY REFCLK,
> > > +	 * thus if no device is present, must force it low with an init pinmux
> > > +	 * to be able to access the DBI registers.
> > 
> > What happens on initial probe if no device is present?  I assume we
> > access DBI registers in the dw_pcie_host_init() path, and it seems
> > like we'd have the same issue with DBI not being accessible when no
> > device is present.
> 
> Correct, same issue. The magic happens with the PINCTRL init state that is
> automatically called before probe. As I tried to explain in the
> Documentation in the pinctrl patch:
> 
> - if ``init`` and ``default`` are defined in the device tree, the "init"
>   state is selected before the driver probe and the "default" state is
>   selected after the driver probe.

OK, thanks for that reminder!

The fact that the pinctrl init state is set implicitly before .probe(),
but we have to do it explicitly in .stm32_pcie_resume_noirq() seems a
*little* bit weird and makes the driver harder to review.  But ... I
guess that's out of scope for this series.

I see that Linus has given his approval to merge the new
pinctrl_pm_select_init_state() along with this series.  Would you mind
pulling those changes [1] and the use [2] into a v13 of this series?
That way I won't have to collect up all the pieces and risk missing
something.

BTW, I noticed a s/platformm/platform/ typo in the "[PATCH v1 2/2]
pinctrl: Add pinctrl_pm_select_init_state helper function" patch.

> > > +	if (!IS_ERR(dev->pins->init_state))
> > > +		ret = pinctrl_select_state(dev->pins->p, dev->pins->init_state);
> > > +	else
> > > +		ret = pinctrl_pm_select_default_state(dev);
> > > +
> > > +	if (ret) {
> > > +		dev_err(dev, "Failed to activate pinctrl pm state: %d\n", ret);
> > > +		return ret;
> > > +	}

> > > +static int stm32_add_pcie_port(struct stm32_pcie *stm32_pcie)
> > > +{
> > > +	struct device *dev = stm32_pcie->pci.dev;
> > > +	unsigned int wake_irq;
> > > +	int ret;
> > > +
> > > +	/* Start to enable resources with PERST# asserted */
> > 
> > I guess if device tree doesn't describe PERST#, we assume PERST# is
> > actually *deasserted* already at this point (because
> > stm32_pcie_deassert_perst() does nothing other than the delay)?
> 
> yes, this also implies that PV is stable

Maybe we could update the comment somehow?  Or maybe even just remove
it, since we actually don't know the state of PERST# at this point?

It sounds like we don't know the PERST# state until after we call
stm32_pcie_deassert_perst() below.

> > > +	ret = phy_set_mode(stm32_pcie->phy, PHY_MODE_PCIE);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = phy_init(stm32_pcie->phy);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
> > > +				 STM32MP25_PCIECR_TYPE_MASK,
> > > +				 STM32MP25_PCIECR_RC);
> > > +	if (ret)
> > > +		goto err_phy_exit;
> > > +
> > > +	stm32_pcie_deassert_perst(stm32_pcie);

Bjorn

[1] https://lore.kernel.org/r/20250813081139.93201-1-christian.bruel@foss.st.com
[2] https://lore.kernel.org/r/20250813115319.212721-1-christian.bruel@foss.st.com


