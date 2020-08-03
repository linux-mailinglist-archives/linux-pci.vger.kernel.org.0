Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1A923A28D
	for <lists+linux-pci@lfdr.de>; Mon,  3 Aug 2020 12:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbgHCKKp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Aug 2020 06:10:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:44614 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbgHCKKp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Aug 2020 06:10:45 -0400
IronPort-SDR: AUNkYSwyZsOjUTQ4ZXFR5p0RI85M2L5XF+OZR8Qy4xsNlxgw+sA3QQQf5Oy9SrP+f++zdIt0At
 ywlOyklFVngQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9701"; a="216497063"
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; 
   d="scan'208";a="216497063"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 03:10:44 -0700
IronPort-SDR: 7Ip5RiplpVxRfCdbc1UIL3aAhXtw/yvuovWyHAYwlgniA1BBPByMoq9xzGsfuKPRSdJUxxbodJ
 ieFfHWH8he8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; 
   d="scan'208";a="396006606"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 03 Aug 2020 03:10:41 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 03 Aug 2020 13:10:40 +0300
Date:   Mon, 3 Aug 2020 13:10:40 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Keith Busch <kbusch@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Reduce noisiness on hot removal
Message-ID: <20200803101040.GH1375436@lahna.fi.intel.com>
References: <b45e46fd8a6aa6930aaac9d7718c2e4b787a4e5e.1595935071.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b45e46fd8a6aa6930aaac9d7718c2e4b787a4e5e.1595935071.git.lukas@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 28, 2020 at 01:24:10PM +0200, Lukas Wunner wrote:
> When a PCIe card is hot-removed, the Presence Detect State and Data Link
> Layer Link Active bits often do not clear simultaneously.  I've seen
> delays of up to 244 msec between the two events with Thunderbolt.
> 
> After pciehp has brought down the slot in response to the first event,
> the other bit may still be set.  It's not discernible whether it's set
> because a new card is already in the slot or if it will soon clear.
> So pciehp tries to bring up the slot and in the latter case fails with
> a bunch of messages, some of them at KERN_ERR severity.  The messages
> are false positives if the slot is no longer occupied and annoy users.
> 
> Stuart Hayes reports the following splat on hot removal:
> 
> KERN_INFO pcieport 0000:3c:06.0: pciehp: Slot(180): Link Up
> KERN_INFO pcieport 0000:3c:06.0: pciehp: Timeout waiting for Presence Detect
> KERN_ERR  pcieport 0000:3c:06.0: pciehp: link training error: status 0x0001
> KERN_ERR  pcieport 0000:3c:06.0: pciehp: Failed to check link status
> 
> Dongdong Liu complains about a similar splat:
> 
> KERN_INFO pciehp 0000:80:10.0:pcie004: Slot(36): Link Down
> KERN_INFO iommu: Removing device 0000:87:00.0 from group 12
> KERN_INFO pciehp 0000:80:10.0:pcie004: Slot(36): Card present
> KERN_INFO pcieport 0000:80:10.0: Data Link Layer Link Active not set in 1000 msec
> KERN_ERR  pciehp 0000:80:10.0:pcie004: Failed to check link status
> 
> Users are particularly irritated to see a bringup attempt even though
> the slot was explicitly brought down via sysfs.  In a perfect world, we
> could avoid this by setting Link Disable on slot bringdown and
> re-enabling it upon a Presence Detect State change.  In reality however,
> there are broken hotplug ports which hardwire Presence Detect to zero,
> see 80696f991424 ("PCI: pciehp: Tolerate Presence Detect hardwired to
> zero").  Conversely, PCIe r1.0 hotplug ports hardwire Link Active to
> zero because Link Active Reporting wasn't specified before PCIe r1.1.
> On unplug, some ports first clear Presence then Link (see Stuart Hayes'
> splat) whereas others use the inverse order (see Dongdong Liu's splat).
> To top it off, there are hotplug ports which flap the Presence and Link
> bits on slot bringup, see 6c35a1ac3da6 ("PCI: pciehp: Tolerate initially
> unstable link").
> 
> pciehp is designed to work with all of these variants.  Surplus attempts
> at slot bringup are a lesser evil than not being able to bring up slots
> at all.  Although we could try to perfect the behavior for specific
> hotplug controllers, we'd risk breaking others or increasing code
> complexity.
> 
> But we can certainly minimize annoyance by emitting only a single
> message with KERN_INFO severity if bringup is unsuccessful:
> 
> * Drop the "Timeout waiting for Presence Detect" message in
>   pcie_wait_for_presence().  The sole caller of that function,
>   pciehp_check_link_status(), ignores the timeout and carries on.
>   It emits error messages of its own and I don't think this particular
>   message adds much value.
> 
> * There's a single error condition in pciehp_check_link_status() which
>   does not emit a message.  Adding one allows dropping the "Failed to
>   check link status" message emitted by board_added() if
>   pciehp_check_link_status() returns a non-zero integer.
> 
> * Tone down all messages in pciehp_check_link_status() to KERN_INFO
>   severity and rephrase them to look as innocuous as possible.  To this
>   end, move the message emitted by pcie_wait_for_link_delay() to its
>   callers.
> 
> As a result, Stuart Hayes' splat becomes:
> 
> KERN_INFO pcieport 0000:3c:06.0: pciehp: Slot(180): Link Up
> KERN_INFO pcieport 0000:3c:06.0: pciehp: Slot(180): Cannot train link: status 0x0001
> 
> Dongdong Liu's splat becomes:
> 
> KERN_INFO pciehp 0000:80:10.0:pcie004: Slot(36): Card present
> KERN_INFO pciehp 0000:80:10.0:pcie004: Slot(36): No link
> 
> The messages now merely serve as information that presence or link bits
> were set a little longer than expected.  Bringup failures which are not
> false positives are still reported, albeit no longer at KERN_ERR
> severity.
> 
> Link: https://lore.kernel.org/linux-pci/20200310182100.102987-1-stuart.w.hayes@gmail.com/
> Link: https://lore.kernel.org/linux-pci/1547649064-19019-1-git-send-email-liudongdong3@huawei.com/
> Reported-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> Reported-by: Dongdong Liu <liudongdong3@huawei.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
