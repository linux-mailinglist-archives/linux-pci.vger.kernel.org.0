Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26C483C188
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2019 05:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390893AbfFKD0I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jun 2019 23:26:08 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44293 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390856AbfFKD0I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jun 2019 23:26:08 -0400
Received: by mail-qt1-f194.google.com with SMTP id x47so12847711qtk.11
        for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2019 20:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JOm+EW5Vwdsl47rTW4cXuPENFumxPeVaKVG65fDZz5k=;
        b=pMAFsOszb9ubT5a74uVuMtyTEVOKR17uVYjpZVQMZ7XBmiRmRxrAW1Obv++8dmI7HA
         FcgRElyTxqC4MbQ06y9gnVDWn4zeUbLx/kDUS6n1g3YnogQVFnSK68EThnEuxDAbSQh8
         uxHSqM/B4nlqH+b6X5VDkJrvreXGR3HDZsjsmkw3uG9fzuFefMbOo49yS1KrUhreczHl
         0IDxiLDh03rSimZNcCOAXQJe/XRdfqbI92OJJwwi2SxZkMYXV3EiaTXk9fyjuq4YQEZg
         XitWI/oOZPC3KO+fUNIwDXhmXdIDYWf1v5G24Fdjf20mLv2TIv4KHlV9de9kimSWt+12
         ST0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JOm+EW5Vwdsl47rTW4cXuPENFumxPeVaKVG65fDZz5k=;
        b=ZgzwlilkiXR8v1bcwAKSZII7XOY1mVANI2qY/dK2LQRBz9FlPZx0X67rD9zTXls/Gh
         HxrMW1YTvrOwgPDsLF+VDJ7YVPAjbRhGv6+5cSKoVJExoIYQEBGS0nuTJGbAe8gWuar/
         Gg0e/NkNfWoYlQ9r+0W2PCiHBTrG7508/VyGZ5qFJ5Ae9O7lrDA1F6xKkRnUa4kGJHoK
         4kzmnGqsVXPrKDHiCt9uGux+6z1FC2kDhneLY2QLQPNk6R3Mq7SD1J3QFUkP7cTZPwgr
         H31ohVE71tNPKo+Ff/AMb3pnC06tvtQa6nFPAXNnqDrN0rMqM5n10iQlfFWMb0iYS0NP
         4Ufw==
X-Gm-Message-State: APjAAAWaH1fy1IEOZIxVOZQTpyaKqTgZgxW3GYhO1qMDwCtApm7FEVsW
        6pIiJAK8Pkgr9B8TiRuI1p4mrXl2obzglhFh7hrfhw==
X-Google-Smtp-Source: APXvYqwkZIvL2PSu1IV5dcWJ7noBUngNZyepyZbZfIdg8F8DRyNz5xcNtt3TN8mTKxkBYK+fndH4UmS/RdTvd+iLprs=
X-Received: by 2002:ac8:2ec3:: with SMTP id i3mr17263276qta.110.1560223567138;
 Mon, 10 Jun 2019 20:26:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190610074456.2761-1-drake@endlessm.com> <20190610211628.GA68572@google.com>
In-Reply-To: <20190610211628.GA68572@google.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Tue, 11 Jun 2019 11:25:55 +0800
Message-ID: <CAD8Lp47BmOtEgFUDCMyLrDpoPZSxcWmbrXEbh4PXS0FSG8ukLA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Add Intel remapped NVMe device support
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        linux-ide@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thanks for the quick feedback. You raise some good questions that I'll
be sure to clarify in the next revision. To focus on some of the
pending details here:

On Tue, Jun 11, 2019 at 5:16 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> Ugh.  Is there a spec that details what's actually going on here?

Unfortunately there isn't a great spec to go on.
https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/100-series-chipset-datasheet-vol-2.pdf
has some details on the VS_CAP register (section 14.2.10).
Beyond that, Intel contributed patches to enable support for these
devices previously:
https://marc.info/?l=linux-ide&m=147709610621480&w=2
and stated that "The patch contents are [the spec]".
https://marc.info/?l=linux-ide&m=147733119300691&w=2
Later in the thread it was also stated unequivocally that the
interrupt is shared & the original NVMe dev config space is
unavailable.
I'll add references to these details in the next revision.

> This driver makes a lot of assumptions about how this works, e.g.,
> apparently there's an AHCI BAR that covers "hidden devices" plus some
> other stuff of some magic size, whatever is special about device 0,
> etc, but I don't see the source of those assumptions.

The AHCI BAR covering hidden devices is sort-of covered in the VS_CAP
spec so I can at least reference that.

> I'm not really keen on the precedent this sets about pretending things
> are PCI when they're not.  This seems like a bit of a kludge that
> might happen to work now but could easily break in the future because
> it's not based on any spec we can rely on.  Plus it makes future PCI
> maintenance harder because we have to worry about how these differ
> from real PCI devices.
>
> I think this creates a fake PCI host bridge, but not an actual PCIe
> Root Port, right?  I.e., "lspci" doesn't show a new Root Port device,
> does it?
>
> But I suppose "lspci" *does* show new NVMe devices that seem to be
> PCIe endpoints?  But they probably don't *work* like PCIe endpoints,
> e.g., we can't control ASPM, can't use AER, etc?

I appreciate your input here as I don't frequently go down to this
level of detail with PCI. I'm trying to follow the previous
suggestions from Christoph Hellwig, and further clarification on the
most appropriate way to do this would be appreciated:

https://marc.info/?l=linux-ide&m=147923593001525&w=2
"implementing a bridge driver like VMD"
http://lists.infradead.org/pipermail/linux-nvme/2017-October/013325.html
"The right way to do this would be to expose a fake PCIe root port
that both the AHCI and NVMe driver bind to."

I'm not completely clear regarding the difference between a PCI host
bridge and a PCIe root port, but indeed, after my patch, when running
lspci, you see:

1. The original RAID controller, now claimed by this new intel-nvme-remap driver

0000:00:17.0 RAID bus controller: Intel Corporation 82801 Mobile SATA
Controller [RAID mode] (rev 30)
    Subsystem: ASUSTeK Computer Inc. 82801 Mobile SATA Controller [RAID mode]
    Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 16
    Memory at b4390000 (32-bit, non-prefetchable) [size=32K]
    Memory at b43aa000 (32-bit, non-prefetchable) [size=256]
    I/O ports at 4090 [size=8]
    I/O ports at 4080 [size=4]
    I/O ports at 4060 [size=32]
    Memory at b4300000 (32-bit, non-prefetchable) [size=512K]
    Capabilities: [d0] MSI-X: Enable- Count=20 Masked-
    Capabilities: [70] Power Management version 3
    Capabilities: [a8] SATA HBA v1.0
    Kernel driver in use: intel-nvme-remap

2. The RAID controller presented by intel-nvme-remap on a new bus,
with the cfg space tweaked in a way that it gets probed & accepted by
the ahci driver:

10000:00:00.0 SATA controller: Intel Corporation 82801 Mobile SATA
Controller [RAID mode] (rev 30) (prog-if 01 [AHCI 1.0])
    Subsystem: ASUSTeK Computer Inc. 82801 Mobile SATA Controller [RAID mode]
    Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 16, NUMA node 0
    Memory at b4390000 (32-bit, non-prefetchable) [size=32K]
    Memory at b43aa000 (32-bit, non-prefetchable) [size=256]
    I/O ports at 4090 [size=8]
    I/O ports at 4080 [size=4]
    I/O ports at 4060 [size=32]
    Memory at b4300000 (32-bit, non-prefetchable) [size=16K]
    Capabilities: [d0] MSI-X: Enable- Count=20 Masked-
    Capabilities: [70] Power Management version 3
    Capabilities: [a8] SATA HBA v1.0
    Kernel driver in use: ahci

3. The (previously inaccessible) NVMe device as presented on the new
bus by intel-nvme-remap, probed by the nvme driver

10000:00:01.0 Non-Volatile memory controller: Intel Corporation Device
0000 (prog-if 02 [NVM Express])
    Flags: bus master, fast Back2Back, fast devsel, latency 0, IRQ 16,
NUMA node 0
    Memory at b430c000 (64-bit, non-prefetchable) [size=16K]
    Kernel driver in use: nvme

I think Christoph's suggestion does ultimately require us to do some
PCI pretending in some form, but let me know if there are more
accepable ways to do this. If you'd like to see this appear more like
a PCIe root port then I guess I can use pci-bridge-emul.c to do this,
although having a fake root bridge appear in lspci output feels like
I'd be doing even more pretending.

Also happy to experiment with alternative approaches if you have any
suggestions? With the decreasing cost of NVMe SSDs, we're seeing an
influx of upcoming consumer PC products that will ship with the NVMe
disk being the only storage device, combined with the BIOS default of
"RST Optane" mode which will prevent Linux from seeing it at all, so
I'm really keen to swiftly find a way forward here.

Thanks!
Daniel
