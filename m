Return-Path: <linux-pci+bounces-21371-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F6AA34C65
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 18:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEED816A62B
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 17:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E8C227EAA;
	Thu, 13 Feb 2025 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dInBiCtJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4226221552;
	Thu, 13 Feb 2025 17:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469126; cv=none; b=DOdcgU5UZio9MouWS4mcQkcxd+EyRxMa5rjdDD6q8g2Swmif7ECpHBp0560jJy4XJOMIWfKNHSHQ+j/Q9t81czsQYKQvo29TRbGjJxrBiuEbYR7XMwFfZoTpf+dZ9RODN6360XVrlULVL5eIZtZIyAcMQltJXkwppe2ullTGbbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469126; c=relaxed/simple;
	bh=18EWLB2pB/NlRAF4HZZXJS64bPlvLghFnDimCTazs4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STX1ijlDRD0LLJs0MjEt1FcZuoXvZ5V+2vDEF0IDZwy2Kptql070YI0AX7mkwPQjnWL+wRnTvS4rK2kdLCn2WgeYpNLiY6lDu3e/mxVP+9VC48ztvS9ikL6m4h4KjHgWZuEUtwuUT/Rd5RqKak5w5XgZXWbzoAV/O0xy0E3J0n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dInBiCtJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AAEC4CED1;
	Thu, 13 Feb 2025 17:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739469126;
	bh=18EWLB2pB/NlRAF4HZZXJS64bPlvLghFnDimCTazs4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dInBiCtJvpBId06Il7SFxhv2Hd8WX58cit+dYrIWh9Z+8pyLbkw8kzF27+5uxNI5H
	 7HHgsqtfOCxY7HubYlUOHoQhiD5ZtWyiKfc+eKcaT6dLkASbNAMstErXCkMO0pAUwM
	 ROee4sY/uu7fp41QAwy3uX+ZBE0NMKMuRogsUaXZiTk8qAaAu7JBYMijW1+uRY0e9U
	 1P7qfFt/G9qU5CreSCUnTO17BwEvCAIYtzrVuCqvLPqAYjERzgRr020jM3JuowRfMr
	 2uVGc8tyaDlX4OEfCSJij6CrbUvLg8eJclfFf+W4PpyNn7q3opgx4Dwp5OrAiVNttF
	 0N6O8ON2b62HQ==
Date: Thu, 13 Feb 2025 23:22:01 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, kishon@kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, p.zabel@pengutronix.de,
	quic_nsekar@quicinc.com, dmitry.baryshkov@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org
Subject: Re: [PATCH v10 2/7] phy: qcom: Introduce PCIe UNIPHY 28LP driver
Message-ID: <Z64xQcgHIgAEzKFb@vaman>
References: <20250206121803.1128216-1-quic_varada@quicinc.com>
 <20250206121803.1128216-3-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206121803.1128216-3-quic_varada@quicinc.com>

On 06-02-25, 17:47, Varadarajan Narayanan wrote:
> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> 
> Add Qualcomm PCIe UNIPHY 28LP driver support present in Qualcomm IPQ5332
> SoC and the phy init sequence.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v9: Align with dt-bindings and make num-lanes mandatory. Return error if not
>     present
>     Add new line before return in one of the functions
> 
> v6: Use generally followed pattern for getting num-lanes from DT
> 
> v5: * Use 'num-lanes' to differentiate instead of '3x1' or '3x2'
>       in compatible string
>     * Drop compatible specific init data as there is only one
>       compatible string
>     * Fix header file order
> 
> v4: Fix uppercase hex digit
>     Use phy->id for pipe clock source
> 
> v3: Added 'Reviewed-by: Dmitry Baryshkov' and made following updates
>     s/unsigned int/u32/g
>     Fix 'lane_offset' comments
>     Fix #define tab -> space
>     Fix mixed case hex numbers
>     Fix licensing & owner
>     Change for-loop pointer to use [] instead of ->
>     Use 'less than max' instead of 'not equal to max' in termination condition
>     Smatch and Coccinelle passed
> 
> v2: Drop IPQ5018 related code and data
>     Use uniform prefix for struct names
>     Place "}, {", on the same line
>     In qcom_uniphy_pcie_init(), use for-loop instead of while
>     Swap reset and clock disable order in qcom_uniphy_pcie_power_off
>     Add reset assert to qcom_uniphy_pcie_power_on's error path
>     Use macros for usleep duration
>     Inlined qcom_uniphy_pcie_get_resources & use devm_platform_get_and_ioremap_resource
>     Drop 'clock-output-names' from phy_pipe_clk_register
> ---
>  drivers/phy/qualcomm/Kconfig                  |  12 +
>  drivers/phy/qualcomm/Makefile                 |   1 +
>  .../phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c  | 287 ++++++++++++++++++
>  3 files changed, 300 insertions(+)
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c
> 
> diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
> index 846f8c99547f..a6b71fda1b9c 100644
> --- a/drivers/phy/qualcomm/Kconfig
> +++ b/drivers/phy/qualcomm/Kconfig
> @@ -154,6 +154,18 @@ config PHY_QCOM_M31_USB
>  	  management. This driver is required even for peripheral only or
>  	  host only mode configurations.
>  
> +config PHY_QCOM_UNIPHY_PCIE_28LP
> +	bool "PCIE UNIPHY 28LP PHY driver"
> +	depends on ARCH_QCOM
> +	depends on HAS_IOMEM
> +	depends on OF
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support the PCIe UNIPHY 28LP phy transceiver that
> +	  is used with PCIe controllers on Qualcomm IPQ5332 chips. It
> +	  handles PHY initialization, clock management required after
> +	  resetting the hardware and power management.
> +
>  config PHY_QCOM_USB_HS
>  	tristate "Qualcomm USB HS PHY module"
>  	depends on USB_ULPI_BUS
> diff --git a/drivers/phy/qualcomm/Makefile b/drivers/phy/qualcomm/Makefile
> index eb60e950ad53..42038bc30974 100644
> --- a/drivers/phy/qualcomm/Makefile
> +++ b/drivers/phy/qualcomm/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_PHY_QCOM_QMP_USB_LEGACY)	+= phy-qcom-qmp-usb-legacy.o
>  obj-$(CONFIG_PHY_QCOM_QUSB2)		+= phy-qcom-qusb2.o
>  obj-$(CONFIG_PHY_QCOM_SNPS_EUSB2)	+= phy-qcom-snps-eusb2.o
>  obj-$(CONFIG_PHY_QCOM_EUSB2_REPEATER)	+= phy-qcom-eusb2-repeater.o
> +obj-$(CONFIG_PHY_QCOM_UNIPHY_PCIE_28LP)	+= phy-qcom-uniphy-pcie-28lp.o
>  obj-$(CONFIG_PHY_QCOM_USB_HS) 		+= phy-qcom-usb-hs.o
>  obj-$(CONFIG_PHY_QCOM_USB_HSIC) 	+= phy-qcom-usb-hsic.o
>  obj-$(CONFIG_PHY_QCOM_USB_HS_28NM)	+= phy-qcom-usb-hs-28nm.o
> diff --git a/drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c b/drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c
> new file mode 100644
> index 000000000000..311f98181177
> --- /dev/null
> +++ b/drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c
> @@ -0,0 +1,287 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2025, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +
> +#define RST_ASSERT_DELAY_MIN_US		100
> +#define RST_ASSERT_DELAY_MAX_US		150
> +#define PIPE_CLK_DELAY_MIN_US		5000
> +#define PIPE_CLK_DELAY_MAX_US		5100
> +#define CLK_EN_DELAY_MIN_US		30
> +#define CLK_EN_DELAY_MAX_US		50
> +#define CDR_CTRL_REG_1		0x80
> +#define CDR_CTRL_REG_2		0x84
> +#define CDR_CTRL_REG_3		0x88
> +#define CDR_CTRL_REG_4		0x8c
> +#define CDR_CTRL_REG_5		0x90
> +#define CDR_CTRL_REG_6		0x94
> +#define CDR_CTRL_REG_7		0x98
> +#define SSCG_CTRL_REG_1		0x9c
> +#define SSCG_CTRL_REG_2		0xa0
> +#define SSCG_CTRL_REG_3		0xa4
> +#define SSCG_CTRL_REG_4		0xa8
> +#define SSCG_CTRL_REG_5		0xac
> +#define SSCG_CTRL_REG_6		0xb0
> +#define PCS_INTERNAL_CONTROL_2	0x2d8
> +
> +#define PHY_CFG_PLLCFG				0x220
> +#define PHY_CFG_EIOS_DTCT_REG			0x3e4
> +#define PHY_CFG_GEN3_ALIGN_HOLDOFF_TIME		0x3e8
> +
> +#define PHY_MODE_FIXED		0x1

where is this used?

> +
> +enum qcom_uniphy_pcie_type {
> +	PHY_TYPE_PCIE = 1,
> +	PHY_TYPE_PCIE_GEN2,
> +	PHY_TYPE_PCIE_GEN3,
> +};
> +
> +struct qcom_uniphy_pcie_regs {
> +	u32 offset;
> +	u32 val;
> +};
> +
> +struct qcom_uniphy_pcie_data {
> +	int lane_offset; /* offset between the lane register bases */
> +	u32 phy_type;
> +	const struct qcom_uniphy_pcie_regs *init_seq;
> +	u32 init_seq_num;
> +	u32 pipe_clk_rate;
> +};
> +
> +struct qcom_uniphy_pcie {
> +	struct phy phy;
> +	struct device *dev;
> +	const struct qcom_uniphy_pcie_data *data;
> +	struct clk_bulk_data *clks;
> +	int num_clks;
> +	struct reset_control *resets;
> +	void __iomem *base;
> +	int lanes;
> +};
> +
> +#define phy_to_dw_phy(x)	container_of((x), struct qca_uni_pcie_phy, phy)
> +
> +static const struct qcom_uniphy_pcie_regs ipq5332_regs[] = {
> +	{
> +		.offset = PHY_CFG_PLLCFG,
> +		.val = 0x30,
> +	}, {
> +		.offset = PHY_CFG_EIOS_DTCT_REG,
> +		.val = 0x53ef,
> +	}, {
> +		.offset = PHY_CFG_GEN3_ALIGN_HOLDOFF_TIME,
> +		.val = 0xcf,
> +	},
> +};
> +
> +static const struct qcom_uniphy_pcie_data ipq5332_data = {
> +	.lane_offset	= 0x800,
> +	.phy_type	= PHY_TYPE_PCIE_GEN3,
> +	.init_seq	= ipq5332_regs,
> +	.init_seq_num	= ARRAY_SIZE(ipq5332_regs),
> +	.pipe_clk_rate	= 250000000,

can be written as 250 * MEGA

> +};
> +
> +static void qcom_uniphy_pcie_init(struct qcom_uniphy_pcie *phy)
> +{
> +	const struct qcom_uniphy_pcie_data *data = phy->data;
> +	const struct qcom_uniphy_pcie_regs *init_seq;
> +	void __iomem *base = phy->base;
> +	int lane, i;
> +
> +	for (lane = 0; lane < phy->lanes; lane++) {
> +		init_seq = data->init_seq;
> +
> +		for (i = 0; i < data->init_seq_num; i++)
> +			writel(init_seq[i].val, base + init_seq[i].offset);
> +
> +		base += data->lane_offset;
> +	}
> +}
> +
> +static int qcom_uniphy_pcie_power_off(struct phy *x)
> +{
> +	struct qcom_uniphy_pcie *phy = phy_get_drvdata(x);
> +
> +	clk_bulk_disable_unprepare(phy->num_clks, phy->clks);
> +
> +	return reset_control_assert(phy->resets);
> +}
> +
> +static int qcom_uniphy_pcie_power_on(struct phy *x)
> +{
> +	struct qcom_uniphy_pcie *phy = phy_get_drvdata(x);
> +	int ret;
> +
> +	ret = reset_control_assert(phy->resets);
> +	if (ret) {
> +		dev_err(phy->dev, "reset assert failed (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	usleep_range(RST_ASSERT_DELAY_MIN_US, RST_ASSERT_DELAY_MAX_US);
> +
> +	ret = reset_control_deassert(phy->resets);
> +	if (ret) {
> +		dev_err(phy->dev, "reset deassert failed (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	usleep_range(PIPE_CLK_DELAY_MIN_US, PIPE_CLK_DELAY_MAX_US);
> +
> +	ret = clk_bulk_prepare_enable(phy->num_clks, phy->clks);
> +	if (ret) {
> +		dev_err(phy->dev, "clk prepare and enable failed %d\n", ret);
> +		return ret;
> +	}
> +
> +	usleep_range(CLK_EN_DELAY_MIN_US, CLK_EN_DELAY_MAX_US);
> +
> +	qcom_uniphy_pcie_init(phy);
> +
> +	return 0;
> +}
> +
> +static inline int qcom_uniphy_pcie_get_resources(struct platform_device *pdev,
> +						 struct qcom_uniphy_pcie *phy)
> +{
> +	struct resource *res;
> +
> +	phy->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(phy->base))
> +		return PTR_ERR(phy->base);
> +
> +	phy->num_clks = devm_clk_bulk_get_all(phy->dev, &phy->clks);
> +	if (phy->num_clks < 0)
> +		return phy->num_clks;
> +
> +	phy->resets = devm_reset_control_array_get_exclusive(phy->dev);
> +	if (IS_ERR(phy->resets))
> +		return PTR_ERR(phy->resets);
> +
> +	return 0;
> +}
> +
> +/*
> + * Register a fixed rate pipe clock.
> + *
> + * The <s>_pipe_clksrc generated by PHY goes to the GCC that gate
> + * controls it. The <s>_pipe_clk coming out of the GCC is requested
> + * by the PHY driver for its operations.
> + * We register the <s>_pipe_clksrc here. The gcc driver takes care
> + * of assigning this <s>_pipe_clksrc as parent to <s>_pipe_clk.
> + * Below picture shows this relationship.
> + *
> + *         +---------------+
> + *         |   PHY block   |<<---------------------------------------+
> + *         |               |                                         |
> + *         |   +-------+   |                   +-----+               |
> + *   I/P---^-->|  PLL  |---^--->pipe_clksrc--->| GCC |--->pipe_clk---+
> + *    clk  |   +-------+   |                   +-----+
> + *         +---------------+
> + */
> +static inline int phy_pipe_clk_register(struct qcom_uniphy_pcie *phy, int id)
> +{
> +	const struct qcom_uniphy_pcie_data *data = phy->data;
> +	struct clk_hw *hw;
> +	char name[64];
> +
> +	snprintf(name, sizeof(name), "phy%d_pipe_clk_src", id);
> +	hw = devm_clk_hw_register_fixed_rate(phy->dev, name, NULL, 0,
> +					     data->pipe_clk_rate);
> +	if (IS_ERR(hw))
> +		return dev_err_probe(phy->dev, PTR_ERR(hw),
> +				     "Unable to register %s\n", name);
> +
> +	return devm_of_clk_add_hw_provider(phy->dev, of_clk_hw_simple_get, hw);
> +}
> +
> +static const struct of_device_id qcom_uniphy_pcie_id_table[] = {
> +	{
> +		.compatible = "qcom,ipq5332-uniphy-pcie-phy",
> +		.data = &ipq5332_data,
> +	}, {
> +		/* Sentinel */
> +	},
> +};
> +MODULE_DEVICE_TABLE(of, qcom_uniphy_pcie_id_table);
> +
> +static const struct phy_ops pcie_ops = {
> +	.power_on	= qcom_uniphy_pcie_power_on,
> +	.power_off	= qcom_uniphy_pcie_power_off,
> +	.owner          = THIS_MODULE,
> +};
> +
> +static int qcom_uniphy_pcie_probe(struct platform_device *pdev)
> +{
> +	struct phy_provider *phy_provider;
> +	struct device *dev = &pdev->dev;
> +	struct qcom_uniphy_pcie *phy;
> +	struct phy *generic_phy;
> +	int ret;
> +
> +	phy = devm_kzalloc(&pdev->dev, sizeof(*phy), GFP_KERNEL);
> +	if (!phy)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, phy);
> +	phy->dev = &pdev->dev;
> +
> +	phy->data = of_device_get_match_data(dev);
> +	if (!phy->data)
> +		return -EINVAL;
> +
> +	ret = of_property_read_u32(dev_of_node(dev), "num-lanes", &phy->lanes);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Couldn't read num-lanes\n");
> +
> +	ret = qcom_uniphy_pcie_get_resources(pdev, phy);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to get resources: %d\n", ret);
> +
> +	generic_phy = devm_phy_create(phy->dev, NULL, &pcie_ops);
> +	if (IS_ERR(generic_phy))
> +		return PTR_ERR(generic_phy);
> +
> +	phy_set_drvdata(generic_phy, phy);
> +
> +	ret = phy_pipe_clk_register(phy, generic_phy->id);
> +	if (ret)
> +		dev_err(&pdev->dev, "failed to register phy pipe clk\n");
> +
> +	phy_provider = devm_of_phy_provider_register(phy->dev,
> +						     of_phy_simple_xlate);
> +	if (IS_ERR(phy_provider))
> +		return PTR_ERR(phy_provider);

should we not unroll the pipe clk registration here?

> +
> +	return 0;
> +}
> +
> +static struct platform_driver qcom_uniphy_pcie_driver = {
> +	.probe		= qcom_uniphy_pcie_probe,
> +	.driver		= {
> +		.name	= "qcom-uniphy-pcie",
> +		.of_match_table = qcom_uniphy_pcie_id_table,
> +	},
> +};
> +
> +module_platform_driver(qcom_uniphy_pcie_driver);
> +
> +MODULE_DESCRIPTION("PCIE QCOM UNIPHY driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.34.1

-- 
~Vinod

