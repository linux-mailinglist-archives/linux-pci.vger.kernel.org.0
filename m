Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5172BBE97
	for <lists+linux-pci@lfdr.de>; Sat, 21 Nov 2020 12:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgKULKx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 21 Nov 2020 06:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbgKULKx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 21 Nov 2020 06:10:53 -0500
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBADBC0613CF
        for <linux-pci@vger.kernel.org>; Sat, 21 Nov 2020 03:10:52 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 77EFD2801F633;
        Sat, 21 Nov 2020 12:10:45 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id CFE30234848; Sat, 21 Nov 2020 12:10:50 +0100 (CET)
Date:   Sat, 21 Nov 2020 12:10:50 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] pci: pciehp: Handle MRL interrupts to enable slot
 for hotplug.
Message-ID: <20201121111050.GA6854@wunner.de>
References: <20200925230138.29011-1-ashok.raj@intel.com>
 <20201119075120.GA542@wunner.de>
 <20201119220807.GB102444@otc-nc-03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119220807.GB102444@otc-nc-03>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 19, 2020 at 02:08:07PM -0800, Raj, Ashok wrote:
> On Thu, Nov 19, 2020 at 08:51:20AM +0100, Lukas Wunner wrote:
> > If an Attention Button is present, the current behavior is to bring up
> > the hotplug slot as soon as presence or link is detected.  We don't wait
> > for a button press.  This is intended as a convience feature to bring up
> > slots as quickly as possible, but the behavior can be changed if the
> > button press and 5 second delay is preferred.
> 
> Looks like we still don't subscribe to PDC if ATTN is present? So you don't
> get an event until someone presses the button to process hotplug right?
[...]
> Looks like we still wait for button press to process. When you don't have a
> power control yes the DLLSC would kick in and we would process them. but if
> you have power control, you won't turn on until the button press?

Right.

For hotplug ports without a power controller, we could in principle achieve
the same behavior (i.e. not bring up the slot until the button is pressed)
by not subscribing to DLLSC events as well (if an Attention Button is
present).

However there are hotplug ports out there with incorrect data in the
Slot Capabilities register:  They claim to have an Attention Button
but in reality don't have one.  In those cases we're still able to
bring up and down the slot right now.  Whereas if we changed the
behavior, those hotplug ports would no longer work.  (We'd not
bring up the slot until the button is pressed but there is no button.)

E.g. this bugzilla contains dmesg output for a 5.4 kernel which is able
to bring up and down the slot correctly even though the Slot Capabilities
register incorrectly claims to have an Attention Button as well as
Command Complete support:
https://bugzilla.kernel.org/show_bug.cgi?id=209283


> > In any case the behavior in response to an Attention Button press should
> > be the same regardless whether an MRL is present or not.  (The spec
> > doesn't seem to say otherwise.)
> 
> True, Looks like that is a Linux behavior, certainly not a spec
> recommendation. Our validation teams tell Windows also behaves such. i.e
> when ATTN exists button press drivers the hot-add. Linux doesn't need to
> follow suite though. 
> 
> In that case do we need to subscribe to PDC even when ATTN is present?

Hm, I'd just leave it the way it is for now if it works.


> > > +	/*
> > > +	 * If ATTN is present and MRL is triggered
> > > +	 * ignore the Presence Change Event.
> > > +	 */
> > > +	if (ATTN_BUTTN(ctrl) && (events & PCI_EXP_SLTSTA_MRLSC))
> > > +		events &= ~PCI_EXP_SLTSTA_PDC;
> > 
> > An Attention Button press results in a synthesized PDC event after
> > 5 seconds, which may get lost due to the above if-statement.
> 
> When its synthesized you don't get the MRLSC? So we won't nuke the PDC then
> correct?

I just meant to say, pciehp_queue_pushbutton_work() will synthesize
a PDC event after 5 seconds and with the above code snippet, if an
MRL event happens simultaneously, that synthesized PDC event would
be lost.  So I'd just drop the above code snippet.  I think you
just need to subscribe to MRL events and propagate them to
pciehp_handle_presence_or_link_change().  There, you'd bring down
the slot if an MRL event has occurred (same as DLLSC or PDC).
Then, check whether MRL is closed.  If so, and if presence or link
is up, try to bring up the slot.

If the MRL is open when slot or presence has gone up, the slot is not
brought up.  But once MRL is closed, there'll be another MRL event and
*then* the slot is brought up.

Thanks,

Lukas
