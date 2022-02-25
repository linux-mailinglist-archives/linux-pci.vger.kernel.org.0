Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401B74C3B54
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 02:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbiBYB4F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Feb 2022 20:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235499AbiBYB4E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Feb 2022 20:56:04 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB84629F40A
        for <linux-pci@vger.kernel.org>; Thu, 24 Feb 2022 17:55:32 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id fc19so5646159qvb.7
        for <linux-pci@vger.kernel.org>; Thu, 24 Feb 2022 17:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iP7thDEIqxn21zEZ3PMQ8d97ApEy1E0BI3PlG0cqqqI=;
        b=NSeSMtKyj99jH6jqKoa2oCetHycscOUuBA/ciiagthe8WbrbdyH0oidbOzNB+GERnt
         7GnT/yi8vHXZcLBjuuoUrQrvugyOxEsqKBuT9cqMKzKkNTDmnsJ5F8+hBygrIew4P/xi
         iDE5v+T5pIPrHPNMDt4kp9uwi8SJzUoXZFdV+R9mGh1DY6D+P+odFk0wJn2QpK3ptoKg
         5B+JqsP4B0xs4dYeESfLwcCVPsdhHn0lV28Ikb1pReztaeqiGi9LNOetNboF7i+aMBK/
         XsGzdFloUsCb1v4vegIbb2dfUTC7cJ2LFPcYyO3jRcPAQ5+4T+07vcD5AvMeKiRvtMK2
         XZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iP7thDEIqxn21zEZ3PMQ8d97ApEy1E0BI3PlG0cqqqI=;
        b=2ED/Z1tsm1W25IZc3BBoA8Oz5FYgTQAKc9MDuCzPZMiU9hbTQjGThDPGlA1nun7NGA
         5+X+VdXDvUBtKTuni6cnO4cpHCX46pHTErBtnOw4HAwOP4TbvrEz8Bme/h8E1+P2TqGM
         Nd5IEJyCm4HJyaMVRFs9TeWKYV9ojBfKAgEF1ZGrewEwCvh9HxpyZbkbcM6ixnFN6DoM
         RMGenxg3lJVTf03YgUtsxWdaMIVPKcZT1LxaVDPGLCwnG42hAbDMMFP21Zp1v+kq2eOO
         F+PdOnhP6452+k5Fycl+fEaKS7f1PunBElf9hKJJVjx44AxfzmQGVJTEmEK7KS6cFjFy
         SgLA==
X-Gm-Message-State: AOAM531yDbhexoLy7c88S33j2Bkui/ane/NQTebPqoFvpuKyUSFZpEu2
        iH8hsewwESDacB8N0oZuZERd+SQJdkQ8qcAbESyH2H/vmmw=
X-Google-Smtp-Source: ABdhPJwtcqY26Ilbtl3vvQJTUAkuzzp0wReye57bVm9rFgd6ozvVavrVULfow+3AJDcxUKcr2DWV3V7izjvlasLLu1c=
X-Received: by 2002:a05:6214:400a:b0:431:7f6c:98fc with SMTP id
 kd10-20020a056214400a00b004317f6c98fcmr4206463qvb.122.1645754132127; Thu, 24
 Feb 2022 17:55:32 -0800 (PST)
MIME-Version: 1.0
References: <20220204144645.3016603-1-dmitry.baryshkov@linaro.org>
 <20220204144645.3016603-4-dmitry.baryshkov@linaro.org> <Yf2jRAf5UKYSMYxe@builder.lan>
 <f521a273-7250-ddca-0e56-b1b27bd75117@linaro.org> <CO1PR02MB8537B9CA859D2719B3BDC4FEE9349@CO1PR02MB8537.namprd02.prod.outlook.com>
In-Reply-To: <CO1PR02MB8537B9CA859D2719B3BDC4FEE9349@CO1PR02MB8537.namprd02.prod.outlook.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 25 Feb 2022 04:55:21 +0300
Message-ID: <CAA8EJpor6beihED6oAPb26PMT0_VjFBnmaAyeakh4eJFyF9_NQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] clk: qcom: gdsc: add support for clocks tied to
 the GDSC
To:     "Prasad Malisetty (Temp) (QUIC)" <quic_pmaliset@quicinc.com>
Cc:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Wilczy??ski" <kw@linux.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Prasad Malisetty <pmaliset@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 15 Feb 2022 at 13:24, Prasad Malisetty (Temp) (QUIC)
<quic_pmaliset@quicinc.com> wrote:
>
>
>
> -----Original Message-----
> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Sent: Saturday, February 12, 2022 1:23 AM
> To: bjorn.andersson@linaro.org; Prasad Malisetty (Temp) (QUIC) <quic_pmal=
iset@quicinc.com>
> Cc: Andy Gross <agross@kernel.org>; Stanimir Varbanov <svarbanov@mm-sol.c=
om>; Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; Rob Herring <robh+dt@ke=
rnel.org>; Krzysztof Wilczy??ski <kw@linux.com>; Michael Turquette <mturque=
tte@baylibre.com>; Stephen Boyd <swboyd@chromium.org>; Bjorn Helgaas <bhelg=
aas@google.com>; Prasad Malisetty <pmaliset@codeaurora.org>; Vinod Koul <vk=
oul@kernel.org>; linux-arm-msm@vger.kernel.org; linux-pci@vger.kernel.org; =
linux-clk@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [PATCH v2 03/11] clk: qcom: gdsc: add support for clocks tie=
d to the GDSC
>
> On 05/02/2022 01:05, Bjorn Andersson wrote:
> > On Fri 04 Feb 08:46 CST 2022, Dmitry Baryshkov wrote:
> >
> >> On newer Qualcomm platforms GCC_PCIE_n_PIPE_CLK_SRC should be
> >> controlled together with the PCIE_n_GDSC. The clock should be fed
> >> from the TCXO before switching the GDSC off and can be fed from
> >> PCIE_n_PIPE_CLK once the GDSC is on.
> >>
> >> Since commit aa9c0df98c29 ("PCI: qcom: Switch pcie_1_pipe_clk_src
> >> after PHY init in SC7280") PCIe controller driver tries to manage
> >> this on it's own, resulting in the non-optimal code. Furthermore, if
> >> the any of the drivers will have the same requirements, the code
> >> would have to be dupliacted there.
> >>
> >> Move handling of such clocks to the GDSC code, providing special GDSC
> >> type.
> >>
> >
> > As discussed on IRC, I'm inclined not to take this, because looks to
> > me to be the same situation that we have with all GDSCs in SM8350 and
> > onwards - that some clocks must be parked on a safe parent before the
> > associated GDSC can be toggled.
> >
> > Prasad, please advice on what the actual requirements are wrt the
> > gcc_pipe_clk_src. When does it need to provide a valid signal and when
> > does it need to be parked?
>
> [Excuse me for the duplicate, Prasad's email was bouncing]
>
> Prasad, any comments?
>
> >
> > Regards,
> > Bjorn
> >
>
> Hi  Dmitry,
>
> Greetings !!!
>
> Sorry for the inconvenience,  there was an issue with my mail so I couldn=
=E2=80=99t receive the updates properly. Now issue is resolved.
> I am in discussion with internal team to know more about this. I will upd=
ate my comments after this discussion.

Prasad, any updates on this topic?

>
> Thanks
> -Prasad
>
> >> Cc: Prasad Malisetty <pmaliset@codeaurora.org>
> >> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >> ---
> >>   drivers/clk/qcom/gdsc.c | 41 +++++++++++++++++++++++++++++++++++++++=
++
> >>   drivers/clk/qcom/gdsc.h | 14 ++++++++++++++
> >>   2 files changed, 55 insertions(+)
> >>
> >> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c index
> >> 7e1dd8ccfa38..9913d1b70947 100644
> >> --- a/drivers/clk/qcom/gdsc.c
> >> +++ b/drivers/clk/qcom/gdsc.c
> >> @@ -45,6 +45,7 @@
> >>   #define TIMEOUT_US         500
> >>
> >>   #define domain_to_gdsc(domain) container_of(domain, struct gdsc,
> >> pd)
> >> +#define domain_to_pipe_clk_gdsc(domain) container_of(domain, struct
> >> +pipe_clk_gdsc, base.pd)
> >>
> >>   enum gdsc_status {
> >>      GDSC_OFF,
> >> @@ -549,3 +550,43 @@ int gdsc_gx_do_nothing_enable(struct generic_pm_d=
omain *domain)
> >>      return 0;
> >>   }
> >>   EXPORT_SYMBOL_GPL(gdsc_gx_do_nothing_enable);
> >> +
> >> +/*
> >> + * Special operations for GDSCs with attached pipe clocks.
> >> + * The clock should be parked to safe source (tcxo) before turning
> >> +off the GDSC
> >> + * and can be switched on as soon as the GDSC is on.
> >> + *
> >> + * We remove respective clock sources from clocks map and handle them=
 manually.
> >> + */
> >> +int gdsc_pipe_enable(struct generic_pm_domain *domain) {
> >> +    struct pipe_clk_gdsc *sc =3D domain_to_pipe_clk_gdsc(domain);
> >> +    int i, ret;
> >> +
> >> +    ret =3D gdsc_enable(domain);
> >> +    if (ret)
> >> +            return ret;
> >> +
> >> +    for (i =3D 0; i< sc->num_clocks; i++)
> >> +            regmap_update_bits(sc->base.regmap, sc->clocks[i].reg,
> >> +                            BIT(sc->clocks[i].shift + sc->clocks[i].w=
idth) - BIT(sc->clocks[i].shift),
> >> +                            sc->clocks[i].on_value << sc->clocks[i].s=
hift);
> >> +
> >> +    return 0;
> >> +}
> >> +EXPORT_SYMBOL_GPL(gdsc_pipe_enable);
> >> +
> >> +int gdsc_pipe_disable(struct generic_pm_domain *domain) {
> >> +    struct pipe_clk_gdsc *sc =3D domain_to_pipe_clk_gdsc(domain);
> >> +    int i;
> >> +
> >> +    for (i =3D sc->num_clocks - 1; i >=3D 0; i--)
> >> +            regmap_update_bits(sc->base.regmap, sc->clocks[i].reg,
> >> +                            BIT(sc->clocks[i].shift + sc->clocks[i].w=
idth) - BIT(sc->clocks[i].shift),
> >> +                            sc->clocks[i].off_value << sc->clocks[i].=
shift);
> >> +
> >> +    /* In case of an error do not try turning the clocks again. We ca=
n not be sure about the GDSC state. */
> >> +    return gdsc_disable(domain);
> >> +}
> >> +EXPORT_SYMBOL_GPL(gdsc_pipe_disable);
> >> diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h index
> >> d7cc4c21a9d4..b1a2f0abe41c 100644
> >> --- a/drivers/clk/qcom/gdsc.h
> >> +++ b/drivers/clk/qcom/gdsc.h
> >> @@ -68,11 +68,25 @@ struct gdsc_desc {
> >>      size_t num;
> >>   };
> >>
> >> +struct pipe_clk_gdsc {
> >> +    struct gdsc base;
> >> +    int num_clocks;
> >> +    struct {
> >> +            u32 reg;
> >> +            u32 shift;
> >> +            u32 width;
> >> +            u32 off_value;
> >> +            u32 on_value;
> >> +    } clocks[];
> >> +};
> >> +
> >>   #ifdef CONFIG_QCOM_GDSC
> >>   int gdsc_register(struct gdsc_desc *desc, struct reset_controller_de=
v *,
> >>                struct regmap *);
> >>   void gdsc_unregister(struct gdsc_desc *desc);
> >>   int gdsc_gx_do_nothing_enable(struct generic_pm_domain *domain);
> >> +int gdsc_pipe_enable(struct generic_pm_domain *domain); int
> >> +gdsc_pipe_disable(struct generic_pm_domain *domain);
> >>   #else
> >>   static inline int gdsc_register(struct gdsc_desc *desc,
> >>                              struct reset_controller_dev *rcdev,
> >> --
> >> 2.34.1
> >>
>
>
> --
> With best wishes
> Dmitry



--=20
With best wishes
Dmitry
