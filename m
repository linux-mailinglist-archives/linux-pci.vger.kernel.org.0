Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EB6772CED
	for <lists+linux-pci@lfdr.de>; Mon,  7 Aug 2023 19:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjHGR27 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 13:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjHGR25 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 13:28:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B32F9;
        Mon,  7 Aug 2023 10:28:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B956C62043;
        Mon,  7 Aug 2023 17:28:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE929C433C7;
        Mon,  7 Aug 2023 17:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691429334;
        bh=umiws+qo/l7mS3mGD2LhwtlaVOENQ2ScuETufuHC9Bs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=D7QbSnaszSbUCdS0UR5Ol4ZssNxf74XnRYwrjiTy1JqoeBOHB1cOodqw61kT7YsHO
         R76Da1TZh/qA7XCWvxc+cYc3RKfZKhsKNInyrspjZ5hUNMiQmAMzjnvxwNnQORXYLG
         Lju0vWYKgLer9tq1FzeibolBZnoIunQZLKBdXWSRL5SAQ7c4sf+OGX0FD1hIVo8X0v
         GyJduxac3udnMALH6lmpwtyyYIYy/iHKkXBfuqDhlPi0cpmvEs2EOtiBhv+joqtMOw
         1l9aLQ5rh4jbclVBdUEkc2EhEa6IRCuaGPyMCqGI6ipWW/U88bjmHnE8HhuL+9bPYn
         r0Q1akV/Va7kA==
Date:   Mon, 7 Aug 2023 12:28:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Igor Mammedov <imammedo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, terraluna977@gmail.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org, mst@redhat.com,
        rafael@kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: acpiphp:: use
 pci_assign_unassigned_bridge_resources() only if bus->self not NULL
Message-ID: <20230807172852.GA250768@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807150746.71ca1df3@imammedo.users.ipa.redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 07, 2023 at 03:07:46PM +0200, Igor Mammedov wrote:
> On Fri, 4 Aug 2023 18:27:09 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > On Wed, Jul 26, 2023 at 02:35:18PM +0200, Igor Mammedov wrote:
> > > Commit [1] switched acpiphp hotplug to use
> > >    pci_assign_unassigned_bridge_resources()
> > > which depends on bridge being available, however in some cases
> > > when acpiphp is in use, enable_slot() can get a slot without
> > > bridge associated.  
> > 
> > acpiphp is *always* in use if we get to enable_slot(), so that doesn't
> > really add information here.
> > 
> > >   1. legitimate case of hotplug on root bus
> > >       (likely not exiting on real hw, but widely used in virt world)
> > >   2. broken firmware, that sends 'Bus check' events to non
> > >      existing root ports (Dell Inspiron 7352/0W6WV0), which somehow
> > >      endup at acpiphp:enable_slot(..., bridge = 0) and with bus
> > >      without bridge assigned to it.  
> 
> how about following commit message (incorporating all feed back in this thread):

I incorporated this commit log and put the patch on for-linus for
v6.5.  I think the patch is fine, and we can amend the commit log
again if necessary.

> -- cut --
> Commit [1] switched acpiphp hotplug to use
>    pci_assign_unassigned_bridge_resources()
> which depends on bridge being available, however in case
> when acpiphp is enabled [2], enable_slot() can be called without
> bridge associated.
>   1. legitimate case of hotplug on root bus
>       (widely used in virt world)
>   2. a (misbehaving) firmware, that sends 'Bus check' events
>      to non existing root ports (Dell Inspiron 7352/0W6WV0),
>      which endup at acpiphp:enable_slot(..., bridge = 0)
>      where bus has not bridge assigned to it.
>      acpihp doesn't know that it's a bridge, and bus specific
>      'PCI subsystem' can't argument ACPI context with bridge
>      information since the PCI device to get this data from
>      is/was not available.
> 
> Issue is easy to reproduce with QEMU's 'pc' machine, which supports
> PCI hotplug on hostbridge slots. To reproduce boot kernel at
> commit [1] in VM started with following CLI (assuming guest root fs
> is installed on sda1 partition):
> 
>    # qemu-system-x86_64 -M pc -m 1G -enable-kvm -cpu host \
>          -monitor stdio -serial file:serial.log           \
>          -kernel arch/x86/boot/bzImage                    \
>          -append "root=/dev/sda1 console=ttyS0"           \
>          guest_disk.img
> 
> once guest OS is fully booted at qemu prompt:
> 
> (qemu) device_add e1000
> 
> (check serial.log) it will cause NULL pointer dereference at:
> 
>     void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
>     {
>         struct pci_bus *parent = bridge->subordinate;
> 
> [  612.277651] BUG: kernel NULL pointer dereference, address: 0000000000000018
> [...]
> [  612.277798]  ? pci_assign_unassigned_bridge_resources+0x1f/0x260
> [  612.277804]  ? pcibios_allocate_dev_resources+0x3c/0x2a0
> [  612.277809]  enable_slot+0x21f/0x3e0
> [  612.277816]  acpiphp_hotplug_notify+0x13d/0x260
> [  612.277822]  ? __pfx_acpiphp_hotplug_notify+0x10/0x10
> [  612.277827]  acpi_device_hotplug+0xbc/0x540
> [  612.277834]  acpi_hotplug_work_fn+0x15/0x20
> [  612.277839]  process_one_work+0x1f7/0x370
> [  612.277845]  worker_thread+0x45/0x3b0
> [  612.277850]  ? __pfx_worker_thread+0x10/0x10
> [  612.277854]  kthread+0xdc/0x110
> [  612.277860]  ? __pfx_kthread+0x10/0x10
> [  612.277866]  ret_from_fork+0x28/0x40
> [  612.277871]  ? __pfx_kthread+0x10/0x10
> [  612.277876]  ret_from_fork_asm+0x1b/0x30
> 
> The issue was discovered on Dell Inspiron 7352/0W6WV0 laptop with
> following sequence:
>    1. suspend to RAM
>    2. wake up with the same backtrace being observed:
>    3. 2nd suspend to RAM attempt makes laptop freeze
> 
> Fix it by using __pci_bus_assign_resources() instead of
> pci_assign_unassigned_bridge_resources() as we used to do
> but only in case when bus doesn't have a bridge associated
> (to cover for the case of ACPI event on hostbridge or
> non existing root port).
> 
> That let us keep hotplug on root bus working like it used to be
> and at the same time keeps resource reassignment usable on
> root ports (and other 1st level bridges) that was fixed by [1].
> 
> 1)
> Fixes: 40613da52b13 ("PCI: acpiphp: Reassign resources on bridge if necessary")
> 2) CONFIG_HOTPLUG_PCI_ACPI=y
> 
> -- cut --
> 
> if commit message is looking acceptable to you, I can respin
> amended patch with your suggestions taken in account.
> 
> > IIUC, the Inspiron problem happens when:
> > 
> >   - acpiphp_context->bridge is NULL, so hotplug_event() calls
> >     enable_slot() instead of acpiphp_check_bridge(), AND
> > 
> >   - acpiphp_slot->bus->self is also NULL, because enable_slot() calls
> >     pci_assign_unassigned_bridge_resources() with that NULL pointer,
> >     which dereferences "bridge->subordinate"
> > 
> > But I can't figure out why acpiphp_context->bridge is NULL for RP07
> > and RP08 (which don't exist), but not for RP03 (which does).
> > 
> > I guess all the acpiphp_contexts (RP03, RP07, RP08) must be allocated in
> > acpiphp_add_context() by acpiphp_init_context().
> > 
> > Woody's lspci from [1] shows only one Root Port:
> > 
> >   00:1c.0 Wildcat Point-LP PCI Express Root Port #3
> > 
> > The DSDT.DSL includes:
> > 
> >   Device (RP01) _ADR 0x001C0000		# 1c.0
> >   Device (RP02) _ADR 0x001C0001		# 1c.1
> >   Device (RP03) _ADR 0x001C0002		# 1c.2
> >   Device (RP04) _ADR 0x001C0003		# 1c.3
> >   Device (RP05) _ADR 0x001C0004		# 1c.4
> >   Device (RP06) _ADR 0x001C0005		# 1c.5
> >   Device (RP07) _ADR 0x001C0006		# 1c.6
> >   Device (RP08) _ADR 0x001C0007		# 1c.7
> > 
> > I can see why we might need a Bus Check after resume to see if
> > something got added while we were suspended.  But I don't see why we
> > handle RP03 differently from RP07 and RP08.
> > 
> > Can you help me out?  I'm lost in a maze of twisty passages, all
> > alike.
> 
> I'll try to trace call path and see where it leads
> (based on a guess in updated commit message: OS/nor ACPI
> has info if it's bridge when the device didn't exists
> during boot).
> 
> (though, I don't think it should hold this patch.
> while it would be good to understand where bridge
> gets added in acpi context, it's not directly relevant
> to the fixing hotplug on hostbridge and buscheck events 
> on non-existing root-ports)
> 
> > Bjorn
> > 
> > [1] https://lore.kernel.org/r/92150d8d-8a3a-d600-a996-f60a8e4c876c@gmail.com
> > 
> 
> 
