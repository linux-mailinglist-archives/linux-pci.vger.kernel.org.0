Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93DB37ABAA
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 18:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhEKQR6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 12:17:58 -0400
Received: from ale.deltatee.com ([204.191.154.188]:53762 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbhEKQR6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 12:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=qGEiJKxfeZlmzsrJW3D8SgKWMOzFWWlWIF4SmeuVBPk=; b=ntkDNl1ZjZzOkVld9EYsyBSR1g
        ccd5oF9LMU67fzPYv90Fwd4Y1irj0V7v+J2klm0JE5M1ASoPOI1v0sVaTjnacpcS7HVdLPMGZV53T
        Voce44zY08R7yplObv7E+p1wa3HXD+WtmqJblO81rvwsCCqqF7TCljrzQSVWdPadK8YUd1giXo/Id
        mQxd8+ma4bxpKkqwsmr5XLNJqp1HOZcmOKxXmN0mc0yd6UeCYgkSE8YEBTkEIOjJLydxxDyOyvbvR
        mMI1FijYE0fyHBeqo+wH0Wg6i0iNhQohX2tpxc/fQ6jXzWaqfrVm5nJt/xrQzecC6pVVLM788y8OF
        KTnNa/sw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1lgV3p-0006e9-2V; Tue, 11 May 2021 10:16:42 -0600
To:     Don Dutile <ddutile@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
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
 <d6220bff-83fc-6c03-76f7-32e9e00e40fd@nvidia.com>
 <a6830332-c866-451f-3c6a-585cbf295ff8@redhat.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <65ae4aa7-b646-c270-6c51-2e9c686c5f03@deltatee.com>
Date:   Tue, 11 May 2021 10:16:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <a6830332-c866-451f-3c6a-585cbf295ff8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jhubbard@nvidia.com, ddutile@redhat.com
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
> ... add a flag (set for p2pdma use)  to the function to print out what the root->devfn is, and what
> the device is so the needed quirk &/or modification can added to handle when this assumption fails;
> or make it a prdebug that can be flipped on for this failing situation, again, to add needed change to accomodate.

Good idea! Will add.

>>     root = NULL;
>>  out:
>>     pci_dev_get(root);
>>     return root;
>> }
>> EXPORT_SYMBOL(pci_get_root_slot);
>>
>> ...I think that's a lot clearer to the reader, about what's going on here.
>>
>> Note that I'm not really sure if it *is* safe, I would need to ask other
>> PCIe subsystem developers with more experience. But I don't think anyone
>> is trying to make p2pdma calls so early that PCIe buses are uninitialized.
>>
>>
>>> +
>>> +    if (!root || root->devfn)
>>>           return false;
>>>         vendor = root->vendor;
>>>       device = root->device;
>>> -    pci_dev_put(root);
> and the reason to remove the dev_put is b/c it can sleep as well?
> is that ok, given the dev_get that John put into the new pci_get_root_slot()?
> ... seems like a locking version with no get/put's is needed, or, fix the host-bridge setups so no !NULL self pointers.

The dev_get is redundant here seeing we hold references to child
devices. It was only in the previous code because we were using
pci_get_slot() to get the device which did the get for us.

Logan
