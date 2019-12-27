Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E19FB12B3ED
	for <lists+linux-pci@lfdr.de>; Fri, 27 Dec 2019 11:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfL0Kgv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Dec 2019 05:36:51 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:49569 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfL0Kgv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Dec 2019 05:36:51 -0500
Received: from 79.184.255.87.ipv4.supernova.orange.pl (79.184.255.87) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id d2f5f766b7eab7f5; Fri, 27 Dec 2019 11:36:49 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, rafael.j.wysocki@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Report runtime wakeup is not supported if bridge isn't bound to driver
Date:   Fri, 27 Dec 2019 11:36:49 +0100
Message-ID: <1948783.ToaVGCCZch@kreacher>
In-Reply-To: <20191227092405.29588-1-kai.heng.feng@canonical.com>
References: <20191227092405.29588-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday, December 27, 2019 10:24:05 AM CET Kai-Heng Feng wrote:
> We have a Pericom USB add-on card that has three USB controller
> functions 06:00.[0-2], connected to bridge device 05:03.0, which is
> connected to another bridge device 04:00.0:
> 
> -[0000:00]-+-00.0
>            +-1c.6-[04-06]----00.0-[05-06]----03.0-[06]--+-00.0
>            |                                            +-00.1
>            |                                            \-00.2
> 
> When bridge device (05:03.0) and all three USB controller functions
> (06:00.[0-2]) are runtime suspended, they don't get woken up by plugging
> USB devices into the add-on card.
> 
> This is because the pcieport driver failed to probe on 04:00.0, since
> the device supports neither legacy IRQ, MSI nor MSI-X. Because of that,
> there's no native PCIe PME can work for devices connected to it.

But in that case the PME driver (drivers/pci/pcie/pme.c) should not bind
to the port in question, so the "can_wakeup" flag should not be set for
the devices under that port.

> So let's correctly report runtime wakeup isn't supported when any of
> PCIe bridges isn't bound to pcieport driver.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=205981
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/pci/pci.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 951099279192..ca686cfbd65e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2493,6 +2493,18 @@ bool pci_dev_run_wake(struct pci_dev *dev)
>  	if (!pci_pme_capable(dev, pci_target_state(dev, true)))
>  		return false;
>  
> +	/* If any upstream PCIe bridge isn't bound to pcieport driver, there's
> +	 * no IRQ for PME.
> +	 */
> +	if (pci_is_pcie(dev)) {
> +		while (bus->parent) {
> +			if (!bus->self->driver)
> +				return false;
> +
> +			bus = bus->parent;
> +		}
> +	}
> +

So it looks like device_can_wakeup() returns 'true' for this device, but it
should return 'false'.

Do you know why the "can_wakeup" flag is set for it?

>  	if (device_can_wakeup(&dev->dev))
>  		return true;
>  
> 

Moreover, even if the native PME is not supported, there can be an ACPI GPE (or
equivalent) that triggers when WAKE# is asserted by one of the PCIe devices
connected to it, so the test added by this patch cannot be used in general.



