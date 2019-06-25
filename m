Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1282854C9A
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 12:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfFYKot (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 06:44:49 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:19106 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726521AbfFYKot (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Jun 2019 06:44:49 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 12EA0BDC5EEDA6055D6F;
        Tue, 25 Jun 2019 18:44:45 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 25 Jun 2019
 18:44:33 +0800
Subject: Re: [GIT PULL] Hisilicon fixes for v5.2
To:     Wei Xu <xuwei5@hisilicon.com>, <arm@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>, <arnd@arndb.de>
References: <b89ef8f0-d102-7f78-f373-cbcc7faddee3@hisilicon.com>
 <afaddac3-4f9c-c09d-09d1-9c3e71beaf7b@hisilicon.com>
CC:     <linuxarm@huawei.com>, "xuwei (O)" <xuwei5@huawei.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhangyi ac <zhangyi.ac@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        <jinying@hisilicon.com>, huangdaode <huangdaode@hisilicon.com>,
        Tangkunshan <tangkunshan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <1dc5a7b1-5476-d732-74ba-d044e63706fa@huawei.com>
Date:   Tue, 25 Jun 2019 11:44:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <afaddac3-4f9c-c09d-09d1-9c3e71beaf7b@hisilicon.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 25/06/2019 11:39, Wei Xu wrote:
> Hi ARM-SoC team,
>
> Sorry, I forgot to mention that one or two patches in this patch set
> are not pure fix.
> We are also OK to queue for v5.3.
> Thanks!
>

Yes, specifically patch "lib: logic_pio: Enforce LOGIC_PIO_INDIRECT 
region ops are set at registration" is a minor tidy/optimisation.

Others are fixes or required for fixes.

And adding for v5.3 is fine, then we can ensure that the necessary is 
backported to stable when in mainline.

Thanks,
John

> Best Regards,
> Wei
>
> On 6/25/2019 11:23 AM, Wei Xu wrote:
>> Hi ARM-SoC team,
>>
>> Please consider to pull the following changes.
>> Thanks!
>>
>> Best Regards,
>> Wei
>>
>> ---
>>
>> The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:
>>
>>   Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/hisilicon/linux-hisi.git tags/hisi-fixes-for-5.2
>>
>> for you to fetch changes up to 07c811af1c00d7b4212eac86900b023b6405a954:
>>
>>   lib: logic_pio: Enforce LOGIC_PIO_INDIRECT region ops are set at registration (2019-06-25 09:40:42 +0100)
>>
>> ----------------------------------------------------------------
>> Hisilicon fixes for v5.2-rc
>>
>> - fixed RCU usage in logical PIO
>> - Added a function to unregister a logical PIO range in logical PIO
>>   to support the fixes in the hisi-lpc driver
>> - fixed and optimized hisi-lpc driver to avoid potential use-after-free
>>   and driver unbind crash
>>
>> ----------------------------------------------------------------
>> John Garry (6):
>>       lib: logic_pio: Fix RCU usage
>>       lib: logic_pio: Avoid possible overlap for unregistering regions
>>       lib: logic_pio: Add logic_pio_unregister_range()
>>       bus: hisi_lpc: Unregister logical PIO range to avoid potential use-after-free
>>       bus: hisi_lpc: Add .remove method to avoid driver unbind crash
>>       lib: logic_pio: Enforce LOGIC_PIO_INDIRECT region ops are set at registration
>>
>>  drivers/bus/hisi_lpc.c    | 43 ++++++++++++++++++++----
>>  include/linux/logic_pio.h |  1 +
>>  lib/logic_pio.c           | 86 +++++++++++++++++++++++++++++++++--------------
>>  3 files changed, 99 insertions(+), 31 deletions(-)
>>
>
>
> .
>


