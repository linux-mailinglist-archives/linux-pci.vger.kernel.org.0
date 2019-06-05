Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6BE2363B9
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2019 21:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfFETGB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jun 2019 15:06:01 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:40609 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbfFETGA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jun 2019 15:06:00 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id B11E23000BA08;
        Wed,  5 Jun 2019 21:05:57 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 7B9E64B204; Wed,  5 Jun 2019 21:05:57 +0200 (CEST)
Date:   Wed, 5 Jun 2019 21:05:57 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: Do not poll for PME if the device is in D3cold
Message-ID: <20190605190557.mbklbuq4fgwbi3wp@wunner.de>
References: <20190605145820.37169-1-mika.westerberg@linux.intel.com>
 <20190605145820.37169-3-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605145820.37169-3-mika.westerberg@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 05, 2019 at 05:58:19PM +0300, Mika Westerberg wrote:
> PME polling does not take into account that a device that is directly
> connected to the host bridge may go into D3cold as well. This leads to a
> situation where the PME poll thread reads from a config space of a
> device that is in D3cold and gets incorrect information because the
> config space is not accessible.
> 
> Here is an example from Intel Ice Lake system where two PCIe root ports
> are in D3cold (I've instrumented the kernel to log the PMCSR register
> contents):
> 
>   [   62.971442] pcieport 0000:00:07.1: Check PME status, PMCSR=0xffff
>   [   62.971504] pcieport 0000:00:07.0: Check PME status, PMCSR=0xffff
> 
> Since 0xffff is interpreted so that PME is pending, the root ports will
> be runtime resumed. This repeats over and over again essentially
> blocking all runtime power management.
> 
> Prevent this from happening by checking whether the device is in D3cold
> before its PME status is read.

There's more broken here.  The below patch fixes a PME polling race
and should also fix the issue you're witnessing, could you verify that?

The patch has been rotting on my development branch for several months,
I just didn't get around to posting it, my apologies.

-- >8 --
Subject: [PATCH] PCI / PM: Fix race on PME polling

Since commit df17e62e5bff ("PCI: Add support for polling PME state on
suspended legacy PCI devices"), the work item pci_pme_list_scan() polls
the PME status flag of devices and wakes them up if the bit is set.

The function performs a check whether a device's upstream bridge is in
D0 for otherwise the device is inaccessible, rendering PME polling
impossible.  However the check is racy because it is performed before
polling the device.  If the upstream bridge runtime suspends to D3hot
after pci_pme_list_scan() checks its power state and before it invokes
pci_pme_wakeup(), the latter will read the PMCSR as "all ones" and
mistake it for a set PME status flag.  I am seeing this race play out as
a Thunderbolt controller going to D3cold and occasionally immediately
going to D0 again because PM polling was performed at just the wrong
time.

Avoid by checking for an "all ones" PMCSR in pci_check_pme_status().

Fixes: 58ff463396ad ("PCI PM: Add function for checking PME status of devices")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: stable@vger.kernel.org # v2.6.34+
---
 drivers/pci/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b98a564..2e05348 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1753,6 +1753,8 @@ bool pci_check_pme_status(struct pci_dev *dev)
 	pci_read_config_word(dev, pmcsr_pos, &pmcsr);
 	if (!(pmcsr & PCI_PM_CTRL_PME_STATUS))
 		return false;
+	if (pmcsr == ~0)
+		return false;
 
 	/* Clear PME status. */
 	pmcsr |= PCI_PM_CTRL_PME_STATUS;
-- 
2.20.1

