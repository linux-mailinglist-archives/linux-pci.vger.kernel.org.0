Return-Path: <linux-pci+bounces-33574-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE743B1DCD9
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 20:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB9D37A3597
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 18:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCCD2222BA;
	Thu,  7 Aug 2025 18:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c56iw94L"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EA6221737;
	Thu,  7 Aug 2025 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754589921; cv=none; b=jbSqIFk8+aOjhcZZKRb2e1wO4ZcjPyrFHSyYhapIhVIYuUEcMBsEa4bLjaQs4cDmmTTLLRiTY9IRuYg5ThofMtRZgaL717s+mELtg64ZLXSD0/Nq46TYvMhC86zE0bHWnHGTREN7nHaJUna+XJeukcf9fuDJl5a8CLbNfJZWg0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754589921; c=relaxed/simple;
	bh=xKpdGfGG9X89d+WYFfLmSef3z1eEJiPKsaCnJZfi//o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=W01qq+6q4mOGIwKp0oH2ny26Q6cpXJajM5oCE4pR2DFRHIeYnC0eO+qZecs7JoImyO3JuXt/STTm8L3SOa+B8aqXJl5gmsSndlll0KzCsExywZuEu3RElnG8xYcd8QApxHomLC0lxmNkg4Zxc4ZusPDkPDZJgyHYk5b5MSodBLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c56iw94L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6AFC4CEEB;
	Thu,  7 Aug 2025 18:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754589920;
	bh=xKpdGfGG9X89d+WYFfLmSef3z1eEJiPKsaCnJZfi//o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=c56iw94LMjfCTQ66ZGwvscHeQingtEi1BN5o2AVxTSaGSKTDiuQ6+ltUm7Jdakf0p
	 KJHhGzLT5y3/d1/pgUJee+oXgPAWU3BQuDWkmfluEH/+0xKhdpe/qHyf3SGc3JnUo7
	 Kzl5xxmGFv4fXuDQMYXaH6cNq5WDiLIZf5u6/Zczvv4og25ptx6G2py/u43Ti8RIlx
	 5TsyHim7Q5xI5qtrH8T0+53Wd4nQG/fNppMfQG7PRkTVwcbXXhh6oU1PJIxcJNdNPK
	 qvnZFc3aAGv2A9McbAffQmwJDw3f7eRRmRM6jO6olH4SeyB3SzyI+gwAvRnCbF3LgY
	 z8RTMlTWzR78Q==
Date: Thu, 7 Aug 2025 13:05:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, linus.walleij@linaro.org,
	linux-pci@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [RESEND PATCH 2/2] PCI: stm32: use
 pinctrl_pm_select_init_state() in stm32_pcie_resume_noirq()
Message-ID: <20250807180519.GA56557@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717063042.2236524-3-christian.bruel@foss.st.com>

On Thu, Jul 17, 2025 at 08:30:42AM +0200, Christian Bruel wrote:
> Replace direct access to dev->pins->init_state with the new helper
> pinctrl_pm_select_init_state() to select the init pinctrl state.
> This fixes build issues when CONFIG_PINCTRL is not defined.
> 
> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> Reported-by: Bjorn Helgaas <bhelgaas@google.com>  
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202506260920.bmQ9hQ9s-lkp@intel.com/
> Fixes: 633f42f48af5 ("PCI: stm32: Add PCIe host support for STM32MP25")

633f42f48af5 is still on pci/controller/dwc-stm32, but only for
reference.  After v6.17-rc1, we will need to rebase to it and figure
out the merge strategy.

Part of that will be to restructure 633f42f48af5 and the material
below such that there is no build issue at any point in the series.

> ---
>  drivers/pci/controller/dwc/pcie-stm32.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-stm32.c b/drivers/pci/controller/dwc/pcie-stm32.c
> index 50fae5f5ced2..c1d803dc3778 100644
> --- a/drivers/pci/controller/dwc/pcie-stm32.c
> +++ b/drivers/pci/controller/dwc/pcie-stm32.c
> @@ -28,6 +28,7 @@ struct stm32_pcie {
>  	struct clk *clk;
>  	struct gpio_desc *perst_gpio;
>  	struct gpio_desc *wake_gpio;
> +	bool   have_pinctrl_init;
>  };
>  
>  static void stm32_pcie_deassert_perst(struct stm32_pcie *stm32_pcie)
> @@ -91,10 +92,10 @@ static int stm32_pcie_resume_noirq(struct device *dev)
>  	/*
>  	 * The core clock is gated with CLKREQ# from the COMBOPHY REFCLK,
>  	 * thus if no device is present, must force it low with an init pinmux
> -	 * to be able to access the DBI registers.
> +	 * if present to be able to access the DBI registers.
>  	 */
> -	if (!IS_ERR(dev->pins->init_state))
> -		ret = pinctrl_select_state(dev->pins->p, dev->pins->init_state);
> +	if (stm32_pcie->have_pinctrl_init)
> +		ret = pinctrl_pm_select_init_state(dev);
>  	else
>  		ret = pinctrl_pm_select_default_state(dev);
>  
> @@ -274,6 +275,9 @@ static int stm32_pcie_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, PTR_ERR(stm32_pcie->rst),
>  				     "Failed to get PCIe reset\n");
>  
> +	if (device_property_match_string(dev, "pinctrl-names", PINCTRL_STATE_INIT) >= 0)
> +		stm32_pcie->have_pinctrl_init = true;
> +
>  	ret = stm32_pcie_parse_port(stm32_pcie);
>  	if (ret)
>  		return ret;
> -- 
> 2.34.1
> 

