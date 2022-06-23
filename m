Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32262557F97
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jun 2022 18:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiFWQRp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 12:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiFWQRo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 12:17:44 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BFA4504A;
        Thu, 23 Jun 2022 09:17:43 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id n15so2292qvh.12;
        Thu, 23 Jun 2022 09:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s3Y6QsGpKcifMEy5jwY1arynj5IGJLuoZJcuD3pJplQ=;
        b=mm/vEw9RZF65k1tVgif6qonUph5GLN/dlS3yD2GhuVF9r8HBDe8dXzCBz1BB04HyBf
         gjz2Yht0xmRhJ5XQGbuqCzJJCsKb1/WH9u8L+0gWgBMSpENINh3z+rusl8CJxCHcdoWu
         CAQqUShINaYIyIyByM4iilryauT4dF3bXjo/LFfwyfnAx297sAXJMELDkzwSGMSPNa4o
         NO3vO8gEcKsqJsMGEb29pv0g342Ng0evXd7g5O1/CLAKsp6fPRjGrnSHkRdLi0kjERXu
         tjAC09RaKR7rQ+L6CxcRCfjp6lw+HOzkiHv8CwC5Se9hx8HkX6zjeVAtecVQyoXWyggw
         J/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s3Y6QsGpKcifMEy5jwY1arynj5IGJLuoZJcuD3pJplQ=;
        b=gGYETP8y86gxTablSabey7rJYGixtWfiImr0yxS+3bcGFTP14A7ckroDLMi2cuTZ68
         YcEzGYd9WUW1AIeBPg7RiOFvn/RSwITui6oaD3BGoOIfBeniQ4YvqSYFLQgARdCeDXOZ
         CipEnIFC7EAy9TlqocIvfgNxoqd8Gd+E+2ppnntsIMjy4KOD1TwCvsExAT2PV3RtUl20
         nMW5+YdYPH9PaVJBKEJtT0btJY3+99hnV02x4l9hsdlY79xyEHsu4qRnrcnHfrplKdXH
         Bw7Rpnt7u7PRgvACmx0cmx/Yjtc/H8FqNZYWVKGyONLr1uon3y/1sqbn93v5wvz8TFiS
         CPXA==
X-Gm-Message-State: AJIora/UXXU6NWvglO/njAH3eTk+CNAleNXZ7x/UPVpMNKbDFgMYMyxe
        pcocAZhJZHUQFAPahwkLU7D+bRqetMKyCuT9txk=
X-Google-Smtp-Source: AGRyM1t99O9MWamhT05ubKuwASitY1LLCgamjT6r2rEmwPYaHR9nq6O92KCqQYUkT+rQpEI/JpRGSpiqu0jSzhUIR6I=
X-Received: by 2002:a05:622a:355:b0:305:2f9:9ce8 with SMTP id
 r21-20020a05622a035500b0030502f99ce8mr8671872qtw.297.1656001062062; Thu, 23
 Jun 2022 09:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220623155004.688090-1-robimarko@gmail.com> <20220623160328.GA1453945@bhelgaas>
In-Reply-To: <20220623160328.GA1453945@bhelgaas>
From:   Robert Marko <robimarko@gmail.com>
Date:   Thu, 23 Jun 2022 18:17:31 +0200
Message-ID: <CAOX2RU4gy4ERWvsqoaT0fR0eXVpzHVK=tuvTK=8e-1SkFMgEfg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PCI: qcom: fix IPQ8074 Gen2 support
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

On Thu, 23 Jun 2022 at 18:03, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Jun 23, 2022 at 05:50:03PM +0200, Robert Marko wrote:
> > Currently the Gen2 port in IPQ8074 will cause the system to hang as its
> > using DBI registers in the .init and those are only accesible after
> > phy_power_on().
> >
> > So solve this by splitting the DBI read/writes to .post_init.
> >
> > Fixes: a0fd361db8e5 ("PCI: dwc: Move "dbi", "dbi2", and "addr_space" resource setup into common code")
>
> Does v5.11 or some v5.11-based stable kernel contain IPQ8074 support?
> If so, I'll mark this for backporting to stable.

Hi Bjorn,
Initial IPQ8074 support was added way back in 4.14.

Note that DTS nodes for both QMP PCI PHY-s and PCIe itself
for IPQ8074 are broken as well.

That is my TODO to clean up and send upstream as well.

Regards,
Robert
>
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> > Changes in v3:
> > * Make sure it applies onto 5.19-rc3
> > * Update the commit description to make it clear this only affects the
> > Gen2 port
> >
> > Changes in v2:
> > * Rebase onto next-20220621
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 48 +++++++++++++++-----------
> >  1 file changed, 28 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index a1f1aca2fb59..24708d5d817d 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -1061,9 +1061,7 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
> >       struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
> >       struct dw_pcie *pci = pcie->pci;
> >       struct device *dev = pci->dev;
> > -     u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> >       int i, ret;
> > -     u32 val;
> >
> >       for (i = 0; i < ARRAY_SIZE(res->rst); i++) {
> >               ret = reset_control_assert(res->rst[i]);
> > @@ -1120,6 +1118,33 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
> >               goto err_clk_aux;
> >       }
> >
> > +     return 0;
> > +
> > +err_clk_aux:
> > +     clk_disable_unprepare(res->ahb_clk);
> > +err_clk_ahb:
> > +     clk_disable_unprepare(res->axi_s_clk);
> > +err_clk_axi_s:
> > +     clk_disable_unprepare(res->axi_m_clk);
> > +err_clk_axi_m:
> > +     clk_disable_unprepare(res->iface);
> > +err_clk_iface:
> > +     /*
> > +      * Not checking for failure, will anyway return
> > +      * the original failure in 'ret'.
> > +      */
> > +     for (i = 0; i < ARRAY_SIZE(res->rst); i++)
> > +             reset_control_assert(res->rst[i]);
> > +
> > +     return ret;
> > +}
> > +
> > +static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
> > +{
> > +     struct dw_pcie *pci = pcie->pci;
> > +     u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > +     u32 val;
> > +
> >       writel(SLV_ADDR_SPACE_SZ,
> >               pcie->parf + PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE);
> >
> > @@ -1147,24 +1172,6 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
> >               PCI_EXP_DEVCTL2);
> >
> >       return 0;
> > -
> > -err_clk_aux:
> > -     clk_disable_unprepare(res->ahb_clk);
> > -err_clk_ahb:
> > -     clk_disable_unprepare(res->axi_s_clk);
> > -err_clk_axi_s:
> > -     clk_disable_unprepare(res->axi_m_clk);
> > -err_clk_axi_m:
> > -     clk_disable_unprepare(res->iface);
> > -err_clk_iface:
> > -     /*
> > -      * Not checking for failure, will anyway return
> > -      * the original failure in 'ret'.
> > -      */
> > -     for (i = 0; i < ARRAY_SIZE(res->rst); i++)
> > -             reset_control_assert(res->rst[i]);
> > -
> > -     return ret;
> >  }
> >
> >  static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
> > @@ -1596,6 +1603,7 @@ static const struct qcom_pcie_ops ops_2_4_0 = {
> >  static const struct qcom_pcie_ops ops_2_3_3 = {
> >       .get_resources = qcom_pcie_get_resources_2_3_3,
> >       .init = qcom_pcie_init_2_3_3,
> > +     .post_init = qcom_pcie_post_init_2_3_3,
> >       .deinit = qcom_pcie_deinit_2_3_3,
> >       .ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
> >  };
> > --
> > 2.36.1
> >
