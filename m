Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF91441DF8C
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 18:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351452AbhI3Qv6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 12:51:58 -0400
Received: from ale.deltatee.com ([204.191.154.188]:43978 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348841AbhI3Qv4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Sep 2021 12:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=74h/+uZ+hrx0m4JxI1QkVpn5MOeSFXzNtUhZ4V300TI=; b=B5EPYCR6ELWWooi0yJ6/qwUCfs
        xW68Odfkghb4ttQc08Np1dJRJhN9XdQKzIzlF9dxrShVzcR/fZ5mUTyUvDuCkeNQ4pQDaLqRNu4AV
        9LBrq4VtrshpfRFd0tC3BAEpbaapoxt2T047s7v1k6PNW0G2koW4beGyNRcL+qQrpt1pAbvFArccc
        9VhMSwHDeIwHWvh1BwQ3z3yRH/FBLA0ifIAFC12OqOFSrd1SnYHwgJBpvv5ay7kPYeRzcbtcELV2O
        OfNoBSYFaO6AmrjP+TI7VDSlCZHBP7pqp9YmEG2tAPspvl1N53iFQI2JW4LgrqkrZjwFCuG05yLoM
        xP02bFUA==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1mVzFp-0004cR-WF; Thu, 30 Sep 2021 10:49:55 -0600
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
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
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-2-logang@deltatee.com>
 <fa99b871-8753-7c3c-09f0-3fd7f610e664@nvidia.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c38e2ed7-43d8-767e-5b84-562c479267f4@deltatee.com>
Date:   Thu, 30 Sep 2021 10:49:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <fa99b871-8753-7c3c-09f0-3fd7f610e664@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: ckulkarnilinux@gmail.com, martin.oliveira@eideticom.com, robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, chaitanyak@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE,NICE_REPLY_A autolearn=ham
        autolearn_force=no version=3.4.2
Subject: Re: [PATCH v3 01/20] lib/scatterlist: add flag for indicating P2PDMA
 segments in an SGL
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-09-29 10:47 p.m., Chaitanya Kulkarni wrote:
> Logan,
> 
>> +/*
>> + * bit 2 is the third free bit in the page_link on 64bit systems which
>> + * is used by dma_unmap_sg() to determine if the dma_address is a PCI
>> + * bus address when doing P2PDMA.
>> + * Note: CONFIG_PCI_P2PDMA depends on CONFIG_64BIT because of this.
>> + */
>> +
>> +#ifdef CONFIG_PCI_P2PDMA
>> +#define SG_DMA_PCI_P2PDMA      0x04UL
>> +#else
>> +#define SG_DMA_PCI_P2PDMA      0x00UL
>> +#endif
>> +
>> +#define SG_PAGE_LINK_MASK (SG_CHAIN | SG_END | SG_DMA_PCI_P2PDMA)
>> +
> 
> You are doing two things in one patch :-
> 1. Introducing a new macro to replace the current macros.
> 2. Adding a new member to those macros.
> 
> shouldn't this be split into two patches where you introduce a
> macro SG_PAGE_LINK_MASK (SG_CHAIN | SG_END) in prep patch and
> update the SF_PAGE_LINK_MASK with SG_DMA_PCI_P2PDMA with related
> code?
> 

Ok, will split. I'll also add the static inline cleanup Jason suggested
in the first patch.

Logan
