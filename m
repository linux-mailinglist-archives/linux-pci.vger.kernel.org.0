Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43EBF3F6098
	for <lists+linux-pci@lfdr.de>; Tue, 24 Aug 2021 16:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237910AbhHXOju (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Aug 2021 10:39:50 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:45002 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237821AbhHXOjr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Aug 2021 10:39:47 -0400
Received: by mail-ot1-f50.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so38128475otg.11;
        Tue, 24 Aug 2021 07:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oJTjVdGamrFwSnS4XYHRrrAclccvRhahcNOf3uZWcog=;
        b=UuMjMBqVHaKyQTJfSlfdrZQJCI4jWGIvVNBljGApFiHdgL8Daf+/iWtCZoWCBqEfky
         NJr0/KSVfAOc7OhBRE+nOFgpBqOWFA4hsIG87TpGtZGJ5M/NWidxgwZwjovm9dNBjJKJ
         2/J9kGMxWWRAZS4Zb8KDnnjTXEblkAsDHLhzPcxB0J15Xko889rStJTkEKiZtv2UzbJg
         2jwOgxbYueYJf9raBdajwWQiWTlOCTOHfkC76AyVgS9KEq7DQfFJWbsl15O83uu3StEp
         AEbAC5HjjjJLxi9GwbiLEXTNFUXJnDS3X7llEoR50or/JhtCBqVzz/xqWsZBt/lzZlEL
         BxtA==
X-Gm-Message-State: AOAM531c/1fWoKNcE129YY2+IjP3CpiWzfoJ1XK+1LN30hZOXr+H+Bz/
        60Wo+SaGbnEaFBfAo6FvHg==
X-Google-Smtp-Source: ABdhPJyWxAQYVSvp5dfYC1MVG4wcDA3+xadxULnBKqwxP7AbYTYs6hbMs3GS17peHFiEsVBo69cv8g==
X-Received: by 2002:a05:6830:238e:: with SMTP id l14mr31227924ots.354.1629815943350;
        Tue, 24 Aug 2021 07:39:03 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i5sm4396860oie.11.2021.08.24.07.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 07:39:02 -0700 (PDT)
Received: (nullmailer pid 407321 invoked by uid 1000);
        Tue, 24 Aug 2021 14:39:01 -0000
Date:   Tue, 24 Aug 2021 09:39:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rex-BC.Chen@mediatek.com, TingHan.Shen@mediatek.com
Subject: Re: [PATCH] dt-bindings: PCI: mediatek-gen3: Add support for MT8195
Message-ID: <YSUEhTbzz9x1UeaB@robh.at.kernel.org>
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

Use 'enum' instead of oneOf+const.

>  
>    reg:
>      maxItems: 1
> -- 
> 2.18.0
> 
> 
