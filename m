Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1832057C6AC
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 10:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbiGUIoZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 04:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbiGUIoX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 04:44:23 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27C07E83D;
        Thu, 21 Jul 2022 01:44:15 -0700 (PDT)
X-UUID: 9534c6f209ec44d5969eaadb28c68965-20220721
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:c9883684-0d3a-4178-b20a-97f88d358bd2,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:0f94e32,CLOUDID:3bf49333-b9e4-42b8-b28a-6364427c76bb,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 9534c6f209ec44d5969eaadb28c68965-20220721
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 36381845; Thu, 21 Jul 2022 16:44:10 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 21 Jul 2022 16:44:09 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 21 Jul 2022 16:44:08 +0800
Message-ID: <0f02af3abf6895ae89f735d849a1873e61ca502a.camel@mediatek.com>
Subject: Re: [PATCH 2/2] dt-bindings: PCI: mediatek-gen3: Add new clock name
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>, <Rex-BC.Chen@mediatek.com>,
        <TingHan.Shen@mediatek.com>, <Liju-clr.Chen@mediatek.com>,
        <Jian.Yang@mediatek.com>
Date:   Thu, 21 Jul 2022 16:44:08 +0800
In-Reply-To: <20220720222448.GA4083816-robh@kernel.org>
References: <20220716074349.28655-1-jianjun.wang@mediatek.com>
         <20220716074349.28655-3-jianjun.wang@mediatek.com>
         <20220720222448.GA4083816-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

Thanks for your comment.

On Wed, 2022-07-20 at 16:24 -0600, Rob Herring wrote:
> On Sat, Jul 16, 2022 at 03:43:49PM +0800, Jianjun Wang wrote:
> > MT8188 and MT8195 use clock "peri_mem" instead of "top_133m", add
> > new
> > clock name "peri_mem" for MT8188 and MT8195.
> 
> This should be part of patch 1.

Sure, I'll merge these two patches into one in the next version.

> 
> Clock names for IP blocks should be local to the IP block. IOW,
> named 
> after the input name for the clocks or what their function is if you 
> don't know that. Neither the old names nor the new name seem to
> follow 
> this. At least make the new name follow that convention.

Sorry, I'm not sure if I understand correctly, would you mind providing
an example of this change?

Thanks.

> 
> > 
> > Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> > ---
> >  .../bindings/pci/mediatek-pcie-gen3.yaml      | 42 ++++++++++++++-
> > ----
> >  1 file changed, 32 insertions(+), 10 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-
> > gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-
> > gen3.yaml
> > index 67d2ba25e336..038e25ae0be7 100644
> > --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> > +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> > @@ -43,9 +43,6 @@ description: |+
> >    each set has its own address for MSI message, and supports 32
> > MSI vectors
> >    to generate interrupt.
> >  
> > -allOf:
> > -  - $ref: /schemas/pci/pci-bus.yaml#
> > -
> >  properties:
> >    compatible:
> >      oneOf:
> > @@ -85,13 +82,7 @@ properties:
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
> > @@ -133,9 +124,40 @@ required:
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
> > +
> >  unevaluatedProperties: false
> >  
> >  examples:
> > -- 
> > 2.18.0
> > 
> > 

