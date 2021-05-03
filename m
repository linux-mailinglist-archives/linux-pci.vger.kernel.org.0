Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC72371FB3
	for <lists+linux-pci@lfdr.de>; Mon,  3 May 2021 20:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhECScJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 May 2021 14:32:09 -0400
Received: from ale.deltatee.com ([204.191.154.188]:60494 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbhECScI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 May 2021 14:32:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=4PPTHdFwsG/FNijX7QmJQU5iOiwqKMFkAEJmwyjdEcs=; b=pWmTqC5UhoOtIRbROwzaB+ZWE1
        wHkLmyIDKJxZsZDLxgnD6Z1lbkZNPwtAHMVRKSMIIb9/0maQTAXw7MDfHeL1hFkcrZtGYsLBetLNw
        j+7qzrbqYPpPmJ23hX6P0ls4TPaV0WkGh5DsW1oxoRADWAdB3nzhINiIOs20KiGt0t0Ss/9SfTKjF
        xUcrvgRWw6/OrYVY9rAMPwOmac3o7/upKHt34JkI38fv0Z+DSNGGCnloayK7gr2BXlP4k3imBeIB9
        +aWQrrtNiOEqAn3BuRX+uctRRjVm2wQnywiNbH3clIsf9tjw46NnASc/POq5RagQrKSkmCqLwk8Y4
        wNygqJ9g==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1lddLV-0000jc-25; Mon, 03 May 2021 12:31:05 -0600
To:     Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
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
 <20210408170123.8788-6-logang@deltatee.com>
 <20210427193157.GQ2047089@ziepe.ca>
 <3c9ba6df-750a-3847-f1fc-8e41f533d1a2@deltatee.com>
 <20210427230113.GV2047089@ziepe.ca> <20210503182811.GC17174@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e3d55333-1e24-8dad-4a94-727bce8f776c@deltatee.com>
Date:   Mon, 3 May 2021 12:31:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210503182811.GC17174@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, christian.koenig@amd.com, dan.j.williams@intel.com, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH 05/16] dma-mapping: Introduce dma_map_sg_p2pdma()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-05-03 12:28 p.m., Christoph Hellwig wrote:
> On Tue, Apr 27, 2021 at 08:01:13PM -0300, Jason Gunthorpe wrote:
>> At a high level I'm OK with it. dma_map_sg_attrs() is the extra
>> extended version of dma_map_sg(), it already has a different
>> signature, a different return code is not out of the question.
>>
>> dma_map_sg() is just the simple easy to use interface that can't do
>> advanced stuff.
>>
>>> I'm not that opposed to this. But it will make this series a fair bit
>>> longer to change the 8 map_sg_attrs() usages.
>>
>> Yes, but the result seems much nicer to not grow the DMA API further.
> 
> We already have a mapping function that can return errors:
> dma_map_sgtable.
> 
> I think it might make more sense to piggy back on that, as the sg_table
> abstraction is pretty useful basically everywhere that we deal with
> scatterlists anyway.

Oh, I didn't even realize that existed. I'll use dma_map_sgtable() for v2.

Thanks,

Logan
