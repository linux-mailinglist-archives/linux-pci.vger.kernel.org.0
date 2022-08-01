Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA27586245
	for <lists+linux-pci@lfdr.de>; Mon,  1 Aug 2022 03:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238881AbiHABkl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 31 Jul 2022 21:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239055AbiHABkX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 31 Jul 2022 21:40:23 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5CB13E98;
        Sun, 31 Jul 2022 18:39:31 -0700 (PDT)
X-UUID: 213dae2b2dec447c8b97c3e895659d9e-20220801
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:ae1fe426-8d54-41d4-b68e-b743b9e7b799,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:0f94e32,CLOUDID:b6fbe4cf-a6cf-4fb6-be1b-c60094821ca2,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 213dae2b2dec447c8b97c3e895659d9e-20220801
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 754513474; Mon, 01 Aug 2022 09:39:24 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 1 Aug 2022 09:39:23 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Mon, 1 Aug 2022 09:39:22 +0800
Message-ID: <989faa34506ab4db8b8ce6eae5457ad07b1a2dee.camel@mediatek.com>
Subject: Re: [PATCH v2] dt-bindings: PCI: mediatek-gen3: Add support for
 MT8188 and MT8195
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Ryder Lee" <ryder.lee@mediatek.com>, <Rex-BC.Chen@mediatek.com>,
        <TingHan.Shen@mediatek.com>, <Liju-clr.Chen@mediatek.com>,
        <Jian.Yang@mediatek.com>
Date:   Mon, 1 Aug 2022 09:39:22 +0800
In-Reply-To: <20220729225320.GA82746-robh@kernel.org>
References: <20220729033331.3075-1-jianjun.wang@mediatek.com>
         <20220729225320.GA82746-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

Thanks for your comment.

On Fri, 2022-07-29 at 16:53 -0600, Rob Herring wrote:
> On Fri, Jul 29, 2022 at 11:33:31AM +0800, Jianjun Wang wrote:
> > MT8188 and MT8195 are ARM platform SoCs with the same PCIe IP as
> > MT8192.
> > 
> > Also add new clock name "peri_mem" since the MT8188 and MT8195 use
> > clock
> > "peri_mem" instead of "top_133m".
> > 
> > Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> > ---
> > Changes in v2:
> > Merge two patches into one.
> > ---
> >  .../bindings/pci/mediatek-pcie-gen3.yaml      | 51
> > +++++++++++++++----
> >  1 file changed, 40 insertions(+), 11 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-
> > gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-
> > gen3.yaml
> > index 0499b94627ae..038e25ae0be7 100644
> > --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> > +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> > @@ -43,12 +43,16 @@ description: |+
> >    each set has its own address for MSI message, and supports 32
> > MSI vectors
> >    to generate interrupt.
> >  
> > -allOf:
> > -  - $ref: /schemas/pci/pci-bus.yaml#
> > -
> >  properties:
> >    compatible:
> > -    const: mediatek,mt8192-pcie
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - mediatek,mt8188-pcie
> > +              - mediatek,mt8195-pcie
> > +          - const: mediatek,mt8192-pcie
> > +      - items:
> > +          - const: mediatek,mt8192-pcie
> >  
> >    reg:
> >      maxItems: 1
> > @@ -78,13 +82,7 @@ properties:
> >      maxItems: 6
> >  
> >    clock-names:
> > -    items:
> > -      - const: pl_250m
> > -      - const: tl_26m
> > -      - const: tl_96m
> > -      - const: tl_32k
> > -      - const: peri_26m
> > -      - const: top_133m
> > +    maxItems: 6
> >  
> >    assigned-clocks:
> >      maxItems: 1
> > @@ -126,9 +124,40 @@ required:
> >    - interrupts
> >    - ranges
> >    - clocks
> > +  - clock-names
> >    - '#interrupt-cells'
> >    - interrupt-controller
> >  
> > +allOf:
> > +  - $ref: /schemas/pci/pci-bus.yaml#
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - mediatek,mt8188-pcie
> > +              - mediatek,mt8195-pcie
> > +    then:
> > +      properties:
> > +        clock-names:
> > +          items:
> > +            - const: pl_250m
> > +            - const: tl_26m
> > +            - const: tl_96m
> > +            - const: tl_32k
> > +            - const: peri_26m
> > +            - const: peri_mem
> > +    else:
> > +      properties:
> > +        clock-names:
> > +          items:
> > +            - const: pl_250m
> > +            - const: tl_26m
> > +            - const: tl_96m
> > +            - const: tl_32k
> > +            - const: peri_26m
> > +            - const: top_133m
> 
> I'm not sure it's worth enforcing just the last clock name. Just do:
> 
> enum: [ peri_mem, top_133m ]
> 
> And key in the top level.
OK, I'll use "enum" to add the new clock name in the next version.

Thanks.
> 
> Rob

