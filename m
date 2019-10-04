Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD198CB84E
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2019 12:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbfJDKcb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Oct 2019 06:32:31 -0400
Received: from foss.arm.com ([217.140.110.172]:41162 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbfJDKcb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Oct 2019 06:32:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5310515A1;
        Fri,  4 Oct 2019 03:32:30 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A88D93F706;
        Fri,  4 Oct 2019 03:32:29 -0700 (PDT)
Date:   Fri, 4 Oct 2019 11:32:28 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>, xu_shunji@hoperun.com
Subject: Re: [PATCH 6/7] arm64: dts: renesas: r8a774b1: Add PCIe device nodes
Message-ID: <20191004103227.GR42880@e119886-lin.cambridge.arm.com>
References: <1570178133-21532-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1570178133-21532-7-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570178133-21532-7-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 04, 2019 at 09:35:32AM +0100, Fabrizio Castro wrote:
> This patch adds PCIe{0,1} device nodes for R8A774B1 SoC.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> ---

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

>  arch/arm64/boot/dts/renesas/r8a774b1.dtsi | 42 +++++++++++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a774b1.dtsi b/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
> index 3bd0b47..0163b284 100644
> --- a/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
> @@ -1304,19 +1304,57 @@
>  		};
>  
>  		pciec0: pcie@fe000000 {
> +			compatible = "renesas,pcie-r8a774b1",
> +				     "renesas,pcie-rcar-gen3";
>  			reg = <0 0xfe000000 0 0x80000>;
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			bus-range = <0x00 0xff>;
> -			/* placeholder */
> +			device_type = "pci";
> +			ranges = <0x01000000 0 0x00000000 0 0xfe100000 0 0x00100000
> +				  0x02000000 0 0xfe200000 0 0xfe200000 0 0x00200000
> +				  0x02000000 0 0x30000000 0 0x30000000 0 0x08000000
> +				  0x42000000 0 0x38000000 0 0x38000000 0 0x08000000>;
> +			/* Map all possible DDR as inbound ranges */
> +			dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x80000000>;
> +			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0>;
> +			interrupt-map = <0 0 0 0 &gic GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 319>, <&pcie_bus_clk>;
> +			clock-names = "pcie", "pcie_bus";
> +			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
> +			resets = <&cpg 319>;
> +			status = "disabled";
>  		};
>  
>  		pciec1: pcie@ee800000 {
> +			compatible = "renesas,pcie-r8a774b1",
> +				     "renesas,pcie-rcar-gen3";
>  			reg = <0 0xee800000 0 0x80000>;
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			bus-range = <0x00 0xff>;
> -			/* placeholder */
> +			device_type = "pci";
> +			ranges = <0x01000000 0 0x00000000 0 0xee900000 0 0x00100000
> +				  0x02000000 0 0xeea00000 0 0xeea00000 0 0x00200000
> +				  0x02000000 0 0xc0000000 0 0xc0000000 0 0x08000000
> +				  0x42000000 0 0xc8000000 0 0xc8000000 0 0x08000000>;
> +			/* Map all possible DDR as inbound ranges */
> +			dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x80000000>;
> +			interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0>;
> +			interrupt-map = <0 0 0 0 &gic GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 318>, <&pcie_bus_clk>;
> +			clock-names = "pcie", "pcie_bus";
> +			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
> +			resets = <&cpg 318>;
> +			status = "disabled";
>  		};
>  
>  		fdp1@fe940000 {
> -- 
> 2.7.4
> 
