Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03C8D427F7
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2019 15:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439478AbfFLNt1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jun 2019 09:49:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:58948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436722AbfFLNt1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jun 2019 09:49:27 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F9A3208CA;
        Wed, 12 Jun 2019 13:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560347366;
        bh=XxmYfcW64R7kQ/+LuOTWFbRjfanmeG4vLimtAoJAOpc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e89zFSzf/8xvYW51g1/UatnItMta3xse8v/K0qRw1bvXcOM9C02qULISPJbuwNvp9
         vx21Lx0SwpZjMsFqHJnSuznkoCL1FxWVSI/cSLboVq/G5C89u3IhxFKeiN1wwNWSFs
         Se33l9/x64vRdLKELqgVlCc8uQQIrYC9Ojp12/IM=
Date:   Wed, 12 Jun 2019 08:49:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Daniel Drake <drake@endlessm.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        linux-ide@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        mjg59@srcf.ucam.org
Subject: Re: [PATCH] PCI: Add Intel remapped NVMe device support
Message-ID: <20190612134925.GC13533@google.com>
References: <20190610074456.2761-1-drake@endlessm.com>
 <20190610211628.GA68572@google.com>
 <CAD8Lp47BmOtEgFUDCMyLrDpoPZSxcWmbrXEbh4PXS0FSG8ukLA@mail.gmail.com>
 <20190611195254.GB768@google.com>
 <CAD8Lp479mY=dAhFvGT2ZiJP12KXszhWev=QpCcgfgoew0TxgWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD8Lp479mY=dAhFvGT2ZiJP12KXszhWev=QpCcgfgoew0TxgWg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 12, 2019 at 11:16:03AM +0800, Daniel Drake wrote:
> On Wed, Jun 12, 2019 at 3:52 AM Bjorn Helgaas <helgaas@kernel.org> wrote:

> > Why do you need these to be PCI devices?
> 
> I don't have a particular preference, but was trying to explore the
> suggestions from the last round of review:
> 
> https://marc.info/?l=linux-ide&m=147923593001525&w=2
> "implementing a bridge driver like VMD"
> http://lists.infradead.org/pipermail/linux-nvme/2017-October/013325.html
> "The right way to do this would be to expose a fake PCIe root port
> that both the AHCI and NVMe driver bind to."
> 
> > It looks like the main thing
> > you get is a hook to bind the driver to.  Could you accomplish
> > something similar by doing some coordination between the ahci and nvme
> > drivers directly, without involving PCI?
> 
> That's basically what Dan Williams originally proposed, and Christoph
> Hellwig was not particularly excited by it...
> 
> Can you take a quick at the original patches and see what you think?
> https://marc.info/?l=linux-ide&m=147709611121482&w=2
> https://marc.info/?l=linux-ide&m=147709611621483&w=2
> https://marc.info/?l=linux-ide&m=147709612221484&w=2
> https://marc.info/?l=linux-ide&m=147709612721485&w=2
> https://marc.info/?l=linux-ide&m=147709613221487&w=2

I see Christoph's objections starting at
https://marc.info/?l=linux-ide&m=147711904724908&w=2
and I agree that this AHCI/NVMe melding is ugly.

But given the existence of this ugly hardware, my opinion is that
Dan's original patch series (above) is actually a nice way to deal
with it.  That's exactly the sort of thing I was proposing.

Part of Christoph's objection was the issue of how reset works, and
that objection absolutely makes sense to me.  But IMO adding a fake
PCI host bridge and fake PCI devices that really don't work because
they have read-only config space just smears the issue over
PCI/VFIO/etc in addition to AHCI and NVMe.

Bjorn
