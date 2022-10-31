Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B94613D7E
	for <lists+linux-pci@lfdr.de>; Mon, 31 Oct 2022 19:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiJaSjq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Oct 2022 14:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiJaSjp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Oct 2022 14:39:45 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B4E101C4;
        Mon, 31 Oct 2022 11:39:45 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1322d768ba7so14414226fac.5;
        Mon, 31 Oct 2022 11:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8I23OysfCUx1Xe2YvQAfauLcceZ5Fm8l3YdA4hOzeE=;
        b=6Cu0ms7lDq96m/6seg+it7F3ju0rgj6296drAzFLUj57hAPLZZyipbmuCg1n75aKs8
         rRFD2OXLBw68XNsdYkDmFcWIWYIkVqYki4524+FyKtJJBvtzd0SVQPapugjQ0ipzGopZ
         1TTtHu5HKh/4zG2D5tl6HHmSjE08ZRKdhNur1EU2BiqoqOkG1pmXz4Q6yKK/e6406lMK
         6yz11peEplSmaT4b1JnfXA+HqcVq9CH6ULfYfJ1Jk4u6VGOQ1dkV7CrXMZQUZDYIRAAh
         tdsIe5l4rXVRJKzL3xYFHzsAuJu7dtqd7LexeV1EjwVUyww1qh+8jR36Uk5E2adZMaYF
         RheQ==
X-Gm-Message-State: ACrzQf3Ow9DwiSWz2W37F/C7g0dj+mCDoCENfOINUankyGk4b/wMrh8E
        +aSec+e1fyWAXUfmbHB8Rg==
X-Google-Smtp-Source: AMsMyM76PZ6E2clfU5MJa4MsDXzGuDNWQDOmvVzuoUlAJbMDTKjf/teIxDgreXo1CZP+otpDeba2ZQ==
X-Received: by 2002:a05:6870:5894:b0:131:b25b:413e with SMTP id be20-20020a056870589400b00131b25b413emr17944734oab.192.1667241584347;
        Mon, 31 Oct 2022 11:39:44 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i16-20020a056870a69000b0013b8b3710bfsm3396902oam.13.2022.10.31.11.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 11:39:43 -0700 (PDT)
Received: (nullmailer pid 3235802 invoked by uid 1000);
        Mon, 31 Oct 2022 18:39:45 -0000
Date:   Mon, 31 Oct 2022 13:39:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v4 1/3] dt-bindings: PCI: mediatek-gen3: Support mt8195
Message-ID: <20221031183945.GA3060184-robh@kernel.org>
References: <20221028094317.29270-1-tinghan.shen@mediatek.com>
 <20221028094317.29270-2-tinghan.shen@mediatek.com>
 <9da05c64-87bb-39c7-6c23-e4918bd5024b@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9da05c64-87bb-39c7-6c23-e4918bd5024b@collabora.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 31, 2022 at 02:28:54PM +0100, AngeloGioacchino Del Regno wrote:
> Il 28/10/22 11:43, Tinghan Shen ha scritto:
> > From: Jianjun Wang <jianjun.wang@mediatek.com>
> > 
> > In order to support mt8195 pcie node, update the yaml to support new
> > properties of iommu and power-domain, and update the reset-names
> > property to allow only one 'mac' name.
> > 
> > Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> > Signed-off-by: TingHan Shen <tinghan.shen@mediatek.com>
> > ---
> >   .../bindings/pci/mediatek-pcie-gen3.yaml         | 16 +++++++++++++---
> >   1 file changed, 13 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> > index c00be39af64e..a9013c10131a 100644
> > --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> > +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> > @@ -70,14 +70,21 @@ properties:
> >       minItems: 1
> >       maxItems: 8
> > +  iommu-map:
> > +    maxItems: 1
> > +
> > +  iommu-map-mask:
> > +    const: 0
> > +
> >     resets:
> >       minItems: 1
> >       maxItems: 2
> >     reset-names:
> > -    minItems: 1
> > -    items:
> > -      - const: phy
> > +    oneOf:
> > +      - items:
> > +          - const: phy
> > +          - const: mac
> >         - const: mac
> 
> Sorry, this looks a bit messy.
> 
> I can propose two solutions, either:
> 
> reset-names:
>   minItems: 1
>   items:
>     - const: mac
>     - const: phy
> ... and change the order in mt8192.dtsi;

That doesn't work because originally 'phy' alone was allowed.

You could do:

minItems: 1
maxItems: 2
items:
  enum: [ phy, mac ]

But for 2 items, either order would be allowed. Not great, but not a 
huge deal.

> otherwise, something like
> allOf:
>   - if:
>      properties:
>        compatible:
>          contains:
>            - const: mediatek,mt8195-pcie
>     ... invert reset-names
> 
> I think that the first solution makes a bit more sense though, as the
> PHY reset may be moved in a PCIE-PHY specific driver instead of being
> managed here in pci-mediatek-gen3.

That either makes sense or it doesn't. If it does, then you should go 
ahead and separate the phy rather than change the ABI twice.

Rob
