Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3EC5102A4D
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2019 18:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbfKSRAP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Nov 2019 12:00:15 -0500
Received: from verein.lst.de ([213.95.11.211]:35389 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727968AbfKSRAP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Nov 2019 12:00:15 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 254F868C4E; Tue, 19 Nov 2019 18:00:07 +0100 (CET)
Date:   Tue, 19 Nov 2019 18:00:06 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paul Burton <paulburton@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        phil@raspberrypi.org, linux-acpi@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        James Hogan <jhogan@kernel.org>, Len Brown <lenb@kernel.org>,
        devicetree@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] dma-mapping: treat dev->bus_dma_mask as a DMA limit
Message-ID: <20191119170006.GA19569@lst.de>
References: <20191113161340.27228-1-nsaenzjulienne@suse.de> <dd074ef5c23ba56598e92be19e8e25ae31b75f93.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd074ef5c23ba56598e92be19e8e25ae31b75f93.camel@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 19, 2019 at 01:57:43PM +0100, Nicolas Saenz Julienne wrote:
> Hi Rob & Christoph,
> do you mind if I append v2 of this into my upcoming v3 RPi4 PCIe support
> series, I didn't do it initially as I thought this was going to be a
> contentious patch.  But as it turned out better than expected, I think it
> should go into the PCIe series. In the end it's the first explicit user of the
> bus DMA limit.
> 
> Here's v2 in case you don't know what I'm talking about:
> https://www.spinics.net/lists/arm-kernel/msg768459.html

In principle I wouldn't mind, but I think this is going to conflict
quite badly with other changes in the dma-mapping tree (including
yours).  So I think we'll need a shared tree or I'll need to pull
in the whole series through the dma-mapping tree if there are not
other conflicts and the other maintainers are fine with it.
