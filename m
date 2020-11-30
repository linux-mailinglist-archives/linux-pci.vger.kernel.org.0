Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B848B2C83E4
	for <lists+linux-pci@lfdr.de>; Mon, 30 Nov 2020 13:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgK3MK6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Nov 2020 07:10:58 -0500
Received: from foss.arm.com ([217.140.110.172]:53558 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbgK3MK5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Nov 2020 07:10:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4B0730E;
        Mon, 30 Nov 2020 04:10:11 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A0273F66B;
        Mon, 30 Nov 2020 04:10:09 -0800 (PST)
Date:   Mon, 30 Nov 2020 12:10:07 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     robh+dt@kernel.org, bhelgaas@google.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, amanharitsh123@gmail.com,
        dinghao.liu@zju.edu.cn, kw@linux.com, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4 4/6] PCI: tegra: Continue unconfig sequence even if
 parts fail
Message-ID: <20201130121007.GC16758@e121166-lin.cambridge.arm.com>
References: <20201109171937.28326-1-vidyas@nvidia.com>
 <20201109171937.28326-5-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109171937.28326-5-vidyas@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 09, 2020 at 10:49:35PM +0530, Vidya Sagar wrote:
> Currently the driver checks for error value of different APIs during the
> uninitialization sequence. It just returns from there if there is any error
> observed for one of those calls. Comparatively it is better to continue the
> uninitialization sequence irrespective of whether some of them are
> returning error. That way, it is more closer to complete uninitialization.

Hi Vidya, Thierry,

I can apply this series (dropping patches as suggested by Thierry),
before though I wanted to ask you if this patch is really an
improvement, it is hard to understand why skipping some error
codes is OK for device correct operations to continue, maybe it
is worth describing why some of those failures aren't really
fatal.

Please let me know, thanks.

Lorenzo

> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V4:
> * None
> 
> V3:
> * Modified subject as per Bjorn's suggestion
> * Removed tegra_pcie_init_controller()'s error checking part and pushed
>   a separate patch for it
> 
> V2:
> * None
> 
>  drivers/pci/controller/dwc/pcie-tegra194.c | 39 +++++++++-------------
>  1 file changed, 15 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 253d91033bc3..9be10c8953df 100644
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
> @@ -2238,8 +2227,9 @@ static int tegra_pcie_dw_suspend_noirq(struct device *dev)
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
> @@ -2267,7 +2257,8 @@ static int tegra_pcie_dw_resume_noirq(struct device *dev)
>  	return 0;
>  
>  fail_host_init:
> -	return __deinit_controller(pcie);
> +	tegra_pcie_unconfig_controller(pcie);
> +	return ret;
>  }
>  
>  static int tegra_pcie_dw_resume_early(struct device *dev)
> @@ -2305,7 +2296,7 @@ static void tegra_pcie_dw_shutdown(struct platform_device *pdev)
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
