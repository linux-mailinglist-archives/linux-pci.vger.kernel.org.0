Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBD55256E4
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 23:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358478AbiELVOi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 17:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235641AbiELVOi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 17:14:38 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E985B5DD1F;
        Thu, 12 May 2022 14:14:36 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bq30so11289122lfb.3;
        Thu, 12 May 2022 14:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2fvUun18Y3H3meaphIs95kvs9TKAJnuvpJthSALeEsM=;
        b=SYgDrGbNWezxlXhEFlbnKE3qsxKpg88XcLFqsc7qV+AJzja8nq9Uexp4VpOOl+mC3e
         jhMnlzK2uojPDcPOqs6NTPtCQJGBFRhg5A5ZuPF27RmZsEndI34lxxxzNyqfcbdLO9Fv
         Q5xxhUUGW0kMcMd2HeXixR9aWsR0HFAbrwkMYJH8KpZk7stUNhRtvbmr1Y1ESAj25ZPo
         MEt46XQG+ql7Wrp74OArn7vvK2YjM8kel2xsR0aj98UqlxpFZUqYVi2J5J4Fa89HvEJG
         WUuhfKWD5wvAfD2ENIv2dnY1BGFaSnUJCucHcsHBBkvPV8CzWY5lrXXsIAYZRcudHRfv
         UAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2fvUun18Y3H3meaphIs95kvs9TKAJnuvpJthSALeEsM=;
        b=sozquFOcTMDkfjCrmF+X4AjoaCSS/u4hpxdgEUo9r2WJBwp61YM7C7hXfHYjgZbmqZ
         i973Lh/jY8+kIhmEdAqgqTDWpaMFODf2NBOdVokiXRm8bZi3jgsfyOJmxbv97CAJm7+U
         RDoxd63tzHWAFN8M24P2h5W6AP2RGor4HvhDaxmFkkJUMmOE7imy4kAcS23cX/pZ7Uot
         buQm2yYZHp0XGhgze5zL7P2I3aAVtjd6Pe7VL5vrAqDoaGYUZCGQ5/0zgeqVxjOwUeX1
         oSHZ/lKf7HT80O2B8cka8gr/E5Au415F7TDeeNMGn8sEpUoCUonfsswSbQzhqqfi7XUm
         R0Nw==
X-Gm-Message-State: AOAM531jMzlgbkcaG+/BwYSeOyKwMUUH4YNYQsdXA2m3cIcT0ear3yyr
        xjxPLl8JUOfDhzXTEKdoasnTwU48oOMogA==
X-Google-Smtp-Source: ABdhPJw0FfTmusT3d920y6m5KoaaHCk+Tsb3Q08jENhNjHIibospIHJ569V43l4Bjqcs7Ohp7XYiIg==
X-Received: by 2002:ac2:5cc7:0:b0:472:5be:eb7b with SMTP id f7-20020ac25cc7000000b0047205beeb7bmr1081981lfq.663.1652390075108;
        Thu, 12 May 2022 14:14:35 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id p23-20020a2e8057000000b0024f3d1dae7csm104867ljg.4.2022.05.12.14.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 14:14:33 -0700 (PDT)
Date:   Fri, 13 May 2022 00:14:31 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] clk: Baikal-T1 DDR/PCIe resets and some xGMAC
 fixes
Message-ID: <20220512211431.r23r6daua36lty7d@mobilestation>
References: <20220503205722.24755-1-Sergey.Semin@baikalelectronics.ru>
 <20220512001156.x6kqyhi3vjjpqch6@mobilestation>
 <20220512152705.GA2506@lpieralisi>
 <20220512171150.GA164627@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220512171150.GA164627@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 12, 2022 at 10:41:50PM +0530, Manivannan Sadhasivam wrote:
> On Thu, May 12, 2022 at 04:27:05PM +0100, Lorenzo Pieralisi wrote:
> > On Thu, May 12, 2022 at 03:11:56AM +0300, Serge Semin wrote:
> > > On Tue, May 03, 2022 at 11:57:18PM +0300, Serge Semin wrote:
> > > > This patchset is an initial one in the series created in the framework
> > > > of my Baikal-T1 PCIe/eDMA-related work:
> > > > 
> > > > [1: In-progress v3] clk: Baikal-T1 DDR/PCIe resets and some xGMAC fixes
> > > > Link: https://lore.kernel.org/linux-pci/20220330144320.27039-1-Sergey.Semin@baikalelectronics.ru/
> > > > [2: In-progress v1] PCI: dwc: Various fixes and cleanups
> > > > Link: https://lore.kernel.org/linux-pci/20220324012524.16784-1-Sergey.Semin@baikalelectronics.ru/
> > > > [3: In-progress v1] PCI: dwc: Add dma-ranges/YAML-schema/Baikal-T1 support
> > > > Link: https://lore.kernel.org/linux-pci/20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru/
> > > > [4: In-progress v1] dmaengine: dw-edma: Add RP/EP local DMA controllers support
> > > > Link: https://lore.kernel.org/linux-pci/20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru/
> > > > 
> > > > Since some of the patches in the later patchsets depend on the
> > > > modifications introduced here, @Lorenzo could you please merge this series
> > > > through your PCIe subsystem repo? After getting all the required ack'es of
> > > > course.
> > > > 
> > > > Short summary regarding this patchset. A few more modifications are
> > > > introduced here to finally finish the Baikal-T1 CCU unit support up and
> > > > prepare the code before adding the Baikal-T1 PCIe/xGMAC support. First of
> > > > all it turned out I specified wrong DW xGMAC PTP reference clock divider
> > > > in my initial patches. It must be 8, not 10. Secondly I was wrong to add a
> > > > joint xGMAC Ref and PTP clock instead of having them separately defined.
> > > > The SoC manual describes these clocks as separate fixed clock wrappers.
> > > > Finally in order to close the SoC clock/reset support up we need to add
> > > > the DDR and PCIe interfaces reset controls support. It's done in two
> > > > steps. First I've moved the reset-controls-related code into a dedicated
> > > > module. Then the DDR/PCIe reset-control functionality is added.
> > > > 
> > > > Link: https://lore.kernel.org/linux-pci/20220324010905.15589-1-Sergey.Semin@baikalelectronics.ru/
> > > > Changelog v2:
> > > > - Resubmit the series with adding @Philipp to the list of the recipients.
> > > > 
> > > > Link: https://lore.kernel.org/linux-pci/20220330144320.27039-1-Sergey.Semin@baikalelectronics.ru/
> > > > Changelog v3:
> > > > - Rebased from v5.17 onto v5.18-rc3.
> > > > - No comments. Just resend the series.
> > > 
> > > No comments for more than a week. There were no comments in v1 and v2
> > > either. Please at least ack or merge in the series. It would be very
> > > appreciated to merge it in through one repo with the rest of the
> > > patchsets before the next merge window. @Bjorn, @Lorenzo, @Michael?
> > 

Hello Lorenzo, Manivannan

> > Hi Sergey,
> > 
> > these changes affect the clock tree and have to be reviewed and merged
> > by the respective maintainers if they think the changes can be accepted.
> > 
> > I don't see any reason why we should, if ACK'ed, take them in the PCI
> > tree, this series does not apply changes to the PCI tree at all and you
> > don't need it as a base for future to-be-merged PCI patches either.
> > 
> > So in short, this series has to go through the usual clock tree review
> > process.
> > 

I do know the normal procedure. But if patches concern different
subsystems but for some reason inter-depended somehow it's ok to merge
them in via a single repo. In my case the platform clock driver has
been updated in a way so to support the reset-controls utilized in the
PCIe driver altered in another patchset. So I didn't want to leave the
kernel not working in the framework of my platform on any git hash
state. That's why I asked to merge the patchsets in via the same repo.
The kernel would be still buildable though.

> 
> Yes, Stephen should be the one taking these patches through the clk tree. Also,
> there is no need to club both pci and clk patches in a single tree. That's
> usually done for patches with build dependencies, but here there are none.

Well, I didn't expect to have my patchsets review to be that delayed.
Now seeing Lorenzo is going to review only DW PCIe fixes and cleanups
after which will be gone for two more months I have to admit that my
plan of getting the changes accepted in 5.19 won't come true. Really
I thought of any subsystem but not of PCIe/DMA that review procedure
would last that long.

-Sergey

> 
> Thanks,
> Mani
> 
> > Thanks,
> > Lorenzo
> > 
> > > -Sergey
> > > 
> > > > 
> > > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > > Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > > > Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> > > > Cc: Rob Herring <robh@kernel.org>
> > > > Cc: "Krzysztof Wilczyński" <kw@linux.com>
> > > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > > > Cc: linux-clk@vger.kernel.org
> > > > Cc: linux-pci@vger.kernel.org
> > > > Cc: linux-mips@vger.kernel.org
> > > > Cc: linux-kernel@vger.kernel.org
> > > > 
> > > > Serge Semin (4):
> > > >   clk: baikal-t1: Fix invalid xGMAC PTP clock divider
> > > >   clk: baikal-t1: Define shared xGMAC ref/ptp clocks parent
> > > >   clk: baikal-t1: Move reset-controls code into a dedicated module
> > > >   clk: baikal-t1: Add DDR/PCIe directly controlled resets support
> > > > 
> > > >  drivers/clk/baikal-t1/Kconfig       |  12 +-
> > > >  drivers/clk/baikal-t1/Makefile      |   1 +
> > > >  drivers/clk/baikal-t1/ccu-div.c     |   1 +
> > > >  drivers/clk/baikal-t1/ccu-div.h     |   6 +
> > > >  drivers/clk/baikal-t1/ccu-rst.c     | 373 ++++++++++++++++++++++++++++
> > > >  drivers/clk/baikal-t1/ccu-rst.h     |  64 +++++
> > > >  drivers/clk/baikal-t1/clk-ccu-div.c | 102 ++------
> > > >  include/dt-bindings/reset/bt1-ccu.h |   9 +
> > > >  8 files changed, 482 insertions(+), 86 deletions(-)
> > > >  create mode 100644 drivers/clk/baikal-t1/ccu-rst.c
> > > >  create mode 100644 drivers/clk/baikal-t1/ccu-rst.h
> > > > 
> > > > -- 
> > > > 2.35.1
> > > > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
