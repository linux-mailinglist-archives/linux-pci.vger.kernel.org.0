Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 935C8100F16
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2019 23:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfKRW6F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Nov 2019 17:58:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:41672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbfKRW6F (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Nov 2019 17:58:05 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7545B2230C;
        Mon, 18 Nov 2019 22:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574117883;
        bh=5gyss9gjUd5Zvf2z4gI+tfw5ZIJEJ76eIhvqtj89hYs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nWxyuuIC4InqGMCQNPgIjh0P7i44ffJt8oqX6uM471PGhuZqWmVz7LB0fEzpq3xFG
         UG96KAKbyRd/IWaDqXRgOqtia1GM9jlNuXSBYDUO+ASRPHxmrUAvc7imHmw0yG9I+K
         M1oInbiXQUvq1vN7ZBZkF/8vmHKFrcZIOc/c/kwk=
Date:   Mon, 18 Nov 2019 16:58:02 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: Re: [PATCH v3 1/1] PCI: Fix bug resulting in double hpmemsize being
 assigned to MMIO window
Message-ID: <20191118225802.GA71768@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PS2P216MB0755848993A4445324AC516E804D0@PS2P216MB0755.KORP216.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 18, 2019 at 09:43:34AM +0000, Nicholas Johnson wrote:
> On Thu, Nov 14, 2019 at 10:56:37AM -0600, Bjorn Helgaas wrote:
> > On Wed, Nov 13, 2019 at 03:25:28PM +0000, Nicholas Johnson wrote:
> > > Currently, the kernel can sometimes assign the MMIO_PREF window
> > > additional size into the MMIO window, resulting in extra MMIO additional
> > > size, despite the MMIO_PREF additional size being assigned successfully
> > > into the MMIO_PREF window.
> > > 
> > > This happens if in the first pass, the MMIO_PREF succeeds but the MMIO
> > > fails. In the next pass, because MMIO_PREF is already assigned, the
> > > attempt to assign MMIO_PREF returns an error code instead of success
> > > (nothing more to do, already allocated). Hence, the size which is
> > > actually allocated, but thought to have failed, is placed in the MMIO
> > > window.
> > > 
> > > Example of problem (more context can be found in the bug report URL):
> > > 
> > > Mainline kernel:
> > > pci 0000:06:01.0: BAR 14: assigned [mem 0x90100000-0xa00fffff] = 256M
> > > pci 0000:06:04.0: BAR 14: assigned [mem 0xa0200000-0xb01fffff] = 256M
> > > 
> > > Patched kernel:
> > > pci 0000:06:01.0: BAR 14: assigned [mem 0x90100000-0x980fffff] = 128M
> > > pci 0000:06:04.0: BAR 14: assigned [mem 0x98200000-0xa01fffff] = 128M
> > > 
> > > This was using pci=realloc,hpmemsize=128M,nocrs - on the same machine
> > > with the same configuration, with a Ubuntu mainline kernel and a kernel
> > > patched with this patch.
> > > 
> > > The bug results in the MMIO_PREF being added to the MMIO window, which
> > > means doubling if MMIO_PREF size = MMIO size. With a large MMIO_PREF,
> > > the MMIO window will likely fail to be assigned altogether due to lack
> > > of 32-bit address space.
> > > 
> > > Change find_free_bus_resource() to do the following:
> > > - Return first unassigned resource of the correct type.
> > > - If none of the above, return first assigned resource of the correct type.
> > > - If none of the above, return NULL.
> > > 
> > > Returning an assigned resource of the correct type allows the caller to
> > > distinguish between already assigned and no resource of the correct type.
> > > 
> > > Rename find_free_bus_resource to find_bus_resource_of_type().
> > > 
> > > Add checks in pbus_size_io() and pbus_size_mem() to return success if
> > > resource returned from find_free_bus_resource() is already allocated.
> > > 
> > > This avoids pbus_size_io() and pbus_size_mem() returning error code to
> > > __pci_bus_size_bridges() when a resource has been successfully assigned
> > > in a previous pass. This fixes the existing behaviour where space for a
> > > resource could be reserved multiple times in different parent bridge
> > > windows.
> > > 
> > > Link: https://lore.kernel.org/lkml/20190531171216.20532-2-logang@deltatee.com/T/#u
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=203243
> > > 
> > > Reported-by: Kit Chow <kchow@gigaio.com>
> > > Reported-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> > > Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> > > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > 
> > Applied with reviewed-by from Mika and Logan to pci/resource for v5.5,
> > thanks!
> 
> We have v5.4-rc8, so there is one more week. Please let me know if you 
> have any concerns about the other four patches so that I may address 
> them ASAP. If you are worried about the first one, I can re-post the 
> series with it at the end, so that the others can be taken first.

I assume you're talking about this:

  [PATCH v11 0/4] Patch series to assist Thunderbolt allocation with kernel parameters

I hope to merge those early in the next cycle so we get some time in
linux-next for wider testing.  It's later in the v5.5 cycle than I
would be comfortable with.

Bjorn
