Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653BA40B202
	for <lists+linux-pci@lfdr.de>; Tue, 14 Sep 2021 16:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbhINOuj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Sep 2021 10:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236207AbhINOtx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Sep 2021 10:49:53 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C15C0613E9
        for <linux-pci@vger.kernel.org>; Tue, 14 Sep 2021 07:46:23 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id A1F2830000085;
        Tue, 14 Sep 2021 16:46:21 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 9436D115A59; Tue, 14 Sep 2021 16:46:21 +0200 (CEST)
Date:   Tue, 14 Sep 2021 16:46:21 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     Jon Derrick <jonathan.derrick@linux.dev>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        James Puthukattukaran <james.puthukattukaran@oracle.com>
Subject: Re: [PATCH v3] PCI: pciehp: Add quirk to handle spurious DLLSC on a
 x4x4 SSD
Message-ID: <20210914144621.GA30031@wunner.de>
References: <20210830155628.130054-1-jonathan.derrick@linux.dev>
 <20210912084547.GA26678@wunner.de>
 <91950e7a-68e9-9d35-ff0b-a2109de7a853@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91950e7a-68e9-9d35-ff0b-a2109de7a853@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 13, 2021 at 04:07:22PM -0500, Jon Derrick wrote:
> On 9/12/21 3:45 AM, Lukas Wunner wrote:
> > On Mon, Aug 30, 2021 at 09:56:28AM -0600, Jon Derrick wrote:
> > > When an Intel P5608 SSD is bifurcated into x4x4 mode, and the upstream
> > > ports both support hotplugging on each respective x4 device, a slot
> > > management system for the SSD requires both x4 slots to have power
> > > removed via sysfs (echo 0 > slot/N/power), from the OS before it can
> > > safely turn-off physical power for the whole x8 device. The implications
> > > are that slot status will display powered off and link inactive statuses
> > > for the x4 devices where the devices are actually powered until both
> > > ports have powered off.
> > 
> > Just to get a better understanding, does the P5608 have an internal
> > PCIe switch with hotplug capability on the Downstream Ports or
> > does it plug into two separate PCIe slots?  I recall previous patches
> > mentioned a CEM interposer?  (An lspci listing might be helpful.)
> 
> It looks like 2 NVMe endpoints plugged into two different root ports, ex,
> 80:00.0 Root port to [81-86]
> 80:01.0 Root port to [87-8b]
> 81:00.0 NVMe
> 87:00.0 NVMe
> 
> The x8 is bifurcated to x4x4. Physically they share the same slot
> power/clock/reset but are logically separate per root port.

So are these two P5608 drives attached to a single Root Port with an
interposer in-between?

I assume the Root Port needs to know that it's bifurcated and has to
appear as two slots on the bus.  Is this configured with a BIOS setting?

If these assumptions are true, the quirk isn't really specific to
the P5608 but should rather apply to the bifurcation-capable Root Port
and the quirk should set the flag if the Root Port is indeed configured
for bifurcation.


> > > @@ -265,6 +266,12 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
> > >  		cancel_delayed_work(&ctrl->button_work);
> > >  		fallthrough;
> > >  	case OFF_STATE:
> > > +		if (pdev->shared_pcc_and_link_slot &&
> > > +		    (events & PCI_EXP_SLTSTA_DLLSC) && !link_active) {
> > > +			mutex_unlock(&ctrl->state_lock);
> > > +			break;
> > > +		}
> > > +
> > 
> > I think you also need to add...
> > 
> > 			pdev->shared_pcc_and_link_slot = false;
> > 
> > ... here to reset the shared_pcc_and_link_slot attribute in case the
> > next card plugged into the slot doesn't have the quirk.
> > 
> > (This can't be done in pciehp_unconfigure_device() because the attribute
> > is queried *after* the slot has been brought down.)
> 
> Agreed. I'll find a good spot for it.

Adding it in the if-clause above should work.  The if-clause is only
entered when the sibling card has had its power removed, and this
only happens once.  When power is reinstated via sysfs, the device
in the slot is reenumerated and pdev->shared_pcc_and_link_slot is
set to true again if there's a quirked device in the slot.

Thanks,

Lukas
