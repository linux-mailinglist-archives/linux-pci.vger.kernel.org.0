Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D1F6CA060
	for <lists+linux-pci@lfdr.de>; Mon, 27 Mar 2023 11:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbjC0JnM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Mar 2023 05:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbjC0JnL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Mar 2023 05:43:11 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6B95B8F
        for <linux-pci@vger.kernel.org>; Mon, 27 Mar 2023 02:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679910162; x=1711446162;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=37SPK8wjFX7vtW2Uj752EJe7UH/ZiEIvpE+wLJ09O0I=;
  b=mFMFIYK58Hjs2koJKstRzcMA6rZcaRHCKIz9DgjfzTdhhglNtI0Xxf4k
   ShgVJMSGGZadh0Gc2HT2sMQHMVkIzU2jnHsZU4HAMD3HgIFtHGQ3mHvYg
   0MrxEh/s82e7ZQXIBqQSyWz+LC4FEuNaAgVEclvyQS/nKcdYnymDIAcFq
   /0wetxU/yOPfguXLKu7VY/qyN8Q1pPpGldpYS5zEbUpqzZfW0pbCeZU64
   ppu5ZFyvUp/Et63ExEA2T2o3jCixEDrLNnAWz5acH4OKxOQeQfHXo7nnZ
   gsJ7DScOoT1cQjgH4WMqNSed/2T/DwEAzG3ez3lpiw6iUDQlelFrUXr2s
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="402819336"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="402819336"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 02:42:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="857597013"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="857597013"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 27 Mar 2023 02:42:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id EE67380A; Mon, 27 Mar 2023 12:42:50 +0300 (EEST)
Date:   Mon, 27 Mar 2023 12:42:50 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>, oohall@gmail.com,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Sheng Bi <windy.bi.enflame@gmail.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Stanislav Spassov <stanspas@amazon.de>,
        Yang Su <yang.su@linux.alibaba.com>, shuo.tan@linux.alibaba.com
Subject: Re: [PATCH] PCI/PM: Wait longer after reset when active link
 reporting is supported
Message-ID: <20230327094250.GC33314@black.fi.intel.com>
References: <20230321095031.65709-1-mika.westerberg@linux.intel.com>
 <20230322221624.GA2497123@bhelgaas>
 <20230326062207.GA14559@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230326062207.GA14559@wunner.de>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Sun, Mar 26, 2023 at 08:22:07AM +0200, Lukas Wunner wrote:
> [cc += Ashok, Sathya, Ravi Kishore, Sheng Bi, Stanislav, Yang Su, Shuo Tan]
> 
> On Wed, Mar 22, 2023 at 05:16:24PM -0500, Bjorn Helgaas wrote:
> > On Tue, Mar 21, 2023 at 11:50:31AM +0200, Mika Westerberg wrote:
> > > The PCIe spec prescribes that a device may take up to 1 second to
> > > recover from reset and this same delay is prescribed when coming out of
> > > D3cold (as that involves reset too). The device may extend this 1 second
> > > delay through Request Retry Status completions and we accommondate for
> > > that in Linux with 60 second cap, only in reset code path, not in resume
> > > code path.
> > > 
> > > However, a device has surfaced, namely Intel Titan Ridge xHCI, which
> > > requires longer delay also in the resume code path. For this reason make
> > > the resume code path to use this same extended delay than with the reset
> > > path but only after the link has come up (active link reporting is
> > > supported) so that we do not wait longer time for devices that have
> > > become permanently innaccessible during system sleep, e.g because they
> > > have been removed.
> > > 
> > > While there move the two constants from the pci.h header into pci.c as
> > > these are not used outside of that file anymore.
> > > 
> > > Reported-by: Chris Chiu <chris.chiu@canonical.com>
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=216728
> > > Cc: Lukas Wunner <lukas@wunner.de>
> > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > 
> > Lukas just added the "timeout" parameter with ac91e6980563 ("PCI:
> > Unify delay handling for reset and resume"), so I'm going to look for
> > his ack for this.
> 
> Acked-by: Lukas Wunner <lukas@wunner.de>
> 
> 
> > After ac91e6980563, we called pci_bridge_wait_for_secondary_bus() with
> > timeouts of either:
> > 
> >   60s for reset (pci_bridge_secondary_bus_reset() or
> >       dpc_reset_link()), or
> > 
> >    1s for resume (pci_pm_resume_noirq() or pci_pm_runtime_resume() via
> >       pci_pm_bridge_power_up_actions())
> > 
> > If I'm reading this right, the main changes of this patch are:
> > 
> >   - For slow links (<= 5 GT/s), we sleep 100ms, then previously waited
> >     up to 1s (resume) or 60s (reset) for the device to be ready.  Now
> >     we will wait a max of 1s for both resume and reset.
> > 
> >   - For fast links (> 5 GT/s) we wait up to 100ms for the link to come
> >     up and fail if it does not.  If the link did come up in 100ms, we
> >     previously waited up to 1s (resume) or 60s (reset).  Now we will
> >     wait up to 60s for both resume and reset.
> > 
> > So this *reduces* the time we wait for slow links after reset, and
> > *increases* the time for fast links after resume.  Right?
> 
> Good point.  So now the wait duration hinges on the link speed
> rather than reset versus resume.
> 
> Before ac91e6980563 (which went into v6.3-rc1), the wait duration
> after a Secondary Bus Reset and a DPC-induced Hot Reset was
> essentially zero.  And the Ponte Vecchio cards which necessitated
> ac91e6980563 are usually plugged into servers whose Root Ports
> support link speeds > 5 GT/s.  So the risk of breaking anything
> with this change seems small.
> 
> The reason why Mika is waiting only 1 second in the <= 5 GT/s case
> is that we don't check for the link to become active for these slower
> link speeds.  That's because Link Active Reporting is only mandatory
> if the port is hotplug-capable or supports link speeds > 5 GT/s.
> Otherwise it's optional (PCIe r6.0.1 sec 7.5.3.6).
> 
> It would be user-unfriendly to pause for 60 sec if the device does
> not come back after reset or resume (e.g. because it was removed)
> and the fact that the link is up is an indication that the device
> is present, but may just need a little more time to respond to
> Configuration Space Requests.
> 
> We *could* afford the longer wait duration in the <= 5 GT/s case
> as well by checking if Link Active Reporting is supported and further
> checking if the link came up after the 100 ms delay prescribed by
> PCIe r6.0 sec 6.6.1.  Should Link Active Reporting *not* be supported,
> we'd have to retain the shorter wait duration limit of 1 sec.
> 
> This optimization opportunity for the <= 5 GT/s case does not have
> to be addressed in this patch.  It could be added later on if it
> turns out that users do plug cards such as Ponte Vecchio into older
> Gen1/Gen2 Downstream Ports.  (Unless Mika wants to perfect it right
> now.)
> 

No problem doing that :) I guess you mean something like the diff below,
so that we use active link reporting and the longer time also for any
downstream port that supports supports it, regardless of the speed.

I can update the patch accordingly.

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 36d4aaa8cea2..b507a26ffb9d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5027,7 +5027,8 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 	if (!pcie_downstream_port(dev))
 		return 0;
 
-	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
+	if (!dev->link_active_reporting &&
+	    pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
 		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
 		msleep(delay);
 		return pci_dev_wait(child, reset_type, PCI_RESET_WAIT - delay);
