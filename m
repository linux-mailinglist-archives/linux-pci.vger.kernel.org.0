Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEBF610D13
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 11:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiJ1JZc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Oct 2022 05:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiJ1JZG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2022 05:25:06 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9056445063;
        Fri, 28 Oct 2022 02:24:46 -0700 (PDT)
X-UUID: 35275e1cbcb14f7da379c244e72f9504-20221028
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ufhGul3EHDWt6vGqX7ebDIkN1/wWifIISfjdZ6no5xY=;
        b=grNzHjgJuxZmbVZ7R7lEWtBSoxPv1TzgR2jwaLNavK6X+cy4N5x2PgM0nvhI8GgjrugHH0NBorEUEKPyrvAlw8BMCxDVbQYKtVAc8uJdLXHu0TO7FnsrngEoOsn/UEViKrh3PFF5ndtXmcWnpIGsYyZ3Ex8agQW+CVPOcK8HcwY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:6107df12-ef3e-413f-b84e-87eecb3bcb7e,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:40
X-CID-INFO: VERSION:1.1.12,REQID:6107df12-ef3e-413f-b84e-87eecb3bcb7e,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:40
X-CID-META: VersionHash:62cd327,CLOUDID:7d74ef80-3116-4fbc-b86b-83475c3df513,B
        ulkID:221028172441ZCOWV2TN,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48|102,
        TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:
        0
X-UUID: 35275e1cbcb14f7da379c244e72f9504-20221028
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 645103608; Fri, 28 Oct 2022 17:24:38 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 28 Oct 2022 17:24:38 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs13n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 28 Oct 2022 17:24:37 +0800
Message-ID: <61c0b62af62ddd0e98378159db2b7d94022c9bf5.camel@mediatek.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: mediatek-gen3: add SoC based
 clock config
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Frank Wunderlich <linux@fw-web.de>,
        <linux-mediatek@lists.infradead.org>
CC:     Frank Wunderlich <frank-w@public-files.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>
Date:   Fri, 28 Oct 2022 17:24:36 +0800
In-Reply-To: <20221025072837.16591-2-linux@fw-web.de>
References: <20221025072837.16591-1-linux@fw-web.de>
         <20221025072837.16591-2-linux@fw-web.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Frank,

After apply this patch, we found some dtbs_check error with the
following patch which adds the PCIe node for MT8195:

https://lore.kernel.org/linux-pci/20221020111925.30002-3-tinghan.shen@mediatek.com/

arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dtb: pcie@112f0000
: clock-names:        5: 'top_133m' was expected
    From schema: Documentation/devicetree/bindings/pci/mediatek-pcie-
gen3.yaml
arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dtb: pcie@112f8000
: clock-names:        5: 'top_133m' was expected
    From schema: Documentation/devicetree/bindings/pci/mediatek-pcie-
gen3.yaml

Did you get the same error when adding the PCIe node for MT7986?

Thanks. 

On Tue, 2022-10-25 at 09:28 +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> The PCIe driver covers different SOC which needing different clock
> configs. Define them based on compatible.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> v2:
> - fix typo in mediatek,mt8192-pcie
> ---
>  .../bindings/pci/mediatek-pcie-gen3.yaml      | 48 ++++++++++++++---
> --
>  1 file changed, 36 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-
> gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-
> gen3.yaml
> index c00be39af64e..98d3f0f1cd76 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> @@ -43,9 +43,6 @@ description: |+
>    each set has its own address for MSI message, and supports 32 MSI
> vectors
>    to generate interrupt.
>  
> -allOf:
> -  - $ref: /schemas/pci/pci-bus.yaml#
> -
>  properties:
>    compatible:
>      oneOf:
> @@ -84,15 +81,7 @@ properties:
>      maxItems: 6
>  
>    clock-names:
> -    items:
> -      - const: pl_250m
> -      - const: tl_26m
> -      - const: tl_96m
> -      - const: tl_32k
> -      - const: peri_26m
> -      - enum:
> -          - top_133m        # for MT8192
> -          - peri_mem        # for MT8188/MT8195
> +    maxItems: 6
>  
>    assigned-clocks:
>      maxItems: 1
> @@ -138,6 +127,41 @@ required:
>    - '#interrupt-cells'
>    - interrupt-controller
>  
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt8192-pcie
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: pl_250m
> +            - const: tl_26m
> +            - const: tl_96m
> +            - const: tl_32k
> +            - const: peri_26m
> +            - const: top_133m
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt8188-pcie
> +              - mediatek,mt8195-pcie
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: pl_250m
> +            - const: tl_26m
> +            - const: tl_96m
> +            - const: tl_32k
> +            - const: peri_26m
> +            - const: peri_mem
> +
>  unevaluatedProperties: false
>  
>  examples:

