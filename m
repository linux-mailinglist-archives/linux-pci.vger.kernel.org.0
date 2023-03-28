Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CD66CC0C3
	for <lists+linux-pci@lfdr.de>; Tue, 28 Mar 2023 15:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjC1N3H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Mar 2023 09:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjC1N3G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Mar 2023 09:29:06 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC6CA273
        for <linux-pci@vger.kernel.org>; Tue, 28 Mar 2023 06:29:04 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id s20so12569516ljp.1
        for <linux-pci@vger.kernel.org>; Tue, 28 Mar 2023 06:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680010142;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AYY5Dr1Z1I9hb8CrXHC9U6DlzlFB2ypBISlRnxmPY3I=;
        b=LSUtWT/AWGybRwLerH/91aATgi4rurZprloou1LoGbGck955eT2qPbsBESu3GGovM1
         Ef82KFLSrfncXdZPa+HO0VHz6/FWeQDOYPZtXTBvOcftd29V/kbshbm89jeOhdgNv72z
         tIBltFQthZyxbP6DnlXHUCQvj7zsXrtmWMZmNso1w1Vz49P7zG/ASg7HQ7r4ifogj/ws
         eRl3o9x5JWVcUPqx5/Wt8dKS6a6guAPmnjP/QFyjmsxcN542w9RqBqdCOFTBbSRGNeMg
         tJ/FR4tWEHOoOd6iME5heju7i64W4GuYfqI6w2KVY5O6997+lc7nztRn7DyHHjQcYCvg
         3g2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680010142;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AYY5Dr1Z1I9hb8CrXHC9U6DlzlFB2ypBISlRnxmPY3I=;
        b=j12YlpY+U9km+8iwqXVKSapab6IZ9CTWlVVrzOTy8XLBdQroPGlM3REJvzT5LBPV7V
         ISToh9eGy6IfGbfdPlLCwN37OPIjEOFGysqF5r4Ft2744LNpaTBMDMJoQMrWFwf4czHD
         JR7+nm19I4f28wk54RTyrBhrE2n4hMOuCO2ynbamO6fHKeGqVJZ3RRLmYPiFmlfF2zf+
         khpWe11dOdpr7GawaeuGFwBoysmo6UmFIm1w4nLXT8GZq1lmkOX4fIHQuqwRIwRfgQE5
         Wm7Fy6xRFXA2EEfE6heNMiVQReMbSTP61WkB0htDQW6wz5vkpxk8dg7vm6EE6bpR7lXf
         Cjxg==
X-Gm-Message-State: AAQBX9dlsbFg0golGbWOz52JDMnmJCqv6ULzcSMh4f9tI2bKdE0EcQfC
        dAm5YCPgulrGRebmzrrC1J6xew==
X-Google-Smtp-Source: AKy350YAExXR6RZ2krFV7pgEcgdlDZBlWD13Eq4CYLuYxlMIcsU/t+DkcS1rzXhKdXibAB8k4462cA==
X-Received: by 2002:a2e:9a8e:0:b0:2a0:7d07:edba with SMTP id p14-20020a2e9a8e000000b002a07d07edbamr5228469lji.43.1680010142574;
        Tue, 28 Mar 2023 06:29:02 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id n12-20020a2e904c000000b00299f0194108sm5049811ljg.31.2023.03.28.06.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 06:29:02 -0700 (PDT)
Message-ID: <76c5b46c-82d6-847c-aaca-7380d310d012@linaro.org>
Date:   Tue, 28 Mar 2023 15:29:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 2/5] ARM: dts: qcom: sdx65: Add support for PCIe PHY
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <1679036039-27157-1-git-send-email-quic_rohiagar@quicinc.com>
 <1679036039-27157-3-git-send-email-quic_rohiagar@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1679036039-27157-3-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 17.03.2023 07:53, Rohit Agarwal wrote:
> Add devicetree support for PCIe PHY used in SDX65 platform. This PHY is
> used by the PCIe EP controller.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom-sdx65.dtsi | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
> index 192f9f9..084daf8 100644
> --- a/arch/arm/boot/dts/qcom-sdx65.dtsi
> +++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
> @@ -293,6 +293,37 @@
>  			status = "disabled";
>  		};
>  
> +		pcie_phy: phy@1c06000 {
> +			compatible = "qcom,sdx65-qmp-gen4x2-pcie-phy";
> +			reg = <0x01c06000 0x2000>;
> +
> +			clocks = <&gcc GCC_PCIE_AUX_PHY_CLK_SRC>,
> +				 <&gcc GCC_PCIE_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_0_CLKREF_EN>,
> +				 <&gcc GCC_PCIE_RCHNG_PHY_CLK>,
> +				 <&gcc GCC_PCIE_PIPE_CLK>;
> +			clock-names = "aux",
> +				      "cfg_ahb",
> +				      "ref",
> +				      "rchng",
> +				      "pipe";
> +
> +			resets = <&gcc GCC_PCIE_PHY_BCR>;
> +			reset-names = "phy";
> +
> +			assigned-clocks = <&gcc GCC_PCIE_RCHNG_PHY_CLK>;
> +			assigned-clock-rates = <100000000>;
> +
> +			power-domains = <&gcc PCIE_GDSC>;
> +
> +			#clock-cells = <0>;
> +			clock-output-names = "pcie_pipe_clk";
> +
> +			#phy-cells = <0>;
> +
> +			status = "disabled";
> +		};
> +
>  		tcsr_mutex: hwlock@1f40000 {
>  			compatible = "qcom,tcsr-mutex";
>  			reg = <0x01f40000 0x40000>;
