Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DDB564D81
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jul 2022 08:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiGDGHI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jul 2022 02:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiGDGHI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jul 2022 02:07:08 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71531260E;
        Sun,  3 Jul 2022 23:07:06 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 49FFF68AA6; Mon,  4 Jul 2022 08:07:00 +0200 (CEST)
Date:   Mon, 4 Jul 2022 08:07:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
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
        Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH v7 16/21] block: add check when merging zone device
 pages
Message-ID: <20220704060700.GA28966@lst.de>
References: <20220615161233.17527-1-logang@deltatee.com> <20220615161233.17527-17-logang@deltatee.com> <20220629064629.GC17576@lst.de> <7da06e08-7dd1-f37c-4382-bc59a1b1e819@deltatee.com> <39bf0071-0acf-12fd-3d3e-06dfd87bb409@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39bf0071-0acf-12fd-3d3e-06dfd87bb409@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 30, 2022 at 03:50:10PM -0600, Logan Gunthorpe wrote:
> Oh, it turns out this code has nothing to do with REQ_NOMERGE. It's used
> indirectly in bio_map_user_iov() and __bio_iov_iter_get_pages() when
> adding pages to the bio via page_is_mergeable(). So it's not about
> requests being merged it's about pages being merged.

Oh, true.

> So I'm not sure how we can avoid this, but it only happens when two
> adjacent pages are added to the same bio in a row, so I don't think it's
> that common, but the check can probably be moved down so it happens
> after the same_page check to make it a little less common.

Yes, looks like we have to keep it.
