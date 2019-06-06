Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00FFE372AB
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2019 13:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfFFLV1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jun 2019 07:21:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:37376 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfFFLV1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Jun 2019 07:21:27 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2019 04:21:27 -0700
X-ExtLoop1: 1
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 06 Jun 2019 04:21:23 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 06 Jun 2019 14:21:23 +0300
Date:   Thu, 6 Jun 2019 14:21:23 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: Do not poll for PME if the device is in D3cold
Message-ID: <20190606112123.GX2781@lahna.fi.intel.com>
References: <20190605145820.37169-1-mika.westerberg@linux.intel.com>
 <20190605145820.37169-3-mika.westerberg@linux.intel.com>
 <20190605190557.mbklbuq4fgwbi3wp@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605190557.mbklbuq4fgwbi3wp@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 05, 2019 at 09:05:57PM +0200, Lukas Wunner wrote:
> On Wed, Jun 05, 2019 at 05:58:19PM +0300, Mika Westerberg wrote:
> > PME polling does not take into account that a device that is directly
> > connected to the host bridge may go into D3cold as well. This leads to a
> > situation where the PME poll thread reads from a config space of a
> > device that is in D3cold and gets incorrect information because the
> > config space is not accessible.
> > 
> > Here is an example from Intel Ice Lake system where two PCIe root ports
> > are in D3cold (I've instrumented the kernel to log the PMCSR register
> > contents):
> > 
> >   [   62.971442] pcieport 0000:00:07.1: Check PME status, PMCSR=0xffff
> >   [   62.971504] pcieport 0000:00:07.0: Check PME status, PMCSR=0xffff
> > 
> > Since 0xffff is interpreted so that PME is pending, the root ports will
> > be runtime resumed. This repeats over and over again essentially
> > blocking all runtime power management.
> > 
> > Prevent this from happening by checking whether the device is in D3cold
> > before its PME status is read.
> 
> There's more broken here.  The below patch fixes a PME polling race
> and should also fix the issue you're witnessing, could you verify that?

It fixes the issue but I needed to tune it a bit ->

> The patch has been rotting on my development branch for several months,
> I just didn't get around to posting it, my apologies.

Better late than never :)

> -- >8 --
> Subject: [PATCH] PCI / PM: Fix race on PME polling
> 
> Since commit df17e62e5bff ("PCI: Add support for polling PME state on
> suspended legacy PCI devices"), the work item pci_pme_list_scan() polls
> the PME status flag of devices and wakes them up if the bit is set.
> 
> The function performs a check whether a device's upstream bridge is in
> D0 for otherwise the device is inaccessible, rendering PME polling
> impossible.  However the check is racy because it is performed before
> polling the device.  If the upstream bridge runtime suspends to D3hot
> after pci_pme_list_scan() checks its power state and before it invokes
> pci_pme_wakeup(), the latter will read the PMCSR as "all ones" and
> mistake it for a set PME status flag.  I am seeing this race play out as
> a Thunderbolt controller going to D3cold and occasionally immediately
> going to D0 again because PM polling was performed at just the wrong
> time.
> 
> Avoid by checking for an "all ones" PMCSR in pci_check_pme_status().
> 
> Fixes: 58ff463396ad ("PCI PM: Add function for checking PME status of devices")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: stable@vger.kernel.org # v2.6.34+
> ---
>  drivers/pci/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b98a564..2e05348 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1753,6 +1753,8 @@ bool pci_check_pme_status(struct pci_dev *dev)
>  	pci_read_config_word(dev, pmcsr_pos, &pmcsr);
>  	if (!(pmcsr & PCI_PM_CTRL_PME_STATUS))
>  		return false;
> +	if (pmcsr == ~0)

<- Here I needed to do

	if (pmcsr == (u16)~0)

I think it is because pmcsr is u16 so we end up comparing:

	0xffff == 0xffffffff

> +		return false;
>  
>  	/* Clear PME status. */
>  	pmcsr |= PCI_PM_CTRL_PME_STATUS;
> -- 
> 2.20.1
