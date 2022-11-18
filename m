Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F4762F8C0
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 16:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242361AbiKRPDj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 10:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242021AbiKRPDL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 10:03:11 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD859736F
        for <linux-pci@vger.kernel.org>; Fri, 18 Nov 2022 07:00:51 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id be13so8622827lfb.4
        for <linux-pci@vger.kernel.org>; Fri, 18 Nov 2022 07:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xZwVEy9nYMOGJVqNuOaZMQiT5Q9vQhLz7eqb5cQdZQw=;
        b=tqVpDafz2JPxpjQRqsyFMMJaYBXdKwQkLbZoJLNsDj9VCVAb7mK9tiv6F2SDhe3ufq
         rwM92bgOOptB7jG/c5D4/Ya+FzHgR+tYlaNW6eTN2kHmmTzAofF5DcT1dlQaMSerR17G
         rDqMG22aJ95f4773TiYyo8QPHpyb2j/dcpg7OfC+6nEshU7MsKGELcm1Mj/Tr+dhfK/5
         4FZKPlIoRdC13WaDRNKf0g2s7vkFRT812d+h70WXPAsVX3F3+fzudapLPjmkSYVt89c4
         Rc4kbe8E4a1WUuJcEcJQWGtK1FS4uE1x8EUvsNIFRLE2En48mecdHTbxq/5Nv3LwVNDB
         CEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xZwVEy9nYMOGJVqNuOaZMQiT5Q9vQhLz7eqb5cQdZQw=;
        b=W0mKUNc8l0qw1Gn3QAfxd+JW1C/ApmvX9skdwLvKQAAL0AtYGtFKzdbYg+nr40/9iZ
         sDEzbXtJVBTm8Je/pbXhZ7JEsAMNq6J4UUSq7og37ajHns8KgMx5/wMOvzooYe36677A
         ocm/WZvW7qz/JIy1r5czykBUk+5Q8OcrIjnCtb5FNtNESbCKKWvvXdkQgRDlxvE+kDpE
         KzqLRu3IY84BLtVDNzw4pvUcNtOU2Fd5ade+eh4IJ+dtc08BUmkcKQJT84HpBZ50FEAo
         /NTHyf0BMlc+DtaT4ZgpNkO7sqtdFmkYB/os6i72aracaJbxNP3pTZq57U51j/quO/SN
         Y+9g==
X-Gm-Message-State: ANoB5pl0LP1UjJKZgv944V3ORNQFkrPMQsUfTDdhRKGTvxSuHsqmQWIl
        wYtsHxbFsDUuiIOYpiwsCNY3uA==
X-Google-Smtp-Source: AA0mqf6BTjsS+TwWckVjHa91aDENgfUjJrDrDj2CcWJkPyIdf7Ut+Y1Rzl3SNKwLnI6zGlVaoA3a5w==
X-Received: by 2002:a05:6512:6d:b0:4a8:ebec:7143 with SMTP id i13-20020a056512006d00b004a8ebec7143mr2515960lfo.493.1668783649650;
        Fri, 18 Nov 2022 07:00:49 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p5-20020a19f005000000b004b48e0f619asm694119lfc.48.2022.11.18.07.00.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 07:00:48 -0800 (PST)
Message-ID: <838b278a-aa3c-c34c-4277-e50079512b47@linaro.org>
Date:   Fri, 18 Nov 2022 16:00:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 11/12] dt-bindings: pcie: convert amlogic,meson-pcie.txt
 to dt-schema
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Eric Dumazet <edumazet@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
References: <20221117-b4-amlogic-bindings-convert-v1-0-3f025599b968@linaro.org>
 <20221117-b4-amlogic-bindings-convert-v1-11-3f025599b968@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221117-b4-amlogic-bindings-convert-v1-11-3f025599b968@linaro.org>
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

On 18/11/2022 15:33, Neil Armstrong wrote:
> Convert the Amlogic Meson AXG DWC PCIE SoC controller bindings to
> dt-schema.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../devicetree/bindings/pci/amlogic,axg-pcie.yaml  | 129 +++++++++++++++++++++
>  .../devicetree/bindings/pci/amlogic,meson-pcie.txt |  70 -----------
>  2 files changed, 129 insertions(+), 70 deletions(-)
> 

Use subject prefixes matching the subsystem (git log --oneline -- ...).

With fixed:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

