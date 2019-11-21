Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 228BF104C9E
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2019 08:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfKUHcA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 02:32:00 -0500
Received: from verein.lst.de ([213.95.11.211]:44458 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfKUHb7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Nov 2019 02:31:59 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0FAB768B05; Thu, 21 Nov 2019 08:31:53 +0100 (CET)
Date:   Thu, 21 Nov 2019 08:31:52 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
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
Message-ID: <20191121073152.GB24024@lst.de>
References: <20191113161340.27228-1-nsaenzjulienne@suse.de> <dd074ef5c23ba56598e92be19e8e25ae31b75f93.camel@suse.de> <20191119170006.GA19569@lst.de> <7609007d-52f5-bb10-e8d5-96fadbfab46d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7609007d-52f5-bb10-e8d5-96fadbfab46d@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 19, 2019 at 05:17:03PM +0000, Robin Murphy wrote:
> TBH I can't see it being a massive problem even if the DMA patch, driver 
> and DTS patch went entirely separately via the respective DMA, PCI, and 
> arm-soc trees in the same cycle. Bisecting over a merge window is a big 
> enough pain in the bum as it is, and if the worst case is that someone 
> trying to do that on a Pi4 has a wonky PCI controller appear for a couple 
> of commits, they may as well just disable that driver for their bisection, 
> because it wasn't there at the start so can't possibly be the thing they're 
> looking for regressions in ;)

Agreed.

Nicolas, can you send a respin?  That way I can still queue it up
for 5.5.
