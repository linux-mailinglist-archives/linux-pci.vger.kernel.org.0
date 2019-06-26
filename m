Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB0F356D8C
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2019 17:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfFZPWR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jun 2019 11:22:17 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:19115 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725958AbfFZPWR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Jun 2019 11:22:17 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CED06C1ABC82D47A8304;
        Wed, 26 Jun 2019 23:22:13 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Wed, 26 Jun 2019
 23:22:06 +0800
Subject: Re: [GIT PULL] Hisilicon fixes for v5.2
To:     Olof Johansson <olof@lixom.net>, Wei Xu <xuwei5@hisilicon.com>
References: <b89ef8f0-d102-7f78-f373-cbcc7faddee3@hisilicon.com>
 <20190625112148.ckj7sgdgvyeel7vy@localhost>
 <CAOesGMj+aNkOT1YVHTSBLkOfEujk7uer3R1AmE-sa1TwCijbBg@mail.gmail.com>
 <7e215bd7-daab-b6cf-8d0f-9513bd7c4f6d@huawei.com>
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
From:   John Garry <john.garry@huawei.com>
Message-ID: <2e59728e-25fa-cc15-3c63-3566dc2ae69f@huawei.com>
Date:   Wed, 26 Jun 2019 16:21:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <7e215bd7-daab-b6cf-8d0f-9513bd7c4f6d@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 25/06/2019 14:31, John Garry wrote:
> On 25/06/2019 14:03, Olof Johansson wrote:
>>>> are available in the Git repository at:
>>>> > >
>>>> > >   git://github.com/hisilicon/linux-hisi.git tags/hisi-fixes-for-5.2
>>>> > >
>>>> > > for you to fetch changes up to
>>>> 07c811af1c00d7b4212eac86900b023b6405a954:
>>>> > >
>>>> > >   lib: logic_pio: Enforce LOGIC_PIO_INDIRECT region ops are set
>>>> at registration (2019-06-25 09:40:42 +0100)
>>>> > >
>>>> > > ----------------------------------------------------------------
>>>> > > Hisilicon fixes for v5.2-rc
>>>> > >
>>>> > > - fixed RCU usage in logical PIO
>>>> > > - Added a function to unregister a logical PIO range in logical PIO
>>>> > >   to support the fixes in the hisi-lpc driver
>>>> > > - fixed and optimized hisi-lpc driver to avoid potential
>>>> use-after-free
>>>> > >   and driver unbind crash
>>> >
>>> > Merged to fixes, thanks.
>>
>> This broke arm64 allmodconfig:
>>
>>        arm64.allmodconfig:
>> drivers/bus/hisi_lpc.c:656:3: error: implicit declaration of function
>> 'hisi_lpc_acpi_remove'; did you mean 'hisi_lpc_acpi_probe'?
>> [-Werror=implicit-function-declaration]

As an aside, I find it a little strange that arm64 allmodconfig does not 
have CONFIG_ACPI set. It used to have it set, and this patch stopped that:

5bcd44083a082f314032969cd6db1eb8275ac77a is the first bad commit
commit 5bcd44083a082f314032969cd6db1eb8275ac77a
Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
Date:   Mon Jul 23 10:57:29 2018 +0900

     drivers: acpi: add dependency of EFI for arm64

     As Ard suggested, CONFIG_ACPI && !CONFIG_EFI doesn't make sense on 
arm64,
     while CONFIG_ACPI and CONFIG_CPU_BIG_ENDIAN doesn't make sense either.

     As CONFIG_EFI already has a dependency of !CONFIG_CPU_BIG_ENDIAN, it is
     good enough to add a dependency of CONFIG_EFI to avoid any useless
     combination of configuration.

     This bug, reported by Will, will be revealed when my patch series,
     "arm64: kexec,kdump: fix boot failures on acpi-only system," is applied
     and the kernel is built under allmodconfig.

     Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
     Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
     Signed-off-by: Will Deacon <will.deacon@arm.com>

That patch stopped many configs being set for allmodconfig.

With this change, CONFIG_EFI is not set. I think that this is because 
CONFIG_CPU_BIG_ENDIAN is set for arm64 allmodconfig.

Any opinion on this? Could we change CONFIG_CPU_BIG_ENDIAN to be unset 
for arm64?

>>
>>
>
> Uhhh, that's my fault - I didn't provide a stub for !ACPI. Sorry. I'll
> send a fixed v3 series.
>
>>
>> Please build and test your branches before you send pull requests, Wei.
>>
>> I've dropped the branch again; please re-submit when fixed. I think
>> it's probably 5.3 material now.
>>
>
> Thanks,
> John
>
>>
>> -Olof
>>
>> .
>>
>


