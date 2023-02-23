Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095C96A0952
	for <lists+linux-pci@lfdr.de>; Thu, 23 Feb 2023 14:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbjBWNEt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Feb 2023 08:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234236AbjBWNEs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Feb 2023 08:04:48 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1AA49880
        for <linux-pci@vger.kernel.org>; Thu, 23 Feb 2023 05:04:46 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id h17-20020a17090aea9100b0023739b10792so6937962pjz.1
        for <linux-pci@vger.kernel.org>; Thu, 23 Feb 2023 05:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDkAyTl4e5Pg7c9IntJyDDk2YT+I/mT8i4BOda6y2xY=;
        b=nBsez7fHRRIiINSdFLPvlrg8TZchD4wKhnS1nlLN1Hk9OXSJ19hvMaV/2ZF/XX0WDk
         kdCw9easfSZyFfb0Qu51theWgnSRm54ROwWtJySpxSlhhJhx0xfU2u1zT54zrOWdmc9Y
         a9AUkEp2t4ZRy2QeSiEOTNCmQDJwGqBLgSFTL9YfTZYp57i8r1l/W+1EA01VDVkLeHJw
         3zHh3UaTFkbrlT+chwl/6mOIumbi/97rhE4pntxkc/T1cZ9lXW4MeCQQkvacJwzbB7Pf
         pZkCyU2uT3Y5Ed9s5swPMNScYpw8LY4G9MORJ/huzHTesbnSRvVs2IRnGyq/11VFR4cv
         UQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JDkAyTl4e5Pg7c9IntJyDDk2YT+I/mT8i4BOda6y2xY=;
        b=RkTRla3iZFLLuwdNKIOlWrEz94lrFZ1UXrNMlS25FfpvBbqMr62OWrnS5ei2OV7oui
         KMw6oje6EebD0WGWb/sNoFID70nf7If93AISGMGjY87AgWXb6c/tSeiCBzd/j9mzl37S
         qyer6G/Rh3sW5A79o3SqfucXUq0VxyVUTevpICYwso/TwMMd55UggC0GL20IX7p5aqYp
         m75KsuGY6MpEeMSqOUlOprZYFXFwfOP1p5iyjSPgtWJ29K+Nv0lVm97CUx2ROm/NRXaP
         n4+SUomPeXmTB6kHoIlFAJ/UrTJ1wZaXE1rCIPzNMynS9R9yaeXOnDanLGw+IR8h/ROz
         xl8A==
X-Gm-Message-State: AO0yUKVoxEHjWI/EUcrwWDG+AZNYgUmem5stF1EMBVVy33TSiPoZvE76
        Kwk0PXxsGR2E7yiiAO2c8gfo
X-Google-Smtp-Source: AK7set9yzaubAFiFFmxHybxYsis4ROkd2GJ3XyKkK0PglYAtJDCPH1KeLOw8n7C3jddbCjDO/uWWjw==
X-Received: by 2002:a17:902:dac7:b0:19a:aa9c:c66f with SMTP id q7-20020a170902dac700b0019aaa9cc66fmr14188841plx.21.1677157486080;
        Thu, 23 Feb 2023 05:04:46 -0800 (PST)
Received: from workstation ([59.97.53.124])
        by smtp.gmail.com with ESMTPSA id e1-20020a170902b78100b001967580f60fsm8675022pls.260.2023.02.23.05.04.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Feb 2023 05:04:45 -0800 (PST)
Date:   Thu, 23 Feb 2023 18:34:40 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     andersson@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 05/11] ARM: dts: qcom: sdx55: Fix the unit address of
 PCIe EP node
Message-ID: <20230223130440.GB6422@workstation>
References: <20230222153251.254492-1-manivannan.sadhasivam@linaro.org>
 <20230222153251.254492-6-manivannan.sadhasivam@linaro.org>
 <4e61522d-075d-c77d-b1f6-c9f4c25e1cf2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e61522d-075d-c77d-b1f6-c9f4c25e1cf2@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 22, 2023 at 05:02:08PM +0100, Konrad Dybcio wrote:
> 
> 
> On 22.02.2023 16:32, Manivannan Sadhasivam wrote:
> > Unit address of PCIe EP node should be 0x1c00000 as it has to match the
> > first address specified in the reg property.
> > 
> > This also requires sorting the node in the ascending order.
> > 
> > Fixes: 31c9ef002580 ("dt-bindings: PCI: Add Qualcomm PCIe Endpoint controller")
> Unsure, we aren't fixing the bindings..
> 

Err... will fix the tag in next version.

Thanks,
Mani

> 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> For the dt change:
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Konrad
> >  arch/arm/boot/dts/qcom-sdx55.dtsi | 78 +++++++++++++++----------------
> >  1 file changed, 39 insertions(+), 39 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
> > index 93d71aff3fab..e84ca795cae6 100644
> > --- a/arch/arm/boot/dts/qcom-sdx55.dtsi
> > +++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
> > @@ -303,6 +303,45 @@ qpic_nand: nand-controller@1b30000 {
> >  			status = "disabled";
> >  		};
> >  
> > +		pcie_ep: pcie-ep@1c00000 {
> > +			compatible = "qcom,sdx55-pcie-ep";
> > +			reg = <0x01c00000 0x3000>,
> > +			      <0x40000000 0xf1d>,
> > +			      <0x40000f20 0xc8>,
> > +			      <0x40001000 0x1000>,
> > +			      <0x40200000 0x100000>,
> > +			      <0x01c03000 0x3000>;
> > +			reg-names = "parf", "dbi", "elbi", "atu", "addr_space",
> > +				    "mmio";
> > +
> > +			qcom,perst-regs = <&tcsr 0xb258 0xb270>;
> > +
> > +			clocks = <&gcc GCC_PCIE_AUX_CLK>,
> > +				 <&gcc GCC_PCIE_CFG_AHB_CLK>,
> > +				 <&gcc GCC_PCIE_MSTR_AXI_CLK>,
> > +				 <&gcc GCC_PCIE_SLV_AXI_CLK>,
> > +				 <&gcc GCC_PCIE_SLV_Q2A_AXI_CLK>,
> > +				 <&gcc GCC_PCIE_SLEEP_CLK>,
> > +				 <&gcc GCC_PCIE_0_CLKREF_CLK>;
> > +			clock-names = "aux", "cfg", "bus_master", "bus_slave",
> > +				      "slave_q2a", "sleep", "ref";
> > +
> > +			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-names = "global", "doorbell";
> > +			reset-gpios = <&tlmm 57 GPIO_ACTIVE_LOW>;
> > +			wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
> > +			resets = <&gcc GCC_PCIE_BCR>;
> > +			reset-names = "core";
> > +			power-domains = <&gcc PCIE_GDSC>;
> > +			phys = <&pcie0_lane>;
> > +			phy-names = "pciephy";
> > +			max-link-speed = <3>;
> > +			num-lanes = <2>;
> > +
> > +			status = "disabled";
> > +		};
> > +
> >  		pcie0_phy: phy@1c07000 {
> >  			compatible = "qcom,sdx55-qmp-pcie-phy";
> >  			reg = <0x01c07000 0x1c4>;
> > @@ -400,45 +439,6 @@ sdhc_1: mmc@8804000 {
> >  			status = "disabled";
> >  		};
> >  
> > -		pcie_ep: pcie-ep@40000000 {
> > -			compatible = "qcom,sdx55-pcie-ep";
> > -			reg = <0x01c00000 0x3000>,
> > -			      <0x40000000 0xf1d>,
> > -			      <0x40000f20 0xc8>,
> > -			      <0x40001000 0x1000>,
> > -			      <0x40200000 0x100000>,
> > -			      <0x01c03000 0x3000>;
> > -			reg-names = "parf", "dbi", "elbi", "atu", "addr_space",
> > -				    "mmio";
> > -
> > -			qcom,perst-regs = <&tcsr 0xb258 0xb270>;
> > -
> > -			clocks = <&gcc GCC_PCIE_AUX_CLK>,
> > -				 <&gcc GCC_PCIE_CFG_AHB_CLK>,
> > -				 <&gcc GCC_PCIE_MSTR_AXI_CLK>,
> > -				 <&gcc GCC_PCIE_SLV_AXI_CLK>,
> > -				 <&gcc GCC_PCIE_SLV_Q2A_AXI_CLK>,
> > -				 <&gcc GCC_PCIE_SLEEP_CLK>,
> > -				 <&gcc GCC_PCIE_0_CLKREF_CLK>;
> > -			clock-names = "aux", "cfg", "bus_master", "bus_slave",
> > -				      "slave_q2a", "sleep", "ref";
> > -
> > -			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
> > -				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
> > -			interrupt-names = "global", "doorbell";
> > -			reset-gpios = <&tlmm 57 GPIO_ACTIVE_LOW>;
> > -			wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
> > -			resets = <&gcc GCC_PCIE_BCR>;
> > -			reset-names = "core";
> > -			power-domains = <&gcc PCIE_GDSC>;
> > -			phys = <&pcie0_lane>;
> > -			phy-names = "pciephy";
> > -			max-link-speed = <3>;
> > -			num-lanes = <2>;
> > -
> > -			status = "disabled";
> > -		};
> > -
> >  		remoteproc_mpss: remoteproc@4080000 {
> >  			compatible = "qcom,sdx55-mpss-pas";
> >  			reg = <0x04080000 0x4040>;
