Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6039632FF6
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 23:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiKUWpx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 17:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiKUWpw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 17:45:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3032A5B593
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2022 14:45:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFB35614EA
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2022 22:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01499C433D6;
        Mon, 21 Nov 2022 22:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669070750;
        bh=sL4eSJrJiNkx/hQk7+s54j0lFcVhAsMr97xrH1+vpqw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dMCCHFaKJODGX83vPuMxqLR5BYNBKzDODp5+cydIMlYNkBY1+Q/g92rTiaXvHY16k
         iNtK1ahEjy42hJkwLpoi9ob07/u2GTynQfAGju5fw7kGda0quJpGrDul8RKn3edTRa
         BVK5fyYl+UFy6ymhQOzfItRIFvet8OSzjrSIFDG+5uweeiWjC1iiXnwYeE76YISjPZ
         Jf4QmHpjASyCa6ImVeHuFBeRJKYRDFBnu5TiDt6PDIEPz6cjSUOQgMRViuYox8VSMF
         4XUm6eS0TeIvda5ox9npKPakexIjDZyIpF2IMuNofB7L8NdNcnIbXjsxuYvGSFvXHK
         2n0HJ2YMpaEIg==
Date:   Mon, 21 Nov 2022 16:45:48 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Take multifunction devices into account when
 distributing resources
Message-ID: <20221121224548.GA138441@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3tlRIG99P/amO9Q@black.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 21, 2022 at 01:47:16PM +0200, Mika Westerberg wrote:
> On Fri, Nov 18, 2022 at 06:29:51AM -0600, Bjorn Helgaas wrote:
> > On Fri, Nov 18, 2022 at 10:57:12AM +0200, Mika Westerberg wrote:
> > > On Thu, Nov 17, 2022 at 05:10:34PM -0600, Bjorn Helgaas wrote:
> > > > On Mon, Nov 14, 2022 at 01:59:52PM +0200, Mika Westerberg wrote:
> > > > > PCIe switch upstream port may be one of the functions of a multifunction
> > > > > device.
> > > > 
> > > > I don't think this is specific to PCIe, is it?  Can't we have a
> > > > multi-function device where one function is a conventional PCI bridge?
> > > > Actually, I don't think "multi-function" is relevant at all -- you
> > > > iterate over all the devices on the bus below.  For PCIe, that likely
> > > > means multiple functions of the same device, but it could be separate
> > > > devices in conventional PCI.
> > > 
> > > Yes it can be but I was trying to explain the problem we encountered and
> > > that's related to PCIe.
> > > 
> > > I can leave this out if you think it is better that way.
> > 
> > Not necessarily, I'm just hoping this change is generic enough for all
> > PCI and PCIe topologies.
> 
> Okay maybe I'll just drop the "multi-function" part of it?
> 
> > > > > The resource distribution code does not take this into account
> > > > > properly and therefore it expands the upstream port resource windows too
> > > > > much, not leaving space for the other functions (in the multifunction
> > > > > device)
> > > > 
> > > > I guess the window expansion here is done by adjust_bridge_window()?
> > > 
> > > Yes but the resources are distributed in
> > > pci_bus_distribute_available_resources().
> > 
> > Yep, sounds good, I was just confirming my understanding of the code.
> > The main point of this patch is to *reduce* the size of the windows to
> > leave room for peers of the bridge, so I had to look a bit to figure
> > out where they got expanded.
> 
> Understood :)
> 
> > > > >  	if (hotplug_bridges + normal_bridges == 1) {
> > > > > -		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
> > > > > -		if (dev->subordinate)
> > > > > -			pci_bus_distribute_available_resources(dev->subordinate,
> > > > > -				add_list, io, mmio, mmio_pref);
> > > > > +		/* Upstream port must be the first */
> > > > > +		bridge = list_first_entry(&bus->devices, struct pci_dev, bus_list);
> > > > > +		if (!bridge->subordinate)
> > > > > +			return;
> > > > > +
> > > > > +		/*
> > > > > +		 * It is possible to have switch upstream port as a part of a
> > > > > +		 * multifunction device. For this reason reduce the space
> > > > > +		 * available for distribution by the amount required by the
> > > > > +		 * peers of the upstream port.
> > > > > +		 */
> > > > > +		list_for_each_entry(dev, &bus->devices, bus_list) {
> > > > 
> > > > It seems like maybe we ought to do this regardless of how many bridges
> > > > there are on the bus.  Don't we always want to assign space to devices
> > > > on this bus before distributing the leftovers to downstream buses?
> > > 
> > > Yes we do.
> > > 
> > > > E.g., maybe this should be done before the adjust_bridge_window()
> > > > calls?
> > > 
> > > With the current code it is clear that we deal with the upstream port.
> > > At least in PCIe it is not allowed to have anything else than downstream
> > > ports on that internal bus so the only case we would need to do this is
> > > the switch upstream port.
> > > 
> > > Let me know if you still want me to move this before adjust_bridge_window()
> > > I can do that in v3. Probably needs a comment too.
> > 
> > Hmm, I don't know exactly how to do this, but I don't think this code
> > should be PCIe-specific, which I think means it shouldn't depend on
> > how many bridges are on the bus.
> > 
> > I guess the existing assumption that a bridge must be the first device
> > on the bus is a hidden assumption that this is PCIe.  That might be a
> > mistake from the past.
> > 
> > I haven't tried it, but I wonder if we could reproduce the same
> > problem in a conventional PCI topology with qemu.
> 
> I'm not an expert in QEMU but I think I was able to create such topology
> with the following command line (parts copied from Jonathan's):
> 
> qemu-system-aarch64                                                             \
>         -M virt,nvdimm=on,gic-version=3 -m 4g,maxmem=8G,slots=8 -cpu max -smp 4 \
>         -bios /usr/share/qemu-efi-aarch64/QEMU_EFI.fd                           \
>         -nographic -no-reboot                                                   \
>         -kernel Image                          					\
>         -initrd rootfs.cpio.bz2              					\
>         -device pcie-pci-bridge,id=br1                                          \
>         -device pci-bridge,chassis_nr=1,bus=br1,id=br2,shpc=on,addr=2           \
>         -device e1000,bus=br1,addr=3                                            \
>         -device e1000,bus=br1,addr=4                                            \
>         -device e1000,bus=br2,addr=5
> 
> However, the problem does not reproduce with or without the patch. The
> below is 'lspci -v' without this patch and 5632e2beaf9d5dda694c0572684dea783d8a9492 reverted:

IIUC, the summary is this:

  00:02.0 bridge window [mem 0x10000000-0x102fffff] to [bus 01-02]
  01:02.0 bridge window [mem 0x10000000-0x100fffff] to [bus 02]
  01:03.0 NIC BAR [mem 0x10200000-0x1021ffff]
  01:04.0 NIC BAR [mem 0x10220000-0x1023ffff]
  02:05.0 NIC BAR [mem 0x10080000-0x1009ffff]

and it's the same with and without the current patch.

Are all these assignments done by BIOS, or did Linux update them?
Did we exercise the same "distribute available resources" path as in
the PCIe case?  I expect we *should*, because there really shouldn't
be any PCI vs PCIe differences in how resources are handled.  This is
why I'm not comfortable with assumptions here that depend on PCIe.

I can't tell from Jonathan's PCIe case whether we got a working config
from BIOS or not because our logging of bridge windows is kind of
poor.

Bjorn
