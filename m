Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADE35597F9
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 12:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbiFXKgX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 06:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiFXKgW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 06:36:22 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA647C843;
        Fri, 24 Jun 2022 03:36:20 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id c1so3899831qvi.11;
        Fri, 24 Jun 2022 03:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d5UTZWIgd/vGwc2cgdjEXREPAqX+7lpHwbmEnAzOWhc=;
        b=KyGzCbc/FFwwDdTy0KmCVzGaJgw0yVEIFGdl4pStW/JEQH3wdsVs4nMl3P5KOAHiSe
         fbyHsCaG18xCEoTrMUS4HN0aCo6YacCC0qKnNP2TuF9BPdybymaOFtvfwe1dxKkRuDKk
         ji+32tbZe5+Z37213lFJjN82TvZay616jM037JHvSdiaO0Y2eIiTd4jmMXDIYcnQcmR8
         34Vt0+SxNJFoqJhjIvXEcBjmuBQKC0P0pEeas8kG2o23vbU7Pe5FeTyx0NpMfSJ69DnM
         iAKdzN60leJRTIracqyccAWTNxVy908qSs16lunkvsBW0h019FRXvtJmcUqQ0Iewu6o8
         ILxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d5UTZWIgd/vGwc2cgdjEXREPAqX+7lpHwbmEnAzOWhc=;
        b=x4L05cRBYRfU4SfnQheV3NxNV7e+o4IClGmUm1ESUDUh5u7FSwmp16ZyfuI4kozqN8
         k202y95DaZrQ/fylNxY6Jaw2WVlrG9gQNFGTT3fm8QyKzGjSEZWD+vKZvAvLZYTpBBAQ
         Ca3RtDmbIuDmfe86QvW1N4gD36kY7vLgiu70hFt6QNsl8JCISWQKXLs4DNNT4GmlrIeb
         pmOU0rKnncHAalmV9lMceoX1SSWlkmlKfxLFUMeFHSIB+gwHTY5UqRchqkOy6y0atEO8
         Oi4R8Edam1sBz/8im1kcoLwKMz8rfygu8KqPOUbXmqcF0NGsd18CXOdb2iaHXhn4b2sU
         HxYA==
X-Gm-Message-State: AJIora/cwcifrbFtJmBgX9/PWNdqyg72OY6AFRtne7hzh/W5jd/yG1Fx
        /4sJX+P8yTiM0UCXRosJBf2tc9U1+kSey+TFwE0=
X-Google-Smtp-Source: AGRyM1u8mpBqrsBjQk+Z4plxjLLTU1LJq6bZQs754AUd6H4z6K+tTGjDWHgNowN9KAuM+5kNk32qe9FPKJHVoJzTVEI=
X-Received: by 2002:a05:622a:144:b0:305:ad2:44f with SMTP id
 v4-20020a05622a014400b003050ad2044fmr12311799qtw.494.1656066979717; Fri, 24
 Jun 2022 03:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220623155004.688090-2-robimarko@gmail.com> <20220623215531.GA1479475@bhelgaas>
In-Reply-To: <20220623215531.GA1479475@bhelgaas>
From:   Robert Marko <robimarko@gmail.com>
Date:   Fri, 24 Jun 2022 12:36:08 +0200
Message-ID: <CAOX2RU7KjUnHabtGg0sukXDZ4ZkdpCsY=5zuxTST098A+4_LYA@mail.gmail.com>
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

On Thu, 23 Jun 2022 at 23:55, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Jun 23, 2022 at 05:50:04PM +0200, Robert Marko wrote:
> > Move register accesses from .init to .post_init callbacks to maintain
> > consinstency for all IP since IPQ8074 specifically requires PHY-s to be
> > powered on before register access and its accesses have been moved to
> > .post_init.
>
> This doesn't do the corresponding move for qcom_pcie_init_2_7_0().  Is
> that intentional or an oversight?

Hi,

It was an oversight on my part, will fixup it now, sorry for the mistake.

Regards,
Robert
>
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 171 ++++++++++++++-----------
> >  1 file changed, 97 insertions(+), 74 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 24708d5d817d..1aa11f12c069 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -348,8 +348,6 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
> >       struct qcom_pcie_resources_2_1_0 *res = &pcie->res.v2_1_0;
> >       struct dw_pcie *pci = pcie->pci;
> >       struct device *dev = pci->dev;
> > -     struct device_node *node = dev->of_node;
> > -     u32 val;
> >       int ret;
> >
> >       /* reset the PCIe interface as uboot can leave it undefined state */
> > @@ -360,8 +358,6 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
> >       reset_control_assert(res->ext_reset);
> >       reset_control_assert(res->phy_reset);
> >
> > -     writel(1, pcie->parf + PCIE20_PARF_PHY_CTRL);
> > -
> >       ret = regulator_bulk_enable(ARRAY_SIZE(res->supplies), res->supplies);
> >       if (ret < 0) {
> >               dev_err(dev, "cannot enable regulators\n");
> > @@ -408,6 +404,35 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
> >       if (ret)
> >               goto err_clks;
> >
> > +     return 0;
> > +
> > +err_clks:
> > +     reset_control_assert(res->axi_reset);
> > +err_deassert_axi:
> > +     reset_control_assert(res->por_reset);
> > +err_deassert_por:
> > +     reset_control_assert(res->pci_reset);
> > +err_deassert_pci:
> > +     reset_control_assert(res->phy_reset);
> > +err_deassert_phy:
> > +     reset_control_assert(res->ext_reset);
> > +err_deassert_ext:
> > +     reset_control_assert(res->ahb_reset);
> > +err_deassert_ahb:
> > +     regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
> > +
> > +     return ret;
> > +}
> > +
> > +static int qcom_pcie_post_init_2_1_0(struct qcom_pcie *pcie)
> > +{
> > +     struct dw_pcie *pci = pcie->pci;
> > +     struct device *dev = pci->dev;
> > +     struct device_node *node = dev->of_node;
> > +     u32 val;
> > +
> > +     writel(1, pcie->parf + PCIE20_PARF_PHY_CTRL);
> > +
> >       /* enable PCIe clocks and resets */
> >       val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> >       val &= ~BIT(0);
> > @@ -451,23 +476,6 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
> >              pci->dbi_base + PCIE20_AXI_MSTR_RESP_COMP_CTRL1);
> >
> >       return 0;
> > -
> > -err_clks:
> > -     reset_control_assert(res->axi_reset);
> > -err_deassert_axi:
> > -     reset_control_assert(res->por_reset);
> > -err_deassert_por:
> > -     reset_control_assert(res->pci_reset);
> > -err_deassert_pci:
> > -     reset_control_assert(res->phy_reset);
> > -err_deassert_phy:
> > -     reset_control_assert(res->ext_reset);
> > -err_deassert_ext:
> > -     reset_control_assert(res->ahb_reset);
> > -err_deassert_ahb:
> > -     regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
> > -
> > -     return ret;
> >  }
> >
> >  static int qcom_pcie_get_resources_1_0_0(struct qcom_pcie *pcie)
> > @@ -555,16 +563,6 @@ static int qcom_pcie_init_1_0_0(struct qcom_pcie *pcie)
> >               goto err_slave;
> >       }
> >
> > -     /* change DBI base address */
> > -     writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
> > -
> > -     if (IS_ENABLED(CONFIG_PCI_MSI)) {
> > -             u32 val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
> > -
> > -             val |= BIT(31);
> > -             writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
> > -     }
> > -
> >       return 0;
> >  err_slave:
> >       clk_disable_unprepare(res->slave_bus);
> > @@ -580,6 +578,22 @@ static int qcom_pcie_init_1_0_0(struct qcom_pcie *pcie)
> >       return ret;
> >  }
> >
> > +static int qcom_pcie_post_init_1_0_0(struct qcom_pcie *pcie)
> > +{
> > +
> > +     /* change DBI base address */
> > +     writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
> > +
> > +     if (IS_ENABLED(CONFIG_PCI_MSI)) {
> > +             u32 val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
> > +
> > +             val |= BIT(31);
> > +             writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  static void qcom_pcie_2_3_2_ltssm_enable(struct qcom_pcie *pcie)
> >  {
> >       u32 val;
> > @@ -648,7 +662,6 @@ static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
> >       struct qcom_pcie_resources_2_3_2 *res = &pcie->res.v2_3_2;
> >       struct dw_pcie *pci = pcie->pci;
> >       struct device *dev = pci->dev;
> > -     u32 val;
> >       int ret;
> >
> >       ret = regulator_bulk_enable(ARRAY_SIZE(res->supplies), res->supplies);
> > @@ -681,27 +694,6 @@ static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
> >               goto err_slave_clk;
> >       }
> >
> > -     /* enable PCIe clocks and resets */
> > -     val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> > -     val &= ~BIT(0);
> > -     writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
> > -
> > -     /* change DBI base address */
> > -     writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
> > -
> > -     /* MAC PHY_POWERDOWN MUX DISABLE  */
> > -     val = readl(pcie->parf + PCIE20_PARF_SYS_CTRL);
> > -     val &= ~BIT(29);
> > -     writel(val, pcie->parf + PCIE20_PARF_SYS_CTRL);
> > -
> > -     val = readl(pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
> > -     val |= BIT(4);
> > -     writel(val, pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
> > -
> > -     val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> > -     val |= BIT(31);
> > -     writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> > -
> >       return 0;
> >
> >  err_slave_clk:
> > @@ -722,8 +714,30 @@ static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
> >       struct qcom_pcie_resources_2_3_2 *res = &pcie->res.v2_3_2;
> >       struct dw_pcie *pci = pcie->pci;
> >       struct device *dev = pci->dev;
> > +     u32 val;
> >       int ret;
> >
> > +     /* enable PCIe clocks and resets */
> > +     val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> > +     val &= ~BIT(0);
> > +     writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
> > +
> > +     /* change DBI base address */
> > +     writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
> > +
> > +     /* MAC PHY_POWERDOWN MUX DISABLE  */
> > +     val = readl(pcie->parf + PCIE20_PARF_SYS_CTRL);
> > +     val &= ~BIT(29);
> > +     writel(val, pcie->parf + PCIE20_PARF_SYS_CTRL);
> > +
> > +     val = readl(pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
> > +     val |= BIT(4);
> > +     writel(val, pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
> > +
> > +     val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> > +     val |= BIT(31);
> > +     writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> > +
> >       ret = clk_prepare_enable(res->pipe_clk);
> >       if (ret) {
> >               dev_err(dev, "cannot prepare/enable pipe clock\n");
> > @@ -837,7 +851,6 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
> >       struct qcom_pcie_resources_2_4_0 *res = &pcie->res.v2_4_0;
> >       struct dw_pcie *pci = pcie->pci;
> >       struct device *dev = pci->dev;
> > -     u32 val;
> >       int ret;
> >
> >       ret = reset_control_assert(res->axi_m_reset);
> > @@ -962,6 +975,33 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
> >       if (ret)
> >               goto err_clks;
> >
> > +     return 0;
> > +
> > +err_clks:
> > +     reset_control_assert(res->ahb_reset);
> > +err_rst_ahb:
> > +     reset_control_assert(res->pwr_reset);
> > +err_rst_pwr:
> > +     reset_control_assert(res->axi_s_reset);
> > +err_rst_axi_s:
> > +     reset_control_assert(res->axi_m_sticky_reset);
> > +err_rst_axi_m_sticky:
> > +     reset_control_assert(res->axi_m_reset);
> > +err_rst_axi_m:
> > +     reset_control_assert(res->pipe_sticky_reset);
> > +err_rst_pipe_sticky:
> > +     reset_control_assert(res->pipe_reset);
> > +err_rst_pipe:
> > +     reset_control_assert(res->phy_reset);
> > +err_rst_phy:
> > +     reset_control_assert(res->phy_ahb_reset);
> > +     return ret;
> > +}
> > +
> > +static int qcom_pcie_post_init_2_4_0(struct qcom_pcie *pcie)
> > +{
> > +     u32 val;
> > +
> >       /* enable PCIe clocks and resets */
> >       val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> >       val &= ~BIT(0);
> > @@ -984,26 +1024,6 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
> >       writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> >
> >       return 0;
> > -
> > -err_clks:
> > -     reset_control_assert(res->ahb_reset);
> > -err_rst_ahb:
> > -     reset_control_assert(res->pwr_reset);
> > -err_rst_pwr:
> > -     reset_control_assert(res->axi_s_reset);
> > -err_rst_axi_s:
> > -     reset_control_assert(res->axi_m_sticky_reset);
> > -err_rst_axi_m_sticky:
> > -     reset_control_assert(res->axi_m_reset);
> > -err_rst_axi_m:
> > -     reset_control_assert(res->pipe_sticky_reset);
> > -err_rst_pipe_sticky:
> > -     reset_control_assert(res->pipe_reset);
> > -err_rst_pipe:
> > -     reset_control_assert(res->phy_reset);
> > -err_rst_phy:
> > -     reset_control_assert(res->phy_ahb_reset);
> > -     return ret;
> >  }
> >
> >  static int qcom_pcie_get_resources_2_3_3(struct qcom_pcie *pcie)
> > @@ -1569,6 +1589,7 @@ static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
> >  static const struct qcom_pcie_ops ops_2_1_0 = {
> >       .get_resources = qcom_pcie_get_resources_2_1_0,
> >       .init = qcom_pcie_init_2_1_0,
> > +     .post_init = qcom_pcie_post_init_2_1_0,
> >       .deinit = qcom_pcie_deinit_2_1_0,
> >       .ltssm_enable = qcom_pcie_2_1_0_ltssm_enable,
> >  };
> > @@ -1577,6 +1598,7 @@ static const struct qcom_pcie_ops ops_2_1_0 = {
> >  static const struct qcom_pcie_ops ops_1_0_0 = {
> >       .get_resources = qcom_pcie_get_resources_1_0_0,
> >       .init = qcom_pcie_init_1_0_0,
> > +     .post_init = qcom_pcie_post_init_1_0_0,
> >       .deinit = qcom_pcie_deinit_1_0_0,
> >       .ltssm_enable = qcom_pcie_2_1_0_ltssm_enable,
> >  };
> > @@ -1595,6 +1617,7 @@ static const struct qcom_pcie_ops ops_2_3_2 = {
> >  static const struct qcom_pcie_ops ops_2_4_0 = {
> >       .get_resources = qcom_pcie_get_resources_2_4_0,
> >       .init = qcom_pcie_init_2_4_0,
> > +     .post_init = qcom_pcie_post_init_2_4_0,
> >       .deinit = qcom_pcie_deinit_2_4_0,
> >       .ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
> >  };
> > --
> > 2.36.1
> >
