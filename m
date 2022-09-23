Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC70D5E8262
	for <lists+linux-pci@lfdr.de>; Fri, 23 Sep 2022 21:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiIWTIn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Sep 2022 15:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbiIWTIm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Sep 2022 15:08:42 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4582A124C1A;
        Fri, 23 Sep 2022 12:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=ZQmZb+lXFhX7pnMcsk23AOR4qV5DlMOOudYTRaQuI38=; b=iyj5atjf9mY5DRHI6pWs1X4Bi6
        i7VWXXFHJq6mQF3UhKDCt1azxiYmU/3In5EAKRjGznKha0IhkHuKd/7hnByYfIMa0A10xryy3cNSI
        9/HmYFmTyE4XR1neliZtOrRXXnkaJ9R21hyg32c9fhQFArWvSxFVueJNleIU1j2erseIiSoUWDXbG
        tOhWjlXnaPU8ESbjgzqPj71YG3maPzlUvgOVWPqFkAVKrS7NJZv9TfQKrhcACp5dMGStbB6KGjxO+
        eKaMDd7tJjeaipjxYkgs+FEV1joq4uNiT2sAhEOHHWDyXHWLYIghjVmN8Fujqsk6/dLFSMh9Fta85
        HjoSW77g==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1obo2O-008xXP-NI; Fri, 23 Sep 2022 13:08:37 -0600
Message-ID: <64f8da81-7803-4db4-73da-a158295cbc9c@deltatee.com>
Date:   Fri, 23 Sep 2022 13:08:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-CA
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
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
References: <20220922163926.7077-1-logang@deltatee.com>
 <20220922163926.7077-2-logang@deltatee.com> <Yy33LUqvDLSOqoKa@ziepe.ca>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <Yy33LUqvDLSOqoKa@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: jgg@ziepe.ca, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, hch@lst.de, gregkh@linuxfoundation.org, dan.j.williams@intel.com, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, dave.b.minturn@intel.com, jason@jlekstrand.net, dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, rcampbell@nvidia.com, sbates@raithlin.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v10 1/8] mm: introduce FOLL_PCI_P2PDMA to gate getting PCI
 P2PDMA pages
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022-09-23 12:13, Jason Gunthorpe wrote:
> On Thu, Sep 22, 2022 at 10:39:19AM -0600, Logan Gunthorpe wrote:
>> GUP Callers that expect PCI P2PDMA pages can now set FOLL_PCI_P2PDMA to
>> allow obtaining P2PDMA pages. If GUP is called without the flag and a
>> P2PDMA page is found, it will return an error.
>>
>> FOLL_PCI_P2PDMA cannot be set if FOLL_LONGTERM is set.
> 
> What is causing this? It is really troublesome, I would like to fix
> it. eg I would like to have P2PDMA pages in VFIO iommu page tables and
> in RDMA MR's - both require longterm.

You had said it was required if we were relying on unmap_mapping_range()...

https://lore.kernel.org/all/20210928200506.GX3544071@ziepe.ca/T/#u

> Is it just because ZONE_DEVICE was created for DAX and carried that
> revocable assumption over? Does anything in your series require
> revocable?

We still rely on unmap_mapping_range() indirectly in the unbind path.
So I expect if something takes a LONGERM mapping that would block until
whatever process holds the pin releases it. That's less than ideal and
I'm not sure what can be done about it.

>> @@ -2383,6 +2392,10 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>>  		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
>>  		page = pte_page(pte);
>>  
>> +		if (unlikely(!(flags & FOLL_PCI_P2PDMA) &&
>> +			     is_pci_p2pdma_page(page)))
>> +			goto pte_unmap;
>> +
>>  		folio = try_grab_folio(page, 1, flags);
>>  		if (!folio)
>>  			goto pte_unmap;
> 
> On closer look this is not in the right place, we cannot touch the
> content of *page without holding a ref, and that doesn't happen until
> until try_grab_folio() completes.
> 
> It would be simpler to put this check in try_grab_folio/try_grab_page
> after the ref has been obtained. That will naturally cover all the
> places that need it.

Ok, I can make that change.

Logan


