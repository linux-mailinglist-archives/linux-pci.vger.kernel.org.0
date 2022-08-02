Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADC1587A04
	for <lists+linux-pci@lfdr.de>; Tue,  2 Aug 2022 11:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbiHBJnV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Aug 2022 05:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbiHBJnU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Aug 2022 05:43:20 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D55275F6;
        Tue,  2 Aug 2022 02:43:16 -0700 (PDT)
X-UUID: 38b491e449154999b289d24e73ef0475-20220802
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:c6cedf9c-523e-402d-9b21-769a8532de95,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:50
X-CID-INFO: VERSION:1.1.8,REQID:c6cedf9c-523e-402d-9b21-769a8532de95,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:50
X-CID-META: VersionHash:0f94e32,CLOUDID:70020b25-a982-4824-82d2-9da3b6056c2a,C
        OID:c8111b11b69c,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 38b491e449154999b289d24e73ef0475-20220802
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1292828691; Tue, 02 Aug 2022 17:43:11 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 2 Aug 2022 17:43:11 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Tue, 2 Aug 2022 17:43:10 +0800
Message-ID: <1688f1aad1f7239e5b0eb3d45a854ca6b0e61e1a.camel@mediatek.com>
Subject: Re: [PATCH v3] dt-bindings: PCI: mediatek-gen3: Add support for
 MT8188 and MT8195
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>, <Rex-BC.Chen@mediatek.com>,
        <TingHan.Shen@mediatek.com>, <Liju-clr.Chen@mediatek.com>,
        <Jian.Yang@mediatek.com>
Date:   Tue, 2 Aug 2022 17:43:10 +0800
In-Reply-To: <cd9518e3-9cb4-5165-af03-00e5300ab927@linaro.org>
References: <20220801113709.12101-1-jianjun.wang@mediatek.com>
         <cd9518e3-9cb4-5165-af03-00e5300ab927@linaro.org>
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

Hi Krzysztof,

Thanks for your comment.

On Tue, 2022-08-02 at 10:59 +0200, Krzysztof Kozlowski wrote:
> On 01/08/2022 13:37, Jianjun Wang wrote:
> > MT8188 and MT8195 are ARM platform SoCs with the same PCIe IP as
> > MT8192.
> > 
> > Also add new clock name "peri_mem" since the MT8188 and MT8195 use
> > clock
> > "peri_mem" instead of "top_133m".
> > 
> > Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> > ---
> > Changes in v3:
> > Use enum property to add the new clock name.
> > 
> > Changes in v2:
> > Merge two patches into one.
> > ---
> >  .../bindings/pci/mediatek-pcie-gen3.yaml           | 14
> > ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-
> > gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-
> > gen3.yaml
> > index 0499b94627ae..a0ca9c7f5dfa 100644
> > --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> > +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> > @@ -48,7 +48,14 @@ allOf:
> >  
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
> 
> You have one item, so this is just const. Or enum if  you expect it
> to
> grow soon.

It makes sense, I'll remove this "items" and just keep the const item
in the next version.

Thanks.
> 
> > +          - const: mediatek,mt8192-pcie
> >  
> >    reg:
> >      maxItems: 1
> > @@ -84,7 +91,9 @@ properties:
> >        - const: tl_96m
> >        - const: tl_32k
> >        - const: peri_26m
> > -      - const: top_133m
> > +      - enum:
> > +          - top_133m        # for MT8192
> > +          - peri_mem        # for MT8188/MT8195
> 
> This requires allOf:if:then restricting it further per variant.
> 
> 
> 
> Best regards,
> Krzysztof

