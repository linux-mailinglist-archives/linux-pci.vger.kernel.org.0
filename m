Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3ABA7668EA
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jul 2023 11:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbjG1Jdj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jul 2023 05:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbjG1Jd3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jul 2023 05:33:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C454209
        for <linux-pci@vger.kernel.org>; Fri, 28 Jul 2023 02:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690536740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PUpytj5yUNrs3kxSkN6zpJqxqa3HoC6l1C2y3i10Sbc=;
        b=N2h+kbOQ/aT4dmn2rcpwv66Z7ZqDQzN5SyGcebICWbpl4cyQOg1IzhYegImdMRodIlExL+
        c3qvjL1GaSxor3NzVRIfySC0tBV9kCNg5GLDIdMYpIUSQZNRkUmwrQs211p1KIkY76MMWZ
        xlONjaycCD3HmwoNj5mQWk8eSynlnLg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-BnON7P28MKOPy-8Ix4OYJA-1; Fri, 28 Jul 2023 05:32:19 -0400
X-MC-Unique: BnON7P28MKOPy-8Ix4OYJA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fbab56aac7so10795185e9.1
        for <linux-pci@vger.kernel.org>; Fri, 28 Jul 2023 02:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690536738; x=1691141538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUpytj5yUNrs3kxSkN6zpJqxqa3HoC6l1C2y3i10Sbc=;
        b=j/4ZBbuMnGvUajiHdv/+cmGkGIL2qt/antGQ2S3PgLpcFpPCrcmo4UQpuD0p0Pzblc
         D72o0uqPJOIdmjA3aQWEiHNQYUP7yKGUAbCtbVJBHxznPTKQFn6Igf/iHNgdQ677DZ4j
         IL73519vaeuaEpvQ6ATFUn3nRVOR9Z4zhiogp8KylUOe8G2OGJi97HUFlToB627Cse8C
         XPUrNAKjBYHpuURB2K3dSMDSjtCUX1hWg+v4KC9+5FK64s066qSfORfNIY1yZVEDnYTe
         oHgLDpYHkIwECSRSs+jCbrRY6ed82UvRq/647EFKzqUQPYtQMmznV3NCB9yGnbVO/cTs
         b2nA==
X-Gm-Message-State: ABy/qLZqpZxwPNK0utGLA4ThLA/j2ENuAsRm4mO5wGlPaXEkg1RluZ9X
        pQvXCL+0A/48p2EE/Irera4o0Zp33s1OBEHKetCDtuaF/pU6oumBXWf0iQhRrn9vwTZvON+aDUx
        ZUG0GDv4FGF/uaj0audSh
X-Received: by 2002:a1c:ed0e:0:b0:3fc:5a3:367c with SMTP id l14-20020a1ced0e000000b003fc05a3367cmr1397477wmh.32.1690536738011;
        Fri, 28 Jul 2023 02:32:18 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGJ0ZJIOZj9cnw9EBMK5YcoiQG18GglmeHsszodanL4lUHj6bphDDU+iSErcJ6q6IMB3uTENw==
X-Received: by 2002:a1c:ed0e:0:b0:3fc:5a3:367c with SMTP id l14-20020a1ced0e000000b003fc05a3367cmr1397462wmh.32.1690536737627;
        Fri, 28 Jul 2023 02:32:17 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id d12-20020a1c730c000000b003fa999cefc0sm3670492wmb.36.2023.07.28.02.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 02:32:16 -0700 (PDT)
Date:   Fri, 28 Jul 2023 11:32:16 +0200
From:   Igor Mammedov <imammedo@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, terraluna977@gmail.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org, mst@redhat.com,
        rafael@kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: acpiphp:: use
 pci_assign_unassigned_bridge_resources() only if bus->self not NULL
Message-ID: <20230728113216.3140577c@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230727174102.GA689794@bhelgaas>
References: <20230726123518.2361181-2-imammedo@redhat.com>
        <20230727174102.GA689794@bhelgaas>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 27 Jul 2023 12:41:02 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> Thank you to both you and Woody for chasing this down!
> 
> On Wed, Jul 26, 2023 at 02:35:18PM +0200, Igor Mammedov wrote:
> > Commit [1] switched acpiphp hotplug to use
> >    pci_assign_unassigned_bridge_resources()
> > which depends on bridge being available, however in some cases
> > when acpiphp is in use, enable_slot() can get a slot without
> > bridge associated.
> >   1. legitimate case of hotplug on root bus
> >       (likely not exiting on real hw, but widely used in virt world)
> >   2. broken firmware, that sends 'Bus check' events to non
> >      existing root ports (Dell Inspiron 7352/0W6WV0), which somehow
> >      endup at acpiphp:enable_slot(..., bridge = 0) and with bus
> >      without bridge assigned to it.  
> 
> Do we have evidence about the details of this non-existent root port?
> If we do, I think it would be interesting to include a URL to them in
> case there's some hole in the way we handle Bus Check events.

it's scattered over logs Woody has provided, here are links to
emails with
  1: lspci output
      https://lore.kernel.org/r/92150d8d-8a3a-d600-a996-f60a8e4c876c@gmail.com/

according to lscpi and dmesg there is only one root-port at 1c.0
which is occupied by wifi card

while DSTD table has more ports described, which is fine as long as
missing/disabled are not reported as present.

  2: last round of logs with debug patch /before 40613da5, with 40613da5, and after/
      https://lore.kernel.org/r/46437825-3bd0-2f8a-12d8-98a2b54d7c22@gmail.com/

here dmesg shows 1st correct port
 ACPI: \_SB_.PCI0.RP03: acpiphp_glue: Bus check in hotplug_event(): bridge: 000000000dad0b34
and then later on
 ACPI: \_SB_.PCI0.RP07: acpiphp_glue: Bus check in hotplug_event(): bridge: 0000000000000000
 ACPI: \_SB_.PCI0.RP08: acpiphp_glue: Bus check in hotplug_event(): bridge: 0000000000000000
which aren't recognized as bridge

I don't know ACPICA code enough to guesstimate where we might miss
a check that device is actually exists to do further debug
over mail list within reasonable timeframe.

> > Issue is easy to reproduce with QEMU's 'pc' machine provides
> > PCI hotplug on hostbridge slots. to reproduce boot kernel at
> > commit [1] in VM started with followin CLI and hotplug a device:  
> 
> You mention CLI; did you mean to include a qemu command line here?
> Maybe it's the same thing mentioned in the 40613da52b13 commit log?
> I tried briefly to reproduce this using the 40613da52b13 command line
> but haven't quite got it going yet.  I think it would be very useful
> to either include it here again or point to the 40613da52b13 commit
> log.

my bad, I didn't realize that saying 'pc' machine is not sufficient.

minimal CLI can be (important part '-M pc -monitor stdio',
the rest is for making guest boot and run at tolerable speed):

$QEMU -M pc -m 4G -monitor stdio -cpu host --enable-kvm vm_disk_image 

Will you amend commit message or shall I repost with changes/Acks?

> > once guest OS is fully booted at qemu prompt:
> > 
> > (qemu) device_add e1000
> > 
> > it will cause NULL pointer dereference at
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
> > pci_assign_unassigned_bridge_resources()as we used to do
> > but only in case when bus doesn't have a bridge associated
> > with it.
> > 
> > That let us keep hotplug on root bus working like it used to be
> > but at the same time keeps resource reassignment usable on
> > root ports (and other 1st level bridges) that was fixed by [1].
> > 
> > 1)
> > Fixes: 40613da52b13 ("PCI: acpiphp: Reassign resources on bridge if necessary")
> > Link: https://lore.kernel.org/r/11fc981c-af49-ce64-6b43-3e282728bd1a@gmail.com
> > Reported-by: Woody Suwalski <terraluna977@gmail.com>
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  drivers/pci/hotplug/acpiphp_glue.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> > index 328d1e416014..3bc4e1f3efee 100644
> > --- a/drivers/pci/hotplug/acpiphp_glue.c
> > +++ b/drivers/pci/hotplug/acpiphp_glue.c
> > @@ -498,6 +498,7 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
> >  				acpiphp_native_scan_bridge(dev);
> >  		}
> >  	} else {
> > +		LIST_HEAD(add_list);
> >  		int max, pass;
> >  
> >  		acpiphp_rescan_slot(slot);
> > @@ -511,10 +512,15 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
> >  				if (pass && dev->subordinate) {
> >  					check_hotplug_bridge(slot, dev);
> >  					pcibios_resource_survey_bus(dev->subordinate);
> > +					if (!bus->self)
> > +						__pci_bus_size_bridges(dev->subordinate, &add_list);
> >  				}
> >  			}
> >  		}
> > -		pci_assign_unassigned_bridge_resources(bus->self);
> > +		if (bus->self)
> > +			pci_assign_unassigned_bridge_resources(bus->self);
> > +		else
> > +			__pci_bus_assign_resources(bus, &add_list, NULL);
> >  	}
> >  
> >  	acpiphp_sanitize_bus(bus);
> > -- 
> > 2.39.3
> >   
> 

