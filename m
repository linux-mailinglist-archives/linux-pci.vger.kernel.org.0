Return-Path: <linux-pci+bounces-16167-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CA99BF801
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 21:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6E0FB21F77
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 20:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A6A20C315;
	Wed,  6 Nov 2024 20:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZg0J0eW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FE120C307;
	Wed,  6 Nov 2024 20:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730925141; cv=none; b=LP81ur9lE0SUliMNJU/pCGFjLn3T2DTQdgH9fproofpWKCUNA4G497NKHz9Xy/fLsBDt+cbIPNTMsUuqI+f8gyMv6PtlIs6DhFRNh9gxIEPSTWi/4wNLkFeWAC2D1DkHgx/BNTh5/2X/rQxLHj8RujvEOywiqKQlqHXhBN6b9RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730925141; c=relaxed/simple;
	bh=1Ei0xMRvJVGpNZKZ8Xu5z8oPwa6biKFwhQZaFWCaniQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iQEXL+0ShBkRcMwMxcTnoPlqhPxhw7Tt2SuQ19VzBR9UGphxjTwyPULjCWeRs+aNhBdnWDK0jkDFoX3JiSN5iF+1NofcAYAhiwrkYROrnQI9nHGGCZVT9QP5IBVkehmT0+tnExcbFKrjMLNkuYnMaay7hPWY4MxpJMW9WSlz3z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZg0J0eW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15120C4CEC6;
	Wed,  6 Nov 2024 20:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730925141;
	bh=1Ei0xMRvJVGpNZKZ8Xu5z8oPwa6biKFwhQZaFWCaniQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tZg0J0eWyw29z9TlF5Dh4E6EQ5oPdCcO4Zz1/6he+K+beNXrwI5BYmOKhVX2TOsrL
	 mAyajLN3o73Gvjnr3Ma+elCxVC6Ow693XoGe6S09/upNh68DhL/lmhJqnTnr1eaG2P
	 vB982vUHSfGzwhi6hvbBmebGg7uoHTS6frYohB/PiF7IdB2PrwT1NTwcKUypN5ZWST
	 +bDlMwFqgxqC0QYaudNUVdGHgRqi8jjbiJge483v+BpQXxLaXN5QcNCgttY6SgPyc+
	 Q2BqAfBJ/xs1a9unoAlhKJDasaC2HI3NH5YOpLHp2NM7XuhVOU6VscBy9lyURxzNsn
	 f8j4/RaEtgLGA==
Date: Wed, 6 Nov 2024 14:32:19 -0600
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
Message-ID: <20241106203219.GA1530199@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aca00bd672ee576ad96d279414fc0835ff31f637.1720022580.git.lorenzo@kernel.org>

On Wed, Jul 03, 2024 at 06:12:44PM +0200, Lorenzo Bianconi wrote:
> Introduce support for Airoha EN7581 PCIe controller to mediatek-gen3
> PCIe controller driver.
> ...

> +static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
> +{
> +	struct device *dev = pcie->dev;
> +	int err;
> +	u32 val;
> +
> +	/*
> +	 * Wait for the time needed to complete the bulk assert in
> +	 * mtk_pcie_setup for EN7581 SoC.
> +	 */
> +	mdelay(PCIE_EN7581_RESET_TIME_MS);

It looks wrong to me to do the assert and deassert in different
places:

  mtk_pcie_setup
    reset_control_bulk_assert(pcie->phy_resets)        <--
    mtk_pcie_en7581_power_up
      mdelay(PCIE_EN7581_RESET_TIME_MS)
      reset_control_bulk_deassert(pcie->phy_resets)    <--
      mdelay(PCIE_EN7581_RESET_TIME_MS)

That makes the code hard to understand.

> +	err = phy_init(pcie->phy);
> +	if (err) {
> +		dev_err(dev, "failed to initialize PHY\n");
> +		return err;
> +	}
> +
> +	err = phy_power_on(pcie->phy);
> +	if (err) {
> +		dev_err(dev, "failed to power on PHY\n");
> +		goto err_phy_on;
> +	}
> +
> +	err = reset_control_bulk_deassert(pcie->soc->phy_resets.num_resets, pcie->phy_resets);
> +	if (err) {
> +		dev_err(dev, "failed to deassert PHYs\n");
> +		goto err_phy_deassert;
> +	}
> +
> +	/*
> +	 * Wait for the time needed to complete the bulk de-assert above.
> +	 * This time is specific for EN7581 SoC.
> +	 */
> +	mdelay(PCIE_EN7581_RESET_TIME_MS);
> +
> +	pm_runtime_enable(dev);
> +	pm_runtime_get_sync(dev);
> +

> +	err = clk_bulk_prepare(pcie->num_clks, pcie->clks);
> +	if (err) {
> +		dev_err(dev, "failed to prepare clock\n");
> +		goto err_clk_prepare;
> +	}
> +
> +	val = FIELD_PREP(PCIE_VAL_LN0_DOWNSTREAM, 0x47) |
> +	      FIELD_PREP(PCIE_VAL_LN1_DOWNSTREAM, 0x47) |
> +	      FIELD_PREP(PCIE_VAL_LN0_UPSTREAM, 0x41) |
> +	      FIELD_PREP(PCIE_VAL_LN1_UPSTREAM, 0x41);
> +	writel_relaxed(val, pcie->base + PCIE_EQ_PRESET_01_REG);
> +
> +	val = PCIE_K_PHYPARAM_QUERY | PCIE_K_QUERY_TIMEOUT |
> +	      FIELD_PREP(PCIE_K_PRESET_TO_USE_16G, 0x80) |
> +	      FIELD_PREP(PCIE_K_PRESET_TO_USE, 0x2) |
> +	      FIELD_PREP(PCIE_K_FINETUNE_MAX, 0xf);
> +	writel_relaxed(val, pcie->base + PCIE_PIPE4_PIE8_REG);

Why is this equalization stuff in the middle between
clk_bulk_prepare() and clk_bulk_enable()?  Is the split an actual
requirement, or could we use clk_bulk_prepare_enable() here, like we
do in mtk_pcie_power_up()?

If the split is required, a comment about why would be helpful.

> +	err = clk_bulk_enable(pcie->num_clks, pcie->clks);
> +	if (err) {
> +		dev_err(dev, "failed to prepare clock\n");
> +		goto err_clk_enable;
> +	}

Per https://lore.kernel.org/r/ZypgYOn7dcYIoW4i@lore-desk,
REG_PCI_CONTROL is asserted/deasserted here by en7581_pci_enable().

Is this where PERST# is asserted?  If so, a comment to that effect
would be helpful.  Where is PERST# deasserted?  Where are the required
delays before deassert done?

Bjorn

