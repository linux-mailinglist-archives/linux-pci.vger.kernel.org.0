Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4B65967AE
	for <lists+linux-pci@lfdr.de>; Wed, 17 Aug 2022 05:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbiHQDOB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 23:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiHQDOA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 23:14:00 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7629D5D113;
        Tue, 16 Aug 2022 20:13:52 -0700 (PDT)
X-UUID: f38c1a2bf4f148fe9c7f0f10077d1e83-20220817
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=DxniUy+/X99gAlGwCbWLlenlcjZNB+qTT48tMczTJeM=;
        b=jSsti5YQoBF3UZa4UiISJl+jMVgBi1Nu/koitx69bT3MU9bD2KFMui9Z6TwxDxAcxhmXBf5j1eY0GLvl1sRRc0bKS8JzQV1UpAddojxyvr85cEDGjKpZOVEb9J9XhJpZwVCKaRVB0UJobEB3SAfb67KP4N1PZsecC2DrdxPgnvg=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:e91c9c94-4efe-4b2a-9d01-d22d81e4bf30,OB:10,
        LOB:0,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:2,SF:54,FILE:0,BULK:0,RULE:Relea
        se_Ham,ACTION:release,TS:56
X-CID-INFO: VERSION:1.1.10,REQID:e91c9c94-4efe-4b2a-9d01-d22d81e4bf30,OB:10,LO
        B:0,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:2,SF:54,FILE:0,BULK:0,RULE:Release
        _HamU,ACTION:release,TS:56
X-CID-META: VersionHash:84eae18,CLOUDID:d1a3e29c-da39-4e3b-a854-56c7d2111b46,C
        OID:0dbe88b70084,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: f38c1a2bf4f148fe9c7f0f10077d1e83-20220817
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 588178327; Wed, 17 Aug 2022 11:13:48 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 17 Aug 2022 11:13:47 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Wed, 17 Aug 2022 11:13:46 +0800
Message-ID: <e330820facd95af02e491bffd41aa9f468d8751e.camel@mediatek.com>
Subject: Re: [PATCH v4] dt-bindings: PCI: mediatek-gen3: Add support for
 MT8188 and MT8195
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>, <Rex-BC.Chen@mediatek.com>,
        <TingHan.Shen@mediatek.com>, <Liju-clr.Chen@mediatek.com>,
        <Jian.Yang@mediatek.com>
Date:   Wed, 17 Aug 2022 11:13:46 +0800
In-Reply-To: <20220802120624.19258-1-jianjun.wang@mediatek.com>
References: <20220802120624.19258-1-jianjun.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Maintainers,

Gentle ping for this patch, if there is anything I need to modify,
please kindly let me know.

Thanks.

On Tue, 2022-08-02 at 20:06 +0800, Jianjun Wang wrote:
> MT8188 and MT8195 are ARM platform SoCs with the same PCIe IP as
> MT8192.
> 
> Also add new clock name "peri_mem" since the MT8188 and MT8195 use
> clock
> "peri_mem" instead of "top_133m".
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> ---
> Changes in v4:
> Remove "items" for "mediatek,mt8192-pcie" since it only have one
> item.
> 
> Changes in v3:
> Use enum property to add the new clock name.
> 
> Changes in v2:
> Merge two patches into one.
> ---
>  .../devicetree/bindings/pci/mediatek-pcie-gen3.yaml | 13
> +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-
> gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-
> gen3.yaml
> index 0499b94627ae..c00be39af64e 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> @@ -48,7 +48,13 @@ allOf:
>  
>  properties:
>    compatible:
> -    const: mediatek,mt8192-pcie
> +    oneOf:
> +      - items:
> +          - enum:
> +              - mediatek,mt8188-pcie
> +              - mediatek,mt8195-pcie
> +          - const: mediatek,mt8192-pcie
> +      - const: mediatek,mt8192-pcie
>  
>    reg:
>      maxItems: 1
> @@ -84,7 +90,9 @@ properties:
>        - const: tl_96m
>        - const: tl_32k
>        - const: peri_26m
> -      - const: top_133m
> +      - enum:
> +          - top_133m        # for MT8192
> +          - peri_mem        # for MT8188/MT8195
>  
>    assigned-clocks:
>      maxItems: 1
> @@ -126,6 +134,7 @@ required:
>    - interrupts
>    - ranges
>    - clocks
> +  - clock-names
>    - '#interrupt-cells'
>    - interrupt-controller
>  

