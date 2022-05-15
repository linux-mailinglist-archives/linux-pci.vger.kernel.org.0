Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F621527967
	for <lists+linux-pci@lfdr.de>; Sun, 15 May 2022 21:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238529AbiEOTRb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 May 2022 15:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238406AbiEOTRZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 May 2022 15:17:25 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610C7120B8;
        Sun, 15 May 2022 12:17:22 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nqJjs-0005vt-RK; Sun, 15 May 2022 21:17:12 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     Peter Geis <pgwipeout@gmail.com>, Marc Zyngier <maz@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 4/5] arm64: dts: rockchip: Add rk3568 PCIe2x1 controller
Date:   Sun, 15 May 2022 21:17:11 +0200
Message-ID: <5575428.DvuYhMxLoT@diego>
In-Reply-To: <20220429123832.2376381-5-pgwipeout@gmail.com>
References: <20220429123832.2376381-1-pgwipeout@gmail.com> <20220429123832.2376381-5-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Freitag, 29. April 2022, 14:38:30 CEST schrieb Peter Geis:
> The PCIe2x1 controller is common between the rk3568 and rk3566. It is a
> single lane PCIe2 compliant controller.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 52 ++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> index 7cdef800cb3c..aea5d9255235 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> @@ -689,6 +689,58 @@ qos_vop_m1: qos@fe1a8100 {
>  		reg = <0x0 0xfe1a8100 0x0 0x20>;
>  	};
>  
> +	pcie2x1: pcie@fe260000 {
> +		compatible = "rockchip,rk3568-pcie";
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		bus-range = <0x0 0xf>;
> +		clocks = <&cru ACLK_PCIE20_MST>, <&cru ACLK_PCIE20_SLV>,
> +			 <&cru ACLK_PCIE20_DBI>, <&cru PCLK_PCIE20>,
> +			 <&cru CLK_PCIE20_AUX_NDFT>;
> +		clock-names = "aclk_mst", "aclk_slv",
> +			      "aclk_dbi", "pclk", "aux";
> +		device_type = "pci";
> +		interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "sys", "pmc", "msi", "legacy", "err";
> +		#interrupt-cells = <1>;

I guess #interrupt-cells shouldn't be necessary here, as that property
is meant for interrupt-controller nodes - like the subnode here
which already has its own #interrupt-cells, right?

> +		interrupt-map-mask = <0 0 0 7>;
> +		interrupt-map = <0 0 0 1 &pcie_intc 0>,
> +				<0 0 0 2 &pcie_intc 1>,
> +				<0 0 0 3 &pcie_intc 2>,
> +				<0 0 0 4 &pcie_intc 3>;
> +		linux,pci-domain = <0>;
> +		num-ib-windows = <6>;
> +		num-ob-windows = <2>;
> +		max-link-speed = <2>;
> +		msi-map = <0x0 &gic 0x0 0x1000>;
> +		num-lanes = <1>;
> +		phys = <&combphy2 PHY_TYPE_PCIE>;
> +		phy-names = "pcie-phy";
> +		power-domains = <&power RK3568_PD_PIPE>;
> +		reg = <0x3 0xc0000000 0x0 0x00400000>,
> +		      <0x0 0xfe260000 0x0 0x00010000>,
> +		      <0x3 0x00000000 0x0 0x01000000>;
> +		ranges = <0x01000000 0x0 0x01000000 0x3 0x01000000 0x0 0x00100000
> +			  0x02000000 0x0 0x02000000 0x3 0x01100000 0x0 0x3ef00000>;
> +		reg-names = "dbi", "apb", "config";
> +		resets = <&cru SRST_PCIE20_POWERUP>;
> +		reset-names = "pipe";
> +		status = "disabled";
> +
> +		pcie_intc: legacy-interrupt-controller {
> +			#address-cells = <0>;
> +			#interrupt-cells = <1>;
> +			interrupt-controller;
> +			interrupt-parent = <&gic>;
> +			interrupts = <GIC_SPI 72 IRQ_TYPE_EDGE_RISING>;
> +		};
> +
> +	};
> +
>  	sdmmc0: mmc@fe2b0000 {
>  		compatible = "rockchip,rk3568-dw-mshc", "rockchip,rk3288-dw-mshc";
>  		reg = <0x0 0xfe2b0000 0x0 0x4000>;
> 




