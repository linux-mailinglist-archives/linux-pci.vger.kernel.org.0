Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1379D62F838
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 15:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241407AbiKROvF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 09:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242018AbiKROuv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 09:50:51 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74948FB37
        for <linux-pci@vger.kernel.org>; Fri, 18 Nov 2022 06:50:49 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id z24so7064561ljn.4
        for <linux-pci@vger.kernel.org>; Fri, 18 Nov 2022 06:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=flARCzHTVyCR8t1b/alFfXpYG08uQcpbdpykx0qaY6o=;
        b=WPhguTbEITewUUFmzDKk67xFlcItotk7CHPjo38HZOuTantjdkogWORtgo0xLlYRgF
         HWg9GOTf1V4e9ThxnO5h7EGEtSAM84fFMdKNcc5IiTsPgjkjtPAow8xj447vQZ+xI9fu
         +EMNqv8xxM0kkgUKOkUMQThTtqLNuitsLUM2+q9sG4Mf7bfPbimkEiHxBNyigCGXB3JH
         hkw+VprjJL3OtOt+z25ktmnAiSNEDvhjN41HMNxYzS7ZhQbxwhTFwKXP3WbivZpl7aB6
         XkuF/NX6RxoqzQhWxmZioNe+aR0PcSCpDbAE6M/O59pFVA7b2qTsMwpCsLKRSomd9Dlv
         tTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=flARCzHTVyCR8t1b/alFfXpYG08uQcpbdpykx0qaY6o=;
        b=3jgMc82l9mRH49JYH7T25jp+PJlFEPB26/cvh+SW7Rv2mBzsRHKtkUOEwoL5hdg2hm
         6qPOmLnaJiBc+0JKLxFb5oK+GsJKWpEdGfBDhrRFrttjFjJ68NYsqhwQglzaz8TqoMRu
         bpfLjJS54T4Jux8ALlLguySgPsctwFac/SG0h7+wiNuSXd2xX8p5OlL03jVVG4HLnZS+
         Hv01xmClSUrl3xwrfcff2KS8ou18fmz9yId5Hax6Z1I3xyD0gqf0AhFaNODGc35o51jr
         NKfpqYa/HJ0qEjibPyV4nsh7VCTECcu5D8H6qbDzqnUYKGWdU18vWF7Hx79i+K8QVLT/
         KRAg==
X-Gm-Message-State: ANoB5pkrVDu6qZE6WqAOjBCqXzMjNWIZegiHjCB62Z5UZAp7IXbOXBtm
        z7jEOfaTB7iP+1Bb5DIa8xycFQ==
X-Google-Smtp-Source: AA0mqf59msaFmJhx4BlNDfC6dSrkN8YU7SVi7qZH3ZaQ9nO4p90o4YgmHrxZLIkn1WuJ/YF2IErpqA==
X-Received: by 2002:a2e:9c13:0:b0:26d:c072:ddd with SMTP id s19-20020a2e9c13000000b0026dc0720dddmr2701980lji.158.1668783048034;
        Fri, 18 Nov 2022 06:50:48 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id dt25-20020a0565122a9900b004947a12232bsm676480lfb.275.2022.11.18.06.50.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 06:50:47 -0800 (PST)
Message-ID: <b2f16f4d-f340-185a-ecfe-5d83e8b8ad6a@linaro.org>
Date:   Fri, 18 Nov 2022 15:50:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 06/12] dt-bindings: rtc: convert rtc-meson.txt to
 dt-schema
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
 <20221117-b4-amlogic-bindings-convert-v1-6-3f025599b968@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221117-b4-amlogic-bindings-convert-v1-6-3f025599b968@linaro.org>
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
> Convert the Amlogic Meson6 RTC bindings to dt-schema.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/rtc/amlogic,meson6-rtc.yaml           | 62 ++++++++++++++++++++++
>  .../devicetree/bindings/rtc/rtc-meson.txt          | 35 ------------
>  2 files changed, 62 insertions(+), 35 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

