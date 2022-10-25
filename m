Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FD160C140
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 03:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiJYBoF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Oct 2022 21:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiJYBnf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Oct 2022 21:43:35 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F413F45056;
        Mon, 24 Oct 2022 18:27:34 -0700 (PDT)
X-UUID: 52a8a363e02d4cd98a3512feb9350419-20221025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=6Gu0ND/jwgTDHnSCh5YQ1qm3jVdaf3TxXKNSqR5nggI=;
        b=Xo8v005oovr0OaDxPzDQ6sd8Pc042Z8bNtRsWhhxg4MOz67rVrOvahbshSLk27xS3jDlQQf/YJdSAZXxAdL+9/3W0ZYQZ1t66fUAovc097pquLrPwBegeFOUrX5Qxrqq+6Hej8L6f+wA0W87UWH/uH5gtAbrz0ovV6UyFtZRUes=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:a2c47874-7e6b-4441-836d-523b4307cdaf,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:a7f289e4-e572-4957-be22-d8f73f3158f9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 52a8a363e02d4cd98a3512feb9350419-20221025
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 457710875; Tue, 25 Oct 2022 09:27:30 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 25 Oct 2022 09:27:28 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Tue, 25 Oct 2022 09:27:28 +0800
Message-ID: <9759df8a6fbe30bfbd0df72793b751b7628006bc.camel@mediatek.com>
Subject: Re: [PATCH 1/3] dt-bindings: PCI: mediatek-gen3: add SoC based
 clock config
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Frank Wunderlich <linux@fw-web.de>,
        <linux-mediatek@lists.infradead.org>
CC:     Frank Wunderlich <frank-w@public-files.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sam Shih <Sam.Shih@mediatek.com>,
        Steven Liu <steven.liu@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 25 Oct 2022 09:27:27 +0800
In-Reply-To: <20221023170234.83621-2-linux@fw-web.de>
References: <20221023170234.83621-1-linux@fw-web.de>
         <20221023170234.83621-2-linux@fw-web.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 2022-10-23 at 19:02 +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> The PCIe driver covers different SOC which needing different clock
> configs. Define them based on compatible.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  .../bindings/pci/mediatek-pcie-gen3.yaml      | 48 ++++++++++++++---
> --
>  1 file changed, 36 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-
> gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-
> gen3.yaml
> index c00be39af64e..af0d2201746d 100644
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
> +            const: mediatek,mt8192-mmc

This should be "mediatek,mt8192-pcie".

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

