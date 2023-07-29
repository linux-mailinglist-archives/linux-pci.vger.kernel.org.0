Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0110176820B
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jul 2023 23:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjG2VuP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Jul 2023 17:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjG2VuO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Jul 2023 17:50:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630F12733;
        Sat, 29 Jul 2023 14:50:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DACCB60AF2;
        Sat, 29 Jul 2023 21:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE68CC433C8;
        Sat, 29 Jul 2023 21:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690667411;
        bh=Ezthvn65lOAkT9EOruMybxawg2mE/UwoELe3RFgmO6M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NjuMSCluKdbvbxEyxmQnlKE9wxyc7qoi8us3aPnGwWc1TYA2mEO0ilDhh2Nf2eQ8j
         ra+PalXEHmERYbj/WrfN1OaKLPmEGf2Z61TLjKejrpGZ0Db3bKA4w1AVVBBeRvkGic
         FZt3USMb81EhF/gxKV5qse344vQAlLhMDcKFrog5r2d6iZ+NibxL5wJjH7YIBQXGHi
         voEZxeyRnQrm1syGkLI4y+zXun7LwE4Z1VGPg8f1Hvmshb9kGUXapJHfn1foc7FXOJ
         7/T6ObWeOvWYNe7C9NjV5LrfSQvs5To2s6+ugxqFSHEfhh3IioumDTLDC3IuYp9onJ
         kY5ghkl9k8sZg==
Date:   Sat, 29 Jul 2023 16:50:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Igor Mammedov <imammedo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, terraluna977@gmail.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org, mst@redhat.com,
        rafael@kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: acpiphp:: use
 pci_assign_unassigned_bridge_resources() only if bus->self not NULL
Message-ID: <20230729215009.GA820749@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728113216.3140577c@imammedo.users.ipa.redhat.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 28, 2023 at 11:32:16AM +0200, Igor Mammedov wrote:
> On Thu, 27 Jul 2023 12:41:02 -0500 Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Jul 26, 2023 at 02:35:18PM +0200, Igor Mammedov wrote:
> > > Commit [1] switched acpiphp hotplug to use
> > >    pci_assign_unassigned_bridge_resources()
> > > which depends on bridge being available, however in some cases
> > > when acpiphp is in use, enable_slot() can get a slot without
> > > bridge associated.
> > >   1. legitimate case of hotplug on root bus
> > >       (likely not exiting on real hw, but widely used in virt world)
> > >   2. broken firmware, that sends 'Bus check' events to non
> > >      existing root ports (Dell Inspiron 7352/0W6WV0), which somehow
> > >      endup at acpiphp:enable_slot(..., bridge = 0) and with bus
> > >      without bridge assigned to it.  
> > 
> > Do we have evidence about the details of this non-existent root port?
> > If we do, I think it would be interesting to include a URL to them in
> > case there's some hole in the way we handle Bus Check events.
> 
> it's scattered over logs Woody has provided, here are links to
> emails with
>   1: lspci output
>       https://lore.kernel.org/r/92150d8d-8a3a-d600-a996-f60a8e4c876c@gmail.com/
> 
> according to lscpi and dmesg there is only one root-port at 1c.0
> which is occupied by wifi card
> 
> while DSTD table has more ports described, which is fine as long as
> missing/disabled are not reported as present.
> 
>   2: last round of logs with debug patch /before 40613da5, with 40613da5, and after/
>       https://lore.kernel.org/r/46437825-3bd0-2f8a-12d8-98a2b54d7c22@gmail.com/
> 
> here dmesg shows 1st correct port
>  ACPI: \_SB_.PCI0.RP03: acpiphp_glue: Bus check in hotplug_event(): bridge: 000000000dad0b34
> and then later on
>  ACPI: \_SB_.PCI0.RP07: acpiphp_glue: Bus check in hotplug_event(): bridge: 0000000000000000
>  ACPI: \_SB_.PCI0.RP08: acpiphp_glue: Bus check in hotplug_event(): bridge: 0000000000000000
> which aren't recognized as bridge

Thanks, that does seem a little suspect.  ACPI r6.5 sec 5.6.6 says
that when OSPM handles a Bus Check, it should "perform a Plug and Play
re-enumeration operation on the device tree starting from the point
where it has been notified."

PCI devices are enumerated by doing PCI config reads.  It would make
sense to re-enumerate a PCI hierarchy starting with a PCI device
that's already known to the OS, e.g., by scanning the secondary bus of
a PCI-to-PCI bridge.

I think there are two problems here:

  1) The platform shouldn't send a Bus Check notification to a PCI
     device that doesn't exist.  How could the OS re-enumerate
     starting there?

  2) Linux runs acpiphp_hotplug_notify() for Bus Checks to
     non-existent PCI devices when it ignore them; reasoning below.

We call acpiphp_enumerate_slots() in this path, which happens before
any of the PCI devices on the root bus have been enumerated:

  pci_register_host_bridge
    pcibios_add_bus(root bus)
      acpi_pci_add_bus
        acpiphp_enumerate_slots(pci_bus *bus)
          acpi_walk_namespace(acpiphp_add_context)
            acpiphp_add_context(struct acpiphp_bridge *)
              acpi_evaluate_integer("_ADR")
              acpiphp_init_context
                context->hp.notify = acpiphp_hotplug_notify

So now we've already looked at RP03, RP07, and RP08, and set up the
.notify() handler for all of them.  Since we haven't scanned the bus
yet, we don't know that RP03 exists and RP07 and RP08 do not.

Per ACPI r6.5, sec 6, all these Device objects are "Augmented Device
Descriptors":

  An Agumented [sic] Device Descriptor, which contains additional
  device information that is not provided from the Device itself, yet
  is needed by the Device or Bus driver in order to properly configure
  and use the device. This type of device is enumerated by a
  bus-specific enumeration mechanism, and OSPM uses the Address (_ADR)
  to match the ACPI Device object in the Namespace to the device
  discovered through bus enumeration.

I think that means OSPM should discover a PCI device using the PCI
bus-specific enumeration mechanism (i.e., config reads) before it even
looks for a corresponding ACPI Device object, and it should only set
up .notify() for PCI devices that actually exist, so the Bus Checks on
RP07 and RP08 would be ignored and we wouldn't even get into the path
that causes the NULL pointer dereference:

  acpi_device_hotplug
    acpiphp_hotplug_notify              # from hp.notify
      hotplug_event
        bridge = context->bridge
        case BUS_CHECK:
          if (bridge)
            acpiphp_check_bridge
          else if (!SLOT_IS_GOING_AWAY)
            enable_slot
              bus = slot->bus           # "bus" is a root bus
              pci_assign_unassigned_bridge_resources(bus->self)
                bridge = bus->self      # "bridge" is NULL since
                                        # bus->self is NULL for root buses
                struct pci_bus *parent = bridge->subordinate
                                        # NULL pointer dereference

Obviously none of this helps solve the current regression.  Changing
the .notify() setup would be a big change, it would be risky because
it might affect dock support, and it still wouldn't fix your case 1 of
hotplug on the root bus in a virtualized environment.

> > > Issue is easy to reproduce with QEMU's 'pc' machine provides
> > > PCI hotplug on hostbridge slots. to reproduce boot kernel at
> > > commit [1] in VM started with followin CLI and hotplug a device:  
> > 
> > You mention CLI; did you mean to include a qemu command line here?
> > Maybe it's the same thing mentioned in the 40613da52b13 commit log?
> > I tried briefly to reproduce this using the 40613da52b13 command line
> > but haven't quite got it going yet.  I think it would be very useful
> > to either include it here again or point to the 40613da52b13 commit
> > log.
> 
> my bad, I didn't realize that saying 'pc' machine is not sufficient.
> 
> minimal CLI can be (important part '-M pc -monitor stdio',
> the rest is for making guest boot and run at tolerable speed):
> 
> $QEMU -M pc -m 4G -monitor stdio -cpu host --enable-kvm vm_disk_image 
> 
> Will you amend commit message or shall I repost with changes/Acks?

I'll give it a shot and post it for your comments.

> > > once guest OS is fully booted at qemu prompt:
> > > 
> > > (qemu) device_add e1000
> > > 
> > > it will cause NULL pointer dereference at
> > > 
> > >     void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
> > >     {
> > >         struct pci_bus *parent = bridge->subordinate;

This worked for me (after setting CONFIG_HOTPLUG_PCI_ACPI=y :)):

  $ qemu-system-x86_64 -M pc -m 512M -monitor stdio -cpu host --enable-kvm -kernel arch/x86/boot/bzImage -drive format=raw,file=ubuntu.img -append "root=/dev/sda1"
  (qemu) device_add e1000

(For posterity, replacing "-monitor stdio" with "-nographic -monitor
telnet:localhost:7001,server,nowait,nodelay" and adding
"console=ttyS0,115200n8" to the -append made it easier to see the
crash details.)

> > > [  612.277651] BUG: kernel NULL pointer dereference, address: 0000000000000018
> > > [...]
> > > [  612.277798]  ? pci_assign_unassigned_bridge_resources+0x1f/0x260
> > > [  612.277804]  ? pcibios_allocate_dev_resources+0x3c/0x2a0
> > > [  612.277809]  enable_slot+0x21f/0x3e0
> > > [  612.277816]  acpiphp_hotplug_notify+0x13d/0x260
> > > [  612.277822]  ? __pfx_acpiphp_hotplug_notify+0x10/0x10
> > > [  612.277827]  acpi_device_hotplug+0xbc/0x540
> > > [  612.277834]  acpi_hotplug_work_fn+0x15/0x20
> > > [  612.277839]  process_one_work+0x1f7/0x370
> > > [  612.277845]  worker_thread+0x45/0x3b0
> > > [  612.277850]  ? __pfx_worker_thread+0x10/0x10
> > > [  612.277854]  kthread+0xdc/0x110
> > > [  612.277860]  ? __pfx_kthread+0x10/0x10
> > > [  612.277866]  ret_from_fork+0x28/0x40
> > > [  612.277871]  ? __pfx_kthread+0x10/0x10
> > > [  612.277876]  ret_from_fork_asm+0x1b/0x30
> > > 
> > > The issue was discovered on Dell Inspiron 7352/0W6WV0 laptop with
> > > following sequence:
> > >    1. suspend to RAM
> > >    2. wake up with the same backtrace being observed:
> > >    3. 2nd suspend to RAM attempt makes laptop freeze
> > > 
> > > Fix it by using __pci_bus_assign_resources() instead of
> > > pci_assign_unassigned_bridge_resources()as we used to do
> > > but only in case when bus doesn't have a bridge associated
> > > with it.
> > > 
> > > That let us keep hotplug on root bus working like it used to be
> > > but at the same time keeps resource reassignment usable on
> > > root ports (and other 1st level bridges) that was fixed by [1].
> > > 
> > > 1)
> > > Fixes: 40613da52b13 ("PCI: acpiphp: Reassign resources on bridge if necessary")
> > > Link: https://lore.kernel.org/r/11fc981c-af49-ce64-6b43-3e282728bd1a@gmail.com
> > > Reported-by: Woody Suwalski <terraluna977@gmail.com>
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > ---
> > >  drivers/pci/hotplug/acpiphp_glue.c | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> > > index 328d1e416014..3bc4e1f3efee 100644
> > > --- a/drivers/pci/hotplug/acpiphp_glue.c
> > > +++ b/drivers/pci/hotplug/acpiphp_glue.c
> > > @@ -498,6 +498,7 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
> > >  				acpiphp_native_scan_bridge(dev);
> > >  		}
> > >  	} else {
> > > +		LIST_HEAD(add_list);
> > >  		int max, pass;
> > >  
> > >  		acpiphp_rescan_slot(slot);
> > > @@ -511,10 +512,15 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
> > >  				if (pass && dev->subordinate) {
> > >  					check_hotplug_bridge(slot, dev);
> > >  					pcibios_resource_survey_bus(dev->subordinate);
> > > +					if (!bus->self)
> > > +						__pci_bus_size_bridges(dev->subordinate, &add_list);
> > >  				}
> > >  			}
> > >  		}
> > > -		pci_assign_unassigned_bridge_resources(bus->self);
> > > +		if (bus->self)
> > > +			pci_assign_unassigned_bridge_resources(bus->self);
> > > +		else
> > > +			__pci_bus_assign_resources(bus, &add_list, NULL);

I really wish we didn't have such different resource assignment paths
depending on whether the device is on a root bus or deeper in the
hierarchy.  But we can't fix that now, so this seems like the right
thing.

But would you be OK with this minor mod?

      if (pci_is_root_bus(bus))
        __pci_bus_size_bridges(dev->subordinate, &add_list);

  ...

  if (pci_is_root_bus(bus))
    __pci_bus_assign_resources(bus, &add_list, NULL);
  else
    pci_assign_unassigned_bridge_resources(bus->self);

For two reasons: (1) test the same condition both places, and (2) be a
little more explicit about the scenario (and "bus->self == NULL" also
happens for the virtual buses added for SR-IOV).

> > >  	}
> > >  
> > >  	acpiphp_sanitize_bus(bus);
> > > -- 
> > > 2.39.3
> > >   
> > 
> 
