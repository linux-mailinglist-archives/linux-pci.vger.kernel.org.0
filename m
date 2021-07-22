Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E99743D1F41
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 09:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhGVHIK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 03:08:10 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3445 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhGVHIK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Jul 2021 03:08:10 -0400
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GVkhy5rnBz6D94x;
        Thu, 22 Jul 2021 15:33:54 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 22 Jul 2021 09:48:43 +0200
Received: from [10.47.26.161] (10.47.26.161) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Thu, 22 Jul
 2021 08:48:42 +0100
Subject: Re: [PATCH V4 1/3] driver core: mark device as irq affinity managed
 if any irq is managed
To:     Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
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
 <fe34623e-1074-862d-e822-7359ae4def0f@huawei.com>
 <87y29zpgct.ffs@nanos.tec.linutronix.de>
From:   John Garry <john.garry@huawei.com>
Message-ID: <27cf7c97-6b03-d1fd-7bfc-6aaf3cd50272@huawei.com>
Date:   Thu, 22 Jul 2021 08:48:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <87y29zpgct.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.26.161]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/07/2021 21:22, Thomas Gleixner wrote:
>>> That's what I assumed, but this text from John suggested there is
>>> something odd about the platform case:
>>>
>>> "Did you consider that for PCI .."
>>> .
>> For this special platform MSI case there is a secondary interrupt
>> controller (called mbigen) which generates the MSI on behalf of the
>> device, which I think the MSI belongs to (and not the device, itself).
> MBIGEN is a different story because it converts wired interrupts into
> MSI interrupts, IOW a MSI based interrupt pin extender.
> 
> I might be wrong, but I seriously doubt that any multiqueue device which
> wants to use affinity managed interrupts is built on top of that.

Actually the SCSI device for which platform device managed interrupts 
support was added in commit e15f2fa959f2 uses mbigen.

Thanks,
John
