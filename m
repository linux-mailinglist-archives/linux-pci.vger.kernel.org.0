Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979D73CD25C
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jul 2021 12:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236323AbhGSJ7N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jul 2021 05:59:13 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3431 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236316AbhGSJ7M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jul 2021 05:59:12 -0400
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GSydy5Btxz6D8wM;
        Mon, 19 Jul 2021 18:25:10 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 19 Jul 2021 12:39:50 +0200
Received: from [10.47.85.214] (10.47.85.214) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 19 Jul
 2021 11:39:50 +0100
Subject: Re: [PATCH V4 1/3] driver core: mark device as irq affinity managed
 if any irq is managed
To:     Christoph Hellwig <hch@lst.de>
CC:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
References: <20210715120844.636968-1-ming.lei@redhat.com>
 <20210715120844.636968-2-ming.lei@redhat.com>
 <5e534fdc-909e-39b2-521d-31f643a10558@huawei.com>
 <20210719094414.GC431@lst.de>
From:   John Garry <john.garry@huawei.com>
Message-ID: <5153406c-e3ed-d466-5603-14fd919304f4@huawei.com>
Date:   Mon, 19 Jul 2021 11:39:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210719094414.GC431@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.85.214]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 19/07/2021 10:44, Christoph Hellwig wrote:
> On Mon, Jul 19, 2021 at 08:51:22AM +0100, John Garry wrote:
>>> Address this issue by adding one field of .irq_affinity_managed into
>>> 'struct device'.
>>>
>>> Suggested-by: Christoph Hellwig <hch@lst.de>
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>
>> Did you consider that for PCI device we effectively have this info already:
>>
>> bool dev_has_managed_msi_irq(struct device *dev)
>> {
>> 	struct msi_desc *desc;
>>
>> 	list_for_each_entry(desc, dev_to_msi_list(dev), list)

I just noticed for_each_msi_entry(), which is the same


>> 		if (desc->affinity && desc->affinity->is_managed)
>> 			return true;
>> 	}
>>
>> 	return false;
> 
> Just walking the list seems fine to me given that this is not a
> performance criticial path.  But what are the locking implications?

Since it would be used for sequential setup code, I didn't think any 
locking was required. But would need to consider where that function 
lived and whether it's public.

> 
> Also does the above imply this won't work for your platform MSI case?
> .
> 

Right. I think that it may be possible to reach into the platform msi 
descriptors to get this info, but I am not sure it's worth it. There is 
only 1x user there and there is no generic .map_queues function, so 
could set the flag directly:

int blk_mq_pci_map_queues(struct blk_mq_queue_map *qmap, struct pci_dev 
*pdev,
  		for_each_cpu(cpu, mask)
  			qmap->mq_map[cpu] = qmap->queue_offset + queue;
  	}
+	qmap->use_managed_irq = dev_has_managed_msi_irq(&pdev->dev);
}

--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -3563,6 +3563,8 @@ static int map_queues_v2_hw(struct Scsi_Host *shost)
                        qmap->mq_map[cpu] = qmap->queue_offset + queue;
        }

+       qmap->use_managed_irq = 1;
+
        return 0;
}
