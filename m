Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A43936CF03
	for <lists+linux-pci@lfdr.de>; Wed, 28 Apr 2021 00:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237009AbhD0XAd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Apr 2021 19:00:33 -0400
Received: from ale.deltatee.com ([204.191.154.188]:42800 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235382AbhD0XAd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Apr 2021 19:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=yfDJcXRXLcFqUpWKFnDEug6ObcuKDigbRQxLqk4fhDY=; b=sbQMyumPhi9BO3PW7BbH7jx3Mv
        vyQd71v56wBfsn24nwtkY+oIQgX3d3l1Ef2xR/D7FmPPejRkZzxHW3lZYylXqntM3wayVT8xUbSON
        pRu0g92wUrYkY4mSSqIOYl5nF3ZdzT0niosmL6qBWRsJuD7/K/AvnuHQmjnHK7oloxX99WCDjqOI0
        cg5+SNiz8HchO6MM165oba4v51OTzr/KDIokovNCY/DFWZ7sMQFW03g7hYFCoWTz3ocn/dosmVMEZ
        sGBSFJDc2fGekrXGh7GNV2q3EeYZREtOFpzZ4vfUtHADST8VMXbeGXWLL0y5KZxGTJ2ejJzeaB2up
        1+e2wlfw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1lbWg7-0002nw-DI; Tue, 27 Apr 2021 16:59:40 -0600
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
        Robin Murphy <robin.murphy@arm.com>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-12-logang@deltatee.com>
 <20210427194337.GT2047089@ziepe.ca>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <4e2537b1-21f3-f726-07bb-91d086e6d124@deltatee.com>
Date:   Tue, 27 Apr 2021 16:59:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210427194337.GT2047089@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, christian.koenig@amd.com, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH 11/16] iommu/dma: Support PCI P2PDMA pages in dma-iommu
 map_sg
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-04-27 1:43 p.m., Jason Gunthorpe wrote:
> On Thu, Apr 08, 2021 at 11:01:18AM -0600, Logan Gunthorpe wrote:
>> When a PCI P2PDMA page is seen, set the IOVA length of the segment
>> to zero so that it is not mapped into the IOVA. Then, in finalise_sg(),
>> apply the appropriate bus address to the segment. The IOVA is not
>> created if the scatterlist only consists of P2PDMA pages.
> 
> I expect P2P to work with systems that use ATS, so we'd want to see
> those systems have the IOMMU programmed with the bus address.

Oh, the paragraph you quote isn't quite as clear as it could be. The bus
address is only used in specific circumstances depending on how the
P2PDMA core code figures the addresses should be mapped (see the
documentation for (upstream_bridge_distance()). The P2PDMA code
currently doesn't have any provisions for ATS (I haven't had access to
any such hardware) but I'm sure it wouldn't be too hard to add.

Logan
