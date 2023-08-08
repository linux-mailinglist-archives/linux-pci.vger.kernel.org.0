Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70BD773DA9
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 18:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjHHQUV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 12:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjHHQS5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 12:18:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C33D6E94
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 08:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691509716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sRU2h9UYx40u7SG49evlNW/9UjBFwgSUB4TmWnU9Xgs=;
        b=G7BgZQMk6LBzhQzzrutZo7TO8ibHZUOz5WqOBwRu42moB7CYa3Fi6F5fEJ2TYT9tGDUkBG
        cRj7CUDm+wUIPn7axFOkPOVVdEvCxHX0rkUHZj3ECTGkKRgz/sN0662KuP8a9/HdX4uWdf
        zGByvNDXm14+SSkRFvpNz6puSHu3tkc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-vZgXnjSzNQye25Li89sdrA-1; Tue, 08 Aug 2023 07:47:45 -0400
X-MC-Unique: vZgXnjSzNQye25Li89sdrA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fe15547164so36312525e9.0
        for <linux-pci@vger.kernel.org>; Tue, 08 Aug 2023 04:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691495264; x=1692100064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRU2h9UYx40u7SG49evlNW/9UjBFwgSUB4TmWnU9Xgs=;
        b=InNbR3ksGlWIEvhymwyEBcLO4TaAvLHrVgXe6Qqr3n9meWNVPQnZNmw9UJB27BskCk
         YcPTi3td8bcfyJZF957Ht3wKBPfAPjAuaj83C8thlbE9QMz4Q0tq5cIZifWUO/pPqXv+
         7FqMOHDoDhguqwi9pxW2yOMkdBQY69PuKfgRHW+Yf0Fw+ehb434D2ZDYRhrW/3Ry2/Wn
         eYmPtX+AK006Q3Bld56MWz2oE3yXTpLDUUvuioLN3SRpqzKUoJIsJZV3ZDE7p6hf0des
         xujWGzlKEzVpst9hN3BkkFmg5cQ9nRAiKueSNDo2Ws3lNYGeb00xQju1kKITaTiMVoGH
         6/kA==
X-Gm-Message-State: AOJu0YyK6t2JL+qEQ/GAKZBXjGcPCdiLW1QLEhviEWKuGv9xiswjw/NG
        QJh4jlAe4hoDmPspJ/0MNngqOdmbER5cuILJ+tj6Smo253q+pYxXr6BjPImsOpMFQNj/DoESlSC
        1EK8gu3sNXqS/W45GXqTj
X-Received: by 2002:a7b:c343:0:b0:3fe:1cac:37d7 with SMTP id l3-20020a7bc343000000b003fe1cac37d7mr9974911wmj.10.1691495264694;
        Tue, 08 Aug 2023 04:47:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNQ3uZsLiZpYAqfmBrk3J+QS+f7Z3LPrLYiLrVNL2H1mIB0zL+EhHYMl4bC3ne2IcAvGJiCQ==
X-Received: by 2002:a7b:c343:0:b0:3fe:1cac:37d7 with SMTP id l3-20020a7bc343000000b003fe1cac37d7mr9974899wmj.10.1691495264338;
        Tue, 08 Aug 2023 04:47:44 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id h5-20020a05600004c500b003143aa0ca8asm13547829wri.13.2023.08.08.04.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 04:47:43 -0700 (PDT)
Date:   Tue, 8 Aug 2023 13:47:42 +0200
From:   Igor Mammedov <imammedo@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, terraluna977@gmail.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org, mst@redhat.com,
        rafael@kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: acpiphp:: use
 pci_assign_unassigned_bridge_resources() only if bus->self not NULL
Message-ID: <20230808134742.464b847f@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230807172852.GA250768@bhelgaas>
References: <20230807150746.71ca1df3@imammedo.users.ipa.redhat.com>
        <20230807172852.GA250768@bhelgaas>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 7 Aug 2023 12:28:52 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Mon, Aug 07, 2023 at 03:07:46PM +0200, Igor Mammedov wrote:
> > On Fri, 4 Aug 2023 18:27:09 -0500
> > Bjorn Helgaas <helgaas@kernel.org> wrote:
> >   
> > > On Wed, Jul 26, 2023 at 02:35:18PM +0200, Igor Mammedov wrote:  
> > > > Commit [1] switched acpiphp hotplug to use
> > > >    pci_assign_unassigned_bridge_resources()
> > > > which depends on bridge being available, however in some cases
> > > > when acpiphp is in use, enable_slot() can get a slot without
> > > > bridge associated.    
> > > 
> > > acpiphp is *always* in use if we get to enable_slot(), so that doesn't
> > > really add information here.
> > >   
> > > >   1. legitimate case of hotplug on root bus
> > > >       (likely not exiting on real hw, but widely used in virt world)
> > > >   2. broken firmware, that sends 'Bus check' events to non
> > > >      existing root ports (Dell Inspiron 7352/0W6WV0), which somehow
> > > >      endup at acpiphp:enable_slot(..., bridge = 0) and with bus
> > > >      without bridge assigned to it.    
> > 
> > how about following commit message (incorporating all feed back in this thread):  
> 
> I incorporated this commit log and put the patch on for-linus for
> v6.5.  I think the patch is fine, and we can amend the commit log
> again if necessary.

Thanks!
 
See below notes on present vs non-present root-ports.

> > -- cut --
> > Commit [1] switched acpiphp hotplug to use
> >    pci_assign_unassigned_bridge_resources()
> > which depends on bridge being available, however in case
> > when acpiphp is enabled [2], enable_slot() can be called without
> > bridge associated.
> >   1. legitimate case of hotplug on root bus
> >       (widely used in virt world)
> >   2. a (misbehaving) firmware, that sends 'Bus check' events
> >      to non existing root ports (Dell Inspiron 7352/0W6WV0),
> >      which endup at acpiphp:enable_slot(..., bridge = 0)
> >      where bus has not bridge assigned to it.
> >      acpihp doesn't know that it's a bridge, and bus specific
> >      'PCI subsystem' can't argument ACPI context with bridge
> >      information since the PCI device to get this data from
> >      is/was not available.
> > 
> > Issue is easy to reproduce with QEMU's 'pc' machine, which supports
> > PCI hotplug on hostbridge slots. To reproduce boot kernel at
> > commit [1] in VM started with following CLI (assuming guest root fs
> > is installed on sda1 partition):
> > 
> >    # qemu-system-x86_64 -M pc -m 1G -enable-kvm -cpu host \
> >          -monitor stdio -serial file:serial.log           \
> >          -kernel arch/x86/boot/bzImage                    \
> >          -append "root=/dev/sda1 console=ttyS0"           \
> >          guest_disk.img
> > 
> > once guest OS is fully booted at qemu prompt:
> > 
> > (qemu) device_add e1000
> > 
> > (check serial.log) it will cause NULL pointer dereference at:
> > 
> >     void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
> >     {
> >         struct pci_bus *parent = bridge->subordinate;
> > 
> > [  612.277651] BUG: kernel NULL pointer dereference, address: 0000000000000018
> > [...]
> > [  612.277798]  ? pci_assign_unassigned_bridge_resources+0x1f/0x260
> > [  612.277804]  ? pcibios_allocate_dev_resources+0x3c/0x2a0
> > [  612.277809]  enable_slot+0x21f/0x3e0
> > [  612.277816]  acpiphp_hotplug_notify+0x13d/0x260
> > [  612.277822]  ? __pfx_acpiphp_hotplug_notify+0x10/0x10
> > [  612.277827]  acpi_device_hotplug+0xbc/0x540
> > [  612.277834]  acpi_hotplug_work_fn+0x15/0x20
> > [  612.277839]  process_one_work+0x1f7/0x370
> > [  612.277845]  worker_thread+0x45/0x3b0
> > [  612.277850]  ? __pfx_worker_thread+0x10/0x10
> > [  612.277854]  kthread+0xdc/0x110
> > [  612.277860]  ? __pfx_kthread+0x10/0x10
> > [  612.277866]  ret_from_fork+0x28/0x40
> > [  612.277871]  ? __pfx_kthread+0x10/0x10
> > [  612.277876]  ret_from_fork_asm+0x1b/0x30
> > 
> > The issue was discovered on Dell Inspiron 7352/0W6WV0 laptop with
> > following sequence:
> >    1. suspend to RAM
> >    2. wake up with the same backtrace being observed:
> >    3. 2nd suspend to RAM attempt makes laptop freeze
> > 
> > Fix it by using __pci_bus_assign_resources() instead of
> > pci_assign_unassigned_bridge_resources() as we used to do
> > but only in case when bus doesn't have a bridge associated
> > (to cover for the case of ACPI event on hostbridge or
> > non existing root port).
> > 
> > That let us keep hotplug on root bus working like it used to be
> > and at the same time keeps resource reassignment usable on
> > root ports (and other 1st level bridges) that was fixed by [1].
> > 
> > 1)
> > Fixes: 40613da52b13 ("PCI: acpiphp: Reassign resources on bridge if necessary")
> > 2) CONFIG_HOTPLUG_PCI_ACPI=y
> > 
> > -- cut --
> > 
> > if commit message is looking acceptable to you, I can respin
> > amended patch with your suggestions taken in account.
> >   
> > > IIUC, the Inspiron problem happens when:
> > > 
> > >   - acpiphp_context->bridge is NULL, so hotplug_event() calls
> > >     enable_slot() instead of acpiphp_check_bridge(), AND
> > > 
> > >   - acpiphp_slot->bus->self is also NULL, because enable_slot() calls
> > >     pci_assign_unassigned_bridge_resources() with that NULL pointer,
> > >     which dereferences "bridge->subordinate"
> > > 
> > > But I can't figure out why acpiphp_context->bridge is NULL for RP07
> > > and RP08 (which don't exist), but not for RP03 (which does).
> > > 
> > > I guess all the acpiphp_contexts (RP03, RP07, RP08) must be allocated in
> > > acpiphp_add_context() by acpiphp_init_context().
> > > 
> > > Woody's lspci from [1] shows only one Root Port:
> > > 
> > >   00:1c.0 Wildcat Point-LP PCI Express Root Port #3
> > > 
> > > The DSDT.DSL includes:
> > > 
> > >   Device (RP01) _ADR 0x001C0000		# 1c.0
> > >   Device (RP02) _ADR 0x001C0001		# 1c.1
> > >   Device (RP03) _ADR 0x001C0002		# 1c.2
> > >   Device (RP04) _ADR 0x001C0003		# 1c.3
> > >   Device (RP05) _ADR 0x001C0004		# 1c.4
> > >   Device (RP06) _ADR 0x001C0005		# 1c.5
> > >   Device (RP07) _ADR 0x001C0006		# 1c.6
> > >   Device (RP08) _ADR 0x001C0007		# 1c.7
> > > 
> > > I can see why we might need a Bus Check after resume to see if
> > > something got added while we were suspended.  But I don't see why we
> > > handle RP03 differently from RP07 and RP08.

[...]

Looks like I was correct in my assumption:
ACPI descriptor doesn't distinguish between PCI devices vs bridges.
PCI code enumerates host-bridge first:

 acpiphp_enumerate_slots 
 acpi_pci_add_bus+0x55/0xf0
 pci_register_host_bridge+0x230/0x510
 pci_create_root_bus+0x86/0xb0
 acpi_pci_root_create+0x182/0x2e0

that creates acpi context for direct children, after that
later within acpi_pci_root_create(), pci_scan_child_bus()
is called:

 acpiphp_enumerate_slots+0x1f/0x2b0
 acpi_pci_add_bus+0x55/0xf0
 pci_add_new_bus+0x25c/0x4b0
 pci_scan_bridge_extend+0x655/0x6a0
 pci_scan_child_bus_extend+0xc7/0x290
 acpi_pci_root_create+0x262/0x2e0

which does brute force scan for present devices and if a device is a bridge
it initializes new bus, slot[s] (incl. acpi context with bridge) ... 

While for non existing root-port, acpi context created by the 1st
acpiphp_enumerate_slots() called from host-bridge is only abstract
acpi device handle (kernel doesn't have sufficient data to do anything with it).

So it effectively degrades to hotplug on host-bridge, and enable_slot(...,false)
would try to bring up all new devices in slot/bus.

Where it gets confusing is that DSDT says that native
PCIe hotplug should be used and dmesg confirms that.
But commit 84c8b58ed3add indicates that both hotplug
methods could be used at the same time sometimes.
I'm not sure how that is supposed to work.

> > > Bjorn
> > > 
> > > [1] https://lore.kernel.org/r/92150d8d-8a3a-d600-a996-f60a8e4c876c@gmail.com
> > >   
> > 
> >   
> 

