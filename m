Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFA36B5C6E
	for <lists+linux-pci@lfdr.de>; Sat, 11 Mar 2023 14:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjCKNvL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Mar 2023 08:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjCKNvK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Mar 2023 08:51:10 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAFD119414
        for <linux-pci@vger.kernel.org>; Sat, 11 Mar 2023 05:51:07 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id j11so10195809lfg.13
        for <linux-pci@vger.kernel.org>; Sat, 11 Mar 2023 05:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678542666;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GIwch7Miap3ZpzUTENBikKrtQkwLURN+uydaKxcQtAE=;
        b=Ck/A/9TXTOrkq4anf9TQfZ2MhVvXOHvmRcfq6QhsRwKmeiE4QqJhb9hjlPaBDUPjKr
         1LqIQkeLRR36GbkjoMF8PomEA3sji7r8dRTfLt6XH7F0w9DsSM+UwOo6VxaThq5wqgpt
         3Ala6jXdvRIC6sHkpYJ6lWXhOJhwQoxzLW1Z1yr/AQfiTbpudj69C5sTrEB5Lqjnc3ao
         87jBxS4vHU8SrjnTmh/SfsnKBMbIwOWNwLFe/clhKlFb4xUzkyF73ra/LKMM1mS50TaP
         9YB2uBd3wK7OZQZb3kvku8vVHjytgMV0Leq1nAPip2ZpsAxebvLDHpe105B4qCDm38Z7
         AgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678542666;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GIwch7Miap3ZpzUTENBikKrtQkwLURN+uydaKxcQtAE=;
        b=TujJ0lA3B31zDVBuIRLmSJDtgaHI3Pq5tJj+QJX36UnAoPosOQbKbJrc8CAbt/gs2g
         WZAnmFnx5qWsnmy/8arSycYuTZkP4gwoXPxZxwq0iBzoDuJl+bMBJ7omxnw3AwTnR+NG
         1JpqdAPFjySC4h3dDgQLsk9uB0PIchAYEQRecExmHWGDPVYFVvq7H3x6OslGDlk5P4IX
         FGnTT/bn2NzXSmM9pLWoEB9cRr0QIIVAfhYDYmAspNMWzJwYcA0JdyTzgqGeca7ZTkI8
         h3BxSOqq11OkFnG+TQ5ub5dhzjwWX9Bfq+cbsaYQRyOfdCMTtrXvxjbeiSlLPeH9zB99
         yKEQ==
X-Gm-Message-State: AO0yUKXmhXuopbaYAT0auncreEzMOsllB7qImTU67dcLybhy3ij7FI8p
        BqIZ5u5+C/K7m6+PK9GetrarZA==
X-Google-Smtp-Source: AK7set9gHSZZob01NbbxcHnRnuK4XtOwbzm9Re1k9uemBs2OIo+U4lCb8DW/iVl2p87cnISK9jDTqQ==
X-Received: by 2002:a19:a403:0:b0:4dd:98bd:411a with SMTP id q3-20020a19a403000000b004dd98bd411amr8197662lfc.51.1678542665803;
        Sat, 11 Mar 2023 05:51:05 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id b24-20020ac24118000000b004db250355a2sm326241lfi.103.2023.03.11.05.51.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 05:51:05 -0800 (PST)
Message-ID: <0992b315-2e52-46f4-01c4-b8e458cfe7f6@linaro.org>
Date:   Sat, 11 Mar 2023 15:51:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 4/6] ARM: dts: qcom: sdx65: Add support for PCIe EP
Content-Language: en-GB
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, lee@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mani@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        bhelgaas@google.com, manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <1678277993-18836-1-git-send-email-quic_rohiagar@quicinc.com>
 <1678277993-18836-5-git-send-email-quic_rohiagar@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1678277993-18836-5-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 08/03/2023 14:19, Rohit Agarwal wrote:
> Add support for PCIe Endpoint controller on the
> Qualcomm SDX65 platform.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>   arch/arm/boot/dts/qcom-sdx65.dtsi | 59 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 59 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
> index df9d428..5ea6a5a 100644
> --- a/arch/arm/boot/dts/qcom-sdx65.dtsi
> +++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
> @@ -11,6 +11,7 @@
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/power/qcom-rpmpd.h>
>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +#include <dt-bindings/gpio/gpio.h>
>   
>   / {
>   	#address-cells = <1>;
> @@ -293,6 +294,59 @@
>   			status = "disabled";
>   		};
>   
> +		pcie_ep: pcie-ep@1c00000 {
> +			compatible = "qcom,sdx65-pcie-ep", "qcom,sdx55-pcie-ep";
> +			reg = <0x01c00000 0x3000>,
> +			      <0x40000000 0xf1d>,
> +			      <0x40000f20 0xa8>,
> +			      <0x40001000 0x1000>,
> +			      <0x40200000 0x100000>,
> +			      <0x01c03000 0x3000>;
> +			reg-names = "parf",
> +				    "dbi",
> +				    "elbi",
> +				    "atu",
> +				    "addr_space",
> +				    "mmio";
> +
> +			qcom,perst-regs = <&tcsr 0xb258 0xb270>;
> +
> +			clocks = <&gcc GCC_PCIE_AUX_CLK>,
> +				 <&gcc GCC_PCIE_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_MSTR_AXI_CLK>,
> +				 <&gcc GCC_PCIE_SLV_AXI_CLK>,
> +				 <&gcc GCC_PCIE_SLV_Q2A_AXI_CLK>,
> +				 <&gcc GCC_PCIE_SLEEP_CLK>,
> +				 <&gcc GCC_PCIE_0_CLKREF_EN>;
> +			clock-names = "aux",
> +				      "cfg",
> +				      "bus_master",
> +				      "bus_slave",
> +				      "slave_q2a",
> +				      "sleep",
> +				      "ref";
> +
> +			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "global", "doorbell";
> +
> +			reset-gpios = <&tlmm 57 GPIO_ACTIVE_LOW>;
> +			wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;

-gpios should go to the board file too.

> +
> +			resets = <&gcc GCC_PCIE_BCR>;
> +			reset-names = "core";
> +
> +			power-domains = <&gcc PCIE_GDSC>;
> +
> +			phys = <&pcie_phy>;
> +			phy-names = "pcie-phy";
> +
> +			max-link-speed = <3>;
> +			num-lanes = <2>;
> +
> +			status = "disabled";
> +		};
> +
>   		pcie_phy: phy@1c06000 {
>   			compatible = "qcom,sdx65-qmp-gen4x2-pcie-phy";
>   			reg = <0x01c06000 0x2000>;
> @@ -332,6 +386,11 @@
>   			#hwlock-cells = <1>;
>   		};
>   
> +		tcsr: syscon@1fcb000 {
> +			compatible = "qcom,sdx65-tcsr", "syscon";
> +			reg = <0x01fc0000 0x1000>;
> +		};
> +
>   		remoteproc_mpss: remoteproc@4080000 {
>   			compatible = "qcom,sdx55-mpss-pas";
>   			reg = <0x04080000 0x4040>;

-- 
With best wishes
Dmitry

