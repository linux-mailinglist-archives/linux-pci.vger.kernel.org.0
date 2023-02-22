Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AA369F897
	for <lists+linux-pci@lfdr.de>; Wed, 22 Feb 2023 17:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjBVQEz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Feb 2023 11:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjBVQEx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Feb 2023 11:04:53 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671E92D15B
        for <linux-pci@vger.kernel.org>; Wed, 22 Feb 2023 08:04:48 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id x24so10788657lfr.1
        for <linux-pci@vger.kernel.org>; Wed, 22 Feb 2023 08:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BvtXsgYaNMgfCwPa3NcjCA/fALryuRunmE0yTYigCgo=;
        b=qoW4bUeWwS3k/GeJaiLUn+XPhE41MVVyIyPtGkL2v5O83xBjix2Li2DkYmR1Ku3+V0
         6pZ4CHdTYNIxyAV4MxYwmrCKG9yvLX2uPBgEmz/EEpWva9Gngw36j5MLkX50UAG/phaV
         orIrc8mVF8QtEI7vBIROBOQwHU/l/0938GUTpX20WIXFLnhwl2ujow0uJkBomUFAEhT6
         aqIWpsGuUQMRZlKET39VjpzeuREyMxAHynJFxpMPW0v1wLFqI2/+z+GpqNVZz230UXIU
         8p3fyxSTQNKRsUniIGrRo2fm1meAtoCveeLqYAi1UGsKO8RZgbB/pUYO9AS9+jqN9npv
         n3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BvtXsgYaNMgfCwPa3NcjCA/fALryuRunmE0yTYigCgo=;
        b=eZj6If0f/YBiU5BBqPYlnd9n7qU8QVkdpeGV7rfZK4JLX3zL8oNYPyIDPB/zfA0zbo
         +a8wu8pMTGDBpwt3xkEBRs4NDoUOk0nPh3PCWfnphMWewR2HZ9+auBJcd4GPgvk9zM8u
         Myz95tIH+IcS7ZdalxuOj3aFooV1fZq3VVafPNx3qk5pXMfis7dhPr8lMJh00uiryEo5
         rov0zSEU0cgfbJe83Yu/wB5AsLRjYRUliRwOZVoit/FwahBFpQeWMy07uhHAB7eAhLky
         Dd22REOSX5d0RkMv5fGTQadrP5f/9PX9VBbOjpOk5f7xCt//NZpE8elD7WLZqC8TQMUo
         VXHg==
X-Gm-Message-State: AO0yUKVjJuqp/5kSzHeQFCdRf8UAG/8bl/FT7lOdu8tMz68fjsS7/rSq
        hLA1l0KAUnpTL/oq1dp/YHM5pw==
X-Google-Smtp-Source: AK7set9PDpRvUR4ICYarWP/6Zlh9mGyGPgoNTdoaMGmA0Ed4tTtpS9C8shCpz0IFX+FNFdEYYwfy+w==
X-Received: by 2002:a19:f609:0:b0:4b5:b06d:4300 with SMTP id x9-20020a19f609000000b004b5b06d4300mr2917956lfe.29.1677081886617;
        Wed, 22 Feb 2023 08:04:46 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id f14-20020ac251ae000000b004db3eff4b12sm2203398lfk.171.2023.02.22.08.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 08:04:46 -0800 (PST)
Message-ID: <ac05fec4-138c-2f1e-a953-8d498d3bb598@linaro.org>
Date:   Wed, 22 Feb 2023 17:04:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 08/11] ARM: dts: qcom: sdx55-t55: Enable PCIe RC support
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org
Cc:     bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230222153251.254492-1-manivannan.sadhasivam@linaro.org>
 <20230222153251.254492-9-manivannan.sadhasivam@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230222153251.254492-9-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
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



On 22.02.2023 16:32, Manivannan Sadhasivam wrote:
> Enable PCIe RC support on Thundercomm T55 board.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-sdx55-t55.dts | 42 ++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx55-t55.dts b/arch/arm/boot/dts/qcom-sdx55-t55.dts
> index 7ed8feb99afb..fb5b9264077c 100644
> --- a/arch/arm/boot/dts/qcom-sdx55-t55.dts
> +++ b/arch/arm/boot/dts/qcom-sdx55-t55.dts
> @@ -242,6 +242,23 @@ &ipa {
>  	memory-region = <&ipa_fw_mem>;
>  };
>  
> +&pcie_phy {
> +	status = "okay";
'status' should go last. Since you're introducing new nodes,
changing the order in the existing ones would be appreciated.

> +
> +	vdda-phy-supply = <&vreg_l1e_bb_1p2>;
> +	vdda-pll-supply = <&vreg_l4e_bb_0p875>;
> +};
> +
> +&pcie_rc {
> +	status = "okay";
> +
> +	perst-gpios = <&tlmm 57 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 53 GPIO_ACTIVE_HIGH>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie_default>;
property-
property-names

Konrad
> +};
> +
>  &qpic_bam {
>  	status = "ok";
>  };
> @@ -265,6 +282,31 @@ &remoteproc_mpss {
>  	memory-region = <&mpss_adsp_mem>;
>  };
>  
> +&tlmm {
> +	pcie_default: pcie-default-state {
> +		clkreq-pins {
> +			pins = "gpio56";
> +			function = "pcie_clkreq";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		perst-pins {
> +			pins = "gpio57";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-down;
> +		};
> +
> +		wake-pins {
> +		       pins = "gpio53";
> +		       function = "gpio";
> +		       drive-strength = <2>;
> +		       bias-pull-up;
> +	       };
> +	};
> +};
> +
>  &usb_hsphy {
>  	status = "okay";
>  	vdda-pll-supply = <&vreg_l4e_bb_0p875>;
