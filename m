Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830D041CE30
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 23:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344300AbhI2Vcq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 17:32:46 -0400
Received: from ale.deltatee.com ([204.191.154.188]:58952 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237351AbhI2Vcp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 17:32:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=6tw6VIf8QZ1mlsWGh+KwACIkxOMm5AZtflXeMzWKDvQ=; b=G14JPhTMh4902E+4gQOpPCi3NE
        bFxLHYjwVMdykIibHNGwwk/pfJGXatmfFScbRKqP5T+6cgkMlic66K1TnPj/+BC8j/maeAvLYRotG
        ORzZWzrzAW3Hz0kwwzy5NnyxHGwS6X410iNmK/7XOdakgXOPRmnlXQX4li117R5c5NTEe5AyXJctp
        I447GFVyTPVitNyLXfV4nNhxBdpafdYHIClVsnA/j/MQ6D+TDBXc8NapePSVE7WVhVJYba8tP0aDK
        j2NQQUrSiYHc+pbO0I+HvFF472sYp9bNn/BqdE6Soub7pluqmdrMQykwOElaEYZym+pT6Ga9TEQYr
        5xy7m3uQ==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1mVhAB-0006Lf-1O; Wed, 29 Sep 2021 15:30:51 -0600
To:     Jason Gunthorpe <jgg@nvidia.com>
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
 <20210916234100.122368-5-logang@deltatee.com>
 <20210928220502.GA1738588@nvidia.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <91469404-fd20-effa-2e01-aa79d9d4b9b5@deltatee.com>
Date:   Wed, 29 Sep 2021 15:30:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210928220502.GA1738588@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: ckulkarnilinux@gmail.com, martin.oliveira@eideticom.com, robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, christian.koenig@amd.com, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH v3 4/20] PCI/P2PDMA: introduce helpers for dma_map_sg
 implementations
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org




On 2021-09-28 4:05 p.m., Jason Gunthorpe wrote:
> On Thu, Sep 16, 2021 at 05:40:44PM -0600, Logan Gunthorpe wrote:
> 
>> +enum pci_p2pdma_map_type
>> +pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
>> +		       struct scatterlist *sg)
>> +{
>> +	if (state->pgmap != sg_page(sg)->pgmap) {
>> +		state->pgmap = sg_page(sg)->pgmap;
> 
> This has built into it an assumption that every page in the sg element
> has the same pgmap, but AFAIK nothing enforces this rule? There is no
> requirement that the HW has pfn gaps between the pgmaps linux decides
> to create over it.

No, that's not a correct reading of the code. Every time there is a new
pagemap, this code calculates the mapping type and bus offset. If a page
comes along with a different page map,f it recalculates. This just
reduces the overhead so that the calculation is done only every time a
page with a different pgmap comes along and not doing it for every
single page.

> At least sg_alloc_append_table_from_pages() and probably something in
> the block world should be updated to not combine struct pages with
> different pgmaps, and this should be documented in scatterlist.*
> someplace.

There's no sane place to do this check. The code is designed to support
mappings with different pgmaps.

Logan
