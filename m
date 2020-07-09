Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53BEA21A452
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jul 2020 18:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgGIQF3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jul 2020 12:05:29 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:37881 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbgGIQF3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jul 2020 12:05:29 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 6DFBA2800B1B1;
        Thu,  9 Jul 2020 18:05:26 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 430F4678ACC; Thu,  9 Jul 2020 18:05:26 +0200 (CEST)
Date:   Thu, 9 Jul 2020 18:05:26 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Don't enable slot unless link or presence up
Message-ID: <20200709160526.unwnsqqfcvd6wkux@wunner.de>
References: <20200310182100.102987-1-stuart.w.hayes@gmail.com>
 <20200329123643.eeqervkxcxzc3kjn@wunner.de>
 <d8c4c36a-9eb9-33c6-556a-2a2d55e127ec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8c4c36a-9eb9-33c6-556a-2a2d55e127ec@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 08, 2020 at 05:39:49PM -0500, Stuart Hayes wrote:
> It's more than just the "Link Up" message.  When I "power down" an NVMe
> drive via sysfs (on a system that doesn't actually shut off the power to
> the slot), and then I physically remove the drive, I get this ugly string
> of messages:
> 
> pcieport 0000:3c:06.0: pciehp: Slot(180): Link Up
> pcieport 0000:3c:06.0: pciehp: Timeout waiting for Presence Detect
> pcieport 0000:3c:06.0: pciehp: link training error: status 0x0001
> pcieport 0000:3c:06.0: pciehp: Failed to check link status

I was just wondering if those messages could be avoided by setting
the Link Disable bit in the Link Control register if the slot
is brought down via sysfs.  The question is, if a new NVMe
drive is subsequently inserted into the slot, does the hotplug
controller signal a DLLSC event even though Link Disable is set?
Or at least a PDC event, whereupon we could clear Link Disable?

Or is there some other way to force the link into a state such that
it is off but DLLSC events continue to be received?

There's a function pciehp_link_enable() which can set or clear the
Link Disable flag.  But it's only ever invoked to clear it.  Hm, digging
in the git history shows that between 2012 and 2014 it was used to set
Link Disable when bringing down the slot, but b1811d2455f3 dropped that
because DLLSC was no longer received.

I guess we might be able to set Link Disable, then clear it once the
PDC event is received upon removal of the NVMe drive from the slot.
But I imagine that would complicate the state machine quite a bit.

Another idea:  If the hotplug controller is suspended to D3hot,
the link should be down but presence or link events should still
be received.  Sadly, runtime D3hot is disabled by default for
hotplug ports because it is known to not work on certain SkyLake
Xeon-SP systems and possibly others (see eb3b5bf1a88d).  You can
force it on by passing pcie_port_pm=force on the command line.


> Would you consider the patch if I rework it to separate the
> BLINKINGON_STATE so that its behavior isn't changed, and change the
> fake PDC events to PDC | DLLSC?

TBH I'd suggest to simply drop some of the messages and tone down the
remaining ones, in particular:

* Drop the "Timeout waiting for Presence Detect" message in
  pcie_wait_for_presence().  The sole caller of that function,
  pciehp_check_link_status(), doesn't bail out if it fails
  but continues and will emit an error message of its own.
  I don't think the message provides much additional value.

* Tone down the "link training error" message in
  pciehp_check_link_status() to ctrl_info().  That message at
  least prints the contents of the Link Status register, which
  may have some value.

* Add a message with ctrl_info() severity in the "if (!found)"
  clause in pciehp_check_link_status().  That way the function
  emits a message in all error cases.

* This in turn allows dropping the "Failed to check link status"
  message in board_added().

As a result you should just get two messages with KERN_INFO severity
which simply serve as an indication that DLLLA and PDS did not change
in unison.

With Thunderbolt, unplugging a daisy chain of devices always causes
a bunch of harmless "no response from device" messages with KERN_INFO
severity.  We never know if there's a real problem or not, so we try
to alert the user that there *may* be a problem, but at the same time
we should try to keep noisiness at a minimum.

Thanks,

Lukas
