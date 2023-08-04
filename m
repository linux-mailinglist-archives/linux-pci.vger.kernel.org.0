Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A897702A9
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 16:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjHDOMJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 10:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjHDOMI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 10:12:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A495171D
        for <linux-pci@vger.kernel.org>; Fri,  4 Aug 2023 07:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691158279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DBAi/8K4DetiYFVQtB0yWHaCmH5B3bRjDXtQpZqWREk=;
        b=iEMhThm1fvNhNuZOyLKykfuamjvkEpPEleUmiii7HT8E5gzEZKM2GkSdmXUYW+1AX1Za8A
        36YzDVk6nZ278GVde0zl4qE4JEoQ9PlBcLvurBfKHL7IriKJ7kTYRZ86vO+Jvh/RBVsqwt
        hH3BoBoBS/JFHJlf2+KuXrhpftzeqO0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-5fxVurnTNFa1cpcrxJdGHw-1; Fri, 04 Aug 2023 10:11:18 -0400
X-MC-Unique: 5fxVurnTNFa1cpcrxJdGHw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b9b00a80e9so21402471fa.1
        for <linux-pci@vger.kernel.org>; Fri, 04 Aug 2023 07:11:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691158277; x=1691763077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBAi/8K4DetiYFVQtB0yWHaCmH5B3bRjDXtQpZqWREk=;
        b=ltA0nbdhg55u1k2PN/VIj9tAuFwKW/c8F62KaPTXLZHa9+FhK+/8l2fiuMYazQ35xU
         FZI7gZdl7qERRknez9iBuvK9JBO6rMQFEnP2q2u4/Wd2Oan84VyZtnwRVJUufvpJ+VDY
         m7bxFKIP/uqn3zfEaboBnVHiWbU98U/TJN7hIOP1kvZlFn2iCtZWoNPTvBhtuwvEuD95
         41rM+QRW0vLVN1MQgsNnZRycmF8uQ5vTUp3GREcoOGmCqnCIHcmhtsMCs9kvkExb9E5C
         RrKBY1cDzMbzEVHpb/7bqm6q9Ynv3U2NfiLN6FAfjr666u7imJdzgH3fjKS9+F6ENN/t
         ZP1Q==
X-Gm-Message-State: AOJu0YzVPfDel+wVrGo8E+99/6KaylkQYMdgJ7YWyM6+nefeo4mp33I6
        r1TI3viIKP+ymZSjfNi8RT3uf24Td+rDuxvK/VE7MnlSzk9Wh6glplFRYV4fFzes/du9ySKf9eN
        JtCNaHLgz6ZibiCvKnlqX
X-Received: by 2002:a2e:9d0c:0:b0:2b9:ec57:c331 with SMTP id t12-20020a2e9d0c000000b002b9ec57c331mr1721401lji.6.1691158277061;
        Fri, 04 Aug 2023 07:11:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbjVZ5H9WePqPTQDVQUMagi6J0dlhs09ra7BM4cUadq/077ALWjF03fHfyZqGV26znETTAKg==
X-Received: by 2002:a2e:9d0c:0:b0:2b9:ec57:c331 with SMTP id t12-20020a2e9d0c000000b002b9ec57c331mr1721381lji.6.1691158276709;
        Fri, 04 Aug 2023 07:11:16 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id v14-20020a17090690ce00b009893b06e9e3sm1373202ejw.225.2023.08.04.07.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 07:11:16 -0700 (PDT)
Date:   Fri, 4 Aug 2023 16:11:15 +0200
From:   Igor Mammedov <imammedo@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, terraluna977@gmail.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org, mst@redhat.com,
        rafael@kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: acpiphp:: use
 pci_assign_unassigned_bridge_resources() only if bus->self not NULL
Message-ID: <20230804161115.0ecf6c76@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230731214251.GA25106@bhelgaas>
References: <20230731144418.1d9c2baf@imammedo.users.ipa.redhat.com>
        <20230731214251.GA25106@bhelgaas>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 31 Jul 2023 16:42:51 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

Hi Bjorn,

Is there anything else for me to do to make this merged?
(just checked recent branches in pci tree, and 
 'Revert "PCI: acpiphp: Reassign resources on bridge if necessary'
is still there)

> On Mon, Jul 31, 2023 at 02:44:18PM +0200, Igor Mammedov wrote:
> > On Sat, 29 Jul 2023 16:50:09 -0500 Bjorn Helgaas <helgaas@kernel.org> wrote:  
> > > On Fri, Jul 28, 2023 at 11:32:16AM +0200, Igor Mammedov wrote:  
> > > > On Thu, 27 Jul 2023 12:41:02 -0500 Bjorn Helgaas <helgaas@kernel.org> wrote:    
> > > > > On Wed, Jul 26, 2023 at 02:35:18PM +0200, Igor Mammedov wrote:    
> > > > > > Commit [1] switched acpiphp hotplug to use
> > > > > >    pci_assign_unassigned_bridge_resources()
> > > > > > which depends on bridge being available, however in some cases
> > > > > > when acpiphp is in use, enable_slot() can get a slot without
> > > > > > bridge associated.
> > > > > >   1. legitimate case of hotplug on root bus
> > > > > >       (likely not exiting on real hw, but widely used in virt world)
> > > > > >   2. broken firmware, that sends 'Bus check' events to non
> > > > > >      existing root ports (Dell Inspiron 7352/0W6WV0), which somehow
> > > > > >      endup at acpiphp:enable_slot(..., bridge = 0) and with bus
> > > > > >      without bridge assigned to it.      
> 
> > > >   2: last round of logs with debug patch /before 40613da5, with 40613da5, and after/
> > > >       https://lore.kernel.org/r/46437825-3bd0-2f8a-12d8-98a2b54d7c22@gmail.com/
> > > > 
> > > > here dmesg shows 1st correct port
> > > >  ACPI: \_SB_.PCI0.RP03: acpiphp_glue: Bus check in hotplug_event(): bridge: 000000000dad0b34
> > > > and then later on
> > > >  ACPI: \_SB_.PCI0.RP07: acpiphp_glue: Bus check in hotplug_event(): bridge: 0000000000000000
> > > >  ACPI: \_SB_.PCI0.RP08: acpiphp_glue: Bus check in hotplug_event(): bridge: 0000000000000000
> > > > which aren't recognized as bridge    
> > > 
> > > Thanks, that does seem a little suspect.  ACPI r6.5 sec 5.6.6 says
> > > that when OSPM handles a Bus Check, it should "perform a Plug and Play
> > > re-enumeration operation on the device tree starting from the point
> > > where it has been notified."
> > > 
> > > PCI devices are enumerated by doing PCI config reads.  It would make
> > > sense to re-enumerate a PCI hierarchy starting with a PCI device
> > > that's already known to the OS, e.g., by scanning the secondary bus of
> > > a PCI-to-PCI bridge.
> > > 
> > > I think there are two problems here:
> > > 
> > >   1) The platform shouldn't send a Bus Check notification to a PCI
> > >      device that doesn't exist.  How could the OS re-enumerate
> > >      starting there?  
> > 
> > in case of reported laptop, DSDT provides Device Descriptors
> > for not existing root-ports.
> > 
> > OSPM can't do anything with it but to pass Notify event to
> > PCI bus-specific enumeration mechanism, and it's upto PCI subsystem
> > to discard/ignore Notify() on this ACPI node.  
> 
> That seems backwards to me, but we have a fair bit of ACPI and PCI
> stuff that's backwards.
> 
> > >   2) Linux runs acpiphp_hotplug_notify() for Bus Checks to
> > >      non-existent PCI devices when it ignore them; reasoning below.
> > > 
> > > We call acpiphp_enumerate_slots() in this path, which happens before
> > > any of the PCI devices on the root bus have been enumerated:
> > > 
> > >   pci_register_host_bridge
> > >     pcibios_add_bus(root bus)
> > >       acpi_pci_add_bus
> > >         acpiphp_enumerate_slots(pci_bus *bus)
> > >           acpi_walk_namespace(acpiphp_add_context)
> > >             acpiphp_add_context(struct acpiphp_bridge *)
> > >               acpi_evaluate_integer("_ADR")
> > >               acpiphp_init_context
> > >                 context->hp.notify = acpiphp_hotplug_notify
> > > 
> > > So now we've already looked at RP03, RP07, and RP08, and set up the
> > > .notify() handler for all of them.  Since we haven't scanned the bus
> > > yet, we don't know that RP03 exists and RP07 and RP08 do not.  
> > 
> > While ACPI doesn't forbid firmware to describe non-existing RP,
> > the PCIe hostbridge can't hotplug extra root ports. (and QEMU
> > follows PCIe design in this respect on 'q35' machine).
> > 
> > However when it comes to hotplug on QEMU's 'pc' machine
> > (hotplug on root bus), each slot has "Augmented Device
> > Descriptors", that includes un-populated slots leading to
> > the presence of .notify() handler on such slots.
> > 
> > Then later on when device is hotplugged, a Notify(,1/*DeviceCheck*/)
> > is sent to previously empty slot and from there on PCI subsystem
> > re-enumerates either a single device or a bridge hierarchy
> > (from the parent context).
> > 
> > So I'd assume that we need to have .notify() handler for all slots
> > that are described in DSDT (present and non present).  
> 
> Just from a "beautiful design" perspective, it seems suboptimal for
> the ACPI device tree to have to include Device objects for all
> possible hot-added devices.
> 
> I would expect hot-add to be handled via a Bus Check to the *parent*
> of a new device, so the device tree would only need to describe
> hardware that's present at boot.  That would mean pci_root.c would
> have some .notify() handler, but I don't see anything there.
> 
> I don't know if platforms really implement Root Port hot-add (maybe
> qemu?), but if they do, I could believe they might do it via Notify to
> an ACPI Device for a non-present hardware device.  I wouldn't know
> whether that's the intent of the spec, or just a reaction to something
> that happened to work with existing OSes.
> 
> > >   $ qemu-system-x86_64 -M pc -m 512M -monitor stdio -cpu host --enable-kvm -kernel arch/x86/boot/bzImage -drive format=raw,file=ubuntu.img -append "root=/dev/sda1"
> > >   (qemu) device_add e1000
> > > 
> > > (For posterity, replacing "-monitor stdio" with "-nographic -monitor
> > > telnet:localhost:7001,server,nowait,nodelay" and adding
> > > "console=ttyS0,115200n8" to the -append made it easier to see the
> > > crash details.)  
> > 
> > I've not put extra arguments, because there is a lot of ways
> > one can configure/use monitor/serial options.
> > 
> > But specifying full command line like yours will be useful
> > for anyone who doesn't have any experience with QEMU CLI.  
> 
> Yep, that's the audience :)  I want to make it as easy as reasonably
> possible for non-qemu experts to repro things.
> 
> > > I really wish we didn't have such different resource assignment paths
> > > depending on whether the device is on a root bus or deeper in the
> > > hierarchy.  But we can't fix that now, so this seems like the right
> > > thing.  
> > 
> > I've looked at possibility of making 
> >   pci_assign_unassigned_bridge_resources()
> > work without bridge pointer, but it looks not viable as it's
> > a bridge dedicated function which on top of rearranging
> > resources, also disables/reprograms/enables bridge.
> > 
> > If there are ideas how to make it better,
> > I can pick it up and try to implement.
> > 
> > Testing shows that pci_assign_unassigned_bridge_resources()
> > isn't ideal since it releases all resources before reassigning
> > and then if the later fails bridge stays in mis-configured
> > state (attempt to recover results in failing BAR assignment
> > to children devices).
> > It's not issue in case of
> >   root-port -> 1 child device hotplug
> > since root port hadn't any working device[s] behind it.
> > But in case of hotplug into PCI bridge, that leaves
> > pre-existing devices behind the bridge broken (SHPC and acpiphp case).  
> 
> Yeah, it's a complicated mess.  That's why I didn't think this would
> be a viable fix in the short term.
> 
> Bjorn
> 

