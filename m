Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76CA2C8F4A
	for <lists+linux-pci@lfdr.de>; Mon, 30 Nov 2020 21:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbgK3Ug7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Nov 2020 15:36:59 -0500
Received: from netrider.rowland.org ([192.131.102.5]:57811 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729290AbgK3Ug7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Nov 2020 15:36:59 -0500
Received: (qmail 977332 invoked by uid 1000); 30 Nov 2020 15:36:18 -0500
Date:   Mon, 30 Nov 2020 15:36:18 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Tom Yan <tom.ty89@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-usb <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        SCSI development list <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2/2] usb-storage: revert from scsi_add_host_with_dma() to
 scsi_add_host()
Message-ID: <20201130203618.GB975529@rowland.harvard.edu>
References: <20201128154849.3193-2-tom.ty89@gmail.com>
 <5e62c383-22ea-6df6-5acc-5e9f381d4632@redhat.com>
 <CAGnHSEnetAJNqUEW-iuq7eVyU6VnP84cv9+OVL4C5Z2ZK_eM0A@mail.gmail.com>
 <186eb035-4bc4-ff72-ee41-aeb6d81888e3@redhat.com>
 <X8T0E2qvF2cgADl+@kroah.com>
 <dd557c38-a919-5e5e-ab3b-17a235f17139@redhat.com>
 <20201130172004.GA966032@rowland.harvard.edu>
 <abb0a79d-63a0-6f3d-4812-f828283cd47c@redhat.com>
 <CAGnHSEk1GixNK71CJMymwLE=MyedjCkiG5Ubq1=O_wFxBBM0GQ@mail.gmail.com>
 <CAGnHSEmPpbDokAfGkeCkvo3JuYfnosVt8H+TK7ZWFNsdyWAfYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGnHSEmPpbDokAfGkeCkvo3JuYfnosVt8H+TK7ZWFNsdyWAfYQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[Added linux-scsi to CC: list.  When discussing code in a particular 
subsystem, it's a good idea to include that subsystem's mailing list in 
the CC:.]

On Tue, Dec 01, 2020 at 03:01:56AM +0800, Tom Yan wrote:
> For the record,
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/scsi/scsi_host.h?h=v5.10-rc6#n753
> 
> On Tue, 1 Dec 2020 at 02:57, Tom Yan <tom.ty89@gmail.com> wrote:
> >
> > This maybe? https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/scsi/scsi_lib.c?h=v5.10-rc6#n1816
> >
> > UAS:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/storage/uas.c?h=v5.10-rc6#n918
> > BOT (AFAICT):
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/scsi/hosts.c?h=v5.10-rc6#n466
> >
> > It would explain why the issue is only triggered with UAS drives.

In brief, a recent change -- calling scsi_add_host_with_dma rather than 
scsi_add_host -- in the USB uas driver has caused a regression in 
performance.  (Note that the shost->dma_dev value is set differently as 
a result of this change.)  Hans has determined that the problem seems 
to be related to permanent changes in the dma_dev's settings caused by 
scsi_add_host_with_dma.

Tom pointed out that __scsi_init_queue contains a couple of questionable 
assignments:

	dma_set_seg_boundary(dev, shost->dma_boundary);

and

	dma_set_max_seg_size(dev, queue_max_segment_size(q));

where dev = shost->dma_dev -- in this case, a USB host controller.

So an important question is why decisions related to a particular SCSI 
host should affect the DMA settings of a device somewhere else in the 
heirarchy?  Sure, the properties of the USB controller should constrain 
the settings available to the SCSI host, but there doesn't seem to be 
any good reason for restrictions to go in the other direction.

Doesn't the way we handle DMA permit a child device to impose additional 
restrictions (such as a smaller max segment size) beyond those of the 
parent device which actually performs the DMA transfer?

> > The questions (from me) are:
> > 1. From the scsi layer POV (as per what __scsi_init_queue() does),
> > what/which should we use as dma_dev?

We should be using the USB host controller, because it is the device 
which actually performs the DMA transfers.

> > 2. Do we really need to set dma_boundary in the UAS host template (to
> > PAGE_SIZE - 1)?

I don't know.  But in theory it should be possible to have settings 
(like this one) which affect only the transfers carried out by the SCSI 
host, not the transfers carred out by other drivers which might use the 
same USB controller.

> > 3. Kind of the same question as #1: when we clamp hw_max_sectors to
> > dma max mapping size, should the size actually be "the smaller one
> > among dev and sysdev"? Or is one of the two sizes *always* the smaller
> > one?

I assume you're referring to code in the uas driver.  There the value of 
dev is meaningless as far as DMA is concerned.  Only sysdev matters.

Alan Stern

> > On Tue, 1 Dec 2020 at 02:19, Hans de Goede <hdegoede@redhat.com> wrote:
> > >
> > > Hi,
> > >
> > > On 11/30/20 6:20 PM, Alan Stern wrote:
> > > > On Mon, Nov 30, 2020 at 02:36:38PM +0100, Hans de Goede wrote:
> > > >> Hi,
> > > >>
> > > >> On 11/30/20 2:30 PM, Greg KH wrote:
> > > >>> On Mon, Nov 30, 2020 at 02:23:48PM +0100, Hans de Goede wrote:
> > > >>>> Hi,
> > > >>>>
> > > >>>> On 11/30/20 1:58 PM, Tom Yan wrote:
> > > >>>>> It's merely a moving of comment moving for/and a no-behavioral-change
> > > >>>>> adaptation for the reversion.>
> > > >>>>
> > > >>>> IMHO the revert of the troublesome commit and the other/new changes really
> > > >>>> should be 2 separate commits. But I will let Alan and Greg have the final
> > > >>>> verdict on this.
> > > >>>
> > > >>> I would prefer to just revert the commits and not do anything
> > > >>> different/special here so late in the release cycle.
> > > >>>
> > > >>> So, if Alan agrees, I'll be glad to do them on my end, I just need the
> > > >>> commit ids for them.
> > > >>
> > > >> The troublesome commit are (in reverse, so revert, order):
> > > >>
> > > >> 5df7ef7d32fe ("uas: bump hw_max_sectors to 2048 blocks for SS or faster drives")
> > > >> 558033c2828f ("uas: fix sdev->host->dma_dev")
> > > >> 0154012f8018 ("usb-storage: fix sdev->host->dma_dev")
> > > >>
> > > >> Alan, the reason for reverting these is that using scsi_add_host_with_dma() as the
> > > >> last 2 patches do, with the dmadev argument of that call pointing to the device
> > > >> for the XHCI controller is causing changes to the DMA settings of the XHCI controller
> > > >> itself which is causing regressions in 5.10, see this email thread:
> > > >>
> > > >> https://lore.kernel.org/linux-usb/fde7e11f-5dfc-8348-c134-a21cb1116285@redhat.com/T/#t
> > > >
> > > > It's hard to go wrong with reverting, so it's okay with me.
> > > >
> > > > Still, Hans, have you checked out the difference between the
> > > > scsi_add_host() and scsi_add_host_with_dma() calls?  It's just a matter
> > > > of using dev vs. sysdev.  In particular, have you checked to see what
> > > > those two devices are on your system?
> > >
> > > Its not just dev vs sysdev, its iface->dev vs bus->sysdev, and I assume
> > > that the latter is actually the XHCI controller.
> > >
> > > my vote goes to reverting to avoid the regression for 5.10, esp. since
> > > this is a clean revert of 3 patches with nothing depending / building
> > > on top of the reverted commits.
> > >
> > > Then for 5.11 we can retry to introduce similar changes. I would be happy
> > > to try a new patch-set for 5.11.
> > >
> > > > It seems likely that if one of those calls messes up some DMA settings,
> > > > the other one does too -- just maybe not settings that matter much.
> > >
> > > I'm not very familiar with all the DMA mapping / mask code, but AFAIK making
> > > changes to the DMA settings of a child will not influence the parent.
> > >
> > > Where as when passing bus->sysdev, then changes are made to a device
> > > which is shared with other devices on the bus, which is why we see
> > > a regression in an USB NIC driver being triggered by the UAS driver
> > > binding to a device (on the same bus).
> > >
> > > At least that is my interpretation of this. I bisected the regression
> > > and that pointed at the UAS DMA change and reverting it fixes things,
> > > confirming that I did not make any mistakes during the bisect.
> > >
> > > Regards,
> > >
> > > Hans
> > >
