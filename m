Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A5A62C16C
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 15:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbiKPOwj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 09:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233936AbiKPOwV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 09:52:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A50F53EDC;
        Wed, 16 Nov 2022 06:50:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92FB2B81DC1;
        Wed, 16 Nov 2022 14:50:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38007C433C1;
        Wed, 16 Nov 2022 14:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668610234;
        bh=6vx2NuaTph2eyF47tN2DEOdT9UeyQdio2OQSeSyfcz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I8KBahRUdK7IKAW56nRRksqNWA2vDdC3IPeZz19j/DkjFr+UwpnMYyne0erKjcXFI
         ZqAHZve56e9BwG67X5/C5BQGSg0O5UnPS190+F0h89qMCiREUJLpZnt8Pi9VaqJx0k
         jhL0j4Jo8inFbxDt3tW0LDddgMSuSB6vcGLuLkC6uJIb2ct0n55DgmAAUN7ILAFe6b
         LlDcWvgYlkrK8ntbNdVBUcNxfnlGRhBMQSuTQSIJ86RtqsvNk0R460NA7jGFgfo5Dp
         2ys1Lzy9weHKzRJGeXSlcCtrzATxBuj30OfvbKqyXmmq1gxh54WZVuMXX/lZxSdC3r
         YRXEBm3QAAiiw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ovJjo-0003Ox-IS; Wed, 16 Nov 2022 15:50:04 +0100
Date:   Wed, 16 Nov 2022 15:50:04 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 7/8] arm64: dts: qcom: sm8350: add PCIe devices
Message-ID: <Y3T4nOjcdkSG4fYa@hovoldconsulting.com>
References: <20221110183158.856242-1-dmitry.baryshkov@linaro.org>
 <20221110183158.856242-8-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110183158.856242-8-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 10, 2022 at 09:31:57PM +0300, Dmitry Baryshkov wrote:
> Add PCIe0 and PCIe1 (and corresponding PHY) devices found on SM8350
> platform. The PCIe0 is a 1-lane Gen3 host, PCIe1 is a 2-lane Gen3 host.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8350.dtsi | 246 ++++++++++++++++++++++++++-
>  1 file changed, 244 insertions(+), 2 deletions(-)

> +		pcie0: pci@1c00000 {
> +			compatible = "qcom,pcie-sm8350";
> +			reg = <0 0x01c00000 0 0x3000>,
> +			      <0 0x60000000 0 0xf1d>,
> +			      <0 0x60000f20 0 0xa8>,
> +			      <0 0x60001000 0 0x1000>,
> +			      <0 0x60100000 0 0x100000>;
> +			reg-names = "parf", "dbi", "elbi", "atu", "config";
> +			device_type = "pci";
> +			linux,pci-domain = <0>;
> +			bus-range = <0x00 0xff>;
> +			num-lanes = <1>;
> +
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +
> +			ranges = <0x01000000 0x0 0x60200000 0 0x60200000 0x0 0x100000>,
> +				 <0x02000000 0x0 0x60300000 0 0x60300000 0x0 0x3d00000>;
> +
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
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> +					<0 0 0 2 &intc 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> +					<0 0 0 3 &intc 0 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
> +					<0 0 0 4 &intc 0 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
> +
> +			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
> +				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
> +				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
> +				 <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>,
> +				 <&gcc GCC_DDRSS_PCIE_SF_TBU_CLK>,
> +				 <&gcc GCC_AGGRE_NOC_PCIE_0_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_NOC_PCIE_1_AXI_CLK>;
> +			clock-names = "aux",
> +				      "cfg",
> +				      "bus_master",
> +				      "bus_slave",
> +				      "slave_q2a",
> +				      "tbu",
> +				      "ddrss_sf_tbu",
> +				      "aggre0",
> +				      "aggre1";
> +
> +			iommus = <&apps_smmu 0x1c00 0x7f>;
> +			iommu-map = <0x0   &apps_smmu 0x1c00 0x1>,
> +				    <0x100 &apps_smmu 0x1c01 0x1>;
> +
> +			resets = <&gcc GCC_PCIE_0_BCR>;
> +			reset-names = "pci";
> +
> +			power-domains = <&gcc PCIE_0_GDSC>;
> +
> +			phys = <&pcie0_phy>;
> +			phy-names = "pciephy";
> +
> +			perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
> +			wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
> +
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pcie0_default_state>;

So I still think these do not belong in the dtsi for the reasons I just
gave in a reply to v2.

> +
> +			status = "disabled";
> +		};
> +
> +		pcie0_phy: phy@1c06000 {
> +			compatible = "qcom,sm8350-qmp-gen3x1-pcie-phy";
> +			reg = <0 0x01c06000 0 0x2000>;

> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;

These three should not be here (same for pcie1).

> +			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
> +				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_0_CLKREF_EN>,
> +				 <&gcc GCC_PCIE0_PHY_RCHNG_CLK>,
> +				 <&gcc GCC_PCIE_0_PIPE_CLK>;
> +			clock-names = "aux", "cfg_ahb", "ref", "rchng", "pipe";
> +
> +			resets = <&gcc GCC_PCIE_0_PHY_BCR>;
> +			reset-names = "phy";
> +
> +			assigned-clocks = <&gcc GCC_PCIE0_PHY_RCHNG_CLK>;
> +			assigned-clock-rates = <100000000>;
> +
> +			#clock-cells = <0>;
> +			clock-output-names = "pcie_0_pipe_clk";
> +
> +			#phy-cells = <0>;
> +
> +			status = "disabled";
> +		};

>  		lpass_ag_noc: interconnect@3c40000 {
>  			compatible = "qcom,sm8350-lpass-ag-noc";
>  			reg = <0 0x03c40000 0 0xf080>;
> @@ -1761,6 +1957,52 @@ tlmm: pinctrl@f100000 {
>  			gpio-ranges = <&tlmm 0 0 204>;
>  			wakeup-parent = <&pdc>;
>  
> +			pcie0_default_state: pcie0-default-state {
> +				perst-pins {
> +					pins = "gpio94";
> +					function = "gpio";
> +					drive-strength = <2>;
> +					bias-pull-down;
> +				};
> +
> +				clkreq-pins {
> +					pins = "gpio95";
> +					function = "pcie0_clkreqn";
> +					drive-strength = <2>;
> +					bias-pull-up;
> +				};
> +
> +				wake-pins {
> +					pins = "gpio96";
> +					function = "gpio";
> +					drive-strength = <2>;
> +					bias-pull-up;
> +				};
> +			};
> +
> +			pcie1_default_state: pcie1-default-state {
> +				perst-pins {
> +					pins = "gpio97";
> +					function = "gpio";
> +					drive-strength = <2>;
> +					bias-pull-down;
> +				};
> +
> +				clkreq-pins {
> +					pins = "gpio98";
> +					function = "pcie1_clkreqn";
> +					drive-strength = <2>;
> +					bias-pull-up;
> +				};
> +
> +				wake-pins {
> +					pins = "gpio99";
> +					function = "gpio";
> +					drive-strength = <2>;
> +					bias-pull-up;
> +				};
> +			};
> +
>  			qup_uart3_default_state: qup-uart3-default-state {
>  				rx-pins {
>  					pins = "gpio18";

Johan
