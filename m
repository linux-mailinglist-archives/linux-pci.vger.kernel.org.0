Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F3E371FDD
	for <lists+linux-pci@lfdr.de>; Mon,  3 May 2021 20:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhECSrR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 May 2021 14:47:17 -0400
Received: from ale.deltatee.com ([204.191.154.188]:32800 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhECSrR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 May 2021 14:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=FQlZSc22rDFnyD/b3PGREqWaL5WzGsfMM4i2vFu2da4=; b=IjY1prSgciJlO7qETHoHcDfvVo
        474Xui/7jwzyvAcWaBDmxoOFd8uUVi4aWV7PQwD6cV/vy5cZzNo0VGRA9oBXLxQpeKYJmpYH4jFyb
        4wFa1eShvwuPp+3pmYC4qq4DvJ9Z2+ZznJ5szAfZyCxaIRohe3bxb+xs950S+H/+mvsScLGbX8B45
        NzXRP57YewUyLmWEB0dkwAeAOpDzXaLnaMXhIujZcHeNydo4HTpR+9b6Qg4uIif2wRfBJ8qvAgoiG
        zwo0WfN8QxtRRhA24zXz3sRBsHqPStF4rnlp5K7yiV9Rf9KQdWrbwuBKRWO+YajAWnmHIvq365iJz
        t2H/5Otg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1ldda9-000141-N8; Mon, 03 May 2021 12:46:14 -0600
To:     Christoph Hellwig <hch@lst.de>
Cc:     John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
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
 <20210408170123.8788-4-logang@deltatee.com>
 <3834be62-3d1b-fc98-d793-e7dcb0a74624@nvidia.com>
 <a1b6ffa9-7a9c-753f-6350-5ea26506cdc3@deltatee.com>
 <20210503183509.GA17971@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d563acfa-f7d5-2f11-4c1b-b5e2f341a2cb@deltatee.com>
Date:   Mon, 3 May 2021 12:46:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210503183509.GA17971@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH 03/16] PCI/P2PDMA: Attempt to set map_type if it has not
 been set
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-05-03 12:35 p.m., Christoph Hellwig wrote:
> On Mon, May 03, 2021 at 10:17:59AM -0600, Logan Gunthorpe wrote:
>> I agree that some of this has evolved in a way that some of the names
>> are a bit odd now. Could definitely use a cleanup, but that's not really
>> part of this series. When I have some time I can look at doing a cleanup
>> series to help with some of this.
> 
> I think adding it to the series would be very helpful.

Ok, I'll prepend a handful of cleanup patches.

Logan
