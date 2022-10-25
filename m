Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F24960D0C7
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 17:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbiJYPhn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 11:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbiJYPhm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 11:37:42 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D9ED8EF5;
        Tue, 25 Oct 2022 08:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=f8Du+MtqcshkZAivSawu/fPBgzGqyOuTUC9w0UwA0us=; b=ma12HTv07ZvN/PMtXNYq8f4UVE
        tKXtoxcuzCMVqGLKjEXOj7DMUtJYVGj5+rPki6TxyFFCVpP46hxCji5pMn3E9YHtuuherZrziOpaW
        DH0G+ZZM5c5NQTW5Y3uRl0wIvA6qiQ3zQt6Bx/ixCGbeutwRoUdLhsNp/QeIQf9DclGpoHLHCPx8b
        VQ9U8Qs3jUiMZU1aWJnEuAT1K3GPkZ2M0LwAwXaBbiCoSJYnesVrmxPgqhLBib86Lqx3YeRc/zDAW
        IYZAXgSHru2stPrxuF0ZSV1HZTm4k6O75N1xXS/uIro7syUZ3yRkEPuMD0oloe6g8+dQEHQ9Ln/8G
        kHBW5WdA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1onLzk-00H0S9-TU; Tue, 25 Oct 2022 09:37:37 -0600
Message-ID: <458b5dce-e130-6608-119a-63ccf6bd1eae@deltatee.com>
Date:   Tue, 25 Oct 2022 09:37:35 -0600
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
 <20221021174116.7200-7-logang@deltatee.com>
 <f2995bf6-66c9-ea22-bd94-9efb87682a49@nvidia.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <f2995bf6-66c9-ea22-bd94-9efb87682a49@nvidia.com>
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
Subject: Re: [PATCH v11 6/9] block: set FOLL_PCI_P2PDMA in
 __bio_iov_iter_get_pages()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022-10-24 19:23, Chaitanya Kulkarni wrote:
> /*
>>   	 * Each segment in the iov is required to be a block size multiple.
>>   	 * However, we may not be able to get the entire segment if it spans
>> @@ -1217,8 +1221,9 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>>   	 * result to ensure the bio's total size is correct. The remainder of
>>   	 * the iov data will be picked up in the next bio iteration.
>>   	 */
>> -	size = iov_iter_get_pages2(iter, pages, UINT_MAX - bio->bi_iter.bi_size,
>> -				  nr_pages, &offset);
>> +	size = iov_iter_get_pages(iter, pages,
>> +				  UINT_MAX - bio->bi_iter.bi_size,
>> +				  nr_pages, &offset, gup_flags);
> 
> nit, 3rd param in above call fits on the first line ? plz check :-
> 
> iov_iter_get_pages(iter, pages, UINT_MAX - bio->bi_iter.bi_size,
>                     nr_pages, &offset, gup_flags);

Oh, yup, this just fits. I'll queue up the fix for if I send v12.

Logan
