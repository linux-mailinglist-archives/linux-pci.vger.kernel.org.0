Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C989576A326
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jul 2023 23:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjGaVnO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 17:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjGaVnH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 17:43:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0202C1B6;
        Mon, 31 Jul 2023 14:42:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 872BF612F1;
        Mon, 31 Jul 2023 21:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8826C433C8;
        Mon, 31 Jul 2023 21:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690839772;
        bh=7Pgr19ArQ0gDdQeiSh5sHbgpFbT91RPMzKTA2NuuCrA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JZn7lY+LJnLklKMLsiGUt1k0YITiexxtrKluHQzcusotorCb/dBpHyfAO55P1QGNN
         L4tvkqXsF/kvyElNQ+Z+w98p6gU0wnITEZ3v6mTnHrH623XfEhUR1QFTa4qcqHcvVu
         sAEDH/Bw+OzfCd9KnJwI17ueNituUBsr54bMwAF37coNid3B/IJOKuYhfbG3mA8ATg
         1Xb+Q1LlCKJHVm6cBUwFRWDeX/gN0b0/SgCn7f1pq2HAX2Z6Mm7Rt4HuhNSz7JO/0Q
         JkfC75C3SPxxyj/GoRN1INRV85jSRH54eK1T8p6hwsHL3u4qf4gQqO/TDxuVXFNBPA
         WFU9f0UqtIVbw==
Date:   Mon, 31 Jul 2023 16:42:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Igor Mammedov <imammedo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, terraluna977@gmail.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org, mst@redhat.com,
        rafael@kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: acpiphp:: use
 pci_assign_unassigned_bridge_resources() only if bus->self not NULL
Message-ID: <20230731214251.GA25106@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731144418.1d9c2baf@imammedo.users.ipa.redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 31, 2023 at 02:44:18PM +0200, Igor Mammedov wrote:
> On Sat, 29 Jul 2023 16:50:09 -0500 Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Jul 28, 2023 at 11:32:16AM +0200, Igor Mammedov wrote:
> > > On Thu, 27 Jul 2023 12:41:02 -0500 Bjorn Helgaas <helgaas@kernel.org> wrote:  
> > > > On Wed, Jul 26, 2023 at 02:35:18PM +0200, Igor Mammedov wrote:  
> > > > > Commit [1] switched acpiphp hotplug to use
> > > > >    pci_assign_unassigned_bridge_resources()
> > > > > which depends on bridge being available, however in some cases
> > > > > when acpiphp is in use, enable_slot() can get a slot without
> > > > > bridge associated.
> > > > >   1. legitimate case of hotplug on root bus
> > > > >       (likely not exiting on real hw, but widely used in virt world)
> > > > >   2. broken firmware, that sends 'Bus check' events to non
> > > > >      existing root ports (Dell Inspiron 7352/0W6WV0), which somehow
> > > > >      endup at acpiphp:enable_slot(..., bridge = 0) and with bus
> > > > >      without bridge assigned to it.    

> > >   2: last round of logs with debug patch /before 40613da5, with 40613da5, and after/
> > >       https://lore.kernel.org/r/46437825-3bd0-2f8a-12d8-98a2b54d7c22@gmail.com/
> > > 
> > > here dmesg shows 1st correct port
> > >  ACPI: \_SB_.PCI0.RP03: acpiphp_glue: Bus check in hotplug_event(): bridge: 000000000dad0b34
> > > and then later on
> > >  ACPI: \_SB_.PCI0.RP07: acpiphp_glue: Bus check in hotplug_event(): bridge: 0000000000000000
> > >  ACPI: \_SB_.PCI0.RP08: acpiphp_glue: Bus check in hotplug_event(): bridge: 0000000000000000
> > > which aren't recognized as bridge  
> > 
> > Thanks, that does seem a little suspect.  ACPI r6.5 sec 5.6.6 says
> > that when OSPM handles a Bus Check, it should "perform a Plug and Play
> > re-enumeration operation on the device tree starting from the point
> > where it has been notified."
> > 
> > PCI devices are enumerated by doing PCI config reads.  It would make
> > sense to re-enumerate a PCI hierarchy starting with a PCI device
> > that's already known to the OS, e.g., by scanning the secondary bus of
> > a PCI-to-PCI bridge.
> > 
> > I think there are two problems here:
> > 
> >   1) The platform shouldn't send a Bus Check notification to a PCI
> >      device that doesn't exist.  How could the OS re-enumerate
> >      starting there?
> 
> in case of reported laptop, DSDT provides Device Descriptors
> for not existing root-ports.
> 
> OSPM can't do anything with it but to pass Notify event to
> PCI bus-specific enumeration mechanism, and it's upto PCI subsystem
> to discard/ignore Notify() on this ACPI node.

That seems backwards to me, but we have a fair bit of ACPI and PCI
stuff that's backwards.

> >   2) Linux runs acpiphp_hotplug_notify() for Bus Checks to
> >      non-existent PCI devices when it ignore them; reasoning below.
> > 
> > We call acpiphp_enumerate_slots() in this path, which happens before
> > any of the PCI devices on the root bus have been enumerated:
> > 
> >   pci_register_host_bridge
> >     pcibios_add_bus(root bus)
> >       acpi_pci_add_bus
> >         acpiphp_enumerate_slots(pci_bus *bus)
> >           acpi_walk_namespace(acpiphp_add_context)
> >             acpiphp_add_context(struct acpiphp_bridge *)
> >               acpi_evaluate_integer("_ADR")
> >               acpiphp_init_context
> >                 context->hp.notify = acpiphp_hotplug_notify
> > 
> > So now we've already looked at RP03, RP07, and RP08, and set up the
> > .notify() handler for all of them.  Since we haven't scanned the bus
> > yet, we don't know that RP03 exists and RP07 and RP08 do not.
> 
> While ACPI doesn't forbid firmware to describe non-existing RP,
> the PCIe hostbridge can't hotplug extra root ports. (and QEMU
> follows PCIe design in this respect on 'q35' machine).
> 
> However when it comes to hotplug on QEMU's 'pc' machine
> (hotplug on root bus), each slot has "Augmented Device
> Descriptors", that includes un-populated slots leading to
> the presence of .notify() handler on such slots.
> 
> Then later on when device is hotplugged, a Notify(,1/*DeviceCheck*/)
> is sent to previously empty slot and from there on PCI subsystem
> re-enumerates either a single device or a bridge hierarchy
> (from the parent context).
> 
> So I'd assume that we need to have .notify() handler for all slots
> that are described in DSDT (present and non present).

Just from a "beautiful design" perspective, it seems suboptimal for
the ACPI device tree to have to include Device objects for all
possible hot-added devices.

I would expect hot-add to be handled via a Bus Check to the *parent*
of a new device, so the device tree would only need to describe
hardware that's present at boot.  That would mean pci_root.c would
have some .notify() handler, but I don't see anything there.

I don't know if platforms really implement Root Port hot-add (maybe
qemu?), but if they do, I could believe they might do it via Notify to
an ACPI Device for a non-present hardware device.  I wouldn't know
whether that's the intent of the spec, or just a reaction to something
that happened to work with existing OSes.

> >   $ qemu-system-x86_64 -M pc -m 512M -monitor stdio -cpu host --enable-kvm -kernel arch/x86/boot/bzImage -drive format=raw,file=ubuntu.img -append "root=/dev/sda1"
> >   (qemu) device_add e1000
> > 
> > (For posterity, replacing "-monitor stdio" with "-nographic -monitor
> > telnet:localhost:7001,server,nowait,nodelay" and adding
> > "console=ttyS0,115200n8" to the -append made it easier to see the
> > crash details.)
> 
> I've not put extra arguments, because there is a lot of ways
> one can configure/use monitor/serial options.
> 
> But specifying full command line like yours will be useful
> for anyone who doesn't have any experience with QEMU CLI.

Yep, that's the audience :)  I want to make it as easy as reasonably
possible for non-qemu experts to repro things.

> > I really wish we didn't have such different resource assignment paths
> > depending on whether the device is on a root bus or deeper in the
> > hierarchy.  But we can't fix that now, so this seems like the right
> > thing.
> 
> I've looked at possibility of making 
>   pci_assign_unassigned_bridge_resources()
> work without bridge pointer, but it looks not viable as it's
> a bridge dedicated function which on top of rearranging
> resources, also disables/reprograms/enables bridge.
> 
> If there are ideas how to make it better,
> I can pick it up and try to implement.
> 
> Testing shows that pci_assign_unassigned_bridge_resources()
> isn't ideal since it releases all resources before reassigning
> and then if the later fails bridge stays in mis-configured
> state (attempt to recover results in failing BAR assignment
> to children devices).
> It's not issue in case of
>   root-port -> 1 child device hotplug
> since root port hadn't any working device[s] behind it.
> But in case of hotplug into PCI bridge, that leaves
> pre-existing devices behind the bridge broken (SHPC and acpiphp case).

Yeah, it's a complicated mess.  That's why I didn't think this would
be a viable fix in the short term.

Bjorn
