Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB3E52B707
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 12:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbiERKD1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 May 2022 06:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbiERKDX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 06:03:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C52BB9;
        Wed, 18 May 2022 03:03:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 140AE617E5;
        Wed, 18 May 2022 10:03:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63076C385AA;
        Wed, 18 May 2022 10:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652868201;
        bh=CtHMvnbHliMiyUEZOXIax7E1bJRVQqkba8XZH4l4ixU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F7ZwXRd/VFTTvSuKsdkXBZdfYLh4H4WXZllZOPgmYQ4rK1xICXf1Qd0wlU0KFrmz5
         yhjrW0EjFkDuf31Xw+dmFG53VLvoexN9Dh1fOl76uVjAgVDawTmjTv6XbDm9Z+4cbw
         siOMMFpZNc9TlBBfg/i7Ea7iXUlSCjbHNwjRvHuL8noa9otkjAr3xq7E4j2SkjV35s
         +lBXuAReLqGtfYnpAttGksvB+nrwR32qESsZBR1VWZHAd4Vm+vGLe68l5mG7aXqzD+
         bBBv4g0nh+Gk5Zh4liaCEFzeuRCSa9im0d7utRcWslMsVZ3fz4HDSSkz8fYuv2JBQ/
         aTkyptk32BQaA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nrGWY-0004uS-By; Wed, 18 May 2022 12:03:22 +0200
Date:   Wed, 18 May 2022 12:03:22 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v10 10/10] arm64: dts: qcom: sm8250: provide additional
 MSI interrupts
Message-ID: <YoTEah//jc8GYItc@hovoldconsulting.com>
References: <20220513172622.2968887-1-dmitry.baryshkov@linaro.org>
 <20220513172622.2968887-11-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513172622.2968887-11-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 13, 2022 at 08:26:22PM +0300, Dmitry Baryshkov wrote:
> On SM8250 each group of MSI interrupts is mapped to the separate host
> interrupt. Describe each of interrupts in the device tree for PCIe0
> host.
> 
> Tested on Qualcomm RB5 platform with first group of MSI interrupts being
> used by the PME and attached ath11k WiFi chip using second group of MSI
> interrupts.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index 410272a1e19b..523a035ffc5f 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -1807,8 +1807,16 @@ pcie0: pci@1c00000 {
>  			ranges = <0x01000000 0x0 0x60200000 0 0x60200000 0x0 0x100000>,
>  				 <0x02000000 0x0 0x60300000 0 0x60300000 0x0 0x3d00000>;
>  
> -			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names = "msi";
> +			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi0", "msi1", "msi2", "msi3",
> +					  "msi4", "msi5", "msi6", "msi7";
>  			#interrupt-cells = <1>;
>  			interrupt-map-mask = <0 0 0 0x7>;
>  			interrupt-map = <0 0 0 1 &intc 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */

Looks correct now:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
