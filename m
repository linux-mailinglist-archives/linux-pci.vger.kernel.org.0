Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3397E2BB6
	for <lists+linux-pci@lfdr.de>; Mon,  6 Nov 2023 19:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbjKFSLO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Nov 2023 13:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjKFSLN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Nov 2023 13:11:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82611BF;
        Mon,  6 Nov 2023 10:11:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F45C433C8;
        Mon,  6 Nov 2023 18:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699294269;
        bh=IJldzK02pKtvHdTYGjPUcWOLj44vsNvgyn25M0XIeyM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=J2/3HeU/jbjGpzta7m1wAP1uDsrmqIp3AjuNgeBmUDq4Af905M05NrVtcOZtcn/mm
         BlmfFcAJdPeWa93i+mZXJtLqVOqQx6p7fiGygZp1WC3TfoGpIfaAS0HiogukoBq3S8
         jMWhVH3WNFdM4q/X112a1AGVmAsfWlKl5Pw+8Q+TVRtA4Y9rOHw6+36BZjFmuNt9C8
         JCbwT5JMpDjIRk5RWar/C9V2d1Y9Jf9k8zj2pXnFkgq+aPE5RHlZxV74VjUuEeC0Jt
         ItZUNDFdO5jMuIS2u9Sn31jYKI10T3Har4YvI79BTyZNgzJ8e1hb6ZovKWhqMoeIpw
         b4NOBs+VHBKOA==
Date:   Mon, 6 Nov 2023 12:11:07 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     vidyas@nvidia.com, bhelgaas@google.com,
        kai.heng.feng@canonical.com, andrea.righi@canonical.com,
        vicamo.yang@canonical.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
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
Message-ID: <20231106181107.GA255535@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <218aa81f-9c6-5929-578d-8dc15f83dd48@panix.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Mika, Sathy, Rafael, David, Ilpo, Ricky, Mario, linux-pci]

On Sat, Nov 04, 2023 at 10:13:24AM -0700, Kenneth R. Crudup wrote:
> 
> I have a Dell XPS-9320 with an Alderlake chipset, and the NVMe behind a
> VMD device:
> 
> ----
> [    0.127342] smpboot: CPU0: 12th Gen Intel(R) Core(TM) i7-1280P (family: 0x6, model: 0x9a, stepping: 0x3)
> ----
> 0000:00:0e.0 0104: 8086:467f
>         Subsystem: 1028:0af3
>         Flags: bus master, fast devsel, latency 0, IOMMU group 9
>         Memory at 603c000000 (64-bit, non-prefetchable) [size=32M]
>         Memory at 72000000 (32-bit, non-prefetchable) [size=32M]
> a7152be79b6        Memory at 6040100000 (64-bit, non-prefetchable) [size=1M]
>         Capabilities: <access denied>
>         Kernel driver in use: vmd
> ----
> 
> The only release kernel that was able to get this laptop to fully get into
> low-power (unfortunately only s0ix) was the Ubuntu-6.2.0- ... series from
> Ubuntu
> (remote git://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/lunar).
> 
> I'd bisected it to the following commits (in this order):
> 
> 4ff116d0d5fd PCI/ASPM: Save L1 PM Substates Capability for suspend/resume
> 5e85eba6f50d PCI/ASPM: Refactor L1 PM Substates Control Register programming
> 1a0102a08f20 UBUNTU: SAUCE: PCI/ASPM: Enable ASPM for links under VMD domain
> 47c7bfd31514 UBUNTU: SAUCE: PCI/ASPM: Enable LTR for endpoints behind VMD
> 154d48da2c57 UBUNTU: SAUCE: vmd: fixup bridge ASPM by driver name instead

Thanks for these.  You don't happen to have URLs for those Ubuntu
commits, do you?  E.g., https://git.kernel.org/linus/4ff116d0d5fd
(which was reverted by a7152be79b62 ("Revert "PCI/ASPM: Save L1 PM
Substates Capability for suspend/resume"")).

> Without the patches I never see Pkg%PC8 or higher(? lower?), nor i915 states
> DC5/6, all necssary for SYS%LPI/CPU%LPI. I've attached a little script I use
> alongside turbostat for verifying low-power operation (and also for seeing
> what chipset subsystem may be preventing it).
> 
> The first two are in Linus' trees, but were reverted (4ff116d0d5fd in
> a7152be79b6, 5e85eba6f50d in ff209ecc376a). The last three come from Ubuntu's
> Linux trees (see remote spec above). The first two remain reverted in the
> Ubuntu trees, but if I put them back, I get increased power savings during
> suspend/resume cycles.
> 
> Considering the power draw is really significant without these patches (10s
> of %s per hour) and I'd think Dell would have sold some decent number of
> these laptops, I'd been patiently waiting for these patches, or some variant
> to show up in the stable trees, but so far I'm up to the 6.6 stable kernel
> and still having to manually cherry-pick these, so I thought maybe I could
> bring this to the PM maintainers' attention so at least start a discussion
> about this issue.

Thank you very much for raising this again.  We really need to make
some progress, and Mika recently posted a patch to add the
4ff116d0d5fd functionality again:
https://lore.kernel.org/r/20231002070044.2299644-1-mika.westerberg@linux.intel.com

The big problem is that it works on *most* systems, but it still seems
to break a few.  So Mika's current patch relies on a denylist of
systems where we *don't* restore the substates.

It's possible we'll have to give in and use a denylist, but it's
obviously not ideal because (a) we don't know *why* it doesn't work on
those systems, and (b) it means substates work before suspend but not
after resume, which is a poor user experience.

Bjorn

> #!/bin/bash -e
> date
> egrep -Hr . /sys/class/drm/card0/power/rc6_residency_ms \
>  /sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us \
>  /sys/kernel/debug/pmc_core/package_cstate_show \
>  /sys/kernel/debug/pmc_core/slp_s0_residency_usec \
>  /sys/kernel/debug/dri/0/i915_edp_psr_status \
>  /sys/kernel/debug/dri/0/i915_dmc_info | tee -a ~/Dropbox/XPS-7390/sleep-params
> egrep '\(ns\): [^0]' /sys/kernel/debug/pmc_core/ltr_show | cut -d'	' -f1,3,4 | sed -e 's;[	][	]*; ;' | tee -a ~/Dropbox/XPS-7390/sleep-params
> egrep -Hr ": On" /sys/kernel/debug/pmc_core/pch_ip_power_gating_status | tee -a /dev/tty | tee -a ~/Dropbox/XPS-7390/sleep-params | wc -l
> egrep No /sys/kernel/debug/pmc_core/slp_s0_debug_status 2>/dev/null | tee -a ~/Dropbox/XPS-7390/sleep-params

