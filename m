Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA70975937F
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 12:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjGSKz3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 06:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjGSKz2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 06:55:28 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AC4197
        for <linux-pci@vger.kernel.org>; Wed, 19 Jul 2023 03:55:27 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4faaaa476a9so11448198e87.2
        for <linux-pci@vger.kernel.org>; Wed, 19 Jul 2023 03:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689764125; x=1692356125;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yVxXZfOtxak8iBVRDb2c9fmyjvpQOuKAzeNKIUJfojo=;
        b=HeVH4aqAbGSTlrakuKCfBsU+kcA3+5vAw/2F2XZ2oKt4WdOKQWlwy96CAB1sZy2WU4
         8qvnhQiLGswTExx5lvoyoLk9HoK5mtEiqeLYGnDidaOStp2zs9rhLdZEtYr1RYBuNInE
         czVr7Mq22nDyuHb/uyyj9p5JJQtEUj9MUChLeLMvmGt68Pf5kpvesh/6Cytqoi8powab
         pju96pfebtbnLVIn6qNYf6YbWElvAJNANr+F4laUWMyJ2D0pQvwrs2s9tX2d/JsKn6b+
         8J+YOtt68Xg3TitlkpEoYxJkP9wP5Vs94/8nAP5jnZX1Fkk5Q70FIz9afn0/kMP7jTcj
         ixPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689764125; x=1692356125;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yVxXZfOtxak8iBVRDb2c9fmyjvpQOuKAzeNKIUJfojo=;
        b=cm6PurY00PUczI5AxypBEmjsJLrhDzlB1YECiW3KQDG1p9g5o/Vdzh8uETywyFRbkQ
         4enGOUWuV7Fm28KU0aEzk2ofpiSoCQ+hYAWwVXE2atHNIOHoKeEPQ6tK9ReY/i3i+P4x
         ERzeB4OZio9W8jl8sMuLReDxZtpyGsuqFcjzcQJw/YvO0rCKQd9WS5njpciGOUF6oEsw
         9uKEsH/6P6OZ3+Xu4PJ5DyMfOAyycxbw7SzLwnZ701giNhgCuZ8YtdqlVgUYYKuADLfG
         Ym7nPwq3VQkdxZqn6GPpDeUu0s48EDVgtNSXdG7NQakJZZVPtqhpwmA3AHCfRJTqEr/Y
         Rzcw==
X-Gm-Message-State: ABy/qLY+3zhUT7BaGWYYf2SUkUgKki+dUDqYGvpIl8nruIGKwAHgsJvK
        EvDEEKLyI2wx7FxXu8VmNc/xfg==
X-Google-Smtp-Source: APBJJlH1QRK+S6KRTvEUqv/cdRVknog7MADGQ8rYn1gGhl1iDVu/AuB3WpeY+yiLkKU5yEqoT9rncw==
X-Received: by 2002:a05:6512:3d89:b0:4f9:6528:fb15 with SMTP id k9-20020a0565123d8900b004f96528fb15mr13939510lfv.12.1689764125474;
        Wed, 19 Jul 2023 03:55:25 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id be1-20020a0564021a2100b0051e2549c4f9sm2526983edb.47.2023.07.19.03.55.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 03:55:25 -0700 (PDT)
Message-ID: <6b452a82-4fc1-bb0e-2475-755d699db1ee@linaro.org>
Date:   Wed, 19 Jul 2023 12:55:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 5/9] dt-bindings: PLDA: Add PLDA XpressRICH PCIe host
 controller
Content-Language: en-US
To:     Minda Chen <minda.chen@starfivetech.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
References: <20230719102057.22329-1-minda.chen@starfivetech.com>
 <20230719102057.22329-6-minda.chen@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230719102057.22329-6-minda.chen@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 19/07/2023 12:20, Minda Chen wrote:
> Add PLDA XpressRICH host controller dt-bindings. Both Microchip
> PolarFire SoC and StarFive JH7110 SoC are using PLDA XpressRICH
> PCIe host controller IP.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../pci/plda,xpressrich-pcie-host.yaml        | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/plda,xpressrich-pcie-host.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/plda,xpressrich-pcie-host.yaml b/Documentation/devicetree/bindings/pci/plda,xpressrich-pcie-host.yaml
> new file mode 100644
> index 000000000000..10a10862a078
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/plda,xpressrich-pcie-host.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/plda,xpressrich-pcie-host.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PLDA XpressRICH PCIe host controller
> +
> +maintainers:
> +  - Daire McNamara <daire.mcnamara@microchip.com>
> +  - Minda Chen <minda.chen@starfivetech.com>
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +  - $ref: plda,xpressrich-pcie-common.yaml#
> +  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: plda,xpressrich-pcie-host
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - "#interrupt-cells"
> +  - interrupts
> +  - interrupt-map-mask
> +  - interrupt-map
> +  - msi-controller

Your common schema should require properties which it defines. Here you
should require only difference or new properties.

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    soc {
> +            #address-cells = <2>;

Use 4 spaces for example indentation.

> +            #size-cells = <2>;
> +            pcie0: pcie@12000000 {


Best regards,
Krzysztof

