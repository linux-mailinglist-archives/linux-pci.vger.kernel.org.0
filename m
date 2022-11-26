Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E07C639679
	for <lists+linux-pci@lfdr.de>; Sat, 26 Nov 2022 15:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiKZOaZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Nov 2022 09:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiKZOaY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 Nov 2022 09:30:24 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB4D1BEB7
        for <linux-pci@vger.kernel.org>; Sat, 26 Nov 2022 06:30:23 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id be13so10898270lfb.4
        for <linux-pci@vger.kernel.org>; Sat, 26 Nov 2022 06:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0FH6Qg/jduzi6PwcFvP6hRcgcF3jb6cJugtkH2wA03k=;
        b=GZqbKSqt+e1ftphMnBrAMi19b1u4IAdImBmNTWqJrX8rdn1oVuFBFKOAfvvO64bKdM
         NMKq6OpVDdPfw275d9Ldd19+I67ocoK8A0PLAKOoK3TKN78kVwSVYM1gfmZEORB3LoxU
         ZEM09KjqYmuGjq9NTAGC6y3w6aA+Mkh5LE5mDZs0eyiQDPTK1s2WtUlH6KqTScWXCaLX
         nzFPUN7+4E4TOPrRpcQE4eTJJowwJlA6OT71zDN8sbFl1ldqK3w/Ng4OFOi9OzYbeQkj
         hXkh21S4ZmZ99b+vdxzxyRqAclye5TvOgH8dw3cVsw9Dlhqg7W3uvYAe1tqrYpra9qxV
         +evQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0FH6Qg/jduzi6PwcFvP6hRcgcF3jb6cJugtkH2wA03k=;
        b=rrfT/g/TdI7X8qO/aUZlvbcvEFx8Eqd4+1EFubHgrtBgoG08JSpAKKe6SKt2aWD248
         PILWD15bS1izbywOyJGPhwDZ9y6TilLrV41r11mQoNlp8dC3p/3CFJ4ShujLrlRhiaR5
         iWgKBeTpZFgncnbqKTyAgmqTslOl0r0rCBZ6wcrRWOa7IHCl6x583bB67PApaiMCmG2u
         8FHxbsNEKp32jGNH44ZMkdvByZNESyfqfDUyFHJeStawCDgNL0zdfSEElKey3jjHwwy0
         3902BaTbAJ5qmkUQCE1qBDVxzZe8eRta/ydB+TN27Ccr76cyrJ31SVmXX2cfOohZoNum
         hVXA==
X-Gm-Message-State: ANoB5pm5v0H7OfMVTvPHkb+fGdjjeSePwZu7+Z5qj8ZmLjOhyxy1P5So
        39wx2ujznA4TT6Wm/DCByXKKHQ==
X-Google-Smtp-Source: AA0mqf6OQNKG/3n825nCEeCAO06Iv5aI6Uk1mOESWJou2dOgsKu3cRwImPUH9aEIreGzTmYNvODxFA==
X-Received: by 2002:ac2:5453:0:b0:4a2:2c23:a6d4 with SMTP id d19-20020ac25453000000b004a22c23a6d4mr13687688lfn.257.1669473021404;
        Sat, 26 Nov 2022 06:30:21 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p11-20020ac24ecb000000b004b50ae0bfe8sm262741lfr.208.2022.11.26.06.30.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Nov 2022 06:30:21 -0800 (PST)
Message-ID: <2b399e95-70c9-0213-90e6-95f377976e95@linaro.org>
Date:   Sat, 26 Nov 2022 15:30:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v7 1/5] dt-bindings: PCI: ti,j721e-pci-*: add checks for
 num-lanes
Content-Language: en-US
To:     Matt Ranostay <mranostay@ti.com>, rogerq@kernel.org,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, vigneshr@ti.com, tjoseph@cadence.com,
        sergio.paracuellos@gmail.com, pthombar@cadence.com,
        linux-pci@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221124081221.1206167-1-mranostay@ti.com>
 <20221124081221.1206167-2-mranostay@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221124081221.1206167-2-mranostay@ti.com>
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

On 24/11/2022 09:12, Matt Ranostay wrote:
> Add num-lanes schema checks based on compatible string on available lanes
> for that platform.
> 
> Signed-off-by: Matt Ranostay <mranostay@ti.com>
> ---
>  .../bindings/pci/ti,j721e-pci-ep.yaml         | 28 +++++++++++++++++--
>  .../bindings/pci/ti,j721e-pci-host.yaml       | 28 +++++++++++++++++--
>  2 files changed, 50 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
> index 10e6eabdff53..1aeea168d3d0 100644
> --- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
> @@ -10,9 +10,6 @@ title: TI J721E PCI EP (PCIe Wrapper)
>  maintainers:
>    - Kishon Vijay Abraham I <kishon@ti.com>
>  
> -allOf:
> -  - $ref: "cdns-pcie-ep.yaml#"
> -
>  properties:
>    compatible:
>      oneOf:
> @@ -65,6 +62,31 @@ properties:
>      items:
>        - const: link_state
>  
> +allOf:
> +  - $ref: "cdns-pcie-ep.yaml#"

While moving it, drop the quotes.

> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - ti,am64-pcie-ep
> +    then:
> +      properties:
> +        num-lanes:
> +          minimum: 1
> +          maximum: 1
> +
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - ti,j7200-pcie-ep
> +            - ti,j721e-pcie-ep
> +    then:
> +      properties:
> +        num-lanes:
> +          minimum: 1
> +          maximum: 2
> +
>  required:
>    - compatible
>    - reg
> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> index b0513b197d08..8eca0d08303f 100644
> --- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> @@ -10,9 +10,6 @@ title: TI J721E PCI Host (PCIe Wrapper)
>  maintainers:
>    - Kishon Vijay Abraham I <kishon@ti.com>
>  
> -allOf:
> -  - $ref: "cdns-pcie-host.yaml#"
> -
>  properties:
>    compatible:
>      oneOf:
> @@ -98,6 +95,31 @@ properties:
>        interrupts:
>          maxItems: 1
>  
> +allOf:
> +  - $ref: "cdns-pcie-host.yaml#"

Same here.

> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - ti,am64-pcie-host
> +    then:
> +      properties:
> +        num-lanes:

const: 1



Best regards,
Krzysztof

