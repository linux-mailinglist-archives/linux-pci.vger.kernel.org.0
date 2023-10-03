Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F977B6CD0
	for <lists+linux-pci@lfdr.de>; Tue,  3 Oct 2023 17:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjJCPQK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Oct 2023 11:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjJCPQJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Oct 2023 11:16:09 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2550EA7
        for <linux-pci@vger.kernel.org>; Tue,  3 Oct 2023 08:16:03 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6c4fa1c804bso674721a34.2
        for <linux-pci@vger.kernel.org>; Tue, 03 Oct 2023 08:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696346162; x=1696950962; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pE6Uob1qUrl/8e+wUGqgR8VjacWMRkVbdY4sfkzHBEE=;
        b=kWYklJWjumJLFYq2mjTGzINOx7I4wuBYYsDhfAKfiSHaW5rh5CUSKsdQZTE4hv/YJW
         XJbYHq+9z+kbn5nF/Thu19KZN2r+ldAVVFewQXpLbiXWDrKzjylKR+1qTme0j6vOkXn9
         H/gUUyiLEtnO1CLQIm65cJtjQLB3Bf7a6gAx6IM1b1aYdMU+/mDupksgG02qH8wOyTzh
         37T8Jw278QCj8Vo/PrvUqZ7bRg0baRHRsz8EGqcRaHVHTNKqC4tV0rac3yBIW9aw9/cE
         +GrClhZSrioNFDxUu8/5q/rRlPNM5TY7vdt2+loxPlr1+OAUlyVhxAOU/nI0Q96N/CbS
         A8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696346162; x=1696950962;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pE6Uob1qUrl/8e+wUGqgR8VjacWMRkVbdY4sfkzHBEE=;
        b=cP92cs3e320IK8k+/a5x4uXvFMrF/L/DNgoJRDjsgljKUG8DI9k+QjoLt3icGScan8
         yO7BwdRR+FLq4xVDi8aXQbQY4U5uQrABM55NcOC+oMelzuKYLHEN6H07rFlgmWEcR4er
         i9E0TrMCKugeeMcdsHmmNNtq/UQX0Ih4mxxTL2AIkUTAxhC0MmiM16JUf1jNiXU/7gyg
         RVlg2CyxTz1yc2Q3XKbcd6gNCopwvQb50Y8N9zeXgg4qVmFTQCNQ6/13HUAwIvXqsM4G
         rrehk2+z+C9N/mDfO1PcCWVT7SgZOXvziXPWz5xP8Uu5q0arThE9//yKHf1CoWqBkagU
         Cbdg==
X-Gm-Message-State: AOJu0YwEbeajke2fMj4/r+9pHXpDeFu3RUty1KTfoE2VNwcwh+SbPgW/
        9DvnJCaxyBvN6pAhAF6moQdOIwjzS8QmcRBbIto6Vw==
X-Google-Smtp-Source: AGHT+IEqhmLmT0s+0uqq+EnaJP5NNo5ifYJD5F0JGVCmiLNmZF2EtNn2buV1AsI4hN0t+AOJuIOnz/JFUhFdHzQ7x/o=
X-Received: by 2002:a05:6808:1407:b0:3ae:251f:923f with SMTP id
 w7-20020a056808140700b003ae251f923fmr20306144oiv.28.1696346162306; Tue, 03
 Oct 2023 08:16:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231003120846.28626-1-quic_nsekar@quicinc.com> <20231003120846.28626-4-quic_nsekar@quicinc.com>
In-Reply-To: <20231003120846.28626-4-quic_nsekar@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 3 Oct 2023 18:15:50 +0300
Message-ID: <CAA8EJpqz+abgiOjYukVvzmz_c-wuQMfDpLYfxnRTsVN8J1Smkg@mail.gmail.com>
Subject: Re: [PATCH 3/6] phy: qcom: Introduce PCIe UNIPHY 28LP driver
To:     Nitheesh Sekar <quic_nsekar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org,
        mani@kernel.org, p.zabel@pengutronix.de, quic_srichara@quicinc.com,
        quic_varada@quicinc.com, quic_ipkumar@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 3 Oct 2023 at 15:09, Nitheesh Sekar <quic_nsekar@quicinc.com> wrote:
>
> Add Qualcomm PCIe UNIPHY 28LP driver support present
> in Qualcomm IPQ5018 SoC and the phy init sequence.
>
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> ---
>  drivers/phy/qualcomm/Kconfig                  |  12 +
>  drivers/phy/qualcomm/Makefile                 |   1 +
>  .../phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c  | 336 ++++++++++++++++++
>  3 files changed, 349 insertions(+)
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c
>
> diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
> index d891058b7c39..b7d37cd98f02 100644
> --- a/drivers/phy/qualcomm/Kconfig
> +++ b/drivers/phy/qualcomm/Kconfig
> @@ -154,6 +154,18 @@ config PHY_QCOM_M31_USB
>           management. This driver is required even for peripheral only or
>           host only mode configurations.
>
> +config PHY_QCOM_UNIPHY_PCIE_28LP
> +       bool "PCIE UNIPHY 28LP PHY driver"
> +       depends on ARCH_QCOM
> +       depends on HAS_IOMEM
> +       depends on OF
> +       select GENERIC_PHY
> +       help
> +         Enable this to support the PCIe UNIPHY 28LP phy transceiver that
> +         is used with PCIe controllers on Qualcomm IPQ5018 chips. It
> +         handles PHY initialization, clock management required after
> +         resetting the hardware and power management.
> +
>  config PHY_QCOM_USB_HS
>         tristate "Qualcomm USB HS PHY module"
>         depends on USB_ULPI_BUS
> diff --git a/drivers/phy/qualcomm/Makefile b/drivers/phy/qualcomm/Makefile
> index ffd609ac6233..31105cd17bc9 100644
> --- a/drivers/phy/qualcomm/Makefile
> +++ b/drivers/phy/qualcomm/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_PHY_QCOM_QMP_USB_LEGACY) += phy-qcom-qmp-usb-legacy.o
>  obj-$(CONFIG_PHY_QCOM_QUSB2)           += phy-qcom-qusb2.o
>  obj-$(CONFIG_PHY_QCOM_SNPS_EUSB2)      += phy-qcom-snps-eusb2.o
>  obj-$(CONFIG_PHY_QCOM_EUSB2_REPEATER)  += phy-qcom-eusb2-repeater.o
> +obj-$(CONFIG_PHY_QCOM_UNIPHY_PCIE_28LP)        += phy-qcom-uniphy-pcie-28lp.o
>  obj-$(CONFIG_PHY_QCOM_USB_HS)          += phy-qcom-usb-hs.o
>  obj-$(CONFIG_PHY_QCOM_USB_HSIC)        += phy-qcom-usb-hsic.o
>  obj-$(CONFIG_PHY_QCOM_USB_HS_28NM)     += phy-qcom-usb-hs-28nm.o
> diff --git a/drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c b/drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c
> new file mode 100644
> index 000000000000..5ef6ae7276cf
> --- /dev/null
> +++ b/drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c
> @@ -0,0 +1,336 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2023, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/phy/phy.h>
> +#include <linux/reset.h>
> +#include <linux/of_device.h>
> +#include <linux/delay.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +
> +#define PIPE_CLK_DELAY_MIN_US                  5000
> +#define PIPE_CLK_DELAY_MAX_US                  5100
> +#define CDR_CTRL_REG_1         0x80
> +#define CDR_CTRL_REG_2         0x84
> +#define CDR_CTRL_REG_3         0x88
> +#define CDR_CTRL_REG_4         0x8C
> +#define CDR_CTRL_REG_5         0x90
> +#define CDR_CTRL_REG_6         0x94
> +#define CDR_CTRL_REG_7         0x98
> +#define SSCG_CTRL_REG_1                0x9c
> +#define SSCG_CTRL_REG_2                0xa0
> +#define SSCG_CTRL_REG_3                0xa4
> +#define SSCG_CTRL_REG_4                0xa8
> +#define SSCG_CTRL_REG_5                0xac
> +#define SSCG_CTRL_REG_6                0xb0
> +#define PCS_INTERNAL_CONTROL_2 0x2d8
> +
> +#define PHY_MODE_FIXED         0x1
> +
> +enum qcom_uniphy_pcie_type {
> +       PHY_TYPE_PCIE = 1,
> +       PHY_TYPE_PCIE_GEN2,
> +       PHY_TYPE_PCIE_GEN3,
> +};
> +
> +struct uniphy_regs {
> +       unsigned int offset;
> +       unsigned int val;
> +};
> +
> +struct uniphy_pcie_data {

Please stick to a single symbol/struct prefix.

> +       int lanes;
> +       /* 2nd lane offset */
> +       int lane_offset;
> +       unsigned int phy_type;
> +       const struct uniphy_regs *init_seq;
> +       unsigned int init_seq_num;
> +};
> +
> +struct qcom_uniphy_pcie {
> +       struct phy phy;
> +       struct device *dev;
> +       const struct uniphy_pcie_data *data;
> +       struct clk_bulk_data *clks;
> +       int num_clks;
> +       struct reset_control *resets;
> +       void __iomem *base;
> +};
> +
> +#define        phy_to_dw_phy(x)        container_of((x), struct qca_uni_pcie_phy, phy)
> +
> +static const struct uniphy_regs ipq5018_regs[] = {
> +       {
> +               .offset = SSCG_CTRL_REG_4,
> +               .val = 0x1cb9,
> +       },
> +       {

"}, {", on the same line.

> +               .offset = SSCG_CTRL_REG_5,
> +               .val = 0x023a,
> +       },
> +       {
> +               .offset = SSCG_CTRL_REG_3,
> +               .val = 0xd360,
> +       },
> +       {
> +               .offset = SSCG_CTRL_REG_1,
> +               .val = 0x1,
> +       },
> +       {
> +               .offset = SSCG_CTRL_REG_2,
> +               .val = 0xeb,
> +       },
> +       {
> +               .offset = CDR_CTRL_REG_4,
> +               .val = 0x3f9,
> +       },
> +       {
> +               .offset = CDR_CTRL_REG_5,
> +               .val = 0x1c9,
> +       },
> +       {
> +               .offset = CDR_CTRL_REG_2,
> +               .val = 0x419,
> +       },
> +       {
> +               .offset = CDR_CTRL_REG_1,
> +               .val = 0x200,
> +       },
> +       {
> +               .offset = PCS_INTERNAL_CONTROL_2,
> +               .val = 0xf101,
> +       },
> +};
> +
> +static const struct uniphy_pcie_data ipq5018_2x2_data = {
> +       .lanes          = 2,
> +       .lane_offset    = 0x800,
> +       .phy_type       = PHY_TYPE_PCIE_GEN2,
> +       .init_seq       = ipq5018_regs,
> +       .init_seq_num   = ARRAY_SIZE(ipq5018_regs),
> +};
> +
> +static void qcom_uniphy_pcie_init(struct qcom_uniphy_pcie *phy)
> +{
> +       const struct uniphy_pcie_data *data = phy->data;
> +       const struct uniphy_regs *init_seq;
> +       void __iomem *base = phy->base;
> +       int lane = 0;
> +       int i;
> +
> +       while (lane != data->lanes) {

for (lane = 0; ...)

> +               init_seq = data->init_seq;
> +
> +               for (i = 0; i < data->init_seq_num; i++, init_seq++)
> +                       writel(init_seq->val, base + init_seq->offset);
> +
> +               if (data->lanes == 2)
> +                       base = base + data->lane_offset;

Drop the if(). Use +=.

> +
> +               lane++;
> +       }
> +}
> +
> +static int qcom_uniphy_pcie_power_off(struct phy *x)
> +{
> +       struct qcom_uniphy_pcie *phy = phy_get_drvdata(x);
> +
> +       reset_control_assert(phy->resets);
> +
> +       clk_bulk_disable_unprepare(phy->num_clks, phy->clks);

Judging from power_on(), the order should be opposite.

> +
> +       return 0;
> +}
> +
> +static int qcom_uniphy_pcie_power_on(struct phy *x)
> +{
> +       int ret;
> +       struct qcom_uniphy_pcie *phy = phy_get_drvdata(x);
> +
> +       ret = reset_control_assert(phy->resets);
> +       if (ret) {
> +               dev_err(phy->dev, "reset assert failed (%d)\n", ret);
> +               return ret;
> +       }
> +
> +       /*
> +        * Delay periods before and after reset deassert are working values
> +        * from downstream Codeaurora kernel
> +        */
> +       usleep_range(100, 150);
> +
> +       ret = reset_control_deassert(phy->resets);
> +       if (ret) {
> +               dev_err(phy->dev, "reset deassert failed (%d)\n", ret);
> +               return ret;
> +       }
> +
> +       usleep_range(PIPE_CLK_DELAY_MIN_US, PIPE_CLK_DELAY_MAX_US);
> +
> +       ret = clk_bulk_prepare_enable(phy->num_clks, phy->clks);
> +       if (ret) {
> +               dev_err(phy->dev, "clk prepare and enable failed %d\n", ret);
> +               return ret;

Shouldn't the reset be asserted again?

> +       }
> +
> +       usleep_range(30, 50);

In the same function you have one usleep_range with the defined
constants and another one using plain numbers. Could you please stick
to the uniform scheme?

> +
> +       qcom_uniphy_pcie_init(phy);
> +       return 0;
> +}
> +
> +static int qcom_uniphy_pcie_get_resources(struct platform_device *pdev,
> +                                         struct qcom_uniphy_pcie *phy)

inline it

> +{
> +       struct resource *res;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       phy->base = devm_ioremap_resource(phy->dev, res);

devm_platform_get_and_ioremap_resource()

> +       if (IS_ERR(phy->base)) {
> +               dev_err(phy->dev, "cannot get phy registers\n");
> +               return PTR_ERR(phy->base);
> +       }
> +
> +       phy->num_clks = devm_clk_bulk_get_all(phy->dev, &phy->clks);
> +       if (phy->num_clks < 0)
> +               return phy->num_clks;
> +
> +       phy->resets = devm_reset_control_array_get_exclusive(phy->dev);
> +       if (IS_ERR(phy->resets))
> +               return PTR_ERR(phy->resets);
> +
> +       return 0;
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
> +static int phy_pipe_clk_register(struct qcom_uniphy_pcie  *phy,
> +                                struct device_node *np)
> +{
> +       struct clk_fixed_rate *fixed;
> +       struct clk_init_data init = { };
> +       int ret;
> +
> +       ret = of_property_read_string(np, "clock-output-names", &init.name);
> +       if (ret) {
> +               dev_err(phy->dev, "%pOFn: No clock-output-names\n", np);
> +               return ret;
> +       }

Can we drop clock-output-names please.

> +
> +       fixed = devm_kzalloc(phy->dev, sizeof(*fixed), GFP_KERNEL);
> +       if (!fixed)
> +               return -ENOMEM;
> +
> +       init.ops = &clk_fixed_rate_ops;
> +       fixed->fixed_rate = 125000000;
> +       fixed->hw.init = &init;
> +
> +       ret = devm_clk_hw_register(phy->dev, &fixed->hw);
> +       if (ret)
> +               return ret;

devm_clk_hw_register_fixed_rate().  Then the whole function can be inlined.

> +
> +       ret = devm_of_clk_add_hw_provider(phy->dev, of_clk_hw_simple_get,
> +                                         &fixed->hw);
> +       if (ret)
> +               return ret;
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id qcom_uniphy_pcie_id_table[] = {
> +       {
> +               .compatible = "qcom,ipq5018-uniphy-pcie-gen2x2",

Bindings describe both 2x1 and 2x2 PHYs, but the driver supports only
2x2. Either of that should be fixed.


> +               .data = &ipq5018_2x2_data,
> +       },
> +       { /* Sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, qcom_uniphy_pcie_id_table);
> +
> +static const struct phy_ops pcie_ops = {
> +       .power_on       = qcom_uniphy_pcie_power_on,
> +       .power_off      = qcom_uniphy_pcie_power_off,
> +       .owner          = THIS_MODULE,
> +};
> +
> +static int qcom_uniphy_pcie_probe(struct platform_device *pdev)
> +{
> +       struct qcom_uniphy_pcie *phy;
> +       int ret;
> +       struct phy *generic_phy;
> +       struct phy_provider *phy_provider;
> +       struct device *dev = &pdev->dev;
> +       struct device_node *np = of_node_get(dev->of_node);
> +
> +       phy = devm_kzalloc(&pdev->dev, sizeof(*phy), GFP_KERNEL);
> +       if (!phy)
> +               return -ENOMEM;
> +
> +       platform_set_drvdata(pdev, phy);
> +       phy->dev = &pdev->dev;
> +
> +       phy->data = of_device_get_match_data(dev);
> +       if (!phy->data)
> +               return -EINVAL;
> +
> +       ret = qcom_uniphy_pcie_get_resources(pdev, phy);
> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "failed to get resources: %d\n", ret);
> +               return ret;
> +       }
> +
> +       ret = phy_pipe_clk_register(phy, np);
> +       if (ret)
> +               dev_err(&pdev->dev, "failed to register phy pipe clk\n");
> +
> +       generic_phy = devm_phy_create(phy->dev, NULL, &pcie_ops);
> +       if (IS_ERR(generic_phy))
> +               return PTR_ERR(generic_phy);
> +
> +       phy_set_drvdata(generic_phy, phy);
> +       phy_provider = devm_of_phy_provider_register(phy->dev,
> +                                                    of_phy_simple_xlate);
> +       if (IS_ERR(phy_provider))
> +               return PTR_ERR(phy_provider);
> +
> +       return 0;
> +}
> +
> +static struct platform_driver qcom_uniphy_pcie_driver = {
> +       .probe          = qcom_uniphy_pcie_probe,
> +       .driver         = {
> +               .name   = "qcom-uniphy-pcie",
> +               .owner  = THIS_MODULE,
> +               .of_match_table = qcom_uniphy_pcie_id_table,
> +       },
> +};
> +
> +module_platform_driver(qcom_uniphy_pcie_driver);
> +
> +MODULE_ALIAS("platform:qcom-uniphy-pcie");
> +MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_DESCRIPTION("PCIE QCOM UNIPHY driver");
> --
> 2.17.1
>


--
With best wishes
Dmitry
