Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91EFD2A524B
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 21:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731521AbgKCUsi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 15:48:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:40424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731508AbgKCUsh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Nov 2020 15:48:37 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC0F62242E;
        Tue,  3 Nov 2020 20:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604436517;
        bh=wBOQgrsvSB+EWrxY4HKKXxfCeq48t8RSC6a8ercJ4RI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LEWlREtdHTMB9aiAFJ7OeiuwqRzUijgrIO0F4qwuh0367UK5uhJvwc3JeHsCeAIrM
         o++S1i3RmEEfnoProKDs1/FzqnmGHxGcFfjCIswnjje+K+DqHGP7Z/CcbH82focT2n
         +J8+E+0aNqjPs+fMagaLRwsfXUG4XnB2h9yK7FLs=
Date:   Tue, 3 Nov 2020 14:48:35 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, robh+dt@kernel.org, bhelgaas@google.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        amanharitsh123@gmail.com, dinghao.liu@zju.edu.cn, kw@linux.com,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V2 4/4] PCI: tegra: Handle error conditions properly
Message-ID: <20201103204835.GA262610@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029051839.11245-5-vidyas@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Vidya,

Can you update the subject to replace "properly" with more details
about what the patch is doing?  "Properly" is really meaningless in
usages like this -- nobody writes patches to do the *wrong* thing, so
it goes without saying that every patch is intended to things
"properly".

It would also help to have some context.  My first thought was that
"error conditions" referred to PCIe errors like completion timeouts,
completer abort, etc.

Maybe something like:

  PCI: tegra: Continue unconfig sequence even if parts fail
  PCI: tegra: Return init error (not unconfig error) on init failure

On Thu, Oct 29, 2020 at 10:48:39AM +0530, Vidya Sagar wrote:
> Currently the driver checks for error value of different APIs during the
> uninitialization sequence. It just returns from there if there is any error
> observed for one of those calls. Comparatively it is better to continue the
> uninitialization sequence irrespective of whether some of them are
> returning error. That way, it is more closer to complete uninitialization.
> It also adds checking return value for error for a cleaner exit path.

This paragraph uses "it" to refer to both "the driver" (second
sentence) and "this patch" (last sentence).  That's confusing.
There's no reason to refer to "this patch" at all.  I'd rather have
"Add checking ..." than "It adds checking ..."

I think that last sentence must be referring to the
tegra_pcie_init_controller() change to return the initialization error
rather than the error from __deinit_controller().  That seems right,
but should be a separate patch.

> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V2:
> * None
> 
>  drivers/pci/controller/dwc/pcie-tegra194.c | 45 ++++++++++------------
>  1 file changed, 20 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 253d91033bc3..8c08998b9ce1 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1422,43 +1422,32 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
>  	return ret;
>  }
>  
> -static int __deinit_controller(struct tegra_pcie_dw *pcie)
> +static void tegra_pcie_unconfig_controller(struct tegra_pcie_dw *pcie)
>  {
>  	int ret;
>  
>  	ret = reset_control_assert(pcie->core_rst);
> -	if (ret) {
> -		dev_err(pcie->dev, "Failed to assert \"core\" reset: %d\n",
> -			ret);
> -		return ret;
> -	}
> +	if (ret)
> +		dev_err(pcie->dev, "Failed to assert \"core\" reset: %d\n", ret);
>  
>  	tegra_pcie_disable_phy(pcie);
>  
>  	ret = reset_control_assert(pcie->core_apb_rst);
> -	if (ret) {
> +	if (ret)
>  		dev_err(pcie->dev, "Failed to assert APB reset: %d\n", ret);
> -		return ret;
> -	}
>  
>  	clk_disable_unprepare(pcie->core_clk);
>  
>  	ret = regulator_disable(pcie->pex_ctl_supply);
> -	if (ret) {
> +	if (ret)
>  		dev_err(pcie->dev, "Failed to disable regulator: %d\n", ret);
> -		return ret;
> -	}
>  
>  	tegra_pcie_disable_slot_regulators(pcie);
>  
>  	ret = tegra_pcie_bpmp_set_ctrl_state(pcie, false);
> -	if (ret) {
> +	if (ret)
>  		dev_err(pcie->dev, "Failed to disable controller %d: %d\n",
>  			pcie->cid, ret);
> -		return ret;
> -	}
> -
> -	return ret;
>  }
>  
>  static int tegra_pcie_init_controller(struct tegra_pcie_dw *pcie)
> @@ -1482,7 +1471,8 @@ static int tegra_pcie_init_controller(struct tegra_pcie_dw *pcie)
>  	return 0;
>  
>  fail_host_init:
> -	return __deinit_controller(pcie);
> +	tegra_pcie_unconfig_controller(pcie);
> +	return ret;
>  }
>  
>  static int tegra_pcie_try_link_l2(struct tegra_pcie_dw *pcie)
> @@ -1551,13 +1541,12 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
>  	appl_writel(pcie, data, APPL_PINMUX);
>  }
>  
> -static int tegra_pcie_deinit_controller(struct tegra_pcie_dw *pcie)
> +static void tegra_pcie_deinit_controller(struct tegra_pcie_dw *pcie)
>  {
>  	tegra_pcie_downstream_dev_to_D0(pcie);
>  	dw_pcie_host_deinit(&pcie->pci.pp);
>  	tegra_pcie_dw_pme_turnoff(pcie);
> -
> -	return __deinit_controller(pcie);
> +	tegra_pcie_unconfig_controller(pcie);
>  }
>  
>  static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
> @@ -1590,7 +1579,11 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
>  		goto fail_pm_get_sync;
>  	}
>  
> -	tegra_pcie_init_controller(pcie);
> +	ret = tegra_pcie_init_controller(pcie);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to initialize controller: %d\n", ret);
> +		goto fail_pm_get_sync;
> +	}
>  
>  	pcie->link_state = tegra_pcie_dw_link_up(&pcie->pci);
>  	if (!pcie->link_state) {
> @@ -2238,8 +2231,9 @@ static int tegra_pcie_dw_suspend_noirq(struct device *dev)
>  					       PORT_LOGIC_MSI_CTRL_INT_0_EN);
>  	tegra_pcie_downstream_dev_to_D0(pcie);
>  	tegra_pcie_dw_pme_turnoff(pcie);
> +	tegra_pcie_unconfig_controller(pcie);
>  
> -	return __deinit_controller(pcie);
> +	return 0;
>  }
>  
>  static int tegra_pcie_dw_resume_noirq(struct device *dev)
> @@ -2267,7 +2261,8 @@ static int tegra_pcie_dw_resume_noirq(struct device *dev)
>  	return 0;
>  
>  fail_host_init:
> -	return __deinit_controller(pcie);
> +	tegra_pcie_unconfig_controller(pcie);
> +	return ret;
>  }
>  
>  static int tegra_pcie_dw_resume_early(struct device *dev)
> @@ -2305,7 +2300,7 @@ static void tegra_pcie_dw_shutdown(struct platform_device *pdev)
>  		disable_irq(pcie->pci.pp.msi_irq);
>  
>  	tegra_pcie_dw_pme_turnoff(pcie);
> -	__deinit_controller(pcie);
> +	tegra_pcie_unconfig_controller(pcie);
>  }
>  
>  static const struct tegra_pcie_dw_of_data tegra_pcie_dw_rc_of_data = {
> -- 
> 2.17.1
> 
