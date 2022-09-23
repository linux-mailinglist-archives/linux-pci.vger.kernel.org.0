Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208015E7584
	for <lists+linux-pci@lfdr.de>; Fri, 23 Sep 2022 10:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiIWIPy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Sep 2022 04:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiIWIPx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Sep 2022 04:15:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DDAB6561;
        Fri, 23 Sep 2022 01:15:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A3F361491;
        Fri, 23 Sep 2022 08:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2193DC433D6;
        Fri, 23 Sep 2022 08:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663920950;
        bh=ITi0Pkie/41exckOOEHb1oAjXkYdzFl60zYe1Z6SOsI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v0KIwFqnf0h62gPG0bxhRtPlMQRU+sn46T0CtPVR5NKOnXZsjItRiireczqzCeKag
         pAvIG3SEtkcD85MT7X2TMXaDlhSnRQcrEOmrMoSMt/EK/FQujn5mkajW6X3k8utzpw
         anYADRkPfWaRWXGb6PsKo0p6qOHfHnd0hbjq1K+8=
Date:   Fri, 23 Sep 2022 10:15:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
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
Subject: Re: [PATCH v10 7/8] PCI/P2PDMA: Allow userspace VMA allocations
 through sysfs
Message-ID: <Yy1rMn3t33OcFzmB@kroah.com>
References: <20220922163926.7077-1-logang@deltatee.com>
 <20220922163926.7077-8-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922163926.7077-8-logang@deltatee.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 22, 2022 at 10:39:25AM -0600, Logan Gunthorpe wrote:
> Create a sysfs bin attribute called "allocate" under the existing
> "p2pmem" group. The only allowable operation on this file is the mmap()
> call.
> 
> When mmap() is called on this attribute, the kernel allocates a chunk of
> memory from the genalloc and inserts the pages into the VMA. The
> dev_pagemap .page_free callback will indicate when these pages are no
> longer used and they will be put back into the genalloc.
> 
> On device unbind, remove the sysfs file before the memremap_pages are
> cleaned up. This ensures unmap_mapping_range() is called on the files
> inode and no new mappings can be created.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/pci/p2pdma.c | 124 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 124 insertions(+)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
