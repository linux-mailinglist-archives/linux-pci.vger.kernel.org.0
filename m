Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1490535E435
	for <lists+linux-pci@lfdr.de>; Tue, 13 Apr 2021 18:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242549AbhDMQkQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Apr 2021 12:40:16 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2847 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbhDMQkP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Apr 2021 12:40:15 -0400
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FKWKm5RPgz689NR;
        Wed, 14 Apr 2021 00:30:04 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 13 Apr 2021 18:39:54 +0200
Received: from [10.47.4.3] (10.47.4.3) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Tue, 13 Apr
 2021 17:39:53 +0100
Subject: Re: [PATCH v2 1/2] drivers/perf: hisi: Add driver for HiSilicon PCIe
 PMU
To:     "liuqi (BA)" <liuqi115@huawei.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhangshaokun <zhangshaokun@hisilicon.com>
References: <1617959157-22956-1-git-send-email-liuqi115@huawei.com>
 <1617959157-22956-2-git-send-email-liuqi115@huawei.com>
 <4cae4206-aa50-f111-2f6f-d035bc36856e@huawei.com>
 <9c577f11-46e7-55a0-95e8-6c3376077049@huawei.com>
 <fb795e51-ce01-e976-ac09-d3f384307623@huawei.com>
 <b45b5443-b0a4-3e7b-7ba6-be18eb413cba@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <60dffcdf-f5a5-b533-2474-ba44580191a9@huawei.com>
Date:   Tue, 13 Apr 2021 17:37:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <b45b5443-b0a4-3e7b-7ba6-be18eb413cba@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.4.3]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 13/04/2021 10:12, liuqi (BA) wrote:
>>>>
>>>> I do wonder why we even need maintain pcie_pmu->cpumask
>>>>
>>>> Can't we just use cpu_online_mask as appropiate instead?
>>
>> ?
> Sorry, missed it yesterday.
> It seems that cpumask is always same as cpu_online_mask, So do we need 
> to reserve the cpumask sysfs interface?

I'm not saying that we don't require the cpumask sysfs interface. I am 
just asking why you maintain a separate cpumask, when, as I said, they 
seem the same.

Thanks,
John
