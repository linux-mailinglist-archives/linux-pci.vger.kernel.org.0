Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C892B3B97
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2019 15:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387592AbfIPNmp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Sep 2019 09:42:45 -0400
Received: from foss.arm.com ([217.140.110.172]:45002 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733054AbfIPNmp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Sep 2019 09:42:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B21AD337;
        Mon, 16 Sep 2019 06:42:44 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 288663F67D;
        Mon, 16 Sep 2019 06:42:43 -0700 (PDT)
Date:   Mon, 16 Sep 2019 14:42:42 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, lorenzo.pieralisi@arm.com, kishon@ti.com,
        bhelgaas@google.com, linux-amlogic@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, yue.wang@Amlogic.com, maz@kernel.org,
        repk@triplefau.lt, nick@khadas.com, gouwa@khadas.com
Subject: Re: [PATCH v2 5/6] arm64: dts: meson-g12a: Add PCIe node
Message-ID: <20190916134241.GR9720@e119886-lin.cambridge.arm.com>
References: <20190916125022.10754-1-narmstrong@baylibre.com>
 <20190916125022.10754-6-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916125022.10754-6-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 16, 2019 at 02:50:21PM +0200, Neil Armstrong wrote:
> This adds the Amlogic G12A PCI Express controller node, also
> using the USB3+PCIe Combo PHY.
> 
> The PHY mode selection is static, thus the USB3+PCIe Combo PHY
> phandle would need to be removed from the USB control node if the
> shared differential lines are used for PCIe instead of USB3.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

> ---
>  .../boot/dts/amlogic/meson-g12-common.dtsi    | 33 +++++++++++++++++++
>  arch/arm64/boot/dts/amlogic/meson-sm1.dtsi    |  4 +++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> index 852cf9cf121b..7330dc37b7a6 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> @@ -95,6 +95,39 @@
>  		#size-cells = <2>;
>  		ranges;
>  
> +		pcie: pcie@fc000000 {
> +			compatible = "amlogic,g12a-pcie", "snps,dw-pcie";
> +			reg = <0x0 0xfc000000 0x0 0x400000
> +			       0x0 0xff648000 0x0 0x2000
> +			       0x0 0xfc400000 0x0 0x200000>;
> +			reg-names = "elbi", "cfg", "config";
> +			interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0>;
> +			interrupt-map = <0 0 0 0 &gic GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
> +			bus-range = <0x0 0xff>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			device_type = "pci";
> +			ranges = <0x81000000 0 0 0x0 0xfc600000 0 0x00100000
> +				  0x82000000 0 0xfc700000 0x0 0xfc700000 0 0x1900000>;
> +
> +			clocks = <&clkc CLKID_PCIE_PHY
> +				  &clkc CLKID_PCIE_COMB
> +				  &clkc CLKID_PCIE_PLL>;
> +			clock-names = "general",
> +				      "pclk",
> +				      "port";
> +			resets = <&reset RESET_PCIE_CTRL_A>,
> +				 <&reset RESET_PCIE_APB>;
> +			reset-names = "port",
> +				      "apb";
> +			num-lanes = <1>;
> +			phys = <&usb3_pcie_phy PHY_TYPE_PCIE>;
> +			phy-names = "pcie";
> +			status = "disabled";
> +		};
> +
>  		ethmac: ethernet@ff3f0000 {
>  			compatible = "amlogic,meson-axg-dwmac",
>  				     "snps,dwmac-3.70a",
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> index 91492819d0d8..ee9ea3c69433 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> @@ -135,6 +135,10 @@
>  	power-domains = <&pwrc PWRC_SM1_ETH_ID>;
>  };
>  
> +&pcie {
> +	power-domains = <&pwrc PWRC_SM1_PCIE_ID>;
> +};
> +
>  &pwrc {
>  	compatible = "amlogic,meson-sm1-pwrc";
>  };
> -- 
> 2.22.0
> 
