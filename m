Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F9F56AB2D
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 21:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235637AbiGGTCT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 15:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbiGGTCS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 15:02:18 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1467433E2B;
        Thu,  7 Jul 2022 12:02:15 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id e12so32711265lfr.6;
        Thu, 07 Jul 2022 12:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q1DoF0c//9rI+20kpcNcAwBtlgZwdI5Tgsxx3beAwIY=;
        b=cNkHIPA8UJqSwtfwUhKjn5+U5W1SC1/U75uTdFu9nRTyVX/WC5qGjTJWDpFVjI+++U
         f/XuKVkX5IawyoZ8GnbwLhC7TvftVk9RYTNGByDjg4dtqNYjUeqNwUvN9YJzTs7MSw/O
         /gbxQXLwJJWrywO05J3zLyXO4GIzTmIsBOy7xoWEiBSkmIfQB/1yHc8CO4gGeAkyYXno
         yKro6y3xMS186i5/RlH+pChrQXHl7LwsOvDg8AYGNOV/bFkPU/zI4OquAbuTWk4snaYz
         P6Kjky2abOgllAA+XjK17rVcOVFbQy2AJD5QQuojoiTFGxC2v8I1n3fvK2II/GITNM4y
         8x8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q1DoF0c//9rI+20kpcNcAwBtlgZwdI5Tgsxx3beAwIY=;
        b=PZ6yfCysNXpJomynZp+QVhqB8aEC3P/qtYTcrPcLrA+MXT+/P3YPzqPbrl4kITam7n
         ia1Da211r/lAOjt8rR/XHZgPg/M030IRYOvypJAS2hfo/KI4X6kSaFxhbSN5EM1CQY8C
         tkZ5SCkdw/ehdzTLkLJCzc6dHemB3dqRIEjvrTLsMY5OThuxMxfUVUoDAXl2Hgto0Rvv
         6DpTGDnVhzZdIJhfYfsCzJ6WoDBx/ji0Cy8YdQZbTP6a0lIvh3VlTX3SrdAs9dd+weLM
         lOlteHqj49i21WGmup72qETBdbfNHxLQET+d637m4vSyLIT1NmzYeglWetz9DFtF6Crw
         5eiQ==
X-Gm-Message-State: AJIora8KqhFjGqoAD/MYtK97K6gxO50m7zp0XMPA4oaXBwXT8GK4y3MV
        5B7CCW0IcTJtEzeOfI7/es2RFw7xbwom4g==
X-Google-Smtp-Source: AGRyM1scRnJl4YiWIHPtQyEaxltd4wyHp7cfXzTpiY0KfJ2Bwa4t03yYYGZPhXTiP5++AJGKqdkY5Q==
X-Received: by 2002:a05:6512:398d:b0:482:d1b6:d7c2 with SMTP id j13-20020a056512398d00b00482d1b6d7c2mr11889882lfu.628.1657220533343;
        Thu, 07 Jul 2022 12:02:13 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id b26-20020ac2563a000000b00486a4491ef8sm954454lff.205.2022.07.07.12.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 12:02:12 -0700 (PDT)
Date:   Thu, 7 Jul 2022 22:02:09 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
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
Message-ID: <20220707190209.t23v6ttr5t3qjuec@mobilestation>
References: <20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru>
 <20220610085706.15741-5-Sergey.Semin@baikalelectronics.ru>
 <20220615145550.GA1069883-robh@kernel.org>
 <20220619142720.tzfgefunvf3kirul@mobilestation>
 <20220701144424.GA804716-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701144424.GA804716-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 01, 2022 at 08:44:24AM -0600, Rob Herring wrote:
> On Sun, Jun 19, 2022 at 05:27:20PM +0300, Serge Semin wrote:
> > On Wed, Jun 15, 2022 at 08:55:50AM -0600, Rob Herring wrote:
> > > On Fri, Jun 10, 2022 at 11:56:52AM +0300, Serge Semin wrote:
> > > > In accordance with [1] DW PCIe controllers support up to Gen5 link speed.
> > > > Let's add the max-link-speed property upper bound to 5 then. The DT
> > > > bindings of the particular devices are expected to setup more strict
> > > > constraint on that parameter.
> > > > 
> > > > [1] Synopsys DesignWare Cores PCI Express Controller Databook, Version
> > > > 5.40a, March 2019, p. 27
> > > > 
> > > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > > 
> > > > ---
> > > > 
> > > > Changelog v3:
> > > > - This is a new patch unpinned from the next one:
> > > >   https://lore.kernel.org/linux-pci/20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru/
> > > >   by the Rob' request. (@Rob)
> > > > ---
> > > >  Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml | 3 +++
> > > >  Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml     | 2 ++
> > > >  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml        | 1 +
> > > >  3 files changed, 6 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> > > > index 627a5d6625ba..b2fbe886981b 100644
> > > > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> > > > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> > > > @@ -45,6 +45,9 @@ properties:
> > > >        the peripheral devices available on the PCIe bus.
> > > >      maxItems: 1
> > > >  
> > > > +  max-link-speed:
> > > > +    maximum: 5
> > > 
> > 
> > > Unless the default is less than the max, shouldn't the max here be 1 
> > > less than the h/w max?
> > 
> > Why? AFAIU max-link-speed semantics it works as less-than-or-equal
> > operator isn't it? The modern DW PCIe Root ports and Endpoints
> > IP-cores support up to Gen5 PCIe speed including the Gen5 mode (see
> > the CX_MAX_PCIE_SPEED IP-core synthesize paramter). It's reasonable to
> > set the max-link-speed here to be in coherency with the IP-core
> > reference manual.
> 

> It is supposed to be an override for the default. Wouldn't the default 
> always be the max the IP supports?

No. It depends on the controller implementation, link-partner
capability and results of the negotiation procedure. In our case by
default the link can't be established higher than Gen.2. In order to
rise it up to maximum possible Gen.3, the link must be re-established
with special flag set in the controller CSR.

> In any case, this max is only accurate for the current/latest version of 
> the IP. For older versions, it's not an accurate limit. I think it 
> should just be dropped and each controller needs to provide a limit.

The generic bindings can have some more relaxed constraints than older
IP-core released would have. It's absolutely normal to have the
IP-core evolve in time: new standard support is added, new properties,
new clocks sources or reset controls are added, etc. All of that IMO
should be taken into account in the generic DT-schema as it's supposed
to be as generic as possible a priori. It can have some properties
defined, which particular device release can lack of (a brightest
example is the clock/reset-names). While the particular device
DT-schema shall have a more rigor constraints so the corresponding
DT-node would have only the supported properties.

> 
> 
> > > >    num-lanes:
> > > >      description:
> > > >        Number of PCIe link lanes to use. Can be omitted should the already
> > > > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> > > > index dcd521aed213..fc3b5d4ac245 100644
> > > > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> > > > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> > > > @@ -55,4 +55,6 @@ examples:
> > > >  
> > > >        phys = <&pcie_phy0>, <&pcie_phy1>, <&pcie_phy2>, <&pcie_phy3>;
> > > >        phy-names = "pcie0", "pcie1", "pcie2", "pcie3";
> > > > +
> > > > +      max-link-speed = <3>;
> > > >      };
> > > > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > index 4a5c8b933b52..01cedf51e0f8 100644
> > > > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > @@ -74,4 +74,5 @@ examples:
> > > >        phy-names = "pcie";
> > > >  
> > > >        num-lanes = <1>;
> > > > +      max-link-speed = <3>;
> > > 
> > 
> > > This should give you an error because pci-bus.yaml only goes up to 4. 
> > 
> > I've set max-link-speed to "3" here. So no error will be caused neither
> > by this schema nor by the pci-bus.yaml bindings.
> > 
> > * Though these examples won't be evaluated because the generic DW PCIe
> > RP and EP schemas have been marked as "select: false".
> 
> Uh, I don't know what I was thinking...
> 
> > 
> > > 
> > > I'm not really sure that limiting it in the common schema is too useful. 
> > > We're going to be updating it one step at a time. Limiting it is really 
> > > only helpful for specific implementations.
> > > 
> > 
> > I disagree. As I said above the max PCIe speed limit set here has been
> > taken from the HW reference manual so it describes the modern DW PCIe
> > controllers capability. No mater what value is set by the pci-bus.yaml
> > schema (eventually we'll get to have it increased to Gen5 too) we can
> > use the DW PCIe-specific limitation here as a known upper capabilities
> > bound.
> 

> The latest DWC IP is likely going to support the latest gen within some 
> amount of time.

Well, in general not necessarily. New incompatible IP-core might get
released instead by the vendor. Vendor can stop supporting the DW PCIe
controller IP-core, etc.

> With each bump, we're going to have to update 
> pci-bus.yaml and then this one too.

I don't see much problem in updating the common property when the new
IP-core and its instances are released.
pci-bus.yaml is supposed to contain a generic max PCIe speed defined
by the standards (although currently it doesn't).
snps,dw-pcie-common.yaml will contain the maximum PCIe speed supported
by the known device instances.
These schemas most likely won't be updated synchronously especially
seeing pci-bus.yaml currently defines max PCIe bus speed of Gen.3,
which isn't the maximum the recent standard defines.

> Yet neither really has any impact 
> if we provide a per controller limit.

If we don't provide the max-link-speed property constraint in the
generic DW PCIe DT-schema, the bindings will be less accurate.
What if the vendor-specific bindings miss the max-link-speed property
constraint while the pci-bus.yaml has greater upper limit than the
IP-core will ever support?..

Anyway I think I've made my point more than clear. I have nothing to
add in this matter. Let's finally finish the discussion. If I wasn't
persuasive enough for you, just explicitly tell me that you'd rather
dropped the patch. So what is your conclusion?

-Sergey

> 
> Rob
