Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CD961380A
	for <lists+linux-pci@lfdr.de>; Mon, 31 Oct 2022 14:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiJaN3C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Oct 2022 09:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiJaN3A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Oct 2022 09:29:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E391FD31;
        Mon, 31 Oct 2022 06:28:59 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 953686602040;
        Mon, 31 Oct 2022 13:28:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667222938;
        bh=9ps5B31edxR0GepExY4h3W2psR6P8vyTX43U+/2T3mo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oo5AyVFdBpKrzCOAmHR088kRNw8TfdgZCNvEVkfw3Lk6w2lGN3SdSqrfjz+yv4Cc8
         9Nb/97sRv1Jnr57Ai+w25rn7yvWYIUsZELHaR+0gy2ZCwPv4MaAxPml749f6iCe4uD
         HxwRDpnhl/vvg0fJPAIak8vfi+7ocXJBXkv05NpvfapoVkiP+XnHZXFe4qNgSdwZ+/
         IuUlp8c7geAKrPFzzbDX6ZIt0sUVCuTQHBrQLjytDFbTuluMGh2j8ZC1j3JT3P+PNn
         7VWil59o3jMeG86tqF9uf/riOSb+ZJt0ufmjcQROPeLjNx1PElFyyIRBWX0aW2uTJG
         Abbok2EoW8H/Q==
Message-ID: <9da05c64-87bb-39c7-6c23-e4918bd5024b@collabora.com>
Date:   Mon, 31 Oct 2022 14:28:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v4 1/3] dt-bindings: PCI: mediatek-gen3: Support mt8195
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221028094317.29270-1-tinghan.shen@mediatek.com>
 <20221028094317.29270-2-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221028094317.29270-2-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Il 28/10/22 11:43, Tinghan Shen ha scritto:
> From: Jianjun Wang <jianjun.wang@mediatek.com>
> 
> In order to support mt8195 pcie node, update the yaml to support new
> properties of iommu and power-domain, and update the reset-names
> property to allow only one 'mac' name.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> Signed-off-by: TingHan Shen <tinghan.shen@mediatek.com>
> ---
>   .../bindings/pci/mediatek-pcie-gen3.yaml         | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> index c00be39af64e..a9013c10131a 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> @@ -70,14 +70,21 @@ properties:
>       minItems: 1
>       maxItems: 8
>   
> +  iommu-map:
> +    maxItems: 1
> +
> +  iommu-map-mask:
> +    const: 0
> +
>     resets:
>       minItems: 1
>       maxItems: 2
>   
>     reset-names:
> -    minItems: 1
> -    items:
> -      - const: phy
> +    oneOf:
> +      - items:
> +          - const: phy
> +          - const: mac
>         - const: mac

Sorry, this looks a bit messy.

I can propose two solutions, either:

reset-names:
   minItems: 1
   items:
     - const: mac
     - const: phy
... and change the order in mt8192.dtsi;

otherwise, something like
allOf:
   - if:
      properties:
        compatible:
          contains:
            - const: mediatek,mt8195-pcie
     ... invert reset-names

I think that the first solution makes a bit more sense though, as the
PHY reset may be moved in a PCIE-PHY specific driver instead of being
managed here in pci-mediatek-gen3.

Regards,
Angelo


