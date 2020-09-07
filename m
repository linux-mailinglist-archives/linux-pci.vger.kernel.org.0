Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA29F25F60C
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 11:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgIGJKv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Sep 2020 05:10:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39052 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727953AbgIGJKu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Sep 2020 05:10:50 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4626D6079A2491DDE45B;
        Mon,  7 Sep 2020 17:10:48 +0800 (CST)
Received: from [127.0.0.1] (10.67.103.235) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Mon, 7 Sep 2020
 17:10:39 +0800
Subject: Re: [PATCH V2 0/2] lspci: Decode 10-Bit Tag Requester Enable
To:     =?UTF-8?Q?Martin_Mare=c5=a1?= <mj@ucw.cz>
References: <1598698722-126013-1-git-send-email-liudongdong3@huawei.com>
 <mj+md-20200902.084236.48915.albireo@ucw.cz>
CC:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <857051a2-9220-2f86-9f27-685597b5c2fe@huawei.com>
Date:   Mon, 7 Sep 2020 17:10:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <mj+md-20200902.084236.48915.albireo@ucw.cz>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.235]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020/9/2 16:42, Martin Mareš wrote:
> Hello!
>
>> This patchset is to:
>> 1. Adjust PCI_EXP_DEV2_* to PCI_EXP_DEVCTL2_* macro definition to keep the
>> same style between the Linux kernel source [1] and lspci.
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/pci_regs.h#n651
>>
>> 2. Decode 10-Bit Tag Requester Enable bit in Device Control 2 Register.
>
> Thanks, applied.
>
> 				Have a nice fortnight
>
Many thanks Martin.

Thanks,
Dongdong

