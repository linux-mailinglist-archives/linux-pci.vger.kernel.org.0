Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B1A716CEA
	for <lists+linux-pci@lfdr.de>; Tue, 30 May 2023 20:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjE3SzU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 May 2023 14:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjE3SzQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 May 2023 14:55:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B121DFE;
        Tue, 30 May 2023 11:55:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45A82616B8;
        Tue, 30 May 2023 18:55:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F08AC433EF;
        Tue, 30 May 2023 18:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685472914;
        bh=NoRbVksJOadZRDSCO1GQDq2mQ1zZ++DBxXmDQAEDteI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uWq1qWhzQlJArWCmzRIMw+iVFQf61mAvdRzXZzPJTOjVtDUJiTkfOiUtq551/xFWy
         +RbOQk0z77rYCB9Z8DWkElee64UWcOv7j4ntrc704DTwhwCKAX1q5KDr3G20XpjD+9
         SX2AMQVo4/+TD0Xs1OAX5j6UkaNtmM1FL4IovKs1/GdL/rsOlgyvg1tjjgZAf/9JHA
         2Z5oq18RPQqHXGjW/bky673hL5jZnEaLEGWqVkZI/r7KeWIGQEoyl2g4AuIg9KtK0d
         pYlGzaUwvtsT8JgChA107Sfg/UczBtlS5FLZsxBNB9fqw+TehPBWwYJWTU9xO6UK9V
         eeSgqKho+Pg6A==
Date:   Tue, 30 May 2023 13:55:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Igor Mammedov <imammedo@redhat.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        mika.westerberg@linux.intel.com
Subject: Re: [PATCH v2] PCI: acpiphp: Reassign resources on bridge if
 necessary
Message-ID: <ZHZGkAg34ltZLV9J@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530141321-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 30, 2023 at 02:16:36PM -0400, Michael S. Tsirkin wrote:
> On Tue, May 30, 2023 at 12:12:44PM -0500, Bjorn Helgaas wrote:
> > On Mon, Apr 24, 2023 at 09:15:57PM +0200, Igor Mammedov wrote:
> > > When using ACPI PCI hotplug, hotplugging a device with
> > > large BARs may fail if bridge windows programmed by
> > > firmware are not large enough.
> > > 
> > > Reproducer:
> > >   $ qemu-kvm -monitor stdio -M q35  -m 4G \
> > >       -global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=on \
> > >       -device id=rp1,pcie-root-port,bus=pcie.0,chassis=4 \
> > >       disk_image
> > > 
> > >  wait till linux guest boots, then hotplug device
> > >    (qemu) device_add qxl,bus=rp1
> > > 
> > >  hotplug on guest side fails with:
> > >    pci 0000:01:00.0: [1b36:0100] type 00 class 0x038000
> > >    pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x03ffffff]
> > >    pci 0000:01:00.0: reg 0x14: [mem 0x00000000-0x03ffffff]
> > >    pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x00001fff]
> > >    pci 0000:01:00.0: reg 0x1c: [io  0x0000-0x001f]
> > >    pci 0000:01:00.0: BAR 0: no space for [mem size 0x04000000]
> > >    pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x04000000]
> > >    pci 0000:01:00.0: BAR 1: no space for [mem size 0x04000000]
> > >    pci 0000:01:00.0: BAR 1: failed to assign [mem size 0x04000000]
> > >    pci 0000:01:00.0: BAR 2: assigned [mem 0xfe800000-0xfe801fff]
> > >    pci 0000:01:00.0: BAR 3: assigned [io  0x1000-0x101f]
> > >    qxl 0000:01:00.0: enabling device (0000 -> 0003)
> > 
> > Ugh, I just noticed that we turned on PCI_COMMAND_MEMORY even though
> > BARs 0 and 1 haven't been assigned.  How did that happen?  It looks
> > like pci_enable_resources() checks for that, but there must be a hole
> > somewhere.
> 
> Maybe because BAR2 was assigned? I think pci_enable_resources just
> does
>                 if (r->flags & IORESOURCE_MEM)
>                         cmd |= PCI_COMMAND_MEMORY;
> in a loop so if any memory BARs are assigned then PCI_COMMAND_MEMORY
> is set.

It does, but it also bails out if it finds IORESOURCE_UNSET:

  pci_enable_resources()
  {
    ...
    pci_dev_for_each_resource(dev, r, i) {
      ...
      if (r->flags & IORESOURCE_UNSET) {
        pci_err(dev, "can't enable device: BAR %d %pR not assigned\n");
        return -EINVAL;
      }
      ...
      if (r->flags & IORESOURCE_MEM)
        cmd |= PCI_COMMAND_MEMORY;
    }
    ...
  }

I expected that IORESOURCE_UNSET would still be there from
pci_assign_resource(), since we saw the "failed to assign" messages,
but there must be more going on.

Bjorn
