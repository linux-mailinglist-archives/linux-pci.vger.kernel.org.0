Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4ABAEE637
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2019 18:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbfKDRjJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Nov 2019 12:39:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:56698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728957AbfKDRjI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Nov 2019 12:39:08 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9568020869;
        Mon,  4 Nov 2019 17:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572889147;
        bh=N4a9nPp4BuN3cqKQ7aWdLaMqDg3klueBElHrgvRDDjg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hT/qMgZX9xf4YyQ6Rlbs2MST38ZPkJB2iZMa0FvXDzbA42X5MPM3U8wUV2w6swWei
         9ENMlOat8xISKb+TIXo/O1OLLBBbNtqR4Jyz2O47YtK2cbZ/c+J/fB/q++2A4KRcy0
         AZ38vnSlErlvBT7rDEdEg7GIecrE9gHHGEZowe9I=
Date:   Mon, 4 Nov 2019 11:39:04 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Sinan Kaya <okaya@kernel.org>, Thierry Reding <treding@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andrew Murray <andrew.murray@arm.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] PCI: Add CRS timeout for pci_device_is_present()
Message-ID: <20191104173904.GA122794@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85267afb-c08e-5625-d3ee-bd32af9ecb12@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Andrew, Lukas]

On Tue, Oct 15, 2019 at 05:44:47PM +0530, Vidya Sagar wrote:
> On 10/15/2019 4:40 PM, Sinan Kaya wrote:
> > ...
> > I think the PCI core should be putting the device back D0 state as one
> > of the first actions before enumerating. Wake up could be a combination
> > of ACPI and/or PCI wake up depending on where your device sits in the
> > topology.
>
> Yup. It is indeed doing it as part of pci_power_up() in pci.c file.
> But, what is confusing to me is the order of the calls.
> pci_power_up() has following calls in the same order.
> 	pci_raw_set_power_state(dev, PCI_D0);
> 	pci_update_current_state(dev, PCI_D0);
> But, pci_raw_set_power_state() is accessing config space without calling
> pci_device_is_present() whereas pci_update_current_state() which is called
> later in the flow is calling pci_device_is_present()...!

A device should always respond to config reads unless it is in D3cold
or it is initializing after a reset.  IIUC you're doing a resume, not
a reset, so I think your device must be coming out of D3cold.  That's
typically done via ACPI, and I think we are missing some kind of delay
before our first config access:

  pci_power_up
    platform_pci_set_power_state(PCI_D0)    # eg, ACPI
    pci_raw_set_power_state
      pci_read_config_word(PCI_PM_CTRL)     # <-- first config access
      pci_write_config_word(PCI_PM_CTRL)
      pci_read_config_word(PCI_PM_CTRL)
    pci_update_current_state
      if (... || !pci_device_is_present())

Mika is working on some delays for the transition out of D3cold [1].
He's more concerned with a secondary bus behind a bridge, so I don't
think his patch addresses this case, but he's certainly familiar with
this area.

Huh, I'm really confused about this, too.  I don't
understand how resume ever works without any delay between
platform_pci_power_manageable() and the config reads in
pci_raw_set_power_state().  I must be missing something.

The pci_device_is_present() call in pci_update_current_state() was
added by a6a64026c0cd ("PCI: Recognize D3cold in
pci_update_current_state()") [2].  The purpose there is not to wait
for a device to become ready; it is to learn whether the device is in
D3cold.  I don't think we'd want a delay in this path because it would
slow down all transitions into D3cold.

[1] https://lore.kernel.org/r/20191004123947.11087-1-mika.westerberg@linux.intel.com
[2] https://git.kernel.org/linus/a6a64026c0cd

> > On the other hand, wake up code doesn't perform the CRS wait. CRS
> > wait is deferred until the first vendor id read in pci_scan_device().
> > I see that it already waits for 60 seconds.
> > 
> > Going back to the patch...
> > 
> > I think we need to find the path that actually needs this sleep and
> > put pci_dev_wait() there.
>
> Following is the path in resume() flow.
> [   36.380726] Call trace:
> [   36.383270]  dump_backtrace+0x0/0x158
> [   36.386802]  show_stack+0x14/0x20
> [   36.389749]  dump_stack+0xb0/0xf8
> [   36.393451]  pci_update_current_state+0x58/0xe0
> [   36.398178]  pci_power_up+0x60/0x70
> [   36.401672]  pci_pm_resume_noirq+0x6c/0x130
> [   36.405669]  dpm_run_callback.isra.16+0x20/0x70
> [   36.410248]  device_resume_noirq+0x120/0x238
> [   36.414364]  async_resume_noirq+0x24/0x58
> [   36.418364]  async_run_entry_fn+0x40/0x148
> [   36.422418]  process_one_work+0x1e8/0x360
> [   36.426525]  worker_thread+0x40/0x488
> [   36.430201]  kthread+0x118/0x120
> [   36.433843]  ret_from_fork+0x10/0x1c
> 
> > 
> > +++ b/drivers/pci/pci.c
> > @@ -5905,7 +5905,8 @@ bool pci_device_is_present(struct pci_dev *pdev)
> > 
> >   	if (pci_dev_is_disconnected(pdev))
> >   		return false;
> > -	return pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v, 0);
> > +	return pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v,
> > +					  PCI_CRS_TIMEOUT);
> >   }
> > 
> > pci_device_is_present() is a too low-level function and it may not
> > be allowed to sleep. It uses 0 as timeout value.
> > 
> > 
> 
