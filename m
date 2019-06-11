Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2C573D738
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2019 21:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404882AbfFKTw6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jun 2019 15:52:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404282AbfFKTw6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Jun 2019 15:52:58 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58ED820883;
        Tue, 11 Jun 2019 19:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560282776;
        bh=0CA6nGYQ/ToZnu4NcBoqKhbEm0DpVVUDuW9mvjoONPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z3+L6uZ/jqpeIZFFKA9KkS7JROD6XRokUklWr6M0oNalePt64+bQhN42uwGBetAB1
         8iaO1HxlyqJjEagyJ2tTGD5hC/99YPCVbcT3hRqajhvdqhM3baFcbIVWVNUKf1ntEe
         oLJkDQGRx+JtqfwmqxSOIf6mTw5hoy6fcZDr9Dd0=
Date:   Tue, 11 Jun 2019 14:52:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Daniel Drake <drake@endlessm.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        linux-ide@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] PCI: Add Intel remapped NVMe device support
Message-ID: <20190611195254.GB768@google.com>
References: <20190610074456.2761-1-drake@endlessm.com>
 <20190610211628.GA68572@google.com>
 <CAD8Lp47BmOtEgFUDCMyLrDpoPZSxcWmbrXEbh4PXS0FSG8ukLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD8Lp47BmOtEgFUDCMyLrDpoPZSxcWmbrXEbh4PXS0FSG8ukLA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 11, 2019 at 11:25:55AM +0800, Daniel Drake wrote:
> On Tue, Jun 11, 2019 at 5:16 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > Ugh.  Is there a spec that details what's actually going on here?
> 
> Unfortunately there isn't a great spec to go on.
> https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/100-series-chipset-datasheet-vol-2.pdf
> has some details on the VS_CAP register (section 14.2.10).
> Beyond that, Intel contributed patches to enable support for these
> devices previously:
> https://marc.info/?l=linux-ide&m=147709610621480&w=2
> and stated that "The patch contents are [the spec]".
> https://marc.info/?l=linux-ide&m=147733119300691&w=2

It also said (three years ago) that there was some hope of opening the
specs.  But I guess that hasn't happened.

I'd much prefer lore.kernel.org links, but unfortunately lore doesn't
seem to have linux-ide archives.  If marc.info is the best we can do,
maybe at least include Message-IDs so there's some useful info in the
event marc.info disappears.

> > I think this creates a fake PCI host bridge, but not an actual PCIe
> > Root Port, right?  I.e., "lspci" doesn't show a new Root Port device,
> > does it?
> > ...
> 
> I appreciate your input here as I don't frequently go down to this
> level of detail with PCI. I'm trying to follow the previous
> suggestions from Christoph Hellwig, and further clarification on the
> most appropriate way to do this would be appreciated:
> 
> https://marc.info/?l=linux-ide&m=147923593001525&w=2
> "implementing a bridge driver like VMD"
> http://lists.infradead.org/pipermail/linux-nvme/2017-October/013325.html
> "The right way to do this would be to expose a fake PCIe root port
> that both the AHCI and NVMe driver bind to."
> 
> I'm not completely clear regarding the difference between a PCI host
> bridge and a PCIe root port, but indeed, after my patch, when running
> lspci, you see:
> 
> 1. The original RAID controller, now claimed by this new intel-nvme-remap driver
> 
> 0000:00:17.0 RAID bus controller: Intel Corporation 82801 Mobile SATA
> Controller [RAID mode] (rev 30)
>     Memory at b4390000 (32-bit, non-prefetchable) [size=32K]

> 2. The RAID controller presented by intel-nvme-remap on a new bus,
> with the cfg space tweaked in a way that it gets probed & accepted by
> the ahci driver:
> 
> 10000:00:00.0 SATA controller: Intel Corporation 82801 Mobile SATA
> Controller [RAID mode] (rev 30) (prog-if 01 [AHCI 1.0])
>     Memory at b4390000 (32-bit, non-prefetchable) [size=32K]

Exposing the same device in two different places (0000:00:17.0 and
10000:00:00.0) is definitely an architectural issue.  Logically we're
saying that accesses to b4390000 are claimed by two different devices.

> 3. The (previously inaccessible) NVMe device as presented on the new
> bus by intel-nvme-remap, probed by the nvme driver
> 
> 10000:00:01.0 Non-Volatile memory controller: Intel Corporation Device
> 0000 (prog-if 02 [NVM Express])
>     Memory at b430c000 (64-bit, non-prefetchable) [size=16K]

From a hardware point of view, I think it *was* previously accessible.
Maybe not in a convenient, driver-bindable way, but I don't think your
patch flips any PCI_COMMAND or similar register enable bits.
Everything should have been accessible before if you knew where to
look.

> I think Christoph's suggestion does ultimately require us to do some
> PCI pretending in some form, but let me know if there are more
> accepable ways to do this. If you'd like to see this appear more like
> a PCIe root port then I guess I can use pci-bridge-emul.c to do this,
> although having a fake root bridge appear in lspci output feels like
> I'd be doing even more pretending.

Maybe exposing a Root Port would help rationalize some of the issues,
but I wasn't suggesting that you *need* to expose a Root Port.  I was
just trying to point out that the comment inaccurately claimed you
were.

> Also happy to experiment with alternative approaches if you have any
> suggestions? 

Why do you need these to be PCI devices?  It looks like the main thing
you get is a hook to bind the driver to.  Could you accomplish
something similar by doing some coordination between the ahci and nvme
drivers directly, without involving PCI?

I assume that whatever magic Intel is doing with this "RST Optane"
mode, the resulting platform topology is at least compliant with the
PCI spec, so all the standard things in the spec like AER, DPC, power
management, etc, still work.

> With the decreasing cost of NVMe SSDs, we're seeing an
> influx of upcoming consumer PC products that will ship with the NVMe
> disk being the only storage device, combined with the BIOS default of
> "RST Optane" mode which will prevent Linux from seeing it at all, 
> so I'm really keen to swiftly find a way forward here.

This all sounds urgent, but without details of what this "RST Optane"
mode means actually means, I don't know what to do with it.  I want to
avoid the voodoo programming of "we don't know *why* we're doing this,
but it seems to work."

Bjorn
