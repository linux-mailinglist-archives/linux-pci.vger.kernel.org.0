Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A50606E52
	for <lists+linux-pci@lfdr.de>; Fri, 21 Oct 2022 05:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiJUD1z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Oct 2022 23:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiJUD1w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Oct 2022 23:27:52 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C006B1EEA16;
        Thu, 20 Oct 2022 20:27:45 -0700 (PDT)
X-UUID: b0300b9995a94ef0ae0a5f763a699ed1-20221021
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=liRN+HmxoIKuY83k0B956REc4h3T4bcOVKQySzS8Z7g=;
        b=TtpGlCVMq3Zes+NBDYyLEj22qgKyjATJni/4fRyQ/e6MjRcLUhLFEd3QoDNG/uf7oquQMHuWiVFeIFsuDFeztOrhVW0jnMzi4x91elDV6+lYwWfY1YD3Y7MeeZ6ZmmQo8DTKu+fsCj2WPSf5TLbavBtc/TSiWcAoQ8p3UoKd7QY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:c26f921f-6ab4-4340-9133-22503ddb52dc,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:51
X-CID-INFO: VERSION:1.1.12,REQID:c26f921f-6ab4-4340-9133-22503ddb52dc,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:51
X-CID-META: VersionHash:62cd327,CLOUDID:fbb839c8-03ab-4171-989e-341ab5339257,B
        ulkID:2210211026516FV6XUSA,BulkQuantity:8,Recheck:0,SF:38|28|17|19|48|102,
        TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,CO
        L:0
X-UUID: b0300b9995a94ef0ae0a5f763a699ed1-20221021
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 104753269; Fri, 21 Oct 2022 11:27:37 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 21 Oct 2022 11:27:35 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 21 Oct 2022 11:27:34 +0800
Message-ID: <20a87e771e4bcce4e9c9f0a1db13e20f75ce3b72.camel@mediatek.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: PCI: mediatek-gen3: Support mt8195
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Rob Herring <robh@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>
CC:     Ryder Lee <ryder.lee@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 21 Oct 2022 11:27:33 +0800
In-Reply-To: <20221021022647.GA2195154-robh@kernel.org>
References: <20221020111925.30002-1-tinghan.shen@mediatek.com>
         <20221020111925.30002-2-tinghan.shen@mediatek.com>
         <20221021022647.GA2195154-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

Thanks for your review.

On Thu, 2022-10-20 at 21:26 -0500, Rob Herring wrote:
> On Thu, Oct 20, 2022 at 07:19:23PM +0800, Tinghan Shen wrote:
> > From: Jianjun Wang <jianjun.wang@mediatek.com>
> > 
> > In order to support mt8195 pcie node, update the yaml to support
> > new
> > properties of iommu and power-domain, and update the reset-names
> > property to allow only one 'mac' name.
> > 
> > Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> > Signed-off-by: TingHan Shen <tinghan.shen@mediatek.com>
> > ---
> >  .../bindings/pci/mediatek-pcie-gen3.yaml         | 16
> > +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-
> > gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-
> > gen3.yaml
> > index c00be39af64e..af271018b134 100644
> > --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> > +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> > @@ -70,14 +70,21 @@ properties:
> >      minItems: 1
> >      maxItems: 8
> >  
> > +  iommu-map:
> > +    maxItems: 1
> > +
> > +  iommu-map-mask:
> > +    maxItems: 1
> 
> This is not a array. It needs a value. Must be 0 if iommu-map only
> has 1 
> entry? Or you only support 1 downstream device?

We only has 1 entry for iommu-map, we'll change it to 0 in the next
version.

Thanks.

> 
> > +
> >    resets:
> >      minItems: 1
> >      maxItems: 2
> >  
> >    reset-names:
> > -    minItems: 1
> > -    items:
> > -      - const: phy
> > +    oneOf:
> > +      - items:
> > +          - const: phy
> > +          - const: mac
> >        - const: mac
> >  
> >    clocks:
> > @@ -107,6 +114,9 @@ properties:
> >      items:
> >        - const: pcie-phy
> >  
> > +  power-domains:
> > +    maxItems: 1
> > +
> >    '#interrupt-cells':
> >      const: 1
> >  
> > -- 
> > 2.18.0
> > 
> > 

