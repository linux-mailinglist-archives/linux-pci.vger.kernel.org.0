Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04AE4182AF1
	for <lists+linux-pci@lfdr.de>; Thu, 12 Mar 2020 09:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgCLIPO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Mar 2020 04:15:14 -0400
Received: from mga02.intel.com ([134.134.136.20]:37152 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbgCLIPN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Mar 2020 04:15:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 01:15:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,544,1574150400"; 
   d="scan'208";a="354074748"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 12 Mar 2020 01:15:09 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 12 Mar 2020 10:15:09 +0200
Date:   Thu, 12 Mar 2020 10:15:09 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        "Shih-Yuan Lee (FourDollars)" <sylee@canonical.com>,
        Tiffany <tiffany.wang@canonical.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: Thunderbolt, direct-complete and long suspend/resume time of
 Suspend-to-idle
Message-ID: <20200312081509.GI2540@lahna.fi.intel.com>
References: <02700895-048F-4EA1-9E18-4883E83AE210@canonical.com>
 <20200311103840.GB2540@lahna.fi.intel.com>
 <E3DA71C8-96A7-482E-B41F-8145979F88F4@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E3DA71C8-96A7-482E-B41F-8145979F88F4@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 12, 2020 at 12:41:08PM +0800, Kai-Heng Feng wrote:
> 
> 
> > On Mar 11, 2020, at 18:38, Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> > 
> > On Wed, Mar 11, 2020 at 01:39:51PM +0800, Kai-Heng Feng wrote:
> >> Hi,
> >> 
> >> I am currently investigating long suspend and resume time of suspend-to-idle.
> >> It's because Thunderbolt bridges need to wait for 1100ms [1] for runtime-resume on system suspend, and also for system resume.
> >> 
> >> I made a quick hack to the USB driver and xHCI driver to support direct-complete, but I failed to do so for the parent PCIe bridge as it always disables the direct-complete [2], since device_may_wakeup() returns true for the device:
> >> 
> >> 	/* Avoid direct_complete to let wakeup_path propagate. */
> >> 		if (device_may_wakeup(dev) || dev->power.wakeup_path)
> >> 			dev->power.direct_complete = false;
> > 
> > You need to be careful here because otherwise you end up situation where
> > the link is not properly trained and we tear down the whole tree of
> > devices which is worse than waiting bit more for resume.
> 
> My idea is to direct-complete when there's no PCI or USB device
> plugged into the TBT, and use pm_reuqest_resume() in complete() so it
> won't block resume() or resume_noirq().

Before doing that..

> >> Once the direct-complete is disabled, system suspend/resume is used hence the delay in [1] is making the resume really slow. 
> >> So how do we make suspend-to-idle faster? I have some ideas but I am not sure if they are feasible:
> >> - Make PM core know the runtime_suspend() already use the same wakeup as suspend(), so it doesn't need to use device_may_wakeup() check to determine direct-complete.
> >> - Remove the DPM_FLAG_NEVER_SKIP flag in pcieport driver, and use pm_request_resume() in its complete() callback to prevent blocking the resume process.
> >> - Reduce the 1100ms delay. Maybe someone knows the values used in macOS and Windows...
> > 
> > Which system this is? ICL?
> 
> CML-H + Titan Ridge.

.. we should really understand this better because CML-H PCH root ports
and Titan/Alpine Ridge downstream ports all support active link
reporting so instead of the 1000+100ms you should see something like
this:

  1. Wait for the link + 100ms for the root port
  2. Wait for the link + 100ms for the Titan Ridge downstream ports
    (these are run paraller wrt all Titan Ridge downstream ports that have
     something connected)

If there is a TBT device connected then 2. is repeated for it and so on.

So the 1000ms+ is really unexpected. Are you running mainline kernel and
if so, can you share dmesg with CONFIG_PCI_DEBUG=y so we can see the
delays there? Maybe also add some debugging to
pcie_wait_for_link_delay() where it checks for the
!pdev->link_active_reporting and waits for 1100ms.
