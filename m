Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576926FB08A
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 14:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbjEHMrI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 08:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjEHMrH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 08:47:07 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EF219D4B
        for <linux-pci@vger.kernel.org>; Mon,  8 May 2023 05:47:05 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-b9ddcf0afb3so6022448276.3
        for <linux-pci@vger.kernel.org>; Mon, 08 May 2023 05:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683550025; x=1686142025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zasgJqK4/xXN93z/6quZqlnv3qeuCfz7ocg5qzyPXEg=;
        b=RajjGp62Dz8ojYRdb7Qa+Wgfqgh0PaYifZWF3TTdykBqxGdZt1EVUNJgaYudAdgH0B
         Xg3JTqbjfMPvBykB3B6dUqxM06VYHhnFiNb3XE/XcC5Ztyh78OLAKhrw8PJejX4YFTTI
         T+vB1pGR+mi+xkQCqUtCMQ3MiOTb3EVdwWrk+TUiA6ZINQyKLNhD43v6BQQrRv7+JRMi
         cvCUkWJxZLkwp7i2rmC3lnRSgHo1Rn4cL6SmvIWuptJmL7XUBS9mqJyvHLzQR09YswpU
         2D5jSNDym1P0IVrN+9et2PxQcAuUbnvM+P999GHkyxqaoLLaOQRZYvQq/YGWMa62+THX
         hmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683550025; x=1686142025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zasgJqK4/xXN93z/6quZqlnv3qeuCfz7ocg5qzyPXEg=;
        b=BKGBGCN8flcU3+AFaoScBA3EdroIyxZM6mEz3yxaMJrJ+T0820LMOUeDR7J+LiT9cf
         SC5MUJdk/Ppfv3N73XTSbRrM6yfVKh14MPwYxwnOkPf+7/8xb2w8DDy23eYzhx8IML98
         mFmq+/lbEzu6+Ka9CNEcZu9Na9KbzRvVzGqK/BoPBFa+EEEhHSodBwOjNvvc6Bb5JfCK
         fhPEAk1YrJIOhfyoByDuZ1p1rksBFVaoZqdzzCuLi/vuoXNonpc+9NragB2zCbqaY6EC
         nuTYzW2xjZ3ZfWNV3retwQYx9e6kLEOC+93lOXTeIyJQK0bIDFSCDEBLV1Xp+K/jJhCA
         SNXQ==
X-Gm-Message-State: AC+VfDyePcyEtXQ0Z0qALOdylFiXx+x2ZeI+FeU9R0hlr2TZp3pACqIc
        UEAYKxmySpcnB0fphuQMHav3O/uBrHyrJnCYN0u2ow==
X-Google-Smtp-Source: ACHHUZ53AC1hM60sp7/VCP+nhBtzioSIHDIvS/pGi97VmrDQO+/wKeMaoVDcdKw+DXIsXe0NDeF2BZWop2xGNZr78VA=
X-Received: by 2002:a25:fc0a:0:b0:b9e:8f7b:5c36 with SMTP id
 v10-20020a25fc0a000000b00b9e8f7b5c36mr10696865ybd.17.1683550024778; Mon, 08
 May 2023 05:47:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230421124938.21974-1-quic_devipriy@quicinc.com>
 <20230421124938.21974-7-quic_devipriy@quicinc.com> <20230508122109.GC4190@thinkpad>
In-Reply-To: <20230508122109.GC4190@thinkpad>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 8 May 2023 15:46:53 +0300
Message-ID: <CAA8EJppKUwfatdNoQPD4QbEPXyv1cEz3cDLfND+70Veq5Bcf8Q@mail.gmail.com>
Subject: Re: [PATCH V3 6/6] PCI: qcom: Add support for IPQ9574
To:     Manivannan Sadhasivam <mani@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 8 May 2023 at 15:21, Manivannan Sadhasivam <mani@kernel.org> wrote:
>
> On Fri, Apr 21, 2023 at 06:19:38PM +0530, Devi Priya wrote:
> > The IPQ9574 platform has 4 Gen3 PCIe controllers: two single-lane
> > and two dual-lane based on SNPS core 5.70a
> > The Qcom IP rev is 1.27.0 and Synopsys IP rev is 5.80a
> > Added a new compatible 'qcom,pcie-ipq9574' and 'ops_1_27_0'
> > which reuses all the members of 'ops_2_9_0' except for the post_init
> > as the SLV_ADDR_SPACE_SIZE configuration differs between 2_9_0
> > and 1_27_0.
> > Also, modified get_resources of 'ops 2_9_0' to get the clocks
> > from the device tree and modelled the post init sequence as
> > a common function to avoid code redundancy.
> >
> > Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> > Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> > Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>
> One comment below. With that fixed,
>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
>
> - Mani
>
> > ---
> >  Changes in V3:
> >       - Rebased on top of linux-next/master
> >
> >  drivers/pci/controller/dwc/pcie-qcom.c | 61 ++++++++++++++++++--------
> >  1 file changed, 43 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/contr=
oller/dwc/pcie-qcom.c
> > index 4ab30892f6ef..3682ecdead1f 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -107,6 +107,7 @@
> >
> >  /* PARF_SLV_ADDR_SPACE_SIZE register value */
> >  #define SLV_ADDR_SPACE_SZ                    0x10000000
> > +#define SLV_ADDR_SPACE_SZ_1_27_0             0x08000000
> >
> >  /* PARF_MHI_CLOCK_RESET_CTRL register fields */
> >  #define AHB_CLK_EN                           BIT(0)
> > @@ -202,10 +203,10 @@ struct qcom_pcie_resources_2_7_0 {
> >       struct reset_control *rst;
> >  };
> >
> > -#define QCOM_PCIE_2_9_0_MAX_CLOCKS           5
> >  struct qcom_pcie_resources_2_9_0 {
> > -     struct clk_bulk_data clks[QCOM_PCIE_2_9_0_MAX_CLOCKS];
> > +     struct clk_bulk_data *clks;
> >       struct reset_control *rst;
> > +     int num_clks;
> >  };
> >
> >  union qcom_pcie_resources {
> > @@ -1050,17 +1051,10 @@ static int qcom_pcie_get_resources_2_9_0(struct=
 qcom_pcie *pcie)
> >       struct qcom_pcie_resources_2_9_0 *res =3D &pcie->res.v2_9_0;
> >       struct dw_pcie *pci =3D pcie->pci;
> >       struct device *dev =3D pci->dev;
> > -     int ret;
> >
> > -     res->clks[0].id =3D "iface";
> > -     res->clks[1].id =3D "axi_m";
> > -     res->clks[2].id =3D "axi_s";
> > -     res->clks[3].id =3D "axi_bridge";
> > -     res->clks[4].id =3D "rchng";
> > -
> > -     ret =3D devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
> > -     if (ret < 0)
> > -             return ret;
> > +     res->num_clks =3D devm_clk_bulk_get_all(dev, &res->clks);
> > +     if (res->clks < 0)
> > +             return res->num_clks;
>
> Why not return proper error no?

Instead the question should be, why not the proper condition: it tells
`if (res->clks < 0)', while it should be `if (res->num_clks < 0)'.

>
> >
> >       res->rst =3D devm_reset_control_array_get_exclusive(dev);
> >       if (IS_ERR(res->rst))
> > @@ -1073,7 +1067,7 @@ static void qcom_pcie_deinit_2_9_0(struct qcom_pc=
ie *pcie)
> >  {
> >       struct qcom_pcie_resources_2_9_0 *res =3D &pcie->res.v2_9_0;
> >
> > -     clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
> > +     clk_bulk_disable_unprepare(res->num_clks, res->clks);
> >  }
> >
> >  static int qcom_pcie_init_2_9_0(struct qcom_pcie *pcie)
> > @@ -1102,19 +1096,16 @@ static int qcom_pcie_init_2_9_0(struct qcom_pci=
e *pcie)
> >
> >       usleep_range(2000, 2500);
> >
> > -     return clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
> > +     return clk_bulk_prepare_enable(res->num_clks, res->clks);
> >  }
> >
> > -static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
> > +static int qcom_pcie_post_init(struct qcom_pcie *pcie)
> >  {
> >       struct dw_pcie *pci =3D pcie->pci;
> >       u16 offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> >       u32 val;
> >       int i;
> >
> > -     writel(SLV_ADDR_SPACE_SZ,
> > -             pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
> > -
> >       val =3D readl(pcie->parf + PARF_PHY_CTRL);
> >       val &=3D ~PHY_TEST_PWR_DOWN;
> >       writel(val, pcie->parf + PARF_PHY_CTRL);
> > @@ -1151,6 +1142,26 @@ static int qcom_pcie_post_init_2_9_0(struct qcom=
_pcie *pcie)
> >       return 0;
> >  }
> >
> > +static int qcom_pcie_post_init_1_27_0(struct qcom_pcie *pcie)
> > +{
> > +     writel(SLV_ADDR_SPACE_SZ_1_27_0,
> > +            pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
> > +
> > +     qcom_pcie_post_init(pcie);
> > +
> > +     return 0;
> > +}
> > +
> > +static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
> > +{
> > +     writel(SLV_ADDR_SPACE_SZ,
> > +            pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
> > +
> > +     qcom_pcie_post_init(pcie);
> > +
> > +     return 0;
> > +}
> > +
> >  static int qcom_pcie_link_up(struct dw_pcie *pci)
> >  {
> >       u16 offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > @@ -1291,6 +1302,15 @@ static const struct qcom_pcie_ops ops_2_9_0 =3D =
{
> >       .ltssm_enable =3D qcom_pcie_2_3_2_ltssm_enable,
> >  };
> >
> > +/* Qcom IP rev.: 1.27.0  Synopsys IP rev.: 5.80a */
> > +static const struct qcom_pcie_ops ops_1_27_0 =3D {
> > +     .get_resources =3D qcom_pcie_get_resources_2_9_0,
> > +     .init =3D qcom_pcie_init_2_9_0,
> > +     .post_init =3D qcom_pcie_post_init_1_27_0,
> > +     .deinit =3D qcom_pcie_deinit_2_9_0,
> > +     .ltssm_enable =3D qcom_pcie_2_3_2_ltssm_enable,
> > +};
> > +
> >  static const struct qcom_pcie_cfg cfg_1_0_0 =3D {
> >       .ops =3D &ops_1_0_0,
> >  };
> > @@ -1323,6 +1343,10 @@ static const struct qcom_pcie_cfg cfg_2_9_0 =3D =
{
> >       .ops =3D &ops_2_9_0,
> >  };
> >
> > +static const struct qcom_pcie_cfg cfg_1_27_0 =3D {
> > +     .ops =3D &ops_1_27_0,
> > +};
> > +
> >  static const struct dw_pcie_ops dw_pcie_ops =3D {
> >       .link_up =3D qcom_pcie_link_up,
> >       .start_link =3D qcom_pcie_start_link,
> > @@ -1607,6 +1631,7 @@ static const struct of_device_id qcom_pcie_match[=
] =3D {
> >       { .compatible =3D "qcom,pcie-ipq8064-v2", .data =3D &cfg_2_1_0 },
> >       { .compatible =3D "qcom,pcie-ipq8074", .data =3D &cfg_2_3_3 },
> >       { .compatible =3D "qcom,pcie-ipq8074-gen3", .data =3D &cfg_2_9_0 =
},
> > +     { .compatible =3D "qcom,pcie-ipq9574", .data =3D &cfg_1_27_0 },
> >       { .compatible =3D "qcom,pcie-msm8996", .data =3D &cfg_2_3_2 },
> >       { .compatible =3D "qcom,pcie-qcs404", .data =3D &cfg_2_4_0 },
> >       { .compatible =3D "qcom,pcie-sa8540p", .data =3D &cfg_1_9_0 },
> > --
> > 2.17.1
> >
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D



--=20
With best wishes
Dmitry
