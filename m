Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B3B5E5D9A
	for <lists+linux-pci@lfdr.de>; Thu, 22 Sep 2022 10:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiIVIiU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Sep 2022 04:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiIVIiU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2022 04:38:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70149A59B6;
        Thu, 22 Sep 2022 01:38:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25346B83134;
        Thu, 22 Sep 2022 08:38:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6B2C433D6;
        Thu, 22 Sep 2022 08:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663835896;
        bh=ZXqrm8nedeHyjJHSE+1GJ5DZF7ttxhR/iupCB+jykP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sLVTqeua8VBBS9O2uBUp1F+RCRb3jzgT/qYn8/Erj5crjgRsyAtxSy76D5wqSuehI
         ky9/I44ksfKvi5sSHy7PazF5U81CS9thdVN+6Zzm6o2+vNMFMFDT7elLAZup43khua
         W/eR3vgb0Y3Make/VdghCWlJmdQ8796Skliks+5Q=
Date:   Thu, 22 Sep 2022 10:38:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>,
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
Message-ID: <Yywe9rBMB6hlUwqw@kroah.com>
References: <20220825152425.6296-8-logang@deltatee.com>
 <YxDb2MyRx6o/wDAz@kroah.com>
 <4a4bca1e-bebf-768f-92d4-92eb8ae714e1@deltatee.com>
 <YxDhEO9ycZDTnbZm@kroah.com>
 <cc9a24a8-dd3a-9d21-d9a7-5ee4b0ad7a57@deltatee.com>
 <YxD7uZYaV75gJS9d@kroah.com>
 <fb9d7948-43fe-87c5-5275-70f280181ad1@deltatee.com>
 <YxGad5h2Nn/Ejslc@kroah.com>
 <db8cd049-c78b-1aa0-dcd0-0feb8c6cb25c@deltatee.com>
 <20220920064613.GB17325@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920064613.GB17325@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 20, 2022 at 08:46:13AM +0200, Christoph Hellwig wrote:
> On Fri, Sep 02, 2022 at 12:46:54PM -0600, Logan Gunthorpe wrote:
> > See the diff at the bottom of this email. I can apply it on top of this
> > patch, but IMO it is neither easier to follow nor maintain. Unless you 
> > have a different suggestion...
> 
> Greg, can you chime in on this?  Besides this item we just have a few
> cosmetic bits left I think, and I'd really like to get the series into
> this merge window.
> 

I don't seem to have this in my inbox at all anymore, sorry.

The original should be fine, Logan, thanks for trying to split it out a
bit more.  So this can be taken as-is for 6.1-rc1.

thanks,

greg k-h
