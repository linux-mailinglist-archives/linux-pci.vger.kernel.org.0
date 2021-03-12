Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA83339926
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 22:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbhCLViM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 16:38:12 -0500
Received: from ale.deltatee.com ([204.191.154.188]:40032 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbhCLVhi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Mar 2021 16:37:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=T7mzuRgHR5zyL13fGxYATb0PibzAkq1gophY5Qi93V0=; b=NljsSHJkFlQ2oulW4psgZdRBZa
        qgoQiY/5e6LFm23c9qIwGHKx59Rdscll0uQCdBksaP8keL4Gv+qXd6SpMzWE3c2KTPN+Yt7TkjfMD
        VKufm9iYy9S1kM3gq5EoA8X0Iwwk+BXaeKR2DtsJwSiGP5M99l11j01GzfuA1WhYodeMJwR9eULLx
        qMCAqJ61hDuiWk9NoL/OXxGIsON+G05ZxyItH2tyiPiUwdHuiVQZbuD3Gw6w7iSs3CxWor/qKRJ+N
        iHGSbxHK1EBS+HEejQDjnyuIn1A2bZ90d2L7GIQDkwb8bf9pWbOv+q1TJdhTOcLW3uuY5x0278s54
        XVUZIIjg==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1lKpT0-0003Fl-Vh; Fri, 12 Mar 2021 14:37:07 -0700
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Ira Weiny <iweiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>
References: <20210312205707.GA2288658@bjorn-Precision-5520>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c252253e-5000-5d96-1ac8-90835c1a4eb0@deltatee.com>
Date:   Fri, 12 Mar 2021 14:37:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210312205707.GA2288658@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, iweiny@intel.com, christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [RFC PATCH v2 02/11] PCI/P2PDMA: Avoid pci_get_slot() which
 sleeps
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-03-12 1:57 p.m., Bjorn Helgaas wrote:
> On Thu, Mar 11, 2021 at 04:31:32PM -0700, Logan Gunthorpe wrote:
>> In order to use upstream_bridge_distance_warn() from a dma_map function,
>> it must not sleep. However, pci_get_slot() takes the pci_bus_sem so it
>> might sleep.
>>
>> In order to avoid this, try to get the host bridge's device from
>> bus->self, and if that is not set just get the first element in the
>> list. It should be impossible for the host bridges device to go away
>> while references are held on child devices, so the first element
>> should not change and this should be safe.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>  drivers/pci/p2pdma.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>> index bd89437faf06..2135fe69bb07 100644
>> --- a/drivers/pci/p2pdma.c
>> +++ b/drivers/pci/p2pdma.c
>> @@ -311,11 +311,15 @@ static const struct pci_p2pdma_whitelist_entry {
>>  static bool __host_bridge_whitelist(struct pci_host_bridge *host,
>>  				    bool same_host_bridge)
>>  {
>> -	struct pci_dev *root = pci_get_slot(host->bus, PCI_DEVFN(0, 0));
>>  	const struct pci_p2pdma_whitelist_entry *entry;
>> +	struct pci_dev *root = host->bus->self;
>>  	unsigned short vendor, device;
>>  
>>  	if (!root)
>> +		root = list_first_entry_or_null(&host->bus->devices,
>> +						struct pci_dev, bus_list);
> 
> Replacing one ugliness (assuming there is a pci_dev for the host
> bridge, and that it is at 00.0) with another (still assuming a pci_dev
> and that it is host->bus->self or the first entry).  I can't suggest
> anything better, but maybe a little comment in the code would help
> future readers.

Yeah, I struggled to find a solution here; this was the best I could
come up with. I'd love it if someone had a better idea. I can add a
comment for future iterations.

> I wish we had a real way to discover this property without the
> whitelist, at least for future devices.  Was there ever any interest
> in a _DSM or similar interface for this?

I'd also like to get rid of the whitelist, but I have no idea how or who
would have to lead a fight to get the hardware to self describe in way
that we could use.

> I *am* very glad to remove a pci_get_slot() usage.
> 
>> +
>> +	if (!root || root->devfn)
>>  		return false;
>>  
>>  	vendor = root->vendor;
> 
> Don't you need to also remove the "pci_dev_put(root)" a few lines
> below?

Yes, right. Good catch!

Logan

