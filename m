Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0DD210895D
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2019 08:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfKYHoS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Nov 2019 02:44:18 -0500
Received: from verein.lst.de ([213.95.11.211]:34672 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfKYHoS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Nov 2019 02:44:18 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id D394368C4E; Mon, 25 Nov 2019 08:44:12 +0100 (CET)
Date:   Mon, 25 Nov 2019 08:44:12 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
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
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paul Burton <paulburton@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        James Hogan <jhogan@kernel.org>, Len Brown <lenb@kernel.org>,
        devicetree@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] dma-mapping: treat dev->bus_dma_mask as a DMA limit
Message-ID: <20191125074412.GA30595@lst.de>
References: <20191121092646.8449-1-nsaenzjulienne@suse.de> <20191123165108.GA15306@ubuntu-x2-xlarge-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191123165108.GA15306@ubuntu-x2-xlarge-x86>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Nov 23, 2019 at 09:51:08AM -0700, Nathan Chancellor wrote:
> Just as an FYI, this introduces a warning on arm32 allyesconfig for me:

I think the dma_limit argument to iommu_dma_alloc_iova should be a u64
and/or we need to use min_t and open code the zero exception.

Robin, Nicolas - any opinions?

Also I wonder how this file gets compiled on arm32 given that arm32
has its own set of iommu dma ops..
