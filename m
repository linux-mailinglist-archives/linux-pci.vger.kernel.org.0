Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC85636CF6
	for <lists+linux-pci@lfdr.de>; Wed, 23 Nov 2022 23:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiKWWOk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 17:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiKWWOZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 17:14:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB4C10AD38;
        Wed, 23 Nov 2022 14:14:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1169F61D85;
        Wed, 23 Nov 2022 22:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E210C433C1;
        Wed, 23 Nov 2022 22:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669241657;
        bh=IlfNd3xG0lGjgm7fwh3ZoO9MxNH11zL8e7meF/BJR3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LELmx55Q/1YwJS2GAtTntuVrIasCR4SSyMBZTwyE3I2LhZeVPg3O4J+1m4/iGwNmA
         Rdsu1YItOzKFOa0qPQIPMZ8qGR8KsuevwlOt2s2MhrJFt2cNh4gNv0RgZo8l4DXcjD
         9ppKwckhHnNb2Mj653o1U9Q7KU5c/wUfZQAHClnBZ6DdhVD+PEJdgIRolUK+MK8yor
         RSAEqap47c5SWrYtDajGNuPxr5YEROKY5fFrr26dYK+YzFvxUtMcQ3z4CLMvzhczL2
         gJ75oU+GDzB+W6ESh0rtEy4412FnSf3kFZAvNxdsTlEUhdyLNXingTeDN2lenhnVq8
         MvHqrlegCTdIA==
Date:   Wed, 23 Nov 2022 22:14:12 +0000
From:   Conor Dooley <conor@kernel.org>
To:     daire.mcnamara@microchip.com, robh@kernel.org
Cc:     conor.dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, lpieralisi@kernel.org,
        kw@linux.com, bhelgaas@google.com, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 9/9] riscv: dts: microchip: add parent ranges and
 dma-ranges for IKRD v2022.09
Message-ID: <Y36bNE/pG14F9KyY@spud>
References: <20221116135504.258687-1-daire.mcnamara@microchip.com>
 <20221116135504.258687-10-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116135504.258687-10-daire.mcnamara@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hey Rob,

On Wed, Nov 16, 2022 at 01:55:04PM +0000, daire.mcnamara@microchip.com wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> we have replaced the "microchip,matro0" hack property with what was
> suggested by Rob - create a parent bus and use ranges and dma-ranges in
> the parent bus and pcie device to achieve the address translations we
> need. Add the appropriate ranges and dma-ranges for the v2022.09 IKRD
> so that it remains functional.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>

This patch was included as demonstration of what the series results in
DT wise. It's the custom address translation property that you had
NACKED in [0] but done (we think) in the way that you suggested with an
extra, middle-man bus. Could you take a look & see if it fits with what
you requested?

Thanks,
Conor.

0 - https://lore.kernel.org/linux-riscv/20220902142202.2437658-1-daire.mcnamara@microchip.com/

> ---
>  .../dts/microchip/mpfs-icicle-kit-fabric.dtsi | 62 +++++++++++--------
>  1 file changed, 35 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
> index 1069134f2e12..51ce87e70b33 100644
> --- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
> +++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
> @@ -26,33 +26,41 @@ i2c2: i2c@40000200 {
>  		status = "disabled";
>  	};
>  
> -	pcie: pcie@3000000000 {
> -		compatible = "microchip,pcie-host-1.0";
> -		#address-cells = <0x3>;
> -		#interrupt-cells = <0x1>;
> -		#size-cells = <0x2>;
> -		device_type = "pci";
> -		reg = <0x30 0x0 0x0 0x8000000>, <0x0 0x43000000 0x0 0x10000>;
> -		reg-names = "cfg", "apb";
> -		bus-range = <0x0 0x7f>;
> -		interrupt-parent = <&plic>;
> -		interrupts = <119>;
> -		interrupt-map = <0 0 0 1 &pcie_intc 0>,
> -				<0 0 0 2 &pcie_intc 1>,
> -				<0 0 0 3 &pcie_intc 2>,
> -				<0 0 0 4 &pcie_intc 3>;
> -		interrupt-map-mask = <0 0 0 7>;
> -		clocks = <&ccc_nw CLK_CCC_PLL0_OUT1>, <&ccc_nw CLK_CCC_PLL0_OUT3>;
> -		clock-names = "fic1", "fic3";
> -		ranges = <0x3000000 0x0 0x8000000 0x30 0x8000000 0x0 0x80000000>;
> -		dma-ranges = <0x02000000 0x0 0x00000000 0x0 0x00000000 0x1 0x00000000>;
> -		msi-parent = <&pcie>;
> -		msi-controller;
> -		status = "disabled";
> -		pcie_intc: interrupt-controller {
> -			#address-cells = <0>;
> -			#interrupt-cells = <1>;
> -			interrupt-controller;
> +	fabric-pcie-bus {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges = <0x0 0x40000000 0x0 0x40000000 0x0 0x20000000>,
> +			 <0x30 0x0 0x30 0x0 0x10 0x0>;
> +		dma-ranges = <0x0 0x0 0x10 0x0 0x0 0x80000000>;
> +		pcie: pcie@3000000000 {
> +			compatible = "microchip,pcie-host-1.0";
> +			#address-cells = <0x3>;
> +			#interrupt-cells = <0x1>;
> +			#size-cells = <0x2>;
> +			device_type = "pci";
> +			reg = <0x30 0x0 0x0 0x8000000>, <0x0 0x43000000 0x0 0x10000>;
> +			reg-names = "cfg", "apb";
> +			bus-range = <0x0 0x7f>;
> +			interrupt-parent = <&plic>;
> +			interrupts = <119>;
> +			interrupt-map = <0 0 0 1 &pcie_intc 0>,
> +					<0 0 0 2 &pcie_intc 1>,
> +					<0 0 0 3 &pcie_intc 2>,
> +					<0 0 0 4 &pcie_intc 3>;
> +			interrupt-map-mask = <0 0 0 7>;
> +			clocks = <&ccc_nw CLK_CCC_PLL0_OUT1>, <&ccc_nw CLK_CCC_PLL0_OUT3>;
> +			clock-names = "fic1", "fic3";
> +			ranges = <0x3000000 0x0 0x8000000 0x30 0x8000000 0x0 0x80000000>;
> +			dma-ranges = <0x3000000 0x10 0x0 0x0 0x0 0x0 0x80000000>;
> +			msi-parent = <&pcie>;
> +			msi-controller;
> +			status = "disabled";
> +			pcie_intc: interrupt-controller {
> +				#address-cells = <0>;
> +				#interrupt-cells = <1>;
> +				interrupt-controller;
> +			};
>  		};
>  	};
>  
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
