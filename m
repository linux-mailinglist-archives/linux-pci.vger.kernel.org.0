Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD33F4C8B34
	for <lists+linux-pci@lfdr.de>; Tue,  1 Mar 2022 12:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbiCAMAe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Mar 2022 07:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbiCAMAb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Mar 2022 07:00:31 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F022251D
        for <linux-pci@vger.kernel.org>; Tue,  1 Mar 2022 03:59:48 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id f37so26399398lfv.8
        for <linux-pci@vger.kernel.org>; Tue, 01 Mar 2022 03:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Si9aW8LCRt5/GwrO2//8BMDIlBc8iSDjacAKlZRx+TQ=;
        b=s1igJK3l+Va0dZp8E9uNa6ojypPkViWmCK7B6e/ivbYdOTCg3Pxemn0dYyX08MJlg6
         DO9kJrrltWp20LX/G/XNek5ZFAjnNCnnV45kbAZAdl0tBFVBTDMH69/LJK7lU1lOoIUB
         R79279OBeExrxDiEvz/UrEhsjPY5bb6YYIT4lqpfa+Mlba84ZzFQmu5fOChpZIVlXFzd
         lj/c5T3G09z+n3AhJ1/d+vPfdsJOeKJW/Or03SiGSvo+dVU9LpPAJKlvqxjZSl+DaSvr
         qhnAILKJPfrCyYjZvNCpiGTiMwF51AEgxsHIjIFHG2z4yrqCAE2AQ9tXEV3i55/lMHtw
         qB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Si9aW8LCRt5/GwrO2//8BMDIlBc8iSDjacAKlZRx+TQ=;
        b=xdsxzd0RjPvs9xMpfJjdnNrcZCGfOw6VFaaVm3j6JR8QoVVGvehqWarTQvK4sZNlfI
         qaxbX1aQq8bhpqn4Iu/FcIWwnVgF0f/RAirOm4ZCK787rp/SlsWWAKrUYsECJyY5qLP2
         zlIG9b89YgPSIMDb0Q2GkvaXsOUXJuVIMqXkGiG48ucwYw6jyFOApPJf7WiKiSFZEfu4
         J3Gt0lA3FXJidEeH3mJWkHCQyHiV551Z1lEYiIeE8A4h6LfHUIj4Sca/tCaHoBibZq/J
         iVD1mnbM/bxej6YmorGeQMVe1wFIFr64EJBHK3hv8ui4A4DpWTxHjbmDWZ1DiZlvsc5v
         f8oA==
X-Gm-Message-State: AOAM532xp3mmdPttvkjDmXSZni+5gizCxT1GT2fH4fRWjdq0BdVvsdaf
        2boEh5AARC6ZpGTQfT5WHi+BZA==
X-Google-Smtp-Source: ABdhPJzpYUIzhepTGM8F34Cw9Ax1tyYQ6Gh+ZuCx4zapfvFyQ2yyS8kip73EUxgDfz3vgszQd5WPxw==
X-Received: by 2002:a05:6512:202c:b0:443:3ce0:22a with SMTP id s12-20020a056512202c00b004433ce0022amr15627934lfs.74.1646135986201;
        Tue, 01 Mar 2022 03:59:46 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id t12-20020ac2548c000000b004435947cf11sm1453672lfk.201.2022.03.01.03.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 03:59:45 -0800 (PST)
Message-ID: <ce32cafe-8dd9-526d-5413-ad81df7b78eb@linaro.org>
Date:   Tue, 1 Mar 2022 14:59:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 6/7] arm64: dts: qcom: sm8150: Add pcie nodes for
 SM8150
Content-Language: en-GB
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     bhupesh.linux@gmail.com, lorenzo.pieralisi@arm.com,
        agross@kernel.org, bjorn.andersson@linaro.org,
        svarbanov@mm-sol.com, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, linux-clk@vger.kernel.org
References: <20220301072511.117818-1-bhupesh.sharma@linaro.org>
 <20220301072511.117818-7-bhupesh.sharma@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220301072511.117818-7-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 01/03/2022 10:25, Bhupesh Sharma wrote:
> Add nodes for the two PCIe controllers founds on the
> SM8150 SoC.
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8150.dtsi | 243 +++++++++++++++++++++++++++
>   1 file changed, 243 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index 6012322a5984..b97f04ec9c6b 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -1626,6 +1626,203 @@ system-cache-controller@9200000 {
>   			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
>   		};
>   
> +		pcie0: pci@1c00000 {
> +			compatible = "qcom,pcie-sm8150", "snps,dw-pcie";
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
> +			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi";
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> +					<0 0 0 2 &intc 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> +					<0 0 0 3 &intc 0 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
> +					<0 0 0 4 &intc 0 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
> +
> +			clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
> +				 <&gcc GCC_PCIE_0_AUX_CLK>,
> +				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
> +				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
> +				 <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
> +			clock-names = "pipe",
> +				      "aux",
> +				      "cfg",
> +				      "bus_master",
> +				      "bus_slave",
> +				      "slave_q2a",
> +				      "tbu";
> +
> +			iommus = <&apps_smmu 0x1d80 0x7f>;
> +			iommu-map = <0x0   &apps_smmu 0x1d80 0x1>,
> +				    <0x100 &apps_smmu 0x1d81 0x1>;
> +
> +			resets = <&gcc GCC_PCIE_0_BCR>;
> +			reset-names = "pci";
> +
> +			power-domains = <&gcc PCIE_0_GDSC>;
> +
> +			phys = <&pcie0_lane>;
> +			phy-names = "pciephy";
> +
> +			perst-gpio = <&tlmm 35 GPIO_ACTIVE_HIGH>;
> +			enable-gpio = <&tlmm 37 GPIO_ACTIVE_HIGH>;
> +
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pcie0_default_state>;
> +
> +			status = "disabled";
> +		};
> +
> +		pcie0_phy: phy@1c06000 {
> +			compatible = "qcom,sm8150-qmp-gen3x1-pcie-phy";
> +			reg = <0 0x01c06000 0 0x1c0>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +			clocks = <&gcc GCC_PCIE_PHY_AUX_CLK>,
> +				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE0_PHY_REFGEN_CLK>;
> +			clock-names = "aux", "cfg_ahb", "refgen";
> +
> +			resets = <&gcc GCC_PCIE_0_PHY_BCR>;
> +			reset-names = "phy";
> +
> +			assigned-clocks = <&gcc GCC_PCIE0_PHY_REFGEN_CLK>;
> +			assigned-clock-rates = <100000000>;
> +
> +			status = "disabled";
> +
> +			pcie0_lane: phy@1c06200 {
> +				reg = <0 0x1c06200 0 0x170>, /* tx */
> +				      <0 0x1c06400 0 0x200>, /* rx */
> +				      <0 0x1c06800 0 0x1f0>, /* pcs */
> +				      <0 0x1c06c00 0 0xf4>; /* "pcs_lane" same as pcs_misc? */
> +				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
> +				clock-names = "pipe0";
> +
> +				#phy-cells = <0>;
> +				clock-output-names = "pcie_0_pipe_clk";
> +			};
> +		};
> +
> +		pcie1: pci@1c08000 {
> +			compatible = "qcom,pcie-sm8150", "snps,dw-pcie";
> +			reg = <0 0x01c08000 0 0x3000>,
> +			      <0 0x40000000 0 0xf1d>,
> +			      <0 0x40000f20 0 0xa8>,
> +			      <0 0x40001000 0 0x1000>,
> +			      <0 0x40100000 0 0x100000>;
> +			reg-names = "parf", "dbi", "elbi", "atu", "config";
> +			device_type = "pci";
> +			linux,pci-domain = <1>;
> +			bus-range = <0x00 0xff>;
> +			num-lanes = <2>;
> +
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +
> +			ranges = <0x01000000 0x0 0x40200000 0x0 0x40200000 0x0 0x100000>,
> +				 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x1fd00000>;
> +
> +			interrupts = <GIC_SPI 306 IRQ_TYPE_EDGE_RISING>;

This should be 307

> +			interrupt-names = "msi";
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc 0 434 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> +					<0 0 0 2 &intc 0 435 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> +					<0 0 0 3 &intc 0 438 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
> +					<0 0 0 4 &intc 0 439 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
> +
> +			clocks = <&gcc GCC_PCIE_1_PIPE_CLK>,
> +				 <&gcc GCC_PCIE_1_AUX_CLK>,
> +				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
> +				 <&gcc GCC_PCIE_1_SLV_AXI_CLK>,
> +				 <&gcc GCC_PCIE_1_SLV_Q2A_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
> +			clock-names = "pipe",
> +				      "aux",
> +				      "cfg",
> +				      "bus_master",
> +				      "bus_slave",
> +				      "slave_q2a",
> +				      "tbu";
> +
> +			assigned-clocks = <&gcc GCC_PCIE_1_AUX_CLK>;
> +			assigned-clock-rates = <19200000>;
> +
> +			iommus = <&apps_smmu 0x1e00 0x7f>;
> +			iommu-map = <0x0   &apps_smmu 0x1e00 0x1>,
> +				    <0x100 &apps_smmu 0x1e01 0x1>;
> +
> +			resets = <&gcc GCC_PCIE_1_BCR>;
> +			reset-names = "pci";
> +
> +			power-domains = <&gcc PCIE_1_GDSC>;
> +
> +			phys = <&pcie1_lane>;
> +			phy-names = "pciephy";
> +
> +			perst-gpio = <&tlmm 102 GPIO_ACTIVE_HIGH>;
> +			enable-gpio = <&tlmm 104 GPIO_ACTIVE_HIGH>;
> +
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pcie1_default_state>;
> +
> +			status = "disabled";
> +		};
> +
> +		pcie1_phy: phy@1c0e000 {
> +			compatible = "qcom,sm8150-qmp-gen3x2-pcie-phy";
> +			reg = <0 0x01c0e000 0 0x1c0>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +			clocks = <&gcc GCC_PCIE_PHY_AUX_CLK>,
> +				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE1_PHY_REFGEN_CLK>;
> +			clock-names = "aux", "cfg_ahb", "refgen";
> +
> +			resets = <&gcc GCC_PCIE_1_PHY_BCR>;
> +			reset-names = "phy";
> +
> +			assigned-clocks = <&gcc GCC_PCIE1_PHY_REFGEN_CLK>;
> +			assigned-clock-rates = <100000000>;
> +
> +			status = "disabled";
> +
> +			pcie1_lane: phy@1c0e200 {
> +				reg = <0 0x1c0e200 0 0x170>, /* tx0 */
> +				      <0 0x1c0e400 0 0x200>, /* rx0 */
> +				      <0 0x1c0ea00 0 0x1f0>, /* pcs */
> +				      <0 0x1c0e600 0 0x170>, /* tx1 */
> +				      <0 0x1c0e800 0 0x200>, /* rx1 */
> +				      <0 0x1c0ee00 0 0xf4>; /* "pcs_com" same as pcs_misc? */
> +				clocks = <&gcc GCC_PCIE_1_PIPE_CLK>;
> +				clock-names = "pipe0";
> +
> +				#phy-cells = <0>;
> +				clock-output-names = "pcie_1_pipe_clk";
> +			};
> +		};
> +
>   		ufs_mem_hc: ufshc@1d84000 {
>   			compatible = "qcom,sm8150-ufshc", "qcom,ufshc",
>   				     "jedec,ufs-2.0";
> @@ -2327,6 +2524,52 @@ qup_spi19_default: qup-spi19-default {
>   				drive-strength = <6>;
>   				bias-disable;
>   			};
> +
> +			pcie0_default_state: pcie0-default {
> +				perst {
> +					pins = "gpio35";
> +					function = "gpio";
> +					drive-strength = <2>;
> +					bias-pull-down;
> +				};
> +
> +				clkreq {
> +					pins = "gpio36";
> +					function = "pci_e0";
> +					drive-strength = <2>;
> +					bias-pull-up;
> +				};
> +
> +				wake {
> +					pins = "gpio37";
> +					function = "gpio";
> +					drive-strength = <2>;
> +					bias-pull-up;
> +				};
> +			};
> +
> +			pcie1_default_state: pcie1-default {
> +				perst {
> +					pins = "gpio102";
> +					function = "gpio";
> +					drive-strength = <2>;
> +					bias-pull-down;
> +				};
> +
> +				clkreq {
> +					pins = "gpio103";
> +					function = "pci_e1";
> +					drive-strength = <2>;
> +					bias-pull-up;
> +				};
> +
> +				wake {
> +					pins = "gpio104";
> +					function = "gpio";
> +					drive-strength = <2>;
> +					bias-pull-up;
> +				};
> +			};
>   		};
>   
>   		remoteproc_mpss: remoteproc@4080000 {


-- 
With best wishes
Dmitry
