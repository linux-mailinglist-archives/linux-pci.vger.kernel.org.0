Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEDF3398B9
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 21:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbhCLUz5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 15:55:57 -0500
Received: from ale.deltatee.com ([204.191.154.188]:46738 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235009AbhCLUzg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Mar 2021 15:55:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=CGrXx6tnunS4rU4vJV260ajUW0JSem+Dld3wlshcr6w=; b=BDbN0bC7mvuP4MZ4/ukk0LJPNY
        DPviP0ZYyTMeFAwbu8j5dMB7b2KzG2FZ7qIkKt0NUgGiAf1lt0M1PYF+gfW9IiRlBWt46STFG4T8J
        cZYMNg2vCeXa+Q8UWw2v2fJVgGu+2rbQWfbc9Xj5/D0yUfdNA2Z63WK6JaJHzMzVN8MTGlNX/GGyd
        Q6TBybdzp+x5Va6pP4OJcp8RqQl1vJGjI19FBAYa1GlCi7QLe7TtG8cifa5LNRoBCRtHYgdC61UIV
        8pOHhROLuEdapKBxAr35W/geKRPGeu8OGDWP2al0JqcX1wjdqdeNjhR6T4IFhrJ7RbKjOU1kMSY/G
        DjXl5YXA==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1lKon3-0002ZN-Ku; Fri, 12 Mar 2021 13:53:46 -0700
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Ira Weiny <iweiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>
References: <20210312203936.GA2286981@bjorn-Precision-5520>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b7b61f6d-3a94-3539-f7f5-425fbb1a9dfa@deltatee.com>
Date:   Fri, 12 Mar 2021 13:53:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210312203936.GA2286981@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, iweiny@intel.com, christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [RFC PATCH v2 01/11] PCI/P2PDMA: Pass gfp_mask flags to
 upstream_bridge_distance_warn()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-03-12 1:39 p.m., Bjorn Helgaas wrote:
> On Thu, Mar 11, 2021 at 04:31:31PM -0700, Logan Gunthorpe wrote:
>> In order to call this function from a dma_map function, it must not sleep.
>> The only reason it does sleep so to allocate the seqbuf to print
>> which devices are within the ACS path.
> 
> s/this function/upstream_bridge_distance_warn()/ ?
> s/so to/is to/
> 
> Maybe the subject could say something about the purpose, e.g., allow
> calling from atomic context or something?  "Pass gfp_mask flags" sort
> of restates what we can read from the patch, but without the
> motivation of why this is useful.
> 
>> Switch the kmalloc call to use a passed in gfp_mask  and don't print that
>> message if the buffer fails to be allocated.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks! I'll apply these changes for any future postings.

Logan
