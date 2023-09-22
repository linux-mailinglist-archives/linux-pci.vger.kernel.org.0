Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EA07AA7EC
	for <lists+linux-pci@lfdr.de>; Fri, 22 Sep 2023 06:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjIVEmt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Sep 2023 00:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjIVEmr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Sep 2023 00:42:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A680118F
        for <linux-pci@vger.kernel.org>; Thu, 21 Sep 2023 21:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695357761; x=1726893761;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ET83e11hSHklmgq3aFm6Lep2UYCeR3kRLFkDHJ7ZAqs=;
  b=DX7OpHxNVpyBwT62E8hFBbx1BHVxbf/WN6WSIjRoYRIgQuKSo8/QoVK5
   G2YmR3Div+64iWq6m61twQNoikC1l2HQxUhON24eEpWrtoO4WNcZajRAl
   56aq08NWhirezJgB9KZO9rTqOAiPXXX8o2AEbBX4ibvxhrYt07BKeOVqy
   Vrvn2E1dDTUxVrVrOgJiSaMmfH7M0Zq3L/QrX8SGTqI9O4Il8CglWcion
   9QyMjKJ3Re+pkPfLTbDTUEh7y8ZDtXr8Ne2jSi4Xr2eQodw6i5C85mKDT
   QgfINbzGSM4KeqYD91KCD8XdchAHvbdHSuk1S1g+GXpSO8tON7GmZ3jWt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="360991977"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="360991977"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 21:42:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="740962975"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="740962975"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 21 Sep 2023 21:42:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id D2FB57D0; Fri, 22 Sep 2023 07:42:37 +0300 (EEST)
Date:   Fri, 22 Sep 2023 07:42:37 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mark Blakeney <mark.blakeney@bullet-systems.net>,
        Kamil Paral <kparal@redhat.com>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Mark devices disconnected if their upstream PCIe
 link is down on resume
Message-ID: <20230922044237.GC3208943@black.fi.intel.com>
References: <20230918053041.1018876-1-mika.westerberg@linux.intel.com>
 <20230921201945.GA343804@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230921201945.GA343804@bhelgaas>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Thu, Sep 21, 2023 at 03:19:45PM -0500, Bjorn Helgaas wrote:
> [+cc Kamil, Chris]
> 
> On Mon, Sep 18, 2023 at 08:30:41AM +0300, Mika Westerberg wrote:
> > Mark Blakeney reported that when suspending system with a Thunderbolt
> > dock connected and then unplugging the dock before resume (which is
> > pretty normal flow with laptops), resuming takes long time.
> > 
> > What happens is that the PCIe link from the root port to the PCIe switch
> > inside the Thunderbolt device does not train (as expected, the link is
> > upplugged):
> > 
> > [   34.903158] pcieport 0000:00:07.2: restoring config space at offset 0x24 (was 0x3bf12001, writing 0x3bf12001)
> > [   34.903231] pcieport 0000:00:07.0: waiting 100 ms for downstream link
> > [   36.140616] pcieport 0000:01:00.0: not ready 1023ms after resume; giving up
> > 
> > However, at this point we still try the resume the devices below that
> > unplugged link:
> > 
> > [   36.140741] pcieport 0000:01:00.0: Unable to change power state from D3cold to D0, device inaccessible
> > ...
> > [   36.142235] pcieport 0000:01:00.0: restoring config space at offset 0x38 (was 0xffffffff, writing 0x0)
> > ...
> > [   36.144702] pcieport 0000:02:02.0: waiting 100 ms for downstream link, after activation
> > 
> > And this is the link from PCIe switch downstream port to the xHCI on the
> > dock:
> > 
> > [   38.380618] xhci_hcd 0000:03:00.0: not ready 1023ms after resume; waiting
> > [   39.420587] xhci_hcd 0000:03:00.0: not ready 2047ms after resume; waiting
> > [   41.527250] xhci_hcd 0000:03:00.0: not ready 4095ms after resume; waiting
> > [   45.793957] xhci_hcd 0000:03:00.0: not ready 8191ms after resume; waiting
> > [   54.113950] xhci_hcd 0000:03:00.0: not ready 16383ms after resume; waiting
> > [   71.180576] xhci_hcd 0000:03:00.0: not ready 32767ms after resume; waiting
> > ...
> > [  105.313963] xhci_hcd 0000:03:00.0: not ready 65535ms after resume; giving up
> > [  105.314037] xhci_hcd 0000:03:00.0: Unable to change power state from D3cold to D0, device inaccessible
> > [  105.315640] xhci_hcd 0000:03:00.0: restoring config space at offset 0x3c (was 0xffffffff, writing 0x1ff)
> > ...
> > 
> > This ends up slowing down the resume time considerably. For this reason
> > mark these devices as disconnected if the link above them did not train
> > properly.
> > 
> > Fixes: e8b908146d44 ("PCI/PM: Increase wait time after resume")
> > Reported-by: Mark Blakeney <mark.blakeney@bullet-systems.net>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217915
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Applied with Lukas' Reviewed-by to pm for v6.7.

Thanks!

> e8b908146d44 appeared in v6.4.  Seems like maybe a candidate for
> stable?  IIUC, resume actually does work, but takes 65+ seconds longer
> than it should?

Yes, I think it should be tagged for stable.

> Kamil also bisected a 60+ second resume delay to e8b908146d44
> (https://lore.kernel.org/r/CA+cBOTeWrsTyANjLZQ=bGoBQ_yOkkV1juyRvJq-C8GOrbW6t9Q@mail.gmail.com),
> but IIUC at
> https://lore.kernel.org/linux-pci/20230824114300.GU3465@black.fi.intel.com/T/#u
> you concluded that Kamil's issue was related to firmware and actually
> had nothing to do with e8b908146d44.
> 
> Do you still think Kamil's issue is unrelated to e8b908146d44 and this
> patch?  If so, how do we handle Kamil's issue?  An answer like "users
> of v6.4+ must upgrade their Thunderbolt firmware" seems like it would
> be kind of a nightmare for users.

It's a different issue. What happens in his system is that the link went
down even though the dock was still connected and this should not happen
(the firmware should bring the link up during resume). The delay was
just a "symptom".

What happen here is that the user suspends the device and deliberately
disconnects the dock.
