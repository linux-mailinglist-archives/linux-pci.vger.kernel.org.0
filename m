Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5905A62FFD7
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 23:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiKRWM2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 17:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiKRWM1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 17:12:27 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2142AE007
        for <linux-pci@vger.kernel.org>; Fri, 18 Nov 2022 14:12:26 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id j4so10457938lfk.0
        for <linux-pci@vger.kernel.org>; Fri, 18 Nov 2022 14:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BP1pZfB5L6HAN1d/uOa0OfQ6gxpcqhet4v5Jrhgig0Y=;
        b=wB02qBRNpHsPPVMbb3DDr9kto6WCgy5JPo6KvvXLpNqnuCS+iDtrm7ZmLVlb41lrWv
         5k0e0cgpXsuh23/9cDwtuhEv2nOD+vBzuzOsDxBPnNXXhU1ZTriTLVkUsqBgAGrA1Gkk
         fZYRtruW9guzXlTokt0kGVvETPTe5tz5enoMhZbfC0gD7zcBF7c0iLGXUbp8mBybKpbL
         m8Y47vrSOKnhX+szUwq0SdUD6weChiovo6TNwAgbIKctMKuUOPqMGW1bngn5ADFbIGDZ
         g+KmsyBKC+HiqN6rYmYhYI86cxDRmH2JGW/RET6iWaIChoYTM0EBTqBJuAZccbIerHWz
         bx3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BP1pZfB5L6HAN1d/uOa0OfQ6gxpcqhet4v5Jrhgig0Y=;
        b=75P5Hvh3/plYZ8iMPNk6IoiMMAUx6p6+GUkwFZkSMXwx7kO8M75ZUq3tXUoNJOVJZJ
         4FCvWlIVUArj/6NvLUhYtcfeU7XhuaUWTRnpXrYQsf+aAmlgEsr5gWTheZ3zztzlTpUj
         kHV8r4dc2CrH/Pen9nRR0hWXfU/R5btPBr040oAq38BmnEPaofDlqIos2bVfTqhbqyy0
         4sQIHMg1k9XSITJT1KWqytJr4EtqiadA9cem5tjNXIB89tr80qRJm78CLLfgTokDhKix
         t2pgUm9Cn5Nb+dsU0IgmiswcwtYD8tsm8AmM+LvjA19K/lJaqlMC1b3Bcqi2hmkqHM4q
         RcFw==
X-Gm-Message-State: ANoB5pn+Lbn9kb1qE023dxdJoLpIdi3ufS71BaTeuPzIKd2Ge5RRlgRd
        A3CJ7R2C4deaezmB7Io339biaQ==
X-Google-Smtp-Source: AA0mqf6p8b1JfeRZXZESF3phUkzBVLQLltBm/Ua90nA8Keoxzd4XxMZ9iYpdHpSBe4G9KOWZJprjzA==
X-Received: by 2002:ac2:5f41:0:b0:4b3:cc01:102b with SMTP id 1-20020ac25f41000000b004b3cc01102bmr3195993lfz.133.1668809544435;
        Fri, 18 Nov 2022 14:12:24 -0800 (PST)
Received: from [192.168.1.129] ([194.204.33.9])
        by smtp.gmail.com with ESMTPSA id n15-20020a2e86cf000000b0026ddaf38b0fsm816651ljj.96.2022.11.18.14.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 14:12:24 -0800 (PST)
Message-ID: <a88557b7-3126-1fd0-6bbf-8d9d8177f021@linaro.org>
Date:   Sat, 19 Nov 2022 00:12:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 7/8] arm64: dts: qcom: sm8350: add PCIe devices
Content-Language: en-GB
To:     Johan Hovold <johan@kernel.org>
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
References: <20221110183158.856242-1-dmitry.baryshkov@linaro.org>
 <20221110183158.856242-8-dmitry.baryshkov@linaro.org>
 <Y3T4nOjcdkSG4fYa@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <Y3T4nOjcdkSG4fYa@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 16/11/2022 16:50, Johan Hovold wrote:
> On Thu, Nov 10, 2022 at 09:31:57PM +0300, Dmitry Baryshkov wrote:
>> Add PCIe0 and PCIe1 (and corresponding PHY) devices found on SM8350
>> platform. The PCIe0 is a 1-lane Gen3 host, PCIe1 is a 2-lane Gen3 host.
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8350.dtsi | 246 ++++++++++++++++++++++++++-
>>   1 file changed, 244 insertions(+), 2 deletions(-)
> 
>> +		pcie0: pci@1c00000 {
>> +			compatible = "qcom,pcie-sm8350";
>> +			reg = <0 0x01c00000 0 0x3000>,
>> +			      <0 0x60000000 0 0xf1d>,
>> +			      <0 0x60000f20 0 0xa8>,
>> +			      <0 0x60001000 0 0x1000>,
>> +			      <0 0x60100000 0 0x100000>;
>> +			reg-names = "parf", "dbi", "elbi", "atu", "config";
>> +			device_type = "pci";
>> +			linux,pci-domain = <0>;
>> +			bus-range = <0x00 0xff>;
>> +			num-lanes = <1>;
>> +
>> +			#address-cells = <3>;
>> +			#size-cells = <2>;
>> +
>> +			ranges = <0x01000000 0x0 0x60200000 0 0x60200000 0x0 0x100000>,
>> +				 <0x02000000 0x0 0x60300000 0 0x60300000 0x0 0x3d00000>;
>> +
>> +			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "msi0", "msi1", "msi2", "msi3",
>> +					  "msi4", "msi5", "msi6", "msi7";
>> +			#interrupt-cells = <1>;
>> +			interrupt-map-mask = <0 0 0 0x7>;
>> +			interrupt-map = <0 0 0 1 &intc 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
>> +					<0 0 0 2 &intc 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
>> +					<0 0 0 3 &intc 0 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
>> +					<0 0 0 4 &intc 0 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
>> +
>> +			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
>> +				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
>> +				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
>> +				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
>> +				 <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
>> +				 <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>,
>> +				 <&gcc GCC_DDRSS_PCIE_SF_TBU_CLK>,
>> +				 <&gcc GCC_AGGRE_NOC_PCIE_0_AXI_CLK>,
>> +				 <&gcc GCC_AGGRE_NOC_PCIE_1_AXI_CLK>;
>> +			clock-names = "aux",
>> +				      "cfg",
>> +				      "bus_master",
>> +				      "bus_slave",
>> +				      "slave_q2a",
>> +				      "tbu",
>> +				      "ddrss_sf_tbu",
>> +				      "aggre0",
>> +				      "aggre1";
>> +
>> +			iommus = <&apps_smmu 0x1c00 0x7f>;
>> +			iommu-map = <0x0   &apps_smmu 0x1c00 0x1>,
>> +				    <0x100 &apps_smmu 0x1c01 0x1>;
>> +
>> +			resets = <&gcc GCC_PCIE_0_BCR>;
>> +			reset-names = "pci";
>> +
>> +			power-domains = <&gcc PCIE_0_GDSC>;
>> +
>> +			phys = <&pcie0_phy>;
>> +			phy-names = "pciephy";
>> +
>> +			perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
>> +			wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
>> +
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&pcie0_default_state>;
> 
> So I still think these do not belong in the dtsi for the reasons I just
> gave in a reply to v2.

Ack. I must admit, I asked Bjorn and he confirmed that pcie pinconf also 
belongs to the board dtsi. So I think I'll leave the pinctrl-0 here, but 
split the bias/strength to the board dtsi.

I still think that we should agree & document the approach and then 
change all boards to follow it. Otherwise e.g. one of sm8550 review 
comments tells the opposite thing: to move sdcc pinconf to SoC dtsi.

> 
>> +
>> +			status = "disabled";
>> +		};
>> +
>> +		pcie0_phy: phy@1c06000 {
>> +			compatible = "qcom,sm8350-qmp-gen3x1-pcie-phy";
>> +			reg = <0 0x01c06000 0 0x2000>;
> 
>> +			#address-cells = <2>;
>> +			#size-cells = <2>;
>> +			ranges;
> 
> These three should not be here (same for pcie1).

Ack

> 
>> +			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
>> +				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
>> +				 <&gcc GCC_PCIE_0_CLKREF_EN>,
>> +				 <&gcc GCC_PCIE0_PHY_RCHNG_CLK>,
>> +				 <&gcc GCC_PCIE_0_PIPE_CLK>;
>> +			clock-names = "aux", "cfg_ahb", "ref", "rchng", "pipe";
>> +
>> +			resets = <&gcc GCC_PCIE_0_PHY_BCR>;
>> +			reset-names = "phy";
>> +
>> +			assigned-clocks = <&gcc GCC_PCIE0_PHY_RCHNG_CLK>;
>> +			assigned-clock-rates = <100000000>;
>> +
>> +			#clock-cells = <0>;
>> +			clock-output-names = "pcie_0_pipe_clk";
>> +
>> +			#phy-cells = <0>;
>> +
>> +			status = "disabled";
>> +		};
> 
>>   		lpass_ag_noc: interconnect@3c40000 {
>>   			compatible = "qcom,sm8350-lpass-ag-noc";
>>   			reg = <0 0x03c40000 0 0xf080>;
>> @@ -1761,6 +1957,52 @@ tlmm: pinctrl@f100000 {
>>   			gpio-ranges = <&tlmm 0 0 204>;
>>   			wakeup-parent = <&pdc>;
>>   
>> +			pcie0_default_state: pcie0-default-state {
>> +				perst-pins {
>> +					pins = "gpio94";
>> +					function = "gpio";
>> +					drive-strength = <2>;
>> +					bias-pull-down;
>> +				};
>> +
>> +				clkreq-pins {
>> +					pins = "gpio95";
>> +					function = "pcie0_clkreqn";
>> +					drive-strength = <2>;
>> +					bias-pull-up;
>> +				};
>> +
>> +				wake-pins {
>> +					pins = "gpio96";
>> +					function = "gpio";
>> +					drive-strength = <2>;
>> +					bias-pull-up;
>> +				};
>> +			};
>> +
>> +			pcie1_default_state: pcie1-default-state {
>> +				perst-pins {
>> +					pins = "gpio97";
>> +					function = "gpio";
>> +					drive-strength = <2>;
>> +					bias-pull-down;
>> +				};
>> +
>> +				clkreq-pins {
>> +					pins = "gpio98";
>> +					function = "pcie1_clkreqn";
>> +					drive-strength = <2>;
>> +					bias-pull-up;
>> +				};
>> +
>> +				wake-pins {
>> +					pins = "gpio99";
>> +					function = "gpio";
>> +					drive-strength = <2>;
>> +					bias-pull-up;
>> +				};
>> +			};
>> +
>>   			qup_uart3_default_state: qup-uart3-default-state {
>>   				rx-pins {
>>   					pins = "gpio18";
> 
> Johan

-- 
With best wishes
Dmitry

