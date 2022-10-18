Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98457603621
	for <lists+linux-pci@lfdr.de>; Wed, 19 Oct 2022 00:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJRWmD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Oct 2022 18:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiJRWmC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Oct 2022 18:42:02 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACEFD03A9
        for <linux-pci@vger.kernel.org>; Tue, 18 Oct 2022 15:41:56 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id f8so9667405qkg.3
        for <linux-pci@vger.kernel.org>; Tue, 18 Oct 2022 15:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QPHsfF5G/eKNcWYWTSHi0xoOr+RUpiJkFM56TjDpIhw=;
        b=cMtW7lgcJvDjvjAYrJwMB5BYBquSoGYgp9AM9VNASnhcTzA3VT2TA7IG94L7X3cPgr
         fKqLbezOGfyszHnXRLuKEo1k0pSXUsi0QxnVMbloRUMQSfdO5QyUOtyTgXrMktTAAETu
         yrXj/NY3hkY90zBqAhJELc7xuZZo6sQZkMe2dLmO2AbVhbeqPcZoDfdM0Z5KffRwxe7W
         jTXr3MEjHlD3i3UYSTxgCxQWVpwJ2Ubaonulh1xdHyK0PSYO4L66qrvARdkLD7CPW7WN
         0199owG2tuDCidKwr2wvdHtXh8yemlVgdoE5kw6D0pEczV1QwnTwPvLhRfkGz5mtMYoO
         RSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QPHsfF5G/eKNcWYWTSHi0xoOr+RUpiJkFM56TjDpIhw=;
        b=fkVvfk8Is0AL4BB3p4MbMdj1m3A0BTLoMmcQtrwjUReZku8apCTZfxqWT5Ef193Drp
         0RgtEMdjfvnV83VRYJCIddYJ9pz34TxCge54uuSDd9cvSVbve0rY2eMNzeNID3N735pA
         rmuP5k4Elpeub3Zptgts6+RgSZ5+b1p7usmdEKtkjiei8iY6RE4Fico6lfXryYKZUdzF
         u6srwvqRmYH/1AOWRWTYnXuNWGTQYWAE953+HpYQ/5DtRqJxHa4kCOzwVH5Ex6SQtQm9
         CDWMzwVF0Z7gpdWM7rJGlSg7sJ+Qu3k/NNwXJRtcxlUDSGRMNgNuXuUvOoEMJEW/g800
         ugEA==
X-Gm-Message-State: ACrzQf2QvrVSKlwqESFX51Vt/c+LNeEYfSWPHzLACFdJNSjl+Lr8rnN6
        G5KIV+LLC3/wCLoJPY6RxqsP4g==
X-Google-Smtp-Source: AMsMyM7EedzjO6hEsUs2zztzn/M462CVJQYYcG6wF5jfqugCFf8K5I8jcxMc++W3EFWNNT2dw/Mg4w==
X-Received: by 2002:a05:620a:1909:b0:6ee:d4a1:fc07 with SMTP id bj9-20020a05620a190900b006eed4a1fc07mr3606841qkb.489.1666132914823;
        Tue, 18 Oct 2022 15:41:54 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id m10-20020ac8444a000000b0039b03ac2f72sm2761502qtn.46.2022.10.18.15.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 15:41:54 -0700 (PDT)
Message-ID: <d6bc528e-1108-908b-fa87-c4f97bc6450b@linaro.org>
Date:   Tue, 18 Oct 2022 18:41:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v1 3/3] arm64: dts: mt8195: Add venc node
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Irui Wang <irui.wang@mediatek.com>
References: <20221017070858.13902-1-tinghan.shen@mediatek.com>
 <20221017070858.13902-4-tinghan.shen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221017070858.13902-4-tinghan.shen@mediatek.com>
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

On 17/10/2022 03:08, Tinghan Shen wrote:
> Add venc node for mt8195 SoC.
> 
> Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 903e92d6156f..7cf2f7ef4ec6 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -2163,6 +2163,30 @@
>  			power-domains = <&spm MT8195_POWER_DOMAIN_VENC>;
>  		};
>  
> +		venc: venc@1a020000 {

I think you called this video-codec in other patches... Would be great
if you (you as folks working on Mediatek from Mediatek) keep patches
consistent...


> +			compatible = "mediatek,mt8195-vcodec-enc";
> +			reg = <0 0x1a020000 0 0x10000>;


Best regards,
Krzysztof

