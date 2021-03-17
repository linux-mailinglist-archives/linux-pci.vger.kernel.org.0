Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0ED33E919
	for <lists+linux-pci@lfdr.de>; Wed, 17 Mar 2021 06:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhCQFbZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Mar 2021 01:31:25 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:33683 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhCQFbV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Mar 2021 01:31:21 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 6BBA9100C059A;
        Wed, 17 Mar 2021 06:31:14 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 3AF1A10A3C; Wed, 17 Mar 2021 06:31:14 +0100 (CET)
Date:   Wed, 17 Mar 2021 06:31:14 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Keith Busch <kbusch@kernel.org>, knsathya@kernel.org,
        Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v2 1/1] PCI: pciehp: Skip DLLSC handling if DPC is
 triggered
Message-ID: <20210317053114.GA32370@wunner.de>
References: <59cb30f5e5ac6d65427ceaadf1012b2ba8dbf66c.1615606143.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210317041342.GA19198@wunner.de>
 <CAPcyv4jxTcUEgcfPRckHqrUPy8gR7ZJsxDaeU__pSq6PqJERAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jxTcUEgcfPRckHqrUPy8gR7ZJsxDaeU__pSq6PqJERAQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 16, 2021 at 10:08:31PM -0700, Dan Williams wrote:
> On Tue, Mar 16, 2021 at 9:14 PM Lukas Wunner <lukas@wunner.de> wrote:
> >
> > On Fri, Mar 12, 2021 at 07:32:08PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > +     if ((events == PCI_EXP_SLTSTA_DLLSC) && is_dpc_reset_active(pdev)) {
> > > +             ctrl_info(ctrl, "Slot(%s): DLLSC event(DPC), skipped\n",
> > > +                       slot_name(ctrl));
> > > +             ret = IRQ_HANDLED;
> > > +             goto out;
> > > +     }
> >
> > Two problems here:
> >
> > (1) If recovery fails, the link will *remain* down, so there'll be
> >     no Link Up event.  You've filtered the Link Down event, thus the
> >     slot will remain in ON_STATE even though the device in the slot is
> >     no longer accessible.  That's not good, the slot should be brought
> >     down in this case.
> 
> Can you elaborate on why that is "not good" from the end user
> perspective? From a driver perspective the device driver context is
> lost and the card needs servicing. The service event starts a new
> cycle of slot-attention being triggered and that syncs the slot-down
> state at that time.

All of pciehp's code assumes that if the link is down, the slot must be
off.  A slot which is in ON_STATE for a prolonged period of time even
though the link is down is an oddity the code doesn't account for.

If the link goes down, the slot should be brought into OFF_STATE.
(It's okay though to delay bringdown until DPC recovery has completed
unsuccessfully, which is what the patch I'm proposing does.)

I don't understand what you mean by "service event".  Someone unplugging
and replugging the NVMe drive?


> > (2) If recovery succeeds, there's a race where pciehp may call
> >     is_dpc_reset_active() *after* dpc_reset_link() has finished.
> >     So both the DPC Trigger Status bit as well as pdev->dpc_reset_active
> >     will be cleared.  Thus, the Link Up event is not filtered by pciehp
> >     and the slot is brought down and back up even though DPC recovery
> >     was succesful, which seems undesirable.
> 
> The hotplug driver never saw the Link Down, so what does it do when
> the slot transitions from Link Up to Link Up? Do you mean the Link
> Down might fire after the dpc recovery has completed if the hotplug
> notification was delayed?

If the Link Down is filtered and the Link Up is not, pciehp will
bring down the slot and then bring it back up.  That's because pciehp
can't really tell whether a DLLSC event is Link Up or Link Down.

It just knows that the link was previously up, is now up again,
but must have been down intermittently, so transactions to the
device in the slot may have been lost and the slot is therefore
brought down for safety.  Because the link is up, it is then
brought back up.

Thanks,

Lukas
