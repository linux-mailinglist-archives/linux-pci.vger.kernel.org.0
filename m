Return-Path: <linux-pci+bounces-19990-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FD0A14011
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 18:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DD9C3A20B2
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 17:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85265145348;
	Thu, 16 Jan 2025 17:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aihW9zUS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DD37081E;
	Thu, 16 Jan 2025 17:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737046876; cv=none; b=PM8ZKmUfiBR3X6THA9lRX7hP+/r48aYc7HEoBOyGK3M5pMnMenT6qFjO9i/1lBu5dS+0dL2ptOdxpginypfPenUNL+tttgO80duAA307Mm4dO/E52c2sjRZPNJZh/+PT9ZQwaIgBGXSkarPZS4zV4X5QMt+xCtb8v/8G2udQ56Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737046876; c=relaxed/simple;
	bh=sIyEpcILKU6HkN+pcB5rrY1Ix3OJNrYy21QuDNq+2IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PvCFO4quCIeuia5qzTWEhww6ItxAcMXBqg2teuoUIcBYNQ3gmxSStOEwhIDx9j3d97Ez3kie5elV9NZJle4w1ZmbybGIVqINt1K0FxbeT8HOeGmUvup/i9Y4R3KHqylmLkbWP0rgTWA+QxLV2s4OJprCwuBnFgcXzAPPIXjwyls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aihW9zUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2839C4CED6;
	Thu, 16 Jan 2025 17:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737046876;
	bh=sIyEpcILKU6HkN+pcB5rrY1Ix3OJNrYy21QuDNq+2IQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aihW9zUS9HxRQsQOKMKJdhyogOtZ88U61HA5vehb8BNQHBNOkxW5Gq7CxpGbq7NGl
	 wpUJTNDfKWCN0LABS5YhiT7jBJj3qD7q28Y7Rsny2FHg3EUi5VPkRWsgDYjijsv5Eq
	 UEAmtqWoH8s7QtSFljoMe0T0gXKw+F2xFCAj3L3Iv8SboyG6cdPxfvwEmzLddxr3HX
	 1vdFC/9NFNb0kj02O7ELPYxlydm1WKgg5BLtkaQe5UJQh6OO+ZFA9iI2KcRM32/9T0
	 soQmWnGKaQURbLuJiSrZ0aL5WWP/GOAHf7hN9mB+66cbjG3HedpzL3d8BYibnCpAl+
	 nUZw1VNynBg6w==
Date: Thu, 16 Jan 2025 11:01:14 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, bhelgaas@google.com, lpieralisi@kernel.org,
	kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
	frank.li@nxp.com, s.hauer@pengutronix.de, festevam@gmail.com,
	imx@lists.linux.dev, kernel@pengutronix.de,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 06/10] PCI: imx6: Fix the missing reference clock
 disable logic
Message-ID: <20250116170114.GA561930@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126075702.4099164-7-hongxing.zhu@nxp.com>

On Tue, Nov 26, 2024 at 03:56:58PM +0800, Richard Zhu wrote:
> Ensure the *_enable_ref_clk() function is symmetric by addressing missing
> disable parts on some platforms.
> 
> Fixes: d0a75c791f98 ("PCI: imx6: Factor out ref clock disable to match enable")

The patch below looks fine to me, and I guess it's more than just
making the code prettier; it also actually *fixes* something, right?

It looks like a functional change because imx_pcie_clk_enable() will
now enable the IMX7D refclk when it didn't before, and
imx_pcie_clk_disable() will disable the IMX6SX and IMX8M* refclk when
it didn't before?

But I don't think the Fixes: tag is correct.  I looked at uses of
these symbols:

  IMX6SX_GPR12_PCIE_TEST_POWERDOWN
    enabled by imx6_pcie_enable_ref_clk()
    disabled by imx6_pcie_assert_core_reset()

  IMX7D_GPR12_PCIE_PHY_REFCLK_SEL
    enabled by imx6_pcie_init_phy()
    disabled by imx6_pcie_clk_disable()

  IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE
    enabled by imx6_pcie_enable_ref_clk()

As far as I can tell, these uses are identical before and after
d0a75c791f98 ("PCI: imx6: Factor out ref clock disable to match
enable").

> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 413db182ce9f..ab2c97a8c327 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -599,10 +599,9 @@ static int imx_pcie_attach_pd(struct device *dev)
>  
>  static int imx6sx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
>  {
> -	if (enable)
> -		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -				  IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
> -
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +			   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
> +			   enable ? 0 : IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
>  	return 0;
>  }
>  
> @@ -631,19 +630,20 @@ static int imx8mm_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
>  {
>  	int offset = imx_pcie_grp_offset(imx_pcie);
>  
> -	if (enable) {
> -		regmap_clear_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE);
> -		regmap_set_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
> -	}
> -
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
> +			   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE,
> +			   enable ? 0 : IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE);
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
> +			   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
> +			   enable ? IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN : 0);
>  	return 0;
>  }
>  
>  static int imx7d_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
>  {
> -	if (!enable)
> -		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -				IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +			   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> +			   enable ? 0 : IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
>  	return 0;
>  }
>  
> -- 
> 2.37.1
> 

