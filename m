Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4177210578B
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2019 17:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfKUQx7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 11:53:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:51920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfKUQx6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Nov 2019 11:53:58 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D73BF20658;
        Thu, 21 Nov 2019 16:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574355237;
        bh=U//DMVp98yPH8p7vkS8DG0VecnLBLi0eUqdzTWKCIus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nOqy6YqNYkxCxubuh9LZRljCgNKNxAsSy1UZanVKcKNTQ0A+tl9OqDhWF1GMUi4VE
         qCPF4LWenOgvvV3Mv9FVQsp/jUSvU93wKcKVK4AdA5iMcZwWJuJ7nmsVzYvhYO3Wiz
         XIGuZedbQKcuRhdrbEVbqndrWgGFUa7vtiqpAiXE=
Date:   Thu, 21 Nov 2019 16:53:48 +0000
From:   Will Deacon <will@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
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
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2] dma-mapping: treat dev->bus_dma_mask as a DMA limit
Message-ID: <20191121165348.GC4905@willie-the-truck>
References: <20191121092646.8449-1-nsaenzjulienne@suse.de>
 <20191121152457.GA525@lst.de>
 <20191121152650.GA651@lst.de>
 <70359d2a-10c6-09c7-a857-805085affb0a@arm.com>
 <20191121160217.GA1583@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121160217.GA1583@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 21, 2019 at 05:02:17PM +0100, Christoph Hellwig wrote:
> On Thu, Nov 21, 2019 at 03:55:39PM +0000, Robin Murphy wrote:
> > Hmm, there's no functional dependency though, is there? AFAICS it's 
> > essentially just a context conflict. Is it worth simply dropping (or 
> > postponing) the local renaming in __dma_direct_optimal_gfp_mask(), or 
> > perhaps even cross-merging arm64/for-next/zone-dma into dma/for-next?
> 
> I would have no problem with pulling it in.  I'd kinda hate creating
> the conflict, though.  So if the arm64 maintainers are fine with it
> I'll pull it in, especially if I get an ACK from Robin.

Please go ahead and pull in our for-next/zone-dma branch if you need it.
We're not going to rebase it, and I suspect we won't even be queueing
anything else there at this stage in the game.

Cheers,

Will
