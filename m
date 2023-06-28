Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75B1740B5B
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jun 2023 10:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjF1I0f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jun 2023 04:26:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:44740 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232981AbjF1IYa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jun 2023 04:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687940670; x=1719476670;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p/sN2cJsiSOl8DdJEbZwKSNafKLiY+207tzomAQQrxE=;
  b=YZZxD2oHVbgcz86ok9NW8+IoPEyHIRTY7fTtLihBjMtFmEgA4+U0FM2/
   fLpzTWwrI4g9wTVFcaN4UMxHfn6DMB+K5hw72Kgr9kI4NvUF330fA3kCW
   8IdNu6TacqS6a0NOPunFD1FPrJ+XMKVebxWTsjFllHczTEfE0/HDdbYgH
   +NNb1NvIRztTU813baJaqJxLewUPZPSpvtQevnmgiLY7i0kvKGt8gKUjk
   LxVZKFAIW7zXV4ob9nbZKa4ZQEfbl6506o9zVnswqTHXyLxWYKsbiAOUP
   9uLDd8fJ/6rk0/DfoSDGpaeC7/D8j1CIEAXoEaqSgkJFija00dTw+zr52
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="392481284"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="392481284"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 23:46:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="716819353"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="716819353"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 27 Jun 2023 23:46:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 0C3E03DA; Wed, 28 Jun 2023 09:46:37 +0300 (EEST)
Date:   Wed, 28 Jun 2023 09:46:37 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Witt <thomas@witt.link>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Tasev Nikola <tasev.stefanoska@skynet.be>,
        Mark Enriquez <enriquezmark36@gmail.com>,
        Thomas Witt <kernel@witt.link>,
        Koba Ko <koba.ko@canonical.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/ASPM: Add back L1 PM Substate save and restore
Message-ID: <20230628064637.GF14638@black.fi.intel.com>
References: <20230627100447.GC14638@black.fi.intel.com>
 <20230627204124.GA366188@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230627204124.GA366188@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Tue, Jun 27, 2023 at 03:41:24PM -0500, Bjorn Helgaas wrote:
> On Tue, Jun 27, 2023 at 01:04:47PM +0300, Mika Westerberg wrote:
> > On Tue, Jun 27, 2023 at 11:53:33AM +0200, Thomas Witt wrote:
> > > On 27/06/2023 08:24, Mika Westerberg wrote:
> > > > Commit a7152be79b62 ("Revert "PCI/ASPM: Save L1 PM Substates Capability
> > > > for suspend/resume"") reverted saving and restoring of ASPM L1 Substates
> > > > due to a regression that caused resume from suspend to fail on certain
> > > > systems. However, we never added this capability back and this is now
> > > > causing systems fail to enter low power CPU states, drawing more power
> > > > from the battery.
> > > 
> > > Hello Mika,
> > > 
> > > I am sorry, but your patch (applied on top of master) triggers the exact
> > > same behaviour I described in
> > > <https://bugzilla.kernel.org/show_bug.cgi?id=216877> (nvme and wifi become
> > > unavailable during suspend/resume)
> > 
> > Thanks for testing! Can you provide the output of dmidecode from that
> > system? We can add it to the denylist as well to avoid the issue on your
> > system.
> 
> To me this says we don't completely understand the mechanism of the
> failure.  If BIOS made L1SS work initially, Linux should be able to
> make it work again after suspend/resume.
> 
> If we can identify an actual hardware or firmware defect, it makes
> good sense to add a quirk or denylist.  But I'll push back a little if
> it's just "there's some problem we don't understand on this system, so
> avoid it."

Fair enough.

I've looked at the Thomas' system dmesg that he attached to the bugzilla
and he has mem_sleep_default=deep in the kernel command line. There is
no such option in the mainline kernel but I suppose this makes systemd
(or some initscript) to write "deep" to /sys/power/mem_sleep, thus
forcing S3 instead of the default the ACPI tables suggest, which
probably is S0ix (Intel low power state which does not involve BIOS).

So when forcing S3 this means the system suspend and resume is done
through the BIOS who is supposed to enable wakes and program the devices
accordingly during and after S3 before the OS is given back the control,
it might very well be that it already did something for the L1
configuration here before Linux (with this patch) reconfigured them and
this is causing the problem.

@Thomas, is there any particular reason you have this option in the
command line? There is possibility that S3 is not even fully validated
if the system advertises S0 low power sleep instead.
