Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D30A712CB2C
	for <lists+linux-pci@lfdr.de>; Sun, 29 Dec 2019 23:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfL2Wh6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 29 Dec 2019 17:37:58 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:62237 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfL2Wh6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 29 Dec 2019 17:37:58 -0500
Received: from 79.184.253.116.ipv4.supernova.orange.pl (79.184.253.116) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id fd89ba99d30803d6; Sun, 29 Dec 2019 23:37:55 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, rafael.j.wysocki@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Report runtime wakeup is not supported if bridge isn't bound to driver
Date:   Sun, 29 Dec 2019 23:37:55 +0100
Message-ID: <4466650.2HG2iOLVKt@kreacher>
In-Reply-To: <C9708CF1-9F01-47BF-A568-53A01725AF95@canonical.com>
References: <20191227092405.29588-1-kai.heng.feng@canonical.com> <1948783.ToaVGCCZch@kreacher> <C9708CF1-9F01-47BF-A568-53A01725AF95@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday, December 27, 2019 6:15:26 PM CET Kai-Heng Feng wrote:
> 
> > On Dec 27, 2019, at 18:36, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > 
> > On Friday, December 27, 2019 10:24:05 AM CET Kai-Heng Feng wrote:
> >> We have a Pericom USB add-on card that has three USB controller
> >> functions 06:00.[0-2], connected to bridge device 05:03.0, which is
> >> connected to another bridge device 04:00.0:
> >> 
> >> -[0000:00]-+-00.0
> >>           +-1c.6-[04-06]----00.0-[05-06]----03.0-[06]--+-00.0
> >>           |                                            +-00.1
> >>           |                                            \-00.2
> >> 
> >> When bridge device (05:03.0) and all three USB controller functions
> >> (06:00.[0-2]) are runtime suspended, they don't get woken up by plugging
> >> USB devices into the add-on card.
> >> 
> >> This is because the pcieport driver failed to probe on 04:00.0, since
> >> the device supports neither legacy IRQ, MSI nor MSI-X. Because of that,
> >> there's no native PCIe PME can work for devices connected to it.
> > 
> > But in that case the PME driver (drivers/pci/pcie/pme.c) should not bind
> > to the port in question, so the "can_wakeup" flag should not be set for
> > the devices under that port.
> 
> We can remove the can_wakeup flag for all its child devices once pcieport probe fails, but I think it's not intuitive.
> 
> > 
> >> So let's correctly report runtime wakeup isn't supported when any of
> >> PCIe bridges isn't bound to pcieport driver.
> >> 
> >> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=205981
> >> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >> ---
> >> drivers/pci/pci.c | 12 ++++++++++++
> >> 1 file changed, 12 insertions(+)
> >> 
> >> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >> index 951099279192..ca686cfbd65e 100644
> >> --- a/drivers/pci/pci.c
> >> +++ b/drivers/pci/pci.c
> >> @@ -2493,6 +2493,18 @@ bool pci_dev_run_wake(struct pci_dev *dev)
> >> 	if (!pci_pme_capable(dev, pci_target_state(dev, true)))
> >> 		return false;
> >> 
> >> +	/* If any upstream PCIe bridge isn't bound to pcieport driver, there's
> >> +	 * no IRQ for PME.
> >> +	 */
> >> +	if (pci_is_pcie(dev)) {
> >> +		while (bus->parent) {
> >> +			if (!bus->self->driver)
> >> +				return false;
> >> +
> >> +			bus = bus->parent;
> >> +		}
> >> +	}
> >> +
> > 
> > So it looks like device_can_wakeup() returns 'true' for this device, but it
> > should return 'false'.
> 
> The USB controllers can assert PME#, so it actually can wakeup, in a way.

Well, that's questionable.

If there is no known way for the PME to be signaled, we may as well mark the
device as wakeup-incapable.

> I think the logical distinction between pci_dev_run_wake() and device_can_wakeup() is that,
> pci_dev_run_wake() means it can actually do runtime wakeup, while device_can_wakeup()
> only means it has the capability to wakeup. Am I correct here?

Kind of, but the "capability" part is not well defined, so to speak, because
if the device happens to be located below a PCIe port in a low-power state
(say D3hot), the PME "support" declared in the config space is clearly
insufficient.

> > 
> > Do you know why the "can_wakeup" flag is set for it?
> 
> All PCI devices with PME cap calls device_set_wakeup_capable() in pci_pm_init().

Right, I forgot about that thing.

It is inconsistent with the rest of the code, particularly with
pci_dev_run_wake(), so I'd try to drop it.

IIRC that would require some other pieces of code to be reworked to avoid
regressions, though.

> > 
> >> 	if (device_can_wakeup(&dev->dev))
> >> 		return true;
> >> 
> >> 
> > 
> > Moreover, even if the native PME is not supported, there can be an ACPI GPE (or
> > equivalent) that triggers when WAKE# is asserted by one of the PCIe devices
> > connected to it, so the test added by this patch cannot be used in general.
> 
> Ok. So how to know when both native PME isn't supported and it doesn't use ACPI GPE?

If the PME driver doesn't bind to the device's root port, the native PME cannot
work.

If there is no wakeup GPE, pci_acpi_setup() will not call
device_set_wakeup_capable() for the device.

> I thought ACPI GPE only works for devices directly connect to Root Complex, but I can't find the reference now.

No, that's not the case.

It can work for any devices (even old-style PCI, non-PCIe) with PME# connected
to a dedicated WAKE# pin on the board (which then is represented as an ACPI GPE
or a GPIO IRQ).

> 
> Another short-term workaround is to make pci_pme_list_scan() not skip bridge when it's in D3hot:

No, that would not be safe in general.

Basically, pci_finish_runtime_suspend() needs to enable wakeup for devices
that can do PME even though can_wakeup is not set for them, as long as
pci_pme_list_scan() can reach them.  That should be sufficient to cover
all of the practically relevant cases.



