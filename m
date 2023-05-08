Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE5F6FB3F2
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 17:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbjEHPhc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 11:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234501AbjEHPhb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 11:37:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62016E8A;
        Mon,  8 May 2023 08:37:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F4436254C;
        Mon,  8 May 2023 15:37:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9CFC433EF;
        Mon,  8 May 2023 15:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683560239;
        bh=qel2kewVtsWY2T8P8nd4z4jo4QGJjpzs3QivQR26XnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BFpzuOPxLR7YpgCaQn1Qyzm7HajYuF8kDSIUFBxHW6XKzeXc4SJcbptiQWGrVF9tK
         9+TPanXeI85eM12C+vQWxoO9n/g4MCnMqVpYjKYH9340zEgYiCwefB6tEo13hofdzM
         droRdHz5COjR8pYAc4YTf8h1g2b2KSp+EDk6aUF2vNfm62dcTDqosiJH2C3pyWzOYU
         39Vnao3Gzl+dEYC4Qp7vk2o6oyaIFmc6Twm5FyR2ugVtPk12bxzpG7JMtNOtUsftKr
         ygcZyzrCOso78EuXUbc2xLZbaV/QsT4kWsZzGj2Yr+Vvt/pIQ61B1J5/wHTJFjriei
         VHz1jXZAC0rfQ==
Date:   Mon, 8 May 2023 21:07:06 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-clk@vger.kernel.org, quic_srichara@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_ipkumar@quicinc.com
Subject: Re: [PATCH V3 6/6] PCI: qcom: Add support for IPQ9574
Message-ID: <20230508153706.GA14969@thinkpad>
References: <20230421124938.21974-1-quic_devipriy@quicinc.com>
 <20230421124938.21974-7-quic_devipriy@quicinc.com>
 <20230508122109.GC4190@thinkpad>
 <CAA8EJppKUwfatdNoQPD4QbEPXyv1cEz3cDLfND+70Veq5Bcf8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA8EJppKUwfatdNoQPD4QbEPXyv1cEz3cDLfND+70Veq5Bcf8Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 08, 2023 at 03:46:53PM +0300, Dmitry Baryshkov wrote:
> On Mon, 8 May 2023 at 15:21, Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > On Fri, Apr 21, 2023 at 06:19:38PM +0530, Devi Priya wrote:
> > > The IPQ9574 platform has 4 Gen3 PCIe controllers: two single-lane
> > > and two dual-lane based on SNPS core 5.70a
> > > The Qcom IP rev is 1.27.0 and Synopsys IP rev is 5.80a
> > > Added a new compatible 'qcom,pcie-ipq9574' and 'ops_1_27_0'
> > > which reuses all the members of 'ops_2_9_0' except for the post_init
> > > as the SLV_ADDR_SPACE_SIZE configuration differs between 2_9_0
> > > and 1_27_0.
> > > Also, modified get_resources of 'ops 2_9_0' to get the clocks
> > > from the device tree and modelled the post init sequence as
> > > a common function to avoid code redundancy.
> > >
> > > Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> > > Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> > > Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> >
> > One comment below. With that fixed,
> >
> > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> >
> > - Mani
> >
> > > ---
> > >  Changes in V3:
> > >       - Rebased on top of linux-next/master
> > >
> > >  drivers/pci/controller/dwc/pcie-qcom.c | 61 ++++++++++++++++++--------
> > >  1 file changed, 43 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > index 4ab30892f6ef..3682ecdead1f 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > @@ -107,6 +107,7 @@
> > >
> > >  /* PARF_SLV_ADDR_SPACE_SIZE register value */
> > >  #define SLV_ADDR_SPACE_SZ                    0x10000000
> > > +#define SLV_ADDR_SPACE_SZ_1_27_0             0x08000000
> > >
> > >  /* PARF_MHI_CLOCK_RESET_CTRL register fields */
> > >  #define AHB_CLK_EN                           BIT(0)
> > > @@ -202,10 +203,10 @@ struct qcom_pcie_resources_2_7_0 {
> > >       struct reset_control *rst;
> > >  };
> > >
> > > -#define QCOM_PCIE_2_9_0_MAX_CLOCKS           5
> > >  struct qcom_pcie_resources_2_9_0 {
> > > -     struct clk_bulk_data clks[QCOM_PCIE_2_9_0_MAX_CLOCKS];
> > > +     struct clk_bulk_data *clks;
> > >       struct reset_control *rst;
> > > +     int num_clks;
> > >  };
> > >
> > >  union qcom_pcie_resources {
> > > @@ -1050,17 +1051,10 @@ static int qcom_pcie_get_resources_2_9_0(struct qcom_pcie *pcie)
> > >       struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
> > >       struct dw_pcie *pci = pcie->pci;
> > >       struct device *dev = pci->dev;
> > > -     int ret;
> > >
> > > -     res->clks[0].id = "iface";
> > > -     res->clks[1].id = "axi_m";
> > > -     res->clks[2].id = "axi_s";
> > > -     res->clks[3].id = "axi_bridge";
> > > -     res->clks[4].id = "rchng";
> > > -
> > > -     ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
> > > -     if (ret < 0)
> > > -             return ret;
> > > +     res->num_clks = devm_clk_bulk_get_all(dev, &res->clks);
> > > +     if (res->clks < 0)
> > > +             return res->num_clks;
> >
> > Why not return proper error no?
> 
> Instead the question should be, why not the proper condition: it tells
> `if (res->clks < 0)', while it should be `if (res->num_clks < 0)'.
> 

Heh. I completely overlooked that part. Yes, the if condition itself should be
fixed.

- Mani

> >
> > >
> > >       res->rst = devm_reset_control_array_get_exclusive(dev);
> > >       if (IS_ERR(res->rst))
> > > @@ -1073,7 +1067,7 @@ static void qcom_pcie_deinit_2_9_0(struct qcom_pcie *pcie)
> > >  {
> > >       struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
> > >
> > > -     clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
> > > +     clk_bulk_disable_unprepare(res->num_clks, res->clks);
> > >  }
> > >
> > >  static int qcom_pcie_init_2_9_0(struct qcom_pcie *pcie)
> > > @@ -1102,19 +1096,16 @@ static int qcom_pcie_init_2_9_0(struct qcom_pcie *pcie)
> > >
> > >       usleep_range(2000, 2500);
> > >
> > > -     return clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
> > > +     return clk_bulk_prepare_enable(res->num_clks, res->clks);
> > >  }
> > >
> > > -static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
> > > +static int qcom_pcie_post_init(struct qcom_pcie *pcie)
> > >  {
> > >       struct dw_pcie *pci = pcie->pci;
> > >       u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > >       u32 val;
> > >       int i;
> > >
> > > -     writel(SLV_ADDR_SPACE_SZ,
> > > -             pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
> > > -
> > >       val = readl(pcie->parf + PARF_PHY_CTRL);
> > >       val &= ~PHY_TEST_PWR_DOWN;
> > >       writel(val, pcie->parf + PARF_PHY_CTRL);
> > > @@ -1151,6 +1142,26 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
> > >       return 0;
> > >  }
> > >
> > > +static int qcom_pcie_post_init_1_27_0(struct qcom_pcie *pcie)
> > > +{
> > > +     writel(SLV_ADDR_SPACE_SZ_1_27_0,
> > > +            pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
> > > +
> > > +     qcom_pcie_post_init(pcie);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
> > > +{
> > > +     writel(SLV_ADDR_SPACE_SZ,
> > > +            pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
> > > +
> > > +     qcom_pcie_post_init(pcie);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > >  static int qcom_pcie_link_up(struct dw_pcie *pci)
> > >  {
> > >       u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > > @@ -1291,6 +1302,15 @@ static const struct qcom_pcie_ops ops_2_9_0 = {
> > >       .ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
> > >  };
> > >
> > > +/* Qcom IP rev.: 1.27.0  Synopsys IP rev.: 5.80a */
> > > +static const struct qcom_pcie_ops ops_1_27_0 = {
> > > +     .get_resources = qcom_pcie_get_resources_2_9_0,
> > > +     .init = qcom_pcie_init_2_9_0,
> > > +     .post_init = qcom_pcie_post_init_1_27_0,
> > > +     .deinit = qcom_pcie_deinit_2_9_0,
> > > +     .ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
> > > +};
> > > +
> > >  static const struct qcom_pcie_cfg cfg_1_0_0 = {
> > >       .ops = &ops_1_0_0,
> > >  };
> > > @@ -1323,6 +1343,10 @@ static const struct qcom_pcie_cfg cfg_2_9_0 = {
> > >       .ops = &ops_2_9_0,
> > >  };
> > >
> > > +static const struct qcom_pcie_cfg cfg_1_27_0 = {
> > > +     .ops = &ops_1_27_0,
> > > +};
> > > +
> > >  static const struct dw_pcie_ops dw_pcie_ops = {
> > >       .link_up = qcom_pcie_link_up,
> > >       .start_link = qcom_pcie_start_link,
> > > @@ -1607,6 +1631,7 @@ static const struct of_device_id qcom_pcie_match[] = {
> > >       { .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
> > >       { .compatible = "qcom,pcie-ipq8074", .data = &cfg_2_3_3 },
> > >       { .compatible = "qcom,pcie-ipq8074-gen3", .data = &cfg_2_9_0 },
> > > +     { .compatible = "qcom,pcie-ipq9574", .data = &cfg_1_27_0 },
> > >       { .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
> > >       { .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
> > >       { .compatible = "qcom,pcie-sa8540p", .data = &cfg_1_9_0 },
> > > --
> > > 2.17.1
> > >
> >
> > --
> > மணிவண்ணன் சதாசிவம்
> 
> 
> 
> -- 
> With best wishes
> Dmitry

-- 
மணிவண்ணன் சதாசிவம்
