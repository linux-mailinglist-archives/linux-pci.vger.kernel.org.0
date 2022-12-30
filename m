Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FBA659A29
	for <lists+linux-pci@lfdr.de>; Fri, 30 Dec 2022 16:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiL3Prn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Dec 2022 10:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiL3Prm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Dec 2022 10:47:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6FA18B31;
        Fri, 30 Dec 2022 07:47:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0417060CEC;
        Fri, 30 Dec 2022 15:47:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3142C433EF;
        Fri, 30 Dec 2022 15:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672415260;
        bh=PF/vePxv+pOtjiKGSBQA3OpYFIRHQT16VqsS90PXTMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k75kf2pMdplhkExbK+WOe+B+QhKoaD1i3m4ESIAXn4n+KqLVEzyyQypNY6Kf0Nurk
         w19SYVslPwA2lxeyTI/t1bJnZP4J7IxS1bwOTTbymB8WVhocFEwGEVIospEq/mkURv
         3bNT8IeiN3mTMto6HWYVdxHrJ/YpDSFhWXrnmRbfP2qTBgHdYms/DuHQxlrLkQlmsR
         Cce8FuYv+kpQxX8V3sGTYCbrTHimjlN32bL+LnOfKTpVtdqzTz54AFH/zkGD6iGn9s
         UxiWmVmJqNcwQdHRijGdXyi0wnu8lCRHv8/kAh7p2F4gxQcsLovX772LquUowuT7lf
         VL652pkj7EqyQ==
Date:   Fri, 30 Dec 2022 16:47:34 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bhelgaas@google.com,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sm8450: Use GIC-ITS for PCIe0
 and PCIe1
Message-ID: <Y68IFveXH5yZVtzr@lpieralisi>
References: <20221222133123.50676-1-manivannan.sadhasivam@linaro.org>
 <20221222133123.50676-4-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222133123.50676-4-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 22, 2022 at 07:01:23PM +0530, Manivannan Sadhasivam wrote:
> Both PCIe0 and PCIe1 controllers are capable of receiving MSIs from
> endpoint devices using GIC-ITS MSI controller. Add support for it.

Nit: the PCI controllers don't receive MSIs using the GIC-ITS MSI
controller, they signal MSIs interrupts using the GIC-ITS controller.

> 
> Currently, BDF (0:0.0) and BDF (1:0.0) are enabled and with the
> msi-map-mask of 0xff00, all the 32 devices under these two busses can
> share the same Device ID.
> 
> The GIC-ITS MSI implementation provides an advantage over internal MSI
> implementation using Locality-specific Peripheral Interrupts (LPI) that
> would allow MSIs to be targeted for each CPU core.
> 
> It should be noted that the MSIs for BDF (1:0.0) only works with Device
> ID of 0x5980 and 0x5a00. Hence, the IDs are swapped.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 570475040d95..c4dd5838fac6 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -1733,9 +1733,13 @@ pcie0: pci@1c00000 {
>  			ranges = <0x01000000 0x0 0x60200000 0 0x60200000 0x0 0x100000>,
>  				 <0x02000000 0x0 0x60300000 0 0x60300000 0x0 0x3d00000>;
>  
> -			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names = "msi";
> -			#interrupt-cells = <1>;
> +			/*
> +			 * MSIs for BDF (1:0.0) only works with Device ID 0x5980.
> +			 * Hence, the IDs are swapped.
> +			 */
> +			msi-map = <0x0 &gic_its 0x5981 0x1>,
> +				  <0x100 &gic_its 0x5980 0x1>;
> +			msi-map-mask = <0xff00>;
>  			interrupt-map-mask = <0 0 0 0x7>;
>  			interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
>  					<0 0 0 2 &intc 0 0 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> @@ -1842,9 +1846,13 @@ pcie1: pci@1c08000 {
>  			ranges = <0x01000000 0x0 0x40200000 0 0x40200000 0x0 0x100000>,
>  				 <0x02000000 0x0 0x40300000 0 0x40300000 0x0 0x1fd00000>;
>  
> -			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names = "msi";
> -			#interrupt-cells = <1>;
> +			/*
> +			 * MSIs for BDF (1:0.0) only works with Device ID 0x5a00.
> +			 * Hence, the IDs are swapped.
> +			 */
> +			msi-map = <0x0 &gic_its 0x5a01 0x1>,
> +				  <0x100 &gic_its 0x5a00 0x1>;
> +			msi-map-mask = <0xff00>;
>  			interrupt-map-mask = <0 0 0 0x7>;
>  			interrupt-map = <0 0 0 1 &intc 0 0 0 434 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
>  					<0 0 0 2 &intc 0 0 0 435 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> -- 
> 2.25.1
> 
