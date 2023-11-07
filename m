Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C84A7E3AD7
	for <lists+linux-pci@lfdr.de>; Tue,  7 Nov 2023 12:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbjKGLPk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Nov 2023 06:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjKGLPk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Nov 2023 06:15:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE5791;
        Tue,  7 Nov 2023 03:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699355737; x=1730891737;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w2/2LCzSyzbuwvyD3qf3LKnmsbE00Zq8CXWqqzD2B60=;
  b=fa0NAkBuJN41kW02oz4ZRbbOjIKOLyaE844KNOTfrshaUendIRXObI8Q
   H9fHwsw+vhWjM6TC6hS+KGY9AKwPnSwo26Ol7SrJK+4yo1NMpZnl3xDPt
   zabgxrX19EfweXMZ2VoogA1tuSariPOKt3TqyRjB5yn8CF7tYsVOOt3UX
   Sm6PSH9e2PN8ifZAQBgmroEHHxigPOCBWbm5xnx/QfJ7pIybzEkicZj4b
   ECrEECljKuj2NksgHks7ym6bPiE9TZ5kDjNnOPCd6Q55Cs/T7uvLWQQVv
   E4UAgtZN/1SpCyizZLt9fVhAT/J0zVkioc3Ccoj/oeacmX1wsd/AEaiLK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="379875889"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="379875889"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 03:15:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="936124134"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="936124134"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 07 Nov 2023 03:15:31 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 64056706; Tue,  7 Nov 2023 13:15:30 +0200 (EET)
Date:   Tue, 7 Nov 2023 13:15:30 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Kenneth R. Crudup" <kenny@panix.com>, vidyas@nvidia.com,
        bhelgaas@google.com, kai.heng.feng@canonical.com,
        andrea.righi@canonical.com, vicamo.yang@canonical.com,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Ricky WU <ricky_wu@realtek.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: My AlderLake Dell (XPS-9320) needs these patches to get full
 standby/low-power modes
Message-ID: <20231107111530.GW17433@black.fi.intel.com>
References: <218aa81f-9c6-5929-578d-8dc15f83dd48@panix.com>
 <20231106181107.GA255535@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231106181107.GA255535@bhelgaas>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Mon, Nov 06, 2023 at 12:11:07PM -0600, Bjorn Helgaas wrote:
> [+cc Mika, Sathy, Rafael, David, Ilpo, Ricky, Mario, linux-pci]
> 
> On Sat, Nov 04, 2023 at 10:13:24AM -0700, Kenneth R. Crudup wrote:
> > 
> > I have a Dell XPS-9320 with an Alderlake chipset, and the NVMe behind a
> > VMD device:
> > 
> > ----
> > [    0.127342] smpboot: CPU0: 12th Gen Intel(R) Core(TM) i7-1280P (family: 0x6, model: 0x9a, stepping: 0x3)
> > ----
> > 0000:00:0e.0 0104: 8086:467f
> >         Subsystem: 1028:0af3
> >         Flags: bus master, fast devsel, latency 0, IOMMU group 9
> >         Memory at 603c000000 (64-bit, non-prefetchable) [size=32M]
> >         Memory at 72000000 (32-bit, non-prefetchable) [size=32M]
> > a7152be79b6        Memory at 6040100000 (64-bit, non-prefetchable) [size=1M]
> >         Capabilities: <access denied>
> >         Kernel driver in use: vmd
> > ----
> > 
> > The only release kernel that was able to get this laptop to fully get into
> > low-power (unfortunately only s0ix) was the Ubuntu-6.2.0- ... series from
> > Ubuntu
> > (remote git://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/lunar).
> > 
> > I'd bisected it to the following commits (in this order):
> > 
> > 4ff116d0d5fd PCI/ASPM: Save L1 PM Substates Capability for suspend/resume
> > 5e85eba6f50d PCI/ASPM: Refactor L1 PM Substates Control Register programming
> > 1a0102a08f20 UBUNTU: SAUCE: PCI/ASPM: Enable ASPM for links under VMD domain
> > 47c7bfd31514 UBUNTU: SAUCE: PCI/ASPM: Enable LTR for endpoints behind VMD
> > 154d48da2c57 UBUNTU: SAUCE: vmd: fixup bridge ASPM by driver name instead
> 
> Thanks for these.  You don't happen to have URLs for those Ubuntu
> commits, do you?  E.g., https://git.kernel.org/linus/4ff116d0d5fd
> (which was reverted by a7152be79b62 ("Revert "PCI/ASPM: Save L1 PM
> Substates Capability for suspend/resume"")).
> 
> > Without the patches I never see Pkg%PC8 or higher(? lower?), nor i915 states
> > DC5/6, all necssary for SYS%LPI/CPU%LPI. I've attached a little script I use
> > alongside turbostat for verifying low-power operation (and also for seeing
> > what chipset subsystem may be preventing it).
> > 
> > The first two are in Linus' trees, but were reverted (4ff116d0d5fd in
> > a7152be79b6, 5e85eba6f50d in ff209ecc376a). The last three come from Ubuntu's
> > Linux trees (see remote spec above). The first two remain reverted in the
> > Ubuntu trees, but if I put them back, I get increased power savings during
> > suspend/resume cycles.
> > 
> > Considering the power draw is really significant without these patches (10s
> > of %s per hour) and I'd think Dell would have sold some decent number of
> > these laptops, I'd been patiently waiting for these patches, or some variant
> > to show up in the stable trees, but so far I'm up to the 6.6 stable kernel
> > and still having to manually cherry-pick these, so I thought maybe I could
> > bring this to the PM maintainers' attention so at least start a discussion
> > about this issue.
> 
> Thank you very much for raising this again.  We really need to make
> some progress, and Mika recently posted a patch to add the
> 4ff116d0d5fd functionality again:
> https://lore.kernel.org/r/20231002070044.2299644-1-mika.westerberg@linux.intel.com
> 
> The big problem is that it works on *most* systems, but it still seems
> to break a few.  So Mika's current patch relies on a denylist of
> systems where we *don't* restore the substates.

According to latest reports it is just that one system where this is
still an issue. The latest patch works in Asus UX305FA even if it is not
in the denylist. That would leave that one system only to the denylist,
at least the ones we are aware about.
