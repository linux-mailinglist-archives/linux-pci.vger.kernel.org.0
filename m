Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3BD41CF8D
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 00:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346645AbhI2W6Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 18:58:24 -0400
Received: from ale.deltatee.com ([204.191.154.188]:60068 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345988AbhI2W6Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 18:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=gyI1iWTgaQxXLC0uh18K74XDfJOQ35Yd/0UtBH7oL2Y=; b=VyEMo1To4bpq3hE/xr6uacN63S
        sFo8JLN2lg3Nt7NjJD/RyCHJ3xIMnFvvWyJQJDzNwEv5i2F31KL273mFPxjWpXsi8VJB7W8aU8iuX
        UhU9U05GQuc4pdzxedOdf9TAaZLqlqelpLTq2C+UtXnoObaPYB2yfaH1YLeAfoLoxcX8gTb/p0aCT
        164B3Y/N5rl7w8PhlikTl4aQ4jNqsb1jJoT2BUjjfIZtVih+GwnXuoh5B3mbUqiLvXqgCmdNOOLxt
        Cw4AtoX4dmjtYkv8q48FbqX8M5k1KxfxuoejCgFSCUcvy99IFnZpCWPQA7rx4nIKKrpUNT13PyREe
        /6e6C7DQ==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1mViV2-0007a2-MS; Wed, 29 Sep 2021 16:56:29 -0600
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
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
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-13-logang@deltatee.com>
 <20210928194325.GS3544071@ziepe.ca>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e7bbe021-9a0c-1999-0a2a-ba249578c9c7@deltatee.com>
Date:   Wed, 29 Sep 2021 16:56:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210928194325.GS3544071@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: ckulkarnilinux@gmail.com, martin.oliveira@eideticom.com, robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, christian.koenig@amd.com, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH v3 12/20] RDMA/rw: use dma_map_sgtable()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org




On 2021-09-28 1:43 p.m., Jason Gunthorpe wrote:
> On Thu, Sep 16, 2021 at 05:40:52PM -0600, Logan Gunthorpe wrote:
>> dma_map_sg() now supports the use of P2PDMA pages so pci_p2pdma_map_sg()
>> is no longer necessary and may be dropped.
>>
>> Switch to the dma_map_sgtable() interface which will allow for better
>> error reporting if the P2PDMA pages are unsupported.
>>
>> The change to sgtable also appears to fix a couple subtle error path
>> bugs:
>>
>>   - In rdma_rw_ctx_init(), dma_unmap would be called with an sg
>>     that could have been incremented from the original call, as
>>     well as an nents that was not the original number of nents
>>     called when mapped.
>>   - Similarly in rdma_rw_ctx_signature_init, both sg and prot_sg
>>     were unmapped with the incorrect number of nents.
> 
> Those bugs should definately get fixed.. I might extract the sgtable
> conversion into a stand alone patch to do it.

Yes. I can try to split it off myself and send a patch later this week.

Logan
