Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD0B11886
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2019 13:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfEBLyC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 May 2019 07:54:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbfEBLyC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 May 2019 07:54:02 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A46C2085A;
        Thu,  2 May 2019 11:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556798040;
        bh=MJuDoA8O1wSTWBXPGBtbAL+9l4Xm9O2UFo5X/JCxCxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vnhcZnx8YfDz5AEqKHeX9+laLdckR7fpastaHDhiz9ApyYyK7Pjd8B931y0hnWCjQ
         RGcQFFisxsb57iuMSeuEr92VmOtEEt+9wpDjCj7Or9NPDIVbH7u9ehv2AoMZKHFryk
         VlcbGDWJi9nAFQgwefoSc6Z1BYBIx5BDtqF+1oEo=
Date:   Thu, 2 May 2019 17:23:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] PCI: qcom: Use clk_bulk API for 2.4.0 controllers
Message-ID: <20190502115351.GM3845@vkoul-mobl.Dlink>
References: <20190502001955.10575-1-bjorn.andersson@linaro.org>
 <20190502001955.10575-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502001955.10575-2-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 01-05-19, 17:19, Bjorn Andersson wrote:
> Before introducing the QCS404 platform, which uses the same PCIe
> controller as IPQ4019, migrate this to use the bulk clock API, in order
> to make the error paths slighly cleaner.
> 
> Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>
> Reviewed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v2:
> - Defined QCOM_PCIE_2_4_0_MAX_CLOCKS
> 
>  drivers/pci/controller/dwc/pcie-qcom.c | 49 ++++++++------------------
>  1 file changed, 14 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 0ed235d560e3..d740cbe0e56d 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -112,10 +112,10 @@ struct qcom_pcie_resources_2_3_2 {
>  	struct regulator_bulk_data supplies[QCOM_PCIE_2_3_2_MAX_SUPPLY];
>  };
>  
> +#define QCOM_PCIE_2_4_0_MAX_CLOCKS	3

empty line after the define please

>  struct qcom_pcie_resources_2_4_0 {
> -	struct clk *aux_clk;
> -	struct clk *master_clk;
> -	struct clk *slave_clk;
> +	struct clk_bulk_data clks[QCOM_PCIE_2_4_0_MAX_CLOCKS];
> +	int num_clks;
>  	struct reset_control *axi_m_reset;
>  	struct reset_control *axi_s_reset;
>  	struct reset_control *pipe_reset;
> @@ -638,18 +638,17 @@ static int qcom_pcie_get_resources_2_4_0(struct qcom_pcie *pcie)
>  	struct qcom_pcie_resources_2_4_0 *res = &pcie->res.v2_4_0;
>  	struct dw_pcie *pci = pcie->pci;
>  	struct device *dev = pci->dev;
> +	int ret;
>  
> -	res->aux_clk = devm_clk_get(dev, "aux");
> -	if (IS_ERR(res->aux_clk))
> -		return PTR_ERR(res->aux_clk);
> +	res->clks[0].id = "aux";
> +	res->clks[1].id = "master_bus";
> +	res->clks[2].id = "slave_bus";
>  
> -	res->master_clk = devm_clk_get(dev, "master_bus");
> -	if (IS_ERR(res->master_clk))
> -		return PTR_ERR(res->master_clk);
> +	res->num_clks = 3;
>  
> -	res->slave_clk = devm_clk_get(dev, "slave_bus");
> -	if (IS_ERR(res->slave_clk))
> -		return PTR_ERR(res->slave_clk);
> +	ret = devm_clk_bulk_get(dev, res->num_clks, res->clks);
> +	if (ret < 0)
> +		return ret;
>  
>  	res->axi_m_reset = devm_reset_control_get_exclusive(dev, "axi_m");
>  	if (IS_ERR(res->axi_m_reset))
> @@ -719,9 +718,7 @@ static void qcom_pcie_deinit_2_4_0(struct qcom_pcie *pcie)
>  	reset_control_assert(res->axi_m_sticky_reset);
>  	reset_control_assert(res->pwr_reset);
>  	reset_control_assert(res->ahb_reset);
> -	clk_disable_unprepare(res->aux_clk);
> -	clk_disable_unprepare(res->master_clk);
> -	clk_disable_unprepare(res->slave_clk);
> +	clk_bulk_disable_unprepare(res->num_clks, res->clks);
>  }
>  
>  static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
> @@ -850,23 +847,9 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
>  
>  	usleep_range(10000, 12000);
>  
> -	ret = clk_prepare_enable(res->aux_clk);
> -	if (ret) {
> -		dev_err(dev, "cannot prepare/enable iface clock\n");
> +	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
> +	if (ret)
>  		goto err_clk_aux;
> -	}
> -
> -	ret = clk_prepare_enable(res->master_clk);
> -	if (ret) {
> -		dev_err(dev, "cannot prepare/enable core clock\n");
> -		goto err_clk_axi_m;
> -	}
> -
> -	ret = clk_prepare_enable(res->slave_clk);
> -	if (ret) {
> -		dev_err(dev, "cannot prepare/enable phy clock\n");
> -		goto err_clk_axi_s;
> -	}
>  
>  	/* enable PCIe clocks and resets */
>  	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> @@ -891,10 +874,6 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
>  
>  	return 0;
>  
> -err_clk_axi_s:
> -	clk_disable_unprepare(res->master_clk);
> -err_clk_axi_m:
> -	clk_disable_unprepare(res->aux_clk);
>  err_clk_aux:
>  	reset_control_assert(res->ahb_reset);
>  err_rst_ahb:
> -- 
> 2.18.0


rest lgtm:

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
