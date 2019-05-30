Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA5572EA5C
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2019 03:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfE3BtM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 May 2019 21:49:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54892 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbfE3BtM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 May 2019 21:49:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 05E6C3084212;
        Thu, 30 May 2019 01:49:12 +0000 (UTC)
Received: from x1.home (ovpn-116-22.phx2.redhat.com [10.3.116.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5636060BF0;
        Thu, 30 May 2019 01:49:09 +0000 (UTC)
Date:   Wed, 29 May 2019 19:49:08 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Maik Broemme <mbroemme@libmpq.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        vfio-users <vfio-users@redhat.com>
Subject: Re: [PATCH] PCI: Mark Intel bridge on SuperMicro Atom C3xxx
 motherboards to avoid bus reset
Message-ID: <20190529194908.1f8d24d3@x1.home>
In-Reply-To: <20190529220307.GD28250@google.com>
References: <20190524153118.GA12862@libmpq.org>
        <20190529220307.GD28250@google.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 30 May 2019 01:49:12 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 29 May 2019 17:03:07 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc Alex]
> 
> On Fri, May 24, 2019 at 05:31:18PM +0200, Maik Broemme wrote:
> > The Intel PCI bridge on SuperMicro Atom C3xxx motherboards do not
> > successfully complete a bus reset when used with certain child devices.
> > After the reset, config accesses to the child may fail. If assigning
> > such device via VFIO it will immediately fail with:
> > 
> >   vfio-pci 0000:01:00.0: Failed to return from FLR
> >   vfio-pci 0000:01:00.0: timed out waiting for pending transaction;
> >   performing function level reset anyway  
> 
> I guess these messages are from v4.13 or earlier, since the "Failed to
> return from FLR" text was removed by 821cdad5c46c ("PCI: Wait up to 60
> seconds for device to become ready after FLR"), which appeared in
> v4.14.
> 
> I suppose a current kernel would fail similarly, but could you try it?
> I think a current kernel would give more informative messages like:
> 
>   not ready XXms after FLR, giving up
>   not ready XXms after bus reset, giving up
> 
> I don't understand the connection here: the messages you quote are
> related to FLR, but the quirk isn't related to FLR.  The quirk
> prevents a secondary bus reset.  So is it the case that we try FLR
> first, it fails, then we try a secondary bus reset (does this succeed?
> you don't mention an error from it), and the device remains
> unresponsive and VFIO assignment fails?
> 
> And with the quirk, I assume we still try FLR, and it still fails.
> But we *don't* try a secondary bus reset, and the device magically
> works?  That's confusing to me.

As a counter point, I found a system with this root port in our test
environment.  It's not ideal as this root port has a PCIe-to-PCI bridge
downstream of it with a Matrox graphics downstream of that.  I can't
use vfio-pci to reset this hierarchy, but I can use setpci, ex:

# lspci -nnvs 00:09.0
00:09.0 PCI bridge [0604]: Intel Corporation Device [8086:19a4] (rev 11) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0, IRQ 26
	Memory at 1080000000 (64-bit, non-prefetchable) [size=128K]
	Bus: primary=00, secondary=03, subordinate=04, sec-latency=0
	I/O behind bridge: None
	Memory behind bridge: 84000000-848fffff [size=9M]
	Prefetchable memory behind bridge: 0000000082000000-0000000083ffffff [size=32M]
# lspci -nnvs 03:00.0
03:00.0 PCI bridge [0604]: Texas Instruments XIO2000(A)/XIO2200A PCI Express-to-PCI Bridge [104c:8231] (rev 03) (prog-if 00 [Normal decode])
	Flags: fast devsel
	Bus: primary=00, secondary=00, subordinate=00, sec-latency=0
	I/O behind bridge: 00000000-00000fff [size=4K]
	Memory behind bridge: 00000000-000fffff [size=1M]
	Prefetchable memory behind bridge: 0000000000000000-00000000000fffff [size=1M]

(resources are reset from previous experiments)

# setpci -s 00:09.0 3e.w=40:40
# lspci -nnvs 03:00.0
03:00.0 PCI bridge [0604]: Texas Instruments XIO2000(A)/XIO2200A PCI Express-to-PCI Bridge [104c:8231] (rev ff) (prog-if ff)
	!!! Unknown header type 7f

(bus in reset, config space unavailable, EXPECTED)

# setpci -s 00:09.0 3e.w=0:40
[root@intel-harrisonville-01 devices]# lspci -nnvs 03:00.0
03:00.0 PCI bridge [0604]: Texas Instruments XIO2000(A)/XIO2200A PCI Express-to-PCI Bridge [104c:8231] (rev 03) (prog-if 00 [Normal decode])
	Flags: fast devsel
	Bus: primary=00, secondary=00, subordinate=00, sec-latency=0
	I/O behind bridge: 00000000-00000fff [size=4K]
	Memory behind bridge: 00000000-000fffff [size=1M]
	Prefetchable memory behind bridge: 0000000000000000-00000000000fffff [size=1M]

(bus out of reset, downstream config space is available again)

I'm also confused about the description of this device:

On Fri, 24 May 2019 20:41:13 +0200 Maik Broemme <mbroemme@libmpq.org> wrote:
> Also I've tried a PCI-E switch from PLX technology, sold by MikroTik, the
> RouterBoard RB14eU. It is exports 4 Mini PCI ports in one PCI-E port and
> I tried it with one card and multiple cards.
> 
> All these devices start to work once I enabled the bus reset quirk. The
> RB14eU even allows to assign the individual Mini PCI-E ports to
> different VMs and survive independent resets behind the PLX bridge.

To me this describes a topology like:

[RP]---[US]-+-[DS]--[EP]
            +-[DS]--[EP]
            +-[DS]--[EP]
            \-[DS]--[EP]

(RootPort/UpstreamSwitch/DownstreamSwitch/EndPoint)

We can only assigned endpoints to VMs through vfio, therefore if we
need to reset the EP via a bus reset, that reset would occur at the
downstream switch point, not the root port.  It doesn't make sense that
a quirk at the RP would resolve anything about this use case.

Also, per the Intel datasheet, this is not the only root port in this
processor and presumably they'd all work the same way, so handling one
ID as a special case seems wrong regardless.  Thanks,

Alex

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
> > -- 
> > 2.21.0  

