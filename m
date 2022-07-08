Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FF256BED9
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jul 2022 20:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238926AbiGHRC4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jul 2022 13:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238927AbiGHRCz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2022 13:02:55 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2745621811;
        Fri,  8 Jul 2022 10:02:53 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id e15so6644946edj.2;
        Fri, 08 Jul 2022 10:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jo+MPiWD4nmpEOoFmepSYwlHHa8Y6OFlf/1Y3eWrLdg=;
        b=RQruHY7yOryEme/5h7DC0AaktobcY2qslGyxjtuwqHAvHZVlFxKTpbn8LUpcOArOkn
         pzmP71eQMKeqDmhpVSmgdzJ/pzK9mXz2lwAhnFdSslX0sjqYhfPBNwB4C7vMrGDE79k2
         5eQYeHMqLDV97s7deWSMrpqqPa293Tf54Dgb0m2w5liMYIqy9Z9qaJychl3euCuqPK/S
         nliSUodeKMLleg609WXxhs/bS1xa/qjBn8hW7Dad/9N5PmSUCe1cUOOxDRKUuZOleO2j
         ncVtf4/jpM/dGme/VJflRc3yJAlY8JYBJRXyhSB8pgdjIMKbRN3MxH0orF0FHKUl1bYC
         9axg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jo+MPiWD4nmpEOoFmepSYwlHHa8Y6OFlf/1Y3eWrLdg=;
        b=dy2ZoYa/pO3OPXUc3fvw0roKpx9RBituN7KOjGgJAlsd06RmoZ5xC+hdUiLYGxLG8B
         zACawFkXdWWfufiHgw9Vk3UVh40DGeDS9dZvqpx4EFPOvzuwQ0BuflgNt7X+x0ydcALN
         PpGyqqAiTvrxDJEAMRCLkordhwBY9IZyEWcMh6FnOXGNZjbaD/v4pASfufTHxRGkECvI
         zpzb0MZguYXa5uCsSw8X66a/ankBQF2TmloXZWqAQSP4n7v+uSAcIzCMVupOS63YE0H3
         ZnifIdwu2gJ0+6pPyuIMIihDS3z8upeZdIiBbmynaSNanvAeaLOqEoVD1mmwnZS3U9k6
         4L7w==
X-Gm-Message-State: AJIora9IZQDWHubN8wcbaCRQfxR+2eO0uzbdTZ2jL38CnDgtQ1Q/MyFb
        FirDbqk4trlZHxAkcnU2X4s=
X-Google-Smtp-Source: AGRyM1tJ8gKpfPAgEgw4SDmyNmX75lTcq477Pe6qgfuvHK4Ea8eWswUpHDUBP/IKe6iG0WCtVnoUFg==
X-Received: by 2002:a05:6402:2804:b0:439:83c2:8be2 with SMTP id h4-20020a056402280400b0043983c28be2mr6050766ede.292.1657299771207;
        Fri, 08 Jul 2022 10:02:51 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090630d500b00724261b592esm9259163ejb.186.2022.07.08.10.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 10:02:50 -0700 (PDT)
Message-ID: <62c8633a.1c69fb81.f15e3.fbd0@mx.google.com>
X-Google-Original-Message-ID: <YshjOC8Ip0sy4LRD@Ansuel-xps.>
Date:   Fri, 8 Jul 2022 19:02:48 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Robert Marko <robimarko@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        lpieralisi@kernel.org, Rob Herring <robh@kernel.org>, kw@linux.com,
        Bjorn Helgaas <bhelgaas@google.com>, p.zabel@pengutronix.de,
        jingoohan1@gmail.com, linux-pci@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        johan+linaro@kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v4 2/2] PCI: qcom: Move all DBI register accesses after
 phy_power_on()
References: <20220624104420.257368-2-robimarko@gmail.com>
 <20220707194139.GA328930@bhelgaas>
 <CAOX2RU6TFDtMW+3_rfqbUOy4AmEJh+8F8wPtLnJEBtpnzeMbdA@mail.gmail.com>
 <62c85fbf.1c69fb81.3ef7.d88d@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62c85fbf.1c69fb81.3ef7.d88d@mx.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 08, 2022 at 06:47:57PM +0200, Christian Marangi wrote:
> On Fri, Jul 08, 2022 at 06:39:37PM +0200, Robert Marko wrote:
> > CC-ing Christian who did a lot of work on 2.1.0 (IPQ806x).
> > 
> > Regards,
> > Robert
> > 
> > On Thu, 7 Jul 2022 at 21:41, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > On Fri, Jun 24, 2022 at 12:44:20PM +0200, Robert Marko wrote:
> > > > IPQ8074 requires the PHY to be powered on before accessing DBI registers.
> > > > It's not clear whether other variants have the same dependency, but there
> > > > seems to be no reason for them to be different, so move all the DBI
> > > > accesses from .init() to .post_init() so they are all after phy_power_on().
> > > >
> > > > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > >
> > > Would any of the qcom driver folks care to review and ack this?
> > > Stanimir, Andy, Bjorn A (from get_maintainer.pl)?
> > >
> 
> Hi Bjorn,
> I tested this on ipq806x and the current patch cause regression as pci
> doesn't work anymore...
> This is a before the patch [1] and this is an after [2].
> 
> As you notice the main problem here is
> [    2.559962] qcom-pcie 1b700000.pci: Phy link never came up
> 
> The cause of this has already been bisected and actually it was a fixup
> pushed some time ago for 2_1_0.
> 
> Uboot can leave the pci in an underfined state and this
> writel(1, pcie->parf + PCIE20_PARF_PHY_CTRL);
> is never called.
> 
> This is mandatory to a correct init and MUST be called before regulator
> enable and reset deassert or the "Phy link never came up" problem is
> triggered.
> 
> So to fix this we just have to have
> writel(1, pcie->parf + PCIE20_PARF_PHY_CTRL);
> in qcom_pcie_init_2_1_0 right after the reset_contro_assert.
> 
> This command is also present in qcom_pcie_init_2_3_2 where the same
> exact reg is written so I assume 2_3_2 have the same regression and the
> write must be placed in init and can't be moved to post_init.
> 
> Feel free to tell me how to proceed if I should post an additional patch
> or you prefer Robi to respin this with the few lines reverted.
> 
> [1] https://gist.github.com/Ansuel/ec827319e585630356fc586273db6f0d
> [2] https://gist.github.com/Ansuel/63fbcab2681cd28a61ec52d7874fa30d
>

While testing this I notice something odd...

2_4_2 prepare the pipe clock only AFTER PCIe clocks and reset are
enabled while in 2_1_0... That made me think there could be a problem
with the current code of 2_1_0... A quick change made me discover that
the problem is actually that we enable prepare_enable clock BEFORE the
value is written in PCIE20_PARF_PHY_CTRL.

By moving the clk_bulk_prepare_enable after the "enable PCIe clocks and
resets" make the pci work with the current change...

So it could be that the current changes are correct and it's really just
a bug in 2_1_0 enabling clock before writing the correct value...

Tell me how to proceed... think at this point a good idea would be to
create a separate patch and fix this for good.

Also bonus question, should I drop the bulk_prepare_enable and follow
the pattern of 2_3_2 and enable aux, cfg, master and slave in init and
pipe in post init or I can keep it? (still have to test but I assume
that it will work.)

> > > > ---
> > > > Changes in v4:
> > > > * Move 2.7.0 accesses as well
> > > > * Correct title and description (Bjorn)
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-qcom.c | 215 ++++++++++++++-----------
> > > >  1 file changed, 119 insertions(+), 96 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > index 24708d5d817d..f1a156052fe7 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > @@ -348,8 +348,6 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
> > > >       struct qcom_pcie_resources_2_1_0 *res = &pcie->res.v2_1_0;
> > > >       struct dw_pcie *pci = pcie->pci;
> > > >       struct device *dev = pci->dev;
> > > > -     struct device_node *node = dev->of_node;
> > > > -     u32 val;
> > > >       int ret;
> > > >
> > > >       /* reset the PCIe interface as uboot can leave it undefined state */
> > > > @@ -360,8 +358,6 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
> > > >       reset_control_assert(res->ext_reset);
> > > >       reset_control_assert(res->phy_reset);
> > > >
> > > > -     writel(1, pcie->parf + PCIE20_PARF_PHY_CTRL);
> > > > -
> > > >       ret = regulator_bulk_enable(ARRAY_SIZE(res->supplies), res->supplies);
> > > >       if (ret < 0) {
> > > >               dev_err(dev, "cannot enable regulators\n");
> > > > @@ -408,6 +404,35 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
> > > >       if (ret)
> > > >               goto err_clks;
> > > >
> > > > +     return 0;
> > > > +
> > > > +err_clks:
> > > > +     reset_control_assert(res->axi_reset);
> > > > +err_deassert_axi:
> > > > +     reset_control_assert(res->por_reset);
> > > > +err_deassert_por:
> > > > +     reset_control_assert(res->pci_reset);
> > > > +err_deassert_pci:
> > > > +     reset_control_assert(res->phy_reset);
> > > > +err_deassert_phy:
> > > > +     reset_control_assert(res->ext_reset);
> > > > +err_deassert_ext:
> > > > +     reset_control_assert(res->ahb_reset);
> > > > +err_deassert_ahb:
> > > > +     regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
> > > > +
> > > > +     return ret;
> > > > +}
> > > > +
> > > > +static int qcom_pcie_post_init_2_1_0(struct qcom_pcie *pcie)
> > > > +{
> > > > +     struct dw_pcie *pci = pcie->pci;
> > > > +     struct device *dev = pci->dev;
> > > > +     struct device_node *node = dev->of_node;
> > > > +     u32 val;
> > > > +
> > > > +     writel(1, pcie->parf + PCIE20_PARF_PHY_CTRL);
> > > > +
> > > >       /* enable PCIe clocks and resets */
> > > >       val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> > > >       val &= ~BIT(0);
> > > > @@ -451,23 +476,6 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
> > > >              pci->dbi_base + PCIE20_AXI_MSTR_RESP_COMP_CTRL1);
> > > >
> > > >       return 0;
> > > > -
> > > > -err_clks:
> > > > -     reset_control_assert(res->axi_reset);
> > > > -err_deassert_axi:
> > > > -     reset_control_assert(res->por_reset);
> > > > -err_deassert_por:
> > > > -     reset_control_assert(res->pci_reset);
> > > > -err_deassert_pci:
> > > > -     reset_control_assert(res->phy_reset);
> > > > -err_deassert_phy:
> > > > -     reset_control_assert(res->ext_reset);
> > > > -err_deassert_ext:
> > > > -     reset_control_assert(res->ahb_reset);
> > > > -err_deassert_ahb:
> > > > -     regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
> > > > -
> > > > -     return ret;
> > > >  }
> > > >
> > > >  static int qcom_pcie_get_resources_1_0_0(struct qcom_pcie *pcie)
> > > > @@ -555,16 +563,6 @@ static int qcom_pcie_init_1_0_0(struct qcom_pcie *pcie)
> > > >               goto err_slave;
> > > >       }
> > > >
> > > > -     /* change DBI base address */
> > > > -     writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
> > > > -
> > > > -     if (IS_ENABLED(CONFIG_PCI_MSI)) {
> > > > -             u32 val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
> > > > -
> > > > -             val |= BIT(31);
> > > > -             writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
> > > > -     }
> > > > -
> > > >       return 0;
> > > >  err_slave:
> > > >       clk_disable_unprepare(res->slave_bus);
> > > > @@ -580,6 +578,22 @@ static int qcom_pcie_init_1_0_0(struct qcom_pcie *pcie)
> > > >       return ret;
> > > >  }
> > > >
> > > > +static int qcom_pcie_post_init_1_0_0(struct qcom_pcie *pcie)
> > > > +{
> > > > +
> > > > +     /* change DBI base address */
> > > > +     writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
> > > > +
> > > > +     if (IS_ENABLED(CONFIG_PCI_MSI)) {
> > > > +             u32 val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
> > > > +
> > > > +             val |= BIT(31);
> > > > +             writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
> > > > +     }
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > >  static void qcom_pcie_2_3_2_ltssm_enable(struct qcom_pcie *pcie)
> > > >  {
> > > >       u32 val;
> > > > @@ -648,7 +662,6 @@ static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
> > > >       struct qcom_pcie_resources_2_3_2 *res = &pcie->res.v2_3_2;
> > > >       struct dw_pcie *pci = pcie->pci;
> > > >       struct device *dev = pci->dev;
> > > > -     u32 val;
> > > >       int ret;
> > > >
> > > >       ret = regulator_bulk_enable(ARRAY_SIZE(res->supplies), res->supplies);
> > > > @@ -681,27 +694,6 @@ static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
> > > >               goto err_slave_clk;
> > > >       }
> > > >
> > > > -     /* enable PCIe clocks and resets */
> > > > -     val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> > > > -     val &= ~BIT(0);
> > > > -     writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
> > > > -
> > > > -     /* change DBI base address */
> > > > -     writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
> > > > -
> > > > -     /* MAC PHY_POWERDOWN MUX DISABLE  */
> > > > -     val = readl(pcie->parf + PCIE20_PARF_SYS_CTRL);
> > > > -     val &= ~BIT(29);
> > > > -     writel(val, pcie->parf + PCIE20_PARF_SYS_CTRL);
> > > > -
> > > > -     val = readl(pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
> > > > -     val |= BIT(4);
> > > > -     writel(val, pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
> > > > -
> > > > -     val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> > > > -     val |= BIT(31);
> > > > -     writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> > > > -
> > > >       return 0;
> > > >
> > > >  err_slave_clk:
> > > > @@ -722,8 +714,30 @@ static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
> > > >       struct qcom_pcie_resources_2_3_2 *res = &pcie->res.v2_3_2;
> > > >       struct dw_pcie *pci = pcie->pci;
> > > >       struct device *dev = pci->dev;
> > > > +     u32 val;
> > > >       int ret;
> > > >
> > > > +     /* enable PCIe clocks and resets */
> > > > +     val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> > > > +     val &= ~BIT(0);
> > > > +     writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
> > > > +
> > > > +     /* change DBI base address */
> > > > +     writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
> > > > +
> > > > +     /* MAC PHY_POWERDOWN MUX DISABLE  */
> > > > +     val = readl(pcie->parf + PCIE20_PARF_SYS_CTRL);
> > > > +     val &= ~BIT(29);
> > > > +     writel(val, pcie->parf + PCIE20_PARF_SYS_CTRL);
> > > > +
> > > > +     val = readl(pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
> > > > +     val |= BIT(4);
> > > > +     writel(val, pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
> > > > +
> > > > +     val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> > > > +     val |= BIT(31);
> > > > +     writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> > > > +
> > > >       ret = clk_prepare_enable(res->pipe_clk);
> > > >       if (ret) {
> > > >               dev_err(dev, "cannot prepare/enable pipe clock\n");
> > > > @@ -837,7 +851,6 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
> > > >       struct qcom_pcie_resources_2_4_0 *res = &pcie->res.v2_4_0;
> > > >       struct dw_pcie *pci = pcie->pci;
> > > >       struct device *dev = pci->dev;
> > > > -     u32 val;
> > > >       int ret;
> > > >
> > > >       ret = reset_control_assert(res->axi_m_reset);
> > > > @@ -962,6 +975,33 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
> > > >       if (ret)
> > > >               goto err_clks;
> > > >
> > > > +     return 0;
> > > > +
> > > > +err_clks:
> > > > +     reset_control_assert(res->ahb_reset);
> > > > +err_rst_ahb:
> > > > +     reset_control_assert(res->pwr_reset);
> > > > +err_rst_pwr:
> > > > +     reset_control_assert(res->axi_s_reset);
> > > > +err_rst_axi_s:
> > > > +     reset_control_assert(res->axi_m_sticky_reset);
> > > > +err_rst_axi_m_sticky:
> > > > +     reset_control_assert(res->axi_m_reset);
> > > > +err_rst_axi_m:
> > > > +     reset_control_assert(res->pipe_sticky_reset);
> > > > +err_rst_pipe_sticky:
> > > > +     reset_control_assert(res->pipe_reset);
> > > > +err_rst_pipe:
> > > > +     reset_control_assert(res->phy_reset);
> > > > +err_rst_phy:
> > > > +     reset_control_assert(res->phy_ahb_reset);
> > > > +     return ret;
> > > > +}
> > > > +
> > > > +static int qcom_pcie_post_init_2_4_0(struct qcom_pcie *pcie)
> > > > +{
> > > > +     u32 val;
> > > > +
> > > >       /* enable PCIe clocks and resets */
> > > >       val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> > > >       val &= ~BIT(0);
> > > > @@ -984,26 +1024,6 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
> > > >       writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> > > >
> > > >       return 0;
> > > > -
> > > > -err_clks:
> > > > -     reset_control_assert(res->ahb_reset);
> > > > -err_rst_ahb:
> > > > -     reset_control_assert(res->pwr_reset);
> > > > -err_rst_pwr:
> > > > -     reset_control_assert(res->axi_s_reset);
> > > > -err_rst_axi_s:
> > > > -     reset_control_assert(res->axi_m_sticky_reset);
> > > > -err_rst_axi_m_sticky:
> > > > -     reset_control_assert(res->axi_m_reset);
> > > > -err_rst_axi_m:
> > > > -     reset_control_assert(res->pipe_sticky_reset);
> > > > -err_rst_pipe_sticky:
> > > > -     reset_control_assert(res->pipe_reset);
> > > > -err_rst_pipe:
> > > > -     reset_control_assert(res->phy_reset);
> > > > -err_rst_phy:
> > > > -     reset_control_assert(res->phy_ahb_reset);
> > > > -     return ret;
> > > >  }
> > > >
> > > >  static int qcom_pcie_get_resources_2_3_3(struct qcom_pcie *pcie)
> > > > @@ -1237,7 +1257,6 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
> > > >       struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> > > >       struct dw_pcie *pci = pcie->pci;
> > > >       struct device *dev = pci->dev;
> > > > -     u32 val;
> > > >       int ret;
> > > >
> > > >       ret = regulator_bulk_enable(ARRAY_SIZE(res->supplies), res->supplies);
> > > > @@ -1271,6 +1290,28 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
> > > >       /* Wait for reset to complete, required on SM8450 */
> > > >       usleep_range(1000, 1500);
> > > >
> > > > +     return 0;
> > > > +err_disable_clocks:
> > > > +     clk_bulk_disable_unprepare(res->num_clks, res->clks);
> > > > +err_disable_regulators:
> > > > +     regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
> > > > +
> > > > +     return ret;
> > > > +}
> > > > +
> > > > +static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
> > > > +{
> > > > +     struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> > > > +
> > > > +     clk_bulk_disable_unprepare(res->num_clks, res->clks);
> > > > +     regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
> > > > +}
> > > > +
> > > > +static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
> > > > +{
> > > > +     struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> > > > +     u32 val;
> > > > +
> > > >       /* configure PCIe to RC mode */
> > > >       writel(DEVICE_TYPE_RC, pcie->parf + PCIE20_PARF_DEVICE_TYPE);
> > > >
> > > > @@ -1297,27 +1338,6 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
> > > >               writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
> > > >       }
> > > >
> > > > -     return 0;
> > > > -err_disable_clocks:
> > > > -     clk_bulk_disable_unprepare(res->num_clks, res->clks);
> > > > -err_disable_regulators:
> > > > -     regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
> > > > -
> > > > -     return ret;
> > > > -}
> > > > -
> > > > -static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
> > > > -{
> > > > -     struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> > > > -
> > > > -     clk_bulk_disable_unprepare(res->num_clks, res->clks);
> > > > -     regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
> > > > -}
> > > > -
> > > > -static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
> > > > -{
> > > > -     struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> > > > -
> > > >       /* Set pipe clock as clock source for pcie_pipe_clk_src */
> > > >       if (pcie->cfg->pipe_clk_need_muxing)
> > > >               clk_set_parent(res->pipe_clk_src, res->phy_pipe_clk);
> > > > @@ -1569,6 +1589,7 @@ static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
> > > >  static const struct qcom_pcie_ops ops_2_1_0 = {
> > > >       .get_resources = qcom_pcie_get_resources_2_1_0,
> > > >       .init = qcom_pcie_init_2_1_0,
> > > > +     .post_init = qcom_pcie_post_init_2_1_0,
> > > >       .deinit = qcom_pcie_deinit_2_1_0,
> > > >       .ltssm_enable = qcom_pcie_2_1_0_ltssm_enable,
> > > >  };
> > > > @@ -1577,6 +1598,7 @@ static const struct qcom_pcie_ops ops_2_1_0 = {
> > > >  static const struct qcom_pcie_ops ops_1_0_0 = {
> > > >       .get_resources = qcom_pcie_get_resources_1_0_0,
> > > >       .init = qcom_pcie_init_1_0_0,
> > > > +     .post_init = qcom_pcie_post_init_1_0_0,
> > > >       .deinit = qcom_pcie_deinit_1_0_0,
> > > >       .ltssm_enable = qcom_pcie_2_1_0_ltssm_enable,
> > > >  };
> > > > @@ -1595,6 +1617,7 @@ static const struct qcom_pcie_ops ops_2_3_2 = {
> > > >  static const struct qcom_pcie_ops ops_2_4_0 = {
> > > >       .get_resources = qcom_pcie_get_resources_2_4_0,
> > > >       .init = qcom_pcie_init_2_4_0,
> > > > +     .post_init = qcom_pcie_post_init_2_4_0,
> > > >       .deinit = qcom_pcie_deinit_2_4_0,
> > > >       .ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
> > > >  };
> > > > --
> > > > 2.36.1
> > > >
> 
> -- 
> 	Ansuel

-- 
	Ansuel
