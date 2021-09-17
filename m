Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D429540F4D4
	for <lists+linux-pci@lfdr.de>; Fri, 17 Sep 2021 11:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240244AbhIQJcg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Sep 2021 05:32:36 -0400
Received: from sibelius.xs4all.nl ([83.163.83.176]:57329 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239040AbhIQJcf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Sep 2021 05:32:35 -0400
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id 4f816570;
        Fri, 17 Sep 2021 11:31:10 +0200 (CEST)
Date:   Fri, 17 Sep 2021 11:31:10 +0200 (CEST)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Marc Zyngier <maz@kernel.org>
Cc:     sven@svenpeter.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, lorenzo.pieralisi@arm.com,
        kw@linux.com, alyssa@rosenzweig.io, stan@corellium.com,
        kettenis@openbsd.org, marcan@marcan.st, Robin.Murphy@arm.com,
        kernel-team@android.com
In-Reply-To: <87mtobblvd.wl-maz@kernel.org> (message from Marc Zyngier on Fri,
        17 Sep 2021 10:19:02 +0100)
Subject: Re: [PATCH v3 10/10] PCI: apple: Configure RID to SID mapper on device addition
References: <20210913182550.264165-1-maz@kernel.org>
        <20210913182550.264165-11-maz@kernel.org>
        <b502383a-fe68-498a-b714-7832d3c8703e@www.fastmail.com>
        <87y27zbiu3.wl-maz@kernel.org>
        <56145a72aa978ebd@bloch.sibelius.xs4all.nl> <87mtobblvd.wl-maz@kernel.org>
Message-ID: <56146608f4547f39@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Date: Fri, 17 Sep 2021 10:19:02 +0100
> From: Marc Zyngier <maz@kernel.org>
> 
> On Tue, 14 Sep 2021 10:56:05 +0100,
> Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> > 
> > > Date: Tue, 14 Sep 2021 10:35:32 +0100
> > > From: Marc Zyngier <maz@kernel.org>
> > > 
> > > On Mon, 13 Sep 2021 21:45:13 +0100,
> > > "Sven Peter" <sven@svenpeter.dev> wrote:
> > > > 
> > > > On Mon, Sep 13, 2021, at 20:25, Marc Zyngier wrote:
> > > > > The Apple PCIe controller doesn't directly feed the endpoint's
> > > > > Requester ID to the IOMMU (DART), but instead maps RIDs onto
> > > > > Stream IDs (SIDs). The DART and the PCIe controller must thus
> > > > > agree on the SIDs that are used for translation (by using
> > > > > the 'iommu-map' property).
> > > > > 
> > > > > For this purpose, parse the 'iommu-map' property each time a
> > > > > device gets added, and use the resulting translation to configure
> > > > > the PCIe RID-to-SID mapper. Similarily, remove the translation
> > > > > if/when the device gets removed.
> > > > > 
> > > > > This is all driven from a bus notifier which gets registered at
> > > > > probe time. Hopefully this is the only PCI controller driver
> > > > > in the whole system.
> > > > > 
> > > > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > > > ---
> > > > >  drivers/pci/controller/pcie-apple.c | 158 +++++++++++++++++++++++++++-
> > > > >  1 file changed, 156 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/pci/controller/pcie-apple.c 
> > > > > b/drivers/pci/controller/pcie-apple.c
> > > > > index 76344223245d..68d71eabe708 100644
> > > > > --- a/drivers/pci/controller/pcie-apple.c
> > > > > +++ b/drivers/pci/controller/pcie-apple.c
> > > > > @@ -23,8 +23,10 @@
> > > > >  #include <linux/iopoll.h>
> > > > >  #include <linux/irqchip/chained_irq.h>
> > > > >  #include <linux/irqdomain.h>
> > > > > +#include <linux/list.h>
> > > > >  #include <linux/module.h>
> > > > >  #include <linux/msi.h>
> > > > > +#include <linux/notifier.h>
> > > > >  #include <linux/of_irq.h>
> > > > >  #include <linux/pci-ecam.h>
> > > > >  
> > > > > @@ -116,6 +118,8 @@
> > > > >  #define   PORT_TUNSTAT_PERST_ACK_PEND	BIT(1)
> > > > >  #define PORT_PREFMEM_ENABLE		0x00994
> > > > >  
> > > > > +#define MAX_RID2SID			64
> > > > 
> > > > Do these actually have 64 slots? I thought that was only for
> > > > the Thunderbolt controllers and that these only had 16.
> > > 
> > > You are indeed right, and I blindly used the limit used in the
> > > Correlium driver. Using entries from 16 onward result in a non booting
> > > system. The registers do not fault though, and simply ignore writes. I
> > > came up with an simple fix for this, see below.
> > 
> > Or should be add a property to the DT binding to indicate the number
> > of entries (using a default of 16)?  We don't have to add that
> > property right away; we can delay that until we actually try to
> > support the Thunderbolt ports.
> 
> I'd rather only add a property for things we cannot discover
> ourselves. And indeed, we don't have to decide on this right now.
> 
> > In case you didn't know already, RIDs that have no mapping in the
> > RID2SID table map to SID 0.  That's why I picked 1 as the SID in the
> > iommu-map property for the port.
> 
> I sort-off guessed, as using 0 made everything work by 'magic', while
> using your DT prevented the machine from booting. I tend to dislike
> magic, hence this patch.

Right.  I deliberately used SID 1 in the DT to make sure other devices
on the bus couldn't accidentally use IOMMU mappings for a device that
was mapped to SID 0.
 
> > > > I never checked it myself though and it doesn't make much
> > > > of a difference for now since only four different RIDs will
> > > > ever be connected anyway.
> > > 
> > > Four? I guess the radios expose more than a single RID?
> > 
> > At this point, on the M1 mini there is the Broadcom BCM4378 WiFi/BT
> > device (which has two functions), the Fresco Logic FL1100 xHCI
> > controller (single function) and the Broadcom BCM57765 Ethernet
> > controller.  So yes, there are for RIDs.
> 
> But as far as I can see, the RID-to-SID mapping is per port. So at
> most, we have two RIDs per port/DART, not four. Or am I missing
> something altogether?

No you're not missing anything.
