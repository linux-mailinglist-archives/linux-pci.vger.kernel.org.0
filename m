Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA84114DE2
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2019 10:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbfLFJAY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Dec 2019 04:00:24 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:34036 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfLFJAY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Dec 2019 04:00:24 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB6909uV013502;
        Fri, 6 Dec 2019 03:00:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575622809;
        bh=uaXzZSsyNHO08tIpDkwGwrPMYqYLJBO4Gfc7A2K13E8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=FMFmLosuuKCZW7AkF/X81qsrzdSuoDgsdXMsFUJvHqsyR+1VnlWmM7j5QT4OOjdp2
         dzcJxHcO3S8QSl3MrPUvOEmpt8AtPnO4FnvWZWCI3BrJLrsCWPE6J8GJOVpxjLv9Ck
         Bji9mz06imCSMz2qHvoTQDvRPBfp6JiZt4dZyJJ0=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB6909YR100000;
        Fri, 6 Dec 2019 03:00:09 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 6 Dec
 2019 03:00:09 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 6 Dec 2019 03:00:09 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB6906vX023816;
        Fri, 6 Dec 2019 03:00:07 -0600
Subject: Re: [PATCH 2/2] PCI: uniphier: Add checking whether PERST# is
 deasserted
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
References: <20191204190547.333C.4A936039@socionext.com>
 <c40da2f3-ea5d-b1fc-0190-f90f031eef4c@ti.com>
 <20191206175813.E6B2.4A936039@socionext.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <6b288f46-452d-6f92-728c-56c4100028cf@ti.com>
Date:   Fri, 6 Dec 2019 14:31:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191206175813.E6B2.4A936039@socionext.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 06/12/19 2:28 pm, Kunihiko Hayashi wrote:
> Hi Kishon,
> 
> On Fri, 6 Dec 2019 12:28:29 +0530 <kishon@ti.com> wrote:
> 
>> Hi,
>>
>> On 04/12/19 3:35 pm, Kunihiko Hayashi wrote:
>>> On Fri, 22 Nov 2019 20:53:16 +0900 <hayashi.kunihiko@socionext.com> wrote:
>>>>> Hello Lorenzo,
>>>>
>>>> On Thu, 21 Nov 2019 16:47:05 +0000 <lorenzo.pieralisi@arm.com> wrote:
>>>>
>>>>> On Fri, Nov 08, 2019 at 04:30:27PM +0900, Kunihiko Hayashi wrote:
>>>>>>> However, If I understand correctly, doesn't your solution only work some
>>>>>>> of the time? What happens if you boot both machines at the same time,
>>>>>>> and PERST# isn't asserted prior to the kernel booting?
>>>>>>
>>>>>> I think it contains an annoying problem.
>>>>>>
>>>>>> If PERST# isn't toggled prior to the kernel booting, PERST# remains asserted
>>>>>> and the RC driver can't access PCI bus.
>>>>>>
>>>>>> As a result, this patch works and deasserts PERST# (and EP configuration will
>>>>>> be lost). So boot sequence needs to include deasserting PERST#.
>>>>>
>>>>> I am sorry but I have lost you. Can you explain to us why checking
>>>>> that PERST# is deasserted guarantees you that:
>>>>>
>>>>> - The EP has bootstrapped
>>>>> - It is safe not to toggle it again (and also skip
>>>>>     uniphier_pcie_ltssm_enable())
>>>>>
>>>>> Please provide details of the HW configuration so that we understand
>>>>> what's actually supposed to happen and why this patch fixes the
>>>>> issue you are facing.
>>>>
>>>> I tried to connect between the following boards, and do pci-epf-test:
>>>>    - "RC board": UniPhier ld20 board that has DWC RC controller
>>>>    - "EP board": UniPhier legacy board that has DWC EP controller
>>>>
>>>> This EP has power-on-state configuration, but it's necessary to set
>>>> class ID, BAR sizes, etc. after starting up.
>>>>
>>>> In case of that starting up RC board before EP board, the RC driver
>>>> can't establish link. So we need to boot EP board first.
>>>> At that point, I've considered why RC can't establish link,
>>> and found that the waitng time was too short.
>>>> - EP/RC: power on both boards
>>>> - RC: start up the kernel on RC board
>>>> - RC: wait for link up (long time enough)
>>>> - EP: start up the kernel on EP board
>>>> - EP: configurate pci-epf-test
>>>> When the endpoint  configuration is done and the EP driver enables LTSSM,
>>> the RC driver will quit from waiting for link up.
>>>> Currently DWC RC driver calls dwc_pcie_wait_for_link(), however,
>>> the function tries to link up 10 times only, that is defined
>>> as LINK_WAIT_MAX_RETRIES in pcie-designware.h, it's too short
>>> to configurate the endpoint.
>>>> Now the patch to bypass PERST# is not necessary.
>>>> Instead for DWC RC drivers, I think that the number of retries
>>> should be changed according to the usage.
>>> And the same issue remains with other RC drivers.
>>
>> If EP is configured using Linux, then PERST# cannot be used as it's difficult to boot linux and initialize EP within the specified time interval. Can't you prevent PERST from being propagated at all?
> 
> Surely it might be difficult for RC to decide the time to wait for EP.
> Since RC almost toggles PERST# in boot time, I'd like to think about
> how to prevent from first PERST# at least.

It can be prevented in the HW (If that's possible). I modify the cable 
connecting RC and EP to not propagate PERST#.

Thanks
Kishon
