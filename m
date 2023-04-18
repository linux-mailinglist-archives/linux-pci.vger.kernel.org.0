Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8841B6E6995
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 18:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjDRQb2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 12:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbjDRQbX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 12:31:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7178BC66A;
        Tue, 18 Apr 2023 09:31:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08DB6613FB;
        Tue, 18 Apr 2023 16:31:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343AEC433EF;
        Tue, 18 Apr 2023 16:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681835476;
        bh=EnkGpZ0KT5wQZ3p6H2OsLu3RjSBEBA8xTMop2/9F6P0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uWDfL7nwvc14b7pg1yK7n42vedIfE0SYdtcDNvIetym7pJWbeEKYA1swuoQld8PLa
         cZUN2TplBTd/RJhOgdN34Lc1mmOLlplg/GSsedT8yPf8obqFjvBGN/ChiXdGSDDU+B
         MBbXPtnT3QNrA+1pzuC+fgwr40r0+VPQx4BaKHaqt6/JM/Q30nQf8iCSBr3KoKxnbC
         VKG6vRCZaFxq8Ut/B7cag6K482wnhOoZcF28l9cAJYTi7ctxbFLMkTcLQp5hTgk8P+
         gt9aDQrEEF+WljFnSgQt01dF0fEAM784lCnZGN0OjAxPcbjxUNtQ993Kla3svfop7q
         xrYh6crrxLqXw==
Date:   Tue, 18 Apr 2023 11:31:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Igor Mammedov <imammedo@redhat.com>, linux-kernel@vger.kernel.org,
        mst@redhat.com, lenb@kernel.org, bhelgaas@google.com,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] pci: acpiphp: try to reassign resources on bridge if
 necessary
Message-ID: <20230418163114.GA134491@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gWKwOiACmK9=ru5W15Kydv6JqKJ8d4ngzKC7jqAjjcpQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Mika, who made previous changes in this area]

On Tue, Apr 18, 2023 at 05:38:15PM +0200, Rafael J. Wysocki wrote:
> On Tue, Apr 18, 2023 at 4:17 PM Igor Mammedov <imammedo@redhat.com> wrote:
> > On Tue, 18 Apr 2023 14:55:29 +0200
> > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > > On Tue, Apr 18, 2023 at 10:50 AM Igor Mammedov <imammedo@redhat.com> wrote:
> > > >
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
> > > >    Unable to create vram_mapping
> > > >    qxl: probe of 0000:01:00.0 failed with error -12
> > > >
> > > > However when using native PCIe hotplug
> > > >   '-global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=off'
> > > > it works fine, since kernel attempts to reassign unused resources.
> > > > Use the same machinery as native PCIe hotplug to (re)assign resources.

Thanks for the nice reproducer and logs!

> > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > >
> > > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > or please let me know if you want me to pick this up.
> >
> > It would be nice if you could pick it up.
> 
> OK, I'll do that unless Bjorn tells me that he prefers to take it via
> the PCI tree.

It's OK with me if you pick this up, but please update the subject to
use the style of previous commits, e.g.,

  PCI: acpiphp: Reassign resources on bridge if necessary

Previous changes involving pci_assign_unassigned_bridge_resources() in
enable_slot() (these are from Mika, so I cc'd him in case he wants to
comment):

  84c8b58ed3ad ("ACPI / hotplug / PCI: Don't scan bridges managed by native hotplug")
  77adf9355304 ("ACPI / hotplug / PCI: Allocate resources directly under the non-hotplug bridge")

> > > > ---
> > > > tested in QEMU with Q35 machine on PCIE root port and also
> > > > with nested conventional bridge attached to root port.
> > > > ---
> > > >  drivers/pci/hotplug/acpiphp_glue.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> > > > index 5b1f271c6034..9aebde28a92f 100644
> > > > --- a/drivers/pci/hotplug/acpiphp_glue.c
> > > > +++ b/drivers/pci/hotplug/acpiphp_glue.c
> > > > @@ -517,7 +517,7 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)

Previous context:

                                             __pci_bus_size_bridges(dev->subordinate,
                                                                    &add_list);

> > > >                                 }
> > > >                         }
> > > >                 }
> > > > -               __pci_bus_assign_resources(bus, &add_list, NULL);
> > > > +               pci_assign_unassigned_bridge_resources(bus->self);

"add_list" is now used only for __pci_bus_size_bridges(), which
*looks* unnecessary unless there's some obscure side-effect of that
path when that parameter is non-NULL.

If "add_list" is unnecessary, you would probably use
pci_bus_size_bridges() above instead of __pci_bus_size_bridges().

After this patch, we have:

  if (bridge && bus->self && hotplug_is_native(bus->self)) {
    for_each_pci_bridge(dev, bus)
      acpiphp_native_scan_bridge(dev);
  } else {
    ...
    pci_assign_unassigned_bridge_resources(bus->self);
  }

We do not do pci_assign_unassigned_bridge_resources() in the "then"
part of the "if".  Per the comment, that case may be used for adding
Thunderbolt controllers.  Is there a reason we do not want
pci_assign_unassigned_bridge_resources() in that path, or should it be
in both cases?

> > > >         }
> > > >
> > > >         acpiphp_sanitize_bus(bus);
