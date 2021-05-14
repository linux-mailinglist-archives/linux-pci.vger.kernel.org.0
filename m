Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF75B380DEC
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 18:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbhENQRP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 12:17:15 -0400
Received: from ale.deltatee.com ([204.191.154.188]:60748 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbhENQRO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 May 2021 12:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=E4eKfLLPwxlNLjuttUuI8VaOne71TO7fgDfREp6VqWo=; b=sPRxOlEMD/ZVQ88LgoGLL9OjBW
        Wx0+B2uNVHava/VVSM9gB4FJtOz6aiI72TospMuM4DTR6YiCUjKsyUOFus7PH/19HYF72JItnGrXW
        vLLue47wtV1XdyCo9lXQkyk8vp82wx6TPOdDnUwXhjOophg0NxfdhWMpLuolM5ISe/FynxCSvGtSn
        JJsuJooWId8Qr8z3RExNK6gc34i19s93IGYSCWBOAxS9DTtnHVWXzpIfK9FdD6uCsHV5a5kGmOum/
        rXiAGakNoK/7PHlxa2iM/+f2Q+Ns8rzVCrKhqZN6zgA9a10xmb4hzYQ25BXQ/JHXfvK25hlMlmWo3
        CP907NSA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1lhaTZ-00066P-MN; Fri, 14 May 2021 10:15:46 -0600
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
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
        Robin Murphy <robin.murphy@arm.com>
References: <20210513223203.5542-1-logang@deltatee.com>
 <20210513223203.5542-9-logang@deltatee.com> <20210514135126.GB4715@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <241e7dad-8d38-9f0c-5e54-8b7df32b8bac@deltatee.com>
Date:   Fri, 14 May 2021 10:15:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210514135126.GB4715@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH v2 08/22] dma-mapping: Allow map_sg() ops to return
 negative error codes
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-05-14 7:51 a.m., Christoph Hellwig wrote:
>> +int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
>>  		enum dma_data_direction dir, unsigned long attrs);
> 
> I don't think it makes sense to expose this __dma_map_sg_attrs helper.
> Just keep it static and move the sgtable helper to kernel/dma/mapping.c
> as well.

Makes sense. I'll fix this for v3.

Logan
