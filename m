Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105D51EA69E
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jun 2020 17:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgFAPOr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jun 2020 11:14:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbgFAPOp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Jun 2020 11:14:45 -0400
Received: from [192.168.68.109] (75-58-59-55.lightspeed.rlghnc.sbcglobal.net [75.58.59.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2C6C20738;
        Mon,  1 Jun 2020 15:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591024484;
        bh=ZEZ0ym3z4cWoMapFRnQouGecwlLb2uuHkk+kjlht0Hw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=1hNev6fGAYWR6isNkuT0U/MxEWQrCo5H/X4v3prURxwDjd/BzFOuz8JvPEYAKUuNr
         MR68fEzOMUtv1i2OQuaKzQRXmZqptwqw2IKTyeSlOe+0Yytfi5OslASZQrJvD+abSc
         ypbM3zqG9ouCEXHsKagy1mbuHT2nb23We8ibQQhs=
Subject: Re: [PATCH] PCI/ASPM: Print correct ASPM status when _OSC failed
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
References: <1590655125-23949-1-git-send-email-yangyicong@hisilicon.com>
 <CAJZ5v0g9O5r7tpLMN7SJu+KZEeEcdeTKeQ=hEo5r+VJzc6g08Q@mail.gmail.com>
From:   Sinan Kaya <okaya@kernel.org>
Autocrypt: addr=okaya@kernel.org; keydata=
 mQENBFrnOrUBCADGOL0kF21B6ogpOkuYvz6bUjO7NU99PKhXx1MfK/AzK+SFgxJF7dMluoF6
 uT47bU7zb7HqACH6itTgSSiJeSoq86jYoq5s4JOyaj0/18Hf3/YBah7AOuwk6LtV3EftQIhw
 9vXqCnBwP/nID6PQ685zl3vH68yzF6FVNwbDagxUz/gMiQh7scHvVCjiqkJ+qu/36JgtTYYw
 8lGWRcto6gr0eTF8Wd8f81wspmUHGsFdN/xPsZPKMw6/on9oOj3AidcR3P9EdLY4qQyjvcNC
 V9cL9b5I/Ud9ghPwW4QkM7uhYqQDyh3SwgEFudc+/RsDuxjVlg9CFnGhS0nPXR89SaQZABEB
 AAG0HVNpbmFuIEtheWEgPG9rYXlhQGtlcm5lbC5vcmc+iQFOBBMBCAA4FiEEYdOlMSE+a7/c
 ckrQvGF4I+4LAFcFAlztcAoCGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQvGF4I+4L
 AFfidAf/VKHInxep0Z96iYkIq42432HTZUrxNzG9IWk4HN7c3vTJKv2W+b9pgvBF1SmkyQSy
 8SJ3Zd98CO6FOHA1FigFyZahVsme+T0GsS3/OF1kjrtMktoREr8t0rK0yKpCTYVdlkHadxmR
 Qs5xLzW1RqKlrNigKHI2yhgpMwrpzS+67F1biT41227sqFzW9urEl/jqGJXaB6GV+SRKSHN+
 ubWXgE1NkmfAMeyJPKojNT7ReL6eh3BNB/Xh1vQJew+AE50EP7o36UXghoUktnx6cTkge0ZS
 qgxuhN33cCOU36pWQhPqVSlLTZQJVxuCmlaHbYWvye7bBOhmiuNKhOzb3FcgT7kBDQRa5zq1
 AQgAyRq/7JZKOyB8wRx6fHE0nb31P75kCnL3oE+smKW/sOcIQDV3C7mZKLf472MWB1xdr4Tm
 eXeL/wT0QHapLn5M5wWghC80YvjjdolHnlq9QlYVtvl1ocAC28y43tKJfklhHiwMNDJfdZbw
 9lQ2h+7nccFWASNUu9cqZOABLvJcgLnfdDpnSzOye09VVlKr3NHgRyRZa7me/oFJCxrJlKAl
 2hllRLt0yV08o7i14+qmvxI2EKLX9zJfJ2rGWLTVe3EJBnCsQPDzAUVYSnTtqELu2AGzvDiM
 gatRaosnzhvvEK+kCuXuCuZlRWP7pWSHqFFuYq596RRG5hNGLbmVFZrCxQARAQABiQEfBBgB
 CAAJBQJa5zq1AhsMAAoJELxheCPuCwBX2UYH/2kkMC4mImvoClrmcMsNGijcZHdDlz8NFfCI
 gSb3NHkarnA7uAg8KJuaHUwBMk3kBhv2BGPLcmAknzBIehbZ284W7u3DT9o1Y5g+LDyx8RIi
 e7pnMcC+bE2IJExCVf2p3PB1tDBBdLEYJoyFz/XpdDjZ8aVls/pIyrq+mqo5LuuhWfZzPPec
 9EiM2eXpJw+Rz+vKjSt1YIhg46YbdZrDM2FGrt9ve3YaM5H0lzJgq/JQPKFdbd5MB0X37Qc+
 2m/A9u9SFnOovA42DgXUyC2cSbIJdPWOK9PnzfXqF3sX9Aol2eLUmQuLpThJtq5EHu6FzJ7Y
 L+s0nPaNMKwv/Xhhm6Y=
Message-ID: <6f6aa87f-7c4d-61f6-f8c2-42ad05b5c845@kernel.org>
Date:   Mon, 1 Jun 2020 11:14:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0g9O5r7tpLMN7SJu+KZEeEcdeTKeQ=hEo5r+VJzc6g08Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/28/2020 7:42 AM, Rafael J. Wysocki wrote:
>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>> index ac8ad6c..5140b26 100644
>> --- a/drivers/acpi/pci_root.c
>> +++ b/drivers/acpi/pci_root.c
>> @@ -456,7 +456,7 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>>
>>                 dev_info(&device->dev, "_OSC failed (%s)%s\n",
>>                          acpi_format_exception(status),
>> -                        pcie_aspm_support_enabled() ? "; disabling ASPM" : "");
>> +                        pcie_aspm_support_enabled() ? "" : "; disabling ASPM");
>>                 return;
>>         }
>>
>> --
> Applied as 5.8 material under the "ACPI: PCI: Fix the ASPM part of the
> _OSC failure message" subject and with a different changelog.


I'm confused. The original change would print ASPM is getting disabled
only when ASPM is supported. Now, we are printing disabling ASPM when
ASPM is not supported.

Now, we reverted the change and went back to incorrect behavior again.

Am I missing something?
