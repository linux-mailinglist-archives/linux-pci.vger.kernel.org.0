Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA000508931
	for <lists+linux-pci@lfdr.de>; Wed, 20 Apr 2022 15:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378886AbiDTN15 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Apr 2022 09:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379033AbiDTN1s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2022 09:27:48 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DC72ACA;
        Wed, 20 Apr 2022 06:25:01 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-e656032735so650585fac.0;
        Wed, 20 Apr 2022 06:25:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WRdWfSi+1sG2KdTR7O9gGMtklLx/TqYIp/Pa2T6eLoc=;
        b=GDwpn5XZGJluUeTqroiCc62FSLIveUwlQfWyFQPEx/HMvx9HAGMCm+9mIsWStjai5U
         tyMG5Ip7w79SdJM9cH88WSRVmwqxRxNn3PUGPTpARUA1U6gwPuZCyoJdfXT5W3O5V5ni
         y4jHJDFFYCH6O4hU9STLapCftge+L8pruDz9HAVxnvK8ctTDv+yYNR7H/8loDFK3wg5H
         ILgE/R2Ud+va+9Cn3xeCsstBgXBnfCL2qKIfbapc0eUHpVhUcAi+nANMZR7+49TcOy2C
         Af2TWHOO8WM61ljNX7PU4s8mwriH5uXs6dj3S6pSFvK7HscsLf3JcmXwc6OJbq795+04
         dh0A==
X-Gm-Message-State: AOAM53087NTvusEclWKQIeoo8R1Jmp7Oazqye57mSKCcowGMKUSuGRPO
        hL1i8esjwQHLi92Z65xVp2ZeVfOHaw==
X-Google-Smtp-Source: ABdhPJwYthaBVW4OLOo5KMUT4jqoFd7LEF5hP00id1qgTvfJFswDcuqE5YofCT+RwIiybfHmHygosQ==
X-Received: by 2002:a05:6870:339d:b0:e1:e7e9:dfb2 with SMTP id w29-20020a056870339d00b000e1e7e9dfb2mr1590921oae.67.1650461100728;
        Wed, 20 Apr 2022 06:25:00 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q17-20020a9d7c91000000b0060542dc13d5sm4997869otn.68.2022.04.20.06.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 06:25:00 -0700 (PDT)
Received: (nullmailer pid 1161723 invoked by uid 1000);
        Wed, 20 Apr 2022 13:24:59 -0000
Date:   Wed, 20 Apr 2022 08:24:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 3/8] dt-bindings: PCI: renesas-pci-usb: Allow multiple
 clocks
Message-ID: <YmAJq+qUF34IvfiZ@robh.at.kernel.org>
References: <20220414074011.500533-1-herve.codina@bootlin.com>
 <20220414074011.500533-4-herve.codina@bootlin.com>
 <CAMuHMdWZyuNQJhxkhzs5H8+8DFGDS95nvptrO-s9RC4QL5kibA@mail.gmail.com>
 <20220420150759.713fcd02@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220420150759.713fcd02@bootlin.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 20, 2022 at 03:07:59PM +0200, Herve Codina wrote:
> Hi Geert, Rob,
> 
> On Thu, 14 Apr 2022 10:35:07 +0200
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> 
> > Hi Hervé,
> > 
> > On Thu, Apr 14, 2022 at 9:40 AM Herve Codina <herve.codina@bootlin.com> wrote:
> > > Define that multiple clocks can be present at clocks property.
> > >
> > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>  
> > 
> > Thanks for your patch!
> > 
> > > --- a/Documentation/devicetree/bindings/pci/renesas,pci-usb.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/renesas,pci-usb.yaml
> > > @@ -54,7 +54,8 @@ properties:
> > >        Standard property that helps to define the interrupt mapping.
> > >
> > >    clocks:
> > > -    description: The reference to the device clock.
> > > +    description:
> > > +      The references to the device clocks (several clocks can be referenced).  
> > 
> > Please describe the clocks, and add the missing "clock-names" property.
> > 
> > >
> > >    bus-range:
> > >      description: |  
> > 
> > I think it would be better to combine this with [PATCH v2 4/8], as the
> > additional clocks are only present on RZ/N1.
> > 
> > Then you can easily add json-schema logic to enforce the correct
> > number of clocks, depending on the compatible value.
> 
> Sure.
> 
> Is there a way to have the clocks description depending on the compatible value.
> I mean something like:
> --- 8< ---
> properties:
>   clocks:
>     maxItems: 1

This would need to cover both cases:

minItems: 1
maxItems: 3

> 
> if:
>   properties:
>     compatible:
>       contains:
>         enum:
>           - renesas,pci-r9a06g032
>           - renesas,pci-rzn1
> 
> then:
>   properties:
>     clocks:
>       items:
>         - description: Internal bus clock (AHB) for HOST
>         - description: Internal bus clock (AHB) Power Management
>         - description: PCI clock for USB subsystem
>       minItems: 3
>       maxItems: 3

Don't need minItems or maxItems here. 3 is the default size based on 
'items' length.

> 
> else:
>   properties:
>     items:

I think you meant for this to be under 'clocks'.

>        - description: Device clock
>     clocks:
>       minItems: 1
>       maxItems: 1

Just 'maxItems' is enough.

> --- 8< ---
> 
> In fact, I would like to describe the 3 clocks only for the r9a06g032 SOC
> and the rzn1 family and have an other description for the other 'compatible'.
> 
> I cannot succeed to do it.
> 
> The only thing I can do is to leave the description of the 3 clocks out of the
> conditional part. This leads to :
> 
> --- 8< ---
> properties:
>   clocks:
>     items:
>       - description: Internal bus clock (AHB) for HOST
>       - description: Internal bus clock (AHB) Power Management
>       - description: PCI clock for USB subsystem
>     minItems: 1
> 
> if:
>   properties:
>     compatible:
>       contains:
>         enum:
>           - renesas,pci-r9a06g032
>           - renesas,pci-rzn1
> 
> then:
>   properties:
>     clocks:
>       minItems: 3
>       maxItems: 3

minItems is enough.

> 
> else:
>   properties:
>     clocks:
>       minItems: 1
>       maxItems: 1

This doesn't seem right as the description of the first clock is wrong 
for this case.

I would go with the first way.

Rob
