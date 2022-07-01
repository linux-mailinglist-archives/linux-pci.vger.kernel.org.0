Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DB956360E
	for <lists+linux-pci@lfdr.de>; Fri,  1 Jul 2022 16:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiGAOoa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Jul 2022 10:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiGAOo2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jul 2022 10:44:28 -0400
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C8D13E84;
        Fri,  1 Jul 2022 07:44:28 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id w10so1549270ilj.4;
        Fri, 01 Jul 2022 07:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ytccVTPOAVJYoaiSKyc0iiVcQYhIGLNNjeSgQTrxPac=;
        b=etBF3h/sROX/O+VkG1fvRXqVtANkWmO6S/xZ6MY5mcrYhxb9eEJqdF54Sks9GY3Pyq
         bZ0xhyvCyAwCXT8PaJuHfeXN45sLv3JqTEXA0Eft3174EhH5iXmzXivZv+XxtzACowSt
         r2Ibw6+14BqUhNroxSigsRsvW4N5Xv87h9pvKiYeLnHtTgtxPCcb4UnPnwBGI33Mo9hr
         1P9TMs1VBm10m9qx2GoUDhDRtkNfFF0HlEikb4m+/Dtfegt/Mv1Y+RnY85Q8ScSrbwAL
         sIOjGKJ7m0OAeIPYdgYCJrxZTM9aaMcHz7tKymiAcblBaR2+T0VQbHnKR/2J81JQo3BL
         z4pg==
X-Gm-Message-State: AJIora9AtYooxCIpmrIlTlS7NoUKLmGjsDRDdwdq2a8zz74evfMn10kZ
        2CX4DMMHV+3ixPJbssDeCQ==
X-Google-Smtp-Source: AGRyM1uzdTpatC7zqZJnxWDfoRAtzaFQwkHUDgHjdzvkIy8cLMH/g0o6FP2Cp2hjNV62WE067Yx5HQ==
X-Received: by 2002:a92:cd8d:0:b0:2d9:5692:5141 with SMTP id r13-20020a92cd8d000000b002d956925141mr8668884ilb.15.1656686667304;
        Fri, 01 Jul 2022 07:44:27 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id j12-20020a6b794c000000b0067275a52928sm10352684iop.9.2022.07.01.07.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 07:44:26 -0700 (PDT)
Received: (nullmailer pid 904416 invoked by uid 1000);
        Fri, 01 Jul 2022 14:44:24 -0000
Date:   Fri, 1 Jul 2022 08:44:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/17] dt-bindings: PCI: dwc: Add max-link-speed
 common property
Message-ID: <20220701144424.GA804716-robh@kernel.org>
References: <20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru>
 <20220610085706.15741-5-Sergey.Semin@baikalelectronics.ru>
 <20220615145550.GA1069883-robh@kernel.org>
 <20220619142720.tzfgefunvf3kirul@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220619142720.tzfgefunvf3kirul@mobilestation>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jun 19, 2022 at 05:27:20PM +0300, Serge Semin wrote:
> On Wed, Jun 15, 2022 at 08:55:50AM -0600, Rob Herring wrote:
> > On Fri, Jun 10, 2022 at 11:56:52AM +0300, Serge Semin wrote:
> > > In accordance with [1] DW PCIe controllers support up to Gen5 link speed.
> > > Let's add the max-link-speed property upper bound to 5 then. The DT
> > > bindings of the particular devices are expected to setup more strict
> > > constraint on that parameter.
> > > 
> > > [1] Synopsys DesignWare Cores PCI Express Controller Databook, Version
> > > 5.40a, March 2019, p. 27
> > > 
> > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > 
> > > ---
> > > 
> > > Changelog v3:
> > > - This is a new patch unpinned from the next one:
> > >   https://lore.kernel.org/linux-pci/20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru/
> > >   by the Rob' request. (@Rob)
> > > ---
> > >  Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml | 3 +++
> > >  Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml     | 2 ++
> > >  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml        | 1 +
> > >  3 files changed, 6 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> > > index 627a5d6625ba..b2fbe886981b 100644
> > > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> > > @@ -45,6 +45,9 @@ properties:
> > >        the peripheral devices available on the PCIe bus.
> > >      maxItems: 1
> > >  
> > > +  max-link-speed:
> > > +    maximum: 5
> > 
> 
> > Unless the default is less than the max, shouldn't the max here be 1 
> > less than the h/w max?
> 
> Why? AFAIU max-link-speed semantics it works as less-than-or-equal
> operator isn't it? The modern DW PCIe Root ports and Endpoints
> IP-cores support up to Gen5 PCIe speed including the Gen5 mode (see
> the CX_MAX_PCIE_SPEED IP-core synthesize paramter). It's reasonable to
> set the max-link-speed here to be in coherency with the IP-core
> reference manual.

It is supposed to be an override for the default. Wouldn't the default 
always be the max the IP supports?

In any case, this max is only accurate for the current/latest version of 
the IP. For older versions, it's not an accurate limit. I think it 
should just be dropped and each controller needs to provide a limit.


> > >    num-lanes:
> > >      description:
> > >        Number of PCIe link lanes to use. Can be omitted should the already
> > > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> > > index dcd521aed213..fc3b5d4ac245 100644
> > > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> > > @@ -55,4 +55,6 @@ examples:
> > >  
> > >        phys = <&pcie_phy0>, <&pcie_phy1>, <&pcie_phy2>, <&pcie_phy3>;
> > >        phy-names = "pcie0", "pcie1", "pcie2", "pcie3";
> > > +
> > > +      max-link-speed = <3>;
> > >      };
> > > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > index 4a5c8b933b52..01cedf51e0f8 100644
> > > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > @@ -74,4 +74,5 @@ examples:
> > >        phy-names = "pcie";
> > >  
> > >        num-lanes = <1>;
> > > +      max-link-speed = <3>;
> > 
> 
> > This should give you an error because pci-bus.yaml only goes up to 4. 
> 
> I've set max-link-speed to "3" here. So no error will be caused neither
> by this schema nor by the pci-bus.yaml bindings.
> 
> * Though these examples won't be evaluated because the generic DW PCIe
> RP and EP schemas have been marked as "select: false".

Uh, I don't know what I was thinking...

> 
> > 
> > I'm not really sure that limiting it in the common schema is too useful. 
> > We're going to be updating it one step at a time. Limiting it is really 
> > only helpful for specific implementations.
> > 
> 
> I disagree. As I said above the max PCIe speed limit set here has been
> taken from the HW reference manual so it describes the modern DW PCIe
> controllers capability. No mater what value is set by the pci-bus.yaml
> schema (eventually we'll get to have it increased to Gen5 too) we can
> use the DW PCIe-specific limitation here as a known upper capabilities
> bound.

The latest DWC IP is likely going to support the latest gen within some 
amount of time. With each bump, we're going to have to update 
pci-bus.yaml and then this one too. Yet neither really has any impact 
if we provide a per controller limit.

Rob
