Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D464147C4F2
	for <lists+linux-pci@lfdr.de>; Tue, 21 Dec 2021 18:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhLURYF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Dec 2021 12:24:05 -0500
Received: from ale.deltatee.com ([204.191.154.188]:53604 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbhLURYF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Dec 2021 12:24:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=6RE2t3Nrh37PIF515dZ3u+BHHExtd6YU1HsGcK2dnu4=; b=eXXVACeUXdlIB1/KjWu9GhcS1t
        xrekSWq8RR2HCh+ekHLaiG+FIMaBYGfJYe5FGYP48P0GSRb0k+4RcTErCcOt9jBFo1Ig9Sjj3Kmoe
        tYncC6lDUuP1bBmukDNNGvuJU7dzQGVanoWl4myv8s/QCXLVm72hdiY9G793ucRM2CiViDyHuRKK1
        7i04q7Rmc1PbF/nOuxVTO3/I4ww8EecYfZPpNo9Hs1p8QOcgmTzxATUwvQhora8iHePLymjF6XC09
        IIUeWkGtVQTpxCWH7uDR7kLmDT2i93+1oUQMtFpv4hoHCiA3m8EbXPaWgvrA4OrO2Fuj1hJ76ySdm
        ndk5VOCg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1mzirJ-00AX1V-OI; Tue, 21 Dec 2021 10:23:31 -0700
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
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20211117215410.3695-1-logang@deltatee.com>
 <20211117215410.3695-2-logang@deltatee.com> <20211221090003.GA7949@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <05095125-464e-4e85-f609-c7bc93d2f479@deltatee.com>
Date:   Tue, 21 Dec 2021 10:23:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211221090003.GA7949@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: jgg@nvidia.com, ckulkarnilinux@gmail.com, martin.oliveira@eideticom.com, robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v4 01/23] lib/scatterlist: cleanup macros into static
 inline functions
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-12-21 2:00 a.m., Christoph Hellwig wrote:
> On Wed, Nov 17, 2021 at 02:53:48PM -0700, Logan Gunthorpe wrote:
>> Convert the sg_is_chain(), sg_is_last() and sg_chain_ptr() macros
>> into static inline functions. There's no reason for these to be macros
>> and static inline are generally preferred these days.
>>
>> Also introduce the SG_PAGE_LINK_MASK define so the P2PDMA work, which is
>> adding another bit to this mask, can do so more easily.
>>
>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> 
> Looks fine:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> scatterlist.h doesn't have a real maintainer, do you want me to pick
> this up through the DMA tree?

Sure, that would be great!

Thanks,

Logan
