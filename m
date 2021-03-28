Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFFD34BBC1
	for <lists+linux-pci@lfdr.de>; Sun, 28 Mar 2021 11:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhC1JHf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Mar 2021 05:07:35 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:38107 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbhC1JHK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Mar 2021 05:07:10 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 6DB092800B3E0;
        Sun, 28 Mar 2021 11:07:08 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 59BBE8178; Sun, 28 Mar 2021 11:07:08 +0200 (CEST)
Date:   Sun, 28 Mar 2021 11:07:08 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        dan.j.williams@intel.com, kbusch@kernel.org, knsathya@kernel.org,
        Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v2 1/1] PCI: pciehp: Skip DLLSC handling if DPC is
 triggered
Message-ID: <20210328090708.GA20590@wunner.de>
References: <59cb30f5e5ac6d65427ceaadf1012b2ba8dbf66c.1615606143.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210317041342.GA19198@wunner.de>
 <b2e456bf-9e01-a8cc-67b3-2c10fcda3949@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2e456bf-9e01-a8cc-67b3-2c10fcda3949@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 27, 2021 at 10:49:45PM -0700, Kuppuswamy, Sathyanarayanan wrote:
> On 3/16/21 9:13 PM, Lukas Wunner wrote:
> > --- a/drivers/pci/hotplug/pciehp_hpc.c
> > +++ b/drivers/pci/hotplug/pciehp_hpc.c
> > @@ -707,6 +707,17 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
> >   	}
> >   	/*
> > +	 * Ignore Link Down/Up caused by Downstream Port Containment
> > +	 * if recovery from the error succeeded.
> > +	 */
> > +	if ((events & PCI_EXP_SLTSTA_DLLSC) && pci_dpc_recovered(pdev) &&
> > +	    ctrl->state == ON_STATE) {
> > +		atomic_and(~PCI_EXP_SLTSTA_DLLSC, &ctrl->pending_events);
> 
> Why modify pending_events here. It should be already be zero right?

"pending_events" is expected to contain the Link Up event
after successful recovery, whereas "events" contains the
Link Down event (if DPC was triggered).

pciehp is structured around the generic irq core's separation
of hardirq handler (runs in interrupt context) and irq thread
(runs in task context).  The hardirq handler pciehp_isr() picks
up events from the Slot Status register and stores them in
"pending_events" for later consumption by the irq thread
pciehp_ist().  The irq thread performs long running tasks such
as slot bringup and bringdown.  The irq thread is also allowed
to sleep.

While pciehp_ist() awaits completion of DPC recovery, a DLLSC
event will be picked up by pciehp_isr() which is caused by
link retraining.  That event is contained in "pending_events",
so after successful recovery, pciehp_ist() can just delete it.

Thanks,

Lukas
