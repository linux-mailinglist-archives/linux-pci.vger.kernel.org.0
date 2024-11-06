Return-Path: <linux-pci+bounces-16179-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0209BFA1B
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 00:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEFF61C2106E
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 23:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0D1168BD;
	Wed,  6 Nov 2024 23:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCgtgnXS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17451DD525;
	Wed,  6 Nov 2024 23:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730935885; cv=none; b=hVodPhMS4jqFey/85jodeg9BLn1yqHjNsuHvZVOFd/2bRf9GXRL1MUK73vxt2ZgYQQxYRd5J8MmgKeJEU4qIYgwW9vn2QrSyqnt2lt0mGyDo85acB+eaMEjXzyN9Q02URRZ4fg8kXcN3w2vxPi5ufnQRVQOV6Uv2pglmmY7V7ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730935885; c=relaxed/simple;
	bh=+oR0lbPCxYDktvmqYyECp9ARZ9ditH6+Br5Ol+YacvE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OEX1LkpgbzIfuP5iwB5M/0NYN7gaRnLKRbeWylvEc4t9BWE5bZcaP3U/WcMwKR8x9bTx9oX/gU31rHBX7rvcepICeOF7R0Hd2moEZ9NBEtM8VvjcGdjWpKxpXHMC5/VFcgBpzCXj/qD1wsrTiX8zFOE8God3DXfgIn9qbOzfsUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCgtgnXS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1246CC4CEC6;
	Wed,  6 Nov 2024 23:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730935885;
	bh=+oR0lbPCxYDktvmqYyECp9ARZ9ditH6+Br5Ol+YacvE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LCgtgnXS34KEat08WBk8VotJAgkfFpyDt5i9Kouaaf6tnp9SHAgfDj0KqqL2yJTDh
	 lerVJDtrdpB5Ycw//ZLmMjPqQi+eAcKj7FZlcnBor6fq+3bR87ouHP/72UDCXf3M+l
	 0Ule8IdT/y6HHNlAmx+T0+2MXGOoIPpUMhfmL6jY8g10pQWMo0KgTZOYTOqyVV+nT0
	 CDMgjNkdPuNMctOMPxJSq4ubzD2Mp8jVHLp9qY/5mo+QjL4i5L9Fjt0Ku3fEskl18P
	 2cliTAd14yWndNICp5mNbQcjy5B3MG1l3RRs6/pHZXPz1i9x7TXMomJOvL8sJhuJD1
	 Gp64oydk5Nicg==
Date: Wed, 6 Nov 2024 17:31:23 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-pci@vger.kernel.org, ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com,
	linux-mediatek@lists.infradead.org, lorenzo.bianconi83@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
	nbd@nbd.name, dd@embedd.com, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH v4 4/4] PCI: mediatek-gen3: Add Airoha EN7581 support
Message-ID: <20241106233123.GA1580663@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyvwXHMRz0kI0J5O@lore-desk>

On Wed, Nov 06, 2024 at 11:40:28PM +0100, Lorenzo Bianconi wrote:
> > On Wed, Jul 03, 2024 at 06:12:44PM +0200, Lorenzo Bianconi wrote:
> > > Introduce support for Airoha EN7581 PCIe controller to mediatek-gen3
> > > PCIe controller driver.
> > > ...
> > 
> > > +static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
> > > +{
> > > +	struct device *dev = pcie->dev;
> > > +	int err;
> > > +	u32 val;
> > > +
> > > +	/*
> > > +	 * Wait for the time needed to complete the bulk assert in
> > > +	 * mtk_pcie_setup for EN7581 SoC.
> > > +	 */
> > > +	mdelay(PCIE_EN7581_RESET_TIME_MS);
> 
> > It looks wrong to me to do the assert and deassert in different
> > places:
> > 
> >   mtk_pcie_setup
> >     reset_control_bulk_assert(pcie->phy_resets)        <--
> >     mtk_pcie_en7581_power_up
> >       mdelay(PCIE_EN7581_RESET_TIME_MS)
> >       reset_control_bulk_deassert(pcie->phy_resets)    <--
> >       mdelay(PCIE_EN7581_RESET_TIME_MS)
> > 
> > That makes the code hard to understand.
> 
> The phy reset line was already asserted running reset_control_assert() in
> mtk_pcie_setup() and de-asserted running reset_control_deassert() in
> mtk_pcie_power_up() before adding EN7581 support. Moreover, EN7581 requires
> to run phy_init()/phy_power_on() before de-asserting the phy reset lines.
> I guess I can add a comment to make it more clear. Agree?

I assume the first deassert(phy_resets) in mtk_pcie_setup() is not
paired with anything in this driver.

I think it would be better to pair the other assert/deasserts in the
same functions like the below.  Then it's easy to see the matching.

While looking at this, I noticed that we assert(mac_reset) in
mtk_pcie_setup(), but it's never deasserted for EN7581.

  mtk_pcie_setup
    reset_control_bulk_deassert(phy_resets)
    mtk_pcie_en7581_power_up
      reset_control_bulk_assert(phy_resets)  # move here
      reset_control_assert(mac_reset)        # move here
      mdelay(PCIE_EN7581_RESET_TIME_MS)
      phy_init
      phy_power_on
      reset_control_deassert(mac_reset)      # add; seems missing?
      reset_control_bulk_deassert(phy_resets)
      mdelay(PCIE_EN7581_RESET_TIME_MS)

  mtk_pcie_setup
    reset_control_bulk_deassert(phy_resets)
    mtk_pcie_power_up
      reset_control_bulk_assert(phy_resets)  # move here
      reset_control_assert(mac_reset)        # move here
      reset_control_bulk_deassert(phy_resets)
      phy_init
      phy_power_on
      reset_control_deassert(mac_reset)

> > > +	err = phy_init(pcie->phy);
> > > +	if (err) {
> > > +		dev_err(dev, "failed to initialize PHY\n");
> > > +		return err;
> > > +	}
> > > +
> > > +	err = phy_power_on(pcie->phy);
> > > +	if (err) {
> > > +		dev_err(dev, "failed to power on PHY\n");
> > > +		goto err_phy_on;
> > > +	}
> > > +
> > > +	err = reset_control_bulk_deassert(pcie->soc->phy_resets.num_resets, pcie->phy_resets);
> > > +	if (err) {
> > > +		dev_err(dev, "failed to deassert PHYs\n");
> > > +		goto err_phy_deassert;
> > > +	}
> > > +
> > > +	/*
> > > +	 * Wait for the time needed to complete the bulk de-assert above.
> > > +	 * This time is specific for EN7581 SoC.
> > > +	 */
> > > +	mdelay(PCIE_EN7581_RESET_TIME_MS);
> > > +
> > > +	pm_runtime_enable(dev);
> > > +	pm_runtime_get_sync(dev);
> > > +
> > 
> > > +	err = clk_bulk_prepare(pcie->num_clks, pcie->clks);
> > > +	if (err) {
> > > +		dev_err(dev, "failed to prepare clock\n");
> > > +		goto err_clk_prepare;
> > > +	}
> > > +
> > > +	val = FIELD_PREP(PCIE_VAL_LN0_DOWNSTREAM, 0x47) |
> > > +	      FIELD_PREP(PCIE_VAL_LN1_DOWNSTREAM, 0x47) |
> > > +	      FIELD_PREP(PCIE_VAL_LN0_UPSTREAM, 0x41) |
> > > +	      FIELD_PREP(PCIE_VAL_LN1_UPSTREAM, 0x41);
> > > +	writel_relaxed(val, pcie->base + PCIE_EQ_PRESET_01_REG);
> > > +
> > > +	val = PCIE_K_PHYPARAM_QUERY | PCIE_K_QUERY_TIMEOUT |
> > > +	      FIELD_PREP(PCIE_K_PRESET_TO_USE_16G, 0x80) |
> > > +	      FIELD_PREP(PCIE_K_PRESET_TO_USE, 0x2) |
> > > +	      FIELD_PREP(PCIE_K_FINETUNE_MAX, 0xf);
> > > +	writel_relaxed(val, pcie->base + PCIE_PIPE4_PIE8_REG);
> > 
> > Why is this equalization stuff in the middle between
> > clk_bulk_prepare() and clk_bulk_enable()?  Is the split an actual
> > requirement, or could we use clk_bulk_prepare_enable() here, like we
> > do in mtk_pcie_power_up()?
> 
> Nope, we can replace clk_bulk_enable() with clk_bulk_prepare_enable() and
> remove clk_bulk_prepare() in mtk_pcie_en7581_power_up() since we actually
> implements just enable callback for EN7581 in clk-en7523.c.
> 
> > If the split is required, a comment about why would be helpful.
> > 
> > > +	err = clk_bulk_enable(pcie->num_clks, pcie->clks);
> > > +	if (err) {
> > > +		dev_err(dev, "failed to prepare clock\n");
> > > +		goto err_clk_enable;
> > > +	}
> > 
> > Per https://lore.kernel.org/r/ZypgYOn7dcYIoW4i@lore-desk,
> > REG_PCI_CONTROL is asserted/deasserted here by en7581_pci_enable().
> 
> correct
> 
> > Is this where PERST# is asserted?  If so, a comment to that effect
> > would be helpful.  Where is PERST# deasserted?  Where are the required
> > delays before deassert done?
> 
> I can add a comment in en7581_pci_enable() describing the PERST issue for
> EN7581. Please note we have a 250ms delay in en7581_pci_enable() after
> configuring REG_PCI_CONTROL register.
> 
> https://github.com/torvalds/linux/blob/master/drivers/clk/clk-en7523.c#L396

Does that 250ms delay correspond to a PCIe mandatory delay, e.g.,
something like PCIE_T_PVPERL_MS?  I think it would be nice to have the
required PCI delays in this driver if possible so it's easy to verify
that they are all covered.

Bjorn

