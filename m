Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9CD2A9B0B
	for <lists+linux-pci@lfdr.de>; Fri,  6 Nov 2020 18:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbgKFRn3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Nov 2020 12:43:29 -0500
Received: from ale.deltatee.com ([204.191.154.188]:58840 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgKFRn3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Nov 2020 12:43:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+aVF8hXlDJ8MzPtxX+XTVoXEhgBr/LXYLuXvlOqZpGU=; b=BMhMQO2caJsqnlb1LxCr7nBMdq
        1Z2QCchiWLzUurwt3unaRF8yXphVx9GmAgyCNN72Z8goljgcSPoUwJVAZ1mDzXLyUGcszQIG0YL6V
        Xh3RTrZLilCq+i/q7PRDd0P4JcITPVliaZMPbMnmuO/M8ewMGtTo8uMTblJXHulgQKx9mbUFNcvt2
        5WwjAZfAP0p7IcvHkxV86Nh7/8FKbB35igvhByuo72QPVLb6cKG8TSef4tW5v/Br/8Hnj1dWC+CUd
        xWx2R4ulYSIMFvjaEWxIIrphSNBNS/KyMiSZvesXCRZGPs/wP5ZtVbHSsHSTvIGKOYH2FRcoJ0bNW
        pfRf3Ijw==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1kb5lh-0003H9-4R; Fri, 06 Nov 2020 10:43:22 -0700
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Ira Weiny <iweiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
References: <20201106170036.18713-1-logang@deltatee.com>
 <20201106170036.18713-16-logang@deltatee.com>
 <20201106173932.GT36674@ziepe.ca>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <da53aaa5-94fd-c150-c5a4-8fec042eb196@deltatee.com>
Date:   Fri, 6 Nov 2020 10:43:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201106173932.GT36674@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, iweiny@intel.com, christian.koenig@amd.com, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [RFC PATCH 15/15] nvme-pci: Allow mmaping the CMB in userspace
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org




On 2020-11-06 10:39 a.m., Jason Gunthorpe wrote:
> On Fri, Nov 06, 2020 at 10:00:36AM -0700, Logan Gunthorpe wrote:
>> Allow userspace to obtain CMB memory by mmaping the controller's
>> char device. The mmap call allocates and returns a hunk of CMB memory,
>> (the offset is ignored) so userspace does not have control over the
>> address within the CMB.
>>
>> A VMA allocated in this way will only be usable by drivers that set
>> FOLL_PCI_P2PDMA when calling GUP. And inter-device support will be
>> checked the first time the pages are mapped for DMA.
>>
>> Currently this is only supported by O_DIRECT to an PCI NVMe device
>> or through the NVMe passthrough IOCTL.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>>  drivers/nvme/host/core.c | 11 +++++++++++
>>  drivers/nvme/host/nvme.h |  1 +
>>  drivers/nvme/host/pci.c  |  9 +++++++++
>>  3 files changed, 21 insertions(+)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index f14316c9b34a..fc642aba671d 100644
>> +++ b/drivers/nvme/host/core.c
>> @@ -3240,12 +3240,23 @@ static long nvme_dev_ioctl(struct file *file, unsigned int cmd,
>>  	}
>>  }
>>  
>> +static int nvme_dev_mmap(struct file *file, struct vm_area_struct *vma)
>> +{
>> +	struct nvme_ctrl *ctrl = file->private_data;
>> +
>> +	if (!ctrl->ops->mmap_cmb)
>> +		return -ENODEV;
>> +
>> +	return ctrl->ops->mmap_cmb(ctrl, vma);
>> +}
> 
> This needs to ensure that the VMA created is destroyed before the
> driver is unprobed - ie the struct pages backing the BAR memory is
> destroyed.
> 
> I don't see anything that synchronizes this in the nvme_dev_release()?

Yup, looks like something that needs to be fixed. Though I'd probably do
it in the pci_p2pdma helper code instead.

Logan
