Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67B960E97A
	for <lists+linux-pci@lfdr.de>; Wed, 26 Oct 2022 21:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbiJZTrS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Oct 2022 15:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234623AbiJZTrF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Oct 2022 15:47:05 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8B52A43F;
        Wed, 26 Oct 2022 12:46:18 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id t10so3226336oib.5;
        Wed, 26 Oct 2022 12:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FS6rm9BDQlab5fLy0WIjAlMKCNgvwb6RMvMQ+w+1YTY=;
        b=sszRyWPj7RqKdsCoopMwTeYYpH34otrd/zwRyBbRZoAaTmUB2SMxhY3QzRpLkUjzn1
         sAbDFe8lXmmQcVDFM0huTKpwy1rfWZ5aFtx7bML1J/zzv+eEcN2DeZZfdN2SXXXAsSgE
         wVBek3sSJZux25ApsCvbsly6HsQOYDyvUTiz4oM6CkNMEPFFodlg0qjsasDaaq6V8638
         H44Zoeemel0RQ35IV8Lhsd7eQE+IzTrpX/OaNA3KsfkrIX9k1qlXo9oJUDw449SBZvWK
         ZBKk/SZPe2wdVapKBBK5tfvkeqsefAuJJXeYB6QFwppErga9S0ueF0SHNxMezZn8UVLQ
         SFGA==
X-Gm-Message-State: ACrzQf1cbKmygXKwlLK2jLxm5xxvBFOifFYQOZcbZOPuVLJlJShkOBZZ
        Hi5DwOk6ekXCtzoHE2RzCUFEMwe7VA==
X-Google-Smtp-Source: AMsMyM6UXJyWxevgK90NbceQb/Qr6Yzp1ZycrnNhNY0KdyxUpeRsVRHipmEBOMF8TifjGLHUVMsPmQ==
X-Received: by 2002:a05:6808:1384:b0:355:535f:118c with SMTP id c4-20020a056808138400b00355535f118cmr2677393oiw.35.1666813577379;
        Wed, 26 Oct 2022 12:46:17 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x11-20020a056808144b00b00350743ac8eesm2407990oiv.41.2022.10.26.12.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:46:16 -0700 (PDT)
Received: (nullmailer pid 1052629 invoked by uid 1000);
        Wed, 26 Oct 2022 19:46:18 -0000
Date:   Wed, 26 Oct 2022 14:46:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] dt-bindings: PCI: mediatek-gen3: add support for
 mt7986
Message-ID: <20221026194618.GA1049502-robh@kernel.org>
References: <20221025072837.16591-1-linux@fw-web.de>
 <20221025072837.16591-3-linux@fw-web.de>
 <22728b06-f460-6dda-21fa-1d7a7ae3b903@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22728b06-f460-6dda-21fa-1d7a7ae3b903@collabora.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 25, 2022 at 01:10:56PM +0200, AngeloGioacchino Del Regno wrote:
> Il 25/10/22 09:28, Frank Wunderlich ha scritto:
> > From: Frank Wunderlich <frank-w@public-files.de>
> > 
> > Add compatible string and clock-definition for mt7986. It needs 4 clocks
> > for PCIe, define them in binding.
> > 
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > ---
> > v2:
> > - squashed patch 2+3 (compatible and clock definition)
> > ---
> >   .../bindings/pci/mediatek-pcie-gen3.yaml        | 17 +++++++++++++++++
> >   1 file changed, 17 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> > index 98d3f0f1cd76..57d0e84253e9 100644
> > --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> > +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> > @@ -48,6 +48,7 @@ properties:
> >       oneOf:
> >         - items:
> >             - enum:
> > +              - mediatek,mt7986-pcie
> >                 - mediatek,mt8188-pcie
> >                 - mediatek,mt8195-pcie
> >             - const: mediatek,mt8192-pcie
> > @@ -78,9 +79,11 @@ properties:
> >         - const: mac
> >     clocks:
> > +    minItems: 4
> >       maxItems: 6
> 
> I'm not sure that this is really correct.
> If you have a list of items (const or description, doesn't matter), you don't have
> to specify maxItems, as it is implicitly equal to the number of items.
> Also, specifying minItems means that you're "setting" one or more items as
> optional.
> 
> It looks like you're specifying a specific and definite list of items for both
> clocks and clock-names... and for all of the supported SoCs, so, I don't think
> that having {min,max}Items globally specified on clocks, clock-names make any
> kind of sense.
> 
> .....but I'd like for someone else to give an opinion on this as well.

It does make sense. Globally, we have the full range of possible clocks 
and then the if/then schemas further restrict it.

Rob
