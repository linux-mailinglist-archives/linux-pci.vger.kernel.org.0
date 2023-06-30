Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE0074362B
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jun 2023 09:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjF3HtT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jun 2023 03:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjF3HtR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jun 2023 03:49:17 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A666A10A
        for <linux-pci@vger.kernel.org>; Fri, 30 Jun 2023 00:49:15 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fa9850bfebso16453165e9.1
        for <linux-pci@vger.kernel.org>; Fri, 30 Jun 2023 00:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688111354; x=1690703354;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iRfw15ErOguqSIIHURRE0OTcz3LeKZcT69wox0vClec=;
        b=rAQuPJi+eT3Kp4arQzO8f3phEq6qoOBmRg4LqXwfiDnXjqDY9VQgugUHdfe0LY9TV3
         rXZG+xZUyDa0UBaHYBLV0Of805dJLLM35TOdYN1FrA264zoEW6U3wpyUNRonVxcOGOwj
         sbahwTGJ1R52N3cIfgInHGmnWjQBOcNEdoHGCbultdhjH3zE70djcfSvpJXzqbE6Pi00
         oHA5LCC0OSfZe3ZLN+sy5rz6dqY3oQqxSQz/Pne1GkycOpeyjSj8Igake2y++TOmq53l
         nwRiLzQiOecnNwSykOmOl+AzVjVArwakSe/FKwCRO5nzvTwXP2XlJg/iP78oU4LXh4SL
         x/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688111354; x=1690703354;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iRfw15ErOguqSIIHURRE0OTcz3LeKZcT69wox0vClec=;
        b=EGkelf0Yk1wnT8pvRHhey0WDJhpiL+hHtbHKMOdRXBJaUvp6lEhU9Y4hDUfxvA12Za
         ke5A7H77X1KV9B8gAuhnRe3fOVQ4epCjstc6AKIM2cQOfm0hYZ9UxG7LeBDg0OUDcP+C
         6pYKgQcrfjQcW6O5PCWgABXkbmqX0UHPbqReycBv24BZhAkfeztYKtBYKynKjTPkIhZx
         GjvT4ZWnZjaaUGkS2ZOCGhx2Sw7oKXq5PASO9+KHmsrtkVFv/v3lyrY9kcEKRh3RnQ8X
         uubdp/S2hsSK3R86f0LTq3wott6qIePbljRpZ2jxApAwD/FizuK6weqtQdAu/GHkhZHI
         Xcxg==
X-Gm-Message-State: AC+VfDwaUy1Ba9gdzweJDiMOSyGqbqOGxRj4K+oZ6L9CHf94GjQp/lFP
        RIFGm9WuwonXmpZEz72ji4oVvg==
X-Google-Smtp-Source: ACHHUZ5+dcZk88UuWwQX5Q/Ft91E+rKmG0m3RzhwO6yEbNe8JfyChx+IvnHE+uGHdF7XI0LyDzntFA==
X-Received: by 2002:a05:600c:3649:b0:3f9:bf0f:1ceb with SMTP id y9-20020a05600c364900b003f9bf0f1cebmr1496183wmq.37.1688111353989;
        Fri, 30 Jun 2023 00:49:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:eac6:eb92:cae4:cfd2? ([2a01:e0a:982:cbb0:eac6:eb92:cae4:cfd2])
        by smtp.gmail.com with ESMTPSA id q10-20020adfdfca000000b003141e629cb6sm1834694wrn.101.2023.06.30.00.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 00:49:13 -0700 (PDT)
Message-ID: <ba03946f-f0ed-0e62-0171-8dee256dce7a@linaro.org>
Date:   Fri, 30 Jun 2023 09:49:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/3] PCI: meson: Remove cast between incompatible function
 type
Content-Language: en-US
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Yue Wang <yue.wang@Amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Srikanth Thokala <srikanth.thokala@intel.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-riscv@lists.infradead.org
References: <20230629165956.237832-1-kwilczynski@kernel.org>
Organization: Linaro Developer Services
In-Reply-To: <20230629165956.237832-1-kwilczynski@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 29/06/2023 18:59, Krzysztof Wilczyński wrote:
> Rather than casting void(*)(struct clk *) to void (*)(void *), that
> forces conversion to an incompatible function type, replace the cast
> with a small local stub function with a signature that matches what
> the devm_add_action_or_reset() function expects.
> 
> The sub function takes a void *, then passes it directly to
> clk_disable_unprepare(), which handles the more specific type.
> 
> Reported by clang when building with warnings enabled:
> 
>    drivers/pci/controller/dwc/pci-meson.c:191:6: warning: cast from 'void (*)(struct clk *)' to 'void (*)(void *)' converts to incompatible function type [-Wcast-function-type-strict]
>                                     (void (*) (void *))clk_disable_unprepare,
>                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> No functional changes are intended.
> 
> Fixes: 9c0ef6d34fdb ("PCI: amlogic: Add the Amlogic Meson PCIe controller driver")
> Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
> ---
>   drivers/pci/controller/dwc/pci-meson.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 

<snip>


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
