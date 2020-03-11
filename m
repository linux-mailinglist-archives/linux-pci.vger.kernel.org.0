Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5DFF1815FF
	for <lists+linux-pci@lfdr.de>; Wed, 11 Mar 2020 11:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgCKKip (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 06:38:45 -0400
Received: from mga09.intel.com ([134.134.136.24]:10049 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbgCKKip (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Mar 2020 06:38:45 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 03:38:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,540,1574150400"; 
   d="scan'208";a="353857634"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 11 Mar 2020 03:38:41 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 11 Mar 2020 12:38:40 +0200
Date:   Wed, 11 Mar 2020 12:38:40 +0200
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
Message-ID: <20200311103840.GB2540@lahna.fi.intel.com>
References: <02700895-048F-4EA1-9E18-4883E83AE210@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02700895-048F-4EA1-9E18-4883E83AE210@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 11, 2020 at 01:39:51PM +0800, Kai-Heng Feng wrote:
> Hi,
> 
> I am currently investigating long suspend and resume time of suspend-to-idle.
> It's because Thunderbolt bridges need to wait for 1100ms [1] for runtime-resume on system suspend, and also for system resume.
> 
> I made a quick hack to the USB driver and xHCI driver to support direct-complete, but I failed to do so for the parent PCIe bridge as it always disables the direct-complete [2], since device_may_wakeup() returns true for the device:
> 
> 	/* Avoid direct_complete to let wakeup_path propagate. */
> 		if (device_may_wakeup(dev) || dev->power.wakeup_path)
> 			dev->power.direct_complete = false;

You need to be careful here because otherwise you end up situation where
the link is not properly trained and we tear down the whole tree of
devices which is worse than waiting bit more for resume.

> Once the direct-complete is disabled, system suspend/resume is used hence the delay in [1] is making the resume really slow. 
> So how do we make suspend-to-idle faster? I have some ideas but I am not sure if they are feasible:
> - Make PM core know the runtime_suspend() already use the same wakeup as suspend(), so it doesn't need to use device_may_wakeup() check to determine direct-complete.
> - Remove the DPM_FLAG_NEVER_SKIP flag in pcieport driver, and use pm_request_resume() in its complete() callback to prevent blocking the resume process.
> - Reduce the 1100ms delay. Maybe someone knows the values used in macOS and Windows...

Which system this is? ICL? I think it is the TBT root ports only that do
not support active link reporting. The PCIe spec is not entirely clear
about root ports since it explictly mentions only downstream ports so
one option would be to check for root port and that it supports gen 3
speeds and based on that wait for max say 2 * 100ms or something like
that.
