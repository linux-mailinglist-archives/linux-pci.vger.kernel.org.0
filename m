Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E3F55D2AA
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345198AbiF1MPq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 08:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245056AbiF1MPp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 08:15:45 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EFB25C69;
        Tue, 28 Jun 2022 05:15:44 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id t24so21954742lfr.4;
        Tue, 28 Jun 2022 05:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kHEtyK+afTRnQvXusEeUxociKuBzGjWIXP0enqXElr4=;
        b=TlWmuP9OMB55nUga7W5Kqb+EYt92GmaRCn+lORX2tVqbIS2iAiZE0qlE7SPyMqN7Mz
         9qd/GTchlefchvGIf7S2Ygp2xyvO9bn0EqTY4CIJfi/EBbyo6g8/rurTpGuzrNeIhhrm
         b0fHMfBB2bQiVMu4x0RLFrmdoDewbJgWTz5OHxID+I/faCylsOEBCllozznBGhKjB9NG
         IO6SScQWolkLGyv6zOBiphNyTcSngcBog4aeUB/0cRXdHiCWANbX+kz+np5F+1YjQsiV
         8v3a4zkUnR5p4yrMhxx4v2ZZOTcchOmukvKy3bpsxv1LPWade1ff3YP39cPNO/G8fjrq
         y9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kHEtyK+afTRnQvXusEeUxociKuBzGjWIXP0enqXElr4=;
        b=NfDRn+zKhBBmU7pO8KqXKrcS+5g6FqffEKA7WUnOODDjncJ5ZkDnwZruF/zYy6agau
         hGA8xudpIsxCUqWY5JA/7UaiUKFofAFLYx+C54cSoy9wRVzVzf91ibpJ2bSBsGMbZ65J
         4DiolMnSq1uKGk9/Zm+r6qp+gaO1plA3z5AITHr64GKeTOSLVkVxRfFW3vLzy6oE5jMH
         KRdiTwtxmc8IUELjCrdekEW0e8P2LNCY/xw6orNgM+3IRph1HLo7dwZElSpfgEHb4D3m
         3zhg+4mkmiEk1EIYH607aKCfC5MUIOx4nlvSh3IlplvRaem3RqypVxoW/comBjtrsPuJ
         znhw==
X-Gm-Message-State: AJIora9CIEe9gRyAVtwFjXU70JwqpJyvF20f93FVpi90nqxHqSSRDAO9
        +ZcBRgSQrYZ7OrWl5NjVHFQ=
X-Google-Smtp-Source: AGRyM1t7DdAiCPvHaJfAL5XAZk51QH8pq3Kn/IpSL6rLsVGim6I6libSANqVs/uASK5kDKtDS0UtrA==
X-Received: by 2002:a05:6512:2287:b0:481:337a:4591 with SMTP id f7-20020a056512228700b00481337a4591mr1398358lfu.95.1656418543213;
        Tue, 28 Jun 2022 05:15:43 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id a20-20020a05651c031400b0025aa2f6d700sm1602530ljp.62.2022.06.28.05.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 05:15:42 -0700 (PDT)
Date:   Tue, 28 Jun 2022 15:15:40 +0300
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
Message-ID: <20220628121540.oilmolkhqa43tf4e@mobilestation>
References: <20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru>
 <20220610085706.15741-5-Sergey.Semin@baikalelectronics.ru>
 <20220615145550.GA1069883-robh@kernel.org>
 <20220619142720.tzfgefunvf3kirul@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220619142720.tzfgefunvf3kirul@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rob,
Could you please get your attention back to this this thread?

-Sergey

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
> 
> > 
> > > +
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
> 
> > Patch 1 didn't apply for me, so none of the checks ran.
> 
> I see. The series will be re-based onto 5.19-rc1 in the next patchset
> revision.
> 
> -Sergey
> 
> > 
> > Rob
