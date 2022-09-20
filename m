Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6065BDD91
	for <lists+linux-pci@lfdr.de>; Tue, 20 Sep 2022 08:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiITGq3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Sep 2022 02:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiITGqX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Sep 2022 02:46:23 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3573564E5;
        Mon, 19 Sep 2022 23:46:22 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8272368BEB; Tue, 20 Sep 2022 08:46:14 +0200 (CEST)
Date:   Tue, 20 Sep 2022 08:46:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
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
Message-ID: <20220920064613.GB17325@lst.de>
References: <20220825152425.6296-1-logang@deltatee.com> <20220825152425.6296-8-logang@deltatee.com> <YxDb2MyRx6o/wDAz@kroah.com> <4a4bca1e-bebf-768f-92d4-92eb8ae714e1@deltatee.com> <YxDhEO9ycZDTnbZm@kroah.com> <cc9a24a8-dd3a-9d21-d9a7-5ee4b0ad7a57@deltatee.com> <YxD7uZYaV75gJS9d@kroah.com> <fb9d7948-43fe-87c5-5275-70f280181ad1@deltatee.com> <YxGad5h2Nn/Ejslc@kroah.com> <db8cd049-c78b-1aa0-dcd0-0feb8c6cb25c@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db8cd049-c78b-1aa0-dcd0-0feb8c6cb25c@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 02, 2022 at 12:46:54PM -0600, Logan Gunthorpe wrote:
> See the diff at the bottom of this email. I can apply it on top of this
> patch, but IMO it is neither easier to follow nor maintain. Unless you 
> have a different suggestion...

Greg, can you chime in on this?  Besides this item we just have a few
cosmetic bits left I think, and I'd really like to get the series into
this merge window.

