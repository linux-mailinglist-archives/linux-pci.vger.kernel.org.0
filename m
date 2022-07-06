Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD500567EF3
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jul 2022 08:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiGFGve (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jul 2022 02:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiGFGvd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jul 2022 02:51:33 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D5614D0B;
        Tue,  5 Jul 2022 23:51:32 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 79E0F67373; Wed,  6 Jul 2022 08:51:27 +0200 (CEST)
Date:   Wed, 6 Jul 2022 08:51:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>,
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
Message-ID: <20220706065127.GA27132@lst.de>
References: <20220705135102.GE23621@ziepe.ca> <20220705161240.GB13721@lst.de> <a509b13c-244b-23fc-f989-339750a733a5@deltatee.com> <20220705164315.GB14484@lst.de> <acb91f37-0470-8ce4-19e4-426903cbc3a1@deltatee.com> <20220705165039.GB14566@lst.de> <YsRzNqmZYlgkL7fI@kroah.com> <1bd43ef7-0403-bd25-087c-d54d5af677e4@deltatee.com> <YsR4CNDgtt4JWonv@kroah.com> <b3deacdd-cb76-6ebb-0e29-ef6a5a426a0d@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3deacdd-cb76-6ebb-0e29-ef6a5a426a0d@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 05, 2022 at 12:16:45PM -0600, Logan Gunthorpe wrote:
> The current version does it through a char device, but that requires
> creating a simple_fs and anon_inode for teardown on driver removal, plus
> a bunch of hooks through the driver that exposes it (NVMe, in this case)
> to set this all up.
> 
> Christoph is suggesting a sysfs interface which could potentially avoid
> the anon_inode and all of the extra hooks. It has some significant
> benefits and maybe some small downsides, but I wouldn't describe it as
> horrid.

Yeah, I don't think is is horrible, it fits in with the resource files
for the BARs, and solves a lot of problems.  Greg, can you explain
what would be so bad about it?
