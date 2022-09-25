Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71735E96A0
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 00:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbiIYWOt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 25 Sep 2022 18:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiIYWOr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 25 Sep 2022 18:14:47 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88F31276A;
        Sun, 25 Sep 2022 15:14:44 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id s10so5600374ljp.5;
        Sun, 25 Sep 2022 15:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=nAin+jVr/Jue1DrUKL2wb0fKwgFhUYwLmf2UBjoHz0I=;
        b=guwot6ip18jr0QFkpa0h++7ETxcp5vodjrTUzOXFcRa5yOJR+FHG9ASv+HJzGL3K4F
         KA1ZbD7JsqzlKbfhaSpguUq9KqecGOAINYypRs0UfQMryq35H2D0cc4DBz2osKt3yTEI
         j/EkLOUbuXTewv4Ms4sXIg6+Do62Z887BX83aLzgz5AXekhkE44a55KMod88NQPgppfm
         vMVcKniVSt3SPYm5hMd/mehDiL7cEzwAS4xyR+smZWZM0SLlDcK9GenViTSLzvLOT6jw
         v8IrXwwu85tuVDAZmsiNe22VHURf8p07047G6lSI5alBEWbb23sfhRMja7ZarjXRd1kN
         I5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=nAin+jVr/Jue1DrUKL2wb0fKwgFhUYwLmf2UBjoHz0I=;
        b=dEm3Xkl9cNl/tW5+lOqoLkPjw6dtw5UEDjFApfX94OR12I5tEElcT9t6v4XsPxed6A
         c6jYIrCHCsVVKGCO9IhgxytUOoZlx/zow92Dr63ot6yZ3lLzBdyL18iqHwAqhAWsF/gi
         AeTAaYRjzaIJaivOkavTbcf4pUbgOnnz7dQjfOO+b9jpCSmPimtTcVo32fnnWa2fLBmi
         HSkKDGguNJHoebffj7wj4ZmgFuY0D9np50RsxTmtJXZT+AHDDI9mpcr/66vBY91lg2d2
         saK6G+NLNVRP3PzSsRwACjBxjSTe0yvwNw7SiFLr4a1ine2+5KP1jNF8wymBXQMgMGTP
         AvBw==
X-Gm-Message-State: ACrzQf13hHTrX4B0SSm9IRA/POnZE49omskpU1M+6sVJJbeXky5E/+AA
        5j14vC1LmFKLfsYA5H6ZKNk=
X-Google-Smtp-Source: AMsMyM5A8hOm7TDV/BE/JjYLXx/M+m3k394esFJ8j5SAazjU8dDIvnHTlIfahnnLNtZ+IObzYsR5pg==
X-Received: by 2002:a2e:5d0:0:b0:26a:9a2d:ca90 with SMTP id 199-20020a2e05d0000000b0026a9a2dca90mr6157170ljf.102.1664144082987;
        Sun, 25 Sep 2022 15:14:42 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id k1-20020ac257c1000000b004947555dbc2sm2331424lfo.100.2022.09.25.15.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 15:14:42 -0700 (PDT)
Date:   Mon, 26 Sep 2022 01:14:40 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 09/20] dt-bindings: PCI: dwc: Add
 interrupts/interrupt-names common properties
Message-ID: <20220925221440.hk2ikb6mfecl2kmu@mobilestation>
References: <20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru>
 <20220822184701.25246-10-Sergey.Semin@baikalelectronics.ru>
 <20220831212443.GA267718-robh@kernel.org>
 <20220911190225.gmmmvbjbczsqwhdk@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220911190225.gmmmvbjbczsqwhdk@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

@Rob, anything to say on what I suggested below?

On Sun, Sep 11, 2022 at 10:02:25PM +0300, Serge Semin wrote:
> On Wed, Aug 31, 2022 at 04:24:43PM -0500, Rob Herring wrote:
> > On Mon, Aug 22, 2022 at 09:46:50PM +0300, Serge Semin wrote:
> > > Currently the 'interrupts' and 'interrupt-names' are defined being too
> > > generic to really describe any actual IRQ interface. Moreover the DW PCIe
> > > End-point devices are left with no IRQ signals. All of that can be fixed
> > > by adding the IRQ-related properties to the common DW PCIe DT-schema and
> > > defining a common and device-specific set of the IRQ names in accordance
> > > with the hardware reference manual. Seeing there are common and dedicated
> > > IRQ signals for DW PCIe Root Port and End-point controllers we suggest to
> > > split the IRQ names up into two sets: common definitions available in the
> > > snps,dw-pcie-common.yaml schema and Root Port specific names defined in
> > > the snps,dw-pcie.yaml schema. The former one will be applied to both DW
> > > PCIe RP and EP controllers, while the later one - for the RP only.
> > > 
> > > Note since there are DW PCI-based vendor-specific DT-bindings with the
> > > custom names assigned to the same IRQ resources we have no much choice but
> > > to add them to the generic DT-schemas in order to have the schemas being
> > > applicable for such devices. Let's mark these names as deprecated so not
> > > to encourage the new DT-bindings to use them.
> > > 
> > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > 
> > > ---
> > > 
> > > Changelog v3:
> > > - This is a new patch unpinned from the next one:
> > >   https://lore.kernel.org/linux-pci/20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru/
> > >   by the Rob' request. (@Rob)
> > > 
> > > Changelog v5:
> > > - Add platform-specific interrupt names, but mark them as deprecated.
> > > ---
> > >  .../bindings/pci/snps,dw-pcie-common.yaml     | 51 ++++++++++++++
> > >  .../bindings/pci/snps,dw-pcie-ep.yaml         | 17 +++++
> > >  .../devicetree/bindings/pci/snps,dw-pcie.yaml | 67 ++++++++++++++++++-
> > >  3 files changed, 132 insertions(+), 3 deletions(-)
> > 
> 
> > I still don't like how you've done interrupts/clocks/reg. I'd suggest 
> > dropping it if you want this series applied soonish.
> 
> I can't drop this modification because what is currently done with the
> generic resource names much worse. Most importantly the generic names
> suggested here are also added to the driver in the framework of this
> patchset. So one way or another these new names need to be
> added to the DT-bindings.
> 
> As I already said many times we need to find a solution which would
> suit both of us. For me it's to add the new names with detailed
> description and if possible restrict the non-standard resource names
> usage. For you it's to implement a suitable named properties
> constraints. At the same time you keep pushing only what you need
> without concerning what is required for this patchset to be coherent
> in accordance with the new functionality.
> 
> I've listed all the possible options in this message:
> https://lore.kernel.org/linux-pci/20220619163727.xjdlx2jf565uhids@mobilestation/
> I asked you many times to pay your attention to it, but you kept
> ignoring these requests so I had to resubmit the series after waiting
> more than two months for your response. Please let's find out a
> solution which would suit both of us this time.
> 
> So you don't like having the "definitions" keyword in the DT-schemas.
> Do you? Ok. I'll just move all the names defined in there right in the
> named properties constraints. But in any case since these are the
> common DT-schemas we are talking about we can't expect the names being
> specified in a fixed order since at the very least some of them can be
> absent in particular device implementation. What do you say on this?
> Do you have any alternative solution I miss?
> 
> -Sergey
> 
> > 
> > Rob
