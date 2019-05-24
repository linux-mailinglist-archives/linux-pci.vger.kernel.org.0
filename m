Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 993FB29E3C
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2019 20:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfEXSlP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 May 2019 14:41:15 -0400
Received: from libmpq.org ([85.25.94.4]:52300 "EHLO mail.libmpq.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbfEXSlO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 May 2019 14:41:14 -0400
Received: from libmpq.org (homer.theraso.int [172.16.50.110])
        by mail.libmpq.org (Postfix) with ESMTPSA id 45AF3395A5D;
        Fri, 24 May 2019 20:41:13 +0200 (CEST)
Date:   Fri, 24 May 2019 20:41:13 +0200
From:   Maik Broemme <mbroemme@libmpq.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        vfio-users <vfio-users@redhat.com>
Subject: Re: [PATCH] PCI: Mark Intel bridge on SuperMicro Atom C3xxx
 motherboards to avoid bus reset
Message-ID: <20190524184113.GK1654@libmpq.org>
References: <20190524153118.GA12862@libmpq.org>
 <20190524104003.2f7f1363@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524104003.2f7f1363@x1.home>
X-Operating-System: Linux homer.theraso.int 5.1.4-arch1-1-ARCH 
X-PGP-Key-FingerPrint: 109D 0AC6 86CF 06BD 4890  17B0 8FB9 9971 4EEB 31F1
Organization: Personal
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alex,

On May 24, 2019, at 18:49, Alex Williamson <alex.williamson@redhat.com> wrote:
> On Fri, 24 May 2019 17:31:18 +0200
> Maik Broemme <mbroemme@libmpq.org> wrote:
> 
> > The Intel PCI bridge on SuperMicro Atom C3xxx motherboards do not
> > successfully complete a bus reset when used with certain child devices.
> 
> What are these 'certain child devices'?  We can't really regression
> test to know if/when the problem might be resolved if we don't know
> what to test.

I tried the following devices:

- Digital Devices GmbH Octopus DVB Adapter
- Digital Devices GmbH Cine S2 V6.5
- Digital Devices GmbH Cine S2 V7
- RealTek RTL8111D
- RealTek RTL8168B
- Intel I210-T1

> Do these devices reset properly in other systems?

All these cards survive VFIO reset and VM reboot cycles in another
motherboard (SuperMicro X11SPM-F). They only fail in the SuperMicro
A2SDi-*C-HLN4F series. I have a 8 core and 16 core version of this
motherboard.

I've tried a passive Mini PCI-E adapter (MikroTik RB11E) in the slot
with several wireless adapters (don't remember them all) and the
'Digital Devices GmbH Octopus DVB Adapter' which is Mini PCI-E. They all
produced the same error 'Failed to return from FLR' and '!!! Unknown
header type 7f'

Also I've tried a PCI-E switch from PLX technology, sold by MikroTik, the
RouterBoard RB14eU. It is exports 4 Mini PCI ports in one PCI-E port and
I tried it with one card and multiple cards.

All these devices start to work once I enabled the bus reset quirk. The
RB14eU even allows to assign the individual Mini PCI-E ports to
different VMs and survive independent resets behind the PLX bridge.

> Are there any devices that can do a bus reset properly on this system?

I'm pretty sure not, of course I can test only devices I own and at
least the Intel I210-T1 supports all functionality to do a proper reset.

I own these motherboards since ~2 years and tried almost any device I
had during this time.

> We'd really only want to blacklist bus reset on this root port(?) if this is
> a systemic problem with the root port, which is not clearly proven
> here.  Thanks,

I can rework the patch and apply the quirk only to my tested devices but
I strongly believe that it is an issue on the root port, independent
from the device.

> 
> Alex
> 
> > After the reset, config accesses to the child may fail. If assigning
> > such device via VFIO it will immediately fail with:
> > 
> >   vfio-pci 0000:01:00.0: Failed to return from FLR
> >   vfio-pci 0000:01:00.0: timed out waiting for pending transaction;
> >   performing function level reset anyway
> > 
> > Device will disappear from PCI device list:
> > 
> >   !!! Unknown header type 7f
> >   Kernel driver in use: vfio-pci
> >   Kernel modules: ddbridge
> > 
> > The attached patch will mark the root port as incapable of doing a
> > bus level reset. After that all my tested devices survive a VFIO
> > assignment and several VM reboot cycles.
> > 
> > Signed-off-by: Maik Broemme <mbroemme@libmpq.org>
> > ---
> >  drivers/pci/quirks.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 0f16acc323c6..86cd42872708 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -3433,6 +3433,13 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0034, quirk_no_bus_reset);
> >   */
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CAVIUM, 0xa100, quirk_no_bus_reset);
> >  
> > +/*
> > + * Root port on some SuperMicro Atom C3xxx motherboards do not successfully
> > + * complete a bus reset when used with certain child devices. After the
> > + * reset, config accesses to the child may fail.
> > + */
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x19a4, quirk_no_bus_reset);
> > +
> >  static void quirk_no_pm_reset(struct pci_dev *dev)
> >  {
> >  	/*
> 

--Maik
