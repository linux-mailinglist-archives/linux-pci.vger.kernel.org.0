Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BF874117F
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jun 2023 14:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjF1MmV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jun 2023 08:42:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:19059 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232512AbjF1Mi6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jun 2023 08:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687955938; x=1719491938;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SiUPLFX8yooaTBprOCUevkhBwdpxnbwZbDK6fkmxZHs=;
  b=hWwqhdtTZhEUw1ZLKR8KXTn27gIDpUd/4j+dWFwkuy5/G7ZkPAmW7txY
   15aJrJNkjDXTPL6rMxccn4oCxXfbq0CqVhOmfwdOdwmze8DSAY1EDj4+o
   /IzZTwWDYEyMWXuYx0gbVAe3Od4yk3XTHuutVtooOAchbnrsNaDIS9zGW
   ct4LbJNSeKOuJqAEpiVUa4Lbn8fFt2VtY2nhRlg3MNzJ7VMX3RXwfw7c4
   FcrkE97AAo5qZSdU+hCec2+E7tHYDgYH9hwXLQoIO3Swva7KZz4IiAmMW
   TKJgh9OJHJ9izovTFxW/dBocE9wzAaSKu4wDMPShyY7+E43tOiMNVUPrt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="342168627"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="342168627"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 05:38:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="787031335"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="787031335"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jun 2023 05:38:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id CF8B5E1; Wed, 28 Jun 2023 15:38:54 +0300 (EEST)
Date:   Wed, 28 Jun 2023 15:38:54 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Thomas Witt <thomas@witt.link>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Tasev Nikola <tasev.stefanoska@skynet.be>,
        Mark Enriquez <enriquezmark36@gmail.com>,
        Thomas Witt <kernel@witt.link>,
        Koba Ko <koba.ko@canonical.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/ASPM: Add back L1 PM Substate save and restore
Message-ID: <20230628123854.GM14638@black.fi.intel.com>
References: <20230627100447.GC14638@black.fi.intel.com>
 <20230627204124.GA366188@bhelgaas>
 <20230628064637.GF14638@black.fi.intel.com>
 <5a5f7511-74e0-39a2-3b3f-864e3f2e957d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5a5f7511-74e0-39a2-3b3f-864e3f2e957d@amd.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 28, 2023 at 07:16:49AM -0500, Mario Limonciello wrote:
> On 6/28/23 01:46, Mika Westerberg wrote:
> > Hi Bjorn,
> > 
> > On Tue, Jun 27, 2023 at 03:41:24PM -0500, Bjorn Helgaas wrote:
> > > On Tue, Jun 27, 2023 at 01:04:47PM +0300, Mika Westerberg wrote:
> > > > On Tue, Jun 27, 2023 at 11:53:33AM +0200, Thomas Witt wrote:
> > > > > On 27/06/2023 08:24, Mika Westerberg wrote:
> > > > > > Commit a7152be79b62 ("Revert "PCI/ASPM: Save L1 PM Substates Capability
> > > > > > for suspend/resume"") reverted saving and restoring of ASPM L1 Substates
> > > > > > due to a regression that caused resume from suspend to fail on certain
> > > > > > systems. However, we never added this capability back and this is now
> > > > > > causing systems fail to enter low power CPU states, drawing more power
> > > > > > from the battery.
> > > > > 
> > > > > Hello Mika,
> > > > > 
> > > > > I am sorry, but your patch (applied on top of master) triggers the exact
> > > > > same behaviour I described in
> > > > > <https://bugzilla.kernel.org/show_bug.cgi?id=216877> (nvme and wifi become
> > > > > unavailable during suspend/resume)
> > > > 
> > > > Thanks for testing! Can you provide the output of dmidecode from that
> > > > system? We can add it to the denylist as well to avoid the issue on your
> > > > system.
> > > 
> > > To me this says we don't completely understand the mechanism of the
> > > failure.  If BIOS made L1SS work initially, Linux should be able to
> > > make it work again after suspend/resume.
> > > 
> > > If we can identify an actual hardware or firmware defect, it makes
> > > good sense to add a quirk or denylist.  But I'll push back a little if
> > > it's just "there's some problem we don't understand on this system, so
> > > avoid it."
> > 
> > Fair enough.
> > 
> > I've looked at the Thomas' system dmesg that he attached to the bugzilla
> > and he has mem_sleep_default=deep in the kernel command line. There is
> > no such option in the mainline kernel but I suppose this makes systemd
> > (or some initscript) to write "deep" to /sys/power/mem_sleep, thus
> > forcing S3 instead of the default the ACPI tables suggest, which
> > probably is S0ix (Intel low power state which does not involve BIOS).
> 
> JFYI actually it is a mainline kernel parameter.
> 
> Reference the documentation here:
> https://www.kernel.org/doc/html/v6.4/admin-guide/kernel-parameters.html?highlight=mem_sleep_default

Indeed it is. Thanks for correcting me. I grepped this from my source
tree but somehow screwed it up and it did not show up anything. Now that
I checked again it is there.
