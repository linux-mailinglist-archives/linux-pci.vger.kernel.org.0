Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1814AF31CB
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 15:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387601AbfKGOwd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 09:52:33 -0500
Received: from mga04.intel.com ([192.55.52.120]:5239 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729450AbfKGOwd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Nov 2019 09:52:33 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2019 06:52:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,278,1569308400"; 
   d="scan'208";a="213035757"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 07 Nov 2019 06:52:29 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 07 Nov 2019 16:52:29 +0200
Date:   Thu, 7 Nov 2019 16:52:29 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Valerio Passini <passini.valerio@gmail.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] ACPI / hotplug / PCI: Allocate resources directly under
 the non-hotplug bridge
Message-ID: <20191107145229.GT2552@lahna.fi.intel.com>
References: <20191107140259.GN2552@lahna.fi.intel.com>
 <20191107144055.GA94678@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107144055.GA94678@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 07, 2019 at 08:40:55AM -0600, Bjorn Helgaas wrote:
> On Thu, Nov 07, 2019 at 04:02:59PM +0200, Mika Westerberg wrote:
> > On Thu, Nov 07, 2019 at 07:52:46AM -0600, Bjorn Helgaas wrote:
> > > > > What would happen if a device below one of the non-hotplug
> > > > > bridges, e.g., 3a:00.0, had an I/O BAR?  Would this patch
> > > > > still work?
> > > > 
> > > > I think it would still work because now we call
> > > > pci_bus_size_bridges() only for non-hotplug bridge which do not
> > > > have I/O window open so pbus_size_io() fails to find the "free"
> > > > I/O resource on that bus and the kernel then fails to assign
> > > > that I/O resource for the device.
> > > 
> > > Not sure I understand; are you saying that we wouldn't have the
> > > EC/GPE issue, but we'd be unable to use a device below 3a:00.0
> > > that happened to have an I/O BAR?
> > 
> > Yes.
> > 
> > > That doesn't sound optimal because there is I/O space available
> > > that could be routed to 3a:00.0
> > 
> > If the none of the upstream bridges up to the PCIe root port does
> > not have I/O window open, I don't think we can do much about it.
> > Unless I'm missing something of course.
> 
> The path to this hypothetical 3a:00.0 device is:
> 
>   PCI host bridge to bus 0000:00
>   pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
>   pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
>   00:1b.0: Root Port to [bus 02-3a]
>   02:00.0: Switch Upstream Port to [bus 03-3a]
>   03:02.0: Switch Downstream Port to [bus 3a]
>   3a:00.0: reg 0x10: [io  0x????-0x????]
> 
> None of the bridges (00:1b.0, 02:00.0, 03:02.0) currently has an open
> I/O window, but there's space available on bus 00 and windows *could*
> be opened.

Right.

> I guess it comes down to that ordering problem: this Notify() and
> acpiphp_native_scan_bridge() happens before pnp/system.c reserves
> things, so we don't yet know what space is actually available.

Yes, exactly. The some parts of the range 0x0d00-0xffff belongs to
PNP/ACPI so if we open the window now it might stomp over some crucial
ACPI resources.

> If firmware had configured I/O windows for these bridges, 3a:00.0
> would probably work.  But it doesn't seem right that we would depend
> on that firmware configuration.

Well, if firmware has configured the topology in such way I think we
should at least try to trust it is intentional. Even if the (PCIe)
device might have an I/O BAR it should work without it (only legacy
endpoints are allowed to create I/O requests, althought many non-legacy
seem to include I/O BAR).
