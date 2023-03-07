Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02876AD926
	for <lists+linux-pci@lfdr.de>; Tue,  7 Mar 2023 09:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjCGIVS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Mar 2023 03:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjCGIUz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Mar 2023 03:20:55 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FF252F44
        for <linux-pci@vger.kernel.org>; Tue,  7 Mar 2023 00:20:26 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id g3so49133513eda.1
        for <linux-pci@vger.kernel.org>; Tue, 07 Mar 2023 00:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678177225;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4bBbMIO52bX8nLA3I9RO9BGA5L/h4IrDmKoZAMdQou0=;
        b=SFXKtozJdDUk4x2ISKLmDv+b9wGwbGMJmaxKqfeHAbrs88w+D7J25EhyHoMd2xoCgt
         SstTFgl1z2pVWnUDpIqBA3nvdMe2HfzlUk+o5fyByolJi12PBMTPOGLViEi3IC+wZ2J0
         qnsXn8yJav3eGTmeH4EUKKJsC/EdV9XS82GoZsx8Ud+rxBLd9LNnl3hXFjEMs53IiIuC
         ScpKZ47SapZcoZDwuS+iASA2u5o/7E/M6N7wxMgkhIQM2Kh7T4aJa6tFfXbjeTGgjPiw
         LtseF2CI4Z5dIZoc78QIdD4cKteJi0zeIqkiFW+Sr4YeP3mIedS4VnBQV3peMCNh8Ely
         g1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678177225;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4bBbMIO52bX8nLA3I9RO9BGA5L/h4IrDmKoZAMdQou0=;
        b=ImOO6hyP0iOjH9eOqQxcV+RKWAdvzb5MeKVfZV00RHdCwgYKa3/ZN3fSbRZbgbmdKI
         YgARYEu8DZk0pP2smGk0Ay4AD1+X7PBVC+VQkp4QIzmTh/4UaJeEnktpW07JtnxGBalV
         zZzeqDkgpUuN7mg1osWvdgQZFzNA5oxcqdNfLe0QKtreblmRNCrSHFgXcyyCQSdAfe8m
         oWIY9EBwwGVyVY4tttHSlVtV+bguGhHKlv5LSPrT6/0hJMB4FQhN/KCCUkOvVvfHKcgh
         3PcEo/Ytlv/kUcV1+e1kPPbHhN6yY097q+hjNrRiEC1Gt9tYOBDi9W+opsV3cZE6V9SW
         N4Vg==
X-Gm-Message-State: AO0yUKXp+liT8CNMqDH+4f7HVp9SPM52TmjeFHty+9heE3F5fIJpg7GR
        nCDz4sFN+uwJ3GlGmM1imYuKgA==
X-Google-Smtp-Source: AK7set+Lndiph5rP0jDSlwKu9kKCS0MqGFZPqqrr9CUWlCqqr/hZdRmLdppeqacwAvCmG+Fi2iW+dA==
X-Received: by 2002:a17:907:6092:b0:872:6bd0:d2b with SMTP id ht18-20020a170907609200b008726bd00d2bmr16709606ejc.45.1678177224834;
        Tue, 07 Mar 2023 00:20:24 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:5310:35c7:6f9e:2cd3? ([2a02:810d:15c0:828:5310:35c7:6f9e:2cd3])
        by smtp.gmail.com with ESMTPSA id q8-20020a170906940800b008eb89a435c9sm5652005ejx.164.2023.03.07.00.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 00:20:24 -0800 (PST)
Message-ID: <1587de60-244a-d97f-dea0-36fe8a5be2c2@linaro.org>
Date:   Tue, 7 Mar 2023 09:20:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 16/19] arm64: dts: qcom: sdm845: Add "mhi" region to the
 PCIe nodes
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com
References: <20230306153222.157667-1-manivannan.sadhasivam@linaro.org>
 <20230306153222.157667-17-manivannan.sadhasivam@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230306153222.157667-17-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
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

On 06/03/2023 16:32, Manivannan Sadhasivam wrote:
> The "mhi" region contains the debug registers that could be used to monitor
> the PCIe link transitions.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 479859bd8ab3..0104e77dd8d5 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -2280,10 +2280,11 @@ opp-4 {
>  		pcie0: pci@1c00000 {
>  			compatible = "qcom,pcie-sdm845";
>  			reg = <0 0x01c00000 0 0x2000>,
> +			      <0 0x01c07000 0 0x1000>,
>  			      <0 0x60000000 0 0xf1d>,
>  			      <0 0x60000f20 0 0xa8>,
>  			      <0 0x60100000 0 0x100000>;
> -			reg-names = "parf", "dbi", "elbi", "config";
> +			reg-names = "parf", "mhi", "dbi", "elbi", "config";

Indexes are fixed, thus this breaks other users of DTS.

Best regards,
Krzysztof

