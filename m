Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC1A56757D
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jul 2022 19:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiGERWE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jul 2022 13:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiGERWE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jul 2022 13:22:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D6512AD2;
        Tue,  5 Jul 2022 10:22:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41EA6B8182F;
        Tue,  5 Jul 2022 17:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3CBC341C7;
        Tue,  5 Jul 2022 17:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657041720;
        bh=2k+PI3826bV0JfafuKOYWZwzEmZ/6OWZBqa+5FOwKKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eW0LSj5OCSMxFTwab7kOj8yB3ANUifdcIyjdDqyqljZ/iy8fnpSDRDB1hx7AhAPR2
         x0qZP6dDTeDA8ifC5C2gTw8/5BH/5dH8LBx4m8NjuS/wZ8PPrtzbO2zUPRMEQWtCnE
         Ysh75bL4zKRSbMgqYVPy39v9+8C6x63MzOq+Bpnc=
Date:   Tue, 5 Jul 2022 19:21:58 +0200
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
Message-ID: <YsRzNqmZYlgkL7fI@kroah.com>
References: <20220629064854.GD17576@lst.de>
 <99242789-66a6-bbd2-b56a-e47891f4522e@deltatee.com>
 <20220629175906.GU23621@ziepe.ca>
 <20220705075108.GB17451@lst.de>
 <20220705135102.GE23621@ziepe.ca>
 <20220705161240.GB13721@lst.de>
 <a509b13c-244b-23fc-f989-339750a733a5@deltatee.com>
 <20220705164315.GB14484@lst.de>
 <acb91f37-0470-8ce4-19e4-426903cbc3a1@deltatee.com>
 <20220705165039.GB14566@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705165039.GB14566@lst.de>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 05, 2022 at 06:50:39PM +0200, Christoph Hellwig wrote:
> [note for the newcomers, this is about allowing mmap()ing the PCIe
> P2P memory from the generic PCI P2P code through sysfs, and more
> importantly how to revoke it on device removal]

We allow mmap on PCIe config space today, right?  Why is this different
from what pci_create_legacy_files() does today?

> On Tue, Jul 05, 2022 at 10:44:49AM -0600, Logan Gunthorpe wrote:
> > We might be able to. I'm not sure. I'll have to figure out how to find
> > that inode from the p2pdma code. I haven't found an obvious interface to
> > do that.
> 
> I think the right way to approach this would be a new sysfs API
> that internally calls unmap_mapping_range internally instead of
> exposing the inode. I suspect that might actually be the right thing
> to do for iomem_inode as well.

Why do we need something new and how is this any different from the PCI
binary files I mention above?  We have supported PCI hotplug for a very
long time, do the current PCI binary sysfs files not work properly with
mmap and removing a device?

thanks,

greg k-h
