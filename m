Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09AC855066
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 15:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbfFYNbs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 09:31:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:19076 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726506AbfFYNbs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Jun 2019 09:31:48 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 267CFC528F2FA8730D57;
        Tue, 25 Jun 2019 21:31:46 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Tue, 25 Jun 2019
 21:31:38 +0800
Subject: Re: [GIT PULL] Hisilicon fixes for v5.2
To:     Olof Johansson <olof@lixom.net>, Wei Xu <xuwei5@hisilicon.com>
References: <b89ef8f0-d102-7f78-f373-cbcc7faddee3@hisilicon.com>
 <20190625112148.ckj7sgdgvyeel7vy@localhost>
 <CAOesGMj+aNkOT1YVHTSBLkOfEujk7uer3R1AmE-sa1TwCijbBg@mail.gmail.com>
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
Message-ID: <7e215bd7-daab-b6cf-8d0f-9513bd7c4f6d@huawei.com>
Date:   Tue, 25 Jun 2019 14:31:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CAOesGMj+aNkOT1YVHTSBLkOfEujk7uer3R1AmE-sa1TwCijbBg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 25/06/2019 14:03, Olof Johansson wrote:
>>> are available in the Git repository at:
>>> > >
>>> > >   git://github.com/hisilicon/linux-hisi.git tags/hisi-fixes-for-5.2
>>> > >
>>> > > for you to fetch changes up to 07c811af1c00d7b4212eac86900b023b6405a954:
>>> > >
>>> > >   lib: logic_pio: Enforce LOGIC_PIO_INDIRECT region ops are set at registration (2019-06-25 09:40:42 +0100)
>>> > >
>>> > > ----------------------------------------------------------------
>>> > > Hisilicon fixes for v5.2-rc
>>> > >
>>> > > - fixed RCU usage in logical PIO
>>> > > - Added a function to unregister a logical PIO range in logical PIO
>>> > >   to support the fixes in the hisi-lpc driver
>>> > > - fixed and optimized hisi-lpc driver to avoid potential use-after-free
>>> > >   and driver unbind crash
>> >
>> > Merged to fixes, thanks.
>
> This broke arm64 allmodconfig:
>
>        arm64.allmodconfig:
> drivers/bus/hisi_lpc.c:656:3: error: implicit declaration of function
> 'hisi_lpc_acpi_remove'; did you mean 'hisi_lpc_acpi_probe'?
> [-Werror=implicit-function-declaration]
>
>

Uhhh, that's my fault - I didn't provide a stub for !ACPI. Sorry. I'll 
send a fixed v3 series.

>
> Please build and test your branches before you send pull requests, Wei.
>
> I've dropped the branch again; please re-submit when fixed. I think
> it's probably 5.3 material now.
>

Thanks,
John

>
> -Olof
>
> .
>


