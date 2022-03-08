Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F36C4D244F
	for <lists+linux-pci@lfdr.de>; Tue,  8 Mar 2022 23:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350827AbiCHWdE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Mar 2022 17:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350751AbiCHWcu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Mar 2022 17:32:50 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D0E5A097
        for <linux-pci@vger.kernel.org>; Tue,  8 Mar 2022 14:31:51 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id t8-20020a0568301e2800b005b235a56f2dso405161otr.9
        for <linux-pci@vger.kernel.org>; Tue, 08 Mar 2022 14:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yu1THqTGD6F10/7zLdE8sY/7tnkCw2lQhVUm7kdi5Vs=;
        b=zM6yJDkCXVr46DAoZEfhO1+xZLGgCRwLMK9TAYUYZVTFi0U5oPxRtHIVQ7xmtlSpMI
         3E8Zq03Dbu+RxrYTIpq2jMcfSFLBmdtuyeiOFn/NaomcmAli5diS6gEyBm1jpZM1t5jT
         dvkq6b9VKQvyrK819bjV/z5ga84NAouXrIchc3cnFe7J9Ph8ty8CSO3Ls09pu0+6JQg4
         VO1vBoP7KH5b9CkJBeYwxPKJXC3oPsEvKV0yYGtVOBrM4mUQkExaBH8vhc00KjKA2ynY
         cEENkWVocmJAKULBG2HXLq6f/fRoupJS9KM8zXL5ixYiW3CKIG8xeNpQA2JR1DtiyMEz
         uhpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yu1THqTGD6F10/7zLdE8sY/7tnkCw2lQhVUm7kdi5Vs=;
        b=UPw0CsblE1iHTR4oAz3vEa4nFva2rFktMSIzkgFabdYfq1LcfFxGeGFugOtrP7Z8cZ
         IsW4TP8e+T+WkN1xa+n62rSj+dW1M61FF3a7/EcU0eoDcYVu4kamp31sJ+EbfvMds7vB
         bl5HfPS91XuCKUNzM6GBix3ZSBzTTBU5Kr9+UBSd1d7x+yWX4TxFix8T9t5KXXoS98cE
         VG9Xerb9Ji9viossBz22m2bLlAiuE1dshyAIidkqHxTUiF4MoYKPr9waVq0MbDjv765g
         oycPTz2s/gnn6sGrJYlY5oNVBkp/TkWNohqwoPx9T7Syfn5F9tCzpjW6hDYwkpjOq4nJ
         ywCg==
X-Gm-Message-State: AOAM532Tm7NqlOos5r+zh0eL4EI2lbXn9ZFfZ/F7b5o+SjHN2VqVthNC
        svndk4ZXhrTVxELturEw+oy/Jg==
X-Google-Smtp-Source: ABdhPJzj4SI3aBtkqXo6gIsiBBn8CcMdnLEkOtQN5+H1BR7bbwBxT7uH7KUFlOg2LT41M+Vsy/RXfQ==
X-Received: by 2002:a05:6830:43a0:b0:5af:e328:6bc7 with SMTP id s32-20020a05683043a000b005afe3286bc7mr9495407otv.62.1646778710427;
        Tue, 08 Mar 2022 14:31:50 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id f4-20020a056870d30400b000da71ab35e0sm78779oag.44.2022.03.08.14.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 14:31:49 -0800 (PST)
Date:   Tue, 8 Mar 2022 16:31:46 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, bhupesh.linux@gmail.com,
        lorenzo.pieralisi@arm.com, agross@kernel.org, svarbanov@mm-sol.com,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v3 7/7] arm64: dts: qcom: sa8155: Enable PCIe nodes
Message-ID: <YifZUtH8hbelcB8L@builder.lan>
References: <20220302203045.184500-1-bhupesh.sharma@linaro.org>
 <20220302203045.184500-8-bhupesh.sharma@linaro.org>
 <CAA8EJpqEy+669gpDsy-zGp2NpDP-d7ZxNf7RVo=OQZdvGdZOvQ@mail.gmail.com>
 <CAH=2Ntz2=pgysEVSfSuGd12C-Am-qRZymaotCw-Lwp0_xaNcOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH=2Ntz2=pgysEVSfSuGd12C-Am-qRZymaotCw-Lwp0_xaNcOg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu 03 Mar 00:09 CST 2022, Bhupesh Sharma wrote:

> Hi Dmitry,
> 
> On Thu, 3 Mar 2022 at 02:29, Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Wed, 2 Mar 2022 at 23:31, Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
> > >
> > > SA8155p ADP board supports the PCIe0 controller in the RC
> > > mode (only). So add the support for the same.
> > >
> > > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > Cc: Vinod Koul <vkoul@kernel.org>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/sa8155p-adp.dts | 42 ++++++++++++++++++++++++
> > >  1 file changed, 42 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> > > index 8756c2b25c7e..3f6b3ee404f5 100644
> > > --- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> > > +++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> > > @@ -387,9 +387,51 @@ &usb_2_qmpphy {
> > >         vdda-pll-supply = <&vdda_usb_ss_dp_core_1>;
> > >  };
> > >
> > > +&pcie0 {
> > > +       status = "okay";
> > > +};
> > > +
> > > +&pcie0_phy {
> > > +       status = "okay";
> > > +       vdda-phy-supply = <&vreg_l18c_0p88>;
> > > +       vdda-pll-supply = <&vreg_l8c_1p2>;
> > > +};
> > > +
> > > +&pcie1_phy {
> > > +       vdda-phy-supply = <&vreg_l18c_0p88>;
> > > +       vdda-pll-supply = <&vreg_l8c_1p2>;
> > > +};
> > > +
> > >  &tlmm {
> > >         gpio-reserved-ranges = <0 4>;
> > >
> > > +       bt_en_default: bt_en_default {

'_' is not a valid character in the node name (it is in the label).

> > > +               mux {

Please flatten this, you can omit the mux and config subnodes and put
the properties directly in the state node.

> > > +                       pins = "gpio172";
> > > +                       function = "gpio";
> > > +               };
> > > +
> > > +               config {
> > > +                       pins = "gpio172";
> > > +                       drive-strength = <2>;
> > > +                       bias-pull-down;
> > > +               };
> > > +       };
> > > +
> > > +       wlan_en_default: wlan_en_default {
> > > +               mux {
> > > +                       pins = "gpio169";
> > > +                       function = "gpio";
> > > +               };
> > > +
> > > +               config {
> > > +                       pins = "gpio169";
> > > +                       drive-strength = <16>;
> > > +                       output-high;
> > > +                       bias-pull-up;
> > > +               };
> > > +       };
> > > +
> >
> > Not related to PCIe
> 
> Hmm.. I have no strong personal opinion on this, so let's see what
> Bjorn thinks about the same.
> My reasoning for keeping it here was to just capture that we have
> 'bt_en' and 'wlan_en' related tlmm details here, so that when you send
> out the reworked QCAxxxx mfd series (see [1]) later, I can easily plug
> it in for SA8155p ADP dts as well with the 'bt' and 'wlan' constructs.
> 

The BT_EN is unrelated to PCIe, and I'm not able to see where you select
the wlan_en_default state, so this would be dangling.

So the bt_en should come in a patch together with a bluetooth node and
the wlan_en_default should come with something that ensures that the
WiFi portion of the chip is powered and the gpio enabled.

Regards,
Bjorn

> [1]. https://lore.kernel.org/lkml/20210621223141.1638189-2-dmitry.baryshkov@linaro.org/T/
> 
> Regards.
> Bhupesh
> 
> > >         usb2phy_ac_en1_default: usb2phy_ac_en1_default {
> > >                 mux {
> > >                         pins = "gpio113";
> > > --
> > > 2.35.1
> > >
> >
> >
> > --
> > With best wishes
> > Dmitry
