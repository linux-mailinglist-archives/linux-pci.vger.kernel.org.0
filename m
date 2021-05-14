Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285BE380DE7
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 18:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhENQRK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 12:17:10 -0400
Received: from ale.deltatee.com ([204.191.154.188]:60726 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhENQRJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 May 2021 12:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=8mPdRqweUyDLPmZFuViN51lMyyF6RcsMDP/27vYhzgo=; b=U+OPhYGBE7d5nwlGLwZsALzoro
        3tgyDKF/0JnvDnEhiVty+7KLtudPXGsgdLrXK8kYa1UhRxLVYx5DTHvguR2b2SxqVbUGMOinTz5RG
        MaiKBrvV+aFk8n5JKHIpqq0/+O13MOf6raVLj/ytmq6kFn5OoOGeKnMdZV7srdp5EypPDRzRNnvDt
        Xcx+TrldLjB0CdBFWcHNA4i8QC6d1CT/44a9DZFyyrmkyCerhqDEyUgv2VGtTRFpKTv3RSlewLnZy
        ZjgSDqhOMfyPwZfy59y4RAtucHTLNIX3hzhpPDgPTeL+UzDpvLPANK7ryKC925sZWizH3oNMMS0fQ
        rpj+1uKw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1lhaTO-00065v-3k; Fri, 14 May 2021 10:15:35 -0600
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <20210513223203.5542-1-logang@deltatee.com>
 <20210513223203.5542-7-logang@deltatee.com> <20210514134900.GA4715@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e1407362-26fe-09db-0964-acfbb45c032c@deltatee.com>
Date:   Fri, 14 May 2021 10:15:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210514134900.GA4715@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH v2 06/22] PCI/P2PDMA: Attempt to set map_type if it has
 not been set
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-05-14 7:49 a.m., Christoph Hellwig wrote:
> On Thu, May 13, 2021 at 04:31:47PM -0600, Logan Gunthorpe wrote:
>> Attempt to find the mapping type for P2PDMA pages on the first
>> DMA map attempt if it has not been done ahead of time.
>>
>> Previously, the mapping type was expected to be calculated ahead of
>> time, but if pages are to come from userspace then there's no
>> way to ensure the path was checked ahead of time.
>>
>> With this change it's no longer invalid to call pci_p2pdma_map_sg()
>> before the mapping type is calculated so drop the WARN_ON when that
>> is the case.
> 
> Why?

Before this change, the if the mapping type wasn't already calculated
pci_p2pdma_map_sg() would just fail. This was fine for NVMe-of as it
always called pci_p2pdma_distance() ahead of time which calculated the
mapping type, stored it in the xarray and did not proceed if the two
devices could not talk to each other.

This patch makes it so if the mapping type is not already calculated at
dma map time, it does the calculation. This means the dma map operation
can fail if the two devices aren't able to talk to each other.

Logan
