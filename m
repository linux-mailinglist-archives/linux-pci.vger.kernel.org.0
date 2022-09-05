Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD0F5AD4E7
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 16:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238296AbiIEOeL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 10:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238137AbiIEOeJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 10:34:09 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B16E5A883;
        Mon,  5 Sep 2022 07:34:09 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3D51A68AFE; Mon,  5 Sep 2022 16:34:05 +0200 (CEST)
Date:   Mon, 5 Sep 2022 16:34:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v9 3/8] block: add check when merging zone device pages
Message-ID: <20220905143405.GB5813@lst.de>
References: <20220825152425.6296-1-logang@deltatee.com> <20220825152425.6296-4-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825152425.6296-4-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 25, 2022 at 09:24:20AM -0600, Logan Gunthorpe wrote:
> Consecutive zone device pages should not be merged into the same sgl
> or bvec segment with other types of pages or if they belong to different
> pgmaps. Otherwise getting the pgmap of a given segment is not possible
> without scanning the entire segment. This helper returns true either if
> both pages are not zone device pages or both pages are zone device
> pages with the same pgmap.
> 
> Add a helper to determine if zone device pages are mergeable and use
> this helper in page_is_mergeable().
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
