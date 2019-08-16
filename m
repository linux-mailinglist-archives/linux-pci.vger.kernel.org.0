Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 391268FD66
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2019 10:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfHPIM7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Aug 2019 04:12:59 -0400
Received: from verein.lst.de ([213.95.11.211]:53365 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbfHPIM7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Aug 2019 04:12:59 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id AAD2868B02; Fri, 16 Aug 2019 10:12:55 +0200 (CEST)
Date:   Fri, 16 Aug 2019 10:12:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Pilmore <epilmore@gigaio.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v3 08/14] PCI/P2PDMA: Add attrs argument to
 pci_p2pdma_map_sg()
Message-ID: <20190816081255.GH9249@lst.de>
References: <20190812173048.9186-1-logang@deltatee.com> <20190812173048.9186-9-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812173048.9186-9-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 12, 2019 at 11:30:42AM -0600, Logan Gunthorpe wrote:
> This is to match the dma_map_sg() API which this function will have to call
> in an future patch.
> 
> Add a pci_p2pdma_map_sg_attrs() function and helper to call it with no
> attributes just like the dma_map_sg() function.
> 
> Link: https://lore.kernel.org/r/20190730163545.4915-9-logang@deltatee.com
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
