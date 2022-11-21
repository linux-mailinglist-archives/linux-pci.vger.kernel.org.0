Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E29632A39
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 18:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiKURFA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 12:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiKURE6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 12:04:58 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E1AC72D0;
        Mon, 21 Nov 2022 09:04:57 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id j5-20020a05600c410500b003cfa9c0ea76so9481550wmi.3;
        Mon, 21 Nov 2022 09:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PLhvLLxdnr82yFgkcTDUhrmPJ/2i+VJZ5fXC3LePZUI=;
        b=gcABP5CoXN7ynrdgJn1f4C4bB7+xxVA/eSyGbcs3RWFf/rp0Rjfau7KV0Jpg1/Aa9Z
         SxJAcOcIL3CKcI9sQOk4/lsN09MhXCSkLT2fz/LlzK3BSU0vzdQn9e+hosHVqEsIXbeZ
         FxbHCOPsEp7kXVLkrGq6fzl3wwyW76s0gjTN1NnV8xRLKUfvlfogAKrJ5IkdBWOSYwnG
         zfPhsv2CYFcbpXegykj6P9p15t7KcwdchTdcglmhQMfZLbFQ/E49IeB5kBr+ShCZAey1
         sciCIOvUUMwRLtBqx5diwGlWHcRAKVhN+ikOMOcFxrSvuw5XBpBWcpz6fc3OtNB0I0+w
         bv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PLhvLLxdnr82yFgkcTDUhrmPJ/2i+VJZ5fXC3LePZUI=;
        b=tynBiCMLdKMXyyv2skZwXFKXT46Rpjbzzsxpwdyl09623j5D4BWPzLrAlKmKulwPpA
         1/lDHEk2EV5uJeIihURU6QGAm1IX7VzDZ129wytUbB86dNHRMcWPZ91q8B7jfjxukcqG
         KzsSbof9dimmP3hwe4W4gxjqBY40K8Vy8ZZMn/29Prl0hjF/+GIUZzzzv+N5ntsaZu5S
         O/oKPIItFrF+iTgAaIPXR/GMUj6isNdNeyRwHV/I+RrlaRKpGTLyCBfwRbFc5xXvri8k
         25rdKakH59I2xk12m8yOZ6LLoKhCp1XMZOszFcUxZtUOr3Aejvlsbj/oQNgTJRxTnNIi
         xYuA==
X-Gm-Message-State: ANoB5pkIORFJj2rrqae3/SmXEKwBD4SuaAeRw92Y8J/FkAohPPP3WFZo
        AOr7SWXTAjRR4zW9Vy4+WWs=
X-Google-Smtp-Source: AA0mqf7jXBGPovWHgEF0yL5d09f1cRbLRadoicFFPQ5P6vSaIEjcofGj5md04kELqxA0my3TLDwuQA==
X-Received: by 2002:a1c:7318:0:b0:3cf:cb16:f24a with SMTP id d24-20020a1c7318000000b003cfcb16f24amr16687766wmb.182.1669050295782;
        Mon, 21 Nov 2022 09:04:55 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id z11-20020a05600c0a0b00b003c6f1732f65sm21161090wmp.38.2022.11.21.09.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 09:04:54 -0800 (PST)
Message-ID: <a002bf30-2f39-48a7-d339-bc4740e9e2d8@gmail.com>
Date:   Mon, 21 Nov 2022 18:04:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 02/11] dt-bindings: phy: mediatek,tphy: add support for
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
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
References: <20221118190126.100895-1-linux@fw-web.de>
 <20221118190126.100895-3-linux@fw-web.de>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221118190126.100895-3-linux@fw-web.de>
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
> Add compatible string for mt7986.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   Documentation/devicetree/bindings/phy/mediatek,tphy.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> index 5613cc5106e3..230a17f24966 100644
> --- a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> +++ b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> @@ -79,6 +79,7 @@ properties:
>             - enum:
>                 - mediatek,mt2712-tphy
>                 - mediatek,mt7629-tphy
> +              - mediatek,mt7986-tphy
>                 - mediatek,mt8183-tphy
>                 - mediatek,mt8186-tphy
>                 - mediatek,mt8192-tphy
