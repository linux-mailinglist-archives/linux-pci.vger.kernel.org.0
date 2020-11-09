Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551F02ABE28
	for <lists+linux-pci@lfdr.de>; Mon,  9 Nov 2020 15:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbgKIOC0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Nov 2020 09:02:26 -0500
Received: from foss.arm.com ([217.140.110.172]:41070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730035AbgKIOC0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Nov 2020 09:02:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C77E31B;
        Mon,  9 Nov 2020 06:02:25 -0800 (PST)
Received: from [10.57.54.223] (unknown [10.57.54.223])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 383D53F719;
        Mon,  9 Nov 2020 06:02:23 -0800 (PST)
Subject: Re: [RFC PATCH 04/15] lib/scatterlist: Add flag for indicating P2PDMA
 segments in an SGL
To:     Christoph Hellwig <hch@lst.de>,
        Logan Gunthorpe <logang@deltatee.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-pci@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Ira Weiny <iweiny@intel.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Stephen Bates <sbates@raithlin.com>,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <20201106170036.18713-1-logang@deltatee.com>
 <20201106170036.18713-5-logang@deltatee.com> <20201109091258.GB28918@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <491c26de-bda0-3266-a67d-ee2580559a54@arm.com>
Date:   Mon, 9 Nov 2020 14:02:21 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201109091258.GB28918@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-11-09 09:12, Christoph Hellwig wrote:
> On Fri, Nov 06, 2020 at 10:00:25AM -0700, Logan Gunthorpe wrote:
>> We make use of the top bit of the dma_length to indicate a P2PDMA
>> segment.
> 
> I don't think "we" can.  There is nothing limiting the size of a SGL
> segment.

Right, the story behind ab2cbeb0ed30 ("iommu/dma: Handle SG length 
overflow better") comes immediately to mind, for one. If all the P2P 
users can agree to be in on the game then by all means implement this in 
the P2P code, but I don't think it belongs in the generic top-level 
scatterlist API.

Robin.
