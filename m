Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C89960FA52
	for <lists+linux-pci@lfdr.de>; Thu, 27 Oct 2022 16:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235763AbiJ0OXP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 10:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbiJ0OXO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 10:23:14 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728E317C55B;
        Thu, 27 Oct 2022 07:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=LyOCU4xpjTTzBhxH1rdyd7TExb5ifJ5snNn8tAmKhaY=; b=MAQjGDL+n0Jp7ezjgZqNWaIPdv
        kbAEpt3r4ap1EWC5XSVaw+OWN25y8+PPt63ZAA/BusDAV9ToTonAcRLlj3w7fE+XaTQBJ7DGoz3EM
        SciMfLGcUvNFBUwWlWabew4Xe3Nzv082uIYP1utpislLqNawQNXRwtcU7DIddQsndpd99Ljp3ol+v
        W95zxl5FEpr8Wp9GGLpXq/tdZHIxpM9OetLizn6UBfYQu69h8t0JlJ6xK8wINfYHzqeqgD6tYCDit
        jMpUoU+WzmqoLrPPWbM/jNu5FXoc8kKf+w89lF6byFO6bjdU12S+7MUCGNmexF+f/TZRFmj7FoNSY
        AOrYbDQg==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1oo3mi-0012H3-V8; Thu, 27 Oct 2022 08:23:06 -0600
Message-ID: <e27a14f9-ed4d-b98b-940c-2ede0ebcb31b@deltatee.com>
Date:   Thu, 27 Oct 2022 08:22:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-CA
To:     Jay Fang <f.fangjian@huawei.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org
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
 <c73c426f-d9f5-2f17-bb88-b72792103703@huawei.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <c73c426f-d9f5-2f17-bb88-b72792103703@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: f.fangjian@huawei.com, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, hch@lst.de, gregkh@linuxfoundation.org, dan.j.williams@intel.com, jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, dave.b.minturn@intel.com, jason@jlekstrand.net, dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, rcampbell@nvidia.com, sbates@raithlin.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v11 3/9] iov_iter: introduce
 iov_iter_get_pages_[alloc_]flags()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022-10-27 01:11, Jay Fang wrote:
> On 2022/10/22 1:41, Logan Gunthorpe wrote:
>> Add iov_iter_get_pages_flags() and iov_iter_get_pages_alloc_flags()
>> which take a flags argument that is passed to get_user_pages_fast().
>>
>> This is so that FOLL_PCI_P2PDMA can be passed when appropriate.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> ---
>>  include/linux/uio.h |  6 ++++++
>>  lib/iov_iter.c      | 32 ++++++++++++++++++++++++--------
>>  2 files changed, 30 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/linux/uio.h b/include/linux/uio.h
>> index 2e3134b14ffd..9ede533ce64c 100644
>> --- a/include/linux/uio.h
>> +++ b/include/linux/uio.h
>> @@ -247,8 +247,14 @@ void iov_iter_pipe(struct iov_iter *i, unsigned int direction, struct pipe_inode
>>  void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count);
>>  void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *xarray,
>>  		     loff_t start, size_t count);
>> +ssize_t iov_iter_get_pages(struct iov_iter *i, struct page **pages,
>> +		size_t maxsize, unsigned maxpages, size_t *start,
>> +		unsigned gup_flags);
>>  ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
>>  			size_t maxsize, unsigned maxpages, size_t *start);
>> +ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
>> +		struct page ***pages, size_t maxsize, size_t *start,
>> +		unsigned gup_flags);
>>  ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i, struct page ***pages,
>>  			size_t maxsize, size_t *start);
>>  int iov_iter_npages(const struct iov_iter *i, int maxpages);
>> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
>> index c3ca28ca68a6..53efad017f3c 100644
>> --- a/lib/iov_iter.c
>> +++ b/lib/iov_iter.c
>> @@ -1430,7 +1430,8 @@ static struct page *first_bvec_segment(const struct iov_iter *i,
>>  
>>  static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
>>  		   struct page ***pages, size_t maxsize,
>> -		   unsigned int maxpages, size_t *start)
>> +		   unsigned int maxpages, size_t *start,
>> +		   unsigned int gup_flags)
> 
> Hi,
> found some checkpatch warnings, like this:
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> #50: FILE: lib/iov_iter.c:1497:
> +		   size_t *start, unsigned gup_flags)

We usually stick with the choices of the nearby code instead of
the warnings of checkpatch.

Thanks,

Logan
