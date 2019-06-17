Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10FFD47FD4
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 12:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfFQKhJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 06:37:09 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:43167 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfFQKhJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2019 06:37:09 -0400
Received: from 79.184.254.20.ipv4.supernova.orange.pl (79.184.254.20) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 4bde88e79f44df54; Mon, 17 Jun 2019 12:37:06 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: Re: [PATCH] PCI/PME: Fix race on PME polling
Date:   Mon, 17 Jun 2019 12:37:06 +0200
Message-ID: <1957149.eOSnrBRbHu@kreacher>
In-Reply-To: <0113014581dbe2d1f938813f1783905bd81b79db.1560079442.git.lukas@wunner.de>
References: <0113014581dbe2d1f938813f1783905bd81b79db.1560079442.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sunday, June 9, 2019 1:29:33 PM CEST Lukas Wunner wrote:
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
> Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v2.6.34+
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/pci/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8abc843b1615..eed5db9f152f 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1989,6 +1989,8 @@ bool pci_check_pme_status(struct pci_dev *dev)
>  	pci_read_config_word(dev, pmcsr_pos, &pmcsr);
>  	if (!(pmcsr & PCI_PM_CTRL_PME_STATUS))
>  		return false;
> +	if (pmcsr == 0xffff)
> +		return false;
>  
>  	/* Clear PME status. */
>  	pmcsr |= PCI_PM_CTRL_PME_STATUS;
> 

Added to my 5.3 queue, thanks!



