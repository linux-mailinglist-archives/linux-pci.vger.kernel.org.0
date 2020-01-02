Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A42B812E5F5
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2020 13:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgABMCH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jan 2020 07:02:07 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52109 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbgABMCH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jan 2020 07:02:07 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1imzAw-00030W-Mq; Thu, 02 Jan 2020 13:02:02 +0100
Message-ID: <7b3bfaa065dd5c647522baaac4dcd9a3b34dfb44.camel@pengutronix.de>
Subject: Re: [PATCH v3 2/2] PCI: qcom: Add support for SDM845 PCIe controller
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Date:   Thu, 02 Jan 2020 13:02:00 +0100
In-Reply-To: <20191107001642.1127561-3-bjorn.andersson@linaro.org>
References: <20191107001642.1127561-1-bjorn.andersson@linaro.org>
         <20191107001642.1127561-3-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2019-11-06 at 16:16 -0800, Bjorn Andersson wrote:
> The SDM845 has one Gen2 and one Gen3 controller, add support for these.
> 
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - Don't assert the reset in the failure path
> 
>  drivers/pci/controller/dwc/pcie-qcom.c | 150 +++++++++++++++++++++++++
>  1 file changed, 150 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 7e581748ee9f..5ea527a6bd9f 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
[...]
> @@ -139,12 +142,20 @@ struct qcom_pcie_resources_2_3_3 {
>  	struct reset_control *rst[7];
>  };
>  
> +struct qcom_pcie_resources_2_7_0 {
> +	struct clk_bulk_data clks[6];
> +	struct regulator_bulk_data supplies[2];
> +	struct reset_control *pci_reset;
> +	struct clk *pipe_clk;
> +};
> +
>  union qcom_pcie_resources {
>  	struct qcom_pcie_resources_1_0_0 v1_0_0;
>  	struct qcom_pcie_resources_2_1_0 v2_1_0;
>  	struct qcom_pcie_resources_2_3_2 v2_3_2;
>  	struct qcom_pcie_resources_2_3_3 v2_3_3;
>  	struct qcom_pcie_resources_2_4_0 v2_4_0;
> +	struct qcom_pcie_resources_2_7_0 v2_7_0;
>  };
>  
>  struct qcom_pcie;
> @@ -1068,6 +1079,134 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
>  	return ret;
>  }
>  
> +static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> +	struct dw_pcie *pci = pcie->pci;
> +	struct device *dev = pci->dev;
> +	int ret;
> +
> +	res->pci_reset = devm_reset_control_get_exclusive(dev, "pci");
> +	if (IS_ERR(res->pci_reset))
> +		return PTR_ERR(res->pci_reset);
> +
> +	res->supplies[0].supply = "vdda";
> +	res->supplies[1].supply = "vddpe-3v3";
> +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(res->supplies),
> +				      res->supplies);
> +	if (ret)
> +		return ret;
> +
> +	res->clks[0].id = "aux";
> +	res->clks[1].id = "cfg";
> +	res->clks[2].id = "bus_master";
> +	res->clks[3].id = "bus_slave";
> +	res->clks[4].id = "slave_q2a";
> +	res->clks[5].id = "tbu";
> +
> +	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
> +	if (ret < 0)
> +		return ret;
> +
> +	res->pipe_clk = devm_clk_get(dev, "pipe");
> +	return PTR_ERR_OR_ZERO(res->pipe_clk);
> +}
> +
> +static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> +	struct dw_pcie *pci = pcie->pci;
> +	struct device *dev = pci->dev;
> +	u32 val;
> +	int ret;
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(res->supplies), res->supplies);
> +	if (ret < 0) {
> +		dev_err(dev, "cannot enable regulators\n");
> +		return ret;
> +	}
> +
> +	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
> +	if (ret < 0)
> +		goto err_disable_regulators;
> +
> +	ret = reset_control_assert(res->pci_reset);
> +	if (ret < 0) {
> +		dev_err(dev, "cannot deassert pci reset\n");

s/deassert/assert/

in the error message. Apart from that,

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

