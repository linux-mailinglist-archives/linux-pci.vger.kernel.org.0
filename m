Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497BA7BF205
	for <lists+linux-pci@lfdr.de>; Tue, 10 Oct 2023 06:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjJJEyA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Oct 2023 00:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjJJEyA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 00:54:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBF9A3
        for <linux-pci@vger.kernel.org>; Mon,  9 Oct 2023 21:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696913638; x=1728449638;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wSGfKvmcRZUXdFABeFJoTnooWu6jUcs1b5kd5POAY8A=;
  b=mx3fN1g7ldZcjrbDgMF0gomnXUMl8oDj8BQYl7F/qNtQ3p1HcP/nShL5
   G1ESm3+/4tHgrYGmh49BpaAWfPYaDfZQdaWC0b0wvQJgg2++YLiYlDFfs
   CeJPFdash0+OLtFwL6ZO6cLwda/6MqpFoOsOP99IeQPM/Vi3z4/o1a5Lk
   5hyIECCv1+P1AWMaHtu8M3gMIaSJc4TmATmBRXZjd6dfWJoLa8lKXsSqo
   V2iR0AHFwQd03m3y8SVTGg2LVU8WKQIammPcpraCdJh6D6XQj+MdwemGb
   mRh191430ZbJIRB5eIALPFZiVmZp1M3nl8LC/0CPht+rH2cEc6u6tFFpf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="364603527"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="364603527"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 21:53:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="843976252"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="843976252"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Oct 2023 21:53:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id ABF7D128; Tue, 10 Oct 2023 07:53:52 +0300 (EEST)
Date:   Tue, 10 Oct 2023 07:53:52 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Witt <kernel@witt.link>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Tasev Nikola <tasev.stefanoska@skynet.be>,
        Mark Enriquez <enriquezmark36@gmail.com>,
        Koba Ko <koba.ko@canonical.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        =?utf-8?B?5ZCz5piK5r6E?= Ricky <ricky_wu@realtek.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v4] PCI/ASPM: Add back L1 PM Substate save and restore
Message-ID: <20231010045352.GH3208943@black.fi.intel.com>
References: <20231009083434.GD3208943@black.fi.intel.com>
 <20231009163421.GA938492@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009163421.GA938492@bhelgaas>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 09, 2023 at 11:34:21AM -0500, Bjorn Helgaas wrote:
> On Mon, Oct 09, 2023 at 11:34:34AM +0300, Mika Westerberg wrote:
> > On Thu, Oct 05, 2023 at 12:22:26PM -0500, Bjorn Helgaas wrote:
> > > On Thu, Oct 05, 2023 at 05:57:52PM +0200, Thomas Witt wrote:
> > > > On 05/10/2023 17:30, Bjorn Helgaas wrote:
> > > > ...
> > > 
> > > > > Right, without the denylist, I expect Thomas' TUXEDO to fail,
> > > > > but I still hope we can figure out why.  If we just keep it on
> > > > > the denylist, that system will suffer from more power
> > > > > consumption than necessary, but only after suspend/resume.
> > > > > 
> > > > > A denylist seems like the absolute last resort.  In this case
> > > > > we don't know about anything *wrong* with those platforms; all
> > > > > we know is that our resume path doesn't work.  It's likely
> > > > > that it fails on other platforms we haven't heard about, too.
> > > > 
> > > > The best guess from Mika and David was a firmware issue, but I
> > > > run the same Firmware revision as Werner. I even reflashed the
> > > > Firmware, but that did not change anything:
> > > 
> > > Possibly a BIOS settings difference?
> > > 
> > > > Quoting David Box:
> > > > > I agree that we should pursue an exception for your system.
> > > > > This is looking like a firmware bug. One thing we did notice
> > > > > in the turbostat results is your IRTL (Interrupt Response Time
> > > > > Limit) values are bogus:
> > > > >
> > > > > cpu6: MSR_PKGC3_IRTL: 0x0000884e (valid, 79872 ns)
> > > > > cpu6: MSR_PKGC6_IRTL: 0x00008000 (valid, 0 ns)
> > > > > cpu6: MSR_PKGC7_IRTL: 0x00008000 (valid, 0 ns)
> > > > > cpu6: MSR_PKGC8_IRTL: 0x00008000 (valid, 0 ns)
> > > > > cpu6: MSR_PKGC9_IRTL: 0x00008000 (valid, 0 ns)
> > > > > cpu6: MSR_PKGC10_IRTL: 0x00008000 (valid, 0 ns)
> > > > >
> > > > > This is despite the PKGC configuration register showing that all
> > > > > states are enabled:
> > > > >
> > > > > cpu6: MSR_PKG_CST_CONFIG_CONTROL: 0x1e008008 (UNdemote-C3, UNdemote-C1,
> > > > demote-
> > > > C3, demote-C1, locked, pkg-cstate-limit=8 (unlimited))
> > > > >
> > > > > Firmware sets this.
> > > 
> > > I can't find this discussion, but if there's a firmware issue related
> > > to IRTL MSRs, I would want the workaround in intel-idle.c or whatever
> > > code deals with the MSRs, not in the ASPM code.
> > 
> > Unfortunately that discussion never ended up on the mailing list. But in
> > summary that particular system seems to run pretty hot (if I understand
> > correctly what David concluded). This is the reason Thomas has the
> > pm_sleep=deep in the command line and this is why the L1 SS restore then
> > causes the failure on resume. Without this it works fine but consumes
> > lot of energy in s2idle.
> > 
> > Can you suggest what we should do with this now?
> >
> > We got report from Tasev Nikola on
> > https://bugzilla.kernel.org/show_bug.cgi?id=216782 that even if the Asus
> > system is removed from the denylist it works so that we can do. However,
> > with the Thomas' system I'm not sure. If we leave it like this:
> > 
> > static int aspm_l1ss_suspend_via_firmware(const struct dmi_system_id *not_used)
> > {
> >         return pm_suspend_via_firmware();
> > }
> > 
> > static const struct dmi_system_id aspm_l1ss_denylist[] = {
> >         {
> >                 /*
> >                  * https://bugzilla.kernel.org/show_bug.cgi?id=216877
> >                  *
> >                  * This system needs to use suspend to mem instead of its 
> >                  * default (suspend to idle) to avoid draining the battery. 
> >                  * However, the BIOS gets confused if we try to restore the
> >                  * L1SS registers so avoid doing that if the user forced
> >                  * suspend to mem. The default suspend to idle on the other
> >                  * hand needs restoring L1SS to allow the CPU to enter low
> >                  * power states. This entry should handle both.
> >                  */
> >                 .callback = aspm_l1ss_suspend_via_firmware,
> >                 .ident = "TUXEDO InfinityBook S 14 v5",
> >                 .matches = {
> >                         DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> >                         DMI_MATCH(DMI_BOARD_NAME, "L140CU"),
> >                 },
> >         },
> >         { }
> > };
> > 
> > Then it should work with Thomas' system (defaults to deep), and TUXEDO
> > with default settings (defaults to s2idle), and with the rest of the
> > world (I hope at least, fingers crossed). Or you want to pursue a
> > solution without the denylist still? I'm out of ideas what could be
> > wrong except that when the pm_sleep=deep it means the BIOS is involved
> > in the suspend/restore of the devices and it may not expect the OS to
> > touch these registers or something along those lines.
> 
> [I think this refers to "mem_sleep_default=deep" (not pm_sleep)]

Yes.

> I assume everything was fine before suspend, and it only runs hot
> after resume.  And the platform granted control of the PCIe Capability
> and the LTR Capability to OSPM via _OSC?

As David commented already it runs hot even before suspend. The platform
did give LTR capability to the OS:

Jan 02 14:17:52 localhost kernel: acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
Jan 02 14:17:52 localhost kernel: acpi PNP0A08:00: _OSC: OS now controls [PME PCIeCapability LTR]
