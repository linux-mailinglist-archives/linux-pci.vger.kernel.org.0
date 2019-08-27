Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 584B69EF4B
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2019 17:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbfH0Pr3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 11:47:29 -0400
Received: from foss.arm.com ([217.140.110.172]:46990 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbfH0Pr3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Aug 2019 11:47:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A5C7337;
        Tue, 27 Aug 2019 08:47:28 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 598D23F59C;
        Tue, 27 Aug 2019 08:47:27 -0700 (PDT)
Date:   Tue, 27 Aug 2019 16:47:25 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@ti.com,
        gustavo.pimentel@synopsys.com, digetx@gmail.com,
        mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH 6/6] PCI: tegra: Add support to enable slot regulators
Message-ID: <20190827154725.GP14582@e119886-lin.cambridge.arm.com>
References: <20190826073143.4582-1-vidyas@nvidia.com>
 <20190826073143.4582-7-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826073143.4582-7-vidyas@nvidia.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 26, 2019 at 01:01:43PM +0530, Vidya Sagar wrote:
> Add support to get regulator information of 3.3V and 12V supplies of a PCIe
> slot from the respective controller's device-tree node and enable those
> supplies. This is required in platforms like p2972-0000 where the supplies
> to x16 slot owned by C5 controller need to be enabled before attempting to
> enumerate the devices.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 65 ++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 8a27b25893c9..97de2151a738 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -278,6 +278,8 @@ struct tegra_pcie_dw {
>  	u32 aspm_l0s_enter_lat;
>  
>  	struct regulator *pex_ctl_supply;
> +	struct regulator *slot_ctl_3v3;
> +	struct regulator *slot_ctl_12v;
>  
>  	unsigned int phy_count;
>  	struct phy **phys;
> @@ -1047,6 +1049,59 @@ static void tegra_pcie_downstream_dev_to_D0(struct tegra_pcie_dw *pcie)
>  	}
>  }
>  
> +static void tegra_pcie_get_slot_regulators(struct tegra_pcie_dw *pcie)
> +{
> +	pcie->slot_ctl_3v3 = devm_regulator_get_optional(pcie->dev, "vpcie3v3");
> +	if (IS_ERR(pcie->slot_ctl_3v3))
> +		pcie->slot_ctl_3v3 = NULL;
> +
> +	pcie->slot_ctl_12v = devm_regulator_get_optional(pcie->dev, "vpcie12v");
> +	if (IS_ERR(pcie->slot_ctl_12v))
> +		pcie->slot_ctl_12v = NULL;

Do these need to take into consideration -EPROBE_DEFER?

Thanks,

Andrew Murray

> +}
> +
> +static int tegra_pcie_enable_slot_regulators(struct tegra_pcie_dw *pcie)
> +{
> +	int ret;
> +
> +	if (pcie->slot_ctl_3v3) {
> +		ret = regulator_enable(pcie->slot_ctl_3v3);
> +		if (ret < 0) {
> +			dev_err(pcie->dev,
> +				"Failed to enable 3V3 slot supply: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	if (pcie->slot_ctl_12v) {
> +		ret = regulator_enable(pcie->slot_ctl_12v);
> +		if (ret < 0) {
> +			dev_err(pcie->dev,
> +				"Failed to enable 12V slot supply: %d\n", ret);
> +			if (pcie->slot_ctl_3v3)
> +				regulator_disable(pcie->slot_ctl_3v3);
> +			return ret;
> +		}
> +	}
> +
> +	/*
> +	 * According to PCI Express Card Electromechanical Specification
> +	 * Revision 1.1, Table-2.4, T_PVPERL (Power stable to PERST# inactive)
> +	 * should be a minimum of 100ms.
> +	 */
> +	msleep(100);
> +
> +	return 0;
> +}
> +
> +static void tegra_pcie_disable_slot_regulators(struct tegra_pcie_dw *pcie)
> +{
> +	if (pcie->slot_ctl_12v)
> +		regulator_disable(pcie->slot_ctl_12v);
> +	if (pcie->slot_ctl_3v3)
> +		regulator_disable(pcie->slot_ctl_3v3);
> +}
> +
>  static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
>  					bool en_hw_hot_rst)
>  {
> @@ -1060,6 +1115,10 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
>  		return ret;
>  	}
>  
> +	ret = tegra_pcie_enable_slot_regulators(pcie);
> +	if (ret < 0)
> +		goto fail_slot_reg_en;
> +
>  	ret = regulator_enable(pcie->pex_ctl_supply);
>  	if (ret < 0) {
>  		dev_err(pcie->dev, "Failed to enable regulator: %d\n", ret);
> @@ -1142,6 +1201,8 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
>  fail_core_clk:
>  	regulator_disable(pcie->pex_ctl_supply);
>  fail_reg_en:
> +	tegra_pcie_disable_slot_regulators(pcie);
> +fail_slot_reg_en:
>  	tegra_pcie_bpmp_set_ctrl_state(pcie, false);
>  
>  	return ret;
> @@ -1174,6 +1235,8 @@ static int __deinit_controller(struct tegra_pcie_dw *pcie)
>  		return ret;
>  	}
>  
> +	tegra_pcie_disable_slot_regulators(pcie);
> +
>  	ret = tegra_pcie_bpmp_set_ctrl_state(pcie, false);
>  	if (ret) {
>  		dev_err(pcie->dev, "Failed to disable controller %d: %d\n",
> @@ -1372,6 +1435,8 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	tegra_pcie_get_slot_regulators(pcie);
> +
>  	pcie->pex_ctl_supply = devm_regulator_get(dev, "vddio-pex-ctl");
>  	if (IS_ERR(pcie->pex_ctl_supply)) {
>  		dev_err(dev, "Failed to get regulator: %ld\n",
> -- 
> 2.17.1
> 
