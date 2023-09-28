Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849887B11A6
	for <lists+linux-pci@lfdr.de>; Thu, 28 Sep 2023 06:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjI1Emk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Sep 2023 00:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1Emj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Sep 2023 00:42:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9B7121
        for <linux-pci@vger.kernel.org>; Wed, 27 Sep 2023 21:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695876157; x=1727412157;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=97XV/CRP5aIuqNvyzML6MfTx6/d7HwiUMaxjQQhuLrA=;
  b=ZMLENvQjMx/tgWsVnX5BdGvaT/G0Xoz1OVRA4Wrs1+2c5iUXHtKhF5uV
   KyuV0WzwJ12TcNWd4uBc4f0YlS3iL92Qqxg59syReA17nJ1HhVRmN4a1t
   e35H1kL+0Pe0cFuWlA8Xj3lBqhOYrPrBKm/yZEvSotKT35bC1ckBclgMc
   DJCeU81vPz9P7klPA2r/EbIVr8A4cjGbHh8kYF492NPiqyQXvuyZvVVeb
   bVKAfMoKWuaSLHDG1EcgH6QW79XZP7QlkhAGcBqVj+dvfbKueVt4KhZ4K
   GJUoHRTsTVsURXUINu74RL8mcBVUuXjkwna6sC2vf4C/RIynNoCRwHwoI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="380863998"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="380863998"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 21:42:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="815106641"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="815106641"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 27 Sep 2023 21:42:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 70046192; Thu, 28 Sep 2023 07:42:33 +0300 (EEST)
Date:   Thu, 28 Sep 2023 07:42:33 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lukas Wunner <lukas@wunner.de>, Kamil Paral <kparal@redhat.com>,
        linux-pci@vger.kernel.org, regressions@lists.linux.dev,
        bhelgaas@google.com, chris.chiu@canonical.com
Subject: Re: [REGRESSION] resume with a Thunderbolt dock broke with commit
 e8b908146d44 "PCI/PM: Increase wait time after resume"
Message-ID: <20230928044233.GR3208943@black.fi.intel.com>
References: <20230927180200.GQ3208943@black.fi.intel.com>
 <20230927194145.GA458987@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230927194145.GA458987@bhelgaas>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 27, 2023 at 02:41:45PM -0500, Bjorn Helgaas wrote:
> On Wed, Sep 27, 2023 at 09:02:00PM +0300, Mika Westerberg wrote:
> > On Wed, Sep 27, 2023 at 12:24:55PM -0500, Bjorn Helgaas wrote:
> > > On Wed, Sep 27, 2023 at 08:01:14PM +0300, Mika Westerberg wrote:
> > > > On Wed, Sep 27, 2023 at 11:50:36AM -0500, Bjorn Helgaas wrote:
> > > > ...
> 
> > > > > The hierarchy:
> > > > > 
> > > > >   pci 0000:00:1c.4: PCI bridge to [bus 04-3c]
> > > > >   pci 0000:04:00.0: PCI bridge to [bus 05-3c]
> > > > >   pci 0000:05:00.0: PCI bridge to [bus 06]
> > > > >   pci 0000:05:01.0: PCI bridge to [bus 07-3b]
> > > > > 
> > > > > It looks like we start the 06:00.0 resume first (118.9), but it
> > > > > doesn't complete until after the timeout (191.7):
> > > > > 
> > > > >   [  118.915870] thunderbolt 0000:06:00.0: control channel starting...
> > > > >   [  118.985530] pcieport 0000:05:01.0: Data Link Layer Link Active not set in 1000 msec
> > > > >   [  190.090902] pcieport 0000:05:01.0: pciehp: Slot(1): Card not present
> > > > >   [  191.754347] thunderbolt 0000:06:00.0: 1: DROM version: 1
> > > > >   [  191.762638] thunderbolt 0-1: new device found, vendor=0x108 device=0x1630
> > > > >   [  191.762641] thunderbolt 0-1: Lenovo ThinkPad Thunderbolt 3 Dock
> > > > >   [  191.943506] pcieport 0000:05:01.0: pciehp: Slot(1): Card present
> > > > > 
> > > > > Did the Thunderbolt driver do something to 06:00.0 that caused the
> > > > > 05:01.0 link to come up, or is the timing just coincidental?
> > > > 
> > > > Yes it sent the firmware a command telling that the driver is ready
> > > > again, then the firmware sends back notification that there is a new
> > > > device:
> > > > 
> > > > [  191.754347] thunderbolt 0000:06:00.0: 1: DROM version: 1
> > > > [  191.762638] thunderbolt 0-1: new device found, vendor=0x108 device=0x1630
> > > > [  191.762641] thunderbolt 0-1: Lenovo ThinkPad Thunderbolt 3 Dock
> > > > 
> > > > this then is send to the userspace via uevent where bolt goes and
> > > > authorizes it and this results the tunnel to be created which show in
> > > > the log as:
> > > > 
> > > > [  191.943506] pcieport 0000:05:01.0: pciehp: Slot(1): Card present
> > > 
> > > So the obvious next question is why we have to wait for the 05:01.0
> > > link timeout before sending the command to the 06:00.0 firmware, since
> > > there's no PCI connection between them.
> > 
> > No there is not - it is a PCIe tunnel.
> 
> You confirmed my assertion that in terms of the PCI topology, there is
> no connection between 05:01.0 and 06:00.0.
> 
> So the question remains: do we need to wait for the 05:01.0 link
> timeout before the 06:00.0 driver does something that leads to
> firmware starting the process of bringing up the tunnel and the link?

In the expected case this should not matter. It is the ACPI _PR0
resource that when turned on starts bringing up all the links.

It is enough for the firmware that we follow the delays in the PCIe spec.

In this case I think we don't need to wait for the link timeout.

> > > But there must be *some* connection between the 05:01.0 link coming up
> > > and the 06:00.0 behavior.  Maybe this is related to the
> > > nhi_resume_noirq() comment about "The tunneled pci bridges are
> > > siblings of us. Use resume_noirq to reenable the tunnels asap. A
> > > corresponding pci quirk blocks the downstream bridges resume_noirq
> > > until we are done." Unfortunately the comment doesn't mention the NAME
> > > of the quirk, so I lost the trail there.
> > > 
> > > Maybe there's an opportunity for a quirk that says "this Thunderbolt
> > > device should never need a whole second for the link to come up", for
> > > example.
> > 
> > The PCIe stack needs to follow PCIe spec (regardless of what is the
> > actual medium the packets go through). And regadless what we do here the
> > PCIe link goes down and that breaks the usage of any devices behind that
> > link such as mounted disks so the delay is definitely not the worst
> > thing that can happen.
> 
> Sure.  But if we resume in a reasonable time, we at least have the
> opportunity to notice what happened and warn about why the mounted
> disk broke.  That's way better than getting bug reports that say
> "resume is broken."

Well "resume is broken" is much better than "your precious eata just got
lost, have fun."

> > Now, If you read anything that Kamil said, this actually works now with
> > the "secure" mode when he turned the "Wake from Thunderbolt" option back
> > to the default. So now it works as expected but upon unplug there is the
> > issue that we fixed with the commit that marks the devices disconnected.
> > He will test that next week so we can be sure.
> 
> I did see that.  You may have also seen my sentiment that it's painful
> for users to diagnose an apparent resume failure and find a BIOS
> option to fix it.

Unfortunately todays systems are such that if you go and change BIOS
options from the defaults you may accidentally enter untested
territories. Changing things back to defaults is a reasonable ask IMHO.

> If we can't make resume work in a reasonable time, can we at least
> detect the case where it's going to take too long?  If so, maybe we
> can warn about it, avoid suspend, or change the way we do it.

Only thing we are missing now is the result of Kamil's testing to see if
the real uplug case is working. I would expect so, this is the issue we
fixed with:

  https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=pm&id=6786c2941fe1788035f99c98c932672138b3fbc5

If that's true then there is nothing more to be fixed, no hacks need to
be put anywhere, and this discussion can be ended too.
