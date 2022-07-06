Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3876567F6C
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jul 2022 09:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbiGFHFI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jul 2022 03:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbiGFHEv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jul 2022 03:04:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE11222A9;
        Wed,  6 Jul 2022 00:04:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF811B81AEF;
        Wed,  6 Jul 2022 07:04:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1095EC3411C;
        Wed,  6 Jul 2022 07:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657091083;
        bh=yFTTCN8eLFI/FFSUip2r6VUaWUpwukK1oykDBvVFoaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jvQpbiTHwHtxiL7mhpAUqPcIfklC3uMq+eSlq7Dn3j9ZoCfEt8bXAghrDvZr0IVL+
         IVo2VVD6El337SyTT90L4wo/hIPFCt8NLQgPrX4IoEu6OyCSHbBsNvDzbu6ja4urNO
         b9ykds4BGL4/msxrju07lSQ9srOtvpaXTx1taFYM=
Date:   Wed, 6 Jul 2022 09:04:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
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
Message-ID: <YsU0Cb0rRbW8FGPX@kroah.com>
References: <20220705161240.GB13721@lst.de>
 <a509b13c-244b-23fc-f989-339750a733a5@deltatee.com>
 <20220705164315.GB14484@lst.de>
 <acb91f37-0470-8ce4-19e4-426903cbc3a1@deltatee.com>
 <20220705165039.GB14566@lst.de>
 <YsRzNqmZYlgkL7fI@kroah.com>
 <1bd43ef7-0403-bd25-087c-d54d5af677e4@deltatee.com>
 <YsR4CNDgtt4JWonv@kroah.com>
 <b3deacdd-cb76-6ebb-0e29-ef6a5a426a0d@deltatee.com>
 <20220706065127.GA27132@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706065127.GA27132@lst.de>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 06, 2022 at 08:51:27AM +0200, Christoph Hellwig wrote:
> On Tue, Jul 05, 2022 at 12:16:45PM -0600, Logan Gunthorpe wrote:
> > The current version does it through a char device, but that requires
> > creating a simple_fs and anon_inode for teardown on driver removal, plus
> > a bunch of hooks through the driver that exposes it (NVMe, in this case)
> > to set this all up.
> > 
> > Christoph is suggesting a sysfs interface which could potentially avoid
> > the anon_inode and all of the extra hooks. It has some significant
> > benefits and maybe some small downsides, but I wouldn't describe it as
> > horrid.
> 
> Yeah, I don't think is is horrible, it fits in with the resource files
> for the BARs, and solves a lot of problems.  Greg, can you explain
> what would be so bad about it?

As you mention, you will have to pass different things down into sysfs
in order for that to be possible.  If it matches the resource files like
we currently have today, that might not be that bad, but it still feels
odd to me.  Let's see an implementation and a Documentation/ABI/ entry
first though.

thanks,

greg k-h
