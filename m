Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F100F62F89B
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 16:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242241AbiKRPAl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 10:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242123AbiKRPA1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 10:00:27 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFAB9C7B5
        for <linux-pci@vger.kernel.org>; Fri, 18 Nov 2022 06:57:39 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id x21so7043223ljg.10
        for <linux-pci@vger.kernel.org>; Fri, 18 Nov 2022 06:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ngv5gxBO7Ianat52oueLrPYqURLVbai2GDjDWBWPbzg=;
        b=EROklCgzykSqhFNVyDi4+gpVhCwfP6B7mI+CUDZF1U/wuFkZa3Cf5/0PPw+YjSLMT4
         hsBip0klea3c0Y/uRLReKIQHK2I/YveobyeZMW2Eef00tDR4+FJJ1yfaVx9MnnhCzfjk
         cCvE8lbIwMNLLJREQo+vrTQRIDwYL4FPJ1AC23pg4kZf3hpwHGTvYjgCi+FwFicVPYVl
         OUZpEIL5hmWoBdLHZ0v2sg6ctc51ghuX779Q4OPfaeKoeVTOzWghwn2NDM9owNC40pGR
         gzSD7t+CX0ZNHtB52/AtIDFIqTrbH06XHLHVFXx/jQn82+R43nQ53cmvHx/KnGWr28zv
         PfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ngv5gxBO7Ianat52oueLrPYqURLVbai2GDjDWBWPbzg=;
        b=ZrBPyzhTzjoUPySNs87En/meUO52DBwcKxGKBwiTwYvhV0lYLDmfgCgxiapr6bBmnT
         fRWbPgAXepSiZ4g2/mvNNj6UjyeGIVZC7FbIOoS/43Or0JOiCqE2P5av5ODQuwebMlV0
         leJRCyHtqMDHvC7aVcd1D+/W0LMN8x52JSsiZALRpcCKvp1rwtkq1A3uALh4u9uaR5xO
         0Uhh5eNql1u8P7TMgtrEYh5Stdhgz2ySLfki5CzshIZH+E10kNhDQHIKvbXZv08z19wN
         TPogMDU/P7C7c5FG0MaHJ6SxsdvcoAZMmqL1JMUyc6ty2jK+jbjeZhuIm1OQt+KPgMZH
         1d6w==
X-Gm-Message-State: ANoB5pnTgQ3Ue9wLeN1s5EyZJVNId0RJSx9nyP6vGqvecTGirphVHzEu
        tx4h1+kMRmmc8UsMgzq0jURqLw==
X-Google-Smtp-Source: AA0mqf4vIPsBBLJFJHTlqjhJ4CFdPwgqhejw4qFFRvVxAexWCQHYq1Ia/7slA+muOzdbuZsvy/yVog==
X-Received: by 2002:a05:651c:12ca:b0:277:a9d:9355 with SMTP id 10-20020a05651c12ca00b002770a9d9355mr2409196lje.102.1668783457528;
        Fri, 18 Nov 2022 06:57:37 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id t23-20020ac243b7000000b004b490427bf2sm691531lfl.66.2022.11.18.06.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 06:57:37 -0800 (PST)
Message-ID: <b14655e4-44ca-24a7-3350-9f0eb80bf925@linaro.org>
Date:   Fri, 18 Nov 2022 15:57:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 10/12] dt-bindings: mmc: convert amlogic,meson-gx.txt to
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
 <20221117-b4-amlogic-bindings-convert-v1-10-3f025599b968@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221117-b4-amlogic-bindings-convert-v1-10-3f025599b968@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 18/11/2022 15:33, Neil Armstrong wrote:
> Convert the Amlogic SD / eMMC controller for S905/GXBB family SoCs
> to dt-schema.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/mmc/amlogic,meson-gx-mmc.yaml         | 78 ++++++++++++++++++++++
>  .../devicetree/bindings/mmc/amlogic,meson-gx.txt   | 39 -----------
>  2 files changed, 78 insertions(+), 39 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
> new file mode 100644
> index 000000000000..c9545334fd99
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/amlogic,meson-gx-mmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic SD / eMMC controller for S905/GXBB family SoCs
> +
> +description:
> +  The MMC 5.1 compliant host controller on Amlogic provides the
> +  interface for SD, eMMC and SDIO devices
> +
> +maintainers:
> +  - Neil Armstrong <neil.armstrong@linaro.org>
> +
> +allOf:
> +  - $ref: mmc-controller.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - amlogic,meson-gx-mmc
> +          - amlogic,meson-axg-mmc
> +      - items:
> +          - enum:
> +              - amlogic,meson-gxbb-mmc
> +              - amlogic,meson-gxl-mmc
> +              - amlogic,meson-gxm-mmc
> +          - const: amlogic,meson-gx-mmc

Mention changes in commit msg. Anyway this might not match existing
usage in DTS. At least amlogic,meson-gxbb-mmc has different order.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 3
> +
> +  clock-names:
> +    items:
> +      - const: core
> +      - const: clkin0
> +      - const: clkin1
> +
> +  resets:
> +    maxItems: 1
> +
> +  amlogic,dram-access-quirk:
> +    type: boolean
> +    description:
> +      set when controller's internal DMA engine cannot access the DRAM memory,
> +      like on the G12A dedicated SDIO controller.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - resets
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    mmc@70000 {
> +          compatible = "amlogic,meson-gx-mmc";
> +          reg = <0x70000 0x2000>;
> +          interrupts = <GIC_SPI 216 IRQ_TYPE_EDGE_RISING>;
> +          clocks = <&clk_mmc>, <&xtal>, <&clk_div>;
> +          clock-names = "core", "clkin0", "clkin1";
> +          pinctrl-0 = <&emm_pins>;
> +          resets = <&reset_mmc>;

Use 4 spaces for example indentation.


Best regards,
Krzysztof

