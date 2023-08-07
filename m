Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829AB77250F
	for <lists+linux-pci@lfdr.de>; Mon,  7 Aug 2023 15:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbjHGNIv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 09:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjHGNIu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 09:08:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F8E171A
        for <linux-pci@vger.kernel.org>; Mon,  7 Aug 2023 06:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691413670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jme0rhfzh6JhD99ZB8QzeloyQi3m6yoYS6ZHD9wuvr8=;
        b=a6IePgmJ8TUo0/05KHF6PBSiS6vjHiM4cz4Xeg/LDabRinThIW4sIxfoIXt/+jE464CMQz
        AfkwLEfGVy3kBu2NuJzxnzaqaQmNCXvcY5yiGuE7yAEuSXoYwsTGfvjpBrwJQwi7ZDOCPa
        mLchtT4Rvg2WgiyrLQ029oOk/Pc/DkM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-ReeE8exuOMyqx2f0ZiH0Kw-1; Mon, 07 Aug 2023 09:07:48 -0400
X-MC-Unique: ReeE8exuOMyqx2f0ZiH0Kw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-978a991c3f5so362506666b.0
        for <linux-pci@vger.kernel.org>; Mon, 07 Aug 2023 06:07:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691413668; x=1692018468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jme0rhfzh6JhD99ZB8QzeloyQi3m6yoYS6ZHD9wuvr8=;
        b=UvJN0yLxFZ1fEpzR0SIfndng7bVo/p9BOP6S0XcgdTQJwLgazlQ1KtXIa0EskdqB4M
         y3aVc3EuyjX9ReNZiwJCER+ELAwK5O8frnWlp8nqlA5CFOPTLlj+Ehi9cUwEEqIoTtIC
         O3+TloMNuPaD5XCnwcfM2vLJxBcRoECIGP7Vl3o9VFhbaFG/RXMDG+qqWV4pTqdS5Wxh
         OrEQRg9eVOLSixdBsknmn2uTOC36QIwB3Npn1iQuAme0iKVZewBrH2p8Ll7aaAlJNNND
         B20o8uBRPb+zliiHvO6EPet6918SsWv+iMULfQLuSgHQF4b2ME8iCBeeJ5lv9/oIsMh/
         yfDg==
X-Gm-Message-State: AOJu0YxSCEsN/J5w6EW/OuXtt7KOgxiXn4bNDRD3SN2ripjmVjg9Kj99
        ladC0UoZtC8nLfIJATAKZpXxoVtGOGAc+CHAtaZVAOyQD/Ee04hAkXijf4lLqeVg3arXsBtngFT
        TVZpqB3LHO1NNAlZaEWt3
X-Received: by 2002:a17:906:1099:b0:99c:9e69:6a1c with SMTP id u25-20020a170906109900b0099c9e696a1cmr8450754eju.67.1691413667812;
        Mon, 07 Aug 2023 06:07:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvInCHNia93LEtdHlepW/JiEfDS2iww5AfvYdIACudI7+y/DnDZC10te1SlCSv/d3wNgreXw==
X-Received: by 2002:a17:906:1099:b0:99c:9e69:6a1c with SMTP id u25-20020a170906109900b0099c9e696a1cmr8450735eju.67.1691413667517;
        Mon, 07 Aug 2023 06:07:47 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id y16-20020a170906071000b00992d122af63sm5190783ejb.89.2023.08.07.06.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 06:07:46 -0700 (PDT)
Date:   Mon, 7 Aug 2023 15:07:46 +0200
From:   Igor Mammedov <imammedo@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, terraluna977@gmail.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org, mst@redhat.com,
        rafael@kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: acpiphp:: use
 pci_assign_unassigned_bridge_resources() only if bus->self not NULL
Message-ID: <20230807150746.71ca1df3@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230804232709.GA174043@bhelgaas>
References: <20230726123518.2361181-2-imammedo@redhat.com>
        <20230804232709.GA174043@bhelgaas>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 4 Aug 2023 18:27:09 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Wed, Jul 26, 2023 at 02:35:18PM +0200, Igor Mammedov wrote:
> > Commit [1] switched acpiphp hotplug to use
> >    pci_assign_unassigned_bridge_resources()
> > which depends on bridge being available, however in some cases
> > when acpiphp is in use, enable_slot() can get a slot without
> > bridge associated.  
> 
> acpiphp is *always* in use if we get to enable_slot(), so that doesn't
> really add information here.
> 
> >   1. legitimate case of hotplug on root bus
> >       (likely not exiting on real hw, but widely used in virt world)
> >   2. broken firmware, that sends 'Bus check' events to non
> >      existing root ports (Dell Inspiron 7352/0W6WV0), which somehow
> >      endup at acpiphp:enable_slot(..., bridge = 0) and with bus
> >      without bridge assigned to it.  

how about following commit message (incorporating all feed back in this thread):

-- cut --
Commit [1] switched acpiphp hotplug to use
   pci_assign_unassigned_bridge_resources()
which depends on bridge being available, however in case
when acpiphp is enabled [2], enable_slot() can be called without
bridge associated.
  1. legitimate case of hotplug on root bus
      (widely used in virt world)
  2. a (misbehaving) firmware, that sends 'Bus check' events
     to non existing root ports (Dell Inspiron 7352/0W6WV0),
     which endup at acpiphp:enable_slot(..., bridge = 0)
     where bus has not bridge assigned to it.
     acpihp doesn't know that it's a bridge, and bus specific
     'PCI subsystem' can't argument ACPI context with bridge
     information since the PCI device to get this data from
     is/was not available.

Issue is easy to reproduce with QEMU's 'pc' machine, which supports
PCI hotplug on hostbridge slots. To reproduce boot kernel at
commit [1] in VM started with following CLI (assuming guest root fs
is installed on sda1 partition):

   # qemu-system-x86_64 -M pc -m 1G -enable-kvm -cpu host \
         -monitor stdio -serial file:serial.log           \
         -kernel arch/x86/boot/bzImage                    \
         -append "root=/dev/sda1 console=ttyS0"           \
         guest_disk.img

once guest OS is fully booted at qemu prompt:

(qemu) device_add e1000

(check serial.log) it will cause NULL pointer dereference at:

    void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
    {
        struct pci_bus *parent = bridge->subordinate;

[  612.277651] BUG: kernel NULL pointer dereference, address: 0000000000000018
[...]
[  612.277798]  ? pci_assign_unassigned_bridge_resources+0x1f/0x260
[  612.277804]  ? pcibios_allocate_dev_resources+0x3c/0x2a0
[  612.277809]  enable_slot+0x21f/0x3e0
[  612.277816]  acpiphp_hotplug_notify+0x13d/0x260
[  612.277822]  ? __pfx_acpiphp_hotplug_notify+0x10/0x10
[  612.277827]  acpi_device_hotplug+0xbc/0x540
[  612.277834]  acpi_hotplug_work_fn+0x15/0x20
[  612.277839]  process_one_work+0x1f7/0x370
[  612.277845]  worker_thread+0x45/0x3b0
[  612.277850]  ? __pfx_worker_thread+0x10/0x10
[  612.277854]  kthread+0xdc/0x110
[  612.277860]  ? __pfx_kthread+0x10/0x10
[  612.277866]  ret_from_fork+0x28/0x40
[  612.277871]  ? __pfx_kthread+0x10/0x10
[  612.277876]  ret_from_fork_asm+0x1b/0x30

The issue was discovered on Dell Inspiron 7352/0W6WV0 laptop with
following sequence:
   1. suspend to RAM
   2. wake up with the same backtrace being observed:
   3. 2nd suspend to RAM attempt makes laptop freeze

Fix it by using __pci_bus_assign_resources() instead of
pci_assign_unassigned_bridge_resources() as we used to do
but only in case when bus doesn't have a bridge associated
(to cover for the case of ACPI event on hostbridge or
non existing root port).

That let us keep hotplug on root bus working like it used to be
and at the same time keeps resource reassignment usable on
root ports (and other 1st level bridges) that was fixed by [1].

1)
Fixes: 40613da52b13 ("PCI: acpiphp: Reassign resources on bridge if necessary")
2) CONFIG_HOTPLUG_PCI_ACPI=y

-- cut --

if commit message is looking acceptable to you, I can respin
amended patch with your suggestions taken in account.

> IIUC, the Inspiron problem happens when:
> 
>   - acpiphp_context->bridge is NULL, so hotplug_event() calls
>     enable_slot() instead of acpiphp_check_bridge(), AND
> 
>   - acpiphp_slot->bus->self is also NULL, because enable_slot() calls
>     pci_assign_unassigned_bridge_resources() with that NULL pointer,
>     which dereferences "bridge->subordinate"
> 
> But I can't figure out why acpiphp_context->bridge is NULL for RP07
> and RP08 (which don't exist), but not for RP03 (which does).
> 
> I guess all the acpiphp_contexts (RP03, RP07, RP08) must be allocated in
> acpiphp_add_context() by acpiphp_init_context().
> 
> Woody's lspci from [1] shows only one Root Port:
> 
>   00:1c.0 Wildcat Point-LP PCI Express Root Port #3
> 
> The DSDT.DSL includes:
> 
>   Device (RP01) _ADR 0x001C0000		# 1c.0
>   Device (RP02) _ADR 0x001C0001		# 1c.1
>   Device (RP03) _ADR 0x001C0002		# 1c.2
>   Device (RP04) _ADR 0x001C0003		# 1c.3
>   Device (RP05) _ADR 0x001C0004		# 1c.4
>   Device (RP06) _ADR 0x001C0005		# 1c.5
>   Device (RP07) _ADR 0x001C0006		# 1c.6
>   Device (RP08) _ADR 0x001C0007		# 1c.7
> 
> I can see why we might need a Bus Check after resume to see if
> something got added while we were suspended.  But I don't see why we
> handle RP03 differently from RP07 and RP08.
> 
> Can you help me out?  I'm lost in a maze of twisty passages, all
> alike.

I'll try to trace call path and see where it leads
(based on a guess in updated commit message: OS/nor ACPI
has info if it's bridge when the device didn't exists
during boot).

(though, I don't think it should hold this patch.
while it would be good to understand where bridge
gets added in acpi context, it's not directly relevant
to the fixing hotplug on hostbridge and buscheck events 
on non-existing root-ports)

> Bjorn
> 
> [1] https://lore.kernel.org/r/92150d8d-8a3a-d600-a996-f60a8e4c876c@gmail.com
> 


