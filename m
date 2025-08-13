Return-Path: <linux-pci+bounces-33982-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 767A8B2539B
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 21:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364548883D0
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 19:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AE92BF016;
	Wed, 13 Aug 2025 19:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBlNzSvR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990822BD5BC;
	Wed, 13 Aug 2025 19:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755111996; cv=none; b=gV3O81n51+GfEt92K3DXswcE/xAXB2qim4w7zQqMP+25J1Uvbr0tf4OcuAOnQGGFwlsgDDs6XOQWcv5cg9EGOfUvmWvEtgWQPQwXVRXTlk1REOzPXdWBozSFpdiyCvRsSlGfJcOKcogS03nkKAdoAbm6Do8jMLHGdjyYjGRcwRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755111996; c=relaxed/simple;
	bh=wBSCYvD6eI/0TlyZhgU8cG9wLNrFJkRgE09i4a9qP58=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kHgpb/5ePaFm0E1Xzjf3WzG7gyQ9XEL1vft0mU3RQRPnaEdPgZikILFsVmvbKSHoyeBbT6nLnCQsMkAY1p/2k1VAF6e2rfMLtHu7UKUh2Wl/pVLqBfIDQyV1ugWebdB7NxTRLJ2ntGHUrCmdVO9ZAd2vGEQtQkEY5Spvtnk6XaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBlNzSvR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF5FC4CEEB;
	Wed, 13 Aug 2025 19:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755111995;
	bh=wBSCYvD6eI/0TlyZhgU8cG9wLNrFJkRgE09i4a9qP58=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OBlNzSvRjYqb41fYPkb3XtEcTVzUOCIp4pAPjdUcdNq5BEF6bkAtQusOWZ8qpO1rh
	 dECUANL8UKjbFMWY19cFtNLzPNbTB70lFZeDmR4GG9SXmuKvsKGka9J9bOXBE9CmUI
	 xI8Sun32XfDsGo1XAwxxItZ/b+3r+cZ1S6/tl8VXVgPt4NOugGilQkaYmyRrNtUcCe
	 8Bb81m1ZPt/nngE+7NgXcWBZZFQh857JxRS0+0Zl32NvbnBXl901oGQFPQwccwT9bE
	 j/huJWTJgU7/LqTKJuLWIm0LCCXuC7+S/NVFmHOaTmwI5BIkBJlKY+AJjamr5py9Rr
	 QQet0O7smwECw==
Date: Wed, 13 Aug 2025 14:06:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, linus.walleij@linaro.org,
	linux-pci@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1] PCI: stm32: use pinctrl_pm_select_init_state() in
 stm32_pcie_resume_noirq()
Message-ID: <20250813190633.GA284987@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813115319.212721-1-christian.bruel@foss.st.com>

On Wed, Aug 13, 2025 at 01:53:19PM +0200, Christian Bruel wrote:
> Replace direct access to dev->pins->init_state with the new helper
> pinctrl_pm_select_init_state() to select the init pinctrl state.
> This fixes build issues when CONFIG_PINCTRL is not defined.
> 
> Depends-on: <20250813081139.93201-3-christian.bruel@foss.st.com>
> Reported-by: Bjorn Helgaas <bhelgaas@google.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202506260920.bmQ9hQ9s-lkp@intel.com/
> Fixes: 633f42f48af5 ("PCI: stm32: Add PCIe host support for STM32MP25")
> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>

I can't merge 633f42f48af5 as-is because of the build issue.

Pinctrl provides stubs for the non-CONFIG_PINCTRL case; the issue is
that 633f42f48af5 uses dev->pins, which only exists when
CONFIG_PINCTRL is enabled.  

The possibilities I see are:

  1) Merge initial stm32 without suspend/resume support via PCI, merge
     pinctrl_pm_select_init_state() via pinctrl, then add stm32
     suspend/resume support.  pinctrl_pm_select_init_state() and stm32
     (without suspend/resume) would appear in v6.18, and stm32
     suspend/resume would be added in v6.19.

  2) Temporarily #ifdef the dev->pins use.  pinctrl_pm_select_init_state()
     and stm32 (with #ifdef) would appear in v6.18, follow-on patch to
     replace #ifdef with pinctrl_pm_select_init_state() would appear
     in v6.19.

  3) Merge your [1] to add pinctrl_pm_select_init_state() via PCI with
     Linus's ack, followed by the stm32 series with the change below
     squashed in.  Everything would appear in v6.18.

I'm OK with any of these.

[1] https://lore.kernel.org/r/20250813081139.93201-1-christian.bruel@foss.st.com

> ---
> Changes in v1:
>  - pinctrl_pm_select_init_state() return 0 if the state is not defined.
>    No need to test as pinctrl_pm_select_default_state() is called.
> ---
>  drivers/pci/controller/dwc/pcie-stm32.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-stm32.c b/drivers/pci/controller/dwc/pcie-stm32.c
> index 50fae5f5ced2..8501b9ed0633 100644
> --- a/drivers/pci/controller/dwc/pcie-stm32.c
> +++ b/drivers/pci/controller/dwc/pcie-stm32.c
> @@ -90,14 +90,10 @@ static int stm32_pcie_resume_noirq(struct device *dev)
>  
>  	/*
>  	 * The core clock is gated with CLKREQ# from the COMBOPHY REFCLK,
> -	 * thus if no device is present, must force it low with an init pinmux
> -	 * to be able to access the DBI registers.
> +	 * thus if no device is present, must deassert it with a GPIO from
> +	 * pinctrl pinmux before accessing the DBI registers.
>  	 */
> -	if (!IS_ERR(dev->pins->init_state))
> -		ret = pinctrl_select_state(dev->pins->p, dev->pins->init_state);
> -	else
> -		ret = pinctrl_pm_select_default_state(dev);
> -
> +	ret = pinctrl_pm_select_init_state(dev);
>  	if (ret) {
>  		dev_err(dev, "Failed to activate pinctrl pm state: %d\n", ret);
>  		return ret;
> -- 
> 2.34.1
> 

