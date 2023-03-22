Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F296C4258
	for <lists+linux-pci@lfdr.de>; Wed, 22 Mar 2023 06:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjCVFqR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Mar 2023 01:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCVFqQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Mar 2023 01:46:16 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7A851C87;
        Tue, 21 Mar 2023 22:46:15 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y20so21970017lfj.2;
        Tue, 21 Mar 2023 22:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679463973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6fFd6pvbyxfyPuecxxTv2e9KKnEJkOs5N1QxtDniQQ=;
        b=iXPb3HHqijQ9eGejgI5V8MdaVxAKPgyanCPDNFKJWTzmDVeEWe3e0RirwlclUx9IPa
         zuahDc0d0qHneGsqL/OMqIq2lnE1hjzMLnCCnh77e6V4mcxn6ZrokXPNgLR19IMhfjaz
         R/4cUkdEl2xqIVqzWP0+s8JIFq0B2470fErxQxwyD22EXKbdBmT81DiUGc3Li6VWN0bv
         8k+bkwYpZ5hIDkBRYb+qLl+z5VnpDe/nLKue7CUDTg/3yICukN2+BYN9vyY1PlolW/XF
         S/ndpV3u/Nkxoz5QlG93sBB0kT+l6cuLc96B2wN9eNzCbzqD+2ZBK0Zh/qqInASAu4zB
         WMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679463973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6fFd6pvbyxfyPuecxxTv2e9KKnEJkOs5N1QxtDniQQ=;
        b=DtfUlYo+/iFaTRRZIROp70nAHTO035ZghLXG23zqc1aGViMpi+ozzHg/bG66+jUpBX
         wgpxZvdgefncJoZBJSdpTagjkmUiDHiM+9V2RQQueOZZRTxiu+0U0VL3yYUGuVXeQCk/
         WVErXf21Nkz08ynbhvtS+puxy+ofsTsdHk9ZB0HBduwuGbXb4pVZpPg/QPcpjH9V64di
         fozBPuMOjKFHwO2AqY2yVuMR5l+ghmoow224aunpGO3ht8v5fbTUpoOTnKymkZV/JOP8
         R5hOwZs7ACOiaH1DO1F59zAOXjBI2rwHXvljHPgEFisjNoKwUfRWqf+sSHVgpy9wau2G
         OfSw==
X-Gm-Message-State: AO0yUKV5LaLufrggQqZsujQd+ERwXXgJkEQnMkgzsu+n3gA4amTj1Z2C
        LxClrzZFVE2WmUsJh02Z8H4=
X-Google-Smtp-Source: AKy350Z6/PzMoCfaj14cLJbpDmswm8vuTkFVbgWCnZ+ykb5TlJN6tf+uVwlglt7ERxGLH4VhgDYJxg==
X-Received: by 2002:ac2:428e:0:b0:4ea:c730:aac3 with SMTP id m14-20020ac2428e000000b004eac730aac3mr348602lfh.3.1679463973237;
        Tue, 21 Mar 2023 22:46:13 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id w14-20020a19c50e000000b004d57a760e4dsm2462136lfe.37.2023.03.21.22.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 22:46:12 -0700 (PDT)
Date:   Wed, 22 Mar 2023 08:46:10 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "Sergey.Semin@baikalelectronics.ru" 
        <Sergey.Semin@baikalelectronics.ru>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v11 03/13] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe
 Host
Message-ID: <20230322054610.gppvtzvp2xan2ror@mobilestation>
References: <20230310123510.675685-1-yoshihiro.shimoda.uh@renesas.com>
 <20230310123510.675685-4-yoshihiro.shimoda.uh@renesas.com>
 <20230321113603.xxdiekhqpv4h777f@mobilestation>
 <TYBPR01MB5341EBFA25F9D3D53AEE72F3D8869@TYBPR01MB5341.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYBPR01MB5341EBFA25F9D3D53AEE72F3D8869@TYBPR01MB5341.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 22, 2023 at 12:35:19AM +0000, Yoshihiro Shimoda wrote:
> Hi Serge,
> 
> > From: Serge Semin, Sent: Tuesday, March 21, 2023 8:36 PM
> > 
> > On Fri, Mar 10, 2023 at 09:35:00PM +0900, Yoshihiro Shimoda wrote:
> > > Document bindings for Renesas R-Car Gen4 and R-Car S4-8 (R8A779F0)
> > > PCIe host module.
> > >
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > 
> > Looks good.
> > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> 
> Thank you for your review!
> 
> > > ---
> > >  .../bindings/pci/rcar-gen4-pci-host.yaml      | 108 ++++++++++++++++++
> > >  1 file changed, 108 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> > b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> > > new file mode 100644
> > > index 000000000000..d838d7c50410
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> > > @@ -0,0 +1,108 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +# Copyright (C) 2022 Renesas Electronics Corp.
> > > +%YAML 1.2
> > > +---
> > > +$id:
> <snip>
> > > +$schema:
> <snip>
> > > +
> > > +title: Renesas R-Car Gen4 PCIe Host
> > > +
> > > +maintainers:
> > > +  - Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > +
> > > +allOf:
> > > +  - $ref: snps,dw-pcie.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - const: renesas,r8a779f0-pcie   # R-Car S4-8
> > > +      - const: renesas,rcar-gen4-pcie  # R-Car Gen4
> > > +
> > > +  reg:
> > > +    maxItems: 5
> > > +
> > > +  reg-names:
> > > +    items:
> > > +      - const: dbi
> > > +      - const: atu
> > > +      - const: dma
> > > +      - const: app
> > > +      - const: config
> > > +
> > > +  interrupts:
> > > +    maxItems: 4
> > > +
> > > +  interrupt-names:
> > > +    items:
> > > +      - const: msi
> > > +      - const: dma
> > > +      - const: sft_ce
> > 
> > > +      - const: app
> > 
> > Just curious what is this IRQ used for?
> 
> The pcie-rcar-gen4 drivers (host and endpoint) doesn't use this IRQ,
> But the hardware issues the IRQ when it receives a vendor defined message
> from remote device.

Ok. Thanks for clarification.

-Serge(y)

> 
> Best regards,
> Yoshihiro Shimoda
> 
> > -Serge(y)
> > 
> > > +
> > > +  clocks:
> > > +    maxItems: 1
> > > +
> > > +  power-domains:
> > > +    maxItems: 1
> > > +
> > > +  resets:
> > > +    maxItems: 1
> > > +
> > > +  max-link-speed:
> > > +    maximum: 4
> > > +
> > > +  num-lanes:
> > > +    maximum: 4
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - interrupts
> > > +  - clocks
> > > +  - power-domains
> > > +
> > > +unevaluatedProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/clock/r8a779f0-cpg-mssr.h>
> > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > +    #include <dt-bindings/power/r8a779f0-sysc.h>
> > > +
> > > +    soc {
> > > +        #address-cells = <2>;
> > > +        #size-cells = <2>;
> > > +
> > > +        pcie: pcie@e65d0000 {
> > > +            compatible = "renesas,r8a779f0-pcie", "renesas,rcar-gen4-pcie";
> > > +            reg = <0 0xe65d0000 0 0x3000>, <0 0xe65d3000 0 0x2000>,
> > > +                  <0 0xe65d5000 0 0x1200>, <0 0xe65d6200 0 0x0e00>,
> > > +                  <0 0xfe000000 0 0x400000>;
> > > +            reg-names = "dbi", "atu", "dma", "app", "config";
> > > +            #address-cells = <3>;
> > > +            #size-cells = <2>;
> > > +            bus-range = <0x00 0xff>;
> > > +            device_type = "pci";
> > > +            ranges = <0x81000000 0 0x00000000 0 0xfe000000 0 0x00400000
> > > +                      0x82000000 0 0x30000000 0 0x30000000 0 0x10000000>;
> > > +            dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x80000000>;
> > > +            interrupts = <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
> > > +                         <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
> > > +                         <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
> > > +                         <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
> > > +            interrupt-names = "msi", "dma", "sft_ce", "app";
> > > +            #interrupt-cells = <1>;
> > > +            interrupt-map-mask = <0 0 0 7>;
> > > +            interrupt-map = <0 0 0 1 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH
> > > +                             0 0 0 2 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH
> > > +                             0 0 0 3 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH
> > > +                             0 0 0 4 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>;
> > > +            clocks = <&cpg CPG_MOD 624>;
> > > +            power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
> > > +            resets = <&cpg 624>;
> > > +            num-lanes = <2>;
> > > +            snps,enable-cdm-check;
> > > +            max-link-speed = <2>;
> > > +        };
> > > +    };
> > > --
> > > 2.25.1
> > >
> > >
