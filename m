Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE5563F60A9
	for <lists+linux-pci@lfdr.de>; Tue, 24 Aug 2021 16:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237816AbhHXOlG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Aug 2021 10:41:06 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:35498 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237852AbhHXOlF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Aug 2021 10:41:05 -0400
Received: by mail-ot1-f52.google.com with SMTP id y14-20020a0568302a0e00b0051acbdb2869so39852265otu.2;
        Tue, 24 Aug 2021 07:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Db5yqDC7zDMI6lAlEXopDZgJg3DaWYgaFCxZGGAfV98=;
        b=FrdzVQJx2bdk5jkjThMv/sxcm1Kack6hn/oxroe1dkTbmpvnLzXBbtLx80ce9s4DnZ
         l8R6WNVfhqOUvsMK4HRGlEVvfYjPYl2bxBU26ucwWdqNln4oLqwmwar4orlYiuYobyd0
         BX62FJboMIN77ToCj5j0Cbq8WybyWEGSAd2hCMPFRhQNkqz+jPw0p7qRH7MqRMO7/3o0
         APmgl6N0xmJeL+cYRuI2EAvXbhRfNPbRhoAd6OBsMj7X77RCPxFHmI12BCLGEvtrl2W0
         v80EzdQF1Tcq0vzdwdEk3fo9OMzXAJWwp67PcEMFJ2lDev5IMvGc8bqRXUkxU6SxmG/a
         qNsA==
X-Gm-Message-State: AOAM530Qc/nuRxXIotTvGs7tGaTM8n5NCqoxTUwRf3bIKemVEdorzYIA
        uhZgWNTzTTgE4ZXPNhypZw==
X-Google-Smtp-Source: ABdhPJxL8lFhvCs4+YAUBK3GXu3cNTYj1yhOTdCkzQWFU8HyHnTwBYORe7LWGVm8SsTIOZPAj9OoXg==
X-Received: by 2002:a54:4789:: with SMTP id o9mr2986623oic.50.1629816021257;
        Tue, 24 Aug 2021 07:40:21 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l8sm4147035oom.19.2021.08.24.07.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 07:40:20 -0700 (PDT)
Received: (nullmailer pid 409340 invoked by uid 1000);
        Tue, 24 Aug 2021 14:40:19 -0000
Date:   Tue, 24 Aug 2021 09:40:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rex-BC.Chen@mediatek.com, TingHan.Shen@mediatek.com
Subject: Re: [PATCH] dt-bindings: PCI: mediatek-gen3: Add support for MT8195
Message-ID: <YSUE08dgiGhFsjwH@robh.at.kernel.org>
References: <20210820023521.30716-1-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820023521.30716-1-jianjun.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 20, 2021 at 10:35:21AM +0800, Jianjun Wang wrote:
> MT8195 is an ARM platform SoC which has the same PCIe IP with MT8192.

If it is the same, then 8192 should be a fallback compatible. 'The same' 
means the current driver for 8192 will work unchanged.

> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> index 742206dbd965..dcebb1036207 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> @@ -48,7 +48,9 @@ allOf:
>  
>  properties:
>    compatible:
> -    const: mediatek,mt8192-pcie
> +    oneOf:
> +      - const: mediatek,mt8192-pcie
> +      - const: mediatek,mt8195-pcie
>  
>    reg:
>      maxItems: 1
> -- 
> 2.18.0
> 
> 
