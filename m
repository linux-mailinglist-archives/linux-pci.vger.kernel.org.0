Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24D3BEDBCA
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2019 10:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfKDJlb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Nov 2019 04:41:31 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40675 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfKDJlb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Nov 2019 04:41:31 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1iRYrU-0001Jf-Ra; Mon, 04 Nov 2019 10:41:24 +0100
Message-ID: <776ec4265217cc83e9e847ff3c80a52a86390b1b.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/2] PCI: qcom: Add support for SDM845 PCIe controller
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 04 Nov 2019 10:41:23 +0100
In-Reply-To: <20191102002721.4091180-3-bjorn.andersson@linaro.org>
References: <20191102002721.4091180-1-bjorn.andersson@linaro.org>
         <20191102002721.4091180-3-bjorn.andersson@linaro.org>
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

Hi Bjorn,

On Fri, 2019-11-01 at 17:27 -0700, Bjorn Andersson wrote:
> The SDM845 has one Gen2 and one Gen3 controller, add support for these.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - Style changes requested by Stan
> - Tested with second PCIe controller as well
> 
>  drivers/pci/controller/dwc/pcie-qcom.c | 152 +++++++++++++++++++++++++
>  1 file changed, 152 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 7e581748ee9f..35f4980480bb 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -54,6 +54,7 @@
[...]
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
> +		goto err_disable_clocks;
> +	}

If for any of the above fails, the reset line is left in its default
state, presumably unasserted. Is there a reason to assert and keep it
asserted if enabling the clocks fails below?

> +	msleep(20);
> +
> +	ret = reset_control_deassert(res->pci_reset);
> +	if (ret < 0) {
> +		dev_err(dev, "cannot deassert pci reset\n");
> +		goto err_assert_resets;

Nitpick: this seems superfluous since the reset line was just asserted
20 ms before. Maybe just:

		goto err_disable_clocks;

> +	}
> +
> +	ret = clk_prepare_enable(res->pipe_clk);
> +	if (ret) {
> +		dev_err(dev, "cannot prepare/enable pipe clock\n");
> +		goto err_assert_resets;
> +	}
> +
> +	/* configure PCIe to RC mode */
> +	writel(DEVICE_TYPE_RC, pcie->parf + PCIE20_PARF_DEVICE_TYPE);
> +
> +	/* enable PCIe clocks and resets */
> +	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> +	val &= ~BIT(0);
> +	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
> +
> +	/* change DBI base address */
> +	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
> +
> +	/* MAC PHY_POWERDOWN MUX DISABLE  */
> +	val = readl(pcie->parf + PCIE20_PARF_SYS_CTRL);
> +	val &= ~BIT(29);
> +	writel(val, pcie->parf + PCIE20_PARF_SYS_CTRL);
> +
> +	val = readl(pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
> +	val |= BIT(4);
> +	writel(val, pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
> +		val |= BIT(31);
> +		writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
> +	}
> +
> +	return 0;
> +err_assert_resets:
> +	reset_control_assert(res->pci_reset);

So maybe this can just be removed. The reset isn't asserted in deinit
either.

regards
Philipp

