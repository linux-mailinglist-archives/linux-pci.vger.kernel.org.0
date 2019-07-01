Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98BE55B4F5
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2019 08:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfGAGXJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jul 2019 02:23:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52066 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726036AbfGAGXJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Jul 2019 02:23:09 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 68DFBF79AA04DEFD7165;
        Mon,  1 Jul 2019 14:23:05 +0800 (CST)
Received: from [127.0.0.1] (10.57.101.250) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Mon, 1 Jul 2019
 14:22:58 +0800
Subject: Re: [GIT PULL] Hisilicon fixes for v5.2
To:     Olof Johansson <olof@lixom.net>, John Garry <john.garry@huawei.com>
References: <b89ef8f0-d102-7f78-f373-cbcc7faddee3@hisilicon.com>
 <20190625112148.ckj7sgdgvyeel7vy@localhost>
 <CAOesGMj+aNkOT1YVHTSBLkOfEujk7uer3R1AmE-sa1TwCijbBg@mail.gmail.com>
 <7e215bd7-daab-b6cf-8d0f-9513bd7c4f6d@huawei.com>
 <20190627021937.kk4lklv2uz3mogoq@localhost>
CC:     ARM-SoC Maintainers <arm@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Linuxarm <linuxarm@huawei.com>,
        "xuwei (O)" <xuwei5@huawei.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5D19A6C1.70104@hisilicon.com>
Date:   Mon, 1 Jul 2019 14:22:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20190627021937.kk4lklv2uz3mogoq@localhost>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.101.250]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Olof,

On 2019/6/27 10:19, Olof Johansson wrote:
> On Tue, Jun 25, 2019 at 02:31:26PM +0100, John Garry wrote:
>> On 25/06/2019 14:03, Olof Johansson wrote:
>>>>> are available in the Git repository at:
>>>>>>>    git://github.com/hisilicon/linux-hisi.git tags/hisi-fixes-for-5.2
>>>>>>>
>>>>>>> for you to fetch changes up to 07c811af1c00d7b4212eac86900b023b6405a954:
>>>>>>>
>>>>>>>    lib: logic_pio: Enforce LOGIC_PIO_INDIRECT region ops are set at registration (2019-06-25 09:40:42 +0100)
>>>>>>>
>>>>>>> ----------------------------------------------------------------
>>>>>>> Hisilicon fixes for v5.2-rc
>>>>>>>
>>>>>>> - fixed RCU usage in logical PIO
>>>>>>> - Added a function to unregister a logical PIO range in logical PIO
>>>>>>>    to support the fixes in the hisi-lpc driver
>>>>>>> - fixed and optimized hisi-lpc driver to avoid potential use-after-free
>>>>>>>    and driver unbind crash
>>>>> Merged to fixes, thanks.
>>> This broke arm64 allmodconfig:
>>>
>>>         arm64.allmodconfig:
>>> drivers/bus/hisi_lpc.c:656:3: error: implicit declaration of function
>>> 'hisi_lpc_acpi_remove'; did you mean 'hisi_lpc_acpi_probe'?
>>> [-Werror=implicit-function-declaration]
>>>
>>>
>> Uhhh, that's my fault - I didn't provide a stub for !ACPI. Sorry. I'll send
>> a fixed v3 series.
> No worries, it happens -- but it's good if maintainers do at least a few test
> builds before sending in pull requests so we don't catch all of it at our end.

Sorry for the late reply!
I had a trip last week and did the pull request in a hurry that forgot 
to do the some building
test like allmodconfig, allyesconfig and so on.
In the future, I will do more testing before sending out to avoid this 
kind fault.

Best Regards,
Wei

>
> -Olof
>
> .
>


