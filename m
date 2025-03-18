Return-Path: <linux-pci+bounces-24065-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17554A67F1D
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 22:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78A861758F1
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 21:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B711DEFDA;
	Tue, 18 Mar 2025 21:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1vjQMJl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1B41F0988
	for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 21:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742334627; cv=none; b=qcothMi6MOan4Rd5HuD8zMCRlXI5EZrC0IV8MWt05rmzJwp22f8YxZnHB1PZsXh1qXfug1J+ckmjr36cmLU6UHdxiNj7X5OhDNPRh3XpxnHAyMKfsQ6nheNRy/qYHeO01ZsyFNj1m9NVidIUcMGYz90j3aC0GOh+gruMhU9o0Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742334627; c=relaxed/simple;
	bh=JQ9fPiB+aEU+fIvz8wPy9BTF9ZmsJD9nneZKBwpD+Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=s0KUfnK9JOtP8w6bu2QwziLYLvWGIbYaCvNFO4xOp4CwgAfUClC4jMBfgoSRspEIPmNiInOUqoaajiy49tTrLaeeO/kNXR0IOB7crWBKJdOWm5u4bCDNn2MnDWiwHb7dHfLlszMoLkw/vD+w5zC4lJqXbCr3TYSN4QEjkg6kOn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1vjQMJl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77ECC4CEDD;
	Tue, 18 Mar 2025 21:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742334626;
	bh=JQ9fPiB+aEU+fIvz8wPy9BTF9ZmsJD9nneZKBwpD+Nw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=q1vjQMJlzMQkWmq2cdvemQJe0NXKqm1V9k3ptBAr5U9W+bjgR4ybx5GJnLq5s0P71
	 Tfh64xBdECJkb0xrq9aeCVzT1eWL7EiebBl7xXpkSAPL+6qrw2WiaErzDUFQhYJWdM
	 WMEup0PO3Illo4AwvblxGC0IAjo6u4Gn5iMEhZkwkzOA9E6BiGDfu9sE8xDN+dTwCv
	 3SjSW3JNrc9CRLuSnKginXU8VE3/woaZMV7kZ8wGpxSC3Wi4nhP6OYkJOZAz5yj8Zu
	 dFrG8OC8F3oBGXQrJRkFo/hhVb7rAM6TvaBfXWSg2u6CSXvukZJQIf6qu0jz5kui2p
	 DlhahlPML178Q==
Date: Tue, 18 Mar 2025 16:50:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Huacai Chen <chenhuacai@gmail.com>
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	Jianmin Lv <lvjianmin@loongson.cn>,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] PCI: loongson: Add quirk for OHCI device rev 0x02
Message-ID: <20250318215025.GA1012479@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H7c9jkXqwn2STdYq-1g4jVELjKL5jaO2aASFAETW5FLHw@mail.gmail.com>

[+cc Greg, USB maintainer; I'm proposing ohci_pci_quirks for this]

On Tue, Mar 18, 2025 at 09:07:10PM +0800, Huacai Chen wrote:
> On Sat, Mar 15, 2025 at 3:59 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Jan 21, 2025 at 07:42:25PM +0800, Huacai Chen wrote:
> > > The OHCI controller (rev 0x02) under LS7A PCI host has a hardware flaw.
> > > MMIO register with offset 0x60/0x64 is treated as legacy PS2-compatible
> > > keyboard/mouse interface, which confuse the OHCI controller. Since OHCI
> > > only use a 4KB BAR resource indeed, the LS7A OHCI controller's 32KB BAR
> > > is wrapped around (the second 4KB BAR space is the same as the first 4KB
> > > internally). So we can add an 4KB offset (0x1000) to the BAR resource as
> > > a workaround.
> >
> > It looks like usb_hcd_pci_probe() only uses BAR 0 in the OHCI case, so
> > I assume this OHCI controller has a single 32KB BAR?
>
> Yes.
> 
> > And you're saying that in that BAR, the 0x1000-0x1fff offsets are
> > aliases of the 0x0000-0x0fff area?
>
> Yes.
> 
> > And this causes some kind of problem because the OCHI driver looks at
> > offsets 0x60 and 0x64 into the BAR and sees something it doesn't like?
>
> Yes.
> 
> > And this quirk adds 0x1000 to the BAR start, so the OHCI driver looks
> > at offsets 0x1060 and 0x1064 of the original BAR, and that somehow
> > avoids a problem?  Even though those are aliases of 0x0060 and 0x0064
> > of the original BAR?
>
> Yes.
> 
> > > +static void loongson_ohci_quirk(struct pci_dev *dev)
> > > +{
> > > +     if (dev->revision == 0x2)
> > > +             dev->resource[0].start += 0x1000;
> >
> > What does this do to the iomem_resource tree?  IIUC, dev->resource[0]
> > no longer correctly describes the PCI address space consumed by the
> > device.
>
> In the iomem_resource tree the whole 32KB is requested for the OHCI
> controller.

I'm skeptical.  The quirk only updates the start, not the end, so I
think the resource is only 28KB after the quirk.

This is a final quirk, so I think the quirk runs after the BAR
resource has already been put in the iomem_resource tree.  We
shouldn't update the resource start/end after that point.

> > If the BAR is actually programmed with [mem 0x20000000-0x20007fff],
> > the device responds to PCI accesses in that range.  Now you update
> > resource[0] so it describes the space [mem 0x20001000-0x20008fff].  So
> > the kernel *thinks* the space at [mem 0x20000000-0x20000fff] is free
> > and available for something else, which is not true, and that the
> > device responds at [mem 0x0x20008000-0x20008fff], which is also not
> > true.
> >
> > I think the resource has already been put into the iomem_resource tree
> > by the time the final fixups are run, so this also may corrupt the
> > sorting of the tree.
> >
> > This just doesn't look safe to me.
>
> OHCI only uses 4KB io resources (hardware designer told me that this
> is from USB specification). So if the BAR is [mem
> 0x20000000-0x20007fff] and without this quirk, software will only
> use [mem 0x20000000-0x20000fff]; and if we do this quirk, software
> will only use [mem 0x20001000-0x20001fff]. Since the whole 32KB
> belongs to OHCI, there won't be corruption.

Here's the path where I think the BAR is requested.  Assume the BAR
contains 0x20000000 when we boot:

  acpi_pci_root_add
    pci_acpi_scan_root                  # loongson
      acpi_pci_root_create
        pci_scan_child_bus
          pci_scan_single_device        # details trimmed
            pci_scan_device
              pci_read_bases
                resource[0].start = 0x20000000
                resource[0].end   = 0x20007fff          # size 32KB
            pci_device_add
              pci_fixup_device(pci_fixup_header)        # <--
      pci_bus_assign_resources          # details trimmed
        pci_assign_resource
          pci_bus_alloc_resource
            allocate_resource
              __request_resource        # inserted in iomem_resource
    pci_bus_add_devices
      pci_bus_add_device
        pci_fixup_device(pci_fixup_final)
          resource[0].start += 0x1000                   # now 0x20001000

  ohci_pci_probe
    usb_hcd_pci_probe(& ohci_pci_hc_driver)
      if (driver->flags & HCD_MEMORY)
        hcd->rsrc_start = pci_resource_start(dev, 0)    # 0x20001000
        hcd->rsrc_len = pci_resource_len(dev, 0)        # now 28KB
        devm_request_mem_region
        hcd->regs = devm_ioremap
      usb_add_hcd
        hcd->driver->reset
          ohci_pci_reset                                # <--

So I suspect:

  - BAR contains 0x20000000 initially (for example)

  - pci_bus_assign_resources() inserts 0x20000000-0x20007fff in
    iomem_resource

  - final quirk updates res->start, so resource is now
    0x20001000-0x20007fff

  - OHCI driver binds and sees 0x20001000-0x20007fff

  - OHCI driver requests 0x20001000-0x20007fff (28KB)

  - OHCI may only use 4KB, but AFAICS it actually reserves the entire
    resource[0], which is now only 28KB

  - BAR still contains 0x20000000 ("lspci -b" should confirm this)

  - /proc/iomem contains something like this:

      20001000-20007fff 0000:3e:00.0
        20001000-20007fff ohci-hcd

Now the device still responds to accesses at 0x20000000 because that's
what's in the BAR, but the kernel doesn't know that anybody is using
the 0x20000000-0x20000fff region.

I think the best solution would be to add an entry in
ohci_pci_quirks[] that bumps hcd->regs up by 0x1000.  Then we wouldn't
have to touch the struct resource, it would stay 32KB, and it would
accurately reflect the hardware.

If that doesn't work, I guess you could also make this a *header*
fixup instead of a final one.  Then we would at least update the
resource before inserting it in iomem_resource.  But I don't like it
because the device still responds to an area not mentioned in
iomem_resource, and the resource is now 28KB, which is an illegal size
for a PCI BAR.

> > > +}
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, DEV_LS7A_OHCI, loongson_ohci_quirk);

