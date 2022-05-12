Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7CE52513E
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 17:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355929AbiELP1T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 11:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350445AbiELP1R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 11:27:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BAEE69707;
        Thu, 12 May 2022 08:27:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F05C5106F;
        Thu, 12 May 2022 08:27:15 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.2.156])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A8093F73D;
        Thu, 12 May 2022 08:27:12 -0700 (PDT)
Date:   Thu, 12 May 2022 16:27:05 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
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
Message-ID: <20220512152705.GA2506@lpieralisi>
References: <20220503205722.24755-1-Sergey.Semin@baikalelectronics.ru>
 <20220512001156.x6kqyhi3vjjpqch6@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220512001156.x6kqyhi3vjjpqch6@mobilestation>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 12, 2022 at 03:11:56AM +0300, Serge Semin wrote:
> On Tue, May 03, 2022 at 11:57:18PM +0300, Serge Semin wrote:
> > This patchset is an initial one in the series created in the framework
> > of my Baikal-T1 PCIe/eDMA-related work:
> > 
> > [1: In-progress v3] clk: Baikal-T1 DDR/PCIe resets and some xGMAC fixes
> > Link: https://lore.kernel.org/linux-pci/20220330144320.27039-1-Sergey.Semin@baikalelectronics.ru/
> > [2: In-progress v1] PCI: dwc: Various fixes and cleanups
> > Link: https://lore.kernel.org/linux-pci/20220324012524.16784-1-Sergey.Semin@baikalelectronics.ru/
> > [3: In-progress v1] PCI: dwc: Add dma-ranges/YAML-schema/Baikal-T1 support
> > Link: https://lore.kernel.org/linux-pci/20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru/
> > [4: In-progress v1] dmaengine: dw-edma: Add RP/EP local DMA controllers support
> > Link: https://lore.kernel.org/linux-pci/20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru/
> > 
> > Since some of the patches in the later patchsets depend on the
> > modifications introduced here, @Lorenzo could you please merge this series
> > through your PCIe subsystem repo? After getting all the required ack'es of
> > course.
> > 
> > Short summary regarding this patchset. A few more modifications are
> > introduced here to finally finish the Baikal-T1 CCU unit support up and
> > prepare the code before adding the Baikal-T1 PCIe/xGMAC support. First of
> > all it turned out I specified wrong DW xGMAC PTP reference clock divider
> > in my initial patches. It must be 8, not 10. Secondly I was wrong to add a
> > joint xGMAC Ref and PTP clock instead of having them separately defined.
> > The SoC manual describes these clocks as separate fixed clock wrappers.
> > Finally in order to close the SoC clock/reset support up we need to add
> > the DDR and PCIe interfaces reset controls support. It's done in two
> > steps. First I've moved the reset-controls-related code into a dedicated
> > module. Then the DDR/PCIe reset-control functionality is added.
> > 
> > Link: https://lore.kernel.org/linux-pci/20220324010905.15589-1-Sergey.Semin@baikalelectronics.ru/
> > Changelog v2:
> > - Resubmit the series with adding @Philipp to the list of the recipients.
> > 
> > Link: https://lore.kernel.org/linux-pci/20220330144320.27039-1-Sergey.Semin@baikalelectronics.ru/
> > Changelog v3:
> > - Rebased from v5.17 onto v5.18-rc3.
> > - No comments. Just resend the series.
> 
> No comments for more than a week. There were no comments in v1 and v2
> either. Please at least ack or merge in the series. It would be very
> appreciated to merge it in through one repo with the rest of the
> patchsets before the next merge window. @Bjorn, @Lorenzo, @Michael?

Hi Sergey,

these changes affect the clock tree and have to be reviewed and merged
by the respective maintainers if they think the changes can be accepted.

I don't see any reason why we should, if ACK'ed, take them in the PCI
tree, this series does not apply changes to the PCI tree at all and you
don't need it as a base for future to-be-merged PCI patches either.

So in short, this series has to go through the usual clock tree review
process.

Thanks,
Lorenzo

> -Sergey
> 
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: "Krzysztof Wilczyński" <kw@linux.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > Cc: linux-clk@vger.kernel.org
> > Cc: linux-pci@vger.kernel.org
> > Cc: linux-mips@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > 
> > Serge Semin (4):
> >   clk: baikal-t1: Fix invalid xGMAC PTP clock divider
> >   clk: baikal-t1: Define shared xGMAC ref/ptp clocks parent
> >   clk: baikal-t1: Move reset-controls code into a dedicated module
> >   clk: baikal-t1: Add DDR/PCIe directly controlled resets support
> > 
> >  drivers/clk/baikal-t1/Kconfig       |  12 +-
> >  drivers/clk/baikal-t1/Makefile      |   1 +
> >  drivers/clk/baikal-t1/ccu-div.c     |   1 +
> >  drivers/clk/baikal-t1/ccu-div.h     |   6 +
> >  drivers/clk/baikal-t1/ccu-rst.c     | 373 ++++++++++++++++++++++++++++
> >  drivers/clk/baikal-t1/ccu-rst.h     |  64 +++++
> >  drivers/clk/baikal-t1/clk-ccu-div.c | 102 ++------
> >  include/dt-bindings/reset/bt1-ccu.h |   9 +
> >  8 files changed, 482 insertions(+), 86 deletions(-)
> >  create mode 100644 drivers/clk/baikal-t1/ccu-rst.c
> >  create mode 100644 drivers/clk/baikal-t1/ccu-rst.h
> > 
> > -- 
> > 2.35.1
> > 
