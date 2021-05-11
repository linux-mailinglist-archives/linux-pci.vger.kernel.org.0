Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6E037AB9B
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 18:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhEKQPz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 12:15:55 -0400
Received: from ale.deltatee.com ([204.191.154.188]:53686 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbhEKQPy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 12:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=Ymx5jystW5s8EPZBRHR4WsTKIk8IQ3Uz4HGrVu+VdWc=; b=hX92MI8IYDAFgrof9DVT2uOU0b
        8bPhv4kGORr76XEMFxwmACnHHa/fI3xZANPeMf8DFf2u+nfJFyyzXvvhEEx4cM9EGABLTEfGioqXt
        Z/Sl8b/TrsPmc0Zdggnd6a4Aa071uVgQv70MVapxhACireL1cQkKucMJmIpHrHj7H3XZLFjeZjpTX
        4FMfsVi3BiCcbaJ4tXOPM9w9r0P9oEz6cRAFuAhfOfKgHBHvXTSHQo7+X36DbFPQPvu2FECcfS/d7
        5R+EqotBeW4C+luSP2De1znJnMp1NuFlq/yf+AFYQPXXq6/dorM+PRU3IbwblLDzIzkKcuqhJpKSR
        pA8OJzOw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1lgV1p-0006b5-VM; Tue, 11 May 2021 10:14:38 -0600
To:     Don Dutile <ddutile@redhat.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
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
 <20210408170123.8788-3-logang@deltatee.com>
 <09f6c713-5ae6-035c-c0ab-a8bd0fac7a79@redhat.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <70f58fff-c228-e637-aef8-f404af2d2f9d@deltatee.com>
Date:   Tue, 11 May 2021 10:14:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <09f6c713-5ae6-035c-c0ab-a8bd0fac7a79@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, jhubbard@nvidia.com, christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, ddutile@redhat.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH 02/16] PCI/P2PDMA: Avoid pci_get_slot() which sleeps
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-05-11 10:05 a.m., Don Dutile wrote:
> On 4/8/21 1:01 PM, Logan Gunthorpe wrote:
>> In order to use upstream_bridge_distance_warn() from a dma_map function,
>> it must not sleep. However, pci_get_slot() takes the pci_bus_sem so it
>> might sleep.
>>
>> In order to avoid this, try to get the host bridge's device from
>> bus->self, and if that is not set, just get the first element in the
>> device list. It should be impossible for the host bridge's device to
>> go away while references are held on child devices, so the first element
>> should not be able to change and, thus, this should be safe.
> Bjorn:
> Why wouldn't (shouldn't?) the bus->self field be set for a host bridge device?
> Should this situation be repaired in the host-brige config/setup code elsewhere in the kernel.
> ... and here, a check-and-fail with info of what doesn't have it setup (another new pci function to do the check & prinfo), so it can point to the offending host-bridge, and thus, the code that needs to be updated?

I've dropped the bus->self thing in v2. Seems bus->self is explicitly
unset for root bridges. There's remnants in the pci code that used to
check bus->self to see if the bridge is the root bridge.

I tried setting bus->self with the pci device of the root bridge but
that just caused my machine not to boot and I didn't dig any further.

Logan
