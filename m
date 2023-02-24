Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCB06A185A
	for <lists+linux-pci@lfdr.de>; Fri, 24 Feb 2023 09:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjBXI72 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Feb 2023 03:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjBXI71 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Feb 2023 03:59:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C365F10A98;
        Fri, 24 Feb 2023 00:59:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 643A5B81B01;
        Fri, 24 Feb 2023 08:59:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A13C433EF;
        Fri, 24 Feb 2023 08:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677229161;
        bh=BdEOv9GBB4KCQQLXMvFqv+qlZjrO7lS8bLUCH+Njj00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FXy7x4hLS6gaaLrSr8BZQA5XQEo6n9cZ9ZwbJKKpwij9i1q2FelbmfYOY1K+7p+A+
         6MSbMle6I7Dzh8p1Fse5t538FvSu/FE0exqkbKdzc7zPuOW5IUBJ7A7vznHh/W+zpb
         Kt3Dkmq0OOmeu1dPXggyM5Qn5d1wRFF5+Xjcu4Ax2D+44HjG7/pjd+o4IOqqTQLa/7
         Q56wrnhnoxek/Sl067G2lQbYs+YB2BqR96+Evex4oo3gLhK/Xokfy823D4OJc5orUL
         NbKgcicgM1Jii+czOY0CEJYACSjCSa7VJ/XyAFxEdIMZ+2BuxBaAAZ5ZdhO/bJ0TJm
         SO0Ja63MUpuhA==
Date:   Fri, 24 Feb 2023 14:29:02 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, p.zabel@pengutronix.de, svarbanov@mm-sol.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-clk@vger.kernel.org,
        quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com
Subject: Re: [PATCH 7/7] arm64: dts: qcom: ipq9574: Add PCIe PHYs and
 controller nodes
Message-ID: <20230224085902.GC5443@thinkpad>
References: <20230214164135.17039-1-quic_devipriy@quicinc.com>
 <20230214164135.17039-8-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230214164135.17039-8-quic_devipriy@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 14, 2023 at 10:11:35PM +0530, Devi Priya wrote:
> Add PCIe0, PCIe1, PCIe2, PCIe3 (and corresponding PHY) devices
> found on IPQ9574 platform. The PCIe0 & PCIe1 are 1-lane Gen3
> host whereas PCIe2 & PCIe3 are 2-lane Gen3 host.
> 

Please split the board devicetree changes into a separate patch.

> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts |  28 ++
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi        | 477 ++++++++++++++++++-
>  2 files changed, 499 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts b/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
> index 2c8430197ec0..21b53f34ce84 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
> @@ -8,6 +8,7 @@
>  
>  /dts-v1/;
>  
> +#include <dt-bindings/gpio/gpio.h>
>  #include "ipq9574.dtsi"
>  
>  / {
> @@ -29,6 +30,33 @@
>  	status = "okay";
>  };
>  
> +&pcie1_phy {
> +	status = "okay";

No PHY power supply needed? Same comment for rest of the PHY nodes.

> +};
> +
> +&pcie1_x1 {

No need to add a suffix to node label indicating the lane config.

> +	perst-gpios = <&tlmm 26 GPIO_ACTIVE_LOW>;

What about "wake" pin? Don't you need pinctrl definitions for these GPIOs?
Same comment for rest of the PCIe nodes.

> +	status = "okay";
> +};
> +
> +&pcie2_phy {
> +	status = "okay";
> +};
> +
> +&pcie2_x2 {
> +	perst-gpios = <&tlmm 29 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};
> +
> +&pcie3_phy {
> +	status = "okay";
> +};
> +
> +&pcie3_x2 {
> +	perst-gpios = <&tlmm 32 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};
> +
>  &sdhc_1 {
>  	pinctrl-0 = <&sdc_default_state>;
>  	pinctrl-names = "default";
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> index 062f80798ebb..a32dbdeb5bed 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -6,8 +6,8 @@
>   * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
> -#include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
>  
>  / {
> @@ -22,11 +22,41 @@
>  			#clock-cells = <0>;
>  		};
>  
> +		pcie30_phy0_pipe_clk: pcie30_phy0_pipe_clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <250000000>;
> +			#clock-cells = <0>;
> +		};
> +
> +		pcie30_phy1_pipe_clk: pcie30_phy1_pipe_clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <250000000>;
> +			#clock-cells = <0>;
> +		};
> +
> +		pcie30_phy2_pipe_clk: pcie30_phy2_pipe_clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <250000000>;
> +			#clock-cells = <0>;
> +		};
> +
> +		pcie30_phy3_pipe_clk: pcie30_phy3_pipe_clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <250000000>;
> +			#clock-cells = <0>;
> +		};

Why PIPE clocks are modeled as fixed clocks unlike other SoCs?

> +
>  		sleep_clk: sleep-clk {
>  			compatible = "fixed-clock";
>  			#clock-cells = <0>;
>  		};
>  
> +		usb3phy_0_cc_pipe_clk: usb3phy_0_cc_pipe_clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <125000000>;
> +			#clock-cells = <0>;
> +		};

Spurious?

> +
>  		xo_board_clk: xo-board-clk {
>  			compatible = "fixed-clock";
>  			#clock-cells = <0>;
> @@ -121,6 +151,155 @@
>  		#size-cells = <1>;
>  		ranges = <0 0 0 0xffffffff>;
>  
> +		pcie0_phy: phy@84000 {
> +			compatible = "qcom,ipq9574-qmp-gen3x1-pcie-phy";
> +			reg = <0x00084000 0x1bc>; /* Serdes PLL */
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			clocks = <&gcc GCC_PCIE0_AUX_CLK>,
> +				 <&gcc GCC_PCIE0_AHB_CLK>,
> +				 <&gcc GCC_ANOC_PCIE0_1LANE_M_CLK>,
> +				 <&gcc GCC_SNOC_PCIE0_1LANE_S_CLK>;
> +			clock-names = "aux", "cfg_ahb", "anoc_lane", "snoc_lane";

Care to explain what these anoc_lane and snoc_lane clocks are?

> +
> +			assigned-clocks = <&gcc GCC_PCIE0_AUX_CLK>;
> +			assigned-clock-rates = <20000000>;
> +
> +			resets = <&gcc GCC_PCIE0_PHY_BCR>,
> +				 <&gcc GCC_PCIE0PHY_PHY_BCR>;
> +			reset-names = "phy", "common";
> +
> +			status = "disabled";
> +
> +			pcie0_lane: phy@84200 {
> +				reg = <0x00084200 0x16c>, /* Serdes Tx */
> +				      <0x00084400 0x200>, /* Serdes Rx */
> +				      <0x00084800 0x1f0>, /* PCS: Lane0, COM, PCIE */
> +				      <0x00084c00 0xf4>;  /* pcs_misc */
> +				#phy-cells = <0>;
> +
> +				clocks = <&gcc GCC_PCIE0_PIPE_CLK>;
> +				clock-names = "pipe0";
> +				clock-output-names = "gcc_pcie0_pipe_clk_src";
> +				#clock-cells = <0>;
> +			};
> +		};
> +

[...]

> +		pcie1_x1: pci@10000000 {
> +			compatible = "qcom,pcie-ipq9574";
> +			reg =  <0x10000000 0xf1d>,
> +			       <0x10000F20 0xa8>,
> +			       <0x10001000 0x1000>,
> +			       <0x000F8000 0x4000>,
> +			       <0x10100000 0x1000>,
> +			       <0x00618108 0x4>;
> +			reg-names = "dbi", "elbi", "atu", "parf", "config", "aggr_noc";

As I asked in the binding patch, why "aggr_noc" region is required?

> +			device_type = "pci";
> +			linux,pci-domain = <2>;
> +			bus-range = <0x00 0xff>;
> +			num-lanes = <1>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +
> +			ranges = <0x81000000 0 0x10200000 0x10200000
> +				  0 0x00100000   /* downstream I/O */
> +				  0x82000000 0 0x10300000 0x10300000
> +				  0 0x07d00000>; /* non-prefetchable memory */

Don't split the ranges and encode them in a single line.

Also, the I'm not sure why you have set the relocatable flag (n) for both
ranges i.e., in 0x81000000 and 0x82000000.

> +
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc 0 35
> +					IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> +					<0 0 0 2 &intc 0 49
> +					IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> +					<0 0 0 3 &intc 0 84
> +					IRQ_TYPE_LEVEL_HIGH>, /* int_c */
> +					<0 0 0 4 &intc 0 85
> +					IRQ_TYPE_LEVEL_HIGH>; /* int_d */
> +

Again, wrap the interrupts in a single line.

> +			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "global_irq";
> +

Linux doesn't support global_irq yet. But since devicetree is supposed to
describe the hardware, you can keep it.

Above comment applies to rest of the PCIe nodes.

> +			/* clocks and clock-names are used to enable the clock in CBCR */
> +			clocks = <&gcc GCC_PCIE1_AHB_CLK>,
> +				 <&gcc GCC_PCIE1_AUX_CLK>,
> +				 <&gcc GCC_PCIE1_AXI_M_CLK>,
> +				 <&gcc GCC_PCIE1_AXI_S_CLK>,
> +				 <&gcc GCC_PCIE1_AXI_S_BRIDGE_CLK>,
> +				 <&gcc GCC_PCIE1_RCHNG_CLK>;
> +			clock-names = "ahb",
> +				      "aux",
> +				      "axi_m",
> +				      "axi_s",
> +				      "axi_bridge",
> +				      "rchng";
> +
> +			resets = <&gcc GCC_PCIE1_PIPE_ARES>,
> +				 <&gcc GCC_PCIE1_CORE_STICKY_ARES>,
> +				 <&gcc GCC_PCIE1_AXI_S_STICKY_ARES>,
> +				 <&gcc GCC_PCIE1_AXI_S_ARES>,
> +				 <&gcc GCC_PCIE1_AXI_M_STICKY_ARES>,
> +				 <&gcc GCC_PCIE1_AXI_M_ARES>,
> +				 <&gcc GCC_PCIE1_AUX_ARES>,
> +				 <&gcc GCC_PCIE1_AHB_ARES>;
> +			reset-names = "pipe",
> +				      "sticky",
> +				      "axi_s_sticky",
> +				      "axi_s",
> +				      "axi_m_sticky",
> +				      "axi_m",
> +				      "aux",
> +				      "ahb";
> +
> +			phys = <&pcie1_lane>;
> +			phy-names = "pciephy";
> +			msi-parent = <&v2m0>;
> +			status = "disabled";
> +		};
> +

[...]

> +		pcie2_x2: pci@20000000 {
> +			compatible = "qcom,pcie-ipq9574";
> +			reg =  <0x20000000 0xf1d>,
> +			       <0x20000F20 0xa8>,
> +			       <0x20001000 0x1000>,
> +			       <0x00088000 0x4000>,
> +			       <0x20100000 0x1000>;
> +			reg-names = "dbi", "elbi", "atu", "parf", "config";
> +			device_type = "pci";
> +			linux,pci-domain = <3>;
> +			bus-range = <0x00 0xff>;
> +			num-lanes =<2>;

Space after =

Thanks,
Mani

-- 
மணிவண்ணன் சதாசிவம்
