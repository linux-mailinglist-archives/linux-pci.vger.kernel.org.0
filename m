Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 919B1FAF73
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2019 12:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfKMLPZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Nov 2019 06:15:25 -0500
Received: from mga12.intel.com ([192.55.52.136]:25180 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727495AbfKMLPZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Nov 2019 06:15:25 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2019 03:15:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,300,1569308400"; 
   d="scan'208";a="214299186"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 13 Nov 2019 03:15:20 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 13 Nov 2019 13:15:19 +0200
Date:   Wed, 13 Nov 2019 13:15:19 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] PCI: pciehp: Prevent deadlock on disconnect
Message-ID: <20191113111519.GI34425@lahna.fi.intel.com>
References: <20191029170022.57528-2-mika.westerberg@linux.intel.com>
 <20191113031752.GA227753@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113031752.GA227753@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 12, 2019 at 09:17:52PM -0600, Bjorn Helgaas wrote:
> On Tue, Oct 29, 2019 at 08:00:22PM +0300, Mika Westerberg wrote:
> > If there are more than one PCIe switch with hotplug downstream ports
> > hot-removing them leads to a following deadlock:
> 
> Does this happen if two sibling switches are removed simultaneously,
> or does this happen when switch A leads to switch B and you remove
> switch A (with obviously also removes switch B)?  I'm guessing the
> latter because it would be easier to reproduce.  And I guess that's
> obvious from the text below.

Yes, that's right.

> >  INFO: task irq/126-pciehp:198 blocked for more than 120 seconds.
> >  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >  irq/126-pciehp  D    0   198      2 0x80000000
> >  Call Trace:
> >   __schedule+0x2a2/0x880
> >   schedule+0x2c/0x80
> >   schedule_timeout+0x246/0x350
> >   ? ttwu_do_activate+0x67/0x90
> >   wait_for_completion+0xb7/0x140
> >   ? wake_up_q+0x80/0x80
> >   kthread_stop+0x49/0x110
> >   __free_irq+0x15c/0x2a0
> >   free_irq+0x32/0x70
> >   pcie_shutdown_notification+0x2f/0x50
> >   pciehp_remove+0x27/0x50
> >   pcie_port_remove_service+0x36/0x50
> >   device_release_driver_internal+0x18c/0x250
> >   device_release_driver+0x12/0x20
> >   bus_remove_device+0xec/0x160
> >   device_del+0x13b/0x350
> >   ? pcie_port_find_device+0x60/0x60
> >   device_unregister+0x1a/0x60
> >   remove_iter+0x1e/0x30
> >   device_for_each_child+0x56/0x90
> >   pcie_port_device_remove+0x22/0x40
> >   pcie_portdrv_remove+0x20/0x60
> >   pci_device_remove+0x3e/0xc0
> >   device_release_driver_internal+0x18c/0x250
> >   device_release_driver+0x12/0x20
> >   pci_stop_bus_device+0x6f/0x90
> >   pci_stop_bus_device+0x31/0x90
> >   pci_stop_and_remove_bus_device+0x12/0x20
> >   pciehp_unconfigure_device+0x88/0x140
> >   pciehp_disable_slot+0x6a/0x110
> >   pciehp_handle_presence_or_link_change+0x263/0x400
> >   pciehp_ist+0x1c9/0x1d0
> >   ? irq_forced_thread_fn+0x80/0x80
> >   irq_thread_fn+0x24/0x60
> >   irq_thread+0xeb/0x190
> >   ? irq_thread_fn+0x60/0x60
> >   kthread+0x120/0x140
> >   ? irq_thread_check_affinity+0xf0/0xf0
> >   ? kthread_park+0x90/0x90
> >   ret_from_fork+0x35/0x40
> >  INFO: task irq/190-pciehp:2288 blocked for more than 120 seconds.
> >  irq/190-pciehp  D    0  2288      2 0x80000000
> >  Call Trace:
> >   __schedule+0x2a2/0x880
> >   schedule+0x2c/0x80
> >   schedule_preempt_disabled+0xe/0x10
> >   __mutex_lock.isra.9+0x2e0/0x4d0
> >   ? __mutex_lock_slowpath+0x13/0x20
> >   __mutex_lock_slowpath+0x13/0x20
> >   mutex_lock+0x2c/0x30
> >   pci_lock_rescan_remove+0x15/0x20
> >   pciehp_unconfigure_device+0x4d/0x140
> >   pciehp_disable_slot+0x6a/0x110
> >   pciehp_handle_presence_or_link_change+0x263/0x400
> >   pciehp_ist+0x1c9/0x1d0
> >   ? irq_forced_thread_fn+0x80/0x80
> >   irq_thread_fn+0x24/0x60
> >   irq_thread+0xeb/0x190
> >   ? irq_thread_fn+0x60/0x60
> >   kthread+0x120/0x140
> >   ? irq_thread_check_affinity+0xf0/0xf0
> >   ? kthread_park+0x90/0x90
> >   ret_from_fork+0x35/0x40
> > 
> > What happens here is that the whole hierarchy is runtime resumed and the
> 
> What is the runtime resume connection here?  I do see that
> pcie_portdrv_remove() may call pm_runtime_forbid(), which looks like
> it resumes devices, but I don't see whether that's actually relevant
> to the deadlock.

When the parent port removes its children the driver core 
(__device_release_driver) calls pm_runtime_get_sync() for the device
which ends up calling the resume hook of the child pciehp.

> > parent PCIe downstream port, who got the hot-remove event, starts
> > removing devices below it taking pci_lock_rescan_remove() lock. When the
> > child PCIe port is runtime resumed it calls pciehp_check_presence()
> > which ends up calling pciehp_card_present() and pciehp_check_link_active().
> 
> Oh, I see, pciehp_resume() calls pciehp_check_presence(), which
> schedules the IRQ thread via pciehp_request().  So does this deadlock
> only happen if the port(s) have been runtime suspended?

I'm aware of two cases where this happens with a real hardware.

First one is that all involved ports are runtime suspended and you
unplug them. This can happen easily if the drivers involved
automatically enable runtime PM (xHCI for example does that).

The other more common case is that you suspend your laptop (close the
lid with the dock + something else connected. Then you unplug the dock
and after some time open the lid. Basically system suspend/resume cycle
so that you unplug the devices when it is suspended.

This patch helps for both cases above.

As Lukas commented there is also a bit more syntetic case where the
removal is done through sysfs in paraller to hot-removing the device. I
believe this one is still unfixed.

> > Both of these read their parts of PCIe config space by calling helper
> > function pcie_capability_read_word(). Now, this function notices that
> > the underlying device is already gone and returns PCIBIOS_DEVICE_NOT_FOUND
> > with the capability value set to 0.  When pciehp gets this value it
> > thinks that its child device is also hot-removed and schedules its IRQ
> > thread to handle the event.
> 
> The child device actually *has* been hot-removed, right? :)

Yes.

> In addition to checking for PCIBIOS_DEVICE_NOT_FOUND, you added checks
> for ~0:
> 
> > +	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
> > +	if (ret == PCIBIOS_DEVICE_NOT_FOUND || lnk_status == (u16)~0)
> > +		return -ENODEV;
> 
> That makes sense to me and I think it's the right thing to do.

So do I :)

> But I do wonder whether pcie_capability_read_word() is doing the wrong
> thing when it sets "*val = 0" in the error case.  I suspect that just
> complicates the callers for no good reason.  The callers could
> otherwise simply check for ~0 as a "this may be an error response"
> value.

I agree.

We discussed about that in v2 and you said that you would like to
explore removal of "*val = 0" but not in the context of this issue [1].

[1] https://patchwork.kernel.org/patch/11089973/#22961207
