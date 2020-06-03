Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25421ED0A0
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jun 2020 15:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgFCNTy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jun 2020 09:19:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47438 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725780AbgFCNTy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jun 2020 09:19:54 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3D677AE57E255F573E1A;
        Wed,  3 Jun 2020 21:19:52 +0800 (CST)
Received: from [10.65.58.147] (10.65.58.147) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Wed, 3 Jun 2020
 21:19:44 +0800
Subject: Re: [PATCH v2] ACPI: PCI: Remove ASPM text from _OSC failure message
To:     "Rafael J. Wysocki" <rafael@kernel.org>
References: <20200602223618.GA845676@bjorn-Precision-5520>
 <B2282A82-EEA4-40F8-B7F5-1D7AE7E3B573@intel.com>
 <faaf2c47-6039-74fb-e5d2-91a5b3705459@kernel.org>
 <03d2a6ca-78de-2d39-5428-2949c2017099@hisilicon.com>
 <CAJZ5v0hxwcbembJGDRdf_nBRaTzcO73L1YJ2TT3BYxaihV6orA@mail.gmail.com>
CC:     Sinan Kaya <okaya@kernel.org>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <0e531765-0398-001f-c157-bab459f4aa94@hisilicon.com>
Date:   Wed, 3 Jun 2020 21:19:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hxwcbembJGDRdf_nBRaTzcO73L1YJ2TT3BYxaihV6orA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/6/3 21:02, Rafael J. Wysocki wrote:
> On Wed, Jun 3, 2020 at 2:15 PM Yicong Yang <yangyicong@hisilicon.com> wrote:
>> Previously the _OSC failed message is rather confusing, as if we
>> forcibly enable ASPM by set pcie_aspm=force, we'll get the message
>> below, which doesn't the reflect the real status.
>>
>>   acpi PNP0A08:02: _OSC failed (AE_NOT_FOUND); disabling ASPM
>>
>> Reword the _OSC failure message and remove the ASPM text to make
>> it clear. As if _OSC failed we're not supposed to take over any
>> PCIe features including ASPM. After the Patch it'll look like:
>>
>>   acpi PNP0A08:02: _OSC: platform retains control of PCIe features (AE_NOT_FOUND)
>>
>> No functional change intended.
>>
>> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> Reviewed-by: Sinan Kaya <okaya@kernel.org>
> This is a Bjorn's patch to which you have added a changelog and posted
> as yours.  It is not OK to do things like that.

Please ignore this Patch !

Sorry for my mistake and thanks for pointing it out.

>
>> ---
>>  drivers/acpi/pci_root.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>> index ac8ad6c..8dd7f14 100644
>> --- a/drivers/acpi/pci_root.c
>> +++ b/drivers/acpi/pci_root.c
>> @@ -454,9 +454,8 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>>   if ((status == AE_NOT_FOUND) && !is_pcie)
>>   return;
>>
>> - dev_info(&device->dev, "_OSC failed (%s)%s\n",
>> - acpi_format_exception(status),
>> - pcie_aspm_support_enabled() ? "; disabling ASPM" : "");
>> + dev_info(&device->dev, "_OSC: platform retains control of PCIe features (%s)\n",
>> + acpi_format_exception(status));
>>   return;
>>   }
>>
>> @@ -517,7 +516,7 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>>   } else {
>>   decode_osc_control(root, "OS requested", requested);
>>   decode_osc_control(root, "platform willing to grant", control);
>> - dev_info(&device->dev, "_OSC failed (%s); disabling ASPM\n",
>> + dev_info(&device->dev, "_OSC: platform retains control of PCIe features (%s)\n",
>>   acpi_format_exception(status));
>>
>>   /*
>> --
>> 2.8.1
>>
>> .
>>
> .
>

