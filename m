Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8525FC0D7
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2019 08:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfKNHfF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Nov 2019 02:35:05 -0500
Received: from verein.lst.de ([213.95.11.211]:38005 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfKNHfF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Nov 2019 02:35:05 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 910B768AFE; Thu, 14 Nov 2019 08:34:59 +0100 (CET)
Date:   Thu, 14 Nov 2019 08:34:59 +0100
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
        Robin Murphy <robin.murphy@arm.com>, phil@raspberrypi.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: treat dev->bus_dma_mask as a DMA limit
Message-ID: <20191114073459.GB26546@lst.de>
References: <20191113161340.27228-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113161340.27228-1-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 13, 2019 at 05:13:39PM +0100, Nicolas Saenz Julienne wrote:
> Using a mask to represent bus DMA constraints has a set of limitations.
> The biggest one being it can only hold a power of two (minus one). The
> DMA mapping code is already aware of this and treats dev->bus_dma_mask
> as a limit. This quirk is already used by some architectures although
> still rare.
> 
> With the introduction of the Raspberry Pi 4 we've found a new contender
> for the use of bus DMA limits, as its PCIe bus can only address the
> lower 3GB of memory (of a total of 4GB). This is impossible to represent
> with a mask. To make things worse the device-tree code rounds non power
> of two bus DMA limits to the next power of two, which is unacceptable in
> this case.
> 
> In the light of this, rename dev->bus_dma_mask to dev->bus_dma_limit all
> over the tree and treat it as such. Note that dev->bus_dma_limit is
> meant to contain the higher accesible DMA address.

This looks sensible modulo the minor comments in this thread.

> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> 
> ---
> 
> Note this is rebased on top of Christoph's latest DMA series:
> https://www.spinics.net/lists/arm-kernel/msg768600.html

FYI, I'll plan to merge those tonight unless anyone screams.
