Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8452A9BE9
	for <lists+linux-pci@lfdr.de>; Fri,  6 Nov 2020 19:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgKFSUV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Nov 2020 13:20:21 -0500
Received: from ale.deltatee.com ([204.191.154.188]:59272 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727918AbgKFSUU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Nov 2020 13:20:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4c2lQ6ZJoiJD4wddIsh1sqnOjISbk8NdEHLgyMHjsI4=; b=WEavvMGUHHtVS6NthMSIjYgE8G
        m2Shk+887YnWyl84qAu5c5aSnwfmdgsQkwuV6Qk/VTpfpITmSKpZTStz2VoJeuvrgKYFgbkpcC2x9
        +Eygs4xkSnIjwB3jk8TQYbV+xWQY2KzZLECeTap/XHrhF7RfsNefRy2cKKo9kcYj3Hkd43uD6lH8r
        UeDxe01Yy7KFTC7wo/J2Zw1d3VJYZkJMQ5JZSmcYq3a5l1dL0v2dLl8ounQVMEe9onzzakY4UYleu
        immFBl00AOuIB6Gr3JQNUHz9T+DktFRE1Gznw7frT3XHfeD8UYFSjQcgB6Z9ymXrL/hXHs6bQE5SP
        AZUhpu/A==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1kb6LI-0003vN-G2; Fri, 06 Nov 2020 11:20:09 -0700
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Ira Weiny <iweiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
References: <20201106170036.18713-1-logang@deltatee.com>
 <20201106170036.18713-15-logang@deltatee.com>
 <20201106172206.GS36674@ziepe.ca>
 <b1e8dfce-d583-bed8-d04d-b7265a54c99f@deltatee.com>
 <20201106174223.GU36674@ziepe.ca>
 <2c2d2815-165e-2ef9-60d6-3ace7ff3aaa5@deltatee.com>
 <20201106180922.GV36674@ziepe.ca>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <09885400-36f8-bc1d-27f0-a8adcf6104d4@deltatee.com>
Date:   Fri, 6 Nov 2020 11:20:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201106180922.GV36674@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, iweiny@intel.com, christian.koenig@amd.com, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE,NICE_REPLY_A autolearn=ham
        autolearn_force=no version=3.4.2
Subject: Re: [RFC PATCH 14/15] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020-11-06 11:09 a.m., Jason Gunthorpe wrote:
>> Ah, hmm, yes. I guess the pages have to be hooked and returned to the
>> genalloc through free_devmap_managed_page(). 
> 
> That sounds about right, but in this case it doesn't need the VMA
> operations.
> 
>> Seems like it might be doable... but it will complicate things for
>> users that don't want to use the genpool (though no such users exist
>> upstream).
> 
> I would like to use this stuff in RDMA pretty much immediately and the
> genpool is harmful for those cases, so please don't make decisions
> that are tying thing to genpool

I certainly can't make decisions for code that isn't currently upstream.
So you will almost certainly have to make changes for the code you want
to add, as is the standard procedure. I can't and should not export APIs
that you might need that have no upstream users, but you are certainly
free to send patches that create them when you add the use case.

Ultimately, if you aren't using the genpool you will have to implement
your own mmap operation that somehow allocates the pages and your own
page_free hook. The latter can be accommodated for by a patch that
splits off pci_p2pdma_add_resource() into a function that doesn't use
the genpool (I've already seen two independent developers create a
similar patch for this but with no upstream user, they couldn't be taken
upstream).

I also don't expect this to be going upstream in the near term so don't
get too excited about using it.

Logan
