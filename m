Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67D212820A
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2019 17:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730893AbfEWP7p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 May 2019 11:59:45 -0400
Received: from verein.lst.de ([213.95.11.211]:47707 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730790AbfEWP7p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 May 2019 11:59:45 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 09BBF68AFE; Thu, 23 May 2019 17:59:23 +0200 (CEST)
Date:   Thu, 23 May 2019 17:59:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/P2PDMA: Root complex whitelist should not apply
 when an IOMMU is present
Message-ID: <20190523155922.GA21552@lst.de>
References: <a98bff67-a76e-4ddc-a317-96f2bdc9af72@email.android.com> <97aa52fc-f062-acf1-0e0c-5a4d1d505777@deltatee.com> <b9e94126-8686-4306-77c3-bd0b96680775@amd.com> <20190523094322.GA14986@lst.de> <fa941625-ef65-74fa-e232-705ea5acefa3@amd.com> <20190523095057.GA15185@lst.de> <252313a9-9af4-14bd-1bfa-1c2327baf2b2@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <252313a9-9af4-14bd-1bfa-1c2327baf2b2@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 23, 2019 at 09:53:53AM -0600, Logan Gunthorpe wrote:
> > The problem shows up if pci_bus_address() returns a different address
> > than pci_resource_start(), should be easy to check if that happens.
> > IIRC it is something mostly seen on embedded SOCs.
> > 
> 
> I think it's a bit more complicated then that: If you're calling
> dma_map_resource() to program the IOMMU then I'm pretty sure you'd want
> to use the pci_resource_start() address as the phys_addr_t. If you're
> bypassing the root complex (like the current p2pdma code enforces), then
> you'd simply use a pci_bus_address() directly as the dma_addr and would
> not program the IOMMU at all seeing it's not involved (which is what is
> currently done).

True.  What we need is:

 if (both device are behind the same root port (using a switch)) {
 	use the current direct map + offset code
 } else {
 	call ->map_resource()
 }
