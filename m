Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1786ABCF8
	for <lists+linux-pci@lfdr.de>; Mon,  6 Mar 2023 11:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjCFKeh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Mar 2023 05:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjCFKeZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Mar 2023 05:34:25 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9198F2D5E
        for <linux-pci@vger.kernel.org>; Mon,  6 Mar 2023 02:33:54 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id d36so8896719lfv.8
        for <linux-pci@vger.kernel.org>; Mon, 06 Mar 2023 02:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678098831;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fmNRtS1CEm/uDJzkZ1f0BSKkMD9Q2wcT/CCsCEbkRXo=;
        b=vpkphbcn8JxWHostX65DzWcaioJMJjJxtqgqUmN+BfoPj/JO3H6Af9oldV3ww5LSx9
         nPmPI/kGHLbB6Zaq2mYY1uMpkypiSDMBEtK1w47b0LLlW/VO3G4/aLHfiEZOM9EZimUg
         CAWorAbKBcwAMZqXJk9AekHjHBh4jbPVfams4KJt6BOjW74GYEeBNv0TEfWAKes6D5oc
         jZzcKH3P+x+9m1C6mFU6GQC3RnNL7KR5yJI60b10NUzyuq51AromlCw8tQYH1TRDXimj
         Q9d3aEqQ1hyJE1q4a0vSl7R3ax3Ee7n0jtqawZcOqekvBqXzgURqdIHqLEPBwRG0+Sg5
         Y2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678098831;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fmNRtS1CEm/uDJzkZ1f0BSKkMD9Q2wcT/CCsCEbkRXo=;
        b=UHZ4VFuILRN1trDwEYc6lfzuw/4wBx37Q+SOB84MqMdwbbPUxORe6m/DVEovdmuKB1
         foT5LUjzziVAnsXWixuwI5aaro+mQIPvQvUWfqRxONvgc0USawPTAhpE//9oo23Avx2q
         E8RjWiclqv9nb7BghAbhrI1XAfWemM5Ps8vza9XEGdhGaxXXJW8/FT9Q9z1F5BxzdDlG
         Xxv5aMpzGxFQzjGdZIa0VFba9bVceK4+FSI+zCcQniDMzS8+W7BMeIjryRiLYs0lbv7u
         rl/LupHlduty7/+JqQAhH5mtASN8n/hLOR0A8GyHs5Jy6zWQutRnHLajlRx7wjNnILYv
         EM9g==
X-Gm-Message-State: AO0yUKUGBXrHhX5GvJJbzdBnparWOHZY+YAc7AeSPBJI5Kq0himu/Gix
        3GwUgQpSx5TC74ctpuieOKCAcQ==
X-Google-Smtp-Source: AK7set8J/UC3DP97b37EjZFmtBAby/nDZ357HvRL72wE8lshsG+rWFJfF0d/XlxV/i2Iv+S1t1+AsQ==
X-Received: by 2002:a19:ae13:0:b0:4e1:13fa:bf07 with SMTP id f19-20020a19ae13000000b004e113fabf07mr2975436lfc.43.1678098831607;
        Mon, 06 Mar 2023 02:33:51 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id q15-20020a2e968f000000b00295b2e08b90sm1610795lji.65.2023.03.06.02.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 02:33:51 -0800 (PST)
Message-ID: <a68fa63d-9d1d-d295-02a4-6f5405ae1d7c@linaro.org>
Date:   Mon, 6 Mar 2023 11:33:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 4/6] ARM: dts: qcom: sdx65: Add support for PCIe EP
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <1678080302-29691-1-git-send-email-quic_rohiagar@quicinc.com>
 <1678080302-29691-5-git-send-email-quic_rohiagar@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1678080302-29691-5-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6.03.2023 06:25, Rohit Agarwal wrote:
> Add support for PCIe Endpoint controller on the Qualcomm SDX65 platform.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  arch/arm/boot/dts/qcom-sdx65.dtsi | 44 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
> index 246290d..93ea94e 100644
> --- a/arch/arm/boot/dts/qcom-sdx65.dtsi
> +++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
> @@ -11,6 +11,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +#include <dt-bindings/gpio/gpio.h>
>  
>  / {
>  	#address-cells = <1>;
> @@ -292,6 +293,44 @@
>  			status = "disabled";
>  		};
>  
> +		pcie_ep: pcie-ep@1c00000 {
> +			compatible = "qcom,sdx65-pcie-ep", "qcom,sdx55-pcie-ep";
> +			reg = <0x01c00000 0x3000>,
> +				  <0x40000000 0xf1d>,
> +				  <0x40000f20 0xa8>,
> +				  <0x40001000 0x1000>,
> +				  <0x40200000 0x100000>,
> +				  <0x01c03000 0x3000>;
The indentation here seems incorrect. The kernel uses 8-wide tabs.

> +			reg-names = "parf", "dbi", "elbi", "atu", "addr_space",
> +						"mmio";
Please turn this into a vertical list, like this:

"parf",
"dbi",
...

> +
> +			qcom,perst-regs = <&tcsr 0xb258 0xb270>;
> +
> +			clocks = <&gcc GCC_PCIE_AUX_CLK>,
> +					 <&gcc GCC_PCIE_CFG_AHB_CLK>,
> +					 <&gcc GCC_PCIE_MSTR_AXI_CLK>,
> +					 <&gcc GCC_PCIE_SLV_AXI_CLK>,
> +					 <&gcc GCC_PCIE_SLV_Q2A_AXI_CLK>,
> +					 <&gcc GCC_PCIE_SLEEP_CLK>,
> +					 <&gcc GCC_PCIE_0_CLKREF_EN>;
The indentation here seems incorrect.

> +			clock-names = "aux", "cfg", "bus_master", "bus_slave",
> +							"slave_q2a", "sleep", "ref";
Please turn this into a vertical list too.

> +
> +			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
> +						 <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
The indentation seems off here.

Konrad
> +			interrupt-names = "global", "doorbell";
> +			reset-gpios = <&tlmm 57 GPIO_ACTIVE_LOW>;
> +			wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
> +			resets = <&gcc GCC_PCIE_BCR>;
> +			reset-names = "core";
> +			power-domains = <&gcc PCIE_GDSC>;
> +			phys = <&pcie0_lane>;
> +			phy-names = "pciephy";
> +			max-link-speed = <3>;
> +			num-lanes = <2>;
> +			status = "disabled";
> +		};
> +
>  		pcie0_phy: phy@1c07000 {
>  			compatible = "qcom,sdx65-qmp-pcie-phy";
>  			reg = <0x01c07000 0x1e4>;
> @@ -330,6 +369,11 @@
>  			#hwlock-cells = <1>;
>  		};
>  
> +		tcsr: syscon@1fcb000 {
> +			compatible = "qcom,sdx65-tcsr", "syscon";
> +			reg = <0x01fc0000 0x1000>;
> +		};
> +
>  		remoteproc_mpss: remoteproc@4080000 {
>  			compatible = "qcom,sdx55-mpss-pas";
>  			reg = <0x04080000 0x4040>;
