Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A77739099A
	for <lists+linux-pci@lfdr.de>; Tue, 25 May 2021 21:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbhEYT0s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 May 2021 15:26:48 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:58039 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbhEYT0s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 May 2021 15:26:48 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 38B2E2800B4A4;
        Tue, 25 May 2021 21:25:12 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 2C3DAF705; Tue, 25 May 2021 21:25:12 +0200 (CEST)
Date:   Tue, 25 May 2021 21:25:12 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jon Derrick <jonathan.derrick@intel.com>,
        linux-pci@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
Subject: Re: [PATCH] PCI: pciehp: Ignore spurious link inactive change when
 off
Message-ID: <20210525192512.GA3450@wunner.de>
References: <20210409205935.41881-1-jonathan.derrick@intel.com>
 <20210524224218.GA1135242@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524224218.GA1135242@bjorn-Precision-5520>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 24, 2021 at 05:42:18PM -0500, Bjorn Helgaas wrote:
> On Fri, Apr 09, 2021 at 02:59:35PM -0600, Jon Derrick wrote:
> > When a specific x8 CEM card is bifurcated into x4x4 mode, and the
> > upstream ports both support hotplugging on each respective x4 device, a
> > slot management system for the CEM card requires both x4 devices to be
> > sysfs removed from the OS before it can safely turn-off physical power.
> > The implications are that Slot Control will display Powered Off status
> > for the device where the device is actually powered until both ports
> > have powered off.
> > 
> > When power is removed from the first half, the link remains active to
> > provide clocking while waiting for the second half to have power
> > removed. When power is then removed from the second half, the first half
> > starts shutdown sequence and will trigger a link status change event.
> > This is misinterpreted as an enabling event due to positive presence
> > detect and causes the first half to be re-enabled.
> > 
> > The spurious enable can be resolved by ignoring link status change
> > events when no link is active when in the off state.

Sorry for not responding earlier, I missed this patch.


> > --- a/drivers/pci/hotplug/pciehp_ctrl.c
> > +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> > @@ -265,6 +265,11 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
> >  		cancel_delayed_work(&ctrl->button_work);
> >  		fallthrough;
> >  	case OFF_STATE:
> > +		if ((events & PCI_EXP_SLTSTA_DLLSC) && !link_active) {
> > +			mutex_unlock(&ctrl->state_lock);
> > +			break;
> > +		}
> > +

I think this change will inadvertently ignore events that shouldn't be
ignored:  E.g., a DLLSC event may have been triggered by replacement of
the card in the slot and while Presence Detect State is 1, the link may
not yet be active.  The change above will cause not only the DLLSC but
also the PDC event to be ignored.

There are also reports of link flaps on card insertion and the above
change may result in the slot not being brought up even though it should.

The commit message sounds like powering down the CEM card takes longer
than expected.  We wait 1 second in set_slot_off() after disabling
slot power and that's apparently not sufficient.  The 1 second delay
is mandated by section 6.7.1.8 of the PCIe Base Spec.  If this card
needs a longer delay, a quirk should be added rather than changing
the algorithm for everyone.

Thanks,

Lukas
