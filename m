Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804A47B0AA4
	for <lists+linux-pci@lfdr.de>; Wed, 27 Sep 2023 18:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjI0Qul (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Sep 2023 12:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjI0Quk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Sep 2023 12:50:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D21092
        for <linux-pci@vger.kernel.org>; Wed, 27 Sep 2023 09:50:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E43BC433C9;
        Wed, 27 Sep 2023 16:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695833438;
        bh=78eebxN/zU5Ta1svqcQKcWfWdehcyX+Vd9lIRhHdkyw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qjlKc+LvKmI4AJEEFHyaWg2l87sGgZp6X/LfpEIaV8XXivYiyMkSAJw1X2VQ4vCNm
         TkZ+2JsnQcgpVMwjfQtPU9EDqwAQ3hvftQuX2RH9rMua3vCKQHuMeC/ra11vT8sHd0
         DUXxkoQXkxTpeBqQQPGkqag8PLK8VFieWmGfM6/pSmg8JoTf6E9o79wUjqJAZJf//I
         rZJ/Hc1E/dHAh+WrTlXCvvamjEfuK6h7tKzLPuvAHkMRtJAK9jQmyGHHFezyTxUqLq
         83NAosNJEQFI+ZRhNTqqInJyDES/oKnwCT8ohh8d+T9s4DZ0hcvpmTP32u1H3mDsx7
         /70g9nc9THpbw==
Date:   Wed, 27 Sep 2023 11:50:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Lukas Wunner <lukas@wunner.de>, Kamil Paral <kparal@redhat.com>,
        linux-pci@vger.kernel.org, regressions@lists.linux.dev,
        bhelgaas@google.com, chris.chiu@canonical.com
Subject: Re: [REGRESSION] resume with a Thunderbolt dock broke with commit
 e8b908146d44 "PCI/PM: Increase wait time after resume"
Message-ID: <20230927165036.GA450933@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927124732.GI3208943@black.fi.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 27, 2023 at 03:47:32PM +0300, Mika Westerberg wrote:
> On Wed, Sep 27, 2023 at 06:57:03AM -0500, Bjorn Helgaas wrote:
> > On Wed, Sep 27, 2023 at 08:16:02AM +0300, Mika Westerberg wrote:
> > > On Tue, Sep 26, 2023 at 12:55:30PM -0500, Bjorn Helgaas wrote:
> > > > On Mon, Sep 25, 2023 at 04:19:30PM +0200, Lukas Wunner wrote:
> > > > > On Mon, Sep 25, 2023 at 08:48:41AM -0500, Bjorn Helgaas wrote:
> > > > > > Now pciehp thinks the slot is occupied and the link is up, so we
> > > > > > re-enumerate the hierarchy.  Is this because thunderbolt did something
> > > > > > to 06:00.0 that made the link from 05:01.0 come up?
> > > > > 
> > > > > PCIe TLPs are encapsulated into Thunderbolt packets and transmitted
> > > > > alongside DisplayPort and other data over the same physical link.
> > > > > 
> > > > > For this to work, PCIe tunnels need to be set up between the Thunderbolt
> > > > > host controller and attached devices.  Once a tunnel is established,
> > > > > the PCIe link magically goes up and TLPs can be transmitted.
> > > > > 
> > > > > There are two ways to establish those tunnels:
> > > > > 
> > > > > 1/ By a firmware in the Thunderbolt host controller.
> > > > >    (firmware or "internal" connection manager, drivers/thunderbolt/icm.c)
> > > > > 
> > > > > 2/ Natively by the kernel.
> > > > >    (software connection manager)
> > > > > 
> > > > > I'm assuming that the laptop in question exclusively uses the firmware
> > > > > connection manager, hence the kernel is reliant on that firmware to
> > > > > establish tunnels and can't really do anything if it fails to do so.
> > > > 
> > > > Thanks for the background; that improves my meager understanding a
> > > > lot.
> > > > 
> > > > Since this seems to be a firmware issue, it does sound like this
> > > > laptop uses a firmware connection manager.  But there still seems to
> > > > be some kernel connection because pre-e8b908146d44, the link came up
> > > > in <5 seconds, and after the minor e8b908146d44 change, it takes >60
> > > > seconds.
> > > 
> > > In both cases (with or without) the commit what happens is that after
> > > resume is finished the firmware connection manager notices the
> > > connection, announces it to the Thunderbolt driver that exposes it to
> > > the userspace where boltd re-authorizes the device. This brings up the
> > > PCIe tunnel again and things get working.
> > > 
> > > (What is expected to happen is that during the resume the firmware
> > >  connection manager re-connects the PCIe tunnel.)
> > > 
> > > This took previously the ~5s before resume is complete so that the above
> > > steps can happen where as after the commit it got delayed more up to the
> > > arbitrary ~60s because we started to use that with the commit
> > > e8b908146d44 (PCIE_RESET_READY_POLL_MS).
> > 
> > Why does the kernel delay affect the timing of when the firmware
> > connection manager notices the connection?  It seems like Linux waits
> > for the timeout, then Linux does something that kicks the firmware
> > connection manager.  That's why I asked about this sequence:
> > 
> >   [  118.985530] pcieport 0000:05:01.0: Data Link Layer Link Active not set in 1000 msec
> >   [  190.090902] pcieport 0000:05:01.0: pciehp: Slot(1): Card not present
> >   [  191.754347] thunderbolt 0000:06:00.0: 1: DROM version: 1
> >   [  191.762638] thunderbolt 0-1: new device found, vendor=0x108 device=0x1630
> >   [  191.762641] thunderbolt 0-1: Lenovo ThinkPad Thunderbolt 3 Dock
> >   [  191.943506] pcieport 0000:05:01.0: pciehp: Slot(1): Card present
> > 
> > where we wait for the timeout, decide the device is gone, remove
> > everything, and then the thunderbolt driver does something, and we
> > notice the device is magically back.
> 
> Well the delay delays the whole resume and this includes Thunderbolt
> driver resume too, and userspace (where the bolt daemon authorizes the
> device again).

I don't know how the Thunderbolt driver works.  I assume this refers
to "thunderbolt 0000:06:00.0"?  Is the 06:00.0 resume related to the
firmware connection manager somehow?

The removal affects the sub-hierarchy below 05:01.0 (bus 07-3b).
06:00.0 is below 05:00.0, so it's in a different sub-hierarchy.  I
don't think there's a PCIe requirement that 05:01.0 be resumed before
05:00.0, or even that they be serialized at all.

The hierarchy:

  pci 0000:00:1c.4: PCI bridge to [bus 04-3c]
  pci 0000:04:00.0: PCI bridge to [bus 05-3c]
  pci 0000:05:00.0: PCI bridge to [bus 06]
  pci 0000:05:01.0: PCI bridge to [bus 07-3b]

It looks like we start the 06:00.0 resume first (118.9), but it
doesn't complete until after the timeout (191.7):

  [  118.915870] thunderbolt 0000:06:00.0: control channel starting...
  [  118.985530] pcieport 0000:05:01.0: Data Link Layer Link Active not set in 1000 msec
  [  190.090902] pcieport 0000:05:01.0: pciehp: Slot(1): Card not present
  [  191.754347] thunderbolt 0000:06:00.0: 1: DROM version: 1
  [  191.762638] thunderbolt 0-1: new device found, vendor=0x108 device=0x1630
  [  191.762641] thunderbolt 0-1: Lenovo ThinkPad Thunderbolt 3 Dock
  [  191.943506] pcieport 0000:05:01.0: pciehp: Slot(1): Card present

Did the Thunderbolt driver do something to 06:00.0 that caused the
05:01.0 link to come up, or is the timing just coincidental?

> > > I would also try to change all the BIOS settings back to defaults, see
> > > that it works (it is probably in "user" security level then), then
> > > switch back to "secure" (only change this one option) and try if it now
> > > works. It could be that some setting just did not get commited properly.
> > 
> > If this might lead to fixing a Linux defect, I'm all for this kind of
> > experimentation.  But if it only leads to understanding a firmware
> > defect better or figuring out better advice to users, I'm not, because
> > I don't want to address this with a release note.
> 
> This is not a Linux defect. The firmware is expected to create that
> tunnel so regardless of the "delay" the devices are already back. This
> is not happening.

Sorry, bad phrasing on my part.  I understand it's not a Linux defect;
I meant to suggest that if we can learn something that leads to a
Linux change that avoids the delay, whether it's a quirk, design
change, whatever, that's great.

If it only leads to a documentation change or recommendation to users,
that's not great because it's only a reaction to something the user
has already tripped over.

Bjorn
