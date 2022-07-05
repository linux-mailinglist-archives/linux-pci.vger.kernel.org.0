Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C8D5674A8
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jul 2022 18:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbiGEQnV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jul 2022 12:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiGEQnU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jul 2022 12:43:20 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CB81CB3F;
        Tue,  5 Jul 2022 09:43:19 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 31F3168AA6; Tue,  5 Jul 2022 18:43:15 +0200 (CEST)
Date:   Tue, 5 Jul 2022 18:43:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Dan Williams <dan.j.williams@intel.com>,
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
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v7 20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
Message-ID: <20220705164315.GB14484@lst.de>
References: <20220615161233.17527-1-logang@deltatee.com> <20220615161233.17527-21-logang@deltatee.com> <20220629064854.GD17576@lst.de> <99242789-66a6-bbd2-b56a-e47891f4522e@deltatee.com> <20220629175906.GU23621@ziepe.ca> <20220705075108.GB17451@lst.de> <20220705135102.GE23621@ziepe.ca> <20220705161240.GB13721@lst.de> <a509b13c-244b-23fc-f989-339750a733a5@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a509b13c-244b-23fc-f989-339750a733a5@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 05, 2022 at 10:41:52AM -0600, Logan Gunthorpe wrote:
> Using sysfs means we don't need all the messy callbacks from the nvme
> driver, which is a plus. But I'm not sure how we'd get or unmap the
> mapping of a sysfs file or avoid the anonymous inode. Seems with the
> existing PCI resources, it uses an bin_attribute->f_mapping() callback
> to pass back the iomem_get_mapping() mapping on file open.
> revoke_iomem() is then used to nuke the VMAs. I don't think we can use
> the same infrastructure here as that would add a dependency on
> CONFIG_IO_STRICT_DEVMEM; which would be odd. And I'm not sure whether
> there is a better way.

Why can't we do the revoke on the actual sysfs inode?
