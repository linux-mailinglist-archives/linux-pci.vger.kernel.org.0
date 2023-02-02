Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17016887CA
	for <lists+linux-pci@lfdr.de>; Thu,  2 Feb 2023 20:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjBBTu5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Feb 2023 14:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbjBBTu5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Feb 2023 14:50:57 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C0D712D8
        for <linux-pci@vger.kernel.org>; Thu,  2 Feb 2023 11:50:54 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id f7so3175871edw.5
        for <linux-pci@vger.kernel.org>; Thu, 02 Feb 2023 11:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vU6b1/DyW9VF99p038CT5rL7cz19rU/zHJDhT4ApbFc=;
        b=qFo6Zs4zc/E7ttK81jaTeAILjmRH5v3tgoYVgjr6j/geeokXq8B3VKC1pad3rpZa5z
         Hx9aluvyOeNlG/2t/IxUqJKbWmnWj8CdxyMA1jK8k/tj9FveSRBkAaYJC2Ks7QmLpinM
         ho7p6AP7jt5VbSWhkHP8/2a0cLQP/b98mdx9WZGKea13BendXKvIiiLPwEp4sQg8W9Kr
         4kPHEyZP2DzxfUYQpUpP7nLPaXwQ3NPYdyzX29/ZCFhWw1uNQqzcOktQep/WzBX59D0r
         YeVPI49AW2fyIGS8rPUAfXPADxjZXADDlQGjJGGpUbZ+TB2SMs0YW4F/lM/HadrYG4Rr
         S93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vU6b1/DyW9VF99p038CT5rL7cz19rU/zHJDhT4ApbFc=;
        b=ssUfSGyk3WSVWaNtSf2H0BkzixQ7OKD2+7DQGD93GKDlHR9YqzESACTBuF7HOrsWA9
         mcQ5385imLpR2V1AvanW3TLQzn1MjiPOq0zwjaindNdqnzvrctIobdXH+Ez91jyBiUgD
         xAtyxzhaeQDPHjQ1CW/8mEJosbwur5WxjrLMkqrRQCoqVcuijX9RD5FLAQ1i1XwVtrxv
         5ggxvDgjG+y4yhhupwFLTVFSqQ+lWUU9x7V3gVG0+wYCEJUWxCrMBpwBnirU6Y2SsGcU
         o/vUtqvNvCnn3fIISRHp846G2MRwte53AVqkBP/WFGx0NRrrm5y5fXMuZYynobKu/tqq
         F3wA==
X-Gm-Message-State: AO0yUKWzf4HeghoVDk5ff9zEd7aGQD9BzfpiBrwqBQbmzkJLqyAIwZmC
        Y9IlWEnx79teADUGOOAgWX8vOg==
X-Google-Smtp-Source: AK7set9amC5pThCDH+9E/vyf4TogzP4SRLeuHMPo01KOUugOmYukuiSJFsLqp102YzKiW0olzQcJrQ==
X-Received: by 2002:a05:6402:22a7:b0:4a2:2d79:dce2 with SMTP id cx7-20020a05640222a700b004a22d79dce2mr7371719edb.10.1675367453255;
        Thu, 02 Feb 2023 11:50:53 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id er18-20020a056402449200b0046892e493dcsm150837edb.26.2023.02.02.11.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 11:50:52 -0800 (PST)
Message-ID: <093a50dc-8f9e-39c9-ba31-906628e54e35@linaro.org>
Date:   Thu, 2 Feb 2023 21:50:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 11/12] arm64: dts: qcom: sm8550: Add PCIe PHYs and
 controllers nodes
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20230202123902.3831491-1-abel.vesa@linaro.org>
 <20230202123902.3831491-12-abel.vesa@linaro.org>
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230202123902.3831491-12-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 02/02/2023 14:39, Abel Vesa wrote:
> Add PCIe controllers and PHY nodes.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> This patch does not have a v3, but since it is now part of the same
> patchset with the controller and the phy drivers patches, I had to
> bump the version to 4.
> 
> The v5 was here:
> https://lore.kernel.org/all/20230124124714.3087948-12-abel.vesa@linaro.org/
> 
> Changes since v5:
>   * renamed nocsr_com to phy_nocsr as discussed off-list with Bjorn and Johan
> 
> Changes since v4:
>   * renamed noc_aggr_4 back to noc_aggr
>   * moved pinctrl properties out to MTP dts
>   * renamed nocsr to nocsr_com
> 
> Changes since v2:
>   * renamed the pcie_1_link_down_reset to simply link_down
>   * dropped the pipe from clock-names
>   * renamed aggre clock-names to noc_aggr_4
>   * dropped the _pcie infix from cnoc_pcie_sf_axi
>   * dropped the aux_phy clock from the pcie1
>   
> Changes since v1:
>   * ordered pcie related nodes alphabetically in MTP dts
>   * dropped the pipe_mux, phy_pipe and ref clocks from the pcie nodes
>   * dropped the child node from the phy nodes, like Johan suggested,
>     and updated to use the sc8280xp binding scheme
>   * changed "pcie_1_nocsr_com_phy_reset" 2nd reset name of pcie1_phy
>     to "nocsr"
>   * reordered all pcie nodes properties to look similar to the ones
>     from sc8280xp
> 
> 
>   arch/arm64/boot/dts/qcom/sm8550.dtsi | 203 ++++++++++++++++++++++++++-
>   1 file changed, 200 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index be2d85ee1f20..a85d2ae7d155 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -740,9 +740,9 @@ gcc: clock-controller@100000 {
>   			#reset-cells = <1>;
>   			#power-domain-cells = <1>;
>   			clocks = <&bi_tcxo_div2>, <&sleep_clk>,
> -				 <0>,
> -				 <0>,
> -				 <0>,
> +				 <&pcie0_phy>,
> +				 <&pcie1_phy>,
> +				 <&pcie_1_phy_aux_clk>,
>   				 <&ufs_mem_phy 0>,
>   				 <&ufs_mem_phy 1>,
>   				 <&ufs_mem_phy 2>,
> @@ -1641,6 +1641,203 @@ mmss_noc: interconnect@1780000 {
>   			qcom,bcm-voters = <&apps_bcm_voter>;
>   		};
>   
> +		pcie0: pci@1c00000 {
> +			device_type = "pci";
> +			compatible = "qcom,pcie-sm8550";
> +			reg = <0 0x01c00000 0 0x3000>,
> +			      <0 0x60000000 0 0xf1d>,
> +			      <0 0x60000f20 0 0xa8>,
> +			      <0 0x60001000 0 0x1000>,
> +			      <0 0x60100000 0 0x100000>;
> +			reg-names = "parf", "dbi", "elbi", "atu", "config";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			ranges = <0x01000000 0x0 0x60200000 0 0x60200000 0x0 0x100000>,
> +				 <0x02000000 0x0 0x60300000 0 0x60300000 0x0 0x3d00000>;
> +			bus-range = <0x00 0xff>;
> +
> +			dma-coherent;
> +
> +			linux,pci-domain = <0>;
> +			num-lanes = <2>;
> +
> +			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi";
> +
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> +					<0 0 0 2 &intc 0 0 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> +					<0 0 0 3 &intc 0 0 0 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
> +					<0 0 0 4 &intc 0 0 0 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
> +
> +			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
> +				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
> +				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
> +				 <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
> +				 <&gcc GCC_DDRSS_PCIE_SF_QTB_CLK>,
> +				 <&gcc GCC_AGGRE_NOC_PCIE_AXI_CLK>;
> +			clock-names = "aux",
> +				      "cfg",
> +				      "bus_master",
> +				      "bus_slave",
> +				      "slave_q2a",
> +				      "ddrss_sf_tbu",
> +				      "noc_aggr";
> +
> +			interconnects = <&pcie_noc MASTER_PCIE_0 0 &mc_virt SLAVE_EBI1 0>,
> +					<&gem_noc MASTER_APPSS_PROC 0 &cnoc_main SLAVE_PCIE_0 0>;
> +			interconnect-names = "pcie-mem", "cpu-pcie";
> +
> +			iommus = <&apps_smmu 0x1400 0x7f>;
> +			iommu-map = <0x0   &apps_smmu 0x1400 0x1>,
> +				    <0x100 &apps_smmu 0x1401 0x1>;
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

As we have moved pinctrl to board files, it would be logical to also 
move these gpios to the board file too. Following the same logic, each 
board can use it's own set of perst/wake gpios for PCIe.

> +
> +			status = "disabled";
> +		};
> +
[skipped the rest]

-- 
With best wishes
Dmitry

