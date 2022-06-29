Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA0855F6A2
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 08:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiF2GdP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 02:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiF2GdO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 02:33:14 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FF31D0C8;
        Tue, 28 Jun 2022 23:33:13 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E206E68AFE; Wed, 29 Jun 2022 08:33:08 +0200 (CEST)
Date:   Wed, 29 Jun 2022 08:33:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v7 01/21] lib/scatterlist: add flag for indicating
 P2PDMA segments in an SGL
Message-ID: <20220629063308.GB17234@lst.de>
References: <20220615161233.17527-1-logang@deltatee.com> <20220615161233.17527-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615161233.17527-2-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 15, 2022 at 10:12:13AM -0600, Logan Gunthorpe wrote:
> Make use of the third free LSB in scatterlist's page_link on 64bit systems.
> 
> The extra bit will be used by dma_[un]map_sg_p2pdma() to determine when a
> given SGL segments dma_address points to a PCI bus address.
> dma_unmap_sg_p2pdma() will need to perform different cleanup when a
> segment is marked as a bus address.
> 
> The new bit will only be used when CONFIG_PCI_P2PDMA is set; this means
> PCI P2PDMA will require CONFIG_64BIT. This should be acceptable as the
> majority of P2PDMA use cases are restricted to newer root complexes and
> roughly require the extra address space for memory BARs used in the
> transactions.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
