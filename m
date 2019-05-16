Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B367320253
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2019 11:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfEPJOJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 May 2019 05:14:09 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:46871 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbfEPJOJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 May 2019 05:14:09 -0400
Received: from [192.168.27.209] (unknown [37.157.136.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 9CB4FCE62;
        Thu, 16 May 2019 12:14:06 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1557998046; bh=U7h5UbxFwM9HF2KK5k9ZsweizpqRxr6fmzDCvFTxsLY=;
        h=Subject:To:Cc:From:Date:From;
        b=dlAHB60cwE2q7geraVnyFJNr28gxi2t6TQCggZ1q78PSRsw4pBuECizxFG2Cr3P1O
         1XxHENfwWRdI8pV61dVlgzK+rASMEGi5oPqKqbKZzi+Gb4K7Uxbc9y7BlurorU5O1b
         qqe0+p3CWdWymJrcwCkaBA/T+KDRa9rGX0oqlDrVIwsHZG6hLpmypOfo43drWtJVs8
         bYrOzZMKelMh3cTygze0W7hiFQG+Tn1KdfXTaK4m6zupoeWq7HkdS2X/+M9eHr4gcf
         Vjb37XBBK1VYPZeYuk440j2RZJHS5OUjkagCtlAveMOs8tQUodIhPOPfEwlfHxiq4s
         RqoaKsEg6mT1w==
Subject: Re: [PATCH v3 1/3] PCI: qcom: Use clk_bulk API for 2.4.0 controllers
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190502001955.10575-1-bjorn.andersson@linaro.org>
 <20190502001955.10575-2-bjorn.andersson@linaro.org>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <fcfcd3b4-99d2-7b10-e82d-b92e6bf37a33@mm-sol.com>
Date:   Thu, 16 May 2019 12:14:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502001955.10575-2-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 5/2/19 3:19 AM, Bjorn Andersson wrote:
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

Use the new fresh define QCOM_PCIE_2_4_0_MAX_CLOCKS?

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

Maybe you have to change the name of the label too?

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
> 

-- 
regards,
Stan
