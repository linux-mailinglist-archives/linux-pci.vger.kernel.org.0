Return-Path: <linux-pci+bounces-7720-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D85CB8CB0B6
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 16:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AA681F23578
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 14:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6A174C09;
	Tue, 21 May 2024 14:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYUEzE2p"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9DD7EEED;
	Tue, 21 May 2024 14:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716302949; cv=none; b=rHkdQWsNr7USECFuDdTZKHaNVr9hpjD1mY5OVskrMQsSPWXscSAbSmF0vdJi8MKO+LUCb9y83N7U1qI5cxV/dsc6dn7/YVOGq0DAYkGe5JchsFucbJFJo1b3ygQApzB5IFUZTdsWDg5iohd3ffDtQSv0s6vlu1IrKjislIbK+hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716302949; c=relaxed/simple;
	bh=2Zdq3ao5oPT4v6RHpySNLDLRlbgSEBW0E+3jgE93Mi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgVB7YL6trilrMs6x76ne+/fjOs54duKqmPU0a/8mH1Xbqo7mNYYkUp/kTNw7jEPHRN2WyGMVaQExVdwRe7AKdjN0XrJ4u5oiDpmFtIDrEPP9+BAWmpA8qpCetnTPvNG48itLo84XV6EzqONi0s5AjYdADxf6jVyFNJcWGmmyF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYUEzE2p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41287C32786;
	Tue, 21 May 2024 14:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716302949;
	bh=2Zdq3ao5oPT4v6RHpySNLDLRlbgSEBW0E+3jgE93Mi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TYUEzE2pOwqKksIUWRjq8fVJT/HgyaReh88FPUyppxVMuiVb/MDoZMmYYU0W4LUO1
	 6/etgtd2/YeSUm3DxLi45m5HzZhCOjinulAmcHmwQTCWPPaGSQLjTULb9+WLT+xo6D
	 oIOJLl/JUtmQTDzQEeF3gqscKRMFjoX/4BU83w01jron1zx6YzK/Ben8N+LaxpqDd+
	 BdTjfFIsspKa16nFRnhuMv7SlYvspX/q94v8X9Wudqz1CxV9IIFt15TnMVuC3k4F28
	 CvJfnO4pnZj6+d7g/6QaSdD//IasH3oEplae93fbTGozssFJEW0L2UPHnVCcZGDgdr
	 lxyDe8T9IEWnw==
Date: Tue, 21 May 2024 16:49:02 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
	robh@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
	vidyas@nvidia.com, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH] PCI: tegra194: Add check for host and endpoint modes
Message-ID: <Zky0XkvmOoFCxnDx@x1-carbon.wireless.wdc>
References: <20240513154900.127612-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513154900.127612-1-manivannan.sadhasivam@linaro.org>

On Mon, May 13, 2024 at 05:49:00PM +0200, Manivannan Sadhasivam wrote:
> Tegra194 driver supports both the host and endpoint mode, but there are no
> checks to validate whether the corresponding mode is enabled in kernel
> config or not. So if the driver tries to function without enabling the
> required mode (CONFIG_PCIE_TEGRA194_HOST/CONFIG_PCIE_TEGRA194_EP), then it
> will result in driver malfunction.
> 
> So let's add the checks in probe() before doing the mode specific config
> and fail probe() if the corresponding mode is not enabled.
> 
> But this also requires adding one redundant check in
> pex_ep_event_pex_rst_assert() for pci_epc_deinit_notify(). Because the
> function is called outside of probe() and the compiler fails to spot the
> dependency in probe() and still complains about the undefined reference to
> pci_epc_deinit_notify().
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202405130815.BwBrIepL-lkp@intel.com
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index d2223821e122..e02a9bca70ef 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1715,7 +1715,16 @@ static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
>  	if (ret)
>  		dev_err(pcie->dev, "Failed to go Detect state: %d\n", ret);
>  
> -	pci_epc_deinit_notify(pcie->pci.ep.epc);
> +	/*
> +	 * We do not really need the below guard as the driver won't probe
> +	 * successfully if it tries to probe in EP mode and
> +	 * CONFIG_PCIE_TEGRA194_EP is not enabled. But since this function is
> +	 * being called outside of probe(), compiler fails to spot the
> +	 * dependency in probe() and hence this redundant check.
> +	 */
> +	if (IS_ENABLED(CONFIG_PCIE_TEGRA194_EP))
> +		pci_epc_deinit_notify(pcie->pci.ep.epc);
> +

This big comment is a bit ugly. It would be nice if it could be avoided.

(pci-epc.h does not provide any dummy implementations for any of the
functions, so I suggest that we leave it like that.)

However, if we look at dw_pcie_ep_init_notify(), it is called from
pex_ep_event_pex_rst_deassert(), and we do not get a build warning for that.

The reason is that dw_pcie_ep_init_notify() has a dummy implementation
in pcie-designware.h.

May I suggest that we add a dw_pcie_ep_deinit_notify() wrapper around
pci_epc_deinit_notify(), while also providing a dummy implementation
in pcie-designware.h ?

That way, the code in pcie-tegra194.c (and pcie-qcom-ep.c) would be
more symmetrical, calling dw_pcie_ep_init_notify() for init notification,
and dw_pcie_ep_deinit_notify() for deinit notification.

(Instead of dw_pcie_ep_init_notify() + pci_epc_deinit_notify())


Kind regards,
Niklas

