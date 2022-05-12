Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891E352582D
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 01:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359408AbiELXUm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 19:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347549AbiELXUm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 19:20:42 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE5A27BC46;
        Thu, 12 May 2022 16:20:38 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id a23so230593ljd.9;
        Thu, 12 May 2022 16:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WBWVeheegSrEpGj7igBTHF2yhrLBHycQwDW5NFTLi8g=;
        b=eX+2ro4JTwaHBb2bo+LApjgYts1GmLMhnYiosuaGG32Qyy1B0jsLHU7LsVr3XMVlm8
         ygkyFLHgl5mZ01MVEHP6wL2xA8Dklv1kV62MPjcpx+KRIGctup8VGF0DpW6PPLgc8Mya
         cUQmly4RVywcy9ulGBxmGo5Gac0kj+w5HcAzg+5+3amPWMCB5eCO6OqlprxQTGvXgIyz
         agyY7OhhYSsQnM4dVu/sklVm1i7f4OeczHZ8UemeoF1caOLeWPVmIMUHIajioOWkxh9w
         RV+rEOSzlyvQEuxm/Xa7n5MiHcR9nQZowDZ6HHuU/vqHvOCtKdrkvC3S8XpddScr+2k5
         JNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WBWVeheegSrEpGj7igBTHF2yhrLBHycQwDW5NFTLi8g=;
        b=RDf+7lJZHttx08mq8FubOwK/a0lYRxhPNHQopuUZaqAgUZqc/aVhectOjO5JBSBcM5
         mnK5TOn4JOoKMCkqWZdYzOBBVAOikAhHQaNX9FHCIx8cUkYjaLvZNOqaxMEFIPbrUctd
         3mFkqa8RPga/TQvmQRyoGyfwjJNPFl31cIAwxKju0i8eNLbZDuSQIeU/3e47zo5zvp9B
         HaXqhtB0ibGyJGyWfBKyyyQKAfnqmVkghpmnt1KUS/POQxl5WX4vS4mlEQf9fTp/VJSU
         kWYc4yDksbwjMGxBe29v/4AWo1ZdHwNRx6KjhyTzUSTKP8dxFiqeCaH7Ha98lDIiaomH
         1xtA==
X-Gm-Message-State: AOAM531uHVxSxfPyK46SLF35Y0cdBIkLxx2grZ0fv2PJveHQE4UdZoVG
        L4JAJEHb08/yU0kDLygh+Kk=
X-Google-Smtp-Source: ABdhPJyA8TEW/IrjDw5qn51PPVQ+mxDVAnm99kbvxVHa1kwfmO9Z925b1O7oHxKU2h03IGnsrMknQw==
X-Received: by 2002:a05:651c:552:b0:250:5c23:d0f2 with SMTP id q18-20020a05651c055200b002505c23d0f2mr1387401ljp.239.1652397636861;
        Thu, 12 May 2022 16:20:36 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id v10-20020a2e504a000000b0024f3d1dae93sm147974ljd.27.2022.05.12.16.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 16:20:35 -0700 (PDT)
Date:   Fri, 13 May 2022 02:20:33 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/13] PCI: dwc: Various fixes and cleanups
Message-ID: <20220512232033.wpbr4excmftzlxdi@mobilestation>
References: <20220503212300.30105-1-Sergey.Semin@baikalelectronics.ru>
 <Yn1/GRzXNCTJnMHj@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yn1/GRzXNCTJnMHj@lpieralisi>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 12, 2022 at 10:41:45PM +0100, Lorenzo Pieralisi wrote:
> On Wed, May 04, 2022 at 12:22:47AM +0300, Serge Semin wrote:
> > This patchset is a second one in the series created in the framework of
> > my Baikal-T1 PCIe/eDMA-related work:
> > 
> > [1: In-progress v3] clk: Baikal-T1 DDR/PCIe resets and some xGMAC fixes
> > Link: https://lore.kernel.org/linux-pci/20220503205722.24755-1-Sergey.Semin@baikalelectronics.ru/
> > [2: In-progress v2] PCI: dwc: Various fixes and cleanups
> > Link: https://lore.kernel.org/linux-pci/20220324012524.16784-1-Sergey.Semin@baikalelectronics.ru/
> > [3: In-progress v1] PCI: dwc: Add dma-ranges/YAML-schema/Baikal-T1 support
> > Link: https://lore.kernel.org/linux-pci/20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru/
> > [4: In-progress v1] dmaengine: dw-edma: Add RP/EP local DMA controllers support
> > Link: https://lore.kernel.org/linux-pci/20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru/
> > 
> > Note it is very recommended to merge the patchsets in the same order as
> > they are placed in the list above in order to prevent possible merge/build
> > conflicts. Nothing prevents them from being reviewed synchronously though.
> > 
> > As it can be easily inferred from the patchset title, this series is about
> > the DW PCIe Root Port/End-point driver fixes and the code cleanups, where
> > fixes come before the cleanup patches. The patchset starts with adding the
> > stop_link() platform-specific method invocation in case of the PCIe host
> > probe procedure errors. It has been missing in the cleanup-on-error path
> > of the DW PCIe Host initialization method. After that there is a patch
> > which fixes the host own cfg-space accessors for the case of the
> > platform-specific DBI implementation. Third the unrolled CSRs layout is
> > added to the iATU disable procedure. Fourth the disable iATU procedure is
> > fixed to be called only for the internal ATU as being specific for the
> > internal ATU implementation. Last but no least the outbound iATU extended
> > region setup procedure is fixed to have the INCREASE_REGION_SIZE flag set
> > based on the limit-address - not the region size one.
> > 
> > Afterwards there is a series of cleanups. It concerns the changes like
> > adding braces to the multi-line if-else constructions, trailing new-lines
> > to the print format-string, dropping unnecessary version checking, and
> > various code simplifications and optimizations.
> 
> Hi,
> 
> I went through the series and I don't have any specific objections.
> 

> We can try to queue it for v5.19, with the caveat that the fixes
> _need_ testing on several DWC platforms

Alas I can't deliver that. But Manivannan has done a testing on his
Qualcomm devices.

> (and I _strongly_ encourage
> DWC maintainers to chime in). To sum it up:
> 

> - It is a mixture of clean-ups and fixes. I would prefer having the
>   cleanups earlier in the series and rebase (if there is a need, I
>   can try to reshuffle the patches myself) the fixes on top. That
>   because we may have to drop some of the fixes (and if we merge them
>   we may have to revert them as cleanly as we can),

Normally fixes patches go before ahead of the rest of the series to
simplify the backporting procedure (makes Greg's life much easier).
Revertability has much less priority. In the worst case an additional
fixes patch is more preferable especially if the original patch has
been reviewed, accepted and most likely backported. Only if the patch
author didn't provide a fix then the reversion is proceeded. So I
wouldn't recommend to reshuffle the patches.

>   my concern is that
>   they require testing on a number of platforms you have not been
>   exposed to

This series and another patchsets have been available for testing for
about two months now. There have been more than enough time to give it
a try and review.

> - Kbot complained about patch (3)

Could you be more specific what it was complaining about? I haven't
got any relevant message in none of my emails.

> - I will have comments about the commit logs but I can try to fix them
>   myself

Feel free to submit your comments. I'll take them into account in v3.

> 
> I have concerns especially about patches (2, 3, 4, 5, 8, 9), because
> they can affect DWC platforms other than the ones you are testing on.

Basically any generic code change affects the dependent platforms. If
you don't see any exact issue in mind then I don't see any reason to
sustain the series any longer especially seeing it has been already
tested on an alternative platform.

> 
> The cleanups we can definitely queue them up.

> As I said, and there
> is nothing I can do about it, I will be off the radar for two months
> from wednesday,

As I noted this isn't good since I haven't noticed much activity for
the last two months. Alas Bjorn hasn't participated in the review
process either. I can offer a help with reviewing the patches
concerning the DW PCIe drivers since during the patchsets development
I've got a good notion regarding the DWC drivers and HW internals. But
it only concerns the DW PCIe Host/End-point code.

> please try to repost with the Kbot issue fixed and

See my comment above regarding kbot.

-Sergey

> with the comments above in mind and I will do my best to queue as
> many patches from this series as possible for v5.19.
> 
> Thanks,
> Lorenzo
> 
> > New features like adding two-level DT bindings abstraction, adding better
> > structured IP-core version interface, adding iATU regions size detection
> > and the PCIe regions verification procedure, adding dma-ranges support,
> > introducing a set of generic platform clocks and resets and finally adding
> > Baikal-T1 PCIe interface support will be submitted in the next part of the
> > series.
> > 
> > Link: https://lore.kernel.org/linux-pci/20220324012524.16784-1-Sergey.Semin@baikalelectronics.ru/
> > Changelog v2:
> > - Fix the end address of the example in the patch log with
> >   the INCREASE_REGION_SIZE flag usage fixup. It should be
> >   0x1000FFFF and not 0x0000FFFF (@Manivannan).
> > - Add the cleanup-on-error path to the dw_pcie_ep_init() function.
> >   (@Manivannan)
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: "Krzysztof Wilczyński" <kw@linux.com>
> > Cc: Frank Li <Frank.Li@nxp.com>
> > Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Cc: linux-pci@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > 
> > Serge Semin (13):
> >   PCI: dwc: Stop link in the host init error and de-initialization
> >   PCI: dwc: Don't use generic IO-ops for DBI-space access
> >   PCI: dwc: Add unroll iATU space support to the regions disable method
> >   PCI: dwc: Disable outbound windows for controllers with iATU
> >   PCI: dwc: Set INCREASE_REGION_SIZE flag based on limit address
> >   PCI: dwc: Add braces to the multi-line if-else statements
> >   PCI: dwc: Add trailing new-line literals to the log messages
> >   PCI: dwc: Discard IP-core version checking on unrolled iATU detection
> >   PCI: dwc: Convert Link-up status method to using dw_pcie_readl_dbi()
> >   PCI: dwc: Deallocate EPC memory on EP init error
> >   PCI: dwc-plat: Simplify the probe method return value handling
> >   PCI: dwc-plat: Discard unused regmap pointer
> >   PCI: dwc-plat: Drop dw_plat_pcie_of_match forward declaration
> > 
> >  .../pci/controller/dwc/pcie-designware-ep.c   | 22 +++++--
> >  .../pci/controller/dwc/pcie-designware-host.c | 66 +++++++++++++++----
> >  .../pci/controller/dwc/pcie-designware-plat.c | 13 ++--
> >  drivers/pci/controller/dwc/pcie-designware.c  | 48 +++++++++-----
> >  4 files changed, 109 insertions(+), 40 deletions(-)
> > 
> > -- 
> > 2.35.1
> > 
