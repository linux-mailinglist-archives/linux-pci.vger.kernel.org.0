Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8083171863E
	for <lists+linux-pci@lfdr.de>; Wed, 31 May 2023 17:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjEaPZY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 May 2023 11:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbjEaPYP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 May 2023 11:24:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60157E55
        for <linux-pci@vger.kernel.org>; Wed, 31 May 2023 08:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685546576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vim2Ps+SLhIjHN6Pns9HoI/IKeD0F9kbBagSaUaU/oo=;
        b=AG1NI4H1sjIqNJtsPCooz3InO3s3ITl8jIXh94OOO+d/D8Ouo1ihbMjNwYf7knnyxj5hfC
        aZoLP/qfgRgUFl84JR2vhELH0u+2od1cFLL+uqRwg15aAA7Vize8RwN8Nr2jzcTJLPcTq2
        rH7Jwp6XKWtSFAt5ruKGf/pM/LZEwmY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-w5gmfSYyM7uhdGA375DqGQ-1; Wed, 31 May 2023 11:22:39 -0400
X-MC-Unique: w5gmfSYyM7uhdGA375DqGQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-96fae2a13a5so494538866b.2
        for <linux-pci@vger.kernel.org>; Wed, 31 May 2023 08:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685546554; x=1688138554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vim2Ps+SLhIjHN6Pns9HoI/IKeD0F9kbBagSaUaU/oo=;
        b=MlEfuBafTNNFbCjyEYUOikP8uIi8QjtcJLoS+oWGfUxjGzuRQhf7W02lNm+36S+heL
         aQHxJyIRpkkzKb99Mqibxh/qELQ14x3OcstSql+22A7QjFWVBeSFb3cegNC8TGAsnar2
         lVmblCWHDK0S294qQFjWfxp7pleLUWoD9P3ZbpYBFERp+Z2hnSSET2r8eGruoJZ1f6bL
         63287C1dgRlEcW2EdZAFUHYQt/zykMhkFf+QqFpwAggf1wLBdmVxqypP5PHx+S8SHQL9
         8XnJsCYQLzbqXmPBB/VmdK4stW/17UK5xgv0a6Ca1aYHMC1XCmDbJy/z0E9tghilL6Bk
         Qu5w==
X-Gm-Message-State: AC+VfDzNJbL7aPLJQeGpH2aCKbd1/gMOphpfRulT2tGlpMrR4h2QMITm
        EihAdHh7XTRLgzXYpXuzl1QxDdNw8d70Loooz9CBxIZZMX+4D5lWE8QVUccV1VsprEaTRqWrAev
        ifh0ATXdNwvxuV2NMLNkZ
X-Received: by 2002:a17:907:eaa:b0:94f:7edf:8fa1 with SMTP id ho42-20020a1709070eaa00b0094f7edf8fa1mr6008752ejc.32.1685546554646;
        Wed, 31 May 2023 08:22:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4TfEMtyNeDIvoDZLtn9WZ6Ma5SEXbIKcUctEw0dFKuBxjkH16CQD3dCFTlwdMhGDeLM5IZ0g==
X-Received: by 2002:a17:907:eaa:b0:94f:7edf:8fa1 with SMTP id ho42-20020a1709070eaa00b0094f7edf8fa1mr6008739ejc.32.1685546554329;
        Wed, 31 May 2023 08:22:34 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id n21-20020a170906089500b00966265be7adsm9112590eje.22.2023.05.31.08.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 08:22:33 -0700 (PDT)
Date:   Wed, 31 May 2023 17:22:32 +0200
From:   Igor Mammedov <imammedo@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
        bhelgaas@google.com, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, mika.westerberg@linux.intel.com
Subject: Re: [PATCH v2] PCI: acpiphp: Reassign resources on bridge if
 necessary
Message-ID: <20230531172232.28cef6a3@imammedo.users.ipa.redhat.com>
In-Reply-To: <ZHZGkAg34ltZLV9J@bhelgaas>
References: <20230530141321-mutt-send-email-mst@kernel.org>
        <ZHZGkAg34ltZLV9J@bhelgaas>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 30 May 2023 13:55:12 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Tue, May 30, 2023 at 02:16:36PM -0400, Michael S. Tsirkin wrote:
> > On Tue, May 30, 2023 at 12:12:44PM -0500, Bjorn Helgaas wrote:  
> > > On Mon, Apr 24, 2023 at 09:15:57PM +0200, Igor Mammedov wrote:  
> > > > When using ACPI PCI hotplug, hotplugging a device with
> > > > large BARs may fail if bridge windows programmed by
> > > > firmware are not large enough.
> > > > 
> > > > Reproducer:
> > > >   $ qemu-kvm -monitor stdio -M q35  -m 4G \
> > > >       -global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=on \
> > > >       -device id=rp1,pcie-root-port,bus=pcie.0,chassis=4 \
> > > >       disk_image
> > > > 
> > > >  wait till linux guest boots, then hotplug device
> > > >    (qemu) device_add qxl,bus=rp1
> > > > 
> > > >  hotplug on guest side fails with:
> > > >    pci 0000:01:00.0: [1b36:0100] type 00 class 0x038000
> > > >    pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x03ffffff]
> > > >    pci 0000:01:00.0: reg 0x14: [mem 0x00000000-0x03ffffff]
> > > >    pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x00001fff]
> > > >    pci 0000:01:00.0: reg 0x1c: [io  0x0000-0x001f]
> > > >    pci 0000:01:00.0: BAR 0: no space for [mem size 0x04000000]
> > > >    pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x04000000]
> > > >    pci 0000:01:00.0: BAR 1: no space for [mem size 0x04000000]
> > > >    pci 0000:01:00.0: BAR 1: failed to assign [mem size 0x04000000]
> > > >    pci 0000:01:00.0: BAR 2: assigned [mem 0xfe800000-0xfe801fff]
> > > >    pci 0000:01:00.0: BAR 3: assigned [io  0x1000-0x101f]
> > > >    qxl 0000:01:00.0: enabling device (0000 -> 0003)  
> > > 
> > > Ugh, I just noticed that we turned on PCI_COMMAND_MEMORY even though
> > > BARs 0 and 1 haven't been assigned.  How did that happen?  It looks
> > > like pci_enable_resources() checks for that, but there must be a hole
> > > somewhere.  
> > 
> > Maybe because BAR2 was assigned? I think pci_enable_resources just
> > does
> >                 if (r->flags & IORESOURCE_MEM)
> >                         cmd |= PCI_COMMAND_MEMORY;
> > in a loop so if any memory BARs are assigned then PCI_COMMAND_MEMORY
> > is set.  
> 
> It does, but it also bails out if it finds IORESOURCE_UNSET:
> 
>   pci_enable_resources()
>   {
>     ...
>     pci_dev_for_each_resource(dev, r, i) {
>       ...
>       if (r->flags & IORESOURCE_UNSET) {
>         pci_err(dev, "can't enable device: BAR %d %pR not assigned\n");
>         return -EINVAL;
>       }
>       ...
>       if (r->flags & IORESOURCE_MEM)
>         cmd |= PCI_COMMAND_MEMORY;
>     }
>     ...
>   }
> 
> I expected that IORESOURCE_UNSET would still be there from
> pci_assign_resource(), since we saw the "failed to assign" messages,
> but there must be more going on.

with current acpiphp code pci_assign_resource() isn't called,
instead it goes __pci_bus_assign_resources() route.

However I an reproduce similar issue with SHPC when using
hierarchy deeper than 1 bridge (for which relocation has never worked)

qemu-kvm -monitor stdio -M q35 -cpu host -enable-kvm  -m 4G \
   -global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=off \
   -device pcie-root-port,id=pr1,bus=pcie.0,chassis=4 \
   -device pcie-pci-bridge,id=br1,bus=pr1

hotplug device
  (qemu) device_add qxl,addr=1,bus=br1

shpchp 0000:01:00.0: Latch close on Slot(1)
shpchp 0000:01:00.0: Button pressed on Slot(1)
shpchp 0000:01:00.0: Card present on Slot(1)
shpchp 0000:01:00.0: PCI slot #1 - powering on due to button press
pci 0000:02:01.0: [1b36:0100] type 00 class 0x038000
pci 0000:02:01.0: reg 0x10: [mem 0x00000000-0x03ffffff]
pci 0000:02:01.0: reg 0x14: [mem 0x00000000-0x03ffffff]
pci 0000:02:01.0: reg 0x18: [mem 0x00000000-0x00001fff]
pci 0000:02:01.0: reg 0x1c: [io  0x0000-0x001f]
pci 0000:02:01.0: BAR 0: no space for [mem size 0x04000000]
pci 0000:02:01.0: BAR 0: failed to assign [mem size 0x04000000]
pci 0000:02:01.0: BAR 1: no space for [mem size 0x04000000]
pci 0000:02:01.0: BAR 1: failed to assign [mem size 0x04000000]
pci 0000:02:01.0: BAR 2: assigned [mem 0xfe600000-0xfe601fff]
pci 0000:02:01.0: BAR 3: assigned [io  0xc000-0xc01f]
                  ^^^^^^^^^^^
shpchp 0000:01:00.0: PCI bridge to [bus 02]
shpchp 0000:01:00.0:   bridge window [io  0xc000-0xcfff]
shpchp 0000:01:00.0:   bridge window [mem 0xfe600000-0xfe7fffff]
shpchp 0000:01:00.0:   bridge window [mem 0xfe000000-0xfe1fffff 64bit pref]
PCI: No. 2 try to assign unassigned res
release child resource [mem 0xfe600000-0xfe601fff]
shpchp 0000:01:00.0: resource 8 [mem 0xfe600000-0xfe7fffff] released
shpchp 0000:01:00.0: PCI bridge to [bus 02]
shpchp 0000:01:00.0: BAR 8: no space for [mem size 0x0a000000]
shpchp 0000:01:00.0: BAR 8: failed to assign [mem size 0x0a000000]
pci 0000:02:01.0: BAR 0: no space for [mem size 0x04000000]
pci 0000:02:01.0: BAR 0: failed to assign [mem size 0x04000000]
pci 0000:02:01.0: BAR 1: no space for [mem size 0x04000000]
pci 0000:02:01.0: BAR 1: failed to assign [mem size 0x04000000]
pci 0000:02:01.0: BAR 2: no space for [mem size 0x00002000]
pci 0000:02:01.0: BAR 2: failed to assign [mem size 0x00002000]
shpchp 0000:01:00.0: PCI bridge to [bus 02]
shpchp 0000:01:00.0:   bridge window [io  0xc000-0xcfff]
shpchp 0000:01:00.0:   bridge window [mem 0xfe000000-0xfe1fffff 64bit pref]
qxl 0000:02:01.0: enabling device (0000 -> 0001)
                                           ^^^ IO res only
where:
  assign_requested_resources_sorted()
     ...
     if (pci_assign_resource())
        reset_resource(res);
reset wipes everything pci_assign_resource() has done for failing resources
leaving only assigned IO (on the 1st pass).
Then later pci_enable_device_flags() will build mask for available bars

        for (i = 0; i <= PCI_ROM_RESOURCE; i++)                                  
                if (dev->resource[i].flags & flags)                              
                        bars |= (1 << i);                                        
        for (i = PCI_BRIDGE_RESOURCES; i < DEVICE_COUNT_RESOURCE; i++)           
                if (dev->resource[i].flags & flags)                              
                        bars |= (1 << i);

however since for failed MEM resources reset cleared flags along with everything else, 
above snippet will ignore MEM bars, leaving only assigned IO resource.
Then
   do_pci_enable_device() -> pcibios_enable_device() -> pci_enable_resources(,bars)
will happily succeed since mask tells it only to look into IO.

And well even if mask weren't excluding MEM ones, it won't help since
the resource was cleared out in assign_requested_resources_sorted().

Perhaps instead of playing with flags, we should somehow mark device
with unusable resources as disabled, and fail pci_enable_device() early.
(and also make sure its resources aren't accounted anymore on follow
up hotplug events to the bridge)

