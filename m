Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAB15A9F33
	for <lists+linux-pci@lfdr.de>; Thu,  1 Sep 2022 20:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbiIAShs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Sep 2022 14:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbiIAShX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Sep 2022 14:37:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B29C4CA0E;
        Thu,  1 Sep 2022 11:36:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A19F61CF7;
        Thu,  1 Sep 2022 18:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68479C433D6;
        Thu,  1 Sep 2022 18:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662057404;
        bh=4EGc98ePtGVoW/OVpl29pIB0Xv/vWLpMdUFKeCItABY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xFeGxXLUUQuSqZdVXhkzgw5JZFhnJkqiyA7MU8ELHe3FJve40mXqCLp9o6Fh+/lAf
         yijiTz3pzHkV1ZEn5hg/537CIQ4D8j2AVuE8Pd8EnOW7zd0tEDyU+ODP2GX+/Dt8iD
         Xilxi4k7yFbvYeFd6jE9lPw3HjO8pop87qrBfh24=
Date:   Thu, 1 Sep 2022 20:36:41 +0200
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
Subject: Re: [PATCH v9 7/8] PCI/P2PDMA: Allow userspace VMA allocations
 through sysfs
Message-ID: <YxD7uZYaV75gJS9d@kroah.com>
References: <20220825152425.6296-1-logang@deltatee.com>
 <20220825152425.6296-8-logang@deltatee.com>
 <YxDb2MyRx6o/wDAz@kroah.com>
 <4a4bca1e-bebf-768f-92d4-92eb8ae714e1@deltatee.com>
 <YxDhEO9ycZDTnbZm@kroah.com>
 <cc9a24a8-dd3a-9d21-d9a7-5ee4b0ad7a57@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc9a24a8-dd3a-9d21-d9a7-5ee4b0ad7a57@deltatee.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 01, 2022 at 12:14:25PM -0600, Logan Gunthorpe wrote:
> 
> 
> 
> On 2022-09-01 10:42, Greg Kroah-Hartman wrote:
> > On Thu, Sep 01, 2022 at 10:32:55AM -0600, Logan Gunthorpe wrote:
> >> On 2022-09-01 10:20, Greg Kroah-Hartman wrote:
> >>> On Thu, Aug 25, 2022 at 09:24:24AM -0600, Logan Gunthorpe wrote:
> >>>> +	/*
> >>>> +	 * Removing the alloc attribute from sysfs will call
> >>>> +	 * unmap_mapping_range() on the inode, teardown any existing userspace
> >>>> +	 * mappings and prevent new ones from being created.
> >>>> +	 */
> >>>> +	sysfs_remove_file_from_group(&pdev->dev.kobj, &p2pmem_alloc_attr.attr,
> >>>> +				     p2pmem_group.name);
> >>>
> >>> Wait, why are you manually removing the sysfs file here?  It's part of
> >>> the group, if you do this then it is gone for forever, right?  Why
> >>> manually do this the sysfs core should handle this for you if the device
> >>> is removed.
> >>
> >> We have to make sure the mappings are all removed before the cleanup of
> >> devm_memremap_pages() which will wait for all the pages to be freed.
> > 
> > Then don't use devm_ functions.  Why not just use the manual functions
> > instead as you know when you want to tear this down.
> 
> Well we haven't plugged in a remove call into p2pdma, that would be more
> work and more interfaces touching the PCI code. Note: this code isn't a
> driver but a set of PCI helpers available to other PCI drivers.
> Everything that's setup is using the devm interfaces and gets torn down
> with the same. So I don't really see the benefit of making the change
> you propose.

The issue is the classic one with the devm helpers.  They do not lend
themselves to resource management issues that require ordering or other
sort of dependencies.  Please do not use them here, just put in a remove
callback as you eventually will need it anyway, as you have a strong
requirement for what gets freed when, and the devm api does not provide
for that well.

thanks,

greg k-h
