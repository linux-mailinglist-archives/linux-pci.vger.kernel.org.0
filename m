Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9171741CE41
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 23:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346199AbhI2VgT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 17:36:19 -0400
Received: from ale.deltatee.com ([204.191.154.188]:59044 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345930AbhI2VgS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 17:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=Bs8bMhC7bQAuNPOpZEH0zniuEdm9NW/YrFeZImeIfOA=; b=I2EoSXtUtxxE6I7rRXNlaQi1Cr
        26y7kb5TT5Pm2pY5KxdBM9XFbLlCc1/rp6B788hVTB6/j0GiBnouY+POEQdum7NZv9aXHc5gg45iF
        yDAL1n2pfsNdyOEb90H2C4R4SoWew8wSXqeMJiwcAExoJRoh6co1C/CZ0YGaO2ofnpKtpl9BhvsIt
        n2teiyqjsDdWHRe3V8sdAM1Oxu9gQupPSVaReSA3KUwu7+sZf+t5nMdzuSACvG6+2YM5krqC8RIUR
        dFiVhA4xErhytJnA9uXt2A1tDoLp4et4Tm1Ld8W02rwrG6hBlPYYC+mPAn/D7qJpK5zLNDI85nLXB
        zO+aoKCA==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1mVhDc-0006Oe-EH; Wed, 29 Sep 2021 15:34:25 -0600
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
 <20210916234100.122368-15-logang@deltatee.com>
 <20210928194707.GU3544071@ziepe.ca>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9c40347c-f9a8-af86-71a5-2156359e15ce@deltatee.com>
Date:   Wed, 29 Sep 2021 15:34:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210928194707.GU3544071@ziepe.ca>
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
Subject: Re: [PATCH v3 14/20] mm: introduce FOLL_PCI_P2PDMA to gate getting
 PCI P2PDMA pages
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org




On 2021-09-28 1:47 p.m., Jason Gunthorpe wrote:
> On Thu, Sep 16, 2021 at 05:40:54PM -0600, Logan Gunthorpe wrote:
>> Callers that expect PCI P2PDMA pages can now set FOLL_PCI_P2PDMA to
>> allow obtaining P2PDMA pages. If a caller does not set this flag
>> and tries to map P2PDMA pages it will fail.
>>
>> This is implemented by adding a flag and a check to get_dev_pagemap().
> 
> I would like to see the get_dev_pagemap() deleted from GUP in the
> first place.
> 
> Why isn't this just a simple check of the page->pgmap type after
> acquiring a valid page reference? See my prior note

It could be, but that will mean dereferencing the pgmap for every page
to determine the type of page and then comparing with FOLL_PCI_P2PDMA.

Probably not terrible to go this way.

Logan
