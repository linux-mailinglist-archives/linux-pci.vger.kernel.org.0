Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812DB1EB32A
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 03:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbgFBB5Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jun 2020 21:57:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5836 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725801AbgFBB5P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Jun 2020 21:57:15 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 065C0E1A63503520C19F;
        Tue,  2 Jun 2020 09:57:13 +0800 (CST)
Received: from [10.65.58.147] (10.65.58.147) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Tue, 2 Jun 2020
 09:57:05 +0800
Subject: Re: [PATCH] PCI/ASPM: Print correct ASPM status when _OSC failed
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sinan Kaya <okaya@kernel.org>
References: <1590655125-23949-1-git-send-email-yangyicong@hisilicon.com>
 <CAJZ5v0g9O5r7tpLMN7SJu+KZEeEcdeTKeQ=hEo5r+VJzc6g08Q@mail.gmail.com>
 <6f6aa87f-7c4d-61f6-f8c2-42ad05b5c845@kernel.org>
 <1908398.Rfmu1g3mcC@kreacher>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <60d31995-1511-4d82-b026-e7119d88a891@hisilicon.com>
Date:   Tue, 2 Jun 2020 09:57:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <1908398.Rfmu1g3mcC@kreacher>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/6/1 23:22, Rafael J. Wysocki wrote:
> On Monday, June 1, 2020 5:14:45 PM CEST Sinan Kaya wrote:
>> On 5/28/2020 7:42 AM, Rafael J. Wysocki wrote:
>>>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>>>> index ac8ad6c..5140b26 100644
>>>> --- a/drivers/acpi/pci_root.c
>>>> +++ b/drivers/acpi/pci_root.c
>>>> @@ -456,7 +456,7 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>>>>
>>>>                 dev_info(&device->dev, "_OSC failed (%s)%s\n",
>>>>                          acpi_format_exception(status),
>>>> -                        pcie_aspm_support_enabled() ? "; disabling ASPM" : "");
>>>> +                        pcie_aspm_support_enabled() ? "" : "; disabling ASPM");
>>>>                 return;
>>>>         }
>>>>
>>>> --
>>> Applied as 5.8 material under the "ACPI: PCI: Fix the ASPM part of the
>>> _OSC failure message" subject and with a different changelog.
>>
>> I'm confused. The original change would print ASPM is getting disabled
>> only when ASPM is supported. Now, we are printing disabling ASPM when
>> ASPM is not supported.
>>
>> Now, we reverted the change and went back to incorrect behavior again.
>>
>> Am I missing something?
> Well, it turns out that I was confused, as well as the author of the patch.
>
> Dropped now, thanks for the heads-up!

well, Sinan's words make sense to me. But I'm still confused that, the message
says we're "disabling ASPM" but ASPM maybe enabled if we designate
pcie_aspm=force as I mentioned in the commit message. Will it be possible if
we replace "disabling" to "disabled" or we can do something else to make
the message reflect the real status of ASPM?

Thanks,
Yicong


>
>
>
> .
>

