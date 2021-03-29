Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5718234D16E
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 15:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhC2NiA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 09:38:00 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:15384 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbhC2Nhy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Mar 2021 09:37:54 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F8D9t0FKLzlW3Q;
        Mon, 29 Mar 2021 21:36:02 +0800 (CST)
Received: from [127.0.0.1] (10.40.192.162) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Mon, 29 Mar 2021
 21:37:39 +0800
Subject: Re: [Linuxarm] Re: [PATCH v3 00/12] acpi: fix some coding style
 issues
To:     "Rafael J. Wysocki" <rafael@kernel.org>
References: <1616846904-25719-1-git-send-email-tanxiaofei@huawei.com>
 <CAJZ5v0i=RPyvWfVuGQ0nWf_0QRw70=qZd6j85CTPWaaWPa_5KQ@mail.gmail.com>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>, <linuxarm@openeuler.org>
From:   Xiaofei Tan <tanxiaofei@huawei.com>
Message-ID: <6c4f84ca-1a31-d2a7-5566-0e5fea408181@huawei.com>
Date:   Mon, 29 Mar 2021 21:37:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0i=RPyvWfVuGQ0nWf_0QRw70=qZd6j85CTPWaaWPa_5KQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.192.162]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rafael,

On 2021/3/29 20:50, Rafael J. Wysocki wrote:
> On Sat, Mar 27, 2021 at 1:11 PM Xiaofei Tan <tanxiaofei@huawei.com> wrote:
>>
>> Fix some coding style issues reported by checkpatch.pl.
>> Only cleanup and no function changes.
>>
>> Differences from v2 to v3:
>> - Remove the modifications that may cause function change.
>>
>> Differences from v1 to v2:
>> - Add subsystem and module name in the name of patch 05/15.
>> - Change to use more proper module name for some patch names.
>>
>> Xiaofei Tan (12):
>>   ACPI: APD: fix a block comment align issue
>>   ACPI: processor: fix some coding style issues
>>   ACPI: ipmi: remove useless return statement for void function
>>   ACPI: LPSS: add a missed blank line after declarations
>>   ACPI: acpi_pad: add a missed blank line after declarations
>>   ACPI: battery: fix some coding style issues
>>   ACPI: button: fix some coding style issues
>>   ACPI: CPPC: fix some coding style issues
>>   ACPI: custom_method: fix a coding style issue
>>   ACPI: PM: add a missed blank line after declarations
>>   ACPI: sysfs: fix some coding style issues
>>   ACPI: dock: fix some coding style issues
>>
>>  drivers/acpi/acpi_apd.c       |  8 ++---
>>  drivers/acpi/acpi_ipmi.c      |  1 -
>>  drivers/acpi/acpi_lpss.c      |  2 ++
>>  drivers/acpi/acpi_pad.c       |  4 +++
>>  drivers/acpi/acpi_processor.c | 18 +++--------
>>  drivers/acpi/battery.c        | 63 ++++++++++++++++++++------------------
>>  drivers/acpi/button.c         |  9 ++----
>>  drivers/acpi/cppc_acpi.c      | 71 ++++++++++++++++++++++---------------------
>>  drivers/acpi/custom_method.c  |  2 +-
>>  drivers/acpi/device_pm.c      |  3 ++
>>  drivers/acpi/device_sysfs.c   | 15 ++++++---
>>  drivers/acpi/dock.c           |  7 +++--
>>  12 files changed, 106 insertions(+), 97 deletions(-)
>>
>> --
>
> Can you please stop sending new versions of this for a while?
>

OK.


> You've sent three of them over the last weekend and honestly I haven't
> had a chance to look at the first one even.


I tried to fix a low-level mistake as quickly as possible. I'm sorry for 
that



> _______________________________________________
> Linuxarm mailing list -- linuxarm@openeuler.org
> To unsubscribe send an email to linuxarm-leave@openeuler.org
>

