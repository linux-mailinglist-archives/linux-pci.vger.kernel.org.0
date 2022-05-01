Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0EC516328
	for <lists+linux-pci@lfdr.de>; Sun,  1 May 2022 10:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344912AbiEAIt1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 1 May 2022 04:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382115AbiEAItN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 1 May 2022 04:49:13 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE5932D
        for <linux-pci@vger.kernel.org>; Sun,  1 May 2022 01:45:10 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z19so13522421edx.9
        for <linux-pci@vger.kernel.org>; Sun, 01 May 2022 01:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EfLbZnKHGkYEiRqrqELv1JHaDPFDY5n+c9cXTFfSJ0E=;
        b=mG0NFqWIJLRl7mAjencG13lKoZDFfhX82IymWESPkrsKtgsIkRSuyPeGZHuG4Cigaj
         nItkEHsguH+4QU8UmwYSM51iw5jlzCW3oAM5hBOnttJVtr3AFRbv3Uj/4YD3u20mcUey
         A+325JQ25uXgJ4u68ZO64bO1Xzy9HE21+hjWrMeLPitp/EYtgTFPoWYWd30xQXtfCsul
         hObDlFPceqLZcbt/f+VAbr7RrQu8tKGkDQ7XmmnbSNg6JSOCfTD5UWg1DCjSTRaIoQVK
         5MiFJEl5/qVJ7zBd4rPyA+AYdG1lwi/0bG2uHzNIIdOTSxgAH9qBrXIuBIW8fK1uo6Wl
         iuyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EfLbZnKHGkYEiRqrqELv1JHaDPFDY5n+c9cXTFfSJ0E=;
        b=opbkSoJMO1ZOAx2ZnQfotdFSeEL8DeuxaPeAIvnHQcdnLaH5t/FUlsahXsRZkO/fXH
         INzoT6/4WDzAnifOyN9IFmIqcSmDDugt2gjNlceBYPHv/PMbdOubnrubqorcQ5fU+F7j
         0hcDmdkPv2LkTaQw1k+Rku9tRZzTJi9Bl0G8CPxitPrRvDUuZEUi7VwAnKpjmh57kFKi
         XJsB/bxa5H7oZD/53OwTdcRHOlRsuldPNLc1SMN+xQsyA5QEYOF1zONKqVIGDFJIzc6r
         inkh5R6Vzxx6DfgfldYtzOKcivgyw8wLnAuSfs5wSQWJNsxrMjGK17iCEO51Ui1RGRH/
         aZJg==
X-Gm-Message-State: AOAM530HB7VZBTChFCMVI5cTJED0kL9sjhXRR1rkmQFu/ojq2X0taYeQ
        trX0CzW0s9xeGiQhYdVYVUb4iQ==
X-Google-Smtp-Source: ABdhPJw9CCShcC37kfCL+gl0bgsIs8A53CVSZFH89+Fb2GuexiRCeerbLJzlc8FhUIUEEYZBjj++4Q==
X-Received: by 2002:a05:6402:524e:b0:423:e919:8eb4 with SMTP id t14-20020a056402524e00b00423e9198eb4mr7958434edd.153.1651394708439;
        Sun, 01 May 2022 01:45:08 -0700 (PDT)
Received: from [192.168.0.182] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gz26-20020a170907a05a00b006f3ef214dd7sm2366054ejc.61.2022.05.01.01.45.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 May 2022 01:45:08 -0700 (PDT)
Message-ID: <1179dd78-b2c0-4c2d-edef-b4903586950a@linaro.org>
Date:   Sun, 1 May 2022 10:45:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 2/6] dt-bindings: PCI: renesas,pci-rcar-gen2: Add
 device tree support for r9a06g032
Content-Language: en-US
To:     Herve Codina <herve.codina@bootlin.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Cc:     Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <20220428151630.586009-1-herve.codina@bootlin.com>
 <20220428151630.586009-3-herve.codina@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220428151630.586009-3-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 28/04/2022 17:16, Herve Codina wrote:
> Add internal PCI bridge support for the r9a06g032 SOC. The Renesas
> RZ/N1D (R9A06G032) internal PCI bridge is compatible with the one
> present in the R-Car Gen2 family.
> Compared to the R-Car Gen2 family, it needs three clocks instead of
> one.
> 
> The 'resets' property for the RZ/N1 family is not required since
> there is no reset-controller support yet for the RZ/N1 family.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../bindings/pci/renesas,pci-rcar-gen2.yaml   | 46 ++++++++++++++++---
>  1 file changed, 39 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml b/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml
> index 494eb975c146..90b42d44c582 100644
> --- a/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml
> +++ b/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml
> @@ -32,6 +32,10 @@ properties:
>                - renesas,pci-r8a7793      # R-Car M2-N
>                - renesas,pci-r8a7794      # R-Car E2
>            - const: renesas,pci-rcar-gen2 # R-Car Gen2 and RZ/G1
> +      - items:
> +          - enum:
> +              - renesas,pci-r9a06g032     # RZ/N1D
> +          - const: renesas,pci-rzn1       # RZ/N1
>  
>    reg:
>      items:
> @@ -41,13 +45,9 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  clocks:
> -    items:
> -      - description: Device clock
> +  clocks: true
>  
> -  clock-names:
> -    items:
> -      - const: pclk
> +  clock-names: true
>  
>    resets:
>      maxItems: 1
> @@ -106,13 +106,45 @@ required:
>    - interrupt-map
>    - interrupt-map-mask
>    - clocks
> -  - resets
>    - power-domains
>    - bus-range
>    - "#address-cells"
>    - "#size-cells"
>    - "#interrupt-cells"
>  
> +if:

This should be better within allOf block. It's likely that it will be
extended later.

Best regards,
Krzysztof
