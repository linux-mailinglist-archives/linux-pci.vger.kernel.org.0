Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBAF5AA76B
	for <lists+linux-pci@lfdr.de>; Fri,  2 Sep 2022 07:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbiIBFyH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 01:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiIBFyG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 01:54:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1B8B2DA6;
        Thu,  1 Sep 2022 22:54:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17AECB829E2;
        Fri,  2 Sep 2022 05:54:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA39C433D6;
        Fri,  2 Sep 2022 05:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662098042;
        bh=ZCVrwOVxOedAeqF2VJSJ1MqkSUOoFJ5Np/T1O/uuDaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GGEJaSZJ8TfObC5gfj4WAIRrRx68MXYadMFrna4EP4/bOJpTVng5KpRT9w2WMvQ9A
         aJ72J6pQIjZkfyU24srJC0MhvFk0SUv+cm02ezR/h5yw3zm4CbOLw6b6r+bLStgM86
         bnLuLeyBgv0eBlvCCB0w1mbRqh6w2xNBKZFV+Ih4=
Date:   Fri, 2 Sep 2022 07:53:59 +0200
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
Message-ID: <YxGad5h2Nn/Ejslc@kroah.com>
References: <20220825152425.6296-1-logang@deltatee.com>
 <20220825152425.6296-8-logang@deltatee.com>
 <YxDb2MyRx6o/wDAz@kroah.com>
 <4a4bca1e-bebf-768f-92d4-92eb8ae714e1@deltatee.com>
 <YxDhEO9ycZDTnbZm@kroah.com>
 <cc9a24a8-dd3a-9d21-d9a7-5ee4b0ad7a57@deltatee.com>
 <YxD7uZYaV75gJS9d@kroah.com>
 <fb9d7948-43fe-87c5-5275-70f280181ad1@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb9d7948-43fe-87c5-5275-70f280181ad1@deltatee.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 01, 2022 at 01:16:54PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2022-09-01 12:36, Greg Kroah-Hartman wrote:
> > On Thu, Sep 01, 2022 at 12:14:25PM -0600, Logan Gunthorpe wrote:
> >> Well we haven't plugged in a remove call into p2pdma, that would be more
> >> work and more interfaces touching the PCI code. Note: this code isn't a
> >> driver but a set of PCI helpers available to other PCI drivers.
> >> Everything that's setup is using the devm interfaces and gets torn down
> >> with the same. So I don't really see the benefit of making the change
> >> you propose.
> > 
> > The issue is the classic one with the devm helpers.  They do not lend
> > themselves to resource management issues that require ordering or other
> > sort of dependencies.  Please do not use them here, just put in a remove
> > callback as you eventually will need it anyway, as you have a strong
> > requirement for what gets freed when, and the devm api does not provide
> > for that well.
> 
> This surprises me. Can you elaborate on this classic issue?

There's long threads about it on the ksummit discuss mailing list and
other places.

> I've definitely seen uses of devm that expect the calls will be torn
> down in reverse order they are added.

Sorry, I didn't mean to imply the ordering of the devm code is
incorrect, that's fine.

It's when you have things in the devm "chain" that need to be freed in a
different order that stuff gets messy.  Like irqs and clocks and other
types of resources that have "actions" associated with them.

> The existing p2pdma code will
> certainly fail quite significantly if a devm_kzalloc() releases its
> memory before the devm_memmap_pages() cleans up. There's also already an
> action that is used to cleanup before the last devm_kzalloc() call
> happens. If ordering is not guaranteed, then devm seems fairly broken
> and unusable and I'd have to drop all uses from this code and go back to
> the error prone method. Also what's the point of
> devm_add_action_or_reset() if it doesn't guarantee the ordering or the
> release?

I have never used devm_add_action_or_reset() so I can't say why it is
there.  I am just pointing out that manually messing with a sysfs group
from a driver is a huge flag that something is wrong.  A driver should
almost never be touching a raw kobject or calling any sysfs_* call if
all is normal, which is why I questioned this.

> But if it's that important I can make the change to these patches for v10.

Try it the way I suggest, with a remove() callback, and see if that
looks simpler and easier to follow and maintain over time.

thanks,

greg k-h
