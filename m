Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE49683350
	for <lists+linux-pci@lfdr.de>; Tue, 31 Jan 2023 18:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjAaRGQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Jan 2023 12:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjAaRGP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Jan 2023 12:06:15 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D8F3401B;
        Tue, 31 Jan 2023 09:06:09 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id x26-20020a056830115a00b0068bbc0ee3eeso2917194otq.0;
        Tue, 31 Jan 2023 09:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n+8rBCXp9QUszN6EtdlrzESk2YRd1LhFxQMBHxqvRZ8=;
        b=KIotuXGen7IPQ2MM3jARlRJcgpTMmXnjonwSHT+XpZMX1+12fCZD0G96L0aAkPfdMS
         JAHa/KIhvXy01RkzKieONIFgBovrC4z8J77AAyJPbvvJGJBhYkeZE63h9y9Q+dalddna
         PRK0CAY2UAlQhTL3jJs0e4S33SYUchhScZ+3cEp1zWv3CrhIaqr1ZwwH9rnrfE5O1uGb
         8yb79/rJu1S0QRRcyN2iE0OAsr3Yp7k2g9ph4snwSPo9xtOyX3Yjc6HPa4d6SIGZbfnd
         Tfg87yjJPUuO696M3UjVX7oStAxPrNPOkWDXt/2gqibuMnOUNXmVnRByLYZqWojpaWgB
         GukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+8rBCXp9QUszN6EtdlrzESk2YRd1LhFxQMBHxqvRZ8=;
        b=m5n7Z95g9DZ3AInOfflZcZtffAaZDCZ5PvuIxSlHUtzdOsq5xCKfEr9Iu40Ex8gDLg
         iyP8VlTeQvgd+/8Citg8WwVFstcug1dh5Acwx1skV01o9O16wXsnBNmtb+AG5swrou4X
         ttDy29XutbwDPAkVxt9dQkrxV0BE6/FZw/EbEVy0MBKNlSmf7Yc4ak8akCg/E+yTM8IC
         SpYJaQbvKVehpbxta7TzQNhT3Kn3oKsFPCpgO9fU7953CDsOj0744PMKUE+dthmlC6fn
         RAbzo7EVpo9F9WrydAWdEBntNu3FC4vYnhGnbBmji/ZgUhtIs1tvZAt5BENjgi/sdm5v
         9fdw==
X-Gm-Message-State: AO0yUKVUCDOFkowTeAbJyihOwwLXqCETHKK3TTkeknL6E2z2G8RbGNvh
        /LFXrx3pvdv7XZmJNdan8Ro=
X-Google-Smtp-Source: AK7set/3cx199W6dlm+bCYeBqwh7XTb78l9Pdy4589af0XRP0nPAx1JUE7sHjjl+5ymFcH8PmR8lxQ==
X-Received: by 2002:a9d:688:0:b0:68d:3e10:2951 with SMTP id 8-20020a9d0688000000b0068d3e102951mr89946otx.3.1675184768344;
        Tue, 31 Jan 2023 09:06:08 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t14-20020a9d590e000000b006864816ecd9sm6740348oth.59.2023.01.31.09.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 09:06:07 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 31 Jan 2023 09:06:06 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-pci@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 3/7] dt-bindings: watchdog: convert meson-wdt.txt to
 dt-schema
Message-ID: <20230131170606.GA3599161@roeck-us.net>
References: <20221117-b4-amlogic-bindings-convert-v3-0-e28dd31e3bed@linaro.org>
 <20221117-b4-amlogic-bindings-convert-v3-3-e28dd31e3bed@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117-b4-amlogic-bindings-convert-v3-3-e28dd31e3bed@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 23, 2023 at 11:10:00AM +0100, Neil Armstrong wrote:
> Convert the Amlogic Meson6 SoCs Watchdog timer bindings to dt-schema.
> 
> Take in account the used interrupts property.
> 
> The "amlogic,meson8-wdt" representation has been simplified
> since there's no users of this compatible used along the
> "amlogic,meson6-wdt".
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  .../bindings/watchdog/amlogic,meson6-wdt.yaml      | 50 ++++++++++++++++++++++
>  .../devicetree/bindings/watchdog/meson-wdt.txt     | 21 ---------
>  2 files changed, 50 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/amlogic,meson6-wdt.yaml b/Documentation/devicetree/bindings/watchdog/amlogic,meson6-wdt.yaml
> new file mode 100644
> index 000000000000..84732cb58ec4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/amlogic,meson6-wdt.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/amlogic,meson6-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic Meson6 SoCs Watchdog timer
> +
> +maintainers:
> +  - Neil Armstrong <neil.armstrong@linaro.org>
> +  - Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> +
> +allOf:
> +  - $ref: watchdog.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - amlogic,meson6-wdt
> +          - amlogic,meson8-wdt
> +          - amlogic,meson8b-wdt
> +      - items:
> +          - const: amlogic,meson8m2-wdt
> +          - const: amlogic,meson8b-wdt
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - interrupts
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    wdt: watchdog@c1109900 {
> +        compatible = "amlogic,meson6-wdt";
> +        reg = <0xc1109900 0x8>;
> +        interrupts = <GIC_SPI 0 IRQ_TYPE_EDGE_RISING>;
> +        timeout-sec = <10>;
> +    };
> diff --git a/Documentation/devicetree/bindings/watchdog/meson-wdt.txt b/Documentation/devicetree/bindings/watchdog/meson-wdt.txt
> deleted file mode 100644
> index 7588cc3971bf..000000000000
> --- a/Documentation/devicetree/bindings/watchdog/meson-wdt.txt
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -Meson SoCs Watchdog timer
> -
> -Required properties:
> -
> -- compatible : depending on the SoC this should be one of:
> -	"amlogic,meson6-wdt" on Meson6 SoCs
> -	"amlogic,meson8-wdt" and "amlogic,meson6-wdt" on Meson8 SoCs
> -	"amlogic,meson8b-wdt" on Meson8b SoCs
> -	"amlogic,meson8m2-wdt" and "amlogic,meson8b-wdt" on Meson8m2 SoCs
> -- reg : Specifies base physical address and size of the registers.
> -
> -Optional properties:
> -- timeout-sec: contains the watchdog timeout in seconds.
> -
> -Example:
> -
> -wdt: watchdog@c1109900 {
> -	compatible = "amlogic,meson6-wdt";
> -	reg = <0xc1109900 0x8>;
> -	timeout-sec = <10>;
> -};
