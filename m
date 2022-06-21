Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30B5553D6E
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jun 2022 23:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355973AbiFUVUB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 17:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355902AbiFUVTp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 17:19:45 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D2135A9E;
        Tue, 21 Jun 2022 14:05:30 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id c83so11127973qke.3;
        Tue, 21 Jun 2022 14:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HeP7RDe/WRpFOY2lnHR3tmueb25njNH1IUveff2RKuw=;
        b=RNn2c0pBugaiXV6bz9gavvC/w8yIBIIHbIyYCrjfQW0kPPaZGrUfvMCZM+vlZtSq46
         xbkJiHnOQ8U9AZ5bJALjEDIgvghARiuR1y+r7tHE5q0RemuV/DIOvO3ylhMj0QI3n8ol
         wrlFvdzyyBm8O6LU7LWWcjYJ+sf5wU/qQ5EkVmFuZd8XPB/J3xb6xjnOGJxtMD/jB6pf
         tZRzvd37kq2B+tHdDdh/bBlVOjXWa9p+XKqEiJw5I5aysYUZnpD5UuoDZFU5x1QDAK1P
         muMB3ab7gsVimZJEjSe6ctpLJg/NewPf4IIzqX7dGL3Q2Q0DJc0+btEokJVeItBnotPl
         WmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HeP7RDe/WRpFOY2lnHR3tmueb25njNH1IUveff2RKuw=;
        b=KrpWcJEd/q2Tsjlb/3x8aQonpeBI2OdyZlDdv2UbxpieCV9ekKR6nFGuUSPhGwAZJQ
         jo8xK7WPA7J9UGg1EZYu4NuCBOS4yy721hZ3EKMcbsgLeRYlpYPggRFlgcQZ9huWQUTh
         QVUxb6W5MxgMrrAdA43HaWgPhJSC0jeVz/ifFBZ1pGF9nle2OnsgX148bwfymw79BncF
         Il8R1uLFWhJNE+NISwO3DttAvtQd1VfN7iCo3fd+Lmf5aFl9CzuDohaAv3XLWQ3GYZCf
         F06RQGVRxeTHp5adiQFEHuk45UMaXflOPtXMWg0CuNSAkv73tNKHy8zhwwYibpcLEqlw
         O7uw==
X-Gm-Message-State: AJIora8FKQo2wnmTXIyaDnskUkBpdtYHNF4mnY227fouEfXXn4Gfwg4N
        gKGSjJvjRejvSkF+5ycpkEGPMsIpqdT7m8s5JnR/uFTRnoo=
X-Google-Smtp-Source: AGRyM1sSz3lGLVvNvrBZVOZaQYqXP7lJyPtshZ2BVHVzuAw+yQapRXKEcg7t/xS1RXtwoheTfAdGz+DbTHKsHhr6cWY=
X-Received: by 2002:a05:620a:2450:b0:6a6:d264:2b88 with SMTP id
 h16-20020a05620a245000b006a6d2642b88mr21180101qkn.25.1655845528278; Tue, 21
 Jun 2022 14:05:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220621112330.448754-1-robimarko@gmail.com> <20220621203211.GA1330530@bhelgaas>
In-Reply-To: <20220621203211.GA1330530@bhelgaas>
From:   Robert Marko <robimarko@gmail.com>
Date:   Tue, 21 Jun 2022 23:05:17 +0200
Message-ID: <CAOX2RU7idTVcW6ivqs3V_Ep33RoHZs1zt0jav-_z2D7xpKJstw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: qcom: fix IPQ8074 Gen2 support
To:     Bjorn Helgaas <helgaas@kernel.org>
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

On Tue, 21 Jun 2022 at 22:32, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Jun 21, 2022 at 01:23:30PM +0200, Robert Marko wrote:
> > IPQ8074 has one Gen2 and one Gen3 port, currently the Gen2 port will
> > cause the system to hang as its using DBI registers in the .init
> > and those are only accesible after phy_power_on().
>
> Is the fact that IPQ8074 has both a Gen2 and a Gen3 port relevant to
> this patch?  I don't see the connection.

Hi Bjorn,
Not really, I can remove it from the description as this only affects the Gen2
port, Gen3 support is dependant on the IPQ6018 support getting merged as
it uses the same controller.

>
> I see that qcom_pcie_host_init() does:
>
>   qcom_pcie_host_init
>     pcie->cfg->ops->init(pcie)
>     phy_power_on(pcie->phy)
>     pcie->cfg->ops->post_init(pcie)
>
> and that you're moving DBI register accesses from
> qcom_pcie_init_2_3_3() to qcom_pcie_post_init_2_3_3().
>
> But I also see DBI register accesses in other .init() functions:
>
>   qcom_pcie_init_2_1_0
>   qcom_pcie_init_1_0_0      (oddly out of order)
>   qcom_pcie_init_2_3_2
>   qcom_pcie_init_2_4_0
>
> Why do these accesses not need to be moved?  I assume it's because
> pcie->phy is an optional PHY and phy_power_on() does nothing on those
> controllers?

As far as I could figure out from QCA-s 5.4 kernel, various commits, and QCA-s
attempts to solve this already upstream the Gen2 controller in IPQ8074 is a bit
special and requires the PHY to be powered on before DBI could be accessed or
else the board will hang as it does for me.

I can only assume that this is an IPQ8074-specific quirk and other IP-s are not
affected like this, so they were not broken.

>
> Whatever the reason, I think the DBI accesses should be done
> consistently in .post_init().  I see that Dmitry's previous patches
> removed all those .post_init() functions, but I think the consistency
> is worth having.
>
> Perhaps we could reorder the patches so this patch comes first, moves
> the DBI accesses into .post_init(), then Dmitry's patches could be
> rebased on top to drop the clock handling?
>
> > So solve this by splitting the DBI read/writes to .post_init.

I am open to anything to get this fixed properly, you are gonna need
to point me in the right direction
as I am really new to PCI.

Regards,
Robert
> >
> > Fixes: a0fd361db8e5 ("PCI: dwc: Move "dbi", "dbi2", and "addr_space" resource setup into common code")
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
> > @@ -1598,6 +1605,7 @@ static const struct qcom_pcie_ops ops_2_4_0 = {
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
