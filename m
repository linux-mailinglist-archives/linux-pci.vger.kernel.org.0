Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272DB3D0C3F
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jul 2021 12:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237915AbhGUJV2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jul 2021 05:21:28 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3442 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236327AbhGUJEw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jul 2021 05:04:52 -0400
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GV9Kb61r5z6D8nk;
        Wed, 21 Jul 2021 17:30:11 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 21 Jul 2021 11:44:57 +0200
Received: from [10.47.85.43] (10.47.85.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 21 Jul
 2021 10:44:56 +0100
Subject: Re: [PATCH V4 1/3] driver core: mark device as irq affinity managed
 if any irq is managed
To:     Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Hannes Reinecke <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>, Marc Zyngier <maz@kernel.org>
References: <20210715120844.636968-1-ming.lei@redhat.com>
 <20210715120844.636968-2-ming.lei@redhat.com>
 <5e534fdc-909e-39b2-521d-31f643a10558@huawei.com>
 <20210719094414.GC431@lst.de> <87lf60cevz.ffs@nanos.tec.linutronix.de>
 <20210721072445.GA11257@lst.de>
From:   John Garry <john.garry@huawei.com>
Message-ID: <fe34623e-1074-862d-e822-7359ae4def0f@huawei.com>
Date:   Wed, 21 Jul 2021 10:44:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210721072445.GA11257@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.85.43]
X-ClientProxiedBy: lhreml734-chm.china.huawei.com (10.201.108.85) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+ Marc

On 21/07/2021 08:24, Christoph Hellwig wrote:
> On Wed, Jul 21, 2021 at 09:20:00AM +0200, Thomas Gleixner wrote:
>>> Just walking the list seems fine to me given that this is not a
>>> performance criticial path.  But what are the locking implications?
>> At the moment there are none because the list is initialized in the
>> setup path and never modified afterwards. Though that might change
>> sooner than later to fix the virtio wreckage vs. MSI-X.
> What is the issue there?  Either way, if we keep the helper in the
> IRQ code it should be easy to spot for anyone adding the locking.
> 
>>> Also does the above imply this won't work for your platform MSI case?
>> The msi descriptors are attached to struct device and independent of
>> platform/PCI/whatever.
> That's what I assumed, but this text from John suggested there is
> something odd about the platform case:
> 
> "Did you consider that for PCI .."
> .

For this special platform MSI case there is a secondary interrupt 
controller (called mbigen) which generates the MSI on behalf of the 
device, which I think the MSI belongs to (and not the device, itself).

See "latter case" mentioned in commit 91f90daa4fb2.

I think Marc and Thomas can explain this much better than I could.

Anyway, as I mentioned earlier, I think that this specific problem is 
unique and can be solved without using a function which examines the 
struct device.msi_list .

Thanks,
John
