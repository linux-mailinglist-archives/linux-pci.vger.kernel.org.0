Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8649255FBBC
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 11:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiF2JV5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 05:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbiF2JVz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 05:21:55 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665FE369D0;
        Wed, 29 Jun 2022 02:21:52 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id n10so8124786qkn.10;
        Wed, 29 Jun 2022 02:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=xyKbiBGwe12VV4+hIYZhHutByUcZnqEu2BFeb6ToEVc=;
        b=Ru4+mVFxOSkJ7OAFQ3tloi+JJTVyK6/e8NHNSXgkYVnfAnpZbGlH720kSMNkKOVNoP
         3Nf4ML7iI3+jAkW8vmuq23ATUDiO3PWYg/Vh23hSlsSHBeWY6MhQACDOkYrFr/lOW8Qj
         7YqBUk5cH6Ml4/AkHJLtDBakAc9A9jIap8JlgdNpZPDxnzdalgk2PN5Wie44gGvUj3dD
         JhTuI+9FDaY/iuse7Xs07LBLHCDBSaFcvp5KhkqCJt/jwT1AhgO6PQ2oThQdwLEJN5ni
         +vSUgmu1TF/OarZedRIndxHmBWYxfjqyr9fnJnmS/ugldZU2Vl1lwGhWAUVl8C1rFhg4
         KX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=xyKbiBGwe12VV4+hIYZhHutByUcZnqEu2BFeb6ToEVc=;
        b=piDf4eSaRELe9V51n0kAbVRfEHfr3X9KYN3W8IkDrOU5SzP9ENRzrHqc1BXj10Q0Gm
         xITQ8wAWufpMfk+TubnZShMntDh14vm4cq3YFIRg8dEb2MgBEiudeUclCOQKSOvhd3MJ
         GcXnSdAfjMv/AyyqlwDzqQ8DfA70Hh5ckwCX/+so13DGRjLrGyrHYINK+EG0I+QtEQuf
         ji5A8AO/1fXY0a64RivKpkYXKxXZHhk/PYJX4XX7u5jtl35HDRKKN9nEYS7clRYLQkvx
         ZEdiSHrYGs+dYLBExU+qz81gagWTbq1e+BgEncVdyrATsJCSlUUCB9DpHI7gjBMRLOhC
         GYNg==
X-Gm-Message-State: AJIora/DjjtyoENp4B7qhYqLela/4dAyceKaBI7Zl8xak7+valqLScb3
        TwV4BUfMct2fO9H3sZWakipiI9Z92pDKpsS85m4=
X-Google-Smtp-Source: AGRyM1uSJPl40kSPwFIPa9wBNkco+vAkh6Zme01ouImI9Tnrlo2A3m6pVGIB9ptmIFV7EyqMJf7DSjFQQ8WmaPi1MQ8=
X-Received: by 2002:a05:620a:1a28:b0:6b1:4d4d:c7c3 with SMTP id
 bk40-20020a05620a1a2800b006b14d4dc7c3mr435716qkb.522.1656494511367; Wed, 29
 Jun 2022 02:21:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220624104420.257368-1-robimarko@gmail.com>
In-Reply-To: <20220624104420.257368-1-robimarko@gmail.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Wed, 29 Jun 2022 11:21:40 +0200
Message-ID: <CAOX2RU5iou-N2N0N9bMD49AufXMe04U84DNARGfJzUX2CdFzrQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] PCI: qcom: Move IPQ8074 DBI register accesses
 after phy_power_on()
To:     Stanimir Varbanov <svarbanov@mm-sol.com>,
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

On Fri, 24 Jun 2022 at 12:44, Robert Marko <robimarko@gmail.com> wrote:
>
> Currently the Gen2 port in IPQ8074 will cause the system to hang as it
> accesses DBI registers in qcom_pcie_init_2_3_3(), and those are only
> accesible after phy_power_on().
>
> Move the DBI read/writes to a new qcom_pcie_post_init_2_3_3(), which is
> executed after phy_power_on().
>
> Fixes: a0fd361db8e5 ("PCI: dwc: Move "dbi", "dbi2", and "addr_space" resource setup into common code")
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Hi,
Bjorn, is there something else I need to fixup?

Regards,
Robert
> ---
> Changes in v4:
> * Correct title and description
>
> Changes in v3:
> * Make sure it applies onto 5.19-rc3
> * Update the commit description to make it clear this only affects the
> Gen2 port
>
> Changes in v2:
> * Rebase onto next-20220621
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 48 +++++++++++++++-----------
>  1 file changed, 28 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index a1f1aca2fb59..24708d5d817d 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1061,9 +1061,7 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
>         struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
>         struct dw_pcie *pci = pcie->pci;
>         struct device *dev = pci->dev;
> -       u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>         int i, ret;
> -       u32 val;
>
>         for (i = 0; i < ARRAY_SIZE(res->rst); i++) {
>                 ret = reset_control_assert(res->rst[i]);
> @@ -1120,6 +1118,33 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
>                 goto err_clk_aux;
>         }
>
> +       return 0;
> +
> +err_clk_aux:
> +       clk_disable_unprepare(res->ahb_clk);
> +err_clk_ahb:
> +       clk_disable_unprepare(res->axi_s_clk);
> +err_clk_axi_s:
> +       clk_disable_unprepare(res->axi_m_clk);
> +err_clk_axi_m:
> +       clk_disable_unprepare(res->iface);
> +err_clk_iface:
> +       /*
> +        * Not checking for failure, will anyway return
> +        * the original failure in 'ret'.
> +        */
> +       for (i = 0; i < ARRAY_SIZE(res->rst); i++)
> +               reset_control_assert(res->rst[i]);
> +
> +       return ret;
> +}
> +
> +static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
> +{
> +       struct dw_pcie *pci = pcie->pci;
> +       u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +       u32 val;
> +
>         writel(SLV_ADDR_SPACE_SZ,
>                 pcie->parf + PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE);
>
> @@ -1147,24 +1172,6 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
>                 PCI_EXP_DEVCTL2);
>
>         return 0;
> -
> -err_clk_aux:
> -       clk_disable_unprepare(res->ahb_clk);
> -err_clk_ahb:
> -       clk_disable_unprepare(res->axi_s_clk);
> -err_clk_axi_s:
> -       clk_disable_unprepare(res->axi_m_clk);
> -err_clk_axi_m:
> -       clk_disable_unprepare(res->iface);
> -err_clk_iface:
> -       /*
> -        * Not checking for failure, will anyway return
> -        * the original failure in 'ret'.
> -        */
> -       for (i = 0; i < ARRAY_SIZE(res->rst); i++)
> -               reset_control_assert(res->rst[i]);
> -
> -       return ret;
>  }
>
>  static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
> @@ -1596,6 +1603,7 @@ static const struct qcom_pcie_ops ops_2_4_0 = {
>  static const struct qcom_pcie_ops ops_2_3_3 = {
>         .get_resources = qcom_pcie_get_resources_2_3_3,
>         .init = qcom_pcie_init_2_3_3,
> +       .post_init = qcom_pcie_post_init_2_3_3,
>         .deinit = qcom_pcie_deinit_2_3_3,
>         .ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>  };
> --
> 2.36.1
>
