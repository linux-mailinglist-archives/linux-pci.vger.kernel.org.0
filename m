Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7773C6440DA
	for <lists+linux-pci@lfdr.de>; Tue,  6 Dec 2022 10:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbiLFJ4A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Dec 2022 04:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235562AbiLFJzZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Dec 2022 04:55:25 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DD427CC8;
        Tue,  6 Dec 2022 01:51:52 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 136so12921957pga.1;
        Tue, 06 Dec 2022 01:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U+fxm9YTmv9JfkvctmWrMw1uJzYw0A6ddSWm2DcTfh4=;
        b=KASsjemV5+/UsBsF+0fNzCSb4WFN82ryD6ERtjetC0+DEaZ4O9MLj81oSaZ8EbY+O8
         GcPaq7/5jK0+4LDB/DIlyERXnYV4N/sT3WK+IkIxdGke/W5eF3Owfo7S9xatHLI8xST6
         0iZ7DmP/wlDGthhrkgFcFrRZXMVO9X6Hhn/5rezUFY4QfliobAmX01jM6Ic+TPC3Jw4C
         dklcRUxBnyJW6qCpWPSK+jaAgBAAoaOOdYH1MwTnVlqELriUF0KQgFrvA9XJzwoJszbt
         dBAwTO3mC3JAaPuxhejeumvj1xC3omn11r078yyUL162A9pbz5peX7nal3E5ZD+O6tkG
         BXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U+fxm9YTmv9JfkvctmWrMw1uJzYw0A6ddSWm2DcTfh4=;
        b=cpI+vwLa3PJ9qpLpK+yqTSup4cIQx1CIioIsODI7g1RpW1R7mSYDf7f8JPReiZcv+1
         +Tlz9gmvfD/VSkVqyh0zXthHv3UzG2/UH+2952ypCzQOGKCLWy6X1PTGUguXnPhlnGO9
         +3D1iiTwJzMrQR7KLEZzG9ONuxuxaOionPX7Eop5XAfL9gH/HrZbChHWoJjIJYwT1yVm
         a7BIFfmUdy7Qjk55a6AD6/SWZ96UQYLA7XOhms6rjBu19AtdIDItAkvVOded6XiFWbgh
         GkyII28PJZtvOKInB0uiDmBPLfSkjnPH3Badw/mM9P8/rFm7/JRCxRFmO1nA2FX8HF7L
         aMFQ==
X-Gm-Message-State: ANoB5pk7vRDJKdTsfYIM+rA1ZWOV0IIpcES+H5cXCXeBd6cKs+gxpaR5
        MSGhP4xqgJYljPHaLJ41G0HTzFnDYPeIXKbV3ew=
X-Google-Smtp-Source: AA0mqf5d8uc1OW9kDo+vs3txxtsxPOjtgmnKTtoagFg6Uf4h1rNHwVGjMS3M09jEM2gFVlWLTIitSlqPsVE3oDgjOXI=
X-Received: by 2002:a63:d52:0:b0:477:66cb:b99 with SMTP id 18-20020a630d52000000b0047766cb0b99mr60852174pgn.10.1670320311315;
 Tue, 06 Dec 2022 01:51:51 -0800 (PST)
MIME-Version: 1.0
References: <20221116214841.1116735-1-robimarko@gmail.com> <20221116214841.1116735-2-robimarko@gmail.com>
 <20221205215253.itobukkyiecn7xi7@builder.lan>
In-Reply-To: <20221205215253.itobukkyiecn7xi7@builder.lan>
From:   Robert Marko <robimarko@gmail.com>
Date:   Tue, 6 Dec 2022 10:51:40 +0100
Message-ID: <CAOX2RU5C6uYKS4Hc7NBwnzRju1=gzewrEHudMksUAL1XdKcfCQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] arm64: dts: qcom: ipq8074: fix Gen3 PCIe QMP PHY
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, bhelgaas@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mani@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        svarbanov@mm-sol.com, shawn.guo@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 5 Dec 2022 at 22:52, Bjorn Andersson <andersson@kernel.org> wrote:
>
> On Wed, Nov 16, 2022 at 10:48:34PM +0100, Robert Marko wrote:
> > IPQ8074 comes in 2 silicon versions:
> > * v1 with 2x Gen2 PCIe ports and QMP PHY-s
> > * v2 with 1x Gen3 and 1x Gen2 PCIe ports and QMP PHY-s
> >
> > v2 is the final and production version that is actually supported by the
> > kernel, however it looks like PCIe related nodes were added for the v1 SoC.
> >
> > Now that we have Gen3 QMP PHY support, we can start fixing the PCIe support
> > by fixing the Gen3 QMP PHY node first.
> >
> > Change the compatible to the Gen3 QMP PHY, correct the register space start
> > and size, add the missing misc PCS register space.
> >
>
> Does this imply that the current node doesn't actually work?

Hi Bjorn,
Yes, the node is for a completely different PHY generation, basically
PCIe on IPQ8074
is completely broken, hence this patch series.

>
> If that's the case, could we perhaps adopt Johan Hovolds' new binding
> and drop the subnode in favor of just a flat reg covering the whole
> QMP region?

I have not seen that so far, any examples?

Regards,
Robert
>
> Regards,
> Bjorn
>
> > Fixes: 33057e1672fe ("ARM: dts: ipq8074: Add pcie nodes")
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> >  arch/arm64/boot/dts/qcom/ipq8074.dtsi | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> > index 6649a758d8df..9503dfb25d50 100644
> > --- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> > @@ -232,9 +232,9 @@ qusb_phy_0: phy@79000 {
> >                       status = "disabled";
> >               };
> >
> > -             pcie_qmp0: phy@86000 {
> > -                     compatible = "qcom,ipq8074-qmp-pcie-phy";
> > -                     reg = <0x00086000 0x1c4>;
> > +             pcie_qmp0: phy@84000 {
> > +                     compatible = "qcom,ipq8074-qmp-gen3-pcie-phy";
> > +                     reg = <0x00084000 0x1bc>;
> >                       #address-cells = <1>;
> >                       #size-cells = <1>;
> >                       ranges;
> > @@ -248,10 +248,11 @@ pcie_qmp0: phy@86000 {
> >                                     "common";
> >                       status = "disabled";
> >
> > -                     pcie_phy0: phy@86200 {
> > -                             reg = <0x86200 0x16c>,
> > -                                   <0x86400 0x200>,
> > -                                   <0x86800 0x4f4>;
> > +                     pcie_phy0: phy@84200 {
> > +                             reg = <0x84200 0x16c>,
> > +                                   <0x84400 0x200>,
> > +                                   <0x84800 0x1f0>,
> > +                                   <0x84c00 0xf4>;
> >                               #phy-cells = <0>;
> >                               #clock-cells = <0>;
> >                               clocks = <&gcc GCC_PCIE0_PIPE_CLK>;
> > --
> > 2.38.1
> >
