Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81AC1F31B3
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 15:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfKGOlB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 09:41:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:48186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbfKGOlB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Nov 2019 09:41:01 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95485214D8;
        Thu,  7 Nov 2019 14:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573137660;
        bh=oee90TV9VKh3b3XXjVcgQ5PKPi5k5GIy2yTH/rCHhAg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eqiQ3Sybsgkb6ecQb48C7ChZ+0qU4vUJIeawk0G+srQMly404G84PqlX4d6AMDdmg
         Nd7jT7Q+Vy7o8cblTYh5BsWu2BYl6DcAzPzAbrtYlKMlHK6PaCq3W+KBEdzbXQd3/5
         5iy4c7h1xmBA1qFFPnKh6m8S7fWc/seonlkQ94jE=
Date:   Thu, 7 Nov 2019 08:40:55 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Valerio Passini <passini.valerio@gmail.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] ACPI / hotplug / PCI: Allocate resources directly under
 the non-hotplug bridge
Message-ID: <20191107144055.GA94678@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107140259.GN2552@lahna.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 07, 2019 at 04:02:59PM +0200, Mika Westerberg wrote:
> On Thu, Nov 07, 2019 at 07:52:46AM -0600, Bjorn Helgaas wrote:
> > > > What would happen if a device below one of the non-hotplug
> > > > bridges, e.g., 3a:00.0, had an I/O BAR?  Would this patch
> > > > still work?
> > > 
> > > I think it would still work because now we call
> > > pci_bus_size_bridges() only for non-hotplug bridge which do not
> > > have I/O window open so pbus_size_io() fails to find the "free"
> > > I/O resource on that bus and the kernel then fails to assign
> > > that I/O resource for the device.
> > 
> > Not sure I understand; are you saying that we wouldn't have the
> > EC/GPE issue, but we'd be unable to use a device below 3a:00.0
> > that happened to have an I/O BAR?
> 
> Yes.
> 
> > That doesn't sound optimal because there is I/O space available
> > that could be routed to 3a:00.0
> 
> If the none of the upstream bridges up to the PCIe root port does
> not have I/O window open, I don't think we can do much about it.
> Unless I'm missing something of course.

The path to this hypothetical 3a:00.0 device is:

  PCI host bridge to bus 0000:00
  pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
  pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
  00:1b.0: Root Port to [bus 02-3a]
  02:00.0: Switch Upstream Port to [bus 03-3a]
  03:02.0: Switch Downstream Port to [bus 3a]
  3a:00.0: reg 0x10: [io  0x????-0x????]

None of the bridges (00:1b.0, 02:00.0, 03:02.0) currently has an open
I/O window, but there's space available on bus 00 and windows *could*
be opened.

I guess it comes down to that ordering problem: this Notify() and
acpiphp_native_scan_bridge() happens before pnp/system.c reserves
things, so we don't yet know what space is actually available.

If firmware had configured I/O windows for these bridges, 3a:00.0
would probably work.  But it doesn't seem right that we would depend
on that firmware configuration.

Bjorn
