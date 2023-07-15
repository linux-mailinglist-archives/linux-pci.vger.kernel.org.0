Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733DC754994
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jul 2023 17:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjGOPH1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 Jul 2023 11:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjGOPHZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 Jul 2023 11:07:25 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921B02D55
        for <linux-pci@vger.kernel.org>; Sat, 15 Jul 2023 08:07:23 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fb73ba3b5dso4927892e87.1
        for <linux-pci@vger.kernel.org>; Sat, 15 Jul 2023 08:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689433642; x=1692025642;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xkOpwxRcm9wnvjjMeHH63MElVKORIFg8V3PvPIN4+FQ=;
        b=q3S4nAweIAIqBX3UCE3W9+G6fsBQr2Jy14ORD9rk5BMj1+4l7zoxQRTPdNx8dxNvD/
         awkqxDJPPf+tU7iCWqgSNcdbg5gZPPLSNWM7zFHSQPoQHod4PJ+gq4/vZDIlR++TjKLz
         cQhR9Bl5OVhY2lEOQqi4w+fIv62jbV139cJeOo0n8nEwcVOC7C95jXtQ7ND25RoGPsuc
         KHDnO6fzYwQVhNnb8JDYRaDrKKNR0MdYIWGosD5oSha7ckidtuwVYlFaTJCJ4oLqe1C1
         03ukeYYSWr8/ANF76vFUmo1ZxNk0ToKRZnlrh1BlGhJKM8o/olD+PZ9fFOWe2DtwISZ7
         HEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689433642; x=1692025642;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xkOpwxRcm9wnvjjMeHH63MElVKORIFg8V3PvPIN4+FQ=;
        b=GJVQRrJT2Binlwo3r+mpXQ1o6+QHiNJQhaiPTqqyCGphQYMozbYLwA/k72+7NK23CJ
         SaeFgs+WcoWSx6ps7YNkxZgAGHmVTIUzzp2RXaiS6Co+CFNzzOVL5pCvx665tlWhiyNF
         dSRDxO+H7lX7kHX9Mlkgw3GwDNyfOtuN2ZLTtuZ47pbs29Rec9FmQRV1ycIP9F0Q3tqu
         MlmwylYUbDX9FC99IvUybSholVtr/ZicfbBXD3WxD/DA0XHt59R/VY1ROKZenyLIw5Cw
         UroweLwMbUTLRuCD+FmGHKwC4seEknY+ZQFdQx8Xq+b+OGptaNTp0QqSR8Snm3XbCDAz
         e7dg==
X-Gm-Message-State: ABy/qLbBmH0/rB67a000v9I8nqT3kAnGNjjsn6vT8VuI5d5zznliOVGl
        sDsuQ5yd8kLkYbWVi/Dkhboacg==
X-Google-Smtp-Source: APBJJlG8uHoxC1G7YvnpgyKuAWwWf20KZoG2BxQMCCyyWDFXN7G/aW4RZetgAfCGX//nb6YbZhgvxA==
X-Received: by 2002:a19:2d42:0:b0:4f8:4512:c846 with SMTP id t2-20020a192d42000000b004f84512c846mr4871339lft.49.1689433641793;
        Sat, 15 Jul 2023 08:07:21 -0700 (PDT)
Received: from [192.168.1.101] (abxi167.neoplus.adsl.tpnet.pl. [83.9.2.167])
        by smtp.gmail.com with ESMTPSA id q2-20020a19a402000000b004fce9e8c390sm507097lfc.63.2023.07.15.08.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jul 2023 08:07:21 -0700 (PDT)
Message-ID: <19ad986d-7121-7b2b-40e6-5046917d5dfc@linaro.org>
Date:   Sat, 15 Jul 2023 17:07:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 2/3] arm: dts: qcom: sdx65: Add PCIe interconnect path
Content-Language: en-US
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        manivannan.sadhasivam@linaro.org
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        krzysztof.kozlowski@linaro.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <1689247213-13569-1-git-send-email-quic_krichai@quicinc.com>
 <1689247213-13569-3-git-send-email-quic_krichai@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1689247213-13569-3-git-send-email-quic_krichai@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 13.07.2023 13:20, Krishna chaitanya chundru wrote:
> Add pcie-mem interconnect path to sdx65 platform.
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
No CPU - SLAVE_PCIE_0?

Konrad
>  arch/arm/boot/dts/qcom/qcom-sdx65.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
> index 1a35830..77fa97c 100644
> --- a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
> +++ b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
> @@ -332,6 +332,9 @@
>  				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "global", "doorbell";
>  
> +			interconnects = <&system_noc MASTER_PCIE_0 &mc_virt SLAVE_EBI1>;
> +			interconnect-names = "pcie-mem";
> +
>  			resets = <&gcc GCC_PCIE_BCR>;
>  			reset-names = "core";
>  
