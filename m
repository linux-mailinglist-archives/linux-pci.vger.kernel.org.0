Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02E9509225
	for <lists+linux-pci@lfdr.de>; Wed, 20 Apr 2022 23:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382556AbiDTVku (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Apr 2022 17:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356105AbiDTVks (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2022 17:40:48 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232C1369F6;
        Wed, 20 Apr 2022 14:38:01 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id w127so3540322oig.10;
        Wed, 20 Apr 2022 14:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t4s+i9BdWcasHydBitg8Y8XSjODVgS+jeiuoMRAUa0g=;
        b=Q6k7shlhp11hY+lXT6vDvUtN4tcjqTfDKWNs1bAu/5i48KFTKWr/+uQv7eXsBgrKfs
         jJCprKnQfkZsycyFjUGtV0/wtNhL9+5VqesXQXq0DsJEpDhYBtbrAHdjkjPEPUfyiXL+
         qvAHgXSV7q7IuLVEpC9JUow9zw3U+8NcUjvsONytud22BNh5c3JaB5L0IgGFPq+TmuGn
         ft7+lvXgPc6T1wcxYHRf5cueGqRSBLLXJ4OQbCEdUOGXXhWluSPDCX43E9pM72e30uSM
         uaonzreKzahU8AU/u9Q3Wh6mq0hL74l15xphWdFPXfeeuRiGRogQMlBIPvdwsNqv5aHg
         O9tw==
X-Gm-Message-State: AOAM5329Fw9flsZH7xMsBCa1NW4vl8uC7AYeSSmbGCtLNFRwRHdILD8r
        rqrxODaMonTEGmhFBRzIfg==
X-Google-Smtp-Source: ABdhPJxVOoBwy2hZdiybdxAptzC2ZHhSsuWp1DtHCc7pFAEQv+x1o8WiqDQYCy1SRNIi+q/nwY7P+g==
X-Received: by 2002:a05:6808:23c1:b0:322:7334:e447 with SMTP id bq1-20020a05680823c100b003227334e447mr2626853oib.288.1650490680412;
        Wed, 20 Apr 2022 14:38:00 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bk35-20020a0568081a2300b003226178fe7bsm5205483oib.33.2022.04.20.14.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 14:37:59 -0700 (PDT)
Received: (nullmailer pid 1894112 invoked by uid 1000);
        Wed, 20 Apr 2022 21:37:59 -0000
Date:   Wed, 20 Apr 2022 16:37:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 2/8] dt-bindings: PCI: renesas-pci-usb: Convert
 bindings to json-schema
Message-ID: <YmB9NxyFdxWAvlPr@robh.at.kernel.org>
References: <20220414074011.500533-1-herve.codina@bootlin.com>
 <20220414074011.500533-3-herve.codina@bootlin.com>
 <YlhkwvGdcf4ozTzG@robh.at.kernel.org>
 <20220420144411.2d369b49@bootlin.com>
 <YmAIOt1vAEzHGvBP@robh.at.kernel.org>
 <20220420154611.7dd34c24@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420154611.7dd34c24@bootlin.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 20, 2022 at 03:46:11PM +0200, Herve Codina wrote:
> Hi Rob,
> 
> On Wed, 20 Apr 2022 08:18:50 -0500
> Rob Herring <robh@kernel.org> wrote:
> 
> ...
> 
> > > > > +  bus-range:
> > > > > +    description: |
> > > > > +      The PCI bus number range; as this is a single bus, the range
> > > > > +      should be specified as the same value twice.    
> > > > 
> > > > items:
> > > >   const: 0  
> > > 
> > > Well, some other values are present in some dtsi files such as
> > > 'bus_range = <1 1>;' or 'bus_range = <2 2>;' in r8a7742.dtsi.
> > > 
> > > The constraint is to have the same value twice. Is there a way
> > > to specify this constraint ?  
> > 
> > Yes, but probably not worthwhile. Just drop it as pci-bus.yaml already 
> > defines it.
> 
> Instead of fully dropping the property, don't you think that keeping
> the given description here can be a way to express that the same value
> is needed twice ?

Yeah, that's fine.


> > > > > +  "#address-cells":
> > > > > +    const: 3
> > > > > +
> > > > > +  "#size-cells":
> > > > > +    const: 2
> > > > > +
> > > > > +  "#interrupt-cells":
> > > > > +    const: 1    
> > > > 
> > > > All these are defined by pci-bus.yaml  
> > > 
> > > Right.
> > > Replaced by:
> > > 
> > > "#address-cells": true
> > > "#size-cells": true
> > > "#interrupt-cells": true
> > > 
> > > Is that correct ?  
> > 
> > You can just drop them completely.
> 
> Ok for #address-cells and #size-cells but not for #interrupt-cells.
> 
> Dropping #interrupt-cells makes 'make dtbindings_check' unhappy:
> --- 8< ---
> $ make dt_binding_check DT_SCHEMA_FILES=renesas,pci-rcar-gen2.yaml
>   LINT    Documentation/devicetree/bindings
>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
> /home/hcodina/xxx/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml: properties: '#interrupt-cells' is a dependency of 'interrupt-map'
> 	from schema $id: http://devicetree.org/meta-schemas/interrupts.yaml#
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> /home/hcodina/xxx/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml: ignoring, error in schema: properties
>   DTEX    Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.example.dts
>   DTC     Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.example.dtb
>   CHECK   Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.example.dtb
> $ 
> --- 8< ---
> 
> So I keep 
> "#interrupt-cells": true

You should also drop 'interrupt-map' and 'interrupt-map-mask'.

Rob
