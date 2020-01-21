Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36F32143BBD
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2020 12:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbgAULKj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jan 2020 06:10:39 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50917 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgAULKi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jan 2020 06:10:38 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1itrQE-0002Xf-PZ; Tue, 21 Jan 2020 12:10:14 +0100
Message-ID: <8409fd7ad6b83da75c914a71accf522953a460a0.camel@pengutronix.de>
Subject: Re: Issues with "PCI/LINK: Report degraded links via link bandwidth
 notification"
From:   Lucas Stach <l.stach@pengutronix.de>
To:     "Alex G." <mr.nuke.me@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Alexandru Gagniuc <alex_gagniuc@dellteam.com>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Jan Vesely <jano.vesely@gmail.com>, Lukas Wunner <lukas@wunner.de>,
        Alex Williamson <alex.williamson@redhat.com>,
        Austin Bolen <austin_bolen@dell.com>,
        Shyam Iyer <Shyam_Iyer@dell.com>,
        Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 21 Jan 2020 12:10:08 +0100
In-Reply-To: <b9764896-102c-84cb-32ea-c2a122b6f0db@gmail.com>
References: <20200120023326.GA149019@google.com>
         <b9764896-102c-84cb-32ea-c2a122b6f0db@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mo, 2020-01-20 at 10:01 -0600, Alex G. wrote:
> 
> On 1/19/20 8:33 PM, Bjorn Helgaas wrote:
> > [+cc NVMe, GPU driver folks]
> > 
> > On Wed, Jan 15, 2020 at 04:10:08PM -0600, Bjorn Helgaas wrote:
> > > I think we have a problem with link bandwidth change notifications
> > > (see https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pcie/bw_notification.c).
> > > 
> > > Here's a recent bug report where Jan reported "_tons_" of these
> > > notifications on an nvme device:
> > > https://bugzilla.kernel.org/show_bug.cgi?id=206197
> > > 
> > > There was similar discussion involving GPU drivers at
> > > https://lore.kernel.org/r/20190429185611.121751-2-helgaas@kernel.org
> > > 
> > > The current solution is the CONFIG_PCIE_BW config option, which
> > > disables the messages completely.  That option defaults to "off" (no
> > > messages), but even so, I think it's a little problematic.
> > > 
> > > Users are not really in a position to figure out whether it's safe to
> > > enable.  All they can do is experiment and see whether it works with
> > > their current mix of devices and drivers.
> > > 
> > > I don't think it's currently useful for distros because it's a
> > > compile-time switch, and distros cannot predict what system configs
> > > will be used, so I don't think they can enable it.
> > > 
> > > Does anybody have proposals for making it smarter about distinguishing
> > > real problems from intentional power management, or maybe interfaces
> > > drivers could use to tell us when we should ignore bandwidth changes?
> > 
> > NVMe, GPU folks, do your drivers or devices change PCIe link
> > speed/width for power saving or other reasons?  When CONFIG_PCIE_BW=y,
> > the PCI core interprets changes like that as problems that need to be
> > reported.
> > 
> > If drivers do change link speed/width, can you point me to where
> > that's done?  Would it be feasible to add some sort of PCI core
> > interface so the driver could say "ignore" or "pay attention to"
> > subsequent link changes?
> > 
> > Or maybe there would even be a way to move the link change itself into
> > the PCI core, so the core would be aware of what's going on?
> 
> Funny thing is, I was going to suggest an in-kernel API for this.
>    * Driver requests lower link speed 'X'
>    * Link management interrupt fires
>    * If link speed is at or above 'X' then do not report it.
> I think an "ignore" flag would defeat the purpose of having link 
> bandwidth reporting in the first place. If some drivers set it, and 
> others don't, then it would be inconsistent enough to not be useful.
> 
> A second suggestion is, if there is a way to ratelimit these messages on 
> a per-downstream port basis.

Both AMD and Nvidia GPUs have embedded controllers, which are
responsible for the power management. IIRC those controllers can
autonomously initiate PCIe link speed changes depending on measured bus
load. So there is no way for the driver to signal the requested bus
speed to the PCIe core.

I guess for the GPU usecase the best we can do is to have the driver
opt-out of the link bandwidth notifications, as the driver knows that
there is some autonomous entity on the endpoint mucking with the link
parameters.

Regards,
Lucas

