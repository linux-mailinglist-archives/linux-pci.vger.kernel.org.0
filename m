Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BBB3E300B
	for <lists+linux-pci@lfdr.de>; Fri,  6 Aug 2021 22:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244365AbhHFUAO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Aug 2021 16:00:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:38616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244341AbhHFUAN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Aug 2021 16:00:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F83061181;
        Fri,  6 Aug 2021 19:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628279997;
        bh=UqVKLug64Y4PSY9jX3pZI+5Ny/f/MK1K8tRFuFCfIcE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WRfD/kZjjUvo7RJtlbHRvoYZrFlgi+kOi3Bt13z5T+6J9G+9uOW0qD5DXQsFvg0ow
         grhKMFnbQvRmxznTEq0wpNHEqxLN1qTPdsHPeSNT9mb4gec986nDpN4/kUBlv1PjVV
         Jw4IkpnNGw90XtP2PJ1SZK+3CTnhMOhnZbxvKXCmZxnW7xfbRIyBEUvmSdJKOzeSUn
         ib5mmv7EGoC9ErrGyOkVRmzJnivM9d3TISMp/MPdeDl49S8sMNAAjx06FooJ+WW1Dz
         dzL2iNZTDQKdeQMLcG9qwF6ryBL0GG2G+CGmBg2u9+M73p5oit6U5/MZxU2vekCVx1
         NtmNIIi0ePsyw==
Received: by mail-ed1-f45.google.com with SMTP id i6so14684826edu.1;
        Fri, 06 Aug 2021 12:59:57 -0700 (PDT)
X-Gm-Message-State: AOAM531+JgIKpDglFrmTvVk4cS+ohMA5kn6rxiXQ7ILVGKVQi8kYrNW6
        hYPIdgMEhIum10jVQTioa69NUGCgiJO4b9LTkg==
X-Google-Smtp-Source: ABdhPJz+E0OEuJndsCm2YSbEUXUzlIlGlq0qlb1skxBmctqYc2VbHUieNbcaIln7cAxq7HYGzjQeRBnuJq5qJ972iHM=
X-Received: by 2002:a05:6402:2043:: with SMTP id bc3mr15137346edb.62.1628279996090;
 Fri, 06 Aug 2021 12:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1620203062.git.baruch@tkos.co.il> <e17461407cf4bb79fed5925ec81196a0b84e7827.1620203062.git.baruch@tkos.co.il>
In-Reply-To: <e17461407cf4bb79fed5925ec81196a0b84e7827.1620203062.git.baruch@tkos.co.il>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 6 Aug 2021 13:59:44 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKOGo4eXKA7FZK7AQQ24MDDbg2-ngUQF9CJK=8eH_pxHQ@mail.gmail.com>
Message-ID: <CAL_JsqKOGo4eXKA7FZK7AQQ24MDDbg2-ngUQF9CJK=8eH_pxHQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] PCI: qcom: add support for IPQ60xx PCIe controller
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Robert Marko <robert.marko@sartura.hr>,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 5, 2021 at 3:18 AM Baruch Siach <baruch@tkos.co.il> wrote:
>
> From: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
>
> IPQ60xx series of SoCs have one port of PCIe gen 3. Add support for that
> platform.
>
> The code is based on downstream Codeaurora kernel v5.4. Split out the
> DBI registers access part from .init into .post_init. DBI registers are
> only accessible after phy_power_on().
>
> Signed-off-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> v2:
>   * Drop ATU configuration; rely on common code instead
>
>   * Use more common register macros
>
>   * Use bulk clk and reset APIs
> ---
>  drivers/pci/controller/dwc/pcie-designware.h |   1 +
>  drivers/pci/controller/dwc/pcie-qcom.c       | 150 +++++++++++++++++++
>  2 files changed, 151 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index ceb359b6e6a6..346462c74a3e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -76,6 +76,7 @@
>
>  #define GEN3_RELATED_OFF                       0x890
>  #define GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL   BIT(0)
> +#define GEN3_RELATED_OFF_RXEQ_RGRDLESS_RXTS    BIT(13)
>  #define GEN3_RELATED_OFF_GEN3_EQ_DISABLE       BIT(16)
>  #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT 24
>  #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK  GENMASK(25, 24)
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 8a7a300163e5..93766aee3e7c 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -52,6 +52,10 @@
>  #define PCIE20_PARF_DBI_BASE_ADDR              0x168
>  #define PCIE20_PARF_SLV_ADDR_SPACE_SIZE                0x16C
>  #define PCIE20_PARF_MHI_CLOCK_RESET_CTRL       0x174
> +#define AHB_CLK_EN                             BIT(0)
> +#define MSTR_AXI_CLK_EN                                BIT(1)
> +#define BYPASS                                 BIT(4)
> +
>  #define PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT      0x178
>  #define PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2   0x1A8
>  #define PCIE20_PARF_LTSSM                      0x1B0
> @@ -94,6 +98,12 @@
>  #define SLV_ADDR_SPACE_SZ                      0x10000000
>
>  #define PCIE20_LNK_CONTROL2_LINK_STATUS2       0xa0
> +#define PCIE_CAP_CURR_DEEMPHASIS               BIT(16)

Isn't this a standard register field?

> +#define SPEED_GEN1                             0x1
> +#define SPEED_GEN2                             0x2
> +#define SPEED_GEN3                             0x3

And these?

There's already some common DWC code for setting the link speed.

> +#define AXI_CLK_RATE                           200000000
> +#define RCHNG_CLK_RATE                         100000000
>
>  #define DEVICE_TYPE_RC                         0x4
>
> @@ -168,6 +178,11 @@ struct qcom_pcie_resources_2_7_0 {
>         struct clk *pipe_clk;
>  };
>
> +struct qcom_pcie_resources_2_9_0 {
> +       struct clk_bulk_data clks[5];
> +       struct reset_control *rst;
> +};
> +
>  union qcom_pcie_resources {
>         struct qcom_pcie_resources_1_0_0 v1_0_0;
>         struct qcom_pcie_resources_2_1_0 v2_1_0;
> @@ -175,6 +190,7 @@ union qcom_pcie_resources {
>         struct qcom_pcie_resources_2_3_3 v2_3_3;
>         struct qcom_pcie_resources_2_4_0 v2_4_0;
>         struct qcom_pcie_resources_2_7_0 v2_7_0;
> +       struct qcom_pcie_resources_2_9_0 v2_9_0;
>  };
>
>  struct qcom_pcie;
> @@ -1266,6 +1282,130 @@ static void qcom_pcie_post_deinit_2_7_0(struct qcom_pcie *pcie)
>         clk_disable_unprepare(res->pipe_clk);
>  }
>
> +static int qcom_pcie_get_resources_2_9_0(struct qcom_pcie *pcie)
> +{
> +       struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
> +       struct dw_pcie *pci = pcie->pci;
> +       struct device *dev = pci->dev;
> +       int ret;
> +
> +       res->clks[0].id = "iface";
> +       res->clks[1].id = "axi_m";
> +       res->clks[2].id = "axi_s";
> +       res->clks[3].id = "axi_bridge";
> +       res->clks[4].id = "rchng";
> +
> +       ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
> +       if (ret < 0)
> +               return ret;
> +
> +       res->rst = devm_reset_control_array_get_exclusive(dev);
> +       if (IS_ERR(res->rst))
> +               return PTR_ERR(res->rst);
> +
> +       return 0;
> +}
> +
> +static void qcom_pcie_deinit_2_9_0(struct qcom_pcie *pcie)
> +{
> +       struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
> +
> +       clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
> +}
> +
> +static int qcom_pcie_init_2_9_0(struct qcom_pcie *pcie)
> +{
> +       struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
> +       struct device *dev = pcie->pci->dev;
> +       int ret;
> +
> +       ret = reset_control_assert(res->rst);
> +       if (ret) {
> +               dev_err(dev, "reset assert failed (%d)\n", ret);
> +               return ret;
> +       }
> +
> +       usleep_range(2000, 2500);
> +
> +       ret = reset_control_deassert(res->rst);
> +       if (ret) {
> +               dev_err(dev, "reset deassert failed (%d)\n", ret);
> +               return ret;
> +       }
> +
> +       /*
> +        * Don't have a way to see if the reset has completed.
> +        * Wait for some time.
> +        */
> +       usleep_range(2000, 2500);
> +
> +       ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
> +       if (ret)
> +               goto err_reset;
> +
> +       return 0;
> +
> +       /*
> +        * Not checking for failure, will anyway return
> +        * the original failure in 'ret'.
> +        */
> +err_reset:
> +       reset_control_assert(res->rst);
> +
> +       return ret;
> +}
> +
> +static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
> +{
> +       struct dw_pcie *pci = pcie->pci;
> +       u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +       u32 val;
> +       int i;
> +
> +       writel(SLV_ADDR_SPACE_SZ,
> +               pcie->parf + PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE);
> +
> +       val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> +       val &= ~BIT(0);
> +       writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
> +
> +       writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
> +
> +       writel(DEVICE_TYPE_RC, pcie->parf + PCIE20_PARF_DEVICE_TYPE);
> +       writel(BYPASS | MSTR_AXI_CLK_EN | AHB_CLK_EN,
> +               pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
> +       writel(GEN3_RELATED_OFF_RXEQ_RGRDLESS_RXTS
> +               | GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL,
> +               pci->dbi_base + GEN3_RELATED_OFF);
> +
> +       writel(MST_WAKEUP_EN | SLV_WAKEUP_EN | MSTR_ACLK_CGC_DIS
> +               | SLV_ACLK_CGC_DIS | CORE_CLK_CGC_DIS |
> +               AUX_PWR_DET | L23_CLK_RMV_DIS | L1_CLK_RMV_DIS,
> +               pcie->parf + PCIE20_PARF_SYS_CTRL);
> +
> +       writel(0, pcie->parf + PCIE20_PARF_Q2A_FLUSH);
> +
> +       dw_pcie_dbi_ro_wr_en(pci);
> +       writel(PCIE_CAP_LINK1_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
> +
> +       /* Configure PCIe link capabilities for ASPM */
> +       val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
> +       val &= ~PCI_EXP_LNKCAP_ASPMS;
> +       writel(val, pci->dbi_base + offset + PCI_EXP_LNKCAP);
> +
> +       writel(PCI_EXP_DEVCTL2_COMP_TMOUT_DIS, pci->dbi_base + offset +
> +                       PCI_EXP_DEVCTL2);
> +
> +       writel(PCIE_CAP_CURR_DEEMPHASIS | SPEED_GEN3,
> +                       pci->dbi_base + offset + PCI_EXP_DEVCTL2);

Doesn't this overwrite the prior register write?

> +
> +       for (i = 0;i < 256;i++)
> +               writel(0x0, pcie->parf + PCIE20_PARF_BDF_TO_SID_TABLE_N
> +                               + (4 * i));
> +
> +       return 0;
> +}
> +
>  static int qcom_pcie_link_up(struct dw_pcie *pci)
>  {
>         u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> @@ -1456,6 +1596,15 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
>         .config_sid = qcom_pcie_config_sid_sm8250,
>  };
>
> +/* Qcom IP rev.: 2.9.0  Synopsys IP rev.: 5.00a */
> +static const struct qcom_pcie_ops ops_2_9_0 = {
> +       .get_resources = qcom_pcie_get_resources_2_9_0,
> +       .init = qcom_pcie_init_2_9_0,
> +       .post_init = qcom_pcie_post_init_2_9_0,
> +       .deinit = qcom_pcie_deinit_2_9_0,
> +       .ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
> +};
> +
>  static const struct dw_pcie_ops dw_pcie_ops = {
>         .link_up = qcom_pcie_link_up,
>         .start_link = qcom_pcie_start_link,
> @@ -1555,6 +1704,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>         { .compatible = "qcom,pcie-qcs404", .data = &ops_2_4_0 },
>         { .compatible = "qcom,pcie-sdm845", .data = &ops_2_7_0 },
>         { .compatible = "qcom,pcie-sm8250", .data = &ops_1_9_0 },
> +       { .compatible = "qcom,pcie-ipq6018", .data = &ops_2_9_0 },
>         { }
>  };
>
> --
> 2.30.2
>
