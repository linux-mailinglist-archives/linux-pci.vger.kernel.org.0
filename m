Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A9A505C23
	for <lists+linux-pci@lfdr.de>; Mon, 18 Apr 2022 17:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244950AbiDRQAN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Apr 2022 12:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345804AbiDRQAD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Apr 2022 12:00:03 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC42FE62
        for <linux-pci@vger.kernel.org>; Mon, 18 Apr 2022 08:57:04 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id b24so17893386edu.10
        for <linux-pci@vger.kernel.org>; Mon, 18 Apr 2022 08:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FjnArbiHeKmHxIQGkXFyLcDATsoCoWvdzs6hnVzyW6g=;
        b=EaxvZM4sPR/maCfoqX/GP+glDd5U/u7Yf8Vqg32ThP1rPQmS6FMeleFG4TqkU2F3p2
         otvkn17tJ6H7Wtl9xR2NdEGg3yPRgmHAY1jS2PIOMMAucDh8ZDBsyDYSZhJ6t5xHEsNY
         6B1Asd78N4dE0oC2XPc/PGtGqUjJH/iNDhDZKlfHnduhngAiKEXdvCvNyYXUxhBP/1DF
         IDxIzLS3vHW1irS5b69DNB/uCQBL1MbGe5l9ke/xKZmcd+Z6xleU5swAtLnNR7y8l3F2
         IOfJLDRw5GK7rMzdycYDkMwtwun3yhWApXofTrKF9C9rRoN2CjCB40SXRGxOcpcDi54K
         YRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FjnArbiHeKmHxIQGkXFyLcDATsoCoWvdzs6hnVzyW6g=;
        b=P6KL0C6XQfiJSWAcflXPJPQPJVv7yGPKbM22yoEQIEm92tZ0x9X7hZ5C8qNol/Hx1c
         IHTXfoxW1gOWnrFmN3Y7vxdY/xpaMt36DKbTE4qU1PsBBT7hoyE4ZFegwLaV6PlmA1Z0
         ixfy2jowjCLGkBTcyC4ljcrke3YD9BqOMsG9l+DuJRhG0h+DYCefEyRXXb4i/NpXxMf+
         GPVrCQQ7iG5/OYM5QadrEYzSZIX2N/r0bNT4HPy6X37LGs0bLmuqJkqAxoyNoou8dEug
         j+6AZPbIB4YuTJJBim4dEOL19LqsGPOijSjcpIdckpmDBI1e+hcaL4ByYZqh9I4FugZh
         uUeQ==
X-Gm-Message-State: AOAM532I6zVjm8UiOdRSo6ksSfxlmD9OrXyeP7Fc0p6UVbW00eUK3Gs0
        ejFWdkvgoDa83s8xmZl2APsPgg==
X-Google-Smtp-Source: ABdhPJz5Nk0LJAe1slK1roTE+oxG1zDFX+FnoXU6Ow5CzumX7mijMS7IuiMHrwNK7ouJ9w2wLzkUnA==
X-Received: by 2002:a05:6402:4253:b0:423:e4e0:fdd8 with SMTP id g19-20020a056402425300b00423e4e0fdd8mr6255768edb.193.1650297423228;
        Mon, 18 Apr 2022 08:57:03 -0700 (PDT)
Received: from [192.168.0.217] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l3-20020aa7cac3000000b00422c961c8c9sm5068097edt.78.2022.04.18.08.57.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 08:57:02 -0700 (PDT)
Message-ID: <605aa014-19ac-2679-799f-c2410b3fcc3a@linaro.org>
Date:   Mon, 18 Apr 2022 17:57:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC/RFT 3/6] phy: rockchip: Support pcie v3
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20220416135458.104048-1-linux@fw-web.de>
 <20220416135458.104048-4-linux@fw-web.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220416135458.104048-4-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 16/04/2022 15:54, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> RK3568 supports PCIe v3 using not Combphy like PCIe v2 on rk3566.
> It use a dedicated pcie-phy. Add support for this.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> driver was taken from linux 5.10 based on in
> https://github.com/JeffyCN/mirrors
> which now has disappeared
> ---
>  drivers/phy/rockchip/Kconfig                  |   9 +
>  drivers/phy/rockchip/Makefile                 |   1 +
>  .../phy/rockchip/phy-rockchip-snps-pcie3.c    | 278 ++++++++++++++++++
>  include/dt-bindings/phy/phy-snps-pcie3.h      |  21 ++

This goes to separate patch or to the bindings one. File naming is also
not correct. Who is the vendor here? "rockchip," or "snps,"?

The values look specific to this Rockchip implementation, so the file
should be also mentioned in the bindings (e.g. in property using it).

Best regards,
Krzysztof
