Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3EA559823
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 12:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiFXKrJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 06:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiFXKrI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 06:47:08 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A376DB1E;
        Fri, 24 Jun 2022 03:47:07 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id z12so1620460qki.3;
        Fri, 24 Jun 2022 03:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jVsJY7WR+SHgjqrT/isEV6YQH8FWzCgPIwE9VasGk2M=;
        b=MRMDRZUGZnkCjWEGNt9eLgLDP8AfngsEdcYSg6QX/1FDhoFRxULdSqacsACOXLau9C
         Addt9jPzTwZSVYztPQ9/QDaUIiPjGUe8LBepAeeoAgbk/RP5ZBzFiLY0i1+rJNToXoXY
         Qyse9bLJmxFvl7Gglu3GQaWun83fZi+WUOdb33UgjegQE6KA/rgU8o7Xblz8RsuVwhG7
         IwV7q2GZfz01F7vkSIoC05ONKUTmiRoKMEnoRFEn3c+KW6XnTYbtpJYzmsE5bhwwqGWM
         ZS2Nj3cFkIycCo19aUGlrwF043wlagl1ZKTnqHD65disaPfygcMO+KT+9+8zyfN/wWVy
         g6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jVsJY7WR+SHgjqrT/isEV6YQH8FWzCgPIwE9VasGk2M=;
        b=jp/yiz+nqT0/8FRPjmSZU6jaQFxKll/txatZ0xqrWIftK53xEmPzkMldlJhou8f5gE
         /F138TwtKY5GxQcE6jYtbZhnwMu/7LKj5dBFHR9rSbtLkkBoMmYy8p3NDAbLOXp2TBZO
         Ag9X81oKnW+PxClDSOnJkfZOKlQ1BH4oFP14AdYOhEavwAxfqcKPFEJq2Z16Uaobs/dK
         IJ2U+K8buN57VU6l9/XvOaRbeG97bb4t1BqkXpkQxjJ9aaKOknubMdCJmN4nZj/JeJ8G
         7ta0nrGncCmJd0lHCwZQ/Aoj83Tsw8Rh1D8XhiEjRZ/OYmkYUdAB1QppcI0pszVYaEHA
         ySAg==
X-Gm-Message-State: AJIora89bK0tAuqLX6GNlt9smcoUgWO1TSYtoAIE8fkzlYo4bI6nmfHR
        EVLhTLn7X32xYpQ9AH1DR75eFKByGh4JiZE743M=
X-Google-Smtp-Source: AGRyM1trkhJ8me3+/x7lO99TYCMjIFQXuQ5AGSTx0SZTYW9Si5m7WhBRbitGCNgf9l/aPdNWCVZoePSVyTlAlfIxa6Y=
X-Received: by 2002:a05:620a:2494:b0:6a7:6a06:7aae with SMTP id
 i20-20020a05620a249400b006a76a067aaemr10044216qkn.87.1656067626254; Fri, 24
 Jun 2022 03:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220623155004.688090-2-robimarko@gmail.com> <20220623215531.GA1479475@bhelgaas>
 <CAOX2RU7KjUnHabtGg0sukXDZ4ZkdpCsY=5zuxTST098A+4_LYA@mail.gmail.com>
In-Reply-To: <CAOX2RU7KjUnHabtGg0sukXDZ4ZkdpCsY=5zuxTST098A+4_LYA@mail.gmail.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Fri, 24 Jun 2022 12:46:55 +0200
Message-ID: <CAOX2RU4zbG8J59k0L22fbUK2fKFOKvW1O2hTTdW1bEpNv7=vjA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] PCI: qcom: move register accesses to .post_init
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        lpieralisi@kernel.org, Rob Herring <robh@kernel.org>, kw@linux.com,
        Bjorn Helgaas <bhelgaas@google.com>, p.zabel@pengutronix.de,
        jingoohan1@gmail.com, linux-pci@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        johan+linaro@kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 24 Jun 2022 at 12:36, Robert Marko <robimarko@gmail.com> wrote:
>
> On Thu, 23 Jun 2022 at 23:55, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Thu, Jun 23, 2022 at 05:50:04PM +0200, Robert Marko wrote:
> > > Move register accesses from .init to .post_init callbacks to maintain
> > > consinstency for all IP since IPQ8074 specifically requires PHY-s to be
> > > powered on before register access and its accesses have been moved to
> > > .post_init.
> >
> > This doesn't do the corresponding move for qcom_pcie_init_2_7_0().  Is
> > that intentional or an oversight?
>
> Hi,
>
> It was an oversight on my part, will fixup it now, sorry for the mistake.
>
> Regards,
> Robert

Bjorn,

I updated the title and description based on your fixups in your branch,
hope that is ok.

Regards,
Robert
> >
> > > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-qcom.c | 171 ++++++++++++++-----------
> > >  1 file changed, 97 insertions(+), 74 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > index 24708d5d817d..1aa11f12c069 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > @@ -348,8 +348,6 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
> > >       struct qcom_pcie_resources_2_1_0 *res = &pcie->res.v2_1_0;
> > >       struct dw_pcie *pci = pcie->pci;
> > >       struct device *dev = pci->dev;
> > > -     struct device_node *node = dev->of_node;
> > > -     u32 val;
> > >       int ret;
> > >
> > >       /* reset the PCIe interface as uboot can leave it undefined state */
> > > @@ -360,8 +358,6 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
> > >       reset_control_assert(res->ext_reset);
> > >       reset_control_assert(res->phy_reset);
> > >
> > > -     writel(1, pcie->parf + PCIE20_PARF_PHY_CTRL);
> > > -
> > >       ret = regulator_bulk_enable(ARRAY_SIZE(res->supplies), res->supplies);
> > >       if (ret < 0) {
> > >               dev_err(dev, "cannot enable regulators\n");
> > > @@ -408,6 +404,35 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
> > >       if (ret)
> > >               goto err_clks;
> > >
> > > +     return 0;
> > > +
> > > +err_clks:
> > > +     reset_control_assert(res->axi_reset);
> > > +err_deassert_axi:
> > > +     reset_control_assert(res->por_reset);
> > > +err_deassert_por:
> > > +     reset_control_assert(res->pci_reset);
> > > +err_deassert_pci:
> > > +     reset_control_assert(res->phy_reset);
> > > +err_deassert_phy:
> > > +     reset_control_assert(res->ext_reset);
> > > +err_deassert_ext:
> > > +     reset_control_assert(res->ahb_reset);
> > > +err_deassert_ahb:
> > > +     regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +static int qcom_pcie_post_init_2_1_0(struct qcom_pcie *pcie)
> > > +{
> > > +     struct dw_pcie *pci = pcie->pci;
> > > +     struct device *dev = pci->dev;
> > > +     struct device_node *node = dev->of_node;
> > > +     u32 val;
> > > +
> > > +     writel(1, pcie->parf + PCIE20_PARF_PHY_CTRL);
> > > +
> > >       /* enable PCIe clocks and resets */
> > >       val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> > >       val &= ~BIT(0);
> > > @@ -451,23 +476,6 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
> > >              pci->dbi_base + PCIE20_AXI_MSTR_RESP_COMP_CTRL1);
> > >
> > >       return 0;
> > > -
> > > -err_clks:
> > > -     reset_control_assert(res->axi_reset);
> > > -err_deassert_axi:
> > > -     reset_control_assert(res->por_reset);
> > > -err_deassert_por:
> > > -     reset_control_assert(res->pci_reset);
> > > -err_deassert_pci:
> > > -     reset_control_assert(res->phy_reset);
> > > -err_deassert_phy:
> > > -     reset_control_assert(res->ext_reset);
> > > -err_deassert_ext:
> > > -     reset_control_assert(res->ahb_reset);
> > > -err_deassert_ahb:
> > > -     regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
> > > -
> > > -     return ret;
> > >  }
> > >
> > >  static int qcom_pcie_get_resources_1_0_0(struct qcom_pcie *pcie)
> > > @@ -555,16 +563,6 @@ static int qcom_pcie_init_1_0_0(struct qcom_pcie *pcie)
> > >               goto err_slave;
> > >       }
> > >
> > > -     /* change DBI base address */
> > > -     writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
> > > -
> > > -     if (IS_ENABLED(CONFIG_PCI_MSI)) {
> > > -             u32 val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
> > > -
> > > -             val |= BIT(31);
> > > -             writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
> > > -     }
> > > -
> > >       return 0;
> > >  err_slave:
> > >       clk_disable_unprepare(res->slave_bus);
> > > @@ -580,6 +578,22 @@ static int qcom_pcie_init_1_0_0(struct qcom_pcie *pcie)
> > >       return ret;
> > >  }
> > >
> > > +static int qcom_pcie_post_init_1_0_0(struct qcom_pcie *pcie)
> > > +{
> > > +
> > > +     /* change DBI base address */
> > > +     writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
> > > +
> > > +     if (IS_ENABLED(CONFIG_PCI_MSI)) {
> > > +             u32 val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
> > > +
> > > +             val |= BIT(31);
> > > +             writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > >  static void qcom_pcie_2_3_2_ltssm_enable(struct qcom_pcie *pcie)
> > >  {
> > >       u32 val;
> > > @@ -648,7 +662,6 @@ static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
> > >       struct qcom_pcie_resources_2_3_2 *res = &pcie->res.v2_3_2;
> > >       struct dw_pcie *pci = pcie->pci;
> > >       struct device *dev = pci->dev;
> > > -     u32 val;
> > >       int ret;
> > >
> > >       ret = regulator_bulk_enable(ARRAY_SIZE(res->supplies), res->supplies);
> > > @@ -681,27 +694,6 @@ static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
> > >               goto err_slave_clk;
> > >       }
> > >
> > > -     /* enable PCIe clocks and resets */
> > > -     val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> > > -     val &= ~BIT(0);
> > > -     writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
> > > -
> > > -     /* change DBI base address */
> > > -     writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
> > > -
> > > -     /* MAC PHY_POWERDOWN MUX DISABLE  */
> > > -     val = readl(pcie->parf + PCIE20_PARF_SYS_CTRL);
> > > -     val &= ~BIT(29);
> > > -     writel(val, pcie->parf + PCIE20_PARF_SYS_CTRL);
> > > -
> > > -     val = readl(pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
> > > -     val |= BIT(4);
> > > -     writel(val, pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
> > > -
> > > -     val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> > > -     val |= BIT(31);
> > > -     writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> > > -
> > >       return 0;
> > >
> > >  err_slave_clk:
> > > @@ -722,8 +714,30 @@ static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
> > >       struct qcom_pcie_resources_2_3_2 *res = &pcie->res.v2_3_2;
> > >       struct dw_pcie *pci = pcie->pci;
> > >       struct device *dev = pci->dev;
> > > +     u32 val;
> > >       int ret;
> > >
> > > +     /* enable PCIe clocks and resets */
> > > +     val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> > > +     val &= ~BIT(0);
> > > +     writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
> > > +
> > > +     /* change DBI base address */
> > > +     writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
> > > +
> > > +     /* MAC PHY_POWERDOWN MUX DISABLE  */
> > > +     val = readl(pcie->parf + PCIE20_PARF_SYS_CTRL);
> > > +     val &= ~BIT(29);
> > > +     writel(val, pcie->parf + PCIE20_PARF_SYS_CTRL);
> > > +
> > > +     val = readl(pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
> > > +     val |= BIT(4);
> > > +     writel(val, pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
> > > +
> > > +     val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> > > +     val |= BIT(31);
> > > +     writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> > > +
> > >       ret = clk_prepare_enable(res->pipe_clk);
> > >       if (ret) {
> > >               dev_err(dev, "cannot prepare/enable pipe clock\n");
> > > @@ -837,7 +851,6 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
> > >       struct qcom_pcie_resources_2_4_0 *res = &pcie->res.v2_4_0;
> > >       struct dw_pcie *pci = pcie->pci;
> > >       struct device *dev = pci->dev;
> > > -     u32 val;
> > >       int ret;
> > >
> > >       ret = reset_control_assert(res->axi_m_reset);
> > > @@ -962,6 +975,33 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
> > >       if (ret)
> > >               goto err_clks;
> > >
> > > +     return 0;
> > > +
> > > +err_clks:
> > > +     reset_control_assert(res->ahb_reset);
> > > +err_rst_ahb:
> > > +     reset_control_assert(res->pwr_reset);
> > > +err_rst_pwr:
> > > +     reset_control_assert(res->axi_s_reset);
> > > +err_rst_axi_s:
> > > +     reset_control_assert(res->axi_m_sticky_reset);
> > > +err_rst_axi_m_sticky:
> > > +     reset_control_assert(res->axi_m_reset);
> > > +err_rst_axi_m:
> > > +     reset_control_assert(res->pipe_sticky_reset);
> > > +err_rst_pipe_sticky:
> > > +     reset_control_assert(res->pipe_reset);
> > > +err_rst_pipe:
> > > +     reset_control_assert(res->phy_reset);
> > > +err_rst_phy:
> > > +     reset_control_assert(res->phy_ahb_reset);
> > > +     return ret;
> > > +}
> > > +
> > > +static int qcom_pcie_post_init_2_4_0(struct qcom_pcie *pcie)
> > > +{
> > > +     u32 val;
> > > +
> > >       /* enable PCIe clocks and resets */
> > >       val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> > >       val &= ~BIT(0);
> > > @@ -984,26 +1024,6 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
> > >       writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> > >
> > >       return 0;
> > > -
> > > -err_clks:
> > > -     reset_control_assert(res->ahb_reset);
> > > -err_rst_ahb:
> > > -     reset_control_assert(res->pwr_reset);
> > > -err_rst_pwr:
> > > -     reset_control_assert(res->axi_s_reset);
> > > -err_rst_axi_s:
> > > -     reset_control_assert(res->axi_m_sticky_reset);
> > > -err_rst_axi_m_sticky:
> > > -     reset_control_assert(res->axi_m_reset);
> > > -err_rst_axi_m:
> > > -     reset_control_assert(res->pipe_sticky_reset);
> > > -err_rst_pipe_sticky:
> > > -     reset_control_assert(res->pipe_reset);
> > > -err_rst_pipe:
> > > -     reset_control_assert(res->phy_reset);
> > > -err_rst_phy:
> > > -     reset_control_assert(res->phy_ahb_reset);
> > > -     return ret;
> > >  }
> > >
> > >  static int qcom_pcie_get_resources_2_3_3(struct qcom_pcie *pcie)
> > > @@ -1569,6 +1589,7 @@ static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
> > >  static const struct qcom_pcie_ops ops_2_1_0 = {
> > >       .get_resources = qcom_pcie_get_resources_2_1_0,
> > >       .init = qcom_pcie_init_2_1_0,
> > > +     .post_init = qcom_pcie_post_init_2_1_0,
> > >       .deinit = qcom_pcie_deinit_2_1_0,
> > >       .ltssm_enable = qcom_pcie_2_1_0_ltssm_enable,
> > >  };
> > > @@ -1577,6 +1598,7 @@ static const struct qcom_pcie_ops ops_2_1_0 = {
> > >  static const struct qcom_pcie_ops ops_1_0_0 = {
> > >       .get_resources = qcom_pcie_get_resources_1_0_0,
> > >       .init = qcom_pcie_init_1_0_0,
> > > +     .post_init = qcom_pcie_post_init_1_0_0,
> > >       .deinit = qcom_pcie_deinit_1_0_0,
> > >       .ltssm_enable = qcom_pcie_2_1_0_ltssm_enable,
> > >  };
> > > @@ -1595,6 +1617,7 @@ static const struct qcom_pcie_ops ops_2_3_2 = {
> > >  static const struct qcom_pcie_ops ops_2_4_0 = {
> > >       .get_resources = qcom_pcie_get_resources_2_4_0,
> > >       .init = qcom_pcie_init_2_4_0,
> > > +     .post_init = qcom_pcie_post_init_2_4_0,
> > >       .deinit = qcom_pcie_deinit_2_4_0,
> > >       .ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
> > >  };
> > > --
> > > 2.36.1
> > >
