Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAD5632AA2
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 18:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbiKURQV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 12:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiKURPt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 12:15:49 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C56CC8C90;
        Mon, 21 Nov 2022 09:13:53 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id n3so4296778wrp.5;
        Mon, 21 Nov 2022 09:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iOdZm+t0ZjNb9E1ZMCmZ/u5jw9aDGTn6ypSEA7WGmII=;
        b=Bri+YqkxR9A7oBnDSBN5S+vyOvU73bMGjpOqXuh54mO57W/8vv2dISgFfJOv3GVPOO
         oprFGOYKvPDkUXBkinoQBz9ugVtWHtbvoxjmtsz8uoKHrn3o4h7g8HzFMT7pZSWm3tQl
         ClJNBQoFkCPAL0MU349QGlUMLQGqPY86xykMZKCWkbcHBRDAz2s9EzUbcjmMdXrFaeWy
         KXJLqSv1NIG7+lIf0t23v2cu1b2bFHGZMN8NVVK6CAXLcA04FgEkSIorOTi9/NgTZfPk
         2ZWmQ/1KOoaRIrZVUtuN5dcjuJheAkvjOXD8diWI7ljW/v9ofHCjrFQZKA5aY3kxeK6O
         TpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iOdZm+t0ZjNb9E1ZMCmZ/u5jw9aDGTn6ypSEA7WGmII=;
        b=ZelV5ALgDxQc9l73EThonb7YOuonhjnLD2RrueobYNmgdWxdan8zUueLoojpFY9WNh
         6Dkl3YCkizBZrFbVjvHSrp1azrsmsPVgXBC5VLrjngCnCXoGrtwsiCk63dJxZrBxNthJ
         iPpzrE4Lmvp/sxViL7mrFHa358dlGPQFwaOH2qrWymKpKINQQqk7jcwsyqaGfLoFOuvh
         Wfmo8aLIB6HN7wzm7/8t42ITi6AY67poy0XJNmAbgB+IMRK5KeccFWKX1nVJj7QM08Ar
         u9qpgC/S0XBMgOE3p6D1Rdl2QsfrrzwrGTUypNEaMkPTv+WZc+tVC3rUJsHDFQq/FtsV
         vzcA==
X-Gm-Message-State: ANoB5pnGctMdzYfeOgpCpReA0XBSq1As2xs/PZfBGGFiMOHWbfGvZbWv
        vWkDWEPY9QcySJl7hEGWGYY=
X-Google-Smtp-Source: AA0mqf4hbwsmtUuhLGr69LHoOQQEqvX+EvI7mtwqoCP9NL9TQavoW8740rWW99QiGdXzv6vfRPk5aw==
X-Received: by 2002:a05:6000:10c6:b0:241:d021:52d3 with SMTP id b6-20020a05600010c600b00241d02152d3mr4812424wrx.540.1669050831503;
        Mon, 21 Nov 2022 09:13:51 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id 4-20020a05600c020400b003b492753826sm13911425wmi.43.2022.11.21.09.13.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 09:13:50 -0800 (PST)
Message-ID: <ef9c585f-37fd-f1f4-032b-20680bda1865@gmail.com>
Date:   Mon, 21 Nov 2022 18:13:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 05/11] dt-bindings: PCI: mediatek-gen3: add support for
 mt7986
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Bo Jiao <Bo.Jiao@mediatek.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-usb@vger.kernel.org,
        Rob Herring <robh@kernel.org>
References: <20221118190126.100895-1-linux@fw-web.de>
 <20221118190126.100895-6-linux@fw-web.de>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221118190126.100895-6-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 18/11/2022 20:01, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add compatible string and clock-definition for mt7986. It needs 4 clocks
> for PCIe, define them in binding.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Jianjun Wang <jianjun.wang@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
> v2:
> - squashed patch 2+3 (compatible and clock definition)
> ---
>   .../bindings/pci/mediatek-pcie-gen3.yaml        | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> index 5d7369debff2..f7a02019daea 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> @@ -48,6 +48,7 @@ properties:
>       oneOf:
>         - items:
>             - enum:
> +              - mediatek,mt7986-pcie
>                 - mediatek,mt8188-pcie
>                 - mediatek,mt8195-pcie
>             - const: mediatek,mt8192-pcie
> @@ -78,9 +79,11 @@ properties:
>         - const: mac
>   
>     clocks:
> +    minItems: 4
>       maxItems: 6
>   
>     clock-names:
> +    minItems: 4
>       maxItems: 6
>   
>     assigned-clocks:
> @@ -160,6 +163,20 @@ allOf:
>               - const: tl_32k
>               - const: peri_26m
>               - const: peri_mem
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt7986-pcie
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: pl_250m
> +            - const: tl_26m
> +            - const: peri_26m
> +            - const: top_133m
>   
>   unevaluatedProperties: false
>   
