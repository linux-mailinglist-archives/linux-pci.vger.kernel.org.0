Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 780CDCF9BC
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2019 14:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbfJHM1P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Oct 2019 08:27:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:30882 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730317AbfJHM1P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Oct 2019 08:27:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 05:27:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,270,1566889200"; 
   d="scan'208";a="206626898"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 08 Oct 2019 05:27:11 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 08 Oct 2019 15:27:10 +0300
Date:   Tue, 8 Oct 2019 15:27:10 +0300
From:   "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: Re: [PATCH v8 6/6] PCI: Fix bug resulting in double hpmemsize being
 assigned to MMIO window
Message-ID: <20191008122710.GK2819@lahna.fi.intel.com>
References: <SL2P216MB018781FEDD139047FCBE42AB80C00@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SL2P216MB018781FEDD139047FCBE42AB80C00@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 26, 2019 at 12:55:03PM +0000, Nicholas Johnson wrote:
> Background
> ==========================================================================

I don't think the above are needed.

> Currently, the kernel can sometimes assign the MMIO_PREF window
> additional size into the MMIO window, resulting in double the MMIO
> additional size, even if the MMIO_PREF window was successful.
> 
> This happens if in the first pass, the MMIO_PREF succeeds but the MMIO
> fails. In the next pass, because MMIO_PREF is already assigned, the
> attempt to assign MMIO_PREF returns an error code instead of success
> (nothing more to do, already allocated).
> 
> Example of problem (more context can be found in the bug report URL):

Maybe add bit more context in the changelog. Also explain how the
problem can be reproduced.

> Mainline kernel:
> pci 0000:06:01.0: BAR 14: assigned [mem 0x90100000-0xa00fffff] = 256M
> pci 0000:06:04.0: BAR 14: assigned [mem 0xa0200000-0xb01fffff] = 256M
> 
> Patched kernel:
> pci 0000:06:01.0: BAR 14: assigned [mem 0x90100000-0x980fffff] = 128M
> pci 0000:06:04.0: BAR 14: assigned [mem 0x98200000-0xa01fffff] = 128M
> 
> This was using pci=realloc,hpmemsize=128M,nocrs - on the same machine
> with the same configuration, with a Ubuntu mainline kernel and a kernel
> patched with this patch series.
> 
> This patch is vital for the next patch in the series. The next patch

There is no next patch in the patch series ;-)

> allows the user to specify MMIO and MMIO_PREF independently. If the
> MMIO_PREF is set to be very large, this bug will end up more than
> doubling the MMIO size. The bug results in the MMIO_PREF being added to
> the MMIO window, which means doubling if MMIO_PREF size == MMIO size.
> With a large MMIO_PREF, without this patch, the MMIO window will likely
> fail to be assigned altogether due to lack of 32-bit address space.
> 
> Patch notes
> ==========================================================================

Here also the above two lines are not needed.

> Change find_free_bus_resource() to not skip assigned resources with
> non-null parent.
> 
> Add checks in pbus_size_io() and pbus_size_mem() to return success if
> resource returned from find_free_bus_resource() is already allocated.
> 
> This avoids pbus_size_io() and pbus_size_mem() returning error code to
> __pci_bus_size_bridges() when a resource has been successfully assigned
> in a previous pass. This fixes the existing behaviour where space for a
> resource could be reserved multiple times in different parent bridge
> windows. This also greatly reduces the number of failed BAR messages in
> dmesg when Linux assigns resources.
> 
> See related from Logan Gunthorpe (same problem, different solution):
> https://lore.kernel.org/lkml/20190531171216.20532-2-logang@deltatee.com/T/#u

Link: https://lore.kernel.org/lkml/20190531171216.20532-2-logang@deltatee.com/T/#u

> Solves bug report: https://bugzilla.kernel.org/show_bug.cgi?id=203243

Link: https://bugzilla.kernel.org/show_bug.cgi?id=203243

The patch itself looks good to me.
