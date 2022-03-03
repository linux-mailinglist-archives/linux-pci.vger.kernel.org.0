Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1154CB6AE
	for <lists+linux-pci@lfdr.de>; Thu,  3 Mar 2022 07:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiCCGKn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Mar 2022 01:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiCCGKm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2022 01:10:42 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B6615C9EB
        for <linux-pci@vger.kernel.org>; Wed,  2 Mar 2022 22:09:58 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id z7so3919967oid.4
        for <linux-pci@vger.kernel.org>; Wed, 02 Mar 2022 22:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F72bStix4IAs331NpnLfcvSkp3vRgdYM9D6jVxCO3QM=;
        b=mSmOEmxrWvorEYk7gtgGW3K4iwExNWCdjz0ETKAOYeEVbyg/cDPlngL2s7hEPx4/2P
         1Dt9/loXa7MYg3XY39YIedYAdXyh2s6Hk4RCByvFFECGsnrOjiVGJm746faqn75T/tCI
         X8rLznuEa7mLlGd8AFgcWMzXYROccUbza3KAh4GXXEumgdBMSVHoGSMkl+kvg3mR0Ryh
         iEo8o0H/db4NyunEi7Jz2O4SqoTcpOG9Q/ZOkIdFY5ZtxwJqwEffbHD+weHSDd9jLpyr
         fps/FD6TN95wlMtVUiP7Xp+ghyc4DoM+drJSnhnp273OFM15OkQ1ydO4+BwAkJrpYO1R
         h+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F72bStix4IAs331NpnLfcvSkp3vRgdYM9D6jVxCO3QM=;
        b=1yLOahINVNp/8saGT1G6VZEOliXOf2wVoSZsYWjnurEAkbagxILopp9VFuYLjQ8ADC
         /nvheCei8E/EVxPApuy+8Xsf7pFnr+QjQdAR6mC/FgzQZtKCRTBDOfze4h5CajiKhLXy
         kwZrHEQYDNzb2z2LypxNfK3kzXCLZ9atYJje5NDTgle7zwHcLb9nkeFJhI3v4ejMOf6s
         NDE116XHoeGIj4puqq8HXcIo1Pns44luwPWqMNKI/z86JoDXZKLZKcZR7VhxF1hsRriU
         BNxSWYIO5kfw1gb4G+1FMwJ8QjO+YyJLVzodPVpPTIMS2mBHdw2XvMVCLJzxWsA6o20d
         3pBg==
X-Gm-Message-State: AOAM531gzSgyaBwLTn3u3JuhDeIQgYZt+592sqA5QjuraJY9hwI6vzB7
        QmPg9+lLRRDfvTM5kALntmvM2jCRUyt3vwmjFXhCGw==
X-Google-Smtp-Source: ABdhPJxP3AtADN5GNByKE/AGLTv6cQU/7GcPF7zfBmZLYqoxmlu3/BeupgEkWEqQsweRc3052c5+h2eBjUrfS2FL/lY=
X-Received: by 2002:a54:4494:0:b0:2d7:652b:287 with SMTP id
 v20-20020a544494000000b002d7652b0287mr3236523oiv.126.1646287797432; Wed, 02
 Mar 2022 22:09:57 -0800 (PST)
MIME-Version: 1.0
References: <20220302203045.184500-1-bhupesh.sharma@linaro.org>
 <20220302203045.184500-8-bhupesh.sharma@linaro.org> <CAA8EJpqEy+669gpDsy-zGp2NpDP-d7ZxNf7RVo=OQZdvGdZOvQ@mail.gmail.com>
In-Reply-To: <CAA8EJpqEy+669gpDsy-zGp2NpDP-d7ZxNf7RVo=OQZdvGdZOvQ@mail.gmail.com>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Thu, 3 Mar 2022 11:39:46 +0530
Message-ID: <CAH=2Ntz2=pgysEVSfSuGd12C-Am-qRZymaotCw-Lwp0_xaNcOg@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] arm64: dts: qcom: sa8155: Enable PCIe nodes
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, bhupesh.linux@gmail.com,
        lorenzo.pieralisi@arm.com, agross@kernel.org,
        bjorn.andersson@linaro.org, svarbanov@mm-sol.com,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Dmitry,

On Thu, 3 Mar 2022 at 02:29, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Wed, 2 Mar 2022 at 23:31, Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
> >
> > SA8155p ADP board supports the PCIe0 controller in the RC
> > mode (only). So add the support for the same.
> >
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Vinod Koul <vkoul@kernel.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sa8155p-adp.dts | 42 ++++++++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> > index 8756c2b25c7e..3f6b3ee404f5 100644
> > --- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> > +++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> > @@ -387,9 +387,51 @@ &usb_2_qmpphy {
> >         vdda-pll-supply = <&vdda_usb_ss_dp_core_1>;
> >  };
> >
> > +&pcie0 {
> > +       status = "okay";
> > +};
> > +
> > +&pcie0_phy {
> > +       status = "okay";
> > +       vdda-phy-supply = <&vreg_l18c_0p88>;
> > +       vdda-pll-supply = <&vreg_l8c_1p2>;
> > +};
> > +
> > +&pcie1_phy {
> > +       vdda-phy-supply = <&vreg_l18c_0p88>;
> > +       vdda-pll-supply = <&vreg_l8c_1p2>;
> > +};
> > +
> >  &tlmm {
> >         gpio-reserved-ranges = <0 4>;
> >
> > +       bt_en_default: bt_en_default {
> > +               mux {
> > +                       pins = "gpio172";
> > +                       function = "gpio";
> > +               };
> > +
> > +               config {
> > +                       pins = "gpio172";
> > +                       drive-strength = <2>;
> > +                       bias-pull-down;
> > +               };
> > +       };
> > +
> > +       wlan_en_default: wlan_en_default {
> > +               mux {
> > +                       pins = "gpio169";
> > +                       function = "gpio";
> > +               };
> > +
> > +               config {
> > +                       pins = "gpio169";
> > +                       drive-strength = <16>;
> > +                       output-high;
> > +                       bias-pull-up;
> > +               };
> > +       };
> > +
>
> Not related to PCIe

Hmm.. I have no strong personal opinion on this, so let's see what
Bjorn thinks about the same.
My reasoning for keeping it here was to just capture that we have
'bt_en' and 'wlan_en' related tlmm details here, so that when you send
out the reworked QCAxxxx mfd series (see [1]) later, I can easily plug
it in for SA8155p ADP dts as well with the 'bt' and 'wlan' constructs.

[1]. https://lore.kernel.org/lkml/20210621223141.1638189-2-dmitry.baryshkov@linaro.org/T/

Regards.
Bhupesh

> >         usb2phy_ac_en1_default: usb2phy_ac_en1_default {
> >                 mux {
> >                         pins = "gpio113";
> > --
> > 2.35.1
> >
>
>
> --
> With best wishes
> Dmitry
