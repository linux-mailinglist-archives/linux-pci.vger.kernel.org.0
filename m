Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F17D550B33
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jun 2022 16:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbiFSO13 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 19 Jun 2022 10:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbiFSO12 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 19 Jun 2022 10:27:28 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29671DF17;
        Sun, 19 Jun 2022 07:27:25 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id v8so9340320ljj.8;
        Sun, 19 Jun 2022 07:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+rnapiqQ/iNhoZEw55mrOqXhsrJQeJukdJJz0YdF52c=;
        b=btKsqxMh0C40YDCkv13jMTT4tBeyKqRThJOTgDQidjmj+Nd4TApTLf2W2CXI76gFAe
         Tmfr7IccdErVC7/+QZnqX6TjGwTKonEns0jc4qv3tbx/TUP5ZkzqwkWN/jCp4pjMItaO
         pdwZpZ+bH7+dsrVND+NXSURDWmQfI0eQS/4jdrASI50naDuv92TEZ5ns48PkLl7UmUmp
         9usp5zCcdT+ThHj5SXlrucXXm7HOui6GbHnkVln3pwmlCVOHGrBoY/XPiKghn6mshsh8
         q/bhbanGwa+RUs8iK8yXENyE3KQ8+Ni8d0YgJF3I+U8IRWZeLk1KNuP2llslcQkZ8nWN
         nT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+rnapiqQ/iNhoZEw55mrOqXhsrJQeJukdJJz0YdF52c=;
        b=s8JY24xWWWekammRwx7o8h0SrN+PIgE/1955KzaeSlOERvYezB7du3+Y56XoPQQFZf
         WogDLx+YINqA82ghhEUSyuQ4UogJ/Fur6E15kjhwG0xXPouiFLQMVTQ1aJ+nokt/x17P
         uEhWxcn9gg/E6/VEkUiIUBql3BidFQ7z3gx113BwJjbkeDrsQ/MgtonWrBuKZ12Y6exG
         BsYd/6TD5ky3FXVImzMbPDFJpvFUyyLuD4/9NHFEOocaP8El05+SUSWpwO0kQaaKlwVS
         BeAgu8ej9eVL7GtncDmWgZMVpshc7zj1Nl2CzsAADR22/Kz1J4YjJh2XX9t/gwPGUKYG
         QqiQ==
X-Gm-Message-State: AJIora/9pfzkDFvWumf3TEJwwU3Nlu8QKdRTStB6mxQujOB6Jg4n/22U
        IlyiimrdSYRYwyu+FfQF3zw=
X-Google-Smtp-Source: AGRyM1tS56MaWKOZQKyi2yt2tECPxHpi/mLAFtv3cpnx9pQl0v21LfZtSjWdshpNpIp13f6e825Pzw==
X-Received: by 2002:a2e:9893:0:b0:255:951f:9694 with SMTP id b19-20020a2e9893000000b00255951f9694mr9599779ljj.283.1655648843142;
        Sun, 19 Jun 2022 07:27:23 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id s19-20020a056512315300b00479353215b3sm549381lfi.139.2022.06.19.07.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 07:27:22 -0700 (PDT)
Date:   Sun, 19 Jun 2022 17:27:20 +0300
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
Message-ID: <20220619142720.tzfgefunvf3kirul@mobilestation>
References: <20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru>
 <20220610085706.15741-5-Sergey.Semin@baikalelectronics.ru>
 <20220615145550.GA1069883-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615145550.GA1069883-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 15, 2022 at 08:55:50AM -0600, Rob Herring wrote:
> On Fri, Jun 10, 2022 at 11:56:52AM +0300, Serge Semin wrote:
> > In accordance with [1] DW PCIe controllers support up to Gen5 link speed.
> > Let's add the max-link-speed property upper bound to 5 then. The DT
> > bindings of the particular devices are expected to setup more strict
> > constraint on that parameter.
> > 
> > [1] Synopsys DesignWare Cores PCI Express Controller Databook, Version
> > 5.40a, March 2019, p. 27
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > ---
> > 
> > Changelog v3:
> > - This is a new patch unpinned from the next one:
> >   https://lore.kernel.org/linux-pci/20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru/
> >   by the Rob' request. (@Rob)
> > ---
> >  Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml | 3 +++
> >  Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml     | 2 ++
> >  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml        | 1 +
> >  3 files changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> > index 627a5d6625ba..b2fbe886981b 100644
> > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> > @@ -45,6 +45,9 @@ properties:
> >        the peripheral devices available on the PCIe bus.
> >      maxItems: 1
> >  
> > +  max-link-speed:
> > +    maximum: 5
> 

> Unless the default is less than the max, shouldn't the max here be 1 
> less than the h/w max?

Why? AFAIU max-link-speed semantics it works as less-than-or-equal
operator isn't it? The modern DW PCIe Root ports and Endpoints
IP-cores support up to Gen5 PCIe speed including the Gen5 mode (see
the CX_MAX_PCIE_SPEED IP-core synthesize paramter). It's reasonable to
set the max-link-speed here to be in coherency with the IP-core
reference manual.

> 
> > +
> >    num-lanes:
> >      description:
> >        Number of PCIe link lanes to use. Can be omitted should the already
> > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> > index dcd521aed213..fc3b5d4ac245 100644
> > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> > @@ -55,4 +55,6 @@ examples:
> >  
> >        phys = <&pcie_phy0>, <&pcie_phy1>, <&pcie_phy2>, <&pcie_phy3>;
> >        phy-names = "pcie0", "pcie1", "pcie2", "pcie3";
> > +
> > +      max-link-speed = <3>;
> >      };
> > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > index 4a5c8b933b52..01cedf51e0f8 100644
> > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > @@ -74,4 +74,5 @@ examples:
> >        phy-names = "pcie";
> >  
> >        num-lanes = <1>;
> > +      max-link-speed = <3>;
> 

> This should give you an error because pci-bus.yaml only goes up to 4. 

I've set max-link-speed to "3" here. So no error will be caused neither
by this schema nor by the pci-bus.yaml bindings.

* Though these examples won't be evaluated because the generic DW PCIe
RP and EP schemas have been marked as "select: false".

> 
> I'm not really sure that limiting it in the common schema is too useful. 
> We're going to be updating it one step at a time. Limiting it is really 
> only helpful for specific implementations.
> 

I disagree. As I said above the max PCIe speed limit set here has been
taken from the HW reference manual so it describes the modern DW PCIe
controllers capability. No mater what value is set by the pci-bus.yaml
schema (eventually we'll get to have it increased to Gen5 too) we can
use the DW PCIe-specific limitation here as a known upper capabilities
bound.

> Patch 1 didn't apply for me, so none of the checks ran.

I see. The series will be re-based onto 5.19-rc1 in the next patchset
revision.

-Sergey

> 
> Rob
