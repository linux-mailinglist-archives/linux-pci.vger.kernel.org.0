Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9EB9A53DB
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2019 12:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbfIBKS7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Sep 2019 06:18:59 -0400
Received: from foss.arm.com ([217.140.110.172]:51620 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729668AbfIBKS7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Sep 2019 06:18:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82DE028;
        Mon,  2 Sep 2019 03:18:58 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED8013F246;
        Mon,  2 Sep 2019 03:18:57 -0700 (PDT)
Date:   Mon, 2 Sep 2019 11:18:56 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@ti.com,
        gustavo.pimentel@synopsys.com, digetx@gmail.com,
        mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V3 3/6] PCI: tegra: Add support to configure sideband pins
Message-ID: <20190902101855.GV14582@e119886-lin.cambridge.arm.com>
References: <20190828172850.19871-1-vidyas@nvidia.com>
 <20190828172850.19871-4-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828172850.19871-4-vidyas@nvidia.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 28, 2019 at 10:58:47PM +0530, Vidya Sagar wrote:
> Add support to configure sideband signal pins when information is present
> in respective controller's device-tree node.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

> ---
> V3:
> * Used 'dev' instead of 'pcie->dev'
> 
> V2:
> * Addressed review comment from Andrew Murray
> * Handled failure case of pinctrl_pm_select_default_state() cleanly
> 
>  drivers/pci/controller/dwc/pcie-tegra194.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index fc0dbeb31d78..77fa6f70bc96 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1304,8 +1304,13 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
>  	if (ret < 0) {
>  		dev_err(dev, "Failed to get runtime sync for PCIe dev: %d\n",
>  			ret);
> -		pm_runtime_disable(dev);
> -		return ret;
> +		goto fail_pm_get_sync;
> +	}
> +
> +	ret = pinctrl_pm_select_default_state(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to configure sideband pins: %d\n", ret);
> +		goto fail_pinctrl;
>  	}
>  
>  	tegra_pcie_init_controller(pcie);
> @@ -1332,7 +1337,9 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
>  
>  fail_host_init:
>  	tegra_pcie_deinit_controller(pcie);
> +fail_pinctrl:
>  	pm_runtime_put_sync(dev);
> +fail_pm_get_sync:
>  	pm_runtime_disable(dev);
>  	return ret;
>  }
> -- 
> 2.17.1
> 
