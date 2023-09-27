Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84C17B0B94
	for <lists+linux-pci@lfdr.de>; Wed, 27 Sep 2023 20:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjI0SCH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Sep 2023 14:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjI0SCG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Sep 2023 14:02:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11F2B4
        for <linux-pci@vger.kernel.org>; Wed, 27 Sep 2023 11:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695837724; x=1727373724;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hHsXtYJYbGMBzqMcwOwqnjO2lOpeB+xlM/cM3hDaKig=;
  b=YhCAwujh+L2VPKgGKEEcgHvYL/wSUc5hRrtLlb+KNJ31PBBzBEUNOJJg
   QXv+6/WyQlEk1Vi9IF+by9cwZWQmAuPQQFYpIDwFx9Dvwh35QLdtDgCNc
   u4B7zNH+KLQKwwSD/h2dN/4wEEEMPeCbZTClPLr6EPkVKH25rr0dXO7TD
   6v1qeap4dNYv76cetEBecjAcrZsCXHGhVxFC+NdKgKgziqxDwOEj3j+L/
   N+xzUPQyQ2SGJPP0yVzcZcDxpf3efKmnHgLAzJh7RvTWYnB9ZMkYFEzRp
   afQFma7B3GcgaM4ACLCUUSgMQRHhon3jGr2xIk/UpDwP0pNjUAT4+K5aS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="381798902"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="381798902"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 11:02:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="749313990"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="749313990"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 27 Sep 2023 11:02:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id B653B177; Wed, 27 Sep 2023 21:02:00 +0300 (EEST)
Date:   Wed, 27 Sep 2023 21:02:00 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lukas Wunner <lukas@wunner.de>, Kamil Paral <kparal@redhat.com>,
        linux-pci@vger.kernel.org, regressions@lists.linux.dev,
        bhelgaas@google.com, chris.chiu@canonical.com
Subject: Re: [REGRESSION] resume with a Thunderbolt dock broke with commit
 e8b908146d44 "PCI/PM: Increase wait time after resume"
Message-ID: <20230927180200.GQ3208943@black.fi.intel.com>
References: <20230927170114.GP3208943@black.fi.intel.com>
 <20230927172455.GA455882@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230927172455.GA455882@bhelgaas>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 27, 2023 at 12:24:55PM -0500, Bjorn Helgaas wrote:
> On Wed, Sep 27, 2023 at 08:01:14PM +0300, Mika Westerberg wrote:
> > On Wed, Sep 27, 2023 at 11:50:36AM -0500, Bjorn Helgaas wrote:
> > > On Wed, Sep 27, 2023 at 03:47:32PM +0300, Mika Westerberg wrote:
> > > > On Wed, Sep 27, 2023 at 06:57:03AM -0500, Bjorn Helgaas wrote:
> > > > > On Wed, Sep 27, 2023 at 08:16:02AM +0300, Mika Westerberg wrote:
> > > > > > On Tue, Sep 26, 2023 at 12:55:30PM -0500, Bjorn Helgaas wrote:
> > > > > > > On Mon, Sep 25, 2023 at 04:19:30PM +0200, Lukas Wunner wrote:
> > > > > > > > On Mon, Sep 25, 2023 at 08:48:41AM -0500, Bjorn Helgaas wrote:
> > > > > > > > > Now pciehp thinks the slot is occupied and the link is up, so we
> > > > > > > > > re-enumerate the hierarchy.  Is this because thunderbolt did something
> > > > > > > > > to 06:00.0 that made the link from 05:01.0 come up?
> > > > > > > > 
> > > > > > > > PCIe TLPs are encapsulated into Thunderbolt packets and transmitted
> > > > > > > > alongside DisplayPort and other data over the same physical link.
> > > > > > > > 
> > > > > > > > For this to work, PCIe tunnels need to be set up between the Thunderbolt
> > > > > > > > host controller and attached devices.  Once a tunnel is established,
> > > > > > > > the PCIe link magically goes up and TLPs can be transmitted.
> > > > > > > > 
> > > > > > > > There are two ways to establish those tunnels:
> > > > > > > > 
> > > > > > > > 1/ By a firmware in the Thunderbolt host controller.
> > > > > > > >    (firmware or "internal" connection manager, drivers/thunderbolt/icm.c)
> > > > > > > > 
> > > > > > > > 2/ Natively by the kernel.
> > > > > > > >    (software connection manager)
> > > > > > > > 
> > > > > > > > I'm assuming that the laptop in question exclusively uses the firmware
> > > > > > > > connection manager, hence the kernel is reliant on that firmware to
> > > > > > > > establish tunnels and can't really do anything if it fails to do so.
> > > > > > > 
> > > > > > > Thanks for the background; that improves my meager understanding a
> > > > > > > lot.
> > > > > > > 
> > > > > > > Since this seems to be a firmware issue, it does sound like this
> > > > > > > laptop uses a firmware connection manager.  But there still seems to
> > > > > > > be some kernel connection because pre-e8b908146d44, the link came up
> > > > > > > in <5 seconds, and after the minor e8b908146d44 change, it takes >60
> > > > > > > seconds.
> > > > > > 
> > > > > > In both cases (with or without) the commit what happens is that after
> > > > > > resume is finished the firmware connection manager notices the
> > > > > > connection, announces it to the Thunderbolt driver that exposes it to
> > > > > > the userspace where boltd re-authorizes the device. This brings up the
> > > > > > PCIe tunnel again and things get working.
> > > > > > 
> > > > > > (What is expected to happen is that during the resume the firmware
> > > > > >  connection manager re-connects the PCIe tunnel.)
> > > > > > 
> > > > > > This took previously the ~5s before resume is complete so that the above
> > > > > > steps can happen where as after the commit it got delayed more up to the
> > > > > > arbitrary ~60s because we started to use that with the commit
> > > > > > e8b908146d44 (PCIE_RESET_READY_POLL_MS).
> > > > > 
> > > > > Why does the kernel delay affect the timing of when the firmware
> > > > > connection manager notices the connection?  It seems like Linux waits
> > > > > for the timeout, then Linux does something that kicks the firmware
> > > > > connection manager.  That's why I asked about this sequence:
> > > > > 
> > > > >   [  118.985530] pcieport 0000:05:01.0: Data Link Layer Link Active not set in 1000 msec
> > > > >   [  190.090902] pcieport 0000:05:01.0: pciehp: Slot(1): Card not present
> > > > >   [  191.754347] thunderbolt 0000:06:00.0: 1: DROM version: 1
> > > > >   [  191.762638] thunderbolt 0-1: new device found, vendor=0x108 device=0x1630
> > > > >   [  191.762641] thunderbolt 0-1: Lenovo ThinkPad Thunderbolt 3 Dock
> > > > >   [  191.943506] pcieport 0000:05:01.0: pciehp: Slot(1): Card present
> > > > > 
> > > > > where we wait for the timeout, decide the device is gone, remove
> > > > > everything, and then the thunderbolt driver does something, and we
> > > > > notice the device is magically back.
> > > > 
> > > > Well the delay delays the whole resume and this includes Thunderbolt
> > > > driver resume too, and userspace (where the bolt daemon authorizes the
> > > > device again).
> > > 
> > > I don't know how the Thunderbolt driver works.  I assume this refers
> > > to "thunderbolt 0000:06:00.0"?  Is the 06:00.0 resume related to the
> > > firmware connection manager somehow?
> > > 
> > > The removal affects the sub-hierarchy below 05:01.0 (bus 07-3b).
> > > 06:00.0 is below 05:00.0, so it's in a different sub-hierarchy.  I
> > > don't think there's a PCIe requirement that 05:01.0 be resumed before
> > > 05:00.0, or even that they be serialized at all.
> > > 
> > > The hierarchy:
> > > 
> > >   pci 0000:00:1c.4: PCI bridge to [bus 04-3c]
> > >   pci 0000:04:00.0: PCI bridge to [bus 05-3c]
> > >   pci 0000:05:00.0: PCI bridge to [bus 06]
> > >   pci 0000:05:01.0: PCI bridge to [bus 07-3b]
> > > 
> > > It looks like we start the 06:00.0 resume first (118.9), but it
> > > doesn't complete until after the timeout (191.7):
> > > 
> > >   [  118.915870] thunderbolt 0000:06:00.0: control channel starting...
> > >   [  118.985530] pcieport 0000:05:01.0: Data Link Layer Link Active not set in 1000 msec
> > >   [  190.090902] pcieport 0000:05:01.0: pciehp: Slot(1): Card not present
> > >   [  191.754347] thunderbolt 0000:06:00.0: 1: DROM version: 1
> > >   [  191.762638] thunderbolt 0-1: new device found, vendor=0x108 device=0x1630
> > >   [  191.762641] thunderbolt 0-1: Lenovo ThinkPad Thunderbolt 3 Dock
> > >   [  191.943506] pcieport 0000:05:01.0: pciehp: Slot(1): Card present
> > > 
> > > Did the Thunderbolt driver do something to 06:00.0 that caused the
> > > 05:01.0 link to come up, or is the timing just coincidental?
> > 
> > Yes it sent the firmware a command telling that the driver is ready
> > again, then the firmware sends back notification that there is a new
> > device:
> > 
> > [  191.754347] thunderbolt 0000:06:00.0: 1: DROM version: 1
> > [  191.762638] thunderbolt 0-1: new device found, vendor=0x108 device=0x1630
> > [  191.762641] thunderbolt 0-1: Lenovo ThinkPad Thunderbolt 3 Dock
> > 
> > this then is send to the userspace via uevent where bolt goes and
> > authorizes it and this results the tunnel to be created which show in
> > the log as:
> > 
> > [  191.943506] pcieport 0000:05:01.0: pciehp: Slot(1): Card present
> 
> So the obvious next question is why we have to wait for the 05:01.0
> link timeout before sending the command to the 06:00.0 firmware, since
> there's no PCI connection between them.

No there is not - it is a PCIe tunnel.

> But there must be *some* connection between the 05:01.0 link coming up
> and the 06:00.0 behavior.  Maybe this is related to the
> nhi_resume_noirq() comment about "The tunneled pci bridges are
> siblings of us. Use resume_noirq to reenable the tunnels asap. A
> corresponding pci quirk blocks the downstream bridges resume_noirq
> until we are done." Unfortunately the comment doesn't mention the NAME
> of the quirk, so I lost the trail there.
> 
> Maybe there's an opportunity for a quirk that says "this Thunderbolt
> device should never need a whole second for the link to come up", for
> example.

The PCIe stack needs to follow PCIe spec (regardless of what is the
actual medium the packets go through). And regadless what we do here the
PCIe link goes down and that breaks the usage of any devices behind that
link such as mounted disks so the delay is definitely not the worst
thing that can happen.

Now, If you read anything that Kamil said, this actually works now with
the "secure" mode when he turned the "Wake from Thunderbolt" option back
to the default. So now it works as expected but upon unplug there is the
issue that we fixed with the commit that marks the devices disconnected.
He will test that next week so we can be sure.
