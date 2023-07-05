Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A334747FCF
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jul 2023 10:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjGEIga (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jul 2023 04:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjGEIgZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jul 2023 04:36:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3850CA;
        Wed,  5 Jul 2023 01:36:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55E2F61495;
        Wed,  5 Jul 2023 08:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F1FC433C8;
        Wed,  5 Jul 2023 08:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688546183;
        bh=GiPQbsvVFHH0j8Ie5psCcKK2KijMqaPujfg7IB6Ry38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UAHC3biC0K4TJF8XhzAbI5ItkvyX5d4lZGVtFX0QsBtmOsv5m03qZU+pE2mpGsuZO
         RuAu8cjyf3LWmejXMEEqTwmS4aiBvyFZcm2iw0Lr9Bs4O0Tj0mVdNxlcOvKZoLx9Go
         yCXru7EK+pDsVFDlqnFrzsTA+F/HQp/LDSy7G+RIGZCXfgZLJ5CPnrN3vuEuOcVkEB
         k0d0or4dZpSNFL+8NJb7D8GmZQRrntIlddLIOM4hYoMAdjNuCJ1fQb048nAwpP5988
         fDgpikDhAgWW1pUYE7OixtmfovE0udP8sxQPGuHigo/bgEjBbu5KZS5G/jEdKj+NKY
         jsK2e4ehZX/aA==
Date:   Wed, 5 Jul 2023 14:06:09 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, quic_shazhuss@quicinc.com,
        quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com,
        quic_nayiluri@quicinc.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v1 5/6] arm64: dts: qcom: sa8775p: Add pcie0 and pcie1
 nodes
Message-ID: <20230705083609.GD11854@thinkpad>
References: <1688545032-17748-1-git-send-email-quic_msarkar@quicinc.com>
 <1688545032-17748-6-git-send-email-quic_msarkar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1688545032-17748-6-git-send-email-quic_msarkar@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 05, 2023 at 01:47:10PM +0530, Mrinmay Sarkar wrote:
> Add pcie dtsi nodes for two controllers found on sa8775p platform.
> 
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 201 +++++++++++++++++++++++++-
>  1 file changed, 199 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index b130136acffe..88749cbaea8b 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -481,8 +481,8 @@ gcc: clock-controller@100000 {
>  				 <0>,
>  				 <0>,
>  				 <0>,
> -				 <0>,
> -				 <0>,
> +				 <&pcie0_phy>,
> +				 <&pcie1_phy>,
>  				 <0>,
>  				 <0>,
>  				 <0>;
> @@ -2315,4 +2315,201 @@ arch_timer: timer {
>  			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>  			     <GIC_PPI 12 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
>  	};
> +
> +	pcie0: pci@1c00000{
> +		device_type = "pci";
> +		compatible = "qcom,pcie-sa8775p";
> +		reg = <0x0 0x01c00000 0x0 0x3000>,
> +		      <0x0 0x40000000 0x0 0xf20>,
> +		      <0x0 0x40000f20 0x0 0xa8>,
> +		      <0x0 0x40001000 0x0 0x4000>,
> +		      <0x0 0x40100000 0x0 0x100000>,
> +		      <0x0 0x01c03000 0x0 0x1000>;
> +		reg-names = "parf", "dbi", "elbi", "atu", "config", "mhi";
> +
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		ranges = <0x01000000 0x0 0x40200000 0x0 0x40200000 0x0 0x100000>,

<0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x100000>

> +			<0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x1fd00000>;
> +		bus-range = <0x00 0xff>;
> +

Add "dma-coherent" property as the PCIe controller supports cache coherency.

> +		linux,pci-domain = <0>;
> +		num-lanes = <2>;
> +
> +		interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "msi";

Are you sure that there is only 1 MSI supported on this platform?

> +		#interrupt-cells = <1>;
> +		interrupt-map-mask = <0 0 0 0x7>;
> +		interrupt-map = <0 0 0 1 &intc GIC_SPI 434 IRQ_TYPE_LEVEL_HIGH>,
> +			<0 0 0 2 &intc GIC_SPI 435 IRQ_TYPE_LEVEL_HIGH>,
> +			<0 0 0 3 &intc GIC_SPI 438 IRQ_TYPE_LEVEL_HIGH>,
> +			<0 0 0 4 &intc GIC_SPI 439 IRQ_TYPE_LEVEL_HIGH>;

Align the values.

> +
> +		clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
> +			<&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> +			<&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
> +			<&gcc GCC_PCIE_0_SLV_AXI_CLK>,
> +			<&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>;
> +

Same as above.

> +		clock-names = "aux",
> +				"cfg",
> +				"bus_master",
> +				"bus_slave",
> +				"slave_q2a";

Same as above.

> +
> +		assigned-clocks = <&gcc GCC_PCIE_0_AUX_CLK>;
> +		assigned-clock-rates = <19200000>;
> +
> +		interconnects = <&pcie_anoc MASTER_PCIE_0 0 &mc_virt SLAVE_EBI1 0>;

Why no cpu-pcie path?

> +		interconnect-names = "pcie-mem";
> +
> +		resets = <&gcc GCC_PCIE_0_BCR>;
> +		reset-names = "pci";
> +		power-domains = <&gcc PCIE_0_GDSC>;
> +
> +		phys = <&pcie0_phy>;
> +		phy-names = "pciephy";
> +
> +		iommus = <&pcie_smmu 0x0000 0x1>;

This property is not needed.

> +		iommu-map = <0x0 &pcie_smmu 0x0000 0x1>,
> +			<0x100 &pcie_smmu 0x0001 0x1>;
> +
> +		perst-gpios = <&tlmm 2 1>;
> +		wake-gpios = <&tlmm 0 0>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pcie0_default_state>;

Move the pinctrl and gpio properties to board dts.

All of the above comment applies to other PCIe node below.

- Mani

> +
> +		status = "disabled";
> +	};
> +
> +	pcie0_phy: phy@1c04000 {
> +		compatible = "qcom,sa8775p-qmp-gen4x2-pcie-phy";
> +		reg = <0x0 0x1c04000 0x0 0x2000>;
> +
> +		clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
> +			 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> +			 <&gcc GCC_PCIE_CLKREF_EN>,
> +			 <&gcc GCC_PCIE_0_PHY_RCHNG_CLK>,
> +			 <&gcc GCC_PCIE_0_PHY_AUX_CLK>,
> +			 <&gcc GCC_PCIE_0_PIPE_CLK>,
> +			 <&gcc GCC_PCIE_0_PIPEDIV2_CLK>;
> +
> +		clock-names = "aux", "cfg_ahb", "ref", "rchng", "phy_aux",
> +						"pipe", "pipediv2";
> +
> +		assigned-clocks = <&gcc GCC_PCIE_0_PHY_RCHNG_CLK>;
> +		assigned-clock-rates = <100000000>;
> +
> +		power-domains = <&gcc PCIE_0_GDSC>;
> +
> +		resets = <&gcc GCC_PCIE_0_PHY_BCR>;
> +		reset-names = "phy";
> +
> +		#clock-cells = <0>;
> +		clock-output-names = "pcie_0_pipe_clk";
> +
> +		#phy-cells = <0>;
> +
> +		status = "disabled";
> +	};
> +
> +	pcie1: pci@1c10000{
> +		device_type = "pci";
> +		compatible = "qcom,pcie-sa8775p";
> +		reg = <0x0 0x01c10000 0x0 0x3000>,
> +		      <0x0 0x60000000 0x0 0xf20>,
> +		      <0x0 0x60000f20 0x0 0xa8>,
> +		      <0x0 0x60001000 0x0 0x4000>,
> +		      <0x0 0x60100000 0x0 0x100000>,
> +		      <0x0 0x01c13000 0x0 0x1000>;
> +		reg-names = "parf", "dbi", "elbi", "atu", "config", "mhi";
> +
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		ranges = <0x01000000 0x0 0x60200000 0x0 0x60200000 0x0 0x100000>,
> +			<0x02000000 0x0 0x60300000 0x0 0x60300000 0x0 0x1fd00000>;
> +		bus-range = <0x00 0xff>;
> +
> +		linux,pci-domain = <1>;
> +		num-lanes = <4>;
> +
> +		interrupts = <GIC_SPI 519 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "msi";
> +		#interrupt-cells = <1>;
> +		interrupt-map-mask = <0 0 0 0x7>;
> +		interrupt-map = <0 0 0 1 &intc GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
> +				<0 0 0 2 &intc GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
> +				<0 0 0 3 &intc GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
> +				<0 0 0 4 &intc GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
> +
> +		clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
> +			<&gcc GCC_PCIE_1_CFG_AHB_CLK>,
> +			<&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
> +			<&gcc GCC_PCIE_1_SLV_AXI_CLK>,
> +			<&gcc GCC_PCIE_1_SLV_Q2A_AXI_CLK>;
> +
> +		clock-names = "aux",
> +				"cfg",
> +				"bus_master",
> +				"bus_slave",
> +				"slave_q2a";
> +
> +		assigned-clocks = <&gcc GCC_PCIE_1_AUX_CLK>;
> +		assigned-clock-rates = <19200000>;
> +
> +		interconnects = <&pcie_anoc MASTER_PCIE_1 0 &mc_virt SLAVE_EBI1 0>;
> +		interconnect-names = "pcie-mem";
> +
> +		resets = <&gcc GCC_PCIE_1_BCR>;
> +		reset-names = "pci";
> +		power-domains = <&gcc PCIE_1_GDSC>;
> +
> +		phys = <&pcie1_phy>;
> +		phy-names = "pciephy";
> +
> +		iommus = <&pcie_smmu 0x0080 0x1>;
> +		iommu-map = <0x0 &pcie_smmu 0x0080 0x1>,
> +			<0x100 &pcie_smmu 0x0081 0x1>;
> +
> +		perst-gpios = <&tlmm 4 1>;
> +		wake-gpios = <&tlmm 5 0>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pcie1_default_state>;
> +
> +		status = "disabled";
> +	};
> +
> +	pcie1_phy: phy@1c14000 {
> +		compatible = "qcom,sa8775p-qmp-gen4x4-pcie-phy";
> +		reg = <0x0 0x1c14000 0x0 0x4000>;
> +
> +		clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
> +			 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
> +			 <&gcc GCC_PCIE_CLKREF_EN>,
> +			 <&gcc GCC_PCIE_1_PHY_RCHNG_CLK>,
> +			 <&gcc GCC_PCIE_1_PHY_AUX_CLK>,
> +			 <&gcc GCC_PCIE_1_PIPE_CLK>,
> +			 <&gcc GCC_PCIE_1_PIPEDIV2_CLK>;
> +
> +		clock-names = "aux", "cfg_ahb", "ref", "rchng", "phy_aux",
> +						"pipe", "pipediv2";
> +
> +		assigned-clocks = <&gcc GCC_PCIE_1_PHY_RCHNG_CLK>;
> +		assigned-clock-rates = <100000000>;
> +
> +		power-domains = <&gcc PCIE_1_GDSC>;
> +
> +		resets = <&gcc GCC_PCIE_1_PHY_BCR>;
> +		reset-names = "phy";
> +
> +		#clock-cells = <0>;
> +		clock-output-names = "pcie_1_pipe_clk";
> +
> +		#phy-cells = <0>;
> +
> +		status = "disabled";
> +
> +	};
>  };
> -- 
> 2.39.2
> 

-- 
மணிவண்ணன் சதாசிவம்
