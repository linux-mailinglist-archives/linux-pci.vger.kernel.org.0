Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E64994CE13
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 14:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbfFTM4q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 08:56:46 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56798 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726569AbfFTM4q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jun 2019 08:56:46 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 95CEE2A38E8229310350;
        Thu, 20 Jun 2019 20:56:42 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Thu, 20 Jun 2019
 20:56:34 +0800
Subject: Re: [PATCH 0/5] Fixes for HiSilicon LPC driver and logical PIO code
To:     Olof Johansson <olof@lixom.net>
References: <1561026716-140537-1-git-send-email-john.garry@huawei.com>
 <CAOesGMg+jAae5A0LgvBH0=dF95Y208h0c5RZ6f0v6CVUhsMk4g@mail.gmail.com>
CC:     <xuwei5@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Linuxarm <linuxarm@huawei.com>,
        ARM-SoC Maintainers <arm@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, "Joe Perches" <joe@perches.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <8265cdc4-ce24-4efd-a64a-78ce34104b9c@huawei.com>
Date:   Thu, 20 Jun 2019 13:56:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CAOesGMg+jAae5A0LgvBH0=dF95Y208h0c5RZ6f0v6CVUhsMk4g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20/06/2019 13:42, Olof Johansson wrote:
> Hi John,
>
> For patches that go to a soc maintainer for merge, we're asking that
> people don't cc arm@kernel.org directly.
>
> We prefer to keep that alias mostly for pull requests from other
> maintainers and patches we might have a reason to apply directly.
> Otherwise we risk essentially getting all of linux-arm-kernel into
> this mailbox as well.
>
>
> Thanks!
>
> -Olof
>

Hi Olof,

Can do in future.

The specific reason here for me to cc arm@kernel.org was that I wanted 
to at least make the maintainers aware that we intend to send some 
patches outside the "arm soc" domain through their tree, * below.

Thanks,
John


> On Thu, Jun 20, 2019 at 11:33 AM John Garry <john.garry@huawei.com> wrote:
>>
>> As reported in [1], the hisi-lpc driver has certain issues in handling
>> logical PIO regions, specifically unregistering regions.
>>
>> This series add a method to unregister a logical PIO region, and fixes up
>> the driver to use them.
>>
>> RCU usage in logical PIO code looks to always have been broken, so that
>> is fixed also. This is not a major fix as the list which RCU protects is
>> very rarely modified.
>>
>> There is another patch to simplify logical PIO registration, made possible
>> by the fixes.
>>
>> At this point, there are still separate ongoing discussions about how to
>> stop the logical PIO and PCI host bridge code leaking ranges, as in [2].
>>

*

>> Hopefully this series can go through the arm soc tree and the maintainers
>> have no issue with that. I'm talking specifically about the logical PIO
>> code, which went through PCI tree on only previous upstreaming.
>>
>> Cc. linux-pci@vger.kernel.org
>>
>> [1] https://lore.kernel.org/lkml/1560770148-57960-1-git-send-email-john.garry@huawei.com/
>> [2] https://lore.kernel.org/lkml/4b24fd36-e716-7c5e-31cc-13da727802e7@huawei.com/
>>
>> John Garry (5):
>>   lib: logic_pio: Fix RCU usage
>>   lib: logic_pio: Add logic_pio_unregister_range()
>>   bus: hisi_lpc: Unregister logical PIO range to avoid potential
>>     use-after-free
>>   bus: hisi_lpc: Add .remove method to avoid driver unbind crash
>>   lib: logic_pio: Enforce LOGIC_PIO_INDIRECT region ops are set at
>>     registration
>>
>>  drivers/bus/hisi_lpc.c    | 43 ++++++++++++++++++---
>>  include/linux/logic_pio.h |  1 +
>>  lib/logic_pio.c           | 78 ++++++++++++++++++++++++++++-----------
>>  3 files changed, 95 insertions(+), 27 deletions(-)
>>
>> --
>> 2.17.1
>>
>
> .
>


