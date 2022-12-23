Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA9265534F
	for <lists+linux-pci@lfdr.de>; Fri, 23 Dec 2022 18:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiLWRqJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Dec 2022 12:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbiLWRqH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Dec 2022 12:46:07 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5331B788
        for <linux-pci@vger.kernel.org>; Fri, 23 Dec 2022 09:46:01 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id k88-20020a17090a4ce100b00219d0b857bcso5581820pjh.1
        for <linux-pci@vger.kernel.org>; Fri, 23 Dec 2022 09:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MXMOluK6Xnpbtic2Z+7oS3BCbi78lKFqA+xBJbdLvwU=;
        b=dcCX/N/WwXTbOXRyZjkDFdH7Q07Jq4e9NJezWBAlSmO74HOaxdmb7CVvysm1Dgfrrb
         z6Am/3vhyTteyyWbNMFfseEJcEa5qDAj6UZd7e4xEDAB++Mg/OilrJYFs0AkAoxM1TLK
         CHXvhM110CT8QUvNgvtExgqliPI/VPtewcZMfDP0gpDaYDqHCc2iQy3wkCPr73ZoNydw
         NOYmsbgwgeqR3/55w/zlV42qI0F/Hr4f4MKxKJlvv5ZjbOHSat5Px2qcB9m7uhVD3FWP
         95n+YvR2wZTxwc+F35zJvbBnrqoOWiuaTcDFmlkK4CzrmJnBS/tFg3Mo3+gZ3oMefutn
         sqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MXMOluK6Xnpbtic2Z+7oS3BCbi78lKFqA+xBJbdLvwU=;
        b=ugGym/9cj7AkPC2u5qSolw0VmfCGeJ/i5PX19UB/hPb6FvOr4rAu1Ik7Xsj+DFSxY7
         45Je5baodTdFZZiprKXV51VfB9NMOo/SsUNA8E6hnXWEiEABGHie9iTB0RuxEnd4Wvya
         9E9Ml7Fgn5WU5f8zTmRX0Hdw/WHmAc/OK6+2OI3v1UC0OOS+xtNCdS7kysgTBA7m7Ox/
         9W5vSFM7WQtC8wabVqHjAUyw1CGMZCYJYBiQaYzAJzoIcVnXgilyZ7sAMHby2/SXt+N7
         i2cUF9PPeHjiV4yb8idBti1tVGEEV1jnk78UtoMFDnCH/LWWJudAxnxSx3HmkcrD2FFG
         tz5Q==
X-Gm-Message-State: AFqh2kpijDLpPq48slRZBc/CuO+TCXwdhtY//7g2jH8A7jJgp5ZyqS+N
        DOF9UYTQKI7b4XVDyhkVzZmp
X-Google-Smtp-Source: AMrXdXv3aAsRFCAOyEYWTytV/+fwTIfoq6O48K4E1KnmNXrWmTZk+SDLVmiTiN5t5d5Vi2PAao2Rtg==
X-Received: by 2002:a17:90b:3597:b0:214:222:6ed3 with SMTP id mm23-20020a17090b359700b0021402226ed3mr11727411pjb.43.1671817561019;
        Fri, 23 Dec 2022 09:46:01 -0800 (PST)
Received: from thinkpad ([27.111.75.82])
        by smtp.gmail.com with ESMTPSA id ne2-20020a17090b374200b001ef8ab65052sm2476399pjb.11.2022.12.23.09.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 09:46:00 -0800 (PST)
Date:   Fri, 23 Dec 2022 23:15:55 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bhelgaas@google.com,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sm8450: Use GIC-ITS for PCIe0
 and PCIe1
Message-ID: <20221223174555.GE4587@thinkpad>
References: <20221222133123.50676-1-manivannan.sadhasivam@linaro.org>
 <20221222133123.50676-4-manivannan.sadhasivam@linaro.org>
 <e756516a-a5e2-a6ac-fd7f-71726766fa81@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e756516a-a5e2-a6ac-fd7f-71726766fa81@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 23, 2022 at 07:18:32PM +0200, Dmitry Baryshkov wrote:
> On 22/12/2022 15:31, Manivannan Sadhasivam wrote:
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
> > It should be noted that the MSIs for BDF (1:0.0) only works with Device
> > ID of 0x5980 and 0x5a00. Hence, the IDs are swapped.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >   arch/arm64/boot/dts/qcom/sm8450.dtsi | 20 ++++++++++++++------
> >   1 file changed, 14 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > index 570475040d95..c4dd5838fac6 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > @@ -1733,9 +1733,13 @@ pcie0: pci@1c00000 {
> >   			ranges = <0x01000000 0x0 0x60200000 0 0x60200000 0x0 0x100000>,
> >   				 <0x02000000 0x0 0x60300000 0 0x60300000 0x0 0x3d00000>;
> > -			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
> > -			interrupt-names = "msi";
> > -			#interrupt-cells = <1>;
> > +			/*
> > +			 * MSIs for BDF (1:0.0) only works with Device ID 0x5980.
> > +			 * Hence, the IDs are swapped.
> > +			 */
> > +			msi-map = <0x0 &gic_its 0x5981 0x1>,
> > +				  <0x100 &gic_its 0x5980 0x1>;
> 
> This definitely doesn't match what has been used in the downstream.
> 

Yes, I do not know why the downstream Device ID doesn't work. I tried finding
the answer within Qcom but didn't get any answer so far :/ So I just went with
the value that works on multiple boards.

> Also if I understand correctly this change would prevent us from using
> multiple MSI interrupts for the connected device, as the last value of the
> 0x100 mapping is 0x1, while the vendor kernel uses <0x100 &its 0x5981 0x20>.
> 

Not true. The controller can still support multiple MSIs for the endpoint
devices but the only difference is, it would use the same Device ID for all.

The Qcom GIC-ITS implementation could only support 32 Device IDs. By specifying
the size of 0x20, a separate Device ID would be used for each devices of bus 1.
But if a PCIe switch is connected and the bus count becomes > 1, then the MSI
allocation would fail because Device IDs are exhausted.

The downstream implementation just assumes that there will be only bus 1 and I
do not want to follow that assumption.

That's why I used "msi-map-mask" property of value "0xff00" here, as that will
allow all the devices under the bus 1 to share the same Device ID. For now I
only mapped bus 1, but extending that in the future for other busses is simple.

Thanks,
Mani

> Do you know by chance, why do we differ from the vendor dtsi?
> 
> > +			msi-map-mask = <0xff00>;
> >   			interrupt-map-mask = <0 0 0 0x7>;
> >   			interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> >   					<0 0 0 2 &intc 0 0 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> > @@ -1842,9 +1846,13 @@ pcie1: pci@1c08000 {
> >   			ranges = <0x01000000 0x0 0x40200000 0 0x40200000 0x0 0x100000>,
> >   				 <0x02000000 0x0 0x40300000 0 0x40300000 0x0 0x1fd00000>;
> > -			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
> > -			interrupt-names = "msi";
> > -			#interrupt-cells = <1>;
> > +			/*
> > +			 * MSIs for BDF (1:0.0) only works with Device ID 0x5a00.
> > +			 * Hence, the IDs are swapped.
> > +			 */
> > +			msi-map = <0x0 &gic_its 0x5a01 0x1>,
> > +				  <0x100 &gic_its 0x5a00 0x1>;
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
