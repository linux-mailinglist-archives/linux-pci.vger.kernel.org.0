Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DD16C63E0
	for <lists+linux-pci@lfdr.de>; Thu, 23 Mar 2023 10:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjCWJl0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Mar 2023 05:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjCWJlE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Mar 2023 05:41:04 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68E6136EF
        for <linux-pci@vger.kernel.org>; Thu, 23 Mar 2023 02:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679564459; x=1711100459;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dCKArEhcC0MggZnRspDk6KLOgA5ibfdP4YXqTtmrbIk=;
  b=j8ZHBU56BDv98o91u60owN6mpRzAZqj83K8mJxnG5PMAv/1Ovpa8k60t
   R/e4K8t2Z5e49qFznT79XTQCtrniUb3Rx+TjmGIGlwRhTvRCcbnqqHOdF
   X/s/CWY4EfbJiL7VvNjRX9+EQ0P5aDEbAgZo8WWpIyyfzgBbQNlZowpT2
   x+Sv9ta9OyZxdzGSBGb3PioRJ04A+cKLCKe2OV5GLmQyxIfLzEZL2mbHL
   Y1j1B4JG5/1uhYzIsYVUi982C11NnrKHujsUW+jVKBSowUSVEZu4uHFzz
   /65KiMZvIUV5b4UBsnylLMI2rGpHgbkerRNwEY60NlzKtbeu1ExzyIF13
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="336947361"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="336947361"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 02:40:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="928155343"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="928155343"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 23 Mar 2023 02:40:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id C75571CC; Thu, 23 Mar 2023 11:41:43 +0200 (EET)
Date:   Thu, 23 Mar 2023 11:41:43 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>, oohall@gmail.com,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Wait longer after reset when active link
 reporting is supported
Message-ID: <20230323094143.GF62143@black.fi.intel.com>
References: <20230321095031.65709-1-mika.westerberg@linux.intel.com>
 <20230322221624.GA2497123@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230322221624.GA2497123@bhelgaas>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Wed, Mar 22, 2023 at 05:16:24PM -0500, Bjorn Helgaas wrote:
> On Tue, Mar 21, 2023 at 11:50:31AM +0200, Mika Westerberg wrote:
> > The PCIe spec prescribes that a device may take up to 1 second to
> > recover from reset and this same delay is prescribed when coming out of
> > D3cold (as that involves reset too). The device may extend this 1 second
> > delay through Request Retry Status completions and we accommondate for
> > that in Linux with 60 second cap, only in reset code path, not in resume
> > code path.
> > 
> > However, a device has surfaced, namely Intel Titan Ridge xHCI, which
> > requires longer delay also in the resume code path. For this reason make
> > the resume code path to use this same extended delay than with the reset
> > path but only after the link has come up (active link reporting is
> > supported) so that we do not wait longer time for devices that have
> > become permanently innaccessible during system sleep, e.g because they
> > have been removed.
> > 
> > While there move the two constants from the pci.h header into pci.c as
> > these are not used outside of that file anymore.
> > 
> > Reported-by: Chris Chiu <chris.chiu@canonical.com>
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=216728
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Lukas just added the "timeout" parameter with ac91e6980563 ("PCI:
> Unify delay handling for reset and resume"), so I'm going to look for
> his ack for this.

Of course :)

> After ac91e6980563, we called pci_bridge_wait_for_secondary_bus() with
> timeouts of either:
> 
>   60s for reset (pci_bridge_secondary_bus_reset() or
>       dpc_reset_link()), or
> 
>    1s for resume (pci_pm_resume_noirq() or pci_pm_runtime_resume() via
>       pci_pm_bridge_power_up_actions())
> 
> If I'm reading this right, the main changes of this patch are:
> 
>   - For slow links (<= 5 GT/s), we sleep 100ms, then previously waited
>     up to 1s (resume) or 60s (reset) for the device to be ready.  Now
>     we will wait a max of 1s for both resume and reset.
> 
>   - For fast links (> 5 GT/s) we wait up to 100ms for the link to come
>     up and fail if it does not.  If the link did come up in 100ms, we
>     previously waited up to 1s (resume) or 60s (reset).  Now we will
>     wait up to 60s for both resume and reset.
> 
> So this *reduces* the time we wait for slow links after reset, and
> *increases* the time for fast links after resume.  Right?

Yes, this is correct.
