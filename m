Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A605B2804
	for <lists+linux-pci@lfdr.de>; Thu,  8 Sep 2022 22:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiIHU5w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Sep 2022 16:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiIHU5v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Sep 2022 16:57:51 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00111F10CF;
        Thu,  8 Sep 2022 13:57:50 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-12803ac8113so14426622fac.8;
        Thu, 08 Sep 2022 13:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=AkYb42H6PAnMFryGXinv8S02AN5zWvsr2AuuaVfXjQs=;
        b=fuc8rIYleXKiEGVfvlediUn/nvbNz62Zw86k1yboZlb6J1NEyiKFxym3qQI1dUS+4T
         tVyziKqskPfnd4B5NjjxZAdIkNWdwowh9eN/YPM2sZO6lOPQABbZ+wi2zTFRb99eq8Cy
         uhosGWWEgNhiA99akoqoL7Jjhkvhqpv8bYFTkI7AE4jyDYSkZ5ufoDI9c/uF7XD8rGRi
         NT++VtX+VvGN+/iKmuDFEfNX9LODaPYY0Y031MCsGRpM9i6FWhXUzbILqH5zu0KS34S3
         g18UgAoUXrI3KgIl0eK7alOKJU2RENL6FeGz4+bQiC2f9C7DTxeMH2SzL6IzWot/+ux7
         R48Q==
X-Gm-Message-State: ACgBeo131EEXIgtzUK9dhmvBMQT67GVJgXVrNcKLQajOuFrekfrdQHLF
        DDb45paOKeceIFM9xnuQNg==
X-Google-Smtp-Source: AA6agR4yS3IFwNYkq3dWRIdhs/oC9/Z9BNOXONwiLcb2gK5t2VzNYKd0HFd+svNy5YDQYIAS3f0tZg==
X-Received: by 2002:a05:6870:5b84:b0:10c:d1fa:2f52 with SMTP id em4-20020a0568705b8400b0010cd1fa2f52mr3064402oab.92.1662670670169;
        Thu, 08 Sep 2022 13:57:50 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id fo7-20020a0568709a0700b001274845032dsm116555oab.13.2022.09.08.13.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 13:57:49 -0700 (PDT)
Received: (nullmailer pid 3326711 invoked by uid 1000);
        Thu, 08 Sep 2022 20:57:48 -0000
Date:   Thu, 8 Sep 2022 15:57:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Daire.McNamara@microchip.com
Cc:     Cyril.Jean@microchip.com, linux-riscv@lists.infradead.org,
        kw@linux.com, Conor.Dooley@microchip.com,
        david.abdurachmanov@gmail.com, devicetree@vger.kernel.org,
        lpieralisi@kernel.org, aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-pci@vger.kernel.org,
        Padmarao.Begari@microchip.com, krzysztof.kozlowski+dt@linaro.org,
        bhelgaas@google.com, heinrich.schuchardt@canonical.com
Subject: Re: [PATCH v1 1/4] dt-bindings: PCI: microchip: add fabric address
 translation properties
Message-ID: <20220908205748.GA3240357-robh@kernel.org>
References: <20220902142202.2437658-1-daire.mcnamara@microchip.com>
 <20220902142202.2437658-2-daire.mcnamara@microchip.com>
 <CAL_Jsq+5pKyOL8eu5YhQy9pLATd_gG_D71sR8bUp1GA6kif=nA@mail.gmail.com>
 <173950d1b76e13c1476f196afc0e804e93d6e602.camel@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173950d1b76e13c1476f196afc0e804e93d6e602.camel@microchip.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 05, 2022 at 02:54:07PM +0000, Daire.McNamara@microchip.com wrote:
> On Fri, 2022-09-02 at 11:28 -0500, Rob Herring wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Fri, Sep 2, 2022 at 9:22 AM <daire.mcnamara@microchip.com> wrote:
> > > From: Conor Dooley <conor.dooley@microchip.com>
> > > 
> > > On PolarFire SoC both in- & out-bound address translations occur in two
> > > stages. The specific translations are tightly coupled to the FPGA
> > > designs and supplement the {dma-,}ranges properties. The first stage of
> > > the translation is done by the FPGA fabric & the second by the root
> > > port.
> > > Add two properties so that the translation tables in the root port's
> > > bridge layer can be configured to account for the translation done by
> > > the FPGA fabric.
> > 
> > I'm skeptical that ranges/dma-ranges can't handle what you need.
> > Anything in this area is going to need justification 'ranges doesn't
> > work because x, y, z...'.
> > 
> > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > > Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> > > ---
> > >  .../bindings/pci/microchip,pcie-host.yaml     | 107 ++++++++++++++++++
> > >  1 file changed, 107 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> > > index 23d95c65acff..29bb1fe99a2e 100644
> > > --- a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> > > @@ -71,6 +71,113 @@ properties:
> > >      minItems: 1
> > >      maxItems: 6
> > > 
> > > +  microchip,outbound-fabric-translation-ranges:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > > +    minItems: 1
> > > +    maxItems: 32
> > > +    description: |
> > > +      The CPU-to-PCIe (outbound) address translation takes place in two stages.
> > > +      Depending on the FPGA bitstream, the outbound address translation tables
> > > +      in the PCIe root port's bridge layer will need to be configured to account
> > > +      for only its part of the overall outbound address translation.
> > > +
> > > +      The first stage of outbound address translation occurs between the CPU address
> > > +      and an intermediate "FPGA address". The second stage of outbound address
> > > +      translation occurs between this FPGA address and the PCIe address. Use this
> > > +      property, in conjunction with the ranges property, to divide the overall
> > > +      address translation into these two stages so that the PCIe address
> > > +      translation tables can be correctly configured.
> > 
> > Sounds like you need 2 levels of ranges/dma-ranges.
> > 
> > / {
> >     fpga-bus {
> >         ranges = ...
> >         dma-ranges = ...
> >         pcie@... {
> >             ranges = ...
> >             dma-ranges = ...
> >         };
> >     };
> > };
> Thanks a million for looking at this! Very much appreciated.
> 
> So, this is what I tried.  I've cut down the dts I used to what I think is the minimum
> fragment to discuss the issue I'm facing.
> 
> So, I replaced this stanza:
> 
> pcie: pcie@3000000000 {
>     ...
>     reg = <0x30 0x0 0x0 0x8000000>, <0x0 0x43000000 0x0 0x10000>;
>     reg-names = "cfg", "apb";
>     ranges = <0x0000000 0x0 0x0000000 0x30 0x0000000 0x0 0x8000000>,
>              <0x3000000 0x0 0x8000000 0x30 0x8000000 0x0 0x80000000>;
>     ...
> };
> 
> with this two-level stanza:
> 
> fpga_bus: fpga-bus {
>     #address-cells = <2>;
>     #size-cells = <2>;
>     ranges = <0 0 0x30 0 0x40 0>;
>     compatible = "simple-bus";
>     ...
> 
>     pcie: pcie@0 {
>         reg = <0x0 0x0 0x0 0x8000000>, <0x0 0x43000000 0x0 0x10000>;
>         reg-names = "cfg", "apb";
>         ranges = <0x0000000 0x0 0x0000000 0 0x0000000 0x0 0x8000000>,
>                  <0x3000000 0x0 0x8000000 0 0x8000000 0x0 0x80000000>;
>         ...
>     };
> };
> 
> and I ran into two problems:
> 1) the ranges presented to the driver via  resource_list_for_each_entry(entry, &bridge->windows) 
>    were unchanged. The start and end of both resources were still in 0x30'0000'0000 space, 
>    not 0x0000'0000 as I'd hoped. The two levels of range had been amalgamated before 
>    presentation to the rootport driver, so my initial problem was unchanged ...

Yes, that's expected as the translation will walk up parents to root 
node. You will have to get the untranslated values out of 
ranges yourself. If you use the range parsing functions on the parent 
node ranges, you'll get the 0 from of_range.bus_addr.

> 
> 2) a new issue cropped up. While the 'cfg' register property is in 0x30'0000'0000 space, 
>    the 'abp' interface is actually delivered over a separate FIC and is in a 0x4000'0000 
>    memory space. In the two-level stanza, it was now being provided to the rootport 
>    driver at a base of 0x30'4000'0000 which is incorrect. This is very typical for 
>    designers to route abp over a different FIC to axi. 

If the fpga-bus ranges has a 1:1 entry for 0x43000000 child bus then it 
should get translated correctly. Worst case, you may need to define a 
child bus address outside of 0x30_00000000 range that translates back to 
0x43000000.

Rob
