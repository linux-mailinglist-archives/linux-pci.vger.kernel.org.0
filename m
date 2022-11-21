Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CE9632A3E
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 18:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiKURFJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 12:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiKURFI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 12:05:08 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4203AC7689;
        Mon, 21 Nov 2022 09:05:04 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id s5so3606097wru.1;
        Mon, 21 Nov 2022 09:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HF+73ogBzWs8DDzLDd+FEDAjvGpR1m7S0//62sPrjlY=;
        b=OUJgA3S2aZb+ri5c3O7yA7l0Mjtqeek0zbSx7dMRR9INwoh3Bdflde+TnimyTyAlMD
         GB0XTN4B0TSg02dFqLy+Bp7sWpzaIOk5Ys6kcO9S/8/zHbsy7Bbp29MtAS1y40+mtp1Y
         7QZmQEXPIZpRD7fp9zHn9nBbcbqXXZ/XKmk9xl4OIC/50zW5eCJNgtHTZeXtx1XJwWg4
         X2NTGKcUqNZxWvvXSuSELljBI0zh7LxkYWCJQTuVe5HqLkj5J90eobBQkI3bnXbq8n4k
         0xlDf2RO2QbztOGNtjdjjzxhJ6yaZkglY+Bp2tiKlZliK19Vj2EDwLqTlmGIN/oFGPzy
         IR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HF+73ogBzWs8DDzLDd+FEDAjvGpR1m7S0//62sPrjlY=;
        b=EFTTvUM3h2Bx7zOL7nXiw/BqYVunVVJDOf28xdd5QHpllxGNNHHZQzXEhDtlKvmtoF
         Wm/GVUYMpKAzKWeUfEAnvRMhkO/KyDsbLB9dAilvUrGzNhNlPZot7N0ffoIFQMJ/QwBi
         taSQAdPa11Z0020oSyfAs7qC5734QwnpKtaHuGZiy6b0Tj0ncT3zquWdZsZb9BzkucNK
         FesDMEykP8sJ2TRVWCCxxr+4y5Ygo1swfiPlT5BwdKHxrS6fsUtzOz0TtHSSIdXVrmoJ
         CQY17j7WW63DmBVgjHNfxHOVM1XY7DHS9DPYsUUUqB5WGnx3ktqo7GZJ86WVG1FdT729
         OHSQ==
X-Gm-Message-State: ANoB5pkT7obQxqc4OfW/TGR0R1XIkcoBL9IRC0WUWz+ZG6AVHi35Pjci
        NDjbkhxfM+P2MaRcNrtQlqw00cdcMI4=
X-Google-Smtp-Source: AA0mqf53nBW4skLAA48WXUrRkzCcN0nS6afComO+HSp5ZD0DW3QxL/O4VQJJ/fjiaY6TMjLwbNDEDw==
X-Received: by 2002:a05:6000:910:b0:236:56a9:65cc with SMTP id bz16-20020a056000091000b0023656a965ccmr11771192wrb.563.1669050302593;
        Mon, 21 Nov 2022 09:05:02 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id y15-20020a1c4b0f000000b003cf7292c553sm14233688wma.13.2022.11.21.09.04.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 09:05:01 -0800 (PST)
Message-ID: <df18d619-1914-6dcf-a0be-647ed8cd703b@gmail.com>
Date:   Mon, 21 Nov 2022 18:04:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 03/11] dt-bindings: usb: mtk-xhci: add support for
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
 <20221118190126.100895-4-linux@fw-web.de>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221118190126.100895-4-linux@fw-web.de>
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
>   Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> index 939623867a64..a3c37944c630 100644
> --- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> +++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> @@ -28,6 +28,7 @@ properties:
>             - mediatek,mt7622-xhci
>             - mediatek,mt7623-xhci
>             - mediatek,mt7629-xhci
> +          - mediatek,mt7986-xhci
>             - mediatek,mt8173-xhci
>             - mediatek,mt8183-xhci
>             - mediatek,mt8186-xhci
