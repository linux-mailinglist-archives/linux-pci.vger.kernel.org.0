Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD8D41DF9F
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 18:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352450AbhI3QxV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 12:53:21 -0400
Received: from ale.deltatee.com ([204.191.154.188]:44024 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352384AbhI3QxT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Sep 2021 12:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=DY98l6f/p37o1n6z2SAmaZFkiMoprnW0+Juc+mDOhCo=; b=pTfd2cTcyBzH2LpKD5iE+L5qG5
        1YxVv6haFuR4tVxbCWzg77WlnQgwPvUMZwmaeKZ/dooUcIP5nxEHrl6iUZij4mssaKTc1px7tpQdx
        UMyTxmWTfEjMtRe2GIkYjVgqlDS1F3IkTZYJ19rOxetGBvpeebtdTkcvo2LLMm8BaIdwZQW6M+yDA
        xwkZTQaVYuM6i+YEvgQv3b/vT6jMo3j0z9ni8dqNTUIbj+9inuXDYYSM/W4MlssDZdeD33aXoOrpZ
        tIrW+L7X4llhAn1S/KznAKSdwTbT4O7Y3kK3KgNwTuziND3TP1yUKnxXkkTO5ob60fRu9UHxzZrhf
        5AMobH0g==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1mVzHI-0004dm-2w; Thu, 30 Sep 2021 10:51:25 -0600
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
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
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-10-logang@deltatee.com>
 <c04215bd-442a-6520-4fc7-5035c1310662@nvidia.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <acaa91df-f932-7449-3623-4209c41634d9@deltatee.com>
Date:   Thu, 30 Sep 2021 10:51:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <c04215bd-442a-6520-4fc7-5035c1310662@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: ckulkarnilinux@gmail.com, martin.oliveira@eideticom.com, robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, chaitanyak@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH v3 09/20] nvme-pci: check DMA ops when indicating support
 for PCI P2PDMA
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-09-29 11:06 p.m., Chaitanya Kulkarni wrote:
> Logan,
> 
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 7efb31b87f37..916750a54f60 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -3771,7 +3771,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
>>                  blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, ns->queue);
>>
>>          blk_queue_flag_set(QUEUE_FLAG_NONROT, ns->queue);
>> -       if (ctrl->ops->flags & NVME_F_PCI_P2PDMA)
>> +       if (ctrl->ops->supports_pci_p2pdma &&
>> +           ctrl->ops->supports_pci_p2pdma(ctrl))
>>                  blk_queue_flag_set(QUEUE_FLAG_PCI_P2PDMA, ns->queue);
>>
>>          ns->ctrl = ctrl;
>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>> index 9871c0c9374c..fb9bfc52a6d7 100644
>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -477,7 +477,6 @@ struct nvme_ctrl_ops {
>>          unsigned int flags;
>>   #define NVME_F_FABRICS                 (1 << 0)
>>   #define NVME_F_METADATA_SUPPORTED      (1 << 1)
>> -#define NVME_F_PCI_P2PDMA              (1 << 2)
>>          int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val);
>>          int (*reg_write32)(struct nvme_ctrl *ctrl, u32 off, u32 val);
>>          int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val);
>> @@ -485,6 +484,7 @@ struct nvme_ctrl_ops {
>>          void (*submit_async_event)(struct nvme_ctrl *ctrl);
>>          void (*delete_ctrl)(struct nvme_ctrl *ctrl);
>>          int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
>> +       bool (*supports_pci_p2pdma)(struct nvme_ctrl *ctrl);
>>   };
>>
> 
> Is this new ops only needed for the PCIe transport ? or do you have 
> following patches to use this op for the other transports ?

No, I don't think this will make sense for transports that are not based
on PCI devices.

> If it is only needed for the PCIe then we need to find a way to
> not add this somehow...

I don't see how we can do that. The core code needs to know whether the
transport supports this and must have an operation to query it.

Logan

