Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA57E60D0B8
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 17:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbiJYPfd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 11:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbiJYPfc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 11:35:32 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186B8AE860;
        Tue, 25 Oct 2022 08:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=x0Yzo3aybKV00mvxm0n+9+v1NGi8dTPJwFPa0omZxuE=; b=TECqBrsdO3eJvM/HwoglBPPjsi
        dzMGqk2j2XncTUg3/bTvE9onc3miFg+MAkyNsga8bElyzRLnAvjYeSkIv+weqKScShndHJOo1rNGx
        /MSeBNPOBQzoaEF+lwDkJV1MvB/MZY+2ONVduaX1mcgFn7/A3C1VwH/FXVkppjmzXuQQpe3Y2xW/O
        KZenWN8CDqmV5JSRsm/v2dvyE5pkksWI9GfcoYs6ecrr/g1iXHiMwXwtDSS3CaUu8/T+5oC9vKi3w
        +etNolO1BjumECdDkTpeWXLoKwzZizi4zMD4uP8rOT1DO6H+twuEbalWwlcabsXQ8ZvEWd7UI0SYP
        CboL3j9w==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1onLxd-00H0QY-Ic; Tue, 25 Oct 2022 09:35:26 -0600
Message-ID: <41e621bb-e836-4a86-e6db-0beed19f5ddc@deltatee.com>
Date:   Tue, 25 Oct 2022 09:35:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-CA
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
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
References: <20221021174116.7200-1-logang@deltatee.com>
 <20221021174116.7200-4-logang@deltatee.com>
 <929ac68b-cf07-8df6-e589-49b0576a50c5@nvidia.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <929ac68b-cf07-8df6-e589-49b0576a50c5@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: chaitanyak@nvidia.com, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, hch@lst.de, gregkh@linuxfoundation.org, dan.j.williams@intel.com, jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, dave.b.minturn@intel.com, jason@jlekstrand.net, dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, rcampbell@nvidia.com, sbates@raithlin.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v11 3/9] iov_iter: introduce
 iov_iter_get_pages_[alloc_]flags()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022-10-24 19:14, Chaitanya Kulkarni wrote:
> On 10/21/22 10:41, Logan Gunthorpe wrote:
>> Add iov_iter_get_pages_flags() and iov_iter_get_pages_alloc_flags()
>> which take a flags argument that is passed to get_user_pages_fast().
>>
>> This is so that FOLL_PCI_P2PDMA can be passed when appropriate.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   include/linux/uio.h |  6 ++++++
>>   lib/iov_iter.c      | 32 ++++++++++++++++++++++++--------
>>   2 files changed, 30 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/linux/uio.h b/include/linux/uio.h
>> index 2e3134b14ffd..9ede533ce64c 100644
>> --- a/include/linux/uio.h
>> +++ b/include/linux/uio.h
>> @@ -247,8 +247,14 @@ void iov_iter_pipe(struct iov_iter *i, unsigned int direction, struct pipe_inode
>>   void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count);
>>   void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *xarray,
>>   		     loff_t start, size_t count);
>> +ssize_t iov_iter_get_pages(struct iov_iter *i, struct page **pages,
>> +		size_t maxsize, unsigned maxpages, size_t *start,
>> +		unsigned gup_flags);
>>   ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
>>   			size_t maxsize, unsigned maxpages, size_t *start);
>> +ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
>> +		struct page ***pages, size_t maxsize, size_t *start,
>> +		unsigned gup_flags);
>>   ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i, struct page ***pages,
>>   			size_t maxsize, size_t *start);
>>   int iov_iter_npages(const struct iov_iter *i, int maxpages);
>> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
>> index c3ca28ca68a6..53efad017f3c 100644
>> --- a/lib/iov_iter.c
>> +++ b/lib/iov_iter.c
>> @@ -1430,7 +1430,8 @@ static struct page *first_bvec_segment(const struct iov_iter *i,
>>   
>>   static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
>>   		   struct page ***pages, size_t maxsize,
>> -		   unsigned int maxpages, size_t *start)
>> +		   unsigned int maxpages, size_t *start,
>> +		   unsigned int gup_flags)
>>   {
>>   	unsigned int n;
>>   
>> @@ -1442,7 +1443,6 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
>>   		maxsize = MAX_RW_COUNT;
>>   
>>   	if (likely(user_backed_iter(i))) {
>> -		unsigned int gup_flags = 0;
>>   		unsigned long addr;
>>   		int res;
>>   
>> @@ -1492,33 +1492,49 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
>>   	return -EFAULT;
>>   }
>>   
>> -ssize_t iov_iter_get_pages2(struct iov_iter *i,
>> +ssize_t iov_iter_get_pages(struct iov_iter *i,
>>   		   struct page **pages, size_t maxsize, unsigned maxpages,
>> -		   size_t *start)
>> +		   size_t *start, unsigned gup_flags)
>>   {
>>   	if (!maxpages)
>>   		return 0;
>>   	BUG_ON(!pages);
>>   
>> -	return __iov_iter_get_pages_alloc(i, &pages, maxsize, maxpages, start);
>> +	return __iov_iter_get_pages_alloc(i, &pages, maxsize, maxpages,
>> +					  start, gup_flags);
>> +}
>> +EXPORT_SYMBOL_GPL(iov_iter_get_pages);
>> +
>> +ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
>> +		size_t maxsize, unsigned maxpages, size_t *start)
>> +{
>> +	return iov_iter_get_pages(i, pages, maxsize, maxpages, start, 0);
>>   }
>>   EXPORT_SYMBOL(iov_iter_get_pages2);
>>   
>> -ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i,
>> +ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
>>   		   struct page ***pages, size_t maxsize,
>> -		   size_t *start)
>> +		   size_t *start, unsigned gup_flags)
>>   {
>>   	ssize_t len;
>>   
>>   	*pages = NULL;
>>   
>> -	len = __iov_iter_get_pages_alloc(i, pages, maxsize, ~0U, start);
>> +	len = __iov_iter_get_pages_alloc(i, pages, maxsize, ~0U, start,
>> +					 gup_flags);
>>   	if (len <= 0) {
>>   		kvfree(*pages);
>>   		*pages = NULL;
>>   	}
>>   	return len;
>>   }
>> +EXPORT_SYMBOL_GPL(iov_iter_get_pages_alloc);
>> +
>> +ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i,
>> +		struct page ***pages, size_t maxsize, size_t *start)
>> +{
>> +	return iov_iter_get_pages_alloc(i, pages, maxsize, start, 0);
>> +}
>>   EXPORT_SYMBOL(iov_iter_get_pages_alloc2);
> Just one minor question why not make following functions
> EXPORT_SYMBOL_GPL() ?
> 
> 1. iov_iter_get_pages2()
> 2. iov_iter_get_pages_alloc2()

They previously were not GPL, so I didn't think that should be changed
in this patch.

Thanks for the review!

Logan
