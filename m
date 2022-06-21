Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8845539C0
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jun 2022 20:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351476AbiFUSxj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 14:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbiFUSxg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 14:53:36 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404211180E;
        Tue, 21 Jun 2022 11:53:35 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id x75so10818916qkb.12;
        Tue, 21 Jun 2022 11:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jhBWONv0sRk0PO6NOho0MICFxLYjmPHqytEaDgbHoM0=;
        b=d1P+wZRsxn/ODj3bCIwRGZIvpv1YLgkrDLwtKc4SdcAkb90TBay3UmcRk1vnvOmt1O
         uQ0z3AhP5gu+zxvJneezJ/x27evsDfWwHq8TEwrGkukKhgM3Did1e4BDFAHwJOtYw1hO
         W83VTz0RKF+ri1D955w7vGzyEiCBMcpw6n3wkj4mm8vB96vhDkUWWz9JUJKGPl7qltQw
         bij56P0l/gzY52GEbIIZP3nasnAIoQJU1pQadU8irOxYw6x75DxsnKKryTDpUMlnL8Pn
         GvGyHyCeX5BozYk6XFJM9bQSaqqZAdwvE/ECbCIQ5CiEUjQmsdcSuyIWoe1o+HRyUkK2
         7R3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jhBWONv0sRk0PO6NOho0MICFxLYjmPHqytEaDgbHoM0=;
        b=v+2Lv1RApt67hRSgcujuA/ClaCmZERioZkrVqHOMFWzHAaeyon8CDdi/PA3NHFLeCK
         n5CtPUu98y1jkThx6kQNNrVYpPkLptiufdRSh7/v4NxNFw8HGGxEOuPwGseVS/Km4KrI
         rvTsNrmGdVZcOFQrmXfZp5YYWRAcCO5PxZo4M7dRjBb4xxBo2y9X1SLu/V6hSuQ9VxjK
         G31kbDzjghdmmZtx+V4qLpvac29PgzuJxaXrJhOlEHfFDcmOatCsSM/ThtvLxZvr31W1
         2QwznYAwdmpKx/bW+IeSoH6Z2bGFVkcTvSExTVR2regB+I3GdhSdc8aO4cJhARMQsFqm
         CtwQ==
X-Gm-Message-State: AJIora8uRyxNPVKyWV2954AUd53Kh5S6gk0Nlzejvlc/U/1xPgJOL8S1
        hPSE2ntX6fED0cwKLxRU2fStq84m+2SHhwb1veKAwRbRyYGbPw==
X-Google-Smtp-Source: AGRyM1sw7lbXUZfP6EAxcQ//+3RxPj9seN6z//cr+z98y/tqVjbv/xAxi9lBZGkz3w/HuA6qN073RBay+DheVRya+gs=
X-Received: by 2002:a05:620a:2450:b0:6a6:d264:2b88 with SMTP id
 h16-20020a05620a245000b006a6d2642b88mr20725040qkn.25.1655837614432; Tue, 21
 Jun 2022 11:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220621112330.448754-1-robimarko@gmail.com> <CAA8EJpoPJKVteUdsxOVH5THH_vqwBrdSn=hkbW4oWmpw+Mjdmg@mail.gmail.com>
In-Reply-To: <CAA8EJpoPJKVteUdsxOVH5THH_vqwBrdSn=hkbW4oWmpw+Mjdmg@mail.gmail.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Tue, 21 Jun 2022 20:53:23 +0200
Message-ID: <CAOX2RU4N26weZU4bBTsJ+zuDZnNoW6_UxNKwfSii0LDed9p1_A@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: qcom: fix IPQ8074 Gen2 support
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     svarbanov@mm-sol.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        lpieralisi@kernel.org, Rob Herring <robh@kernel.org>, kw@linux.com,
        Bjorn Helgaas <bhelgaas@google.com>, p.zabel@pengutronix.de,
        jingoohan1@gmail.com, linux-pci@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        johan+linaro@kernel.org
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

On Tue, 21 Jun 2022 at 19:29, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Tue, 21 Jun 2022 at 14:23, Robert Marko <robimarko@gmail.com> wrote:
> >
> > IPQ8074 has one Gen2 and one Gen3 port, currently the Gen2 port will
> > cause the system to hang as its using DBI registers in the .init
> > and those are only accesible after phy_power_on().
> >
> > So solve this by splitting the DBI read/writes to .post_init.
> >
> > Fixes: a0fd361db8e5 ("PCI: dwc: Move "dbi", "dbi2", and "addr_space" resource setup into common code")
>
> Any elaboration for the Fixes tag? I think the follow one is more
> logical, isn't it?
>
> Fixes: 5d76117f070d ("PCI: qcom: Add support for IPQ8074 PCIe controller")

Hi,
My logic was that it was working before the commit a0fd361db8e5 as it
moved PHY init
later and indirectly broke IPQ8074 gen2.

Regards,
Robert
>
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> > Changes in v2:
> > * Rebase onto next-20220621
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 48 +++++++++++++++-----------
> >  1 file changed, 28 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 51fed83484af..da6d79d61397 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -1061,9 +1061,7 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
> >         struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
> >         struct dw_pcie *pci = pcie->pci;
> >         struct device *dev = pci->dev;
> > -       u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> >         int i, ret;
> > -       u32 val;
> >
> >         for (i = 0; i < ARRAY_SIZE(res->rst); i++) {
> >                 ret = reset_control_assert(res->rst[i]);
> > @@ -1120,6 +1118,33 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
> >                 goto err_clk_aux;
> >         }
> >
> > +       return 0;
> > +
> > +err_clk_aux:
> > +       clk_disable_unprepare(res->ahb_clk);
> > +err_clk_ahb:
> > +       clk_disable_unprepare(res->axi_s_clk);
> > +err_clk_axi_s:
> > +       clk_disable_unprepare(res->axi_m_clk);
> > +err_clk_axi_m:
> > +       clk_disable_unprepare(res->iface);
> > +err_clk_iface:
> > +       /*
> > +        * Not checking for failure, will anyway return
> > +        * the original failure in 'ret'.
> > +        */
> > +       for (i = 0; i < ARRAY_SIZE(res->rst); i++)
> > +               reset_control_assert(res->rst[i]);
> > +
> > +       return ret;
> > +}
> > +
> > +static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
> > +{
> > +       struct dw_pcie *pci = pcie->pci;
> > +       u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > +       u32 val;
> > +
> >         writel(SLV_ADDR_SPACE_SZ,
> >                 pcie->parf + PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE);
> >
> > @@ -1147,24 +1172,6 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
> >                 PCI_EXP_DEVCTL2);
> >
> >         return 0;
> > -
> > -err_clk_aux:
> > -       clk_disable_unprepare(res->ahb_clk);
> > -err_clk_ahb:
> > -       clk_disable_unprepare(res->axi_s_clk);
> > -err_clk_axi_s:
> > -       clk_disable_unprepare(res->axi_m_clk);
> > -err_clk_axi_m:
> > -       clk_disable_unprepare(res->iface);
> > -err_clk_iface:
> > -       /*
> > -        * Not checking for failure, will anyway return
> > -        * the original failure in 'ret'.
> > -        */
> > -       for (i = 0; i < ARRAY_SIZE(res->rst); i++)
> > -               reset_control_assert(res->rst[i]);
> > -
> > -       return ret;
> >  }
> >
> >  static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
> > @@ -1598,6 +1605,7 @@ static const struct qcom_pcie_ops ops_2_4_0 = {
> >  static const struct qcom_pcie_ops ops_2_3_3 = {
> >         .get_resources = qcom_pcie_get_resources_2_3_3,
> >         .init = qcom_pcie_init_2_3_3,
> > +       .post_init = qcom_pcie_post_init_2_3_3,
> >         .deinit = qcom_pcie_deinit_2_3_3,
> >         .ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
> >  };
> > --
> > 2.36.1
> >
>
>
> --
> With best wishes
> Dmitry
