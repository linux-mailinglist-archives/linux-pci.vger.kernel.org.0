Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0D64A4F1C
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jan 2022 20:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358212AbiAaTAz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 14:00:55 -0500
Received: from ale.deltatee.com ([204.191.154.188]:36660 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244293AbiAaTAy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jan 2022 14:00:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=JfiBWAhkX1yHT92Ca969hKJaoVoe9ZEugeTA+o2gzlk=; b=l8gfX2giRWGgLu5RJY5tnXex3G
        naOg0DFHyGRH+WLiZNH6sHyFr4bWsG1rAvdlZ1fmScq1SMfZDFIEnUYH8VczuVNJAw9nbR2ZHg/oq
        yJTHQQQl/ejTUOl5M+8lgqwY+8MnixFCjR2Spi6TJ1qAU3tOAr6Zvchw6CRPXgL437qt1wS6Z172Y
        dkvB2bUHt9IHazdxNJlQRzlYq1Zun08wMxYQTlew19LVw6U3nB3ecjgtyBQp29pl1CavUC8RSaymJ
        GqmzMSm6w+nK1bSbSduZGxfQ/6O6c76ZYO2FoIihh1jEypL8oHnl8n01OJnsZT5sASWHH3nFELW0W
        Q3IdSFGw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1nEbuV-008jbJ-R5; Mon, 31 Jan 2022 12:00:20 -0700
To:     Jonathan Derrick <jonathan.derrick@linux.dev>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org
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
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>
References: <20220128002614.6136-1-logang@deltatee.com>
 <c725798d-48da-2993-cc48-0ec0b314455f@linux.dev>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <08564685-e027-30b2-2c6e-9faf1d95dc7a@deltatee.com>
Date:   Mon, 31 Jan 2022 12:00:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <c725798d-48da-2993-cc48-0ec0b314455f@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: rcampbell@nvidia.com, ckulkarnilinux@gmail.com, martin.oliveira@eideticom.com, robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jonathan.derrick@linux.dev
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v5 00/24] Userspace P2PDMA with O_DIRECT NVMe devices
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022-01-31 11:56 a.m., Jonathan Derrick wrote:
>> This is relatively straightforward, however the one significant
>> problem is that, presently, pci_p2pdma_map_sg() requires a homogeneous
>> SGL with all P2PDMA pages or all regular pages. Enhancing GUP to
>> support enforcing this rule would require a huge hack that I don't
>> expect would be all that pallatable. So patches 3 to 16 add
>> support for P2PDMA pages to dma_map_sg[table]() to the dma-direct
>> and dma-iommu implementations. Thus systems without an IOMMU plus
>> Intel and AMD IOMMUs are supported. (Other IOMMU implementations would
>> then be unsupported, notably ARM and PowerPC but support would be added
>> when they convert to dma-iommu).
> Am I understanding that an IO may use a mix of p2pdma and system pages?
> Would that cause inconsistent latencies?

Yes, that certainly would be a possibility. People developing
applications that do such mixing would have to weight that issue if
latency is something they care about.

But it's counter productive and causes other difficulties for the kernel
to enforce only homogenous IO.

Logan
