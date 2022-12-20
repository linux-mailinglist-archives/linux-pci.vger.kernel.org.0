Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C80651EE0
	for <lists+linux-pci@lfdr.de>; Tue, 20 Dec 2022 11:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiLTKeN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Dec 2022 05:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbiLTKeL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Dec 2022 05:34:11 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAB31583C
        for <linux-pci@vger.kernel.org>; Tue, 20 Dec 2022 02:34:10 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id k88-20020a17090a4ce100b00219d0b857bcso11708831pjh.1
        for <linux-pci@vger.kernel.org>; Tue, 20 Dec 2022 02:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5HcjsPgT2Huo/8axIHpoMgW6KyD2HQnudHSnjh27AGw=;
        b=i/NxBUj8QPvNHEvcdQ65/NQfhsk2PYAX6KipLmhtxb4obV9TRqYcPYrsi59isg5nSA
         591cjrO13Y+ySJP+WwpUdxxIQmRTqq61oGuln9dW+4OgagHOOnEsrFlkSl4RpaDbdew3
         1S2+Z+GNqYO0dPku13wzUjnjw+wNEIQyzRwWWX7D7K5d7ZbiqmNeTqPsEQWPZHyo7YSu
         MgEwLkfNgDIavpk5UJGrhKI0UycKSd9I3uDH4g5sZ37t5L8QYpC28XD2Be3FcOBgOSeL
         mSh3+DvWhkgdBHD7WxPS3sUolfEAMdbz0Vd4b/97n+ujt1RtovANBabcmpsK726TsroQ
         qhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5HcjsPgT2Huo/8axIHpoMgW6KyD2HQnudHSnjh27AGw=;
        b=etDA80lrYTf1iDL8D857hHwXdFhnmdjTbXVngPvebmuhcam7ehXNOE7U6h+22076NG
         tKyPDH4cJuwi1OjALBxqAO3iA2lFErN2jEXY/PEK4xNS9eJx04If45CMCNcT5NJZFY2H
         AI0VWx2N1W07Gmw9Gjf1jSqjaEt9gwaxSBxGUbcgCsfnJ2LPyvUYvCRDg5yBYRF5C5sb
         s1L5/BX1p9Ie9rVbON9fqSnnnDuRaR9jS7YDU2wHqP0AGYoKkkFxp5bB3Ii02X4XkrTb
         ofPsDiz5XQJa+Mh4eMYquFyUKa5VvwBHSuuzcIfHlX2bAh1K47T0i78DuFMSK7fkaP2I
         jeCQ==
X-Gm-Message-State: AFqh2krKpR2lFIUEL9c9xVDEQWdDeszhan397HI0ButkN2pTjh76C4Jm
        IH/EDISf9iH6hKYq/mlTTYcM
X-Google-Smtp-Source: AMrXdXuwjT5auxfIEPMBUp6EOd7lGMoElCiqh37+vvQd/Lbzlf1Dx8j0QZjDWIwNDJLWHVEmOyMVmA==
X-Received: by 2002:a17:902:a9c9:b0:191:217f:b2ea with SMTP id b9-20020a170902a9c900b00191217fb2eamr6450308plr.40.1671532449512;
        Tue, 20 Dec 2022 02:34:09 -0800 (PST)
Received: from thinkpad ([117.217.181.222])
        by smtp.gmail.com with ESMTPSA id v20-20020a170902ca9400b001708c4ebbaesm8934788pld.309.2022.12.20.02.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 02:34:08 -0800 (PST)
Date:   Tue, 20 Dec 2022 16:04:00 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bhelgaas@google.com,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm8450: Use GIC-ITS for PCIe0 and
 PCIe1
Message-ID: <20221220103400.GB38609@thinkpad>
References: <20221219191427.480085-1-manivannan.sadhasivam@linaro.org>
 <20221219191427.480085-4-manivannan.sadhasivam@linaro.org>
 <6a59addb-b1a0-8536-c909-25c4c4447e09@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a59addb-b1a0-8536-c909-25c4c4447e09@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 19, 2022 at 11:46:03PM +0200, Dmitry Baryshkov wrote:
> On 19/12/2022 21:14, Manivannan Sadhasivam wrote:
> > Both PCIe0 and PCIe1 controllers are capable of receiving MSIs from
> > endpoint devices using GIC-ITS MSI controller. Add support for it.
> > 
> > Currently, BDF (0:0.0) and BDF (1:0.0) are enabled and with the
> > msi-map-mask of 0xff00, all the 32 devices under these two busses can
> > share the same Device ID.
> > 
> > The GIC-ITS MSI implementation provides an advantage over internal MSI
> > implementation using Locality-specific Peripheral Interrupts (LPI) that
> > would allow MSIs to be targeted for each CPU core.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >   arch/arm64/boot/dts/qcom/sm8450.dtsi | 12 ++++++------
> >   1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > index 570475040d95..276ceba4c247 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > @@ -1733,9 +1733,9 @@ pcie0: pci@1c00000 {
> >   			ranges = <0x01000000 0x0 0x60200000 0 0x60200000 0x0 0x100000>,
> >   				 <0x02000000 0x0 0x60300000 0 0x60300000 0x0 0x3d00000>;
> > -			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
> > -			interrupt-names = "msi";
> > -			#interrupt-cells = <1>;
> > +			msi-map = <0x0 &gic_its 0x5980 0x1>,
> > +				  <0x100 &gic_its 0x5981 0x1>;
> 
> Does ITS support handling more than one MSI interrupt per device? Otherwise
> it might be better to switch to multi-MSI scheme using SPI interrupts.
> 

Yes, it does support multiple MSIs from endpoints. I've verified it using the
MHI Endpoint device.

> > +			msi-map-mask = <0xff00>;
> >   			interrupt-map-mask = <0 0 0 0x7>;
> >   			interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> >   					<0 0 0 2 &intc 0 0 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> > @@ -1842,9 +1842,9 @@ pcie1: pci@1c08000 {
> >   			ranges = <0x01000000 0x0 0x40200000 0 0x40200000 0x0 0x100000>,
> >   				 <0x02000000 0x0 0x40300000 0 0x40300000 0x0 0x1fd00000>;
> > -			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
> > -			interrupt-names = "msi";
> > -			#interrupt-cells = <1>;
> > +			msi-map = <0x0 &gic_its 0x5a01 0x1>,
> > +				  <0x100 &gic_its 0x5a00 0x1>;
> 
> Are you sure that the order is correct here?
> 

Ideally, BDF (1:0.0) should be assinged the Device ID of 0x5a01. But based on my
experiments, it doesn't work. But if the Device ID gets swapped, it works.

Maybe I should add a comment here.

Thanks,
Mani

> > +			msi-map-mask = <0xff00>;
> >   			interrupt-map-mask = <0 0 0 0x7>;
> >   			interrupt-map = <0 0 0 1 &intc 0 0 0 434 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> >   					<0 0 0 2 &intc 0 0 0 435 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> 
> -- 
> With best wishes
> Dmitry
> 

-- 
மணிவண்ணன் சதாசிவம்
