Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960A94722AE
	for <lists+linux-pci@lfdr.de>; Mon, 13 Dec 2021 09:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbhLMI2U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Dec 2021 03:28:20 -0500
Received: from verein.lst.de ([213.95.11.211]:46712 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232936AbhLMI2F (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Dec 2021 03:28:05 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id DB2A168BFE; Mon, 13 Dec 2021 09:28:02 +0100 (CET)
Date:   Mon, 13 Dec 2021 09:28:02 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        linux-mips@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Christoph Hellwig <hch@lst.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/4] MIPS: bmips: Remove obsolete DMA mapping support
Message-ID: <20211213082802.GE21462@lst.de>
References: <20211209204726.6676-1-jim2101024@gmail.com> <20211209204726.6676-4-jim2101024@gmail.com> <92db2bfe-4bf2-60c0-3483-01fa59723517@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92db2bfe-4bf2-60c0-3483-01fa59723517@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 09, 2021 at 01:31:39PM -0800, Florian Fainelli wrote:
> On 12/9/21 12:47 PM, Jim Quinlan wrote:
> > The code in 'arch/mips/bmips/dma.c' performed DMA mapping for inbound
> > regions.  This mapping was and is required for the Broadcom STB PCIe
> > controller HW.  This code is removed as the current 'struct device' has a
> > @dma_range_map field which performs the same functionality by processing
> > the "dma-ranges" DT property.
> > 
> > Subsequently, ARCH_HAS_PHYS_TO_DMA is now unset since the dma_to_phys()
> > and phys_to_dma() functions are removed.
> > 
> > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> 
> CC Christoph so he can do the happy dance, thanks!

No actual patch content in this mail so I can't comment about the
substance, but removing another ARCH_HAS_PHYS_TO_DMA instance is always
awesome.
